classdef measurement < dynamicprops
    
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
        name, ...
        setup_id, ...
        setup_name, ...
        start_time, ...
        end_time, ...
        start_cycleCount,...
        end_cycleCount,...
        max_cycleCount, ...
        user_id, ...
        user_name, ...
        n_instruments, ...
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
        
        function obj = connect(obj,sort,direction)
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
                javaclasspath("jdbc/mysql-connector-java-8.0.18.jar");
            elseif isfile("mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar")
                % legacy jdbc location
                javaclasspath("mysql-connector-java-8.0.18/mysql-connector-java-8.0.18.jar");
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
            
            
                    
           sqlquery = ['SELECT `measurements`.`id`, ' ...
                    '       TRIM(`measurements`.`name_en`) AS `name`, ' ...
                    '       TRIM(`measurements`.`description_en`) AS `description`, ' ...
                    '       `measurements`.`started_at`, ' ...
                    '       `measurements`.`stopped_at`, ' ...
                    '       TRIM(`setups`.`name_en`) AS `setup`, ' ...
                    '       TRIM(`users`.`username`) AS `user`, ' ...
                    '       `measurements`.`count`, ' ...
                    '       `measurements`.`max` ' ...          
                    '       FROM `measurements` ' ...
                    '       LEFT JOIN `users` ' ...
                    '       ON `measurements`.`user_id` = `users`.`id` ' ...
                    '       LEFT JOIN `setups` ' ...
                    '       ON `measurements`.`setup_id` = `setups`.`id` ' ...
                    '       ORDER BY `' sort '`' direction ';'];
            
            obj.list = select( obj.conn,sqlquery);
            obj.list.name = string(obj.list.name);
            obj.list.description(contains(obj.list.description,''))= {'empty'};
            obj.list.description = string(obj.list.description);
            obj.list.name = string(obj.list.name);
            obj.list.setup = string(obj.list.setup);
            obj.list.user = string(obj.list.user);
            wrongID = obj.list.id ==  -2147483648;
            obj.list.started_at(wrongID) ={'0'};
            obj.list.stopped_at(wrongID) ={'0'};
            % start time
            obj.list.started_at = string(obj.list.started_at);
            %obj.list.started_at = datetime(obj.list.started_at,'InputFormat','yyyy-MM-dd HH:mm:ss.SSS','TimeZone','UTC');
  
            % end time 
            obj.list.stopped_at = string(obj.list.stopped_at);
            %obj.list.stopped_at = datetime(obj.list.stopped_at,'InputFormat','yyyy-MM-dd HH:mm:ss.SSS','TimeZone','UTC');
        end
        
 
        function obj = set_measurement_ID(obj,measurement_id)
            %set measurement id
            obj.id = measurement_id;
        end
        %%  *************** declaration of instruments *******************
        
        function obj = declaration(obj,date,dur,addDistSubs)
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
     
           sqlquery = ['SELECT MAX(`measurement_datasets`.`cyclecounter`) AS `max` ' ...
                'FROM `measurement_datasets` ' ...
                'WHERE `measurement_datasets`.`measurement_id` = ' int2str(obj.id) ';'];
            maxCycleCount = select(obj.conn,sqlquery);
            obj.max_cycleCount = maxCycleCount.max;            
                                 
            sqlquery = ['SELECT `measurements`.`id`, ' ...
                '       `measurements`.`setup_id`, ' ...
                '       `measurements`.`user_id`, ' ...
                '       `measurements`.`started_at`, ' ...
                '       `measurements`.`stopped_at`, ' ...
                '        TRIM(`measurements`.`name_en`) AS `name`, ' ...
                '       TRIM(`measurements`.`description_en`) AS `description`, ' ...
                '       TRIM(`setups`.`name_en`) AS `user`, ' ...
                '       TRIM(`users`.`username`) AS `setup` ' ...
                'FROM `measurements` ' ...                       
                '       LEFT JOIN `users` ' ...
                '       ON `measurements`.`user_id` = `users`.`id` ' ...
                '       LEFT JOIN `setups` ' ...
                '       ON `measurements`.`setup_id` = `setups`.`id` ' ...
                'WHERE `measurements`.`id` = ' int2str(obj.id) ';'];
            
            measurement_info = select(obj.conn, sqlquery);
            obj.id = measurement_info.id;             
            obj.name = string(measurement_info.description);  
            obj.setup_id = measurement_info.setup_id;
            obj.setup_name = string(measurement_info.setup);
            obj.user_id = measurement_info.user_id;
            obj.user_name = string(measurement_info.user);
            
            % Set Start and end time and the cycle counters 
            if contains(date,"full",'IgnoreCase',true) || date==""  || isempty(date)              
                obj.start_time = datetime(measurement_info.started_at,'InputFormat','yyyy-MM-dd HH:mm:ss.SSS','TimeZone','UTC');
                obj.end_time = datetime(measurement_info.stopped_at,'InputFormat','yyyy-MM-dd HH:mm:ss.SSS','TimeZone','UTC');
                
                if  obj.max_cycleCount == -2147483648
                    diff = obj.end_time - obj.start_time;
                    pulled_cycleCounts = seconds(diff)/0.02;
                    obj.end_cycleCount = pulled_cycleCounts;
                else
                    pulled_cycleCounts = int64(obj.max_cycleCount);
                    obj.end_cycleCount =  pulled_cycleCounts;
                end
                obj.start_cycleCount = 1;
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
                 dateSplit = ["00","00","0000","00","00","00","000"];
                 splitted = split(date,{'-','/',':','h','m','s','.',' '},2);
                 dateSplit(1:size(splitted,2)) = splitted;
                
                 dateSymbols = ["-","-"," ",":",":",".",""]; 
                 dateArray = reshape([dateSplit(1:7) ;dateSymbols(1:7)],1,[]);
                 
                 dateConverted = strjoin(dateArray(1:end-1),"");

                 % set start time
                 startMeasurement = datetime(measurement_info.start_time,'InputFormat','yyyy-MM-dd HH:mm:ss.SSS','TimeZone','UTC');    
                 endMeasurement = datetime(measurement_info.end_time,'InputFormat','yyyy-MM-dd HH:mm:ss.SSS','TimeZone','UTC');    
                 dateNumConverted=datenum(dateConverted,'dd-mm-yyyy HH:MM:SS.FFF');
                 if (dateNumConverted-datenum(startMeasurement))<0 && (dateNumConverted-datenum(endMeasurement))>0
                    obj.start_time = startMeasurement;
                else
                    obj.start_time = datetime(dateConverted,'InputFormat','dd-MM-yyyy HH:mm:ss.SSS', 'Format', 'dd-MM-yyyy HH:mm:ss.SSS');
                end
                % Set start time and start and end cyclecount
                dateNr = posixtime(obj.start_time); 
                % set cycle counters
                obj.start_cycleCount = ceil((dateNr*1000 - measurement_info.start_time)/1000/0.02);
                if obj.start_cycleCount < 0                    
                     error("out of range");
                end
                
                trials =0;
                while isempty(dur) || dur <=0
                    if trials==3
                        exit
                    end
                    warning off backtrace;
                    warning("choose a duration higher than zero");
                    warning on backtrace;
                    dur = input('enter a duration > 0: ');
                    trials = trials+1;
                end
                obj.end_cycleCount = floor((dateNr*1000 + ceil(dur*60*60*1000) - measurement_info.start_time)/1000/0.02); 
                if obj.end_cycleCount > obj.max_cycleCount
                    obj.end_cycleCount = int64(obj.max_cycleCount);
                end
                pulled_cycleCounts =  int64(obj.end_cycleCount)-obj.start_cycleCount+1;
                obj.end_time = obj.start_time + seconds(double(pulled_cycleCounts)*0.02);
            end
            
            % Selecting setup
            sqlquery = ['SELECT `t1`.`id`, '...	  
            '       TRIM(`t1`.`name_en`) AS `name`, '...
            '       TRIM(`t1`.`description_en`) AS `description`, '...
            '       IF(`t2`.`value` IS NULL, `t1`.`value`,  `t2`.`value`) AS value  '...
            'FROM ( '...
            'SELECT `instrument_type_parameter`.`value`, '...
            '       `instruments`.`id`, '...
            '       `instruments`.`name_en`, '...
            '       `instruments`.`description_en` '...
            'FROM `instrument_type_parameter` '...
            'INNER JOIN `instruments` '...
            ' ON `instruments`.`instrument_type_id` = `instrument_type_parameter`.`instrument_type_id` '...
            'INNER JOIN `setups` '...
            ' ON `setups`.`id` = `instruments`.`setup_id` '...
            'WHERE `instrument_type_parameter`.`parameter_id` = 33 '...
            ' AND `setups`.`id` = ' int2str(obj.setup_id) ' '...
            'ORDER BY `instruments`.`id` ASC '...
            ') AS `t1` '...
            'LEFT JOIN ( '...
            'SELECT `instrument_parameter`.`value`, '...
            '       `instruments`.`id` '...
            'FROM `instrument_parameter` '...
            'INNER JOIN `instruments` '...
            ' ON `instruments`.`id` = `instrument_parameter`.`instrument_id` '...
            'INNER JOIN `setups` '...
            ' ON `setups`.`id` = `instruments`.`setup_id` '...
            'WHERE `instrument_parameter`.`parameter_id` = 33 '...
            ' AND `setups`.`id` = ' int2str(obj.setup_id) ' '...
            'ORDER BY `instruments`.`id` ASC '...
            ') AS `t2` '...
            'ON `t1`.`id` = `t2`.`id`;'];
        
            datatype_list = select(obj.conn,sqlquery);                   
            obj.n_instruments = size(datatype_list,1);
            obj.instruments = classes.instrument.empty(0,obj.n_instruments);
            for i = 1:obj.n_instruments
                obj.instruments(i) = classes.instrument(datatype_list.id(i),datatype_list.name{i},datatype_list.description{i},datatype_list.value(i), pulled_cycleCounts,addDistSubs);
                % RAM memory usage
                if obj.enableStoreMemory 
                    [user,sys] = memory;
                    obj.memoryDeclaration(i)= user.MemUsedMATLAB;
                end
            end
            % ------- software instruments  -------
            % OAS
%             sqlquery = ['SELECT `instruments`.`id`, ' ...                
%             '       `instruments`.`name_en`, '...            
%             '       `instruments`.`description_en` '...
%                 'FROM `instruments` ' ...
%                 'INNER JOIN `setups` ' ...
%                 'ON `setups`.`id` = `instruments`.`setup_id` ' ...
%                 'INNER JOIN `instrument_type_parameter` ' ...
%                 'ON `instrument_type_parameter`.`instrument_type_id` = `instruments`.`instrument_type_id` ' ...
%                 'WHERE `setups`.`id` = ' int2str(obj.setup_id) ' AND `instrument_type_parameter`.`parameter_id` = 256 AND `instrument_type_parameter`.`value` = 3;'];
%             OAS = select(obj.conn,sqlquery);
% %             if OAS_id.id==672
% %               
% %             
% %             end
%             obj.instruments(i+1) = classes.instrument(OAS.id,OAS.name,OAS.description,-1 , 1,false);
        end       
        
        %% *********************** Get data ***************************
        
        function obj = get_dataset_DB(obj,excludeInstruments,addDistSubs)
            %Get the dataset from the 'STP_measurement_dataset table'.
            %This contains all the data inside the chosen range
            %MATLAB will get the data in parts of maximum 5000.
            %
            %A warning will be created when there are missing cycle
            %counters
            totalExtrationTime = 0;
            totalProcessingTime =0;
        for i = 1:obj.n_instruments 
            if excludeInstruments(i)==0
                obj.instruments(i).addprop('extracted');
                obj.instruments(i).extracted = true;
                Limit = 1000000;
                if Limit > (obj.end_cycleCount-obj.start_cycleCount)
                    Limit = obj.end_cycleCount-obj.start_cycleCount+1;
                end
                obj.dataset_list  = [];
                j=obj.start_cycleCount;
                tic
                disp(newline + "  -------" + obj.instruments(i).name + "-----" );
                while j<obj.end_cycleCount 

                     endLimit = j+Limit ;
                    if j+Limit > obj.end_cycleCount
                        endLimit= obj.end_cycleCount;
                    end
                    sqlquery = ['SELECT `measurement_datasets`.`cyclecounter`, ' ...
                        '       `measurement_datasets`.`status`, ' ...
                        '       `measurement_datablobs`.`data`, ' ...
                        '       `measurement_datablobs`.`status` ' ...
                        'FROM `measurement_datasets` '  ...
                        'INNER JOIN `measurement_datablobs` ' ...
                        ' ON `measurement_datasets`.`id` = `measurement_datablobs`.`measurement_dataset_id` ' ...
                        'WHERE `measurement_datasets`.`measurement_id` = ' int2str(obj.id) ' ' ...
                        ' AND `measurement_datasets`.`cyclecounter` <= ' int2str(endLimit) ' '...
                        ' AND `measurement_datasets`.`cyclecounter` >= ' int2str(j) ' '...
                        ' AND `measurement_datablobs`.`instrument_id` = ' int2str(obj.instruments(i).id ) ';'];
                    obj.dataset_list = [obj.dataset_list;select(obj.conn,sqlquery)];    
                    j=endLimit+1;
                end
                if isempty(obj.dataset_list)
                    warning off backtrace;                    
                    warning("Measurement contains no data");
                    warning on backtrace;
                    return;
                elseif obj.dataset_list.cyclecounter(1)==0
                    obj.dataset_list.cyclecounter= obj.dataset_list.cyclecounter+1;
                end

    %             cycleSequence = obj.start_cycleCount:1:obj.end_cycleCount;
    %             missingCycles = setdiff(cycleSequence,int64(obj.dataset_list.cyclecounter)');
    %          
    %             if ~isempty(missingCycles)
    %                 warning off backtrace;
    %                 warning(" %i cyclecounters are missing:(first 25 are shown)\n%s %s", size(missingCycles,2),join(string(missingCycles(1:min([25 size(missingCycles,2)]))),", "));
    %                 warning on backtrace;
    %             end
                extrationTime = toc;
                disp("  - Extraction time: " + extrationTime + " s");
                totalExtrationTime = totalExtrationTime + extrationTime; 
                [obj,processingTime] = processData_DB(obj,i,addDistSubs);
                totalProcessingTime = totalProcessingTime + processingTime;
            end
        end  
         disp(newline + "  ------ Total time -----");
         disp("    Extraction time: " + totalExtrationTime + " s");
         disp("    processing time: " + totalProcessingTime + " s");
        end
        %% processing 
        function [obj,processingTime] = processData_DB(obj,i,addDistSubs)
           %The declared instruments will be filled with the sensor data.
           %
           %If the data doesn't contain 0x80 on the end an error will be
           %prompted and the code stops.
           
          
            % converting Cell to array and shifting the array in case of
            % missing cycle counters
            tic 
             dataset = cell2mat(obj.dataset_list.data')';
                     
            
                obj.instruments(i) = obj.instruments(i).add_data( int64(obj.dataset_list.cyclecounter)-obj.start_cycleCount+1, dataset,addDistSubs);
                % RAM memory usage
                if  obj.enableStoreMemory 
                    [user,sys] = memory;
                    obj.memoryInstrument(i) =  user.MemUsedMATLAB;
                end 
                 
                if ( obj.dataset_list.status_1 ~= 128 - isnan(obj.dataset_list.status_1))>0
                    error("No 0x80 at the end");
                end
             processingTime = toc; 
           disp("  - processing time: " + processingTime + " s");
           
            %% TODO OAS characteristic slope
            
%             if OAS_id.id >0 
%               sqlquery = ['SELECT * FROM `instrument_parameter` '...
%                             'WHERE ((`instrument_id` =' int2str(OAS_id.id) ') '...
%                             'AND(`parameter_id` in (1027,1028,1029)));'];
%               OAS_setting = select(obj.conn,sqlquery);
%               
%             joystick_id = findobj(obj.instruments,'datatype',161,'-or','datatype',162,'-or','datatype',163).id;
%             sqlquery = ['SELECT * FROM `instrument_parameter` '...
%                             'WHERE ((`instrument_id` =' int2str(joystick_id) ') '...
%                             'AND(`parameter_id` in (1026)));'];
%             OAS_setting= [OAS_setting; select(obj.conn,sqlquery)];
%             obj.addprop(OAS)
%             obj.isntrument.add_OAS_setting(OAS_setting);
%               
%               
%             end
            
            
            
            obj.dataset_list = [];
            clear dataset shiftedData 
        end
        %% *************** plot all instrument *******************
        
        function obj = plot_all(obj,showHeatMap,standardHeatmap,variableScale,ExcludedInstruments,plotDownSample,downSampleFactor,showDistSubs)
           %All the instruments will be plotted
           addpath('libraries')
            for i = 1:obj.n_instruments
                if isprop(obj.instruments(i),'extracted') && obj.instruments(i).extracted ==1 && ExcludedInstruments(i)
                obj.instruments(i).plot_all(obj.id,obj.start_time,showHeatMap,standardHeatmap,variableScale,plotDownSample,downSampleFactor,showDistSubs);
                end
            end
        end
        %% ***************Filtering *******************  
        function obj = filter(obj,deadZone,FilterUnit)
           %All the instruments will be plotted
            for i = 1:  obj.n_instruments
                switch obj.instruments(i).datatype
                    case 161 % A1 JOYSTICK_DX2_OUTPUT
                        obj.instruments(i) = obj.instruments(i).filter(deadZone,FilterUnit);
                        break
                    case 162 % A2 JOYSTICK_PG_OUTPUT
                        obj.instruments(i)= obj.instruments(i).filter(deadZone,FilterUnit);
                        break
                    case 163 % A3 JOYSTICK_LINX_OUTPUT
                        obj.instruments(i) = obj.instruments(i).filter(deadZone,FilterUnit);
                        break
                    otherwise
                end
           end
        end    

               %% *********************** export data ***********************
        function mobj = extractionMobject(obj)
            mobj = obj;
            mobj.conn = [];
        end
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
            info.measurementName = string(obj.name);
            info.setupID= obj.setup_id;
            info.setupName= string(obj.setup_name);
            info.userID= obj.user_id;
            info.userName= string(obj.user_name);
            
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
