classdef measurement
    
    % measurement summary
    % This class creates an object for a measurement.
    % The following data is stored in this object:
    %   -  id
    %   - start_time
    %   - end_time
    %   - start_cycleCount
    %   - end_cycleCount
    %   - max_cycleCount
    %   - setup_id
    %   - n_instruments
    %   - description
    %   - instruments
    %
    %The instruments variable contains all the instrument objects that are
    %declared in the setup. 
    %
    %Method summary:
    %*  connect                 -   Start a connection with the EDUCAT database on the Myriade server
 	%*  declaration             -	gets the maximum cycle count, measurements info and the list of sensors.
 	%*  extractionData              -   Each sensor data will be exported to the workspace. 
 	%*  get_dataset_DB          -   Get the dataset from the 'STP_measurement_dataset table'. 
 	%*  get_dataset_SD          -	in progress 
 	%*  get_measurement_fromSD  -   in progress 
 	%*  plot_all                -	All the instruments will be plotted 
 	%*  processData_DB          -   The declared instruments will be filled with the sensor data. 
 	%*  set_measurement_ID      -   set measurement id 
    
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
        
        function obj = connect(obj,sort)
        % Start a connection with the EDUCAT database on the Myriade
        % server. 
        %
        %The password will be asked the first time you execute the
        %function. After the input you have the option to store this
        %password on your pc. if you have chosen to save the password, it
        %will start the connection immediately without asking for the
        %password.
            
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
                error("JDBC MySQL Connector not found, please download the connector from https://dev.mysql.com/downloads/connector/j/ and extract it in the 'jdbc' directory. Note: the mysql-connector-java-8.0.18.jar musn't be placed in a subdirectory, but directly in the root of the jdbc directory.");
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
                        '      TRIM(`STP_setups`.`name`) AS `setup`, ' ...
                        '      TRIM(`USR_users`.`name`) AS `user`, ' ...
                        '      Count(`STP_measurement_dataset`.`cyclecounter`) AS `count`,  ' ...
                        '      MAX(`STP_measurement_dataset`.`cyclecounter`) AS `max` ' ...
                        'FROM `STP_measurement_dataset` ' ...
                        'LEFT JOIN `STP_measurements` ' ...
                        'ON `STP_measurement_dataset`.`measurement_id` = `STP_measurements`.`id` ' ...
                        'LEFT JOIN `STP_setups_users` ' ...
                        'ON `STP_measurements`.`setup_user_id` = `STP_setups_users`.`id` ' ...
                        'LEFT JOIN `USR_users` ' ...
                        'ON `STP_setups_users`.`user_id` = `USR_users`.`id` ' ...
                        'LEFT JOIN `STP_setups` ' ...
                        'ON `STP_setups_users`.`setup_id` = `STP_setups`.`id` ' ...
                        'WHERE `STP_measurement_dataset`.`measurement_id` >= 0 ' ...
                        'GROUP BY `STP_measurement_dataset`.`measurement_id` ' ...
                        'ORDER BY `' sort '` DESC;'];
                    
       
            
            obj.list = select( obj.conn,sqlquery);
            wrongID = obj.list.id ==  -2147483648;
            obj.list.start_time(wrongID) = 0;
            obj.list.end_time(wrongID) = 0;
            % start time
            obj.list.start_time = datetime(obj.list.start_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss');
           
            % end time 
            obj.list.end_time = datetime(obj.list.end_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss');
        end
        
        function obj = set_measurement_ID(obj,measurement_id)
            %set measurement id
            obj.id = measurement_id;
        end
        %%  *************** declaration of instruments *******************
        
        function obj = declaration(obj,date,duration)
           % gets the maximum cycle count of the measurement, the
           % measurements info and the list of sensors of the set up.
           % After this the declaration of the instrument objects in an
           % array is done.
           %
           %Options:
           %-   To get the full measurement: 
           %        date variable must contain "full" or is empty
           %
           %-   For a specific date:  format 'dd-MM-yyyy HH:mm:ss.SSS'
           %        All measurements inside the range will be stored.
           %        The time is optional but if a time is chosen, the hours
           %        and minutes must be entered.
           %        If no time is chosen the measurement object will have a
           %        start time of 00:00:00.000 of the given date.
     
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
            
            % Set Start and end time and the cycle counters 
            if contains(date,'full','IgnoreCase',true) || isempty(date)              
                obj.start_time = datetime(measurement_info.start_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss.SSS');
                obj.end_time = datetime(measurement_info.end_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss.SSS');
                pulled_cycleCounts = obj.max_cycleCount;
                obj.end_cycleCount = obj.max_cycleCount;
                obj.start_cycleCount = 0;
            else 
                 regexDate = '^(0[1-9]|[1-2][0-9]|3[0-1])[-/](0[1-9]|1[0-2])[-/]([0-9]{4})( ([0-1][0-9]|2[0-3])[:h]([0-5][0-9])(?:[:m](?:([0-5][0-9])(?:[.,]([0-9]{1,3})|s?)?)?)?)?$';
                 dateCapture = regexp(date,regexDate, 'tokens');

                 % check if date is correct
                 trials = 0;
                 while  isempty(dateCapture) && trials <=3
                     if trials ==3
                         exit
                     end
                     warning off backtrace;
                     warning("Wrong format! the folowing types are supported: for dates 'dd/MM-yyyy' or 'dd-MM-yyyy' and the following symbols for time: 'h','m','s',':' and '.' for miliseconds");
                     warning on backtrace;
                     date = input('Date: ','s');
                     dateCapture = regexp(date,regexDate, 'tokens');
                     trials = trials +1;                
                 end

                 % split date and reformat the date 
                 dateSplit = split(date,{'-','/',':','h','m','s','.',' '},2);
                 if isempty(dateSplit{end}) % if a symbol is at the end of the string a 0x0 char will be present in the dateSplit
                     dateSplit{end} = [];
                     sizeSplit = size(dateSplit,2)-1;
                 else
                     sizeSplit = size(dateSplit,2);
                 end
                 dateSymbols = ["-","-"," ",":",":","."]; 
                 dateArray = reshape([dateSplit(1:sizeSplit) ;dateSymbols(1:sizeSplit)],1,[]);
                 dateConverted = strjoin(dateArray(1:end-1),"");

                 % set start time
                 startMeasurement = datetime(measurement_info.start_time,'ConvertFrom','epochtime','TicksPerSecond',1e3,'Format','dd-MM-yyyy HH:mm:ss.SSS');    
                 if (size(dateSplit,2)==3) && contains(dateConverted,datestr(startMeasurement,'dd-mm-yyyy'))
                         obj.start_time = startMeasurement;
                 else % start time will be midnight
                         obj.start_time = datetime(dateConverted,'InputFormat','dd-MM-yyyy', 'Format', 'dd-MM-yyyy HH:mm:ss.SSS');
                 end

                % Set start time and start and end cyclecount
                dateNr = posixtime(obj.start_time);     
                % set cycle counters
                obj.start_cycleCount = ceil(double(int64(dateNr*1000) - measurement_info.start_time)/1000/0.02+1);
                if obj.start_cycleCount < 0                    
                     error("out of range");
                end
                
                trials =0;
                while duration <=0
                    if trials==3
                        exit
                    end
                    warning off backtrace;
                    warning("choose a duration higher than zero");
                    warning on backtrace;
                    duration = input('duration: ');
                    trials = trials+1;
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
        
        %% *********************** Get data ***************************
        
        function obj = get_dataset_DB(obj)
            %Get the dataset from the 'STP_measurement_dataset table'.
            %This contains all the data inside the chosen range
            %MATLAB will get the data in parts of maximum 5000.
            %
            %A warning will be created when there are missing cycle
            %counters
            
        Limit = 1000000;
            if Limit > (obj.end_cycleCount-obj.start_cycleCount)
            Limit = obj.end_cycleCount-obj.start_cycleCount+1;
            end
            obj.dataset_list  = [];
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
            if obj.dataset_list.cyclecounter(1)==0
                obj.dataset_list.cyclecounter= obj.dataset_list.cyclecounter+1;
            end
            
            cycleSequence = 1:1:(obj.end_cycleCount - obj.start_cycleCount);
            missingCycles = setdiff(cycleSequence,obj.dataset_list.cyclecounter');
         
            if ~isempty(missingCycles)
                warning off backtrace;
                warning(" %i cyclecounters are missing:(first 25 are shown)\n%s %s", size(missingCycles,2),join(string(missingCycles(1:min([25 size(missingCycles,2)]))),", "));
                warning on backtrace;
            end                     
        end
        %% processing 
        function obj = processData_DB(obj)
           %The declared instruments will be filled with the sensor data.
           %
           %If the data doesn't contain 0x80 on the end an error will be
           %prompted and the code stops.
           
            offset = 1;
             
            % converting Cell to array and shifting the array in case of
            % missing cycle counters
             dataset = cell2mat(obj.dataset_list.data')';
                     
            for i = 1:obj.n_instruments
                new_offset = offset + obj.instruments(i).length;
                obj.instruments(i) = obj.instruments(i).add_data( obj.dataset_list.cyclecounter, dataset(:,offset:new_offset));
                % RAM memory usage
                if  obj.enableStoreMemory 
                    [user,sys] = memory;
                    obj.memoryInstrument(i) =  user.MemUsedMATLAB;
                end 
                 
                if ( dataset(:,new_offset)~= -128 - isnan(dataset(:,new_offset)))>0
                    error("No 0x80 at the end");
                end
                offset = new_offset+1;
            end
            clear dataset shiftedData
        end
        %% *************** plot all instrument *******************
        
        function obj = plot_all(obj)
           %All the instruments will be plotted
            for i = 1:obj.n_instruments
                obj.instruments(i).plot_all(obj.id,obj.start_time);
            end
        end
   

               %% *********************** export data ***********************
        function  extractionData(obj)
            %Each sensor data will be exported to the workspace.
            %The name of the variables will be in the following format:
            %   "IDxx_instxxx_sensorname"
            %   
                       
            for i=obj.instruments
                nameCell = strcat('ID',num2str(obj.id),'.inst', num2str(i.id),'.',i.name);
                for j= 1 :size(i.data,2)
                    nameSensor= strcat( nameCell, '.',char(i.data(j).name));
                    genName = matlab.lang.makeValidName(nameSensor);
                    eval([genName '= i.data(' num2str(j) ').values ;']);
                    assignin('base',genName,i.data(j).values);
                end
                %'ID',string(obj.id),'.',
            end
            time = (seconds((1:size(obj.instruments(1).data(1).values,1))*0.020) + obj.start_time)';
            assignin('base',strcat('ID',num2str(obj.id),'_time'), time);
            cycleCount = (1:1:size(obj.instruments(1).data(1).values,1))';
            assignin('base',strcat('ID',num2str(obj.id),'_cycleCount'), cycleCount);
            info.measurementID= obj.id;
            info.measurementDescription = obj.description;
            info.setupID= obj.setup_id;
            info.startTime= datestr(obj.start_time,'dd/mm/yyyy HH:MM:SS.FFF');
            info.endTime= datestr(obj.end_time,'dd/mm/yyyy HH:MM:SS.FFF');
            assignin('base',strcat('ID',num2str(obj.id),'_info'),info);
        end
        %% 
        function [] =  save(obj,fname,varargin)     
            save(fname,'obj',varargin{:});
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
