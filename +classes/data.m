classdef data
    properties
        name, ...
        values, ...
        datatype, ...
        unit
    end
    methods
        function obj = data(name, unit, datatype,maxCycleCount)
            obj.name = name;  
            obj.unit = unit;
            switch datatype %% ENUMERATING to prevent String compares during live loop
                case "int_8"
                    obj.datatype = 0;
                    obj.values = int8.empty(maxCycleCount,0);
                case "uint_8"
                    obj.datatype = 1;  
                    obj.values = uint8.empty(maxCycleCount,0);
                case "int_16"
                    obj.datatype = 2;
                    obj.values = int16.empty(maxCycleCount,0);
                case "uint_16"
                    obj.datatype = 3;
                    obj.values = uint16.empty(maxCycleCount,0);
                case "iint_32"
                    obj.datatype = 4;
                    obj.values = int32.empty(maxCycleCount,0);
                case "uint_32"
                    obj.datatype = 5;
                    obj.values = uint32.empty(maxCycleCount,0);
                case "float_32"
                    obj.datatype = 6;
                    obj.values = single.empty(maxCycleCount,0);
                case "int_64"
                    obj.datatype = 7;
                    obj.values = int64.empty(maxCycleCount,0);
                case "uint_64"
                    obj.datatype = 8;
                    obj.values = uint64.empty(maxCycleCount,0);
                case "float_64"
                    obj.datatype = 9;
                    obj.values = double.empty(maxCycleCount,0);
                otherwise
                    error("MATLAB Datatype not supported")
            end
            %obj.resize();
        end
        function obj = add_value(obj, blob)
            switch obj.datatype %% ENUMERATING to prevent String compares during live loop
                case 0 %int_8
                    reOut = reshape(blob',1,[]);
                    obj.values = typecast(reOut,'int8'); 
                case 1 %uint_8
                    reOut = reshape(blob',1,[]);
                    obj.values = typecast(reOut,'uint8');
                case 2 %int_16
                    reOut = reshape(blob(:,2:-1:1)',1,[]);
                    obj.values = typecast(reOut,'int16');
                case 3 %uint_16
                    reOut = reshape(blob(:,2:-1:1)',1,[]);
                    obj.values = typecast(reOut,'uint16');
                case 4 %int_32
                    reOut = reshape(blob(:,4:-1:1)',1,[]);
                    obj.values = typecast(reOut,'int32');
                case 5 %uint_32
                    reOut = reshape(blob(:,4:-1:1)',1,[]);
                    obj.values = typecast(reOut,'uint32');
                case 6 %float_32
                    reOut = reshape(blob(:,4:-1:1)',1,[]);
                    obj.values = typecast(reOut,'single');
                case 7 %int_64
                    reOut = reshape(blob(:,8:-1:1)',1,[]);
                    obj.values = typecast(reOut,'int64');
                case 8 %uint_64
                    reOut = reshape(blob(:,8:-1:1)',1,[]);
                    obj.values = typecast(reOut,'uint64');
                case 9 %float_64
                    reOut = reshape(blob(:,8:-1:1)',1,[]);
                    obj.values = typecast(reOut,'double');
                    %obj.values = typecast(blob(8:-1:1),'double');
            end
            %obj.value(cyclecounter).value;
            
            
            
            
        end
        function obj = resize(obj)
            %obj.value = obj.value;
        end
        function obj = plot(obj,startTime,xlabelOn)
            time = seconds(0:(size(obj.values,2)-1))*0.020 + startTime;
            plot(time,obj.values,'LineWidth',2);
            title([char(obj.name) ' [' char(obj.unit) ']'],'fontsize',14);
            %ylim([min([0 obj.values],[],'all') (1.5*max(obj.values,[],'all'))]);
            xlim(([min(time) (max(time))]));
            if xlabelOn
                xlabel('Time (UTC)','fontsize',14);
            end
            ylabel([char(obj.name) ' [' char(obj.unit) ']'],'fontsize',14);
        end
    end
end