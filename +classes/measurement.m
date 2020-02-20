
classdef measurement 
    properties
        id, ...
            start_time, ...
            end_time, ...
            start_cycleCount,...
            end_cycleCount,...
            max_cycleCount, ...
            setup_id, ...
            n_instruments, ...
            description, ...
            instruments, ...
            list
    end
    properties (Hidden)
        conn,...
        dataset_list,...
        enableStoreMemory,...
        memoryDeclaration,...
        memoryInstrument,...
        memoryProcess
    end
    methods
        %% Create object measurement and get a connection with DB
        
        function obj = measurement()
            % OBJECT CREATION
            % enable the storage of the memory usage 
            obj.enableStoreMemory = false;
        end
        
        function obj = connect(obj)
            % No database object necessary
            % Install https://dev.mysql.com/downloads/file/?id=490495
            if isfile("jdbc/mysql-connector-java-8.0.18.jar")
                javaaddpath("jdbc/mysql-connector-java-8.0.18.jar");
            elseif isfile("mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar")
                % legacy jdbc location
                javaaddpath("mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar");
            else
                if ~exist('jdbc', 'dir')
                    mkdir('jdbc')                    
                end
                error("JDBC MySQL Connector not found, please download the connector from https://dev.mysql.com/downloads/connector/j/ and extract it in the 'jdbc' directory. Note: the mysql-connector-java-8.0.18.jar musn't be place in a subdirectory, but directly in the root of the jdbc directory.");
                
            end
              
            databaseName = "educat";
            username = "analyst";
            disp([' EDUCAT DB username: ' char(username)]);
            if isfile("password.mat")
                load password.mat password;
            end
            if ~exist('password','var')
                password = input(' EDUCAT DB password: ','s');
                store_password = input(' store this password (Y/N): ','s');
                if store_password == "Y" || store_password == "y" || store_password == "yes"
                    save password.mat password;
                    warning off backtrace;                    
                    warning("Password saved to 'password.mat' file");
                    warning on backtrace;
                end
            else
                disp(' EDUCAT DB password (retrieved from file)');
            end
            
            jdbcDriver = "com.mysql.cj.jdbc.Driver";
            server = "jdbc:mysql://clouddb.myriade.be:20100/";
            
            % TODO: Check for valid connection
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
        
        function obj = declaration(obj,date,duration)
           
           
           sqlquery = ['SELECT MAX(`STP_measurement_dataset`.`cyclecounter`) AS `max` ' ...
                'FROM `STP_measurement_dataset` ' ...
                'WHERE `STP_measurement_dataset`.`measurement_id` = ' int2str(obj.id) ';'];
            maxCycleCount = select(obj.conn,sqlquery);
            obj.max_cycleCount = maxCycleCount.max;            
            
            
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
          
            obj.setup_id = measurement_info.setup_id;
            obj.description = measurement_info.description;
            
%             regexDate = '^(0[1-9]|[1-2][0-9]|3[0-1])[-/](0[1-9]|1[0-2])[-/]([0-9]{4})( ([0-1][0-9]|2[0-3])[:h]([0-5][0-9])(?:[:m](?:([0-5][0-9])(?:[.,]([0-9]{1,3})|s?)?)?)?)?$';
%             regexTime ='^ ([0-1][0-9]|2[0-3])[:h]([0-5][0-9])(?:[:m](?:([0-5][0-9])(?:[.,]([0-9]{1,3})|s?)?)?)?$';
%             dateCapture = regexp(date,regexDate, 'tokens');
%             if size(dateCapture{1}{4},2)=4
%             timeCapture = regexp(dateCapture{1}{4},regexTime, 'tokens');
%             end
            
            if contains(date,'full')
                obj.start_time = datetime(measurement_info.start_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss.SSS');
                obj.end_time = datetime(measurement_info.end_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss.SSS');
                pulled_cycleCounts = obj.max_cycleCount;
                obj.end_cycleCount = obj.max_cycleCount;
                obj.start_cycleCount = 0;
            else 
                % Set start time and start and end cyclecount
                if contains(date,'.')
                 obj.start_time = datetime(date,'InputFormat','dd-MM-yyyy HH:mm:ss.SSS', 'Format', 'dd-MM-yyyy HH:mm:ss.SSS');
                elseif contains(date,':')
                    obj.start_time = datetime(date,'InputFormat','dd-MM-yyyy HH:mm:ss', 'Format', 'dd-MM-yyyy HH:mm:ss.SSS');
                elseif contains(date,'/')
                    startMeasurement = datetime(measurement_info.start_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss.SSS');
                    if contains(date,datestr(startMeasurement))
                      obj.start_time = startMeasurement;
                    else % start time will be midnight
                      obj.start_time = datetime(date,'InputFormat','dd/MM/yyyy', 'Format', 'dd-MM-yyyy HH:mm:ss.SSS');
                    end
                elseif  contains(date,'-')
                   startMeasurement = datetime(measurement_info.start_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss.SSS');
                    if contains(date,datestr(startMeasurement,'dd-mm-yyyy'))
                      obj.start_time = startMeasurement;
                    else % start time will be midnight
                      obj.start_time = datetime(date,'InputFormat','dd-MM-yyyy', 'Format', 'dd-MM-yyyy HH:mm:ss.SSS');
                    end
                else
                    error("wrong input format of the date choose one of the following notations: 'dd-MM-yyyy', 'dd/MM/yyyy', 'dd-MM-yyyy HH:mm:ss''dd-MM-yyyy HH:mm:ss.SSS',  ");
                end
                
                dateNr = posixtime(obj.start_time);     
                % set cycle counters
                obj.start_cycleCount = ceil(double(int64(dateNr*1000) - measurement_info.start_time)/1000/0.02+1);
                if obj.start_cycleCount < 0         
                     error("out of range");
                end
                obj.end_cycleCount = floor(double(int64(dateNr*1000) + (duration*60*60*1000) - measurement_info.start_time)/1000/0.02+1); 
                
                pulled_cycleCounts =  obj.end_cycleCount-obj.start_cycleCount+1;
                obj.end_time = obj.start_time + seconds(pulled_cycleCounts*0.02);
            end  
                
           
            
            
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
            
            
            
            obj.n_instruments = size(datatype_list,1);
            obj.instruments = classes.instrument.empty(0,obj.n_instruments);
            for i = 1:obj.n_instruments
                obj.instruments(i) = classes.instrument(datatype_list.id(i),datatype_list.name{i},datatype_list.description{i},datatype_list.value(i), pulled_cycleCounts);
                % RAM memory usage
                if obj.enableStoreMemory 
                    [user,sys] = memory;
                    obj.memoryDeclaration(i)= user.MemUsedMATLAB;
                end
            end
        end
        
        function obj= getMeasurementInfo (obj)
        
        end
        %% *********************** Get data ***************************
        
        function obj = get_dataset_DB(obj)
            Limit = 5000;
            if Limit > (obj.end_cycleCount-obj.start_cycleCount)
            Limit = obj.end_cycleCount-obj.start_cycleCount+1;
            end
            for i=obj.start_cycleCount:Limit:obj.end_cycleCount
                endLimit = i+Limit ;
                if i+Limit > obj.end_cycleCount-1
                    endLimit= obj.end_cycleCount+1;
                end
                sqlquery = ['SELECT `STP_measurement_dataset`.`id`, ' ...
                    '       `STP_measurement_dataset`.`cyclecounter`, ' ...
                    '       `STP_measurement_dataset`.`state`, ' ...
                    '       `STP_measurement_data`.`data` ' ...
                    'FROM `STP_measurement_dataset` '  ...
                    'INNER JOIN `STP_measurement_data` ' ...
                    ' ON `STP_measurement_dataset`.`id` = `STP_measurement_data`.`dataset_id` ' ...
                    'WHERE `STP_measurement_dataset`.`measurement_id` = ' int2str(obj.id) ' ' ...
                    ' AND `STP_measurement_dataset`.`cyclecounter` < ' int2str(endLimit) ' '...
                    ' AND `STP_measurement_dataset`.`cyclecounter` >= ' int2str(i) ';'];

                obj.dataset_list = [obj.dataset_list;select(obj.conn,sqlquery)];
            end
        end
        %% processing 
        function obj = processData_DB(obj)
            len = size(obj.dataset_list,1);
            for i = len:-1:1
                obj = obj.add_dataset(int64(obj.dataset_list.cyclecounter(i))-obj.start_cycleCount+1, obj.dataset_list.data{i});
                % RAM memory usage
                if mod(i,1000)==0 && obj.enableStoreMemory 
                    [user,sys] = memory;
                    obj.memoryProcess(i/1000)= user.MemUsedMATLAB;
                end 
            end
           %obj.dataset_list = [];
        end
        
        function obj = processDayData_DB(obj)
            len = size(obj.dataset_list,1);
            for i = len:-1:1
                obj = obj.add_dataset(obj.dataset_list.cyclecounter(i), obj.dataset_list.data{i});
                % RAM memory usage
                if mod(i,1000)==0 && obj.enableStoreMemory 
                    [user,sys] = memory;
                    obj.memoryProcess(i/1000)= user.MemUsedMATLAB;
                end 
            end
           obj.dataset_list = [];
        end

        %% *************** Add dataset to instrument *******************
        function obj = add_dataset(obj, cyclecounter, blob)
            offset = 1;
            
            for i = 1:obj.n_instruments
                new_offset = offset + obj.instruments(i).length;
                obj.instruments(i) = obj.instruments(i).add_data(cyclecounter, blob(offset:new_offset));
                % RAM memory usage
                if mod(cyclecounter,1000)==0 && obj.enableStoreMemory 
                    [user,sys] = memory;
                    obj.memoryInstrument(cyclecounter/1000,i) =  user.MemUsedMATLAB;
                end 
                
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
