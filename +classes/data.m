classdef data
    properties
        name, ...
        values, ...
        datatype, ...
        unit
    end
    methods
        function obj = data(name, unit, datatype)
            obj.name = name;  
            obj.unit = unit;
            switch datatype %% ENUMERATING to prevent String compares during live loop
                case "int_8"
                    obj.datatype = 0;
                case "uint_8"
                    obj.datatype = 1;                    
                case "int_16"
                    obj.datatype = 2;
                case "uint_16"
                    obj.datatype = 3;
                case "iint_32"
                    obj.datatype = 4;
                case "uint_32"
                    obj.datatype = 5;
                case "float_32"
                    obj.datatype = 6;
                case "int_64"
                    obj.datatype = 7;
                case "uint_64"
                    obj.datatype = 8;
                case "float_64"
                    obj.datatype = 9;
                otherwise
                    error("MATLAB Datatype not supported")
            end
            %obj.resize();
        end
        function obj = add_value(obj,cyclecounter, blob)
            switch obj.datatype %% ENUMERATING to prevent String compares during live loop
                case 0 %int_8
                    obj.values(cyclecounter) = typecast(blob,'int8');
                case 1 %uint_8
                    obj.values(cyclecounter) = typecast(blob,'uint8');
                case 2 %int_16
                    obj.values(cyclecounter) = typecast(blob(2:-1:1),'int16');
                    %obj.values(cyclecounter) = typecast(blob(1:2),'int16');
                case 3 %uint_16
                    obj.values(cyclecounter) = typecast(blob(2:-1:1),'uint16');
                case 4 %int_32
                    obj.values(cyclecounter) = typecast(blob(4:-1:1),'int32');
                case 5 %uint_32
                    obj.values(cyclecounter) = typecast(blob(4:-1:1),'uint32');
                case 6 %float_32
                    obj.values(cyclecounter) = typecast(blob(4:-1:1),'single');
                case 7 %int_64
                    obj.values(cyclecounter) = typecast(blob(8:-1:1),'int64');
                case 8 %uint_64
                    obj.values(cyclecounter) = typecast(blob(8:-1:1),'uint64');
                case 9 %float_64
                    obj.values(cyclecounter) = typecast(blob(8:-1:1),'double');
            end
            %%obj.value(cyclecounter).value;
        end
        function obj = resize(obj)
            %obj.value = obj.value;
        end
        function obj = plot(obj,startTime,xlabelOn)
            time = (1:size(obj.values,2))*0.020 + startTime;
            timeAndDay = datetime(time, 'convertfrom','posixtime');
            plot(timeAndDay,obj.values,'LineWidth',2);
            title([char(obj.name) ' [' char(obj.unit) ']'],'fontsize',16);
            %ylim([min([0 obj.values],[],'all') (1.5*max(obj.values,[],'all'))]);
            xlim(([min(timeAndDay) (max(timeAndDay))]));
            if xlabelOn
                xlabel('Time (UTC)','fontsize',20);
            end
            ylabel([char(obj.name) ' [' char(obj.unit) ']'],'fontsize',20);
        end
    end
end