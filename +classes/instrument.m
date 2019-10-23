classdef instrument    properties        id, ...            name, ...            description, ...            data, ...            datatype , ...            length    end    methods        %% constructor                function obj = instrument(id, name, description, datatype,maxCycleCount)            obj.id = id;            obj.name = name;            obj.description = description;            obj.datatype = datatype;            switch obj.datatype                case 161 % A1                    obj.length = 5;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);                    obj.data(2) = classes.data("Turn","?","int_8",maxCycleCount);                    obj.data(3) = classes.data("Speed","?","int_8",maxCycleCount);                    obj.data(4) = classes.data("Profile","?","int_8",maxCycleCount);                case 162 % A2                    obj.length = 6;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);                    obj.data(2) = classes.data("Turn","?","int_8",maxCycleCount);                    obj.data(3) = classes.data("Speed","?","int_8",maxCycleCount);                    obj.data(4) = classes.data("Profile","?","int_8",maxCycleCount);                    obj.data(5) = classes.data("Mode","?","int_8",maxCycleCount);                case 163 % A3                    obj.length = 5;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);                    obj.data(2) = classes.data("Turn","?","int_8",maxCycleCount);                    obj.data(3) = classes.data("Speed","?","int_8",maxCycleCount);                    obj.data(4) = classes.data("Profile","?","int_8",maxCycleCount);                case 177 % B1                    obj.length = 26;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);                    obj.data(7) = classes.data("mx","0.01 �T","int_16",maxCycleCount);                    obj.data(8) = classes.data("my","0.01 �T","int_16",maxCycleCount);                    obj.data(9) = classes.data("mz","0.01 �T","int_16",maxCycleCount);                    obj.data(10) = classes.data("real","0.001","int_16",maxCycleCount);                    obj.data(11) = classes.data("i","0.001","int_16",maxCycleCount);                    obj.data(12) = classes.data("j","0.001","int_16",maxCycleCount);                    obj.data(13) = classes.data("k","0.001","int_16",maxCycleCount);                case 178 % B2                    obj.length = 12;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);                case 193 % C1                    obj.length = 17;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("longitude","degrees","float_32",maxCycleCount);                    obj.data(2) = classes.data("latitude","degrees","float_32",maxCycleCount);                    obj.data(3) = classes.data("hMSL","m","float_32",maxCycleCount);                    obj.data(4) = classes.data("speed","m/s","float_32",maxCycleCount);                    obj.data(5) = classes.data("gnss","m/s","int_8",maxCycleCount);                case 194 % C2                    error("Datatype unsupported - not yet implemented");                case 195 % C3                    error("Datatype unsupported - not yet implemented");                case 209 % D1                    obj.length = 2;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("US","?","uint_16",maxCycleCount);                case 210 % D2                    obj.length = 1;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("IR","?","uint_8",maxCycleCount);                case 211 % D3                    obj.length = 5;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("Calculated","?","uint_16",maxCycleCount);                    obj.data(2) = classes.data("US","?","uint_16",maxCycleCount);                    obj.data(3) = classes.data("IR","?","uint_8",maxCycleCount);                case 212 % D4                    obj.length = 6;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("Calculated","?","uint_16",maxCycleCount);                    obj.data(2) = classes.data("US","?","uint_16",maxCycleCount);                    obj.data(3) = classes.data("IR 1","?","uint_8",maxCycleCount);                    obj.data(4) = classes.data("IR 2","?","uint_8",maxCycleCount);                case 213 % D5                    obj.length = 7;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("Calculated","?","uint_16",maxCycleCount);                    obj.data(2) = classes.data("US","?","uint_16",maxCycleCount);                    obj.data(3) = classes.data("IR 1","?","uint_8",maxCycleCount);                    obj.data(4) = classes.data("IR 2","?","uint_8",maxCycleCount);                    obj.data(5) = classes.data("IR 3","?","uint_8",maxCycleCount);                case 214 % D6                    obj.length = 6;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("Calculated","?","uint_16",maxCycleCount);                    obj.data(2) = classes.data("IR 1","?","uint_8",maxCycleCount);                    obj.data(3) = classes.data("IR 2","?","uint_8",maxCycleCount);                    obj.data(4) = classes.data("IR 3","?","uint_8",maxCycleCount);                    obj.data(5) = classes.data("IR 4","?","uint_8",maxCycleCount);                case 225 % E1                    obj.length = 8;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("unix_epoch_ms","ms","uint_64",maxCycleCount);                case 241 % F1                    obj.length = 2;                    obj.data = classes.data.empty(0,obj.length);                    obj.data(1) = classes.data("OAS Calculated Value","","uint_8",maxCycleCount);                    obj.data(2) = classes.data("Booleans","","uint_8",maxCycleCount);                otherwise                    error("Datatype unsupported");            end        end        %%  add data function                function obj = add_data(obj,cyclecounter, blob)            switch obj.datatype                case 161 % A1                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(4));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(5));                case 162 % A2                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(4));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(5));                    obj.data(5) = obj.data(4).add_value(cyclecounter, blob(6));                case 163 % A3                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(4));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(5));                case 177 % B1                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3:4));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(5:6));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(7:8));                    obj.data(5) = obj.data(5).add_value(cyclecounter, blob(9:10));                    obj.data(6) = obj.data(6).add_value(cyclecounter, blob(11:12));                    obj.data(7) = obj.data(7).add_value(cyclecounter, blob(13:14));                    obj.data(8) = obj.data(8).add_value(cyclecounter, blob(15:16));                    obj.data(9) = obj.data(9).add_value(cyclecounter, blob(17:18));                    obj.data(10) = obj.data(10).add_value(cyclecounter, blob(19:20));                    obj.data(11) = obj.data(11).add_value(cyclecounter, blob(21:22));                    obj.data(12) = obj.data(12).add_value(cyclecounter, blob(23:24));                    obj.data(13) = obj.data(13).add_value(cyclecounter, blob(25:26));                case 178 % B2                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3:4));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(5:6));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(7:8));                    obj.data(5) = obj.data(5).add_value(cyclecounter, blob(9:10));                    obj.data(6) = obj.data(6).add_value(cyclecounter, blob(11:12));                case 193 % C1                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:4));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(5:8));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(9:12));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(13:16));                    obj.data(5) = obj.data(5).add_value(cyclecounter, blob(17));                case 194 % C2                case 195 % C3                case 209 % D1                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                case 210 % D2                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1));                case 211 % D3                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3:4));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(5));                case 212 % D4                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3:4));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(5));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(6));                case 213 % D5                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3:4));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(5));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(6));                    obj.data(5) = obj.data(5).add_value(cyclecounter, blob(7));                case 214 % D6                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:2));                    obj.data(2) = obj.data(2).add_value(cyclecounter, blob(3));                    obj.data(3) = obj.data(3).add_value(cyclecounter, blob(4));                    obj.data(4) = obj.data(4).add_value(cyclecounter, blob(5));                    obj.data(5) = obj.data(5).add_value(cyclecounter, blob(6));                case 225 % E1                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1:8));                case 241 % F1                    obj.data(1) = obj.data(1).add_value(cyclecounter, blob(1));                    obj.data(2) = obj.data(1).add_value(cyclecounter, blob(2));            end        end        %%  export function                function out = export(obj)            switch obj.datatype                case 161 % A1                case 162 % A2                                    case 163 % A3                    out= obj.data(1).values';                case 177 % B1                case 178 % B2                                    case 193 % C1                                    case 194 % C2                case 195 % C3                case 209 % D1                                    case 210 % D2                                    case 211 % D3                                    case 212 % D4                                    case 213 % D5                                    case 214 % D6                                    case 225 % E1                                    case 241 % F1                                end        end        %% plot function                function obj = plot_all(obj,measureID,startTime)            figure();            set(gca,'fontsize',20) % set fontsize of the plot to 20            set(gcf, 'Position', get(0,'Screensize')); % automatic full screen            set(0, 'DefaultAxesFontSize', 20);            switch obj.datatype                case 161 % A1                    subplotArray(1) = subplot(2,3,1:3);                    obj.data(1).plot(startTime,true);                    subplotArray(2) =  subplot(2,3,4);                    obj.data(2).plot(startTime,false);                    subplotArray(3) =  subplot(2,3,5);                    obj.data(3).plot(startTime,false);                    subplotArray(4) =  subplot(2,3,6);                    obj.data(4).plot(startTime,false);                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);                    linkaxes(subplotArray,'x');                    figure()                    set(gca,'fontsize',20) % set fontsize of the plot to 20                    set(gcf, 'Position', get(0,'Screensize')); % automatic full screen                    set(0, 'DefaultAxesFontSize', 20);                    plot(obj.data(2).values, obj.data(3).values,'+');                    axis equal;                    limValue = max(abs([obj.data(2).values; obj.data(3).values]),[],'all');                    if( limValue >0)                        axis ([-limValue limValue -limValue limValue]);                    end                    xlabel(obj.data(2).name);                    ylabel(obj.data(3).name);                case 162 % A2                    subplotArray(1) = subplot(2,4,1:4);                    obj.data(1).plot(startTime,true);                    subplotArray(2) = subplot(2,4,5);                    obj.data(2).plot(startTime,false);                    subplotArray(3) = subplot(2,4,6);                    obj.data(3).plot(startTime,false);                    subplotArray(4) = subplot(2,4,7);                    obj.data(4).plot(startTime,false);                    subplotArray(5) = subplot(2,4,8);                    obj.data(4).plot(startTime,false);                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);                    linkaxes(subplotArray,'x');                    figure()                    set(gca,'fontsize',20) % set fontsize of the plot to 20                    set(gcf, 'Position', get(0,'Screensize')); % automatic full screen                    set(0, 'DefaultAxesFontSize', 20);                    plot(obj.data(2).values, obj.data(3).values,'+');                    axis equal;                    limValue = max(abs([obj.data(2).values; obj.data(3).values]),[],'all');                    if( limValue >0)                        axis ([-limValue limValue -limValue limValue]);                    end                    xlabel(obj.data(2).name);                    ylabel(obj.data(3).name);                case 163 % A3                    subplotArray(1) = subplot(2,3,1:3);                    obj.data(1).plot(startTime,true);                    subplotArray(2) =subplot(2,3,4);                    obj.data(2).plot(startTime,false);                    subplotArray(3) =subplot(2,3,5);                    obj.data(3).plot(startTime,false);                    subplotArray(4) =subplot(2,3,6);                    obj.data(4).plot(startTime,false);                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);                    linkaxes(subplotArray,'x');                    figure()                    set(gca,'fontsize',20) % set fontsize of the plot to 20                    set(gcf, 'Position', get(0,'Screensize')); % automatic full screen                    set(0, 'DefaultAxesFontSize', 20);                    plot(obj.data(2).values, obj.data(3).values,'+');                    axis equal;                    limValue = max(abs([obj.data(2).values; obj.data(3).values]),[],'all');                    if( limValue >0)                        axis ([-limValue limValue -limValue limValue]);                    end                    xlabel(obj.data(2).name);                    ylabel(obj.data(3).name);                case 177 % B1                    subplotArray(1) = subplot(3,1,1);                    obj.data(1).plot(startTime,false);                    subplotArray(2) =subplot(3,1,2);                    obj.data(2).plot(startTime,false);                    subplotArray(3) = subplot(3,1,3);                    obj.data(3).plot(startTime,true);                    linkaxes(subplotArray,'x');                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);                    figure();                    set(gca,'fontsize',20) % set fontsize of the plot to 20                    set(gcf, 'Position', get(0,'Screensize')); % automatic full screen                    set(0, 'DefaultAxesFontSize', 20);                    subplotArray(1) = subplot(3,1,1);                    obj.data(4).plot(startTime,false);                    subplotArray(2) = subplot(3,1,2);                    obj.data(5).plot(startTime,false);                    subplotArray(3) = subplot(3,1,3);                    obj.data(6).plot(startTime,true);                    linkaxes(subplotArray,'x');                case 178 % B2                    subplotArray(1) = subplot(3,1,1);                    obj.data(1).plot(startTime,false);                    subplotArray(2) = subplot(3,1,2);                    obj.data(2).plot(startTime,false);                    subplotArray(3) = subplot(3,1,3);                    obj.data(3).plot(startTime,true);                    linkaxes(subplotArray,'x');                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);                    figure();                    set(gca,'fontsize',20) % set fontsize of the plot to 20                    set(gcf, 'Position', get(0,'Screensize')); % automatic full screen                    set(0, 'DefaultAxesFontSize', 20);                    subplotArray(1) = subplot(3,1,1);                    obj.data(4).plot(startTime,false);                    subplotArray(2) = subplot(3,1,2);                    obj.data(5).plot(startTime,false);                    subplotArray(3) =subplot(3,1,3);                    obj.data(6).plot(startTime,true);                    linkaxes(subplotArray,'x');                case 193 % C1                    subplotArray(1) = subplot(2,1,1);                    obj.data(1).plot(startTime,false);                    subplotArray(2) = subplot(2,1,2);                    obj.data(2).plot(startTime,true);                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);                    linkaxes(subplotArray,'x');                    figure();                    set(gca,'fontsize',20) % set fontsize of the plot to 20                    set(gcf, 'Position', get(0,'Screensize')); % automatic full screen                    set(0, 'DefaultAxesFontSize', 20);                    subplotArray(1) = subplot(3,1,1);                    obj.data(3).plot(startTime,false);                    subplotArray(2) = subplot(3,1,2);                    obj.data(4).plot(startTime,false);                    subplotArray(3) =subplot(3,1,3);                    obj.data(5).plot(startTime,true);                    linkaxes(subplotArray,'x');                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);                    figure()                    set(gca,'fontsize',20) % set fontsize of the plot to 20                    set(gcf, 'Position', get(0,'Screensize')); % automatic full screen                    set(0, 'DefaultAxesFontSize', 20);                    plot(obj.data(1).values, obj.data(2).values,'+');                    axis equal;                    limValue = max(abs([obj.data(1).values; obj.data(2).values]),[],'all');                    if( limValue >0)                        axis ([-limValue limValue -limValue limValue]);                    end                    xlabel(obj.data(1).name);                    ylabel(obj.data(2).name);                case 194 % C2                    disp([obj.name " is not yet programmed"]);                case 195 % C3                    disp([obj.name " is not yet programmed"]);                case 209 % D1                    obj.data(1).plot(startTime,true);                case 210 % D2                    obj.data(1).plot(startTime,true);                case 211 % D3                    subplotArray(1) =subplot(2,2,1:2);                    obj.data(1).plot(startTime,true);                    subplotArray(2) =subplot(2,2,3);                    obj.data(2).plot(startTime,false);                    subplotArray(3) = subplot(2,2,4);                    obj.data(3).plot(startTime,false);                    linkaxes(subplotArray,'x');                case 212 % D4                    subplotArray(1) = subplot(2,3,1:3);                    obj.data(1).plot(startTime,true);                    subplotArray(2) = subplot(2,3,4);                    obj.data(2).plot(startTime,false);                    subplotArray(3) = subplot(2,3,5);                    obj.data(3).plot(startTime,false);                    subplotArray(4) = subplot(2,3,5);                    obj.data(4).plot(startTime,false);                    linkaxes(subplotArray,'x');                case 213 % D5                    subplotArray(1) =subplot(2,4,1:4);                    obj.data(1).plot(startTime,true);                    subplotArray(2) = subplot(2,4,5);                    obj.data(2).plot(startTime,false);                    subplotArray(3) = subplot(2,4,6);                    obj.data(3).plot(startTime,false);                    subplotArray(4) = subplot(2,4,7);                    obj.data(4).plot(startTime,false);                    subplotArray(5) = subplot(2,4,8);                    obj.data(5).plot(startTime,false);                    linkaxes(subplotArray,'x');                case 214 % D6                    subplotArray(1) = subplot(2,4,1:4);                    obj.data(1).plot(startTime,true);                    subplotArray(2) = subplot(2,4,5);                    obj.data(2).plot(startTime,false);                    subplotArray(3) = subplot(2,4,6);                    obj.data(3).plot(startTime,false);                    subplotArray(4) = subplot(2,4,7);                    obj.data(4).plot(startTime,false);                    subplotArray(5) = subplot(2,4,8);                    obj.data(5).plot(startTime,false);                    linkaxes(subplotArray,'x');                case 225 % E1                    disp([obj.name " is not yet programmed"]);                case 241 % F1                    disp([obj.name " is not yet programmed"]);            end                    suptitle([obj.name newline  '- ' ...                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - ']);        end    endend