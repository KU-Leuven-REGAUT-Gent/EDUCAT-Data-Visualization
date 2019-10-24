
classdef measurement 
    properties
        id, ...
            start_time, ...
            end_time, ...
            max_cycleCount, ...
            setup_id, ...
            n_instruments, ...
            description, ...
            instruments, ...
            list
    end
    properties (Hidden)
        conn
    end
    methods
        %% Create object measurement and get a connection with DB
        
        function obj = measurement(user, pswd)
            % No database object necessary
            % Install https://dev.mysql.com/downloads/windows/installer/8.0.html
            javaaddpath(".\mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar");
            databaseName = "educat";
            username = user;
            password = pswd;
            jdbcDriver = "com.mysql.cj.jdbc.Driver";
            server = "jdbc:mysql://clouddb.myriade.be:20100/";
            obj.conn = database(databaseName, username, password, jdbcDriver, server);
            
            
            % get list
            sqlquery = ['SELECT `STP_measurements`.`id`, ' ...
                '      `STP_measurements`.`description`, ' ...
                '      `STP_measurements`.`start_time`, ' ...
                '      `STP_measurements`.`end_time`, ' ...
                '      COUNT(`STP_measurement_dataset`.`cyclecounter`) AS `count`,  ' ...
                '      MAX(`STP_measurement_dataset`.`cyclecounter`) AS `max` ' ...
                'FROM `STP_measurements` ' ...
                'LEFT JOIN `STP_measurement_dataset` ' ...
                'ON `STP_measurements`.`id` = `STP_measurement_dataset`.`measurement_id` ' ...
                'GROUP BY `STP_measurements`.`id` ' ...
                'ORDER BY `id` DESC;'];
            obj.list = select( obj.conn,sqlquery);
            % start time
            ms = uint64(obj.list.start_time);
            wholeSecs = floor(double(ms)/1e3);
            fracSecs = double(ms - uint64(wholeSecs)*1e3)/1e3;
            obj.list.start_time = datetime(wholeSecs, 'convertfrom','posixtime','Format','dd-MM-yyyy HH:mm:ss.SSS')+ seconds(fracSecs);
           
            % end time 
            ms = uint64(obj.list.end_time);
            wholeSecs = floor(double(ms)/1e3);
            fracSecs = double(ms - uint64(wholeSecs)*1e3)/1e3;
            obj.list.end_time = datetime(wholeSecs, 'convertfrom','posixtime','Format','dd-MM-yyyy HH:mm:ss.SSS')+ seconds(fracSecs);
            
        end
        
        function obj = set_measurement_ID(obj,measurement_id)
            obj.id = measurement_id;
        end
        %%  *************** declaration of instruments *******************
        
        function obj = declaration(obj)
            sqlquery = ['SELECT `STP_measurements`.`id`, ' ...
                '       `STP_measurements`.`setup_user_id`, ' ...
                '       `STP_measurements`.`start_time`, ' ...
                '       `STP_measurements`.`end_time`, ' ...
                '       `STP_measurements`.`description`, ' ...
                '       `STP_setups_users`.`setup_id` ' ...
                'FROM `STP_measurements` ' ...
                'INNER JOIN `STP_setups_users` ' ...
                'ON `STP_measurements`.`setup_user_id` = `STP_setups_users`.`id` ' ...
                'WHERE `STP_measurements`.`id` = ' int2str(obj.id) ';'];
            measurement_info = select(obj.conn, sqlquery);
            
            obj.id = measurement_info.id;
            obj.start_time = double(measurement_info.start_time)/1000;
            obj.end_time = double(measurement_info.end_time)/1000;
            obj.setup_id = measurement_info.setup_id;
            obj.description = measurement_info.description;
            
            % Selecting setup
            sqlquery = ['SELECT `STP_instrument_type_parameter_values`.`value`,' ...
                '       `STP_instruments`.`id`,' ...
                '       `STP_instruments`.`name`,' ...
                '       `STP_instruments`.`description`' ...
                'FROM `STP_instrument_type_parameter_values` ' ...
                'INNER JOIN `STP_instruments` ' ...
                ' ON `STP_instruments`.`instrument_type_id` = `STP_instrument_type_parameter_values`.`instrument_type_id` ' ...
                'INNER JOIN `STP_setups_instruments` ' ...
                ' ON `STP_setups_instruments`.`instrument_id` = `STP_instruments`.`id` ' ...
                'INNER JOIN `STP_setups` ' ...
                ' ON `STP_setups`.`id` = `STP_setups_instruments`.`setup_id` ' ...
                'WHERE `STP_instrument_type_parameter_values`.`parameter_id` = 33 ' ...
                ' AND `STP_setups`.`id` = ' int2str(obj.setup_id) ' ' ...
                'ORDER BY `STP_instruments`.`id` ASC;'];
            datatype_list = select(obj.conn,sqlquery);
            
            sqlquery = ['SELECT MAX(`STP_measurement_dataset`.`cyclecounter`) AS `max` ' ...
                'FROM `STP_measurement_dataset` ' ...
                'WHERE `STP_measurement_dataset`.`measurement_id` = ' int2str(obj.id) ';'];
            maxCycleCount = select(obj.conn,sqlquery);
            obj.max_cycleCount = maxCycleCount.max;
            
            obj.n_instruments = size(datatype_list,1);
            obj.instruments = classes.instrument.empty(0,obj.n_instruments);
            for i = 1:obj.n_instruments
                obj.instruments(i) = classes.instrument(datatype_list.id(i),datatype_list.name{i},datatype_list.description{i},datatype_list.value(i),obj.max_cycleCount);
            end
        end
        
        %% *********************** Get data ***************************
        
        function obj = get_dataset_DB(obj)
            sqlquery = ['SELECT `STP_measurement_dataset`.`id`, ' ...
                '       `STP_measurement_dataset`.`cyclecounter`, ' ...
                '       `STP_measurement_dataset`.`state`, ' ...
                '       `STP_measurement_data`.`data` ' ...
                'FROM `STP_measurement_dataset` '  ...
                'INNER JOIN `STP_measurement_data` ' ...
                ' ON `STP_measurement_dataset`.`id` = `STP_measurement_data`.`dataset_id` ' ...
                'WHERE `STP_measurement_dataset`.`measurement_id` = ' int2str(obj.id) ' ' ...
                ' AND `STP_measurement_dataset`.`cyclecounter` <= ' int2str(obj.max_cycleCount) ';'];
            dataset_list = select(obj.conn,sqlquery);
            
            len = size(dataset_list,1);
            for i = 1:len
                obj = obj.add_dataset(dataset_list.cyclecounter(i), dataset_list.data{i});
            end
        end
        

        %% *************** Add dataset to instrument *******************
        function obj = add_dataset(obj, cyclecounter, blob)
            offset = 1;
            for i = 1:obj.n_instruments
                new_offset = offset + obj.instruments(i).length;
                obj.instruments(i) = obj.instruments(i).add_data(cyclecounter, blob(offset:new_offset));
                if blob(new_offset) ~= -128
                    error("No 0x80 at the end");
                end
                offset = new_offset+1;
            end
        end
        %% *************** plot all instrument *******************
        
        function obj = plot_all(obj)
            for i = 1:obj.n_instruments
                obj.instruments(i).plot_all(obj.id,obj.start_time);
            end
        end
   

               %% *********************** export data ***********************
        function  exportData(obj)
            for i=obj.instruments
                nameCell = strcat(i.name, num2str(i.id));
                for j= 1 :size(i.data,2)
                    nameSensor= strcat( nameCell, '.',char(i.data(j).name));
                    genName = matlab.lang.makeValidName(nameSensor);
                    eval([genName '= i.data(' num2str(j) ').values ;']);
                    assignin('base',genName,i.data(j).values);
                end
                
            end
            time = (1:size(obj.instruments(1).data(1).values,2))*0.020 + obj.start_time;
            wholeSecs = floor(double(time));
            fracSecs = time - wholeSecs;
            time =  datetime(wholeSecs, 'convertfrom','posixtime','Format','dd-MM-yyyy HH:mm:ss.SSS')+ seconds(fracSecs);
            assignin('base',"time", time);
            cycleCount = 1:1:size(obj.instruments(1).data(1).values,2);
            assignin('base',"cycleCount", cycleCount);
        end
        
        
        
        %% *********************** SD card data ***********************
        function obj = get_measurement_fromSD(obj)
            % in progress
            %obj.id =
        end
        
        function obj = get_dataset_SD(obj)
            % in progress
            %....
            len = size(dataset_list,1);
            for i = 1:len
                obj = obj.add_dataset(dataset_list.cyclecounter(i), dataset_list.data{i});
            end
        end
        
    end
end
