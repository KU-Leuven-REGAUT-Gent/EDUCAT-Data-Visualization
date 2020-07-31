classdef setting
    % Teste ne
    
    properties
        name, ...
        id, ...
        parameters, ...
        datatype
    end
    
    methods
        function obj = setting(name, id, datatype, maxSetting)
            obj.name = name; 
            obj.id = id; 
            switch datatype %% ENUMERATING to prevent String compares during live loop
                case "boolean"
                    obj.datatype = 0;
                    obj.parameters = NaN(maxSetting,1);
                case "int_8"
                    obj.datatype = 1;
                    obj.parameters = NaN(maxSetting,1);
                case "uint_8"
                    obj.datatype = 2;  
                    obj.parameters = NaN(maxSetting,1);
                case "int_16"
                    obj.datatype = 3;
                    obj.parameters = NaN(maxSetting,1);
                case "uint_16"
                    obj.datatype = 4;
                    obj.parameters = NaN(maxSetting,1);
                case "iint_32"
                    obj.datatype = 5;
                    obj.parameters = NaN(maxSetting,1);
                case "uint_32"
                    obj.datatype = 6;
                    obj.parameters = NaN(maxSetting,1);
                case "float_32"
                    obj.datatype = 7;
                    obj.parameters = NaN(maxSetting,1);
                case "int_64"
                    obj.datatype = 8;
                    obj.parameters = NaN(maxSetting,1);
                case "uint_64"
                    obj.datatype = 9;
                    obj.parameters = NaN(maxSetting,1);
                case "float_64"
                    obj.datatype = 10;
                    obj.parameters = NaN(maxSetting,1);
                otherwise
                    error("MATLAB Datatype not supported")
            end
        end
        
        function obj = add_setting(obj,setting_nr, parameter_value)
            switch obj.datatype %% ENUMERATING to prevent String compares during live loop
                case 0 %boolean/already converted
                    obj.parameters(setting_nr) = parameter_value;
                case 1 %int_8
                    reOut = reshape(parameter_value',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'int8'); 
                case 2 %uint_8
                    reOut = reshape(parameter_value',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'uint8');
                case 3 %int_16
                    reOut = reshape(parameter_value(:,2:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'int16');
                case 4 %uint_16
                    reOut = reshape(parameter_value(:,2:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'uint16');
                case 5 %int_32
                    reOut = reshape(parameter_value(:,4:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'int32');
                case 6 %uint_32
                    reOut = reshape(parameter_value(:,4:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'uint32');
                case 7 %float_32
                    reOut = reshape(parameter_value(:,4:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'single');
                case 8 %int_64
                    reOut = reshape(parameter_value(:,8:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'int64');
                case 9 %uint_64
                    reOut = reshape(parameter_value(:,8:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'uint64');
                case 10 %float_64
                    reOut = reshape(parameter_value(:,8:-1:1)',1,[]);
                    obj.parameters(setting_nr) = typecast(reOut,'double');
                    %obj.parameters = typecast(blob(8:-1:1),'double');
            end         
        end
       
        function obj = plot(obj,startTime,enableTitle,enableXlabel,yEnLim,plotDownSample,downSampleFactor)
            time = seconds(0:(size(obj.parameters,1)-1))*0.020 + startTime;
             if plotDownSample
                factor = size(obj.parameters,1)/downSampleFactor;
                plt(time,obj.parameters,'LineWidth',2,'downsample',factor);
            else
                plot(time,obj.parameters,'LineWidth',2);
             end
            if enableTitle
                title([char(obj.name) ' [' char(obj.unit) ']'],'fontsize',20);
            end
            if yEnLim && obj.datatype ~= 0
                ylim([min([-0.1; obj.parameters],[],'all')*1.1 (1.1*max([obj.parameters;0.1],[],'all'))]);
            elseif obj.datatype == 0
                ylim([-0.1 1.1]);
            end
            xlim(([min(time) (max(time))]));
            if enableXlabel
                xlabel('Time (UTC)','fontsize',20);
            end
            if strlength(char(obj.name))> 30
                yText = split(extractAfter(char(obj.name),strlength(char(obj.name))/2),['-',' ']);
                yText = char(yText(end));
            else
                yText = char(obj.name);
            end
            ylabel([yText ' [' char(obj.unit) ']'],'fontsize',20);
        end
    end
end