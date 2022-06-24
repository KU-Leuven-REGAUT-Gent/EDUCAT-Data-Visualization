
classdef instrument < dynamicprops
    % instrument summary
    % This object contains all the sensor data
    %
    %
    % Method summary:
    % *	add_data               -    add data to the sensordata object of the instrument
    % * export                 -    Under construction
    % * plot_all               -    plot all the sensordata object of the instrument.
    properties
        id, ...
            name, ...
            description, ...
            data, ...
            datatype , ...
            lengthData
    end
    properties (Hidden)
        filterSetting
    end
    methods
        %%  *************** constructor *******************
        
        function obj = instrument(id,name,description,datatype,maxCycleCount,addDistSubs)
            %constructor of the instrument
            %Declaration of the ID, name, description and the datatype of
            %the instrument.
            %Creation of the different sensordata object of each
            %instrument.
            
            obj.id = id;
            obj.name = name;
            obj.description = description;
            obj.datatype = datatype;
%             obj.filterSetting.executed = false; 
            
            switch obj.datatype
                case 160 % TRIAL 1 JOYSTICK
                    obj.lengthData = 5;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Actuator mode","1/0","boolean",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Operated","bit","boolean",maxCycleCount);
                    obj.data(6) = classes.data("Bouts","bouts/measurement","boolean",1);
                    obj.data(7) = classes.data("Operating time","s","float_64",1);
                case 161 % A1 JOYSTICK_DX2_OUTPUT
                    obj.lengthData = 5;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Operated","bit","boolean",maxCycleCount);
                    obj.data(6) = classes.data("Bouts","bouts/measurement","boolean",1);
                    obj.data(7) = classes.data("Operating time","s","float_64",1);
                case 162 % A2 JOYSTICK_PG_OUTPUT
                    obj.lengthData = 6;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Mode","number","int_8",maxCycleCount);
                    obj.data(6) = classes.data("Operated","bit","boolean",maxCycleCount);
                    obj.data(7) = classes.data("Bouts","bouts/measurement","boolean",1);
                    obj.data(8) = classes.data("Operating time","s","float_64",1);
                case 163 % A3 JOYSTICK_LINX_OUTPUT
                    obj.lengthData = 5;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Operated","bit","boolean",maxCycleCount);
                    obj.data(6) = classes.data("Bouts","bouts/measurement","boolean",1);
                    obj.data(7) = classes.data("Operating time","s","float_64",1);
                case 176 % B0 TRIAL 1 IMU WITH TEMPERATURE
                    obj.lengthData = 20;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);
                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(7) = classes.data("mx","0.01 µT","int_16",maxCycleCount);
                    obj.data(8) = classes.data("my","0.01 µT","int_16",maxCycleCount);
                    obj.data(9) = classes.data("mz","0.01 µT","int_16",maxCycleCount);
                    obj.data(10) = classes.data("T","°C","int_16",maxCycleCount);
                case 177 % B1 IMU_9AXIS_ROT_VEC
                    obj.lengthData = 26;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);
                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(7) = classes.data("mx","0.01 µT","int_16",maxCycleCount);
                    obj.data(8) = classes.data("my","0.01 µT","int_16",maxCycleCount);
                    obj.data(9) = classes.data("mz","0.01 µT","int_16",maxCycleCount);
                    obj.data(10) = classes.data("real","0.001","int_16",maxCycleCount);
                    obj.data(11) = classes.data("i","0.001","int_16",maxCycleCount);
                    obj.data(12) = classes.data("j","0.001","int_16",maxCycleCount);
                    obj.data(13) = classes.data("k","0.001","int_16",maxCycleCount);
                case 178 % B2 IMU_6AXIS
                    obj.lengthData = 12;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);
                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                case 192 % C0 TRIAL 1 GPS WITH CLOCK
                    obj.lengthData = 17;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("longitude","degrees","float_32",maxCycleCount);
                    obj.data(2) = classes.data("latitude","degrees","float_32",maxCycleCount);
                    obj.data(3) = classes.data("altitude","m","float_32",maxCycleCount);
                    obj.data(4) = classes.data("n sats","-","int_8",maxCycleCount);
                    obj.data(5) = classes.data("hour","degrees","uint_8",maxCycleCount);
                    obj.data(6) = classes.data("min","m","uint_8",maxCycleCount);
                    obj.data(7) = classes.data("sec","-","uint_8",maxCycleCount);
                case 193 % C1 GPS_MIN_DATA
                    obj.lengthData = 17;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("longitude","degrees","float_32",maxCycleCount);
                    obj.data(2) = classes.data("latitude","degrees","float_32",maxCycleCount);
                    obj.data(3) = classes.data("hMSL","m","float_32",maxCycleCount);
                    obj.data(4) = classes.data("speed","m/s","float_32",maxCycleCount);
                    obj.data(5) = classes.data("Reception","-","int_8",maxCycleCount);
                case 194 % C2 GPS_STATUS
                    error("Datatype unsupported - not yet implemented");
                case 195 % C3 GPS_DATA_STATUS
                    error("Datatype unsupported - not yet implemented");
                case 209 % D1 AN_DISTANCE_NODES D1 (US)
                    obj.lengthData = 2;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("US","cm","uint_16",maxCycleCount);
                case 210 % D2 CAN_DISTANCE_NODES D2 (IR)
                    obj.lengthData = 1;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("IR","cm","uint_8",maxCycleCount);
                case 211 % D3 CAN_DISTANCE_NODES D3 (US+IR)
                    obj.lengthData = 5;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("US","cm","uint_16",maxCycleCount);
                        obj.data(3) = classes.data("IR","cm","uint_8",maxCycleCount);
                    end
                case 212 % D4 CAN_DISTANCE_NODES D4 (US+2IR)
                    obj.lengthData = 6;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("US","cm","uint_16",maxCycleCount);
                        obj.data(3) = classes.data("IR 1","cm","uint_8",maxCycleCount);
                        obj.data(4) = classes.data("IR 2","cm","uint_8",maxCycleCount);
                    end
                case 213 % D5 CAN_DISTANCE_NODES D5 (US+3IR)
                    obj.lengthData = 7;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("US","cm","uint_16",maxCycleCount);
                        obj.data(3) = classes.data("IR 1","cm","uint_8",maxCycleCount);
                        obj.data(4) = classes.data("IR 2","cm","uint_8",maxCycleCount);
                        obj.data(5) = classes.data("IR 3","cm","uint_8",maxCycleCount);
                    end
                case 214 % D6  CAN_DISTANCE_NODES D6(4IR)
                    obj.lengthData = 6;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    if addDistSubs
                        obj.data(2) = classes.data("IR 1","cm","uint_8",maxCycleCount);
                        obj.data(3) = classes.data("IR 2","cm","uint_8",maxCycleCount);
                        obj.data(4) = classes.data("IR 3","cm","uint_8",maxCycleCount);
                        obj.data(5) = classes.data("IR 4","cm","uint_8",maxCycleCount);
                    end
                case 215 % D7  CAN_DISTANCE_NODES D7 (4IR) Only Calculated Value
                    obj.lengthData = 2;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Calculated distance","cm","uint_16",maxCycleCount);
                case 216 % D8  CAN_DISTANCE_NODES D8 (US+3IR) Only Calculated Value
                    obj.lengthData = 2;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("Calculated distance","cm","uint_16",maxCycleCount);
                case 225 % E1 Real Time Clock
                    obj.lengthData = 8;
                    obj.data = classes.data.empty(0,obj.lengthData);
                    obj.data(1) = classes.data("unix_epoch_ms","ms","uint_64",maxCycleCount);
                case 241 % F1 Android Device
                    obj.lengthData = 2;
                    obj.data = classes.data.empty(0,4);
                    obj.data(1) = classes.data("OAS Calculated Value","","uint_8",maxCycleCount);
                    obj.data(2) = classes.data("Buzzer","","boolean",maxCycleCount);
                    obj.data(3) = classes.data("Haptic Feedback","","boolean",maxCycleCount);
                    obj.data(4) = classes.data("Visual Feedback","","boolean",maxCycleCount);
                    
                case 242 % F2 Android Device
                    obj.lengthData = 3;
                    obj.data = classes.data.empty(0,12);
                    obj.data(1) = classes.data("OAS Calculated Value","","uint_8",maxCycleCount);
                    obj.data(2) = classes.data("Buzzer","","boolean",maxCycleCount);
                    obj.data(3) = classes.data("Haptic Feedback","","boolean",maxCycleCount);
                    obj.data(4) = classes.data("Visual Feedback","","boolean",maxCycleCount);
                    obj.data(5) = classes.data("Sensor activate bit - Instrument 1","","boolean",maxCycleCount);
                    obj.data(6) = classes.data("Sensor activate bit - Instrument 2","","boolean",maxCycleCount);
                    obj.data(7) = classes.data("Sensor activate bit - Instrument 3","","boolean",maxCycleCount);
                    obj.data(8) = classes.data("Sensor activate bit - Instrument 4","","boolean",maxCycleCount);
                    obj.data(9) = classes.data("Sensor activate bit - Instrument 5","","boolean",maxCycleCount);
                    obj.data(10) = classes.data("Sensor activate bit - Instrument 6","","boolean",maxCycleCount);
                    obj.data(11) = classes.data("Sensor activate bit - Instrument 7","","boolean",maxCycleCount);
                    obj.data(12) = classes.data("Sensor activate bit - Instrument 8","","boolean",maxCycleCount);
                    
                otherwise
                    error("Datatype unsupported");
            end
        end
        
        %%  *************** add data function *******************
        function obj = add_data(obj, cyclecounter_list, blob, addDistSubs)
            % add data to the sensordata object of the instrument
            switch obj.datatype
                case 161 % A1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    
                    % calculate operation, operation time and bouts
                    obj.joystickCalculations(5,blob(:,3),blob(:,4),cyclecounter_list);
                case 162 % A2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,6));
                    
                    % calculate operation, operation time and bouts
                    obj.joystickCalculations(6,blob(:,3),blob(:,4),cyclecounter_list);
                case 163 % A3
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    
                    % calculate operation, operation time and bouts
                    obj.joystickCalculations(5,blob(:,3),blob(:,4),cyclecounter_list);
                case 177 % B1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, blob(:,13:14));
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, blob(:,15:16));
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, blob(:,17:18));
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, blob(:,19:20));
                    obj.data(11) = obj.data(11).add_value(cyclecounter_list, blob(:,21:22));
                    obj.data(12) = obj.data(12).add_value(cyclecounter_list, blob(:,23:24));
                    obj.data(13) = obj.data(13).add_value(cyclecounter_list, blob(:,25:26));
                case 178 % B2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5:6));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,7:8));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,9:10));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, blob(:,11:12));
                case 193 % C1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:4));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,5:8));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,9:12));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,13:16));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,17));
                case 194 % C2
                case 195 % C3
                case 209 % D1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                case 210 % D2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                case 211 % D3
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                    end
                case 212 % D4
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                        obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,6));
                    end
                case 213 % D5
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                        obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,6));
                        obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,7));
                    end
                case 214 % D6
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    if addDistSubs
                        obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                        obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                        obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                        obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,6));
                    end
                case 215 % D7
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                case 216 % D8
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                case 225 % E1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:8));
                case 241 % F1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, bitand(blob(:,2),1)==1);
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, bitand(blob(:,2),2)==2);
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, bitand(blob(:,2),4)==4);
                case 242 % F2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, bitand(blob(:,2),1)==1);
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, bitand(blob(:,2),2)==2);
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, bitand(blob(:,2),4)==4);
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, bitand(blob(:,3),1)==1);
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, bitand(blob(:,3),2)==2);
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, bitand(blob(:,3),4)==4);
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, bitand(blob(:,3),8)==8);
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, bitand(blob(:,3),16)==16);
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, bitand(blob(:,3),32)==32);
                    obj.data(11) = obj.data(11).add_value(cyclecounter_list, bitand(blob(:,3),64)==64);
                    obj.data(12) = obj.data(12).add_value(cyclecounter_list, bitand(uint8(blob(:,3)),128)==128);
            end
        end
        
        function obj = joystickCalculations(obj,startIndexInstrument,blobTurn,blobSpeed,cyclecounter_list)
            % resize and clear data Operated bit
            if length(obj.data(startIndexInstrument).values)>1 && sum(isnan(obj.data(startIndexInstrument).values)) < length(obj.data(startIndexInstrument).values)
                obj.data(startIndexInstrument) = obj.data(startIndexInstrument).resize(1,length(blobTurn));
                obj.data(startIndexInstrument) = obj.data(startIndexInstrument).clear_value();
            end
             % resize and clear Bouts   
            if length(obj.data(startIndexInstrument+1).values)>1 && sum(isnan(obj.data(startIndexInstrument+1).values)) < length(obj.data(startIndexInstrument+1).values)
                obj.data(startIndexInstrument+1) = obj.data(startIndexInstrument+1).resize(1,length(cyclecounter_list));
                obj.data(startIndexInstrument+1) = obj.data(startIndexInstrument+1).clear_value();
            end
            % operated bit
             measuredCyclesIDs = ~isnan(blobTurn) & ~isnan(blobSpeed);
             
            % adjust turn and speed when less or equal than 3 consecutive [0,0] from the turn and speed
            [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,blobTurn,blobSpeed);
            
            startZeroID = startZeroID(zeroCrossingIDs);
            endZeroID =  endZeroID(zeroCrossingIDs)-1;
            
            for i = 1: numel(startZeroID)
                blobTurn(startZeroID(i):endZeroID(i)) = 255;
                blobSpeed(startZeroID(i):endZeroID(i)) = 255;
            end
                        
         
            % calculate operated bit
            operatedBit  = zeros(numel(blobTurn),0);
            operatedBit(measuredCyclesIDs,1) = (blobTurn(measuredCyclesIDs) ~= 0 | blobSpeed(measuredCyclesIDs) ~= 0);
            obj.data(startIndexInstrument) = obj.data(startIndexInstrument).add_value(cyclecounter_list,operatedBit(measuredCyclesIDs));
  
            % Bouts calculation       
            flankDet = [operatedBit ;0]- [0; operatedBit];
                
            obj.data(startIndexInstrument+1) = obj.data(startIndexInstrument+1).add_value(1,sum(flankDet(flankDet>0)));
            
            % Operating time
%             obj.data(startIndexInstrument+2) = obj.data(startIndexInstrument+2).resize(1,length(cyclecounter_list));
            obj.data(startIndexInstrument+2) = obj.data(startIndexInstrument+2).clear_value();
            obj.data(startIndexInstrument+2) = obj.data(startIndexInstrument+2).filteredData(1,(sum(obj.data(startIndexInstrument).values(measuredCyclesIDs))-1)*0.02);
        end
        
        %%  *************** remove data function *******************
        function obj = remove_data(obj,cyclecounter_Keeplist)
            
            switch obj.datatype
                case 160 % A0 TRIAL 1 JOYSTICK
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    % recalculate bouts and operation time 
                    flankDet = [obj.data(5).values ;0]- [0; obj.data(5).values];
                    obj.data(6) = obj.data(6).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(7) = obj.data(7).filteredData(1,sum(rmmissing(obj.data(5).values))*0.02);
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);   
                        obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);   
                        obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);   
                        
                        % recalculate bouts and operation time 
                        flankDet = [obj.data(10).values ;0]- [0; obj.data(10).values];
                        obj.data(11) = obj.data(11).add_value(1,sum(flankDet(flankDet>0)));
                        obj.data(12) = obj.data(12).filteredData(1,sum(rmmissing(obj.data(10).values))*0.02);
                    end
                    if isprop(obj,'actuatorControl')
                        obj.actuatorControl.turn = obj.actuatorControl.turn.remove_value(cyclecounter_Keeplist);
                        obj.actuatorControl.speed = obj.actuatorControl.speed.remove_value(cyclecounter_Keeplist);
                        obj.actuatorControl.profile = obj.actuatorControl.profile.remove_value(cyclecounter_Keeplist);
                        actuatorControlArray = find(obj.data(1).values == 0);
                        if sum(actuatorControlArray)==0
                             delete(obj.findprop('actuatorControl'));
                        else
                            obj.calculateActuatorOperatingTime(actuatorControlArray,obj.actuatorControl.turn.values,obj.actuatorControl.speed.values);
                             if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                                obj.actuatorControl.filtered.turn = obj.actuatorControl.filtered.turn.remove_value(cyclecounter_Keeplist);
                                obj.actuatorControl.filtered.speed = obj.actuatorControl.filtered.speed.remove_value(cyclecounter_Keeplist);
                                obj.calculateFilteredactuatorOperatingTime(actuatorControlArray,obj.actuatorControl.filtered.turn.values,obj.actuatorControl.filtered.speed.values);
                            end
                        end
                    end                                
     
                    if isprop(obj,'attendantControl')
                        obj.attendantControl.turn = obj.attendantControl.turn.remove_value(cyclecounter_Keeplist);
                        obj.attendantControl.speed = obj.attendantControl.speed.remove_value(cyclecounter_Keeplist);
                        attendantInControlArray = ~isnan(obj.attendantControl.turn.values) & ~isnan(obj.attendantControl.speed.values);
                        if sum(attendantInControlArray)==0
                            delete(obj.findprop('attendantControl'));
                        else
                            obj.calculateAttendantOperatingTime(attendantInControlArray,obj.attendantControl.turn.values,obj.attendantControl.speed.values);
                            if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                                obj.attendantControl.filtered.turn = obj.attendantControl.filtered.turn.remove_value(cyclecounter_Keeplist);
                                obj.attendantControl.filtered.speed = obj.attendantControl.filtered.speed.remove_value(cyclecounter_Keeplist);
                                obj.calculateFilteredAttendantOperatingTime(attendantInControlArray,obj.attendantControl.filtered.turn.values,obj.attendantControl.filtered.speed.values);
                            end
                        end
                    end
                         % recalculate the operation time, operated and bauts
%                     if sum(~isnan(obj.data(2).values))>0 && sum (~isnan(obj.data(3).values))>0 
%                         cycleCounterList = find(~isnan(obj.data(2).values) | ~isnan(obj.data(3).values));
%                         obj.joystickCalculations(5,obj.data(2).values, obj.data(3).values,cycleCounterList);
%                     end   
                case 161 % A1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    % recalculate bouts and operation time 
                    flankDet = [obj.data(5).values ;0]- [0; obj.data(5).values];
                    obj.data(6) = obj.data(6).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(7) = obj.data(7).filteredData(1,sum(rmmissing(obj.data(5).values))*0.02);
                    
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);   
                        obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);   
                        obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);   
                        
                        % recalculate bouts and operation time 
                        flankDet = [obj.data(10).values ;0]- [0; obj.data(10).values];
                        obj.data(11) = obj.data(11).add_value(1,sum(flankDet(flankDet>0)));
                        obj.data(12) = obj.data(12).filteredData(1,sum(rmmissing(obj.data(10).values))*0.02);
                    end
                    
                    if isprop(obj,'attendantControl')
                        obj.attendantControl.turn = obj.attendantControl.turn.remove_value(cyclecounter_Keeplist);
                        obj.attendantControl.speed = obj.attendantControl.speed.remove_value(cyclecounter_Keeplist);
                        attendantInControlArray = find(obj.data(4).values == 6);
                        if sum(attendantInControlArray)==0
                             delete(obj.findprop('attendantControl'));
                        else
                            obj.calculateAttendantOperatingTime(attendantInControlArray,obj.attendantControl.turn.values,obj.attendantControl.speed.values);
                        end
                    end
                case 162 % A2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    flankDet = [obj.data(6).values ;0]- [0; obj.data(6).values];
                    obj.data(7) = obj.data(7).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(8) = obj.data(8).filteredData(1,sum(rmmissing(obj.data(6).values))*0.02);
                    
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);   
                        obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);   
                        obj.data(11) = obj.data(11).remove_value(cyclecounter_Keeplist);   
                        
                        % recalculate bouts and operation time 
                        flankDet = [obj.data(11).values ;0]- [0; obj.data(11).values];
                        obj.data(12) = obj.data(12).add_value(1,sum(flankDet(flankDet>0)));
                        obj.data(13) = obj.data(13).filteredData(1,sum(rmmissing(obj.data(11).values))*0.02);
                    end
                    
                    if isprop(obj,'attendantControl')
                        obj.attendantControl.turn = obj.attendantControl.turn.remove_value(cyclecounter_Keeplist);
                        obj.attendantControl.speed = obj.attendantControl.speed.remove_value(cyclecounter_Keeplist);
                        attendantInControlArray = find(obj.data(4).values == 6);
                        if sum(attendantInControlArray)==0
                             delete(obj.findprop('attendantControl'));
                        else
                            obj.calculateAttendantOperatingTime(attendantInControlArray,obj.attendantControl.turn.values,obj.attendantControl.speed.values);
                        end
                    end
                case 163 % A3
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) =  obj.data(6).remove_value(cyclecounter_Keeplist);
                    flankDet = [obj.data(5).values ;0]- [0; obj.data(5).values];
                    obj.data(6) = obj.data(6).add_value(1,sum(flankDet(flankDet>0)));
                    obj.data(7) = obj.data(7).filteredData(1,sum(rmmissing(obj.data(5).values))*0.02);
                    
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);   
                        obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);   
                        obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);   
                        
                        % recalculate bouts and operation time 
                        flankDet = [obj.data(10).values ;0]- [0; obj.data(10).values];
                        obj.data(11) = obj.data(11).add_value(1,sum(flankDet(flankDet>0)));
                        obj.data(12) = obj.data(12).filteredData(1,sum(rmmissing(obj.data(10).values))*0.02);
                    end
                    
                    if isprop(obj,'attendantControl')
                        obj.attendantControl.turn = obj.attendantControl.turn.remove_value(cyclecounter_Keeplist);
                        obj.attendantControl.speed = obj.attendantControl.speed.remove_value(cyclecounter_Keeplist);
                        attendantInControlArray = find(obj.data(4).values == 6);
                        if sum(attendantInControlArray)==0
                             delete(obj.findprop('attendantControl'));
                        else
                            obj.calculateAttendantOperatingTime(attendantInControlArray,obj.attendantControl.turn.values,obj.attendantControl.speed.values);
                        end
                    end
                case 176 % B0 TRIAL 1 IMU
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                    obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);
                    obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);
                    obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);
                case 177 % B1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                    obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);
                    obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);
                    obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);
                    obj.data(11) = obj.data(11).remove_value(cyclecounter_Keeplist);
                    obj.data(12) = obj.data(12).remove_value(cyclecounter_Keeplist);
                    obj.data(13) = obj.data(13).remove_value(cyclecounter_Keeplist);
                case 178 % B2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    
                case 192 % C0 TRIAL 1 GPS
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                case 193 % C1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                case 194 % C2
                case 195 % C3
                case 209 % D1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 210 % D2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 211 % D3
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    end
                case 212 % D4
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                        obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    end
                case 213 % D5
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                        obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                        obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    end
                case 214 % D6
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    if numel(obj.data,1)>1
                        obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                        obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                        obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                        obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    end
                case 215 % D7
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 216 % D8
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 225 % E1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                case 241 % F1
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                case 242 % F2
                    obj.data(1) = obj.data(1).remove_value(cyclecounter_Keeplist);
                    obj.data(2) = obj.data(2).remove_value(cyclecounter_Keeplist);
                    obj.data(3) = obj.data(3).remove_value(cyclecounter_Keeplist);
                    obj.data(4) = obj.data(4).remove_value(cyclecounter_Keeplist);
                    obj.data(5) = obj.data(5).remove_value(cyclecounter_Keeplist);
                    obj.data(6) = obj.data(6).remove_value(cyclecounter_Keeplist);
                    obj.data(7) = obj.data(7).remove_value(cyclecounter_Keeplist);
                    obj.data(8) = obj.data(8).remove_value(cyclecounter_Keeplist);
                    obj.data(9) = obj.data(9).remove_value(cyclecounter_Keeplist);
                    obj.data(10) = obj.data(10).remove_value(cyclecounter_Keeplist);
                    obj.data(11) = obj.data(11).remove_value(cyclecounter_Keeplist);
                    obj.data(12) = obj.data(12).remove_value(cyclecounter_Keeplist);
            end
        end
        
        %% ***************Filtering *******************        
        function obj = filter(obj,deadZone,FilterUnit)
            switch obj.datatype
                case 160 % A0 TRIAL 1 JOYSTICK
                    if (max(obj.data(2).values)- min(obj.data(2).values)>100) || (max(obj.data(3).values)- min(obj.data(3).values)>100)
                        R= 128;
                    else
                        R=100;
                    end
                    % declaration of filtered data
                    
                    if FilterUnit % percentage
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= R*deadZone/100 | abs(obj.data(3).values)>= R*deadZone/100);
                    else  % value
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= deadZone | abs(obj.data(3).values)>= deadZone);
                    end
                
                    if  sum(filter)>0
                        obj.filterSetting.startID = 8;                        
                        obj.filterSetting.deadZone = deadZone;
                        if FilterUnit % percentage
                            obj.filterSetting.unit = "%";
                        else % value
                            obj.filterSetting.unit = "bit(s)";
                        end                                               
                    else
                        obj.filterSetting.executed = false;
                        return;
                    end     
         
                case 161 % A1 JOYSTICK_DX2_OUTPUT
                    R= 128;
                    % declaration of filtered data
                    
                    if FilterUnit % percentage
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= R*deadZone/100 | abs(obj.data(3).values)>= R*deadZone/100);
                    else  % value
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= deadZone | abs(obj.data(3).values)>= deadZone);
                    end
                    
                                     
                    
                    if  sum(filter)>0
                        obj.filterSetting.startID = 8;
                        obj.filterSetting.deadZone = deadZone;
                        if FilterUnit % percentage
                            obj.filterSetting.unit = "%";
                        else % value
                            obj.filterSetting.unit = "bit(s)";
                        end
                    else
                        obj.filterSetting.executed = false;
                        return;
                    end
                                        
                case 162 % A2 JOYSTICK_PG_OUTPUT
                    R = 100;
                    % declaration of filtered data
                    if FilterUnit % percentage
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= R*deadZone/100 | abs(obj.data(3).values)>= R*deadZone/100);
                    else  % value
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= deadZone | abs(obj.data(3).values)>= deadZone);
                    end
                                        
                    if sum(filter)>0
                        obj.filterSetting.startID = 9;
                        obj.filterSetting.deadZone = deadzone;
                        if FilterUnit % percentage
                            obj.filterSetting.unit = "%";
                        else % value
                            obj.filterSetting.unit = "bit(s)";
                        end
                    else
                        obj.filterSetting.executed = false;
                        return;
                    end
                case 163 % A3 JOYSTICK_LINX_OUTPUT
                    R = 128;
                    
                    if FilterUnit % percentage
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= R*deadZone/100 | abs(obj.data(3).values)>= R*deadZone/100);
                    else  % value
                        filter = obj.removeConsecutiveZeros(2);
                        filter = filter & (abs(obj.data(2).values)>= deadZone | abs(obj.data(3).values)>= deadZone);
                    end
                    
                    
                    if sum(filter)>0
                        obj.filterSetting.startID = 8;  
                        obj.filterSetting.deadZone = deadzone;
                        if FilterUnit % percentage
                            obj.filterSetting.unit = "%";
                        else % value
                            obj.filterSetting.unit = "bit(s)";
                        end
                        
                    else
                        obj.filterSetting.executed = false;
                        return
                    end                    
                otherwise
                    warning("Not yet programmed");
                    return;
            end
            
            
            turnID = obj.filterSetting.startID;
            speedID= obj.filterSetting.startID +1;
            operatedID= obj.filterSetting.startID +2;
            boutsID = obj.filterSetting.startID +3;
            operatingTime = obj.filterSetting.startID +4;    
            
            if FilterUnit % percentage
                obj.data(turnID ) = classes.data("Turn (" + deadZone + "%)" ,"filt. %","int_8",size(obj.data(3).values,1));
                obj.data(speedID) = classes.data("Speed (" + deadZone + "%)" ,"filt. %","int_8",size(obj.data(3).values,1));
            else  % value
                obj.data(turnID) = classes.data("Turn (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
                obj.data(speedID) = classes.data("Speed (>" + deadZone + ")" ,"filt.","int_8",size(obj.data(3).values,1));
            end                   

            obj.data(operatedID) = classes.data("Filt. operated","bit","boolean",size(obj.data(3).values,1));
            obj.data(boutsID) = classes.data("Filt. bouts","bouts/measurement","boolean",1);
            obj.data(operatingTime) = classes.data("Filt. operating time","s","float_64",1);

            cycle = find(filter);
            % filtering Turn and speed                    
            obj.data(turnID ) = obj.data(turnID).filteredData(cycle, obj.data(2).values(filter));
            obj.data(speedID) = obj.data(speedID).filteredData(cycle, obj.data(3).values(filter));

            % cycleCounter = 1:size(obj.data(turnID).values,1);
            cycleCounterList = find(~isnan(obj.data(turnID).values) | ~isnan(obj.data(speedID).values));
            obj.joystickCalculations(operatedID,obj.data(turnID).values,obj.data(speedID).values,cycleCounterList);
            if isprop(obj,'attendantControl')
                if FilterUnit % percentage
                    filter = obj.removeStructureConsecutiveZeros(obj.attendantControl);
                    filter = filter & (abs(obj.attendantControl.turn.values)>= R*deadZone/100 | abs(obj.attendantControl.speed.values)>= R*deadZone/100);
                else  % value
                    filter = obj.removeStructureConsecutiveZeros(obj.attendantControl);
                    filter = filter & (abs(obj.attendantControl.turn.values)>= deadZone | abs(obj.attendantControl.speed.values)>= deadZone);
                end
                filteredAttendantInControlArray = find(filter);
                obj.createFilteredAttendantControl(filteredAttendantInControlArray);
            end
            if isprop(obj,'actuatorControl')
                if FilterUnit % percentage
                    filter = obj.removeStructureConsecutiveZeros(obj.actuatorControl);
                    filter = filter & (abs(obj.actuatorControl.turn.values)>= R*deadZone/100 | abs(obj.actuatorControl.speed.values)>= R*deadZone/100);
                else  % value
                    filter = obj.removeStructureConsecutiveZeros(obj.actuatorControl);
                    filter = filter & (abs(obj.actuatorControl.turn.values)>= deadZone | abs(obj.actuatorControl.speed.values)>= deadZone);
                end
                filteredActuatorInControlArray = find(filter);
                obj.createFilteredActuatorControl(filteredActuatorInControlArray);
            end
            obj.filterSetting.executed = true;
        end
        
        %%  *************** zero crossing function *******************
        function filterID  = removeConsecutiveZeros(obj,startIndex)
            % remove more than 3 consecutive [0,0] from the turn and speed
            [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,obj.data(startIndex).values,obj.data(startIndex+1).values);
            
            startZeroID(zeroCrossingIDs) = [];
            endZeroID(zeroCrossingIDs) = [];
            
            startZeroID = startZeroID+1;
            endZeroID = endZeroID-2;
            
            filterID = ones(numel(obj.data(startIndex).values),1);
            for i = 1: numel(startZeroID)
                filterID(startZeroID(i):endZeroID(i)) = 0;
            end
        end
        function filterID  = removeStructureConsecutiveZeros(obj,specificJoystickData)
            % remove more than 3 consecutive [0,0] from the turn and speed
            [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,specificJoystickData.turn.values,specificJoystickData.turn.values);
            
            startZeroID(zeroCrossingIDs) = [];
            endZeroID(zeroCrossingIDs) = [];
            
            startZeroID = startZeroID+1;
            endZeroID = endZeroID-2;
            
            filterID = ones(numel(specificJoystickData.turn.values),1);
            for i = 1: numel(startZeroID)
                filterID(startZeroID(i):endZeroID(i)) = 0;
            end
        end
        function [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,turn,speed)
            % Detect less or equal than 3 consecutive [0,0] from the turn and speed
            noMovementID = (turn == 0 & speed ==0) | (isnan(turn) & isnan(speed));           
            diffNoMovement = [0; diff(noMovementID)]; 
            
            startZeroID = find(diffNoMovement==1);
            endZeroID = find(diffNoMovement==-1);
            
            if ~isempty(endZeroID) && ~isempty(startZeroID) && endZeroID(1)< startZeroID(1)
                startZeroID = [1; startZeroID];
            end
            if ~isempty(endZeroID) && ~isempty(startZeroID) && endZeroID(end)< startZeroID(end)
                endZeroID(end+1) = length(noMovementID);
            end
            zeroCrossingIDs = (endZeroID - startZeroID)<=3;            
        end
        
        %%  *************** export function *******************
        function out = export(obj)
            % Under construction
            switch obj.datatype
                case 161 % A1
                case 162 % A2
                case 163 % A3
                    out= obj.data(1).values';
                case 177 % B1
                case 178 % B2
                case 193 % C1
                case 194 % C2
                case 195 % C3
                case 209 % D1
                case 210 % D2
                case 211 % D3
                case 212 % D4
                case 213 % D5
                case 214 % D6
                case 215 % D7
                case 225 % E1
                case 241 % F1
                case 242 % F2
            end
        end
        
        %%  *************** Import Trial 1 Instrument *******************
        function obj = importTrial1Instrument(obj,cyclecounter_list,trialData)
            switch obj.datatype
                case 160 % TRIAL 1 JOYSTICK
                    if sum(ismember(trialData.Properties.VariableNames,'actuatormode'))
                        obj.data(1) = obj.data(1).add_trial1Data(cyclecounter_list,trialData.actuatormode);
                    end
                    obj.data(2) = obj.data(2).add_trial1Data(cyclecounter_list,trialData.turn);
                    obj.data(3) = obj.data(3).add_trial1Data(cyclecounter_list,trialData.speed);
                    obj.data(4) = obj.data(4).add_trial1Data(cyclecounter_list,trialData.profile);
                    
                    % calculate operation, operation time and bouts
                    obj.joystickCalculations(5,trialData.turn, trialData.speed,cyclecounter_list);
                    
                    
                    
         
                case 176 % B0 TRIAL 1 IMU with temperature
                    obj.data(1) = obj.data(1).add_trial1Data(cyclecounter_list,trialData.ax);
                    obj.data(2) = obj.data(2).add_trial1Data(cyclecounter_list,trialData.ay);
                    obj.data(3) = obj.data(3).add_trial1Data(cyclecounter_list,trialData.az);
                    obj.data(4) = obj.data(4).add_trial1Data(cyclecounter_list,trialData.gx);
                    obj.data(5) = obj.data(5).add_trial1Data(cyclecounter_list,trialData.gy);
                    obj.data(6) = obj.data(6).add_trial1Data(cyclecounter_list,trialData.gz);
                    obj.data(7) = obj.data(7).add_trial1Data(cyclecounter_list,trialData.mx);
                    obj.data(8) = obj.data(8).add_trial1Data(cyclecounter_list,trialData.my);
                    obj.data(9) = obj.data(9).add_trial1Data(cyclecounter_list,trialData.mz);
                    if sum(ismember(trialData.Properties.VariableNames,'imu_temperature'))
                        ignoreZeroIndices = trialData.imu_temperature~=0;
                        obj.data(10) =obj.data(10).add_trial1Data(cyclecounter_list(ignoreZeroIndices),trialData.imu_temperature(ignoreZeroIndices));
                    end
                case 192 % C0 TRIAL 1 GPS WITH CLOCK
                    obj.data(1) = obj.data(1).add_trial1Data(cyclecounter_list,trialData.longitude);
                    obj.data(2) = obj.data(2).add_trial1Data(cyclecounter_list,trialData.latitude);
                    obj.data(3) = obj.data(3).add_trial1Data(cyclecounter_list,trialData.altitude);
                    obj.data(4) = obj.data(4).add_trial1Data(cyclecounter_list,trialData.n_sats);
                    obj.data(5) = obj.data(5).add_trial1Data(cyclecounter_list,trialData.gps_hour);
                    obj.data(6) = obj.data(6).add_trial1Data(cyclecounter_list,trialData.gps_min);
                    obj.data(7) = obj.data(7).add_trial1Data(cyclecounter_list,trialData.gps_sec);
                otherwise
                    error("Datatype unsupported");
            end
        end
        
        %%  *************** Actuator control *******************
        function obj = createActuatorControl(obj,actuatorControlArray)
            % Create actuatorControl structure
            % Copy the joystick data when actuator mode equals 1
            % because joystick controls now the actuators instead of
            % the motors
            %
            %Declaration
            if( ~isprop(obj,'actuatorControl'))
                obj.addprop('actuatorControl');
            end
            maxCycleCount = numel(obj.data(3).values);
            obj.actuatorControl.turn = classes.data("Turn","raw","int_8",maxCycleCount);
            obj.actuatorControl.speed = classes.data("Speed","raw","int_8",maxCycleCount);
            obj.actuatorControl.profile = classes.data("Profile","number","int_8",maxCycleCount);
            obj.actuatorControl.operated = classes.data("Operated","bit","boolean",maxCycleCount);
            obj.actuatorControl.bouts = classes.data("Bouts","bouts/measurement","boolean",1);
            obj.actuatorControl.operatingTime = classes.data("Operating time","s","float_64",1);
            
            %Copy turn and speed to actuatorControl when actuator mode is
            %active
            obj.actuatorControl.turn = obj.actuatorControl.turn.add_trial1Data(actuatorControlArray,obj.data(2).values(actuatorControlArray));
            obj.actuatorControl.speed = obj.actuatorControl.speed.add_trial1Data(actuatorControlArray,obj.data(3).values(actuatorControlArray));
            obj.actuatorControl.profile = obj.actuatorControl.profile.add_trial1Data(actuatorControlArray,obj.data(4).values(actuatorControlArray));
     
            
            %Set Turn and speed in Instrument to zero when actuator mode is
            %active
            obj.data(2).values(actuatorControlArray) = nan;
            obj.data(3).values(actuatorControlArray) = nan;
            obj.data(4).values(actuatorControlArray) = nan;
            cycleCounterList = ~isnan(obj.data(2).values);
            % recalculate the operation time, operated and bauts
            if sum(~isnan(obj.data(2).values))>0 && sum (~isnan(obj.data(3).values))>0 
                obj.joystickCalculations(5,obj.data(2).values, obj.data(3).values,cycleCounterList);
            end
            obj.calculateActuatorOperatingTime(actuatorControlArray,obj.actuatorControl.turn.values,obj.actuatorControl.speed.values);
        end        
        
        function obj = calculateActuatorOperatingTime(obj,actuatorControlArray,blobTurn,blobSpeed)
            
            if length(obj.actuatorControl.operated.values)>1 && length(blobTurn) < length(obj.actuatorControl.operated.values)
                obj.actuatorControl.operated = obj.actuatorControl.operated.resize(1,length(blobTurn));
                obj.actuatorControl.operated = obj.actuatorControl.operated.clear_value();
            end
            % operated bit
             measuredCyclesIDs = ~isnan(blobTurn) & ~isnan(blobSpeed);
             
            % adjust turn and speed when less or equal than 3 consecutive [0,0] from the turn and speed
            [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,blobTurn,blobSpeed);
            
            startZeroID = startZeroID(zeroCrossingIDs);
            endZeroID =  endZeroID(zeroCrossingIDs)-1;
            
            for i = 1: numel(startZeroID)
                blobTurn(startZeroID(i):endZeroID(i)) = 255;
                blobSpeed(startZeroID(i):endZeroID(i)) = 255;
            end
                        
         
            % calculate operated bit.
             if numel(blobTurn) >= 1 && numel(blobSpeed)>=1  &&  sum((measuredCyclesIDs))>0
                operatedBit  = zeros(numel(blobTurn),0);
                operatedBit(measuredCyclesIDs,1) = (blobTurn(measuredCyclesIDs) ~= 0 | blobSpeed(measuredCyclesIDs) ~= 0);
                obj.actuatorControl.operated = obj.actuatorControl.operated.add_trial1Data(actuatorControlArray,operatedBit(measuredCyclesIDs));
                
                % Bouts calculation       
                flankDet = [operatedBit ;0]- [0; operatedBit];
                obj.actuatorControl.bouts = obj.actuatorControl.bouts.add_trial1Data(1,sum(flankDet(flankDet>0)));
                % Operating time
                obj.actuatorControl.operatingTime = obj.actuatorControl.operatingTime.add_trial1Data(1,(sum(obj.actuatorControl.operated.values(measuredCyclesIDs))-1)*0.02);
             end
            

        end
        
        %filtered
        function obj = createFilteredActuatorControl(obj,actuatorControlArray)
            % Create actuatorControl structure
            % Copy the joystick data when actuator mode equals 1
            % because joystick controls now the actuators instead of
            % the motors
            %
            %Declaration
            if( ~isprop(obj,'actuatorControl'))
                obj.addprop('actuatorControl');
            end
            maxCycleCount = numel(obj.data(3).values);
            obj.actuatorControl.filtered.turn = classes.data("Turn","raw","int_8",maxCycleCount);
            obj.actuatorControl.filtered.speed = classes.data("Speed","raw","int_8",maxCycleCount);
            obj.actuatorControl.filtered.profile = classes.data("Profile","number","int_8",maxCycleCount);
            obj.actuatorControl.filtered.operated = classes.data("Operated","bit","boolean",maxCycleCount);
            obj.actuatorControl.filtered.bouts = classes.data("Bouts","bouts/measurement","boolean",1);
            obj.actuatorControl.filtered.operatingTime = classes.data("Operating time","s","float_64",1);
            
            %Copy turn and speed to actuatorControl when actuator mode is
            %active
            obj.actuatorControl.filtered.turn = obj.actuatorControl.filtered.turn.add_trial1Data(actuatorControlArray, obj.actuatorControl.turn.values(actuatorControlArray));
            obj.actuatorControl.filtered.speed = obj.actuatorControl.filtered.speed.add_trial1Data(actuatorControlArray,obj.actuatorControl.speed.values(actuatorControlArray));
            obj.actuatorControl.filtered.profile = obj.actuatorControl.filtered.profile.add_trial1Data(actuatorControlArray,obj.actuatorControl.profile.values(actuatorControlArray));
     
            
           
            obj.calculateFilteredActuatorOperatingTime(actuatorControlArray,obj.actuatorControl.filtered.turn.values,obj.actuatorControl.filtered.speed.values);
        end        
        
        function obj = calculateFilteredActuatorOperatingTime(obj,actuatorControlArray,blobTurn,blobSpeed)
            
            if length(obj.actuatorControl.filtered.operated.values)>1 && length(blobTurn) < length(obj.actuatorControl.filtered.operated.values)
                obj.actuatorControl.filtered.operated = obj.actuatorControl.filtered.operated.resize(1,length(blobTurn));
                obj.actuatorControl.filtered.operated = obj.actuatorControl.filtered.operated.clear_value();
            end
            % operated bit
             measuredCyclesIDs = ~isnan(blobTurn) & ~isnan(blobSpeed);
             
            % adjust turn and speed when less or equal than 3 consecutive [0,0] from the turn and speed
            [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,blobTurn,blobSpeed);
            
            startZeroID = startZeroID(zeroCrossingIDs);
            endZeroID =  endZeroID(zeroCrossingIDs)-1;
            
            for i = 1: numel(startZeroID)
                blobTurn(startZeroID(i):endZeroID(i)) = 255;
                blobSpeed(startZeroID(i):endZeroID(i)) = 255;
            end
                        
         
            % calculate operated bit.
             if numel(blobTurn) >= 1 && numel(blobSpeed)>=1  &&  sum((measuredCyclesIDs))>0
                operatedBit  = zeros(numel(blobTurn),0);
                operatedBit(measuredCyclesIDs,1) = (blobTurn(measuredCyclesIDs) ~= 0 | blobSpeed(measuredCyclesIDs) ~= 0);
                obj.actuatorControl.filtered.operated = obj.actuatorControl.filtered.operated.add_trial1Data(measuredCyclesIDs,operatedBit(measuredCyclesIDs));
                
                % Bouts calculation       
                flankDet = [operatedBit ;0]- [0; operatedBit];
                obj.actuatorControl.filtered.bouts = obj.actuatorControl.filtered.bouts.add_trial1Data(1,sum(flankDet(flankDet>0)));
                % Operating time
                obj.actuatorControl.filtered.operatingTime = obj.actuatorControl.filtered.operatingTime.add_trial1Data(1,(sum(obj.actuatorControl.operated.values(measuredCyclesIDs))-1)*0.02);
             end
            

        end
        
        %%  *************** Attendant control *******************
        
        function obj = createAttendantControl(obj,cyclecounter_list,attendantInControlArray)
            % Create actuatorControl structure
            % Copy the joystick data when actuator mode equals 1
            % because joystick controls now the actuators instead of
            % the motors
            %
            %Declaration
            if( ~isprop(obj,'attendantControl'))
                obj.addprop('attendantControl');
                maxCycleCount = numel(obj.data(3).values);
                obj.attendantControl.turn  = classes.data("Turn","raw","int_8",maxCycleCount);
                obj.attendantControl.speed = classes.data("Speed","raw","int_8",maxCycleCount);
                
                obj.attendantControl.operated = classes.data("Operated","bit","boolean",maxCycleCount);
                obj.attendantControl.bouts = classes.data("Bouts","bouts/measurement","boolean",1);
                obj.attendantControl.operatingTime = classes.data("Operating time","s","float_64",1);

                %Copy turn and speed to actuatorControl when actuator mode is
                %active
                obj.attendantControl.turn = obj.attendantControl.turn.add_trial1Data(attendantInControlArray,obj.data(2).values(attendantInControlArray));
                obj.attendantControl.speed = obj.attendantControl.speed.add_trial1Data(attendantInControlArray,obj.data(3).values(attendantInControlArray));

                %Set Turn and speed in Instrument to zero when actuator mode is
                %active
                obj.data(2).values(attendantInControlArray) = nan;
                obj.data(3).values(attendantInControlArray) = nan;
                obj.data(4).values(attendantInControlArray) = nan;
                cycleCounterList = ~isnan(obj.data(2).values);
                % recalculate the operation time, operated and bauts
                obj.joystickCalculations(5,obj.data(2).values, obj.data(3).values,cycleCounterList);
                 obj.calculateAttendantOperatingTime(attendantInControlArray,obj.attendantControl.turn.values,obj.attendantControl.speed.values);
                 
            end
        end
        
        function obj = calculateAttendantOperatingTime(obj,AttendantControlArray,blobTurn,blobSpeed)
            if length(obj.attendantControl.operated.values)>1 && length(blobTurn) < length(obj.attendantControl.operated.values)
                obj.attendantControl.operated = obj.attendantControl.operated.resize(1,length(obj.attendantControl.turn.values));                    
                obj.attendantControl.operated = obj.attendantControl.operated.clear_value();
            end
            % operated bit
             measuredCyclesIDs = ~isnan(blobTurn) & ~isnan(blobSpeed);
             if numel(blobTurn) >= 1 && numel(blobSpeed)>=1  &&  sum(~isnan(blobTurn) & ~isnan(blobSpeed))>0
                % adjust turn and speed when less or equal than 3 consecutive [0,0] from the turn and speed
                [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,blobTurn,blobSpeed);

                startZeroID = startZeroID(zeroCrossingIDs);
                endZeroID =  endZeroID(zeroCrossingIDs)-1;

                for i = 1: numel(startZeroID)
                    blobTurn(startZeroID(i):endZeroID(i)) = 255;
                    blobSpeed(startZeroID(i):endZeroID(i)) = 255;
                end
                        
         
                % calculate operated bit.
             
                operatedBit  = zeros(numel(blobTurn),0);
                operatedBit(measuredCyclesIDs,1) = (blobTurn(measuredCyclesIDs) ~= 0 | blobSpeed(measuredCyclesIDs) ~= 0);
                obj.attendantControl.operated = obj.attendantControl.operated.add_trial1Data(AttendantControlArray,operatedBit(measuredCyclesIDs));
                
                % Bouts calculation       
                flankDet = [operatedBit ;0]- [0; operatedBit];
                obj.attendantControl.bouts = obj.attendantControl.bouts.add_trial1Data(1,sum(flankDet(flankDet>0)));
                % Operating time
                obj.attendantControl.operatingTime = obj.attendantControl.operatingTime.add_trial1Data(1,(sum(obj.attendantControl.operated.values(measuredCyclesIDs))-1)*0.02); 
             end 
        end
        
        function obj = createFilteredAttendantControl(obj,attendantInControlArray)
            % Create actuatorControl structure
            % Copy the joystick data when actuator mode equals 1
            % because joystick controls now the actuators instead of
            % the motors
            %
            %Declaration
            if( isprop(obj,'attendantControl'))
                maxCycleCount = numel(obj.data(3).values);
                obj.attendantControl.filtered.turn  = classes.data("Turn","raw","int_8",maxCycleCount);
                obj.attendantControl.filtered.speed = classes.data("Speed","raw","int_8",maxCycleCount);
                
                obj.attendantControl.filtered.operated = classes.data("Operated","bit","boolean",maxCycleCount);
                obj.attendantControl.filtered.bouts = classes.data("Bouts","bouts/measurement","boolean",1);
                obj.attendantControl.filtered.operatingTime = classes.data("Operating time","s","float_64",1);

                %Copy turn and speed to actuatorControl when actuator mode is
                %active
                obj.attendantControl.filtered.turn = obj.attendantControl.filtered.turn.add_trial1Data(attendantInControlArray,obj.attendantControl.turn.values(attendantInControlArray));
                obj.attendantControl.filtered.speed = obj.attendantControl.filtered.speed.add_trial1Data(attendantInControlArray,obj.attendantControl.speed.values(attendantInControlArray));

                
                % recalculate the operation time, operated and bauts
                 obj.calculateFilteredAttendantOperatingTime(attendantInControlArray,obj.attendantControl.filtered.turn.values,obj.attendantControl.filtered.speed.values);
                 
            end
        end
        
         function obj = calculateFilteredAttendantOperatingTime(obj,AttendantControlArray,blobTurn,blobSpeed)
            if length(obj.attendantControl.filtered.operated.values)>1 && length(blobTurn) < length(obj.attendantControl.filtered.operated.values)
                obj.attendantControl.filtered.operated = obj.attendantControl.filtered.operated.resize(1,length(obj.attendantControl.turn.values));                    
                obj.attendantControl.filtered.operated = obj.attendantControl.filtered.operated.clear_value();
            else 
                obj.attendantControl.filtered.operated = obj.attendantControl.filtered.operated.clear_value();
            end
            % operated bit
             measuredCyclesIDs = ~isnan(blobTurn) & ~isnan(blobSpeed);
             if numel(blobTurn) >= 1 && numel(blobSpeed)>=1  &&  sum(~isnan(blobTurn) & ~isnan(blobSpeed))>0
                % adjust turn and speed when less or equal than 3 consecutive [0,0] from the turn and speed
                [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,blobTurn,blobSpeed);

                startZeroID = startZeroID(zeroCrossingIDs);
                endZeroID =  endZeroID(zeroCrossingIDs)-1;

                for i = 1: numel(startZeroID)
                    blobTurn(startZeroID(i):endZeroID(i)) = 255;
                    blobSpeed(startZeroID(i):endZeroID(i)) = 255;
                end
                        
         
                % calculate operated bit.
             
                operatedBit  = zeros(numel(blobTurn),0);
                operatedBit(measuredCyclesIDs,1) = (blobTurn(measuredCyclesIDs) ~= 0 | blobSpeed(measuredCyclesIDs) ~= 0);
                obj.attendantControl.filtered.operated = obj.attendantControl.filtered.operated.add_trial1Data(measuredCyclesIDs,operatedBit(measuredCyclesIDs));
                
                % Bouts calculation       
                flankDet = [operatedBit ;0]- [0; operatedBit];
                obj.attendantControl.filtered.bouts = obj.attendantControl.filtered.bouts.add_trial1Data(1,sum(flankDet(flankDet>0)));
                % Operating time
                obj.attendantControl.filtered.operatingTime = obj.attendantControl.filtered.operatingTime.add_trial1Data(1,(sum(obj.attendantControl.filtered.operated.values(measuredCyclesIDs))-1)*0.02); 
             end 
        end
            
        function profileOperatingTime = profileOperatingTime(obj,profileArray,profineNr, operatedBitArray)
            profileOperatingTime = round((sum(profileArray==profineNr & operatedBitArray ==1)-1)*0.02 ,2);
            if profileOperatingTime < 0
                profileOperatingTime = 0;
            end
        end
        %%  *************** plot function *******************
        function obj = plot_all(obj,measureID,startTime,showHeatMap,standardHeatmap,variableScale,showJoystickPath,plotDownSample,downSampleFactor, showDistSubs,showGPS,fontSize)
            % plot all the sensordata object of the instrument.
            % It plots with the following settings:
            % - Font size= 20
            % - Plots on fullscreen figure
            % - X-axis is linked with the other subplots
            % - The axes hava a default axis font size of 18 or 14.
            % - The figures gets a title in the format:
            %   -   starttime - measurement ID: xx -
        
            if obj.datatype ==193 && showGPS >0 || obj.datatype ~=193
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
            else
                return
            end
            switch obj.datatype
                case 160 % A0 TRIAL 1  JOYSTICK
                    if (max(obj.data(2).values)- min(obj.data(2).values)>100) || (max(obj.data(3).values)- min(obj.data(3).values)>100)
                        R= 128;
                    else
                        R=100;
                    end
                    subplotArray(1) =  subplot(3,1,1);
                    obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) =  subplot(3,1,2);
                    obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                     
%                     text(startTime+ seconds(1),5, "Operating time: " + round(sum(obj.data(2).values~=0 | obj.data(3).values~=0)*0.02,2) + " s",'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
%                         
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    
                    % plot profiles and actuator mode if actuator is filled
                    % with data
                    if sum(isnan(obj.data(1).values))~=numel(obj.data(1).values)
                        subplotArray=[];
                        figure();
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(2,1,1);
                        p=obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        p.Marker= '*';
                        if isprop(obj,'actuatorControl') && ~isempty(obj.actuatorControl.operatingTime)
                            text(startTime+ seconds(1),0.5, "Actuator Operating time: " + round(obj.actuatorControl.operatingTime.values,2) + " s",'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        end
                        subplotArray(2) = subplot(2,1,2);
                        obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        Title = [obj.name newline  ' actuator - ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                    
                    % ----- Plot separated  speed and turn
                    if isprop(obj,'actuatorControl')
                        obj.plotJoystickSpeedTurn(obj.actuatorControl, measureID, 'Actuator Control',startTime,fontSize);
                        if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                             obj.plotJoystickSpeedTurn(obj.actuatorControl.filtered, measureID, 'Filtered actuator Control',startTime,fontSize);
                        end  
                    end
                    if isprop(obj,'attendantControl')
                        obj.plotJoystickSpeedTurn(obj.attendantControl, measureID, 'Attendant Control',startTime,fontSize);
                        if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                             obj.plotJoystickSpeedTurn(obj.attendantControl.filtered, measureID, 'Filtered attendant Control',startTime,fontSize);
                        end  
                        
                    end
                    
                    disp("---------  operating times in specific profile ---------")
                    profile = [0; 1; 2; 3; 4; 5; "total user";"attendant control" ];
                    OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(5).values);
                    OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(5).values);
                    OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(5).values);
                    OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(5).values);
                    OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(5).values);
                    OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(5).values); 
                    OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)) ,2);
                     if isprop(obj,'attendantControl')
                        OperatingTimeInSec(8,1) = round(sum(obj.attendantControl.operated.values==1)*0.02  ,2);
                     else
                        OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(5).values);
                     end         
                     
                    if isprop(obj,'actuatorControl')
                        disp(strcat("Actuator operating time: ", string(obj.actuatorControl.operatingTime.values)," s"))
                       
                        actuatorOperatingTimeInSec = zeros(8,1);
                        actuatorOperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.actuatorControl.profile.values,0, obj.actuatorControl.operated.values);
                        actuatorOperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.actuatorControl.profile.values,1, obj.actuatorControl.operated.values);
                        actuatorOperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.actuatorControl.profile.values,2, obj.actuatorControl.operated.values);
                        actuatorOperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.actuatorControl.profile.values,3, obj.actuatorControl.operated.values);
                        actuatorOperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.actuatorControl.profile.values,4, obj.actuatorControl.operated.values);
                        actuatorOperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.actuatorControl.profile.values,5, obj.actuatorControl.operated.values);                                          
                        actuatorOperatingTimeInSec(7,1) = round(sum(actuatorOperatingTimeInSec(1:6)),2);
                        if isprop(obj,'attendantControl')
                            actuatorOperatingTimeInSec(8,1) =nan;
                        else
                            actuatorOperatingTimeInSec(8,1) = round(sum(obj.actuatorControl.profile.values==6 & obj.actuatorControl.operated.values ==1)*0.02 ,2);                          
                        end      
                        
                        summationPerProfileTimeInSec(1,1) = round(OperatingTimeInSec(1,1)+ actuatorOperatingTimeInSec(1,1) ,2);
                        summationPerProfileTimeInSec(2,1) = round(OperatingTimeInSec(2,1)+ actuatorOperatingTimeInSec(2,1) ,2);
                        summationPerProfileTimeInSec(3,1) = round(OperatingTimeInSec(3,1)+ actuatorOperatingTimeInSec(3,1) ,2);
                        summationPerProfileTimeInSec(4,1) = round(OperatingTimeInSec(4,1)+ actuatorOperatingTimeInSec(4,1) ,2);
                        summationPerProfileTimeInSec(5,1) = round(OperatingTimeInSec(5,1)+ actuatorOperatingTimeInSec(5,1) ,2);
                        summationPerProfileTimeInSec(6,1) = round(OperatingTimeInSec(6,1)+ actuatorOperatingTimeInSec(6,1) ,2);  
                        summationPerProfileTimeInSec(7,1) = round(sum(summationPerProfileTimeInSec(1:6)),2);
                        if isprop(obj,'attendantControl')
                            summationPerProfileTimeInSec(8,1) =nan;
                        else
                           summationPerProfileTimeInSec(8,1) = round(OperatingTimeInSec(8,1)+ actuatorOperatingTimeInSec(8,1) ,2);
                        end   
                        table(profile,OperatingTimeInSec,actuatorOperatingTimeInSec,summationPerProfileTimeInSec)
%                         obj.Heatmp('Actuator',obj.actuatorControl.turn.values,obj.actuatorControl.speed.values,R,standardHeatmap,variableScale,true,fontSize);
%                         % ------ Adjustable heatmap ------
%                         gridSize =evalin('base', 'gridSize');
%                         obj.Heatmp('Actuator',obj.actuatorControl.turn.values,obj.actuatorControl.speed.values,R,gridSize,variableScale,false,fontSize);
                    else
                        table(profile,OperatingTimeInSec)
                    end
                    
                    
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        disp("---------  Filtered operating times in specific profile ---------")
                        profile = [0; 1; 2; 3; 4; 5; "total  user";"attendant control"];
                        OperatingTimeInSec = zeros(8,1);
                        OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(10).values);
                        OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(10).values);
                        OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(10).values);
                        OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(10).values);
                        OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(10).values);
                        OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(10).values);
                        OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)),2);                        
                        if isprop(obj,'attendantControl')
                            OperatingTimeInSec(8,1) = round(sum(obj.attendantControl.filtered.operated.values==1)*0.02  ,2);
                        else
                             OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(10).values);
                        end  
                        
                        if isprop(obj,'actuatorControl')
                                actuatorOperatingTimeInSec = zeros(8,1);
                                summationPerProfileTimeInSec = zeros(8,1);
                                actuatorOperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.actuatorControl.filtered.profile.values,0, obj.actuatorControl.filtered.operated.values); 
                                actuatorOperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.actuatorControl.filtered.profile.values,1, obj.actuatorControl.filtered.operated.values); 
                                actuatorOperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.actuatorControl.filtered.profile.values,2, obj.actuatorControl.filtered.operated.values); 
                                actuatorOperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.actuatorControl.filtered.profile.values,3, obj.actuatorControl.filtered.operated.values); 
                                actuatorOperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.actuatorControl.filtered.profile.values,4, obj.actuatorControl.filtered.operated.values); 
                                actuatorOperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.actuatorControl.filtered.profile.values,5, obj.actuatorControl.filtered.operated.values); 
                                actuatorOperatingTimeInSec(7,1) = round(sum(actuatorOperatingTimeInSec(1:6)),2);
                                if isprop(obj,'attendantControl')
                                    actuatorOperatingTimeInSec(8,1) =nan;
                                else
                                    actuatorOperatingTimeInSec(8,1) = round(sum(obj.actuatorControl.profile.values==6 & obj.actuatorControl.operated.values ==1)*0.02 ,2);                          
                                end 
                                
                                summationPerProfileTimeInSec(1,1) = round(OperatingTimeInSec(1,1)+ actuatorOperatingTimeInSec(1,1) ,2);
                        summationPerProfileTimeInSec(2,1) = round(OperatingTimeInSec(2,1)+ actuatorOperatingTimeInSec(2,1) ,2);
                        summationPerProfileTimeInSec(3,1) = round(OperatingTimeInSec(3,1)+ actuatorOperatingTimeInSec(3,1) ,2);
                        summationPerProfileTimeInSec(4,1) = round(OperatingTimeInSec(4,1)+ actuatorOperatingTimeInSec(4,1) ,2);
                        summationPerProfileTimeInSec(5,1) = round(OperatingTimeInSec(5,1)+ actuatorOperatingTimeInSec(5,1) ,2);
                        summationPerProfileTimeInSec(6,1) = round(OperatingTimeInSec(6,1)+ actuatorOperatingTimeInSec(6,1) ,2);  
                        summationPerProfileTimeInSec(7,1) = round(sum(summationPerProfileTimeInSec(1:6)),2);
                        if isprop(obj,'attendantControl')
                            summationPerProfileTimeInSec(8,1) =nan;
                        else
                           summationPerProfileTimeInSec(8,1) = round(OperatingTimeInSec(8,1)+ actuatorOperatingTimeInSec(8,1) ,2);
                        end   
                        
                                table(profile,OperatingTimeInSec,actuatorOperatingTimeInSec,summationPerProfileTimeInSec)
                        else
                          table(profile,OperatingTimeInSec)
                        end
                        
                        
                    end
                  
                    
                    % *************** Deflections Pattern ****************
                    obj.DeflectionsPattern('',obj.data(2), obj.data(3), fontSize,plotDownSample,downSampleFactor);
                    if isprop(obj,'actuatorControl')
                        obj.DeflectionsPattern('Actuator',obj.actuatorControl.turn, obj.actuatorControl.speed, fontSize,plotDownSample,downSampleFactor);
                    end
                    
                    
                    % *************** heatmap ****************
                    % ------ RAW  ------
                    if showHeatMap(1)
                        % ------ Standard heatmap ------
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,R,standardHeatmap,variableScale,false,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,R,gridSize,variableScale,false,fontSize);
                    end
                    % ------ Filtered  ------
                    if showHeatMap(2) && isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        % ------ Standard heatmap ------
                        obj.Heatmp('filtered',obj.data(8).values,obj.data(9).values,R,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('Filtered',obj.data(8).values,obj.data(9).values,R,gridSize,variableScale,true,fontSize);
                    end
                    if showHeatMap(3) && isprop(obj,'actuatorControl') && ~isempty(obj.actuatorControl) 
                        % ------ Standard heatmap ------
                        obj.Heatmp('Actuator',obj.actuatorControl.turn.values,obj.actuatorControl.speed.values,R,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('Actuator',obj.actuatorControl.turn.values,obj.actuatorControl.speed.values,R,gridSize,variableScale,true,fontSize);
                        if showHeatMap(2) && isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                            % ------ Standard heatmap ------
                            obj.Heatmp('FilteredActuator',obj.actuatorControl.filtered.turn.values,obj.actuatorControl.filtered.speed.values,R,standardHeatmap,variableScale,true,fontSize);

                            % ------ Adjustable heatmap ------
                            gridSize =evalin('base', 'gridSize');
                            obj.Heatmp('FilteredActuator',obj.actuatorControl.filtered.turn.values,obj.actuatorControl.filtered.speed.values,R,gridSize,variableScale,true,fontSize);
                        end
                    end
                    
                    % ************** Operate plot **************
                    figure();
                    subplotArray=[];
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    xL=xlim;
                    yL=ylim;
                    text(xL(2),1.2*yL(2),string(obj.data(6).values) + " " + obj.data(6).unit ,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                    text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(7).values) + " " + obj.data(7).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    % ---------- Filtered ------------
                    if  isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        figure();
                        subplotArray=[];
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        xL=xlim;
                        yL=ylim;
                        text(xL(2),1.2*yL(2),string(obj.data(11).values) + " " + obj.data(11).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                        text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(12).values) + " " + obj.data(12).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(3) =  subplot(3,1,3);
                        obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        Title = [obj.name newline  '- ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                        
                    if isprop(obj,'actuatorControl')
                                  % ************** Operate plot **************
                            figure();
                            subplotArray=[];
                            set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                            set(0, 'DefaultAxesFontSize', fontSize);
                            subplotArray(1) = subplot(3,1,1);
                            obj.actuatorControl.operated.plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                            xL=xlim;
                            yL=ylim;
                            text(xL(2),1.2*yL(2),string(obj.actuatorControl.bouts.values) + " " + obj.actuatorControl.bouts.unit ,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                            text(xL(1),1.2*yL(2),"Actuator operating time: " + string(obj.actuatorControl.operatingTime.values) + " " + obj.actuatorControl.operatingTime.unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                            subplotArray(2) = subplot(3,1,2);
                            obj.actuatorControl.turn.plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                            subplotArray(3) =  subplot(3,1,3);
                            obj.actuatorControl.speed.plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                            Title = ['Actuator control' newline  '- ' ...
                                datestr(startTime,'dd/mm/yyyy') ,...
                                ' - Measurement ID: ' num2str(measureID) ' - '];
                            try
                                sgtitle(Title,'fontsize',fontSize);
                            catch
                                suptitle(Title);
                            end
                            linkaxes(subplotArray,'x'); 
                    end
                    
                    
                case 161 % A1 JOYSTICK DX2
                    subplotArray(1) = subplot(2,3,1:3);
                    obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) =  subplot(2,3,4);
                    obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =  subplot(2,3,5);
                    obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(4) =  subplot(2,3,6);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    
                    if isprop(obj,'attendantControl')
                        obj.plotJoystickSpeedTurn(obj.attendantControl, measureID, 'Attendant Control',startTime,fontSize);
                    end
                    
                    disp("---------  operating times in specific profile ---------")
                  
                    profile = [0; 1; 2; 3; 4; 5;"total user";"attendant control"];
                    
                    OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(5).values);
                    OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(5).values);
                    OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(5).values);
                    OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(5).values);
                    OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(5).values);
                    OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(5).values);
                    OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)) ,2);
                    if isprop(obj,'attendantControl')
                        OperatingTimeInSec(8,1) = round(sum(obj.attendantControl.operated.values==1)*0.02  ,2);
                    else
                        OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(5).values);
                    end
                    table(profile,OperatingTimeInSec)
                    
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        disp("---------  Filtered operating times in specific profile ---------")
                       
                        OperatingTimeInSec = zeros(8,1);
                        OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(10).values);
                        OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(10).values);
                        OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(10).values);
                        OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(10).values);
                        OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(10).values);
                        OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(10).values);                        
                        OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)) ,2);
                        OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(10).values);
                        table(profile,OperatingTimeInSec)
                    end
                    
                    % *************** Deflections Pattern ****************
                    obj.DeflectionsPattern('',obj.data(2), obj.data(3), fontSize,plotDownSample,downSampleFactor);
                    
                    % *************** heatmap ****************
                    % ------ RAW  ------
                    if showHeatMap(1)
                        % ------ Standard heatmap ------
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,128,standardHeatmap,variableScale,false,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,128,gridSize,variableScale,false,fontSize);
                    end
                    % ------ Filtered  ------
                    if showHeatMap(2) && isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        % ------ Standard heatmap ------
                        obj.Heatmp('filtered',obj.data(8).values,obj.data(9).values,128,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('filtered',obj.data(8).values,obj.data(9).values,128,gridSize,variableScale,true,fontSize);
                    end
                    
                    % ************** Operate plot **************
                    figure();
                    subplotArray=[];
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    xL=xlim;
                    yL=ylim;
                    text(xL(2),1.2*yL(2),string(obj.data(6).values) + " " + obj.data(6).unit ,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                    text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(7).values) + " " + obj.data(7).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    % ---------- Filtered ------------
                    if  isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        figure();
                        subplotArray=[];
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        xL=xlim;
                        yL=ylim;
                        text(xL(2),1.2*yL(2),string(obj.data(11).values) + " " + obj.data(11).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                        text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(12).values) + " " + obj.data(12).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(3) =  subplot(3,1,3);
                        obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        Title = [obj.name newline  '- ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                    
                case 162 % A2 JOYSTICK PG
                    subplotArray(1) = subplot(2,4,1:4);
                    obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(2,4,5);
                    obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(2,4,6);
                    obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(4) = subplot(2,4,7);
                    obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(5) = subplot(2,4,8);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    Title =[obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    
                    if isprop(obj,'attendantControl')
                        obj.plotJoystickSpeedTurn(obj.attendantControl, measureID, 'Attendant Control',startTime,fontSize);
                    end
                    
                    disp("---------  operating times in specific profile ---------")
                   
                    profile = [0; 1; 2; 3; 4; 5; "total user";"attendant control"];
                    
                    OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(6).values);
                    OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(6).values);
                    OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(6).values);
                    OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(6).values);
                    OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(6).values);
                    OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(6).values);
                    OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)) ,2);
                    if isprop(obj,'attendantControl')
                        OperatingTimeInSec(8,1) = round(sum(obj.attendantControl.operated.values==1)*0.02  ,2);
                    else
                        OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(5).values);
                    end
                    table(profile,OperatingTimeInSec)
                    
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        disp("---------  Filtered operating times in specific profile ---------")
                        
                        OperatingTimeInSec = zeros(7,1);
                        OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(11).values);
                        OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(11).values);
                        OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(11).values);
                        OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(11).values);
                        OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(11).values);
                        OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(11).values);
                        OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)) ,2);
                        OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(10).values);
                        table(profile,OperatingTimeInSec)
                    end
                    
                    % *************** Deflections Pattern ****************
                    obj.DeflectionsPattern('',obj.data(2), obj.data(3), fontSize,plotDownSample,downSampleFactor);
                    
                    % *************** heatmap ****************
                    % ------ RAW  ------
                    if showHeatMap(1)
                        % ------ Standard heatmap ------
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,100,standardHeatmap,variableScale,false,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,100,gridSize,variableScale,false,fontSize);
                    end
                    
                    % ------ Filtered ------
                    if showHeatMap(2) &&  isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        % ------ Standard heatmap ------
                        obj.Heatmp('filtered',obj.data(9).values,obj.data(10).values,100,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap --------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('filtered',obj.data(9).values,obj.data(10).values,100,gridSize,variableScale,true,fontSize);
                    end
                    
                    % ************** Operate plot **************
                    figure();
                    subplotArray=[];
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(6).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    xL=xlim;
                    yL=ylim;
                    text(xL(2),1.2*yL(2),string(obj.data(7).values) + " " + obj.data(7).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                    text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(8).values) + " " + obj.data(8).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    % ---------- Filtered ------------
                    if  isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        figure();
                        subplotArray=[];
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        xL=xlim;
                        yL=ylim;
                        text(xL(2),1.2*yL(2),string(obj.data(12).values) + " " + obj.data(12).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                        text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(13).values) + " " + obj.data(13).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(3) =  subplot(3,1,3);
                        obj.data(10).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        Title = [obj.name newline  '- ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                    
                case 163 % A3 JOYSTICK LINX
                    subplotArray(1) = subplot(2,3,1:3);
                    obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) =subplot(2,3,4);
                    obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =subplot(2,3,5);
                    obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(4) =subplot(2,3,6);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    
                    if isprop(obj,'attendantControl')
                        obj.plotJoystickSpeedTurn(obj.attendantControl, measureID, 'Attendant Control',startTime,fontSize);
                    end
                    
                    disp("---------  operating times in specific profile ---------")
                    profile = [0; 1; 2; 3; 4; 5;"total user";"attendant control"];
                    OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(5).values);
                    OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(5).values);
                    OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(5).values);
                    OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(5).values);
                    OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(5).values);
                    OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(5).values);                    
                    OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)) ,2);
                    if isprop(obj,'attendantControl')
                        OperatingTimeInSec(8,1) = round(sum(obj.attendantControl.operated.values==1)*0.02  ,2);
                    else
                        OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(5).values);
                    end
                    table(profile,OperatingTimeInSec)
                    
                    if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        disp("---------  Filtered operating times in specific profile ---------")
                        OperatingTimeInSec = zeros(8,1);
                        OperatingTimeInSec(1,1) = obj.profileOperatingTime(obj.data(4).values,0, obj.data(10).values);
                        OperatingTimeInSec(2,1) = obj.profileOperatingTime(obj.data(4).values,1, obj.data(10).values);
                        OperatingTimeInSec(3,1) = obj.profileOperatingTime(obj.data(4).values,2, obj.data(10).values);
                        OperatingTimeInSec(4,1) = obj.profileOperatingTime(obj.data(4).values,3, obj.data(10).values);
                        OperatingTimeInSec(5,1) = obj.profileOperatingTime(obj.data(4).values,4, obj.data(10).values);
                        OperatingTimeInSec(6,1) = obj.profileOperatingTime(obj.data(4).values,5, obj.data(10).values);
                        OperatingTimeInSec(7,1) = round(sum(OperatingTimeInSec(1:6)) ,2);                        
                        OperatingTimeInSec(8,1) = obj.profileOperatingTime(obj.data(4).values,6, obj.data(10).values);
                        table(profile,OperatingTimeInSec)
                    end
                    
                    % *************** Deflections Pattern ****************
                    obj.DeflectionsPattern('',obj.data(2), obj.data(3), fontSize,plotDownSample,downSampleFactor);
                    
                    % *************** heatmap ****************
                    % ------ RAW  ------
                    if showHeatMap(1)
                        % ------ Standard heatmap ------
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,128,standardHeatmap,variableScale,false,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('',obj.data(2).values,obj.data(3).values,128,gridSize,variableScale,false,fontSize);
                    end
                    
                    % ------ Filtered ------
                    if showHeatMap(2) && isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        % ------ Standard heatmap ------
                        obj.Heatmp('filtered',obj.data(8).values,obj.data(9).values,128,standardHeatmap,variableScale,true,fontSize);
                        
                        % ------ Adjustable heatmap ------
                        gridSize =evalin('base', 'gridSize');
                        obj.Heatmp('filtered',obj.data(8).values,obj.data(9).values,128,gridSize,variableScale,true,fontSize);
                    end
                    
                    % ************** Operate plot **************
                    figure();
                    subplotArray=[];
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    xL=xlim;
                    yL=ylim;
                    text(xL(2),1.2*yL(2),string(obj.data(6).values) + " " + obj.data(6).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top');
                    text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(7).values) + " " + obj.data(7).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =  subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    % ---------- Filtered ------------
                    if  isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                        figure();
                        subplotArray=[];
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        xL=xlim;
                        yL=ylim;
                        text(xL(2),1.2*yL(2),string(obj.data(11).values) + " " + obj.data(11).unit,'fontsize',fontSize,'HorizontalAlignment','right','VerticalAlignment','top')
                        text(xL(1),1.2*yL(2),"Operating time: " + string(obj.data(12).values) + " " + obj.data(12).unit,'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(3) =  subplot(3,1,3);
                        obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        Title = [obj.name newline  '- ' ...
                            datestr(startTime,'dd/mm/yyyy') ,...
                            ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                    end
                case 176 % B0 TRIAL 1 IMU 9AXIS
                    % accelleration
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    %  Gyroscope
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    % Magnetometer
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(7).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % Temperature
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    p=obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    p.Marker = '*';
                case 177 % B1 IMU 9AXIS
                    % accelleration
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    %  Gyroscope
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    % Magnetometer
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(7).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(8).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(9).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    
                    % Quaternion
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(12).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(13).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    
                case 178 % B2 IMU 6AXIS
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime), ...
                        'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',fontSize+2);
                    catch
                        suptitle(Title);
                    end
                    figure();
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor, fontSize);
                    subplotArray(3) =subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                    linkaxes(subplotArray,'x');
                case 192 % C0 TRIAL 1 GPS
                    % plot gps if filled
                    if sum(isnan(obj.data(1).values))~=numel(obj.data(1).values)
                        if showGPS >0
                            subplotArray(1) = subplot(4,1,1);
                            obj.data(1).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                            subplotArray(2) = subplot(4,1,2);
                            obj.data(2).plot(startTime,true,true,false,plotDownSample,downSampleFactor, fontSize);
                            subplotArray(3) = subplot(4,1,3);
                            obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                            subplotArray(4) = subplot(4,1,4);
                            obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                            Title = [obj.name newline  '- ' ...
                                datestr(datetime(startTime), ...
                                'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                            try
                                sgtitle(Title,'fontsize',fontSize+2);
                            catch
                                suptitle(Title);
                            end
                            linkaxes(subplotArray,'x');
                            %                             figure();
                            %                             set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                            %                             set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                            %                             set(0, 'DefaultAxesFontSize', fontSize);
                            %
                            %
                            %                             subplotArray(3) =subplot(3,1,3);
                            %                             obj.data(5).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                            %                             linkaxes(subplotArray,'x');
                            %                             Title = [obj.name newline  '- ' ...
                            %                                 datestr(datetime(startTime), ...
                            %                                 'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                            %                             try
                            %                                 sgtitle(Title,'fontsize',fontSize+2);
                            %                             catch
                            %                                 suptitle(Title);
                            %                             end
                        end
                        if showGPS == 1 || showGPS == 3
                            figure()
                            set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                            set(0, 'DefaultAxesFontSize', fontSize);
                            indexLatNotZero = obj.data(2).values(:)~=0;
                            if sum(indexLatNotZero)~= numel(obj.data(2).values(:))
                                disp('PS locations with latitude equal to 0 are not shown but are present in the data')
                            end
                            if plotDownSample
                                factor = size(obj.data(2).values(indexLatNotZero),1)/downSampleFactor;
                                plt(obj.data(1).values(indexLatNotZero), obj.data(2).values(indexLatNotZero),'+','downsample',factor);
                                xlabel(obj.data(1).name);
                                ylabel(obj.data(2).name);
                            else
                                plot(obj.data(1).values(indexLatNotZero), obj.data(2).values(indexLatNotZero),'+','LineWidth',2);
                                Title = [obj.name newline  '- ' ...
                                    datestr(datetime(startTime), ...
                                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                                try
                                    sgtitle(Title,'fontsize',fontSize+2);
                                catch
                                    suptitle(Title);
                                end
                                xlabel('Longitude','fontsize',fontSize);
                                ylabel('lattitude','fontsize',fontSize);
                            end
                        end
                        if showGPS == 2 || showGPS == 3
                            % with satelitte view
                            figure()
                            set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                            set(0, 'DefaultAxesFontSize', fontSize);
                            indexLatNotZero = obj.data(2).values(:)~=0;
                            if sum(indexLatNotZero)~= numel(obj.data(2).values(:))
                                disp('PS locations with latitude equal to 0 are not shown but are present in the data')
                            end
                            gx =geoscatter(obj.data(2).values(indexLatNotZero), obj.data(1).values(indexLatNotZero));
                            gx.MarkerEdgeColor = 'r';
                            gx.LineWidth = 3;
                            if min(obj.data(2).values(indexLatNotZero))/max(obj.data(2).values(indexLatNotZero))<0.01
                                gx.LineWidth = 10;
                            end
                            gx.Parent.FontSize =fontSize;
                            geobasemap satellite
                            [latlim, lonlim] = geolimits;
                            geolimits([latlim(1)-0.0009 latlim(2)+0.0009],[lonlim(1)-0.0009 lonlim(2)+0.0009]) ;
                            Title = [obj.name newline  '- ' ...
                                datestr(datetime(startTime), ...
                                'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                            try
                                sgtitle(Title,'fontsize',fontSize+2);
                            catch
                                suptitle(Title);
                            end
                        end
                        
                    else
                        close;
                        disp('No GPS location data');
                    end
                    % plot gps clock if filled
                    if sum(isnan(obj.data(5).values))~=numel(obj.data(5).values)
                        subplotArray=[];
                        figure();
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(5).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(6).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(3) =subplot(3,1,3);
                        obj.data(7).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        linkaxes(subplotArray,'x');
                    else
                        disp('No GPS clock');
                    end
                case 193 % C1 GPS MIN
                    if showGPS >0
                        subplotArray(1) = subplot(2,1,1);
                        obj.data(1).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(2) = subplot(2,1,2);
                        obj.data(2).plot(startTime,true,true,false,plotDownSample,downSampleFactor, fontSize);
                        Title = [obj.name newline  '- ' ...
                            datestr(datetime(startTime), ...
                            'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize+2);
                        catch
                            suptitle(Title);
                        end
                        linkaxes(subplotArray,'x');
                        figure();
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        subplotArray(1) = subplot(3,1,1);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(2) = subplot(3,1,2);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor, fontSize);
                        subplotArray(3) =subplot(3,1,3);
                        obj.data(5).plot(startTime,true,true,true,plotDownSample,downSampleFactor, fontSize);
                        linkaxes(subplotArray,'x');
                        Title = [obj.name newline  '- ' ...
                            datestr(datetime(startTime), ...
                            'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                        try
                            sgtitle(Title,'fontsize',fontSize+2);
                        catch
                            suptitle(Title);
                        end
                    end
                    if showGPS == 1 || showGPS == 3
                        figure()
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        indexLatNotZero = obj.data(2).values(:)~=0;
                        if sum(indexLatNotZero)~= numel(obj.data(2).values(:))
                            disp('PS locations with latitude equal to 0 are not shown but are present in the data')
                        end
                        
                        if plotDownSample
                            factor = size(obj.data(2).values(indexLatNotZero),1)/downSampleFactor;
                            plt(obj.data(1).values(indexLatNotZero), obj.data(2).values(indexLatNotZero),'+','downsample',factor);
                            xlabel(obj.data(1).name);
                            ylabel(obj.data(2).name);
                        else
                            plot(obj.data(1).values(indexLatNotZero), obj.data(2).values(indexLatNotZero),'+','LineWidth',2);
                            Title = [obj.name newline  '- ' ...
                                datestr(datetime(startTime), ...
                                'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
                            try
                                sgtitle(Title,'fontsize',fontSize+2);
                            catch
                                suptitle(Title);
                            end
                            xlabel('Longitude','fontsize',fontSize);
                            ylabel('lattitude','fontsize',fontSize);
                        end
                    end
                    if showGPS == 2 || showGPS == 3
                        % with satelitte view
                        figure()
                        set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                        set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                        set(0, 'DefaultAxesFontSize', fontSize);
                        indexLatNotZero = obj.data(2).values(:)~=0;
                        if sum(indexLatNotZero)~= numel(obj.data(2).values(:))
                            disp('PS locations with latitude equal to 0 are not shown but are present in the data')
                        end
                        
                        gx =geoscatter(obj.data(2).values(indexLatNotZero), obj.data(1).values(indexLatNotZero));
                        gx.MarkerEdgeColor = 'r';
                        gx.LineWidth = 3;
                        gx.Parent.FontSize =fontSize;
                        geobasemap satellite
                        [latlim, lonlim] = geolimits;
                        geolimits([latlim(1)-0.0009 latlim(2)+0.0009],[lonlim(1)-0.0009 lonlim(2)+0.0009]) ;
                    end
                    
                case 194 % C2 GPS STATUS
                    disp([obj.name " is not yet programmed"]);
                case 195 % C3 GPS DATA STATUS
                    disp([obj.name " is not yet programmed"]);
                case 209 % D1 CAN DISTANCE NODES (US)
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor, fontSize);
                case 210 % D2 CAN DISTANCE NODES (IR)
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor, fontSize);
                    %                     ylim([0 max(obj.data(1).values)*1.2]);
                case 211 % D3 CAN DISTANCE NODES (US+IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor, fontSize);
                    else
                        subplotArray(1) =subplot(2,2,1:2);
                        obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(2) =subplot(2,2,3);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(3) = subplot(2,2,4);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        linkaxes(subplotArray,'x');
                    end
                case 212 % D4 CAN DISTANCE NODES (US+2IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor,fontSize);
                    else
                        subplotArray(1) = subplot(2,3,1:3);
                        obj.data(1).plot(startTime,true,true,false,plotDownSample,downSampleFactor,fontSize);
                        ylim([0 max(obj.data(1).values)*1.2]);
                        subplotArray(2) = subplot(2,3,4);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(3) = subplot(2,3,5);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(4) = subplot(2,3,5);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        linkaxes(subplotArray,'x');
                    end
                case 213 % D5 CAN DISTANCE NODES (US+3IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor,fontSize);
                    else
                        subplotArray(1) =subplot(2,4,1:4);
                        obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(2) = subplot(2,4,5);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(3) = subplot(2,4,6);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(4) = subplot(2,4,7);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(5) = subplot(2,4,8);
                        obj.data(5).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        linkaxes(subplotArray,'x');
                    end
                case 214 % D6 CAN DISTANCE NODES (4IR)
                    if showDistSubs == false || size(obj.data,2)==1
                        obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor,fontSize);
                    else
                        subplotArray(1) = subplot(2,4,1:4);
                        obj.data(1).plot(startTime,true,true,true,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(2) = subplot(2,4,5);
                        obj.data(2).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(3) = subplot(2,4,6);
                        obj.data(3).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(4) = subplot(2,4,7);
                        obj.data(4).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        subplotArray(5) = subplot(2,4,8);
                        obj.data(5).plot(startTime,true,false,false,plotDownSample,downSampleFactor,fontSize);
                        linkaxes(subplotArray,'x');
                    end
                case 215 % D7 CAN DISTANCE NODES (4IR) Only Calculated Value
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor,fontSize);
                case 216 % D8 CAN DISTANCE NODES (US+3IR) Only Calculated Value
                    obj.data(1).plot(startTime,false,true,true,plotDownSample,downSampleFactor,fontSize);
                case 225 % E1 Real Time Clock
                    obj.data(1).plot(startTime,false,true,false,plotDownSample,downSampleFactor,fontSize);
                case 241 % F1 USB AD as Instrument
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    s = get(gca, 'Position');
                    set(gca, 'Position', [s(1), s(2), s(3), s(4) * 0.9])
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor,fontSize);
                    s = get(gca, 'Position');
                    set(gca, 'Position', [s(1), s(2), s(3), s(4) * 0.9])
                    linkaxes(subplotArray,'x');
                case 242 % F2 USB AD as Instrument + Sensor activate bits
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true,true,plotDownSample,downSampleFactor,fontSize);
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(5).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(6).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(7).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(8).plot(startTime,true,true,true,plotDownSample,downSampleFactor,fontSize);
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', fontSize);
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(9).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(10).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(11).plot(startTime,true,false,true,plotDownSample,downSampleFactor,fontSize);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(12).plot(startTime,true,true,true,plotDownSample,downSampleFactor,fontSize);
                    linkaxes(subplotArray,'x');
            end
            
            Title = [obj.name newline  '- ' ...
                datestr(datetime(startTime), ...
                'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '];
            if  obj.datatype ~= 160 && obj.datatype ~= 161 && obj.datatype  ~= 162 && obj.datatype  ~= 163 && obj.datatype  ~= 242 && obj.datatype  ~= 176
                try
                    sgtitle(Title,'fontsize',fontSize+2);
                catch
                    suptitle(Title);
                end
            end
            
            plotJoystickPath(obj,measureID,startTime,showJoystickPath,fontSize)
            
        end
        
        %%  Local plot functions
        
        function Heatmp(obj,name,turn,speed,R,size,variableScale,dataFiltered,fontSize)
            
            tic
            XgridEdges = -R:(R*2)/size:R;
            YgridEdges =-R:(R*2)/size:R;
            s=num2str(size);
            if size > 5
                hsize = 'Variable';
            else
                hsize = 'Standard';
            end
            htmpName = [name 'heatmap' hsize];
            if( ~isprop(obj, htmpName))
                obj.addprop(htmpName);
            end
            movementIDs =  ~isnan(turn) & ~isnan(speed) & (turn ~=0 & speed ~=0);
            
            turn = turn(movementIDs);
            speed = speed(movementIDs);
            obj.(htmpName).bin = histcounts2(turn,speed,XgridEdges,YgridEdges);
            
            
            obj.(htmpName).bin(obj.(htmpName).bin == 0) =nan;
            obj.(htmpName).bin = rot90(obj.(htmpName).bin); % this is needed because the hitscounts2 rotates the result
            obj.(htmpName).bin = obj.(htmpName).bin/length(turn)*100; %
            limit = R-(R/size);
            obj.(htmpName).speedAxis = round(linspace(limit,-limit,size),2);
            obj.(htmpName).turnAxis = round(linspace(-limit,limit,size),2);
            % create heatmap
            figure;
            set(gca,'fontsize',20) % set fontsize of the plot to 20
            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
            set(0, 'DefaultAxesFontSize', 20);
            %             Show table
            T = array2table(obj.(htmpName).bin);
            T.Properties.VariableNames= string(obj.(htmpName).turnAxis );
            T.Properties.RowNames = string(obj.(htmpName).speedAxis);
            T
            %             Show heatmap
            htmp = heatmap(obj.(htmpName).turnAxis,obj.(htmpName).speedAxis,obj.(htmpName).bin);
            
            
            
            htmp.ColorLimits = [0 100];
            if contains(name,'FilteredActuator')
                 htmp.Title = s+ "x" + s + " Filtered actuator control Deflection Heat Map";
            elseif contains(name,'Actuator')
                 htmp.Title = s+ "x" + s + " Actuator control Deflection Heat Map";
            elseif dataFiltered
                htmp.Title = s+ "x" + s + " filtered Joystick Deflection Heat Map";
            else
                htmp.Title = s+ "x" + s + " RAW Joystick Deflection Heat Map";
            end
            if variableScale
                htmp.ColorLimits = [0 max(max(obj.(htmpName).bin))];
            else
                htmp.ColorLimits = [0 100];
            end
            htmp.CellLabelFormat = '%.2f';
            htmp.ColorMethod = 'none';
            htmp.XLabel = 'turn';
            htmp.YLabel = 'speed';
            htmp.FontSize = fontSize;
            htmp.MissingDataLabel = 0;
            htmp.MissingDataColor = [1 1 1];
            colormap default
            disp("Elapsed time for " + s+ "x" +s + " heatmap: " + toc + "s")
            
        end
        function saveHeatmaps(obj, store)
            
            if ~exist([pwd '\heatmaps'], 'dir')
                mkdir('heatmaps')
            end
            % create filename
            filename = fullfile(pwd,'heatmaps', [store '.xlsx']);
            
            i=0;
            while exist(filename, 'file') == 2
                i = i+1;
                filename = fullfile(pwd,'heatmaps', [store '_V' int2str(i)  '.xlsx']);
            end
            writematrix("Standard speed axis",filename,'Sheet',"standard",'Range','A2')
            writematrix(obj.heatmapStandard.speedAxis',filename,'Sheet',"standard",'Range','A3')
            writematrix("Standard turn axis",filename,'Sheet',"standard",'Range','B1')
            writematrix(obj.heatmapStandard.turnAxis,filename,'Sheet',"standard",'Range','C1')
            writematrix(obj.heatmapStandard.bin,filename,'Sheet',"standard",'Range','C3')
            
            writematrix("Variable speed axis",filename,'Sheet',"standard",'Range','A15')
            writematrix(obj.heatmapVariable.speedAxis',filename,'Sheet',"standard",'Range','A16')
            writematrix("Variable turn axis",filename,'Sheet',"standard",'Range','B14')
            writematrix(obj.heatmapVariable.turnAxis,filename,'Sheet',"standard",'Range','C14')
            writematrix(obj.heatmapVariable.bin,filename,'Sheet',"standard",'Range','C16')
            
            %            Filtered heatmaps
            if isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                writematrix("Standard speed axis",filename,'Sheet',"filtered",'Range','A2')
                writematrix(obj.filteredheatmapStandard.speedAxis',filename,'Sheet',"filtered",'Range','A3')
                writematrix("standard turn axis",filename,'Sheet',"filtered",'Range','B1')
                writematrix(obj.filteredheatmapStandard.turnAxis,filename,'Sheet',"filtered",'Range','C1')
                %             writematrix("Standard bin",filename,'Sheet',"filtered",'Range','A4')
                writematrix(obj.filteredheatmapStandard.bin,filename,'Sheet',"filtered",'Range','C3')
                
                writematrix("Variable speed axis",filename,'Sheet',"filtered",'Range','A15')
                writematrix(obj.filteredheatmapVariable.speedAxis',filename,'Sheet',"filtered",'Range','A16')
                writematrix("Variable turn axis",filename,'Sheet',"filtered",'Range','B14')
                writematrix(obj.filteredheatmapVariable.turnAxis,filename,'Sheet',"filtered",'Range','C14')
                %             writematrix("Variable bin",filename,'Sheet','filtered','Range','A15')
                writematrix(obj.filteredheatmapVariable.bin,filename,'Sheet',"filtered",'Range','C16')
            end
        end
        
        function DeflectionsPattern(obj,name,xData,yData,fontSize,plotDownSample,downSampleFactor)
            figure()
            set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
            set(0, 'DefaultAxesFontSize', fontSize);
            try
                sgtitle([name , ' Joystick deflection pattern'],'fontsize',fontSize+2);
            catch
                suptitle([name , ' Joystick deflection pattern']);
            end
            if plotDownSample
                factor = size(obj.data(xData).values,1)/downSampleFactor;
                plt(xData.values, yData.values,'+','downsample',factor);
            else
                plot(xData.values, yData.values,'+');
            end
            axis equal;
            limValue = max(abs([xData.values; yData.values]))*1.1;
            if( limValue >0)
                axis ([-limValue limValue -limValue limValue]);
            end
            xlabel(xData.name);
            ylabel(yData.name);
        end
        
        function plotJoystickSpeedTurn(obj,data,measurementID, title, startTime,fontSize)
            time = seconds(0:(numel(data.turn.values)-1))*0.020 + startTime;
           figure();
            set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
            set(0, 'DefaultAxesFontSize', fontSize);
            subplotArray(1) =  subplot(2,1,1);
            plot(time, data.turn.values, 'LineWidth',2)
            try
                subtitle("turn")
            catch
                suptitle("turn")
            end
            subplotArray(2) =  subplot(2,1,2);
            plot(time, data.speed.values, 'LineWidth',2)
            try
                subtitle("speed")
            catch
                suptitle("speed")
            end
            Title = [title newline  '- ' ...
                datestr(startTime,'dd/mm/yyyy') ,...
                ' - Measurement ID: ' num2str(measurementID) ' - '];
            try
                sgtitle(Title,'fontsize',fontSize);
            catch
                suptitle(Title);
            end
            xlim([time(1) time(end)]);
            linkaxes(subplotArray,'x');
        end
        
        function plotJoystickPath(obj,measureID,startTime,showJoystickPath,fontSize)
            
            % --------------------- Joystick path length ----------------------------
            if( isprop(obj,'pathLength'))
                
                time = seconds(0:(size(obj.pathLength.d,1)-1))*0.020 + startTime;
                tzOffset = tzoffset(startTime);
                
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                nrPlots = sum(showJoystickPath);
                subplotArray(1) = subplot(1 + (nrPlots>0),2,1:2);
                plot(time,obj.pathLength.d,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Instantaneous joystick path length [RAW]' ];
                
                title(Title,'fontsize',fontSize);
                
                if showJoystickPath(1)
                    subplotArray(2) = subplot(1 + (nrPlots>0),2,3:3+(nrPlots==1));
                    plot(time,obj.pathLength.dx ,'LineWidth',2)
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',20);
                    title('dx [RAW]','fontsize',fontSize)
                    
                end
                
                if showJoystickPath(2)
                    subplotArray(3-(nrPlots==1)) = subplot(1 + (nrPlots>0),2,4-(nrPlots==1):4);
                    plot(time,obj.pathLength.dy,'LineWidth',2 )
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',fontSize);
                    title('dy [RAW]','fontsize',fontSize)
                end
                linkaxes(subplotArray,'x');
                % plot cumulative path
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                plot(time,obj.pathLength.cumd,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                
                %                 ylabel([yText ' [' char(obj.unit) ']'],'fontsize',20);
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',fontSize);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Cumulative joystick path length (CJPL) [RAW]' ];
                
                title(Title,'fontsize',fontSize);
                text(time(50),obj.pathLength.cumd(end), "CJPL score: " + round(obj.pathLength.scoreD),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                text(time(50),obj.pathLength.cumd(end)*0.95, "NJS for polynomials: " + round(obj.pathLength.NJS_poly(end)),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                text(time(50),obj.pathLength.cumd(end)*0.9, "NJS for harmonics: " + round(obj.pathLength.NJS_harm(end)),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                
                display( "CJPL score: " + round(obj.pathLength.scoreD));
                display("NJS for measurement with polynomials: " + round(obj.pathLength.NJS_poly(end))');
                display("NJS for measurement with harmonics: " + round(obj.pathLength.NJS_harm(end))');
                
                %show NJS
                subplotArray=[];
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                subplotArray(1) = subplot(2,1,1);
                plot(obj.pathLength.t,obj.pathLength.NJS_poly,'LineWidth',2 )
                title('NJS for polynomials','fontSize',fontSize);
                ylabel('NJS');
                subplotArray(2) = subplot(2,1,2);
                plot(obj.pathLength.t,obj.pathLength.NJS_harm,'LineWidth',2 )
                title('NJS for harmonics','fontSize',fontSize);
                ylabel('NJS');
                xlabel('Effective raw movement time (s)','fontsize',fontSize);
                linkaxes(subplotArray,'x');
                
                %                 % differences plots
                %                 subplotArray=[];
                %                 figure();
                %                 set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                %                 set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                %                 set(0, 'DefaultAxesFontSize', fontSize);
                %
                %                 subplotArray(1) = subplot(3,2,1);
                %                 plot(obj.pathLength.diff1.x,'LineWidth',2 )
                %                 xlim(([1 numel(obj.pathLength.diff1.x)]));
                %                 xlabel('Samples','fontsize',20);
                %                 Title = [datestr(datetime(startTime), ...
                %                     'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                %                     'X diff 1' ];
                %                 title(Title,'fontsize',20);
                %
                %                 subplotArray(2) = subplot(3,2,2);
                %                 plot(obj.pathLength.diff1.y,'LineWidth',2 )
                %                 xlim(([1 numel(obj.pathLength.diff1.y)]));
                %                 xlabel('Samples','fontsize',20);
                %                 title('Y diff 1','fontsize',fontSize)
                %
                %                 % 2th diff
                %                 subplotArray(3) = subplot(3,2,3);
                %                 plot(obj.pathLength.diff2.x,'LineWidth',2 )
                %                 xlim(([1 numel(obj.pathLength.diff2.x)]));
                %                 xlabel('Samples','fontsize',20);
                %                 title('X diff 2','fontsize',fontSize)
                %
                %                 subplotArray(4) = subplot(3,2,4);
                %                 plot(obj.pathLength.diff2.y,'LineWidth',2 )
                %                 xlim(([1 numel(obj.pathLength.diff2.y)]));
                %                 xlabel('Samples','fontsize',20);
                %                 title('Y diff 2','fontsize',fontSize)
                %
                %                 % 3th diff
                %                 subplotArray(5) = subplot(3,2,5);
                %                 plot(obj.pathLength.diff3.x,'LineWidth',2 )
                %                 xlim(([1 numel(obj.pathLength.diff3.x)]));
                %                 xlabel('Samples','fontsize',20);
                %                 title('X diff 3','fontsize',fontSize)
                %
                %                 subplotArray(6) = subplot(3,2,6);
                %                 plot(obj.pathLength.diff3.y,'LineWidth',2 )
                %                 xlim(([1 numel(obj.pathLength.diff3.y)]));
                %                 xlabel('Samples','fontsize',20);
                %                 title('Y diff 3','fontsize',fontSize)
                %                 linkaxes(subplotArray,'x');
                %                 subplotArray=[];
            end
            
            % --------------------- Filtered joystick path length ----------------------------
            if( isprop(obj,'filteredPathLength'))
                tzOffset = tzoffset(startTime);
                
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                nrPlots = sum(showJoystickPath);
                subplotArray(1) = subplot(1 + (nrPlots>0),2,1:2);
                plot(time,obj.filteredPathLength.d,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',fontSize);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Filtered Instantaneous joystick path length' ];
                
                title(Title,'fontsize',fontSize);
                
                if showJoystickPath(1)
                    subplotArray(2) = subplot(1 + (nrPlots>0),2,3:3+(nrPlots==1));
                    plot(time,obj.filteredPathLength.dx ,'LineWidth',2)
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',fontSize);
                    title('Filtered dx','fontsize',fontSize)
                    linkaxes(subplotArray,'x');
                end
                
                if showJoystickPath(2)
                    subplotArray(3-(nrPlots==1)) = subplot(1 + (nrPlots>0),2,4-(nrPlots==1):4);
                    plot(time,obj.filteredPathLength.dy,'LineWidth',2 )
                    xlim(([min(time) (max(time))]));
                    xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',fontSize);
                    title('Filtered dy','fontsize',fontSize)
                    linkaxes(subplotArray,'x');
                end
                
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                plot(time,obj.filteredPathLength.cumd,'LineWidth',2 )
                xlim(([min(time) (max(time))]));
                text(time(50),obj.filteredPathLength.cumd(end), "Filtered CJPL score: " + round(obj.filteredPathLength.scoreD),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                text(time(50),obj.filteredPathLength.cumd(end)*0.95, "NJS for polynomials: " + round(obj.filteredPathLength.NJS_poly(end)),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                text(time(50),obj.filteredPathLength.cumd(end)*0.9, "NJS for harmonics: " + round(obj.filteredPathLength.NJS_harm(end)),'fontsize',fontSize,'HorizontalAlignment','left','VerticalAlignment','top');
                
                %                 ylabel([yText ' [' char(obj.unit) ']'],'fontsize',20);
                xlabel('Time (UTC +'+  extractBefore(string(tzOffset,'hh:mm'),':')+ ')','fontsize',fontSize);
                Title = [datestr(datetime(startTime), ...
                    'dd/mm/yyyy') ' - Measurement ID: ' num2str(measureID) ' - '  newline ....
                    'Filtered Cumulative Joystick Path Length (CJPL)' ];
                
                title(Title,'fontsize',fontSize);
                display( "Filtered CJPL score: " + round(obj.filteredPathLength.scoreD));
                display("NJS for measurement with polynomials: " + round(obj.filteredPathLength.NJS_poly(end))');
                display("NJS for measurement with harmonics: " + round(obj.filteredPathLength.NJS_harm(end))');
                
                %show NJS
                subplotArray=[];
                figure();
                set(gca,'fontsize',fontSize+2) % set fontsize of the plot to 20
                set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                set(0, 'DefaultAxesFontSize', fontSize);
                subplotArray(1) = subplot(2,1,1);
                plot(obj.filteredPathLength.t,obj.filteredPathLength.NJS_poly,'LineWidth',2 )
                title('Filtered NJS for polynomials','fontSize',fontSize);
                ylabel('NJS');
                subplotArray(2) = subplot(2,1,2);
                plot(obj.filteredPathLength.t, obj.filteredPathLength.NJS_harm,'LineWidth',2 )
                title('Filtered NJS for harmonics','fontSize',fontSize);
                ylabel('NJS');
                xlabel('Effective filtered movement time (s)','fontsize',fontSize);
                linkaxes(subplotArray,'x');
            end
            
        end
        
        
        %%  Joystick functions
        function obj  = joystickPathLength(obj)
            if sum(obj.datatype == (160:163)) && sum(~isnan(obj.data(2).values))>0
                
                if( ~isprop(obj,'pathLength'))
                    obj.addprop('pathLength');
                end
                
                if( ~isprop(obj,'time'))
                    obj.addprop('time');
                end
                
                obj.pathLength.dx = [0; obj.data(2).values(2:end)-obj.data(2).values(1:end-1)]; % turn
                obj.pathLength.dy = [0; obj.data(3).values(2:end)-obj.data(3).values(1:end-1)]; % speed
                obj.pathLength.d = sqrt(obj.pathLength.dx.^2 + obj.pathLength.dy.^2);
                obj.pathLength.d(isnan(obj.pathLength.d))=0;
                obj.pathLength.cumd = cumsum(obj.pathLength.d);
                obj.pathLength.scoreD = obj.pathLength.cumd(end);
                [obj.pathLength.t, obj.pathLength.NJS_poly, obj.pathLength.NJS_harm]= obj.NJS_adjusted(2);
                obj.time.effective_raw = obj.pathLength.t(end);
                
                x= obj.data(2).values;
                x(isnan(x))=0;
                y= obj.data(2+1).values;
                y(isnan(y))=0;
                obj.pathLength.diff1.x= diff(x,1);
                obj.pathLength.diff1.y= diff(y,1);
                obj.pathLength.diff2.x= diff(x,2);
                obj.pathLength.diff2.y= diff(y,2);
                obj.pathLength.diff3.x= diff(x,3);
                obj.pathLength.diff3.y= diff(y,3);
                
                if  isfield(obj.filterSetting,'executed') && obj.filterSetting.executed
                    if( ~isprop(obj,'filteredPathLength'))
                        obj.addprop('filteredPathLength');
                    end
                    
                    if obj.datatype == 162
                        obj.filteredPathLength.dx = [0; obj.data(9).values(2:end)-obj.data(9).values(1:end-1)]; % turn
                        obj.filteredPathLength.dy = [0; obj.data(10).values(2:end)-obj.data(10).values(1:end-1)]; % speed
                        obj.filteredPathLength.d = sqrt(obj.filteredPathLength.dx.^2 + obj.filteredPathLength.dy.^2);
                        obj.filteredPathLength.d(isnan(obj.filteredPathLength.d))=0;
                        obj.filteredPathLength.cumd = cumsum(obj.filteredPathLength.d);
                        obj.filteredPathLength.scoreD = obj.filteredPathLength.cumd(end);
                        [obj.filteredPathLength.t, obj.filteredPathLength.NJS_poly, obj.filteredPathLength.NJS_harm] = obj.NJS_adjusted(9);
                        obj.time.effective_filtered = obj.filteredPathLength.t(end);
                        
                        x= obj.data(9).values;
                        x(isnan(x))=0;
                        y= obj.data(9+1).values;
                        y(isnan(y))=0;
                        obj.filteredPathLength.diff1.x= diff(x,1);
                        obj.filteredPathLength.diff1.y= diff(y,1);
                        obj.filteredPathLength.diff2.x= diff(x,2);
                        obj.filteredPathLength.diff2.y= diff(y,2);
                        obj.filteredPathLength.diff3.x= diff(x,3);
                        obj.filteredPathLength.diff3.y= diff(y,3);
                    else
                        obj.filteredPathLength.dx = [0; obj.data(8).values(2:end)-obj.data(8).values(1:end-1)]; % turn
                        obj.filteredPathLength.dy = [0; obj.data(9).values(2:end)-obj.data(9).values(1:end-1)]; % speed
                        obj.filteredPathLength.d = sqrt(obj.filteredPathLength.dx.^2 + obj.filteredPathLength.dy.^2);
                        obj.filteredPathLength.d(isnan(obj.filteredPathLength.d))=0;
                        obj.filteredPathLength.cumd = cumsum(obj.filteredPathLength.d);
                        obj.filteredPathLength.scoreD = obj.filteredPathLength.cumd(end);
                        [obj.filteredPathLength.t, obj.filteredPathLength.NJS_poly, obj.filteredPathLength.NJS_harm] = obj.NJS_adjusted(8);
                        obj.time.effective_filtered = obj.filteredPathLength.t(end);
                        
                        x= obj.data(8).values;
                        x(isnan(x))=0;
                        y= obj.data(8+1).values;
                        y(isnan(y))=0;
                        obj.filteredPathLength.diff1.x= diff(x,1);
                        obj.filteredPathLength.diff1.y= diff(y,1);
                        obj.filteredPathLength.diff2.x= diff(x,2);
                        obj.filteredPathLength.diff2.y= diff(y,2);
                        obj.filteredPathLength.diff3.x= diff(x,3);
                        obj.filteredPathLength.diff3.y= diff(y,3);
                    end
                    
                end
            end
        end
        
        function [timevec, njs_poly, njs_harm] = NJS_adjusted(obj, startIndex)
            %Speedclean and turnclean --> Only measurement data during the trails (not
            %before/after)
            
            %Array speed + array turn --> Array of instantaneous jerk (3 difference -->
            %3 cel gone, pad with zero
            %From comparison with Simulink, array must be padded every diff)
            %Derivative + padding
            
            % Get turn and speed data and clear NaN.
            turn_clean= obj.data(startIndex).values;
            speed_clean= obj.data(startIndex+1).values;
            
            % remove more than 3 consecutive [0,0] from the turn and speed
           [startZeroID, endZeroID, zeroCrossingIDs] = zeroCrossingDetection(obj,turn_clean,speed_clean);
           
            startZeroID(zeroCrossingIDs) = [];
            endZeroID(zeroCrossingIDs) = [];
            
            startZeroID = startZeroID+1;
            endZeroID = endZeroID-2;
            for i = 1: numel(startZeroID)
                turn_clean(startZeroID(i):endZeroID(i)) = nan;
                speed_clean(startZeroID(i):endZeroID(i)) = nan;
            end
            
            
            figure
            subplotArray(1) = subplot(2,1,1);
            hold on 
            plot(obj.data(startIndex).values)
            plot(turn_clean)
            legend('original','>3 consecutive [0,0] removed')
            try
                subtitle("turn")
            catch
                suptitle("turn")
            end
            title("removed more than 3 consecutive [0,0]")
            subplotArray(2) = subplot(2,1,2);
            hold on
            plot(obj.data(startIndex+1).values)
            plot(speed_clean)
            try
                subtitle("speed")
            catch
                suptitle("speed")
            end
            linkaxes(subplotArray,'x')
            
            % remove all nans
            nanID =  isnan(turn_clean)  | isnan(speed_clean);
            
            turn_clean(nanID)=[];
            speed_clean(nanID)=[];
            
            
            jerk_trn = turn_clean;
            jerk_spd = speed_clean;
            Ts = 0.02;
            
            for i=1:3
                %Derivative
                trn_d1=diff(jerk_trn, 1)/Ts;
                spd_d1=diff(jerk_spd, 1)/Ts;
                %Padding
                jerk_trn(2:end)=trn_d1;
                jerk_spd(2:end)=spd_d1;
                jerk_trn(1)=0;
                jerk_spd(1)=0;
            end
            jerk=jerk_trn.^2 + jerk_spd.^2;
            
            %Array jerk integrated
            jerk_integrated = jerk;
            for i = 2:length(jerk_integrated)
                jerk_integrated(i)=jerk_integrated(i-1)+jerk(i)*Ts;
            end
          
            %Array of length
            len = sqrt(diff(turn_clean).^2+diff(speed_clean).^2);
            
            %Array of summmated length (difference --> 1 cel gone, pad with 0)
            len_sumtem = len;
            for i = 2:length(len_sumtem)
                len_sumtem(i)=len_sumtem(i-1)+len(i);
            end
            len_sum=zeros(length(speed_clean),1);
            len_sum(2:end)=len_sumtem(1:end);
            
            %Time array                    
            timevec = ((0:length(speed_clean)-1)*Ts)';
            
            %Array of NJS            
            njs_poly=sqrt(0.5.*jerk_integrated.*(timevec.^5)./(len_sum.^2));
            njs_harm=sqrt(0.5.*jerk_integrated.*(timevec)./(len_sum.^2));
            
            
            
            
            figure
            subplotArray(1) = subplot(4,1,1);
            plot(timevec,jerk)
            try
               subtitle('Jerk')
            catch
                suptitle('Jerk')
            end
            subplotArray(2) = subplot(4,1,2);
            plot(timevec,jerk_integrated)
            try
                subtitle('Integrated Jerk')
            catch
                suptitle('Integrated Jerk')
            end
            subplotArray(3) = subplot(4,1,3);
            plot(timevec,njs_poly)
            try
                subtitle('NJS poly')
            catch
                suptitle('NJS poly')
            end
            subplotArray(4) = subplot(4,1,4);
            plot(timevec, njs_harm)
            try
                subtitle('NJS harm')
            catch
                 suptitle('NJS harm')
            end
             xlabel('Effective movement time (s)');
             linkaxes(subplotArray,'x')
        end
    end
    
    
end