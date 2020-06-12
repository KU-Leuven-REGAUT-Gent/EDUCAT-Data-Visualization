classdef instrument
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
            length
    end
    methods
        %%  *************** constructor *******************
        function obj = instrument(id, name, description, datatype,maxCycleCount)
            %constructor of the instrument
            %Declaration of the ID, name, description and the datatype of
            %the instrument.
            %Creation of the different sensordata object of each
            %instrument.
            
            obj.id = id;
            obj.name = name;
            obj.description = description;
            obj.datatype = datatype;
            switch obj.datatype
                case 161 % A1 JOYSTICK_DX2_OUTPUT
                    obj.length = 5;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                case 162 % A2 JOYSTICK_PG_OUTPUT
                    obj.length = 6;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                    obj.data(5) = classes.data("Mode","number","int_8",maxCycleCount);
                case 163 % A3 JOYSTICK_LINX_OUTPUT
                    obj.length = 5;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Actual speed","mm/s","int_16",maxCycleCount);
                    obj.data(2) = classes.data("Turn","raw","int_8",maxCycleCount);
                    obj.data(3) = classes.data("Speed","raw","int_8",maxCycleCount);
                    obj.data(4) = classes.data("Profile","number","int_8",maxCycleCount);
                case 177 % B1 IMU_9AXIS_ROT_VEC
                    obj.length = 26;
                    obj.data = classes.data.empty(0,obj.length);
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
                    obj.length = 12;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("ax","cm/s^2","int_16",maxCycleCount);
                    obj.data(2) = classes.data("ay","cm/s^2","int_16",maxCycleCount);
                    obj.data(3) = classes.data("az","cm/s^2","int_16",maxCycleCount);
                    obj.data(4) = classes.data("gx","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(5) = classes.data("gy","0.01 degree/s","int_16",maxCycleCount);
                    obj.data(6) = classes.data("gz","0.01 degree/s","int_16",maxCycleCount);
                case 193 % C1 GPS_MIN_DATA
                    obj.length = 17;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("longitude","degrees","float_32",maxCycleCount);
                    obj.data(2) = classes.data("latitude","degrees","float_32",maxCycleCount);
                    obj.data(3) = classes.data("hMSL","m","float_32",maxCycleCount);
                    obj.data(4) = classes.data("speed","m/s","float_32",maxCycleCount);
                    obj.data(5) = classes.data("reception","-","int_8",maxCycleCount);
                case 194 % C2 GPS_STATUS
                    error("Datatype unsupported - not yet implemented");
                case 195 % C3 GPS_DATA_STATUS
                    error("Datatype unsupported - not yet implemented");
                case 209 % D1 AN_DISTANCE_NODES D1 (US)
                    obj.length = 2;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("US","cm","uint_16",maxCycleCount);
                case 210 % D2 CAN_DISTANCE_NODES D2 (IR)
                    obj.length = 1;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("IR","cm","uint_8",maxCycleCount);
                case 211 % D3 CAN_DISTANCE_NODES D3 (US+IR)
                    obj.length = 5;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    obj.data(2) = classes.data("US","cm?","uint_16",maxCycleCount);
                    obj.data(3) = classes.data("IR","cm?","uint_8",maxCycleCount);
                case 212 % D4 CAN_DISTANCE_NODES D4 (US+2IR)
                    obj.length = 6;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    obj.data(2) = classes.data("US","cm?","uint_16",maxCycleCount);
                    obj.data(3) = classes.data("IR 1","cm?","uint_8",maxCycleCount);
                    obj.data(4) = classes.data("IR 2","cm?","uint_8",maxCycleCount);
                case 213 % D5 CAN_DISTANCE_NODES D5 (US+3IR)
                    obj.length = 7;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    obj.data(2) = classes.data("US","cm?","uint_16",maxCycleCount);
                    obj.data(3) = classes.data("IR 1","cm?","uint_8",maxCycleCount);
                    obj.data(4) = classes.data("IR 2","cm?","uint_8",maxCycleCount);
                    obj.data(5) = classes.data("IR 3","cm?","uint_8",maxCycleCount);
                case 214 % D6  CAN_DISTANCE_NODES D6(4IR)
                    obj.length = 6;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated","cm","uint_16",maxCycleCount);
                    obj.data(2) = classes.data("IR 1","cm?","uint_8",maxCycleCount);
                    obj.data(3) = classes.data("IR 2","cm?","uint_8",maxCycleCount);
                    obj.data(4) = classes.data("IR 3","cm?","uint_8",maxCycleCount);
                    obj.data(5) = classes.data("IR 4","cm?","uint_8",maxCycleCount);
                case 215 % D7  CAN_DISTANCE_NODES D7 (4IR) Only Calculated Value
                    obj.length = 2;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("Calculated distance","cm","uint_16",maxCycleCount);
                case 225 % E1 Real Time Clock
                    obj.length = 8;
                    obj.data = classes.data.empty(0,obj.length);
                    obj.data(1) = classes.data("unix_epoch_ms","ms","uint_64",maxCycleCount);
                case 241 % F1 Android Device
                    obj.length = 2;
                    obj.data = classes.data.empty(0,4);
                    obj.data(1) = classes.data("OAS Calculated Value","","uint_8",maxCycleCount);
                    obj.data(2) = classes.data("Buzzer","","boolean",maxCycleCount);
                    obj.data(3) = classes.data("Haptic Feedback","","boolean",maxCycleCount);
                    obj.data(4) = classes.data("Visual Feedback","","boolean",maxCycleCount);
                    
                case 242 % F2 Android Device
                    obj.length = 3;
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
        function obj = add_data(obj, cyclecounter_list, blob)
            % add data to the sensordata object of the instrument
            switch obj.datatype
                case 161 % A1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                case 162 % A2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    obj.data(5) = obj.data(4).add_value(cyclecounter_list, blob(:,6));
                case 163 % A3
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
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
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                case 212 % D4
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,6));
                case 213 % D5
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3:4));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,5));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,6));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,7));
                case 214 % D6
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, blob(:,3));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, blob(:,4));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, blob(:,5));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, blob(:,6));
                case 215 % D7
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:2));
                case 225 % E1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1:8));
                case 241 % F1
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, bitand(blob(:,2),1));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, bitand(blob(:,2),2));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, bitand(blob(:,2),4));
                case 242 % F2
                    obj.data(1) = obj.data(1).add_value(cyclecounter_list, blob(:,1));
                    obj.data(2) = obj.data(2).add_value(cyclecounter_list, bitand(blob(:,2),1));
                    obj.data(3) = obj.data(3).add_value(cyclecounter_list, bitand(blob(:,2),2));
                    obj.data(4) = obj.data(4).add_value(cyclecounter_list, bitand(blob(:,2),4));
                    obj.data(5) = obj.data(5).add_value(cyclecounter_list, bitand(blob(:,3),1));
                    obj.data(6) = obj.data(6).add_value(cyclecounter_list, bitand(blob(:,3),2));
                    obj.data(7) = obj.data(7).add_value(cyclecounter_list, bitand(blob(:,3),4));
                    obj.data(8) = obj.data(8).add_value(cyclecounter_list, bitand(blob(:,3),8));
                    obj.data(9) = obj.data(9).add_value(cyclecounter_list, bitand(blob(:,3),16));
                    obj.data(10) = obj.data(10).add_value(cyclecounter_list, bitand(blob(:,3),32));
                    obj.data(11) = obj.data(11).add_value(cyclecounter_list, bitand(blob(:,3),64));
                    obj.data(12) = obj.data(12).add_value(cyclecounter_list, bitand(blob(:,3),128));
            end
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
        
        %%  *************** plot function *******************
        function obj = plot_all(obj,measureID,startTime)
            % plot all the sensordata object of the instrument.
            % It plots with the following settings:
            % - Font size= 20
            % - Plots on fullscreen figure
            % - X-axis is linked with the other subplots
            % - The axes hava a default axis font size of 18 or 14.
            % - The figures gets a title in the format:
            %   -   starttime - measurement ID: xx -
            
            figure();
            set(gca,'fontsize',20) % set fontsize of the plot to 20
            set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
            set(0, 'DefaultAxesFontSize', 18);
            switch obj.datatype
                case 161 % A1
                    subplotArray(1) = subplot(2,3,1:3);
                    obj.data(1).plot(startTime,true,true);
                    subplotArray(2) =  subplot(2,3,4);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) =  subplot(2,3,5);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) =  subplot(2,3,6);
                    obj.data(4).plot(startTime,true,false);
                    Title = [obj.name newline  '- ' ...
                        datestr(startTime,'dd/mm/yyyy') ,...
                        ' - measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',20);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    try
                        sgtitle('Joystick Deflection Pattern','fontsize',20);
                    catch
                        suptitle('Joystick Deflection Pattern');
                    end
                    plot(obj.data(2).values, obj.data(3).values,'+');
                    axis equal;
                    limValue = max(abs([obj.data(2).values; obj.data(3).values]))*1.1;
                    if( limValue >0)
                        axis ([-limValue limValue -limValue limValue]);
                    end
                    xlabel(obj.data(2).name);
                    ylabel(obj.data(3).name);
                    % *************** heatmap ****************
                    % 5x5 grid heatmap
                    R = 100;
                    XgridEdges = -R:(R*2)/5:R;
                    YgridEdges =-R:(R*2)/5:R;
                    cData = histcounts2(obj.data(2).values,obj.data(3).values,XgridEdges,YgridEdges);
                    cData = rot90(cData); % this is needed because the hitscounts2 rotates the result
                    cData = cData/size(obj.data(2).values,1)*100; %
                    
                    limit = 127/(5/2)*floor(5/2);
                    clusteredSpeed = linspace(limit,-limit,5);
                    clusteredTurn = linspace(-limit,limit,5);
                    % create heatmap
                    figure
                    h = heatmap(clusteredTurn,clusteredSpeed,cData);
                    h.ColorLimits = [0 100];
                    h.Title="5x5 joystick deflection Heat Map";
                    colormap default
                    
                    % ------ Adjustable heatmap --------
                    % binning data
                    gridSize =evalin('base', 'gridSize');
                    XgridEdges = -R:(R*2)/gridSize:R;
                    YgridEdges =-R:(R*2)/gridSize:R;
                    cData = histcounts2(obj.data(2).values,obj.data(3).values,XgridEdges,YgridEdges);
                    cData = rot90(cData); % this is needed because the hitscounts2 rotates the result
                    cData = cData/size(obj.data(2).values,1)*100; %
                    
                    limit = 127/(gridSize/2)*floor(gridSize/2);
                    clusteredSpeed = linspace(limit,-limit,gridSize);
                    clusteredTurn = linspace(-limit,limit,gridSize);
                    % create heatmap
                    figure
                    h = heatmap(clusteredTurn,clusteredSpeed,cData);
                    h.ColorLimits = [0 100];
                    h.Title = strcat(string(gridSize), "x", string(gridSize), " joystick deflection Heat Map");
                    colormap default
                    
                case 162 % A2
                    subplotArray(1) = subplot(2,4,1:4);
                    obj.data(1).plot(startTime,true,true);
                    subplotArray(2) = subplot(2,4,5);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(2,4,6);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) = subplot(2,4,7);
                    obj.data(4).plot(startTime,true,false);
                    subplotArray(5) = subplot(2,4,8);
                    obj.data(4).plot(startTime,true,false);
                    Title =[obj.name newline  '- ' ...
                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...
                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',20);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    try
                        sgtitle('Joystick Deflection Pattern','fontsize',20);
                    catch
                        suptitle('Joystick Deflection Pattern');
                    end
                    
                    plot(obj.data(2).values, obj.data(3).values,'+');
                    axis equal;
                    limValue = max(abs([obj.data(2).values; obj.data(3).values]));
                    if( limValue >0)
                        axis ([-limValue limValue -limValue limValue]);
                    end
                    xlabel(obj.data(2).name);
                    ylabel(obj.data(3).name);
                   
                    % *************** heatmap ****************
                    % 5x5 grid heatmap
                    R = 100;
                    XgridEdges = -R:(R*2)/5:R;
                    YgridEdges =-R:(R*2)/5:R;
                    cData = histcounts2(obj.data(2).values,obj.data(3).values,XgridEdges,YgridEdges);
                    cData = rot90(cData); % this is needed because the hitscounts2 rotates the result
                    cData = cData/size(obj.data(2).values,1)*100; %                 
                    limit = R/(5/2)*floor(5/2);
                    clusteredSpeed = linspace(limit,-limit,5);
                    clusteredTurn = linspace(-limit,limit,5);
                    % create heatmap
                    figure
                    h = heatmap(clusteredTurn,clusteredSpeed,cData);
                    h.ColorLimits = [0 100];
                    h.Title = "5x5 joystick deflection Heat Map";
                    colormap default
                    
                    % ------ Adjustable heatmap --------
                    % binning data
                    gridSize =evalin('base', 'gridSize');
                    XgridEdges = -R:(R*2)/gridSize:R;
                    YgridEdges =-R:(R*2)/gridSize:R;
                    cData = histcounts2(obj.data(2).values,obj.data(3).values,XgridEdges,YgridEdges);
                    cData = rot90(cData); % this is needed because the hitscounts2 rotates the result
                    cData = cData/size(obj.data(2).values,1)*100; %
                    
                    limit = R/(gridSize/2)*floor(gridSize/2);
                    clusteredSpeed = linspace(limit,-limit,gridSize);
                    clusteredTurn = linspace(-limit,limit,gridSize);
                    % create heatmap
                    figure
                    h = heatmap(clusteredTurn,clusteredSpeed,cData);
                    h.ColorLimits = [0 100];
                    h.Title = strcat(string(gridSize), "x", string(gridSize), " joystick deflection Heat Map");
                    colormap default
                case 163 % A3
                    subplotArray(1) = subplot(2,3,1:3);
                    obj.data(1).plot(startTime,true,true);
                    subplotArray(2) =subplot(2,3,4);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) =subplot(2,3,5);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) =subplot(2,3,6);
                    obj.data(4).plot(startTime,true,false);
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...
                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',20);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    try
                        sgtitle('Joystick Deflection Pattern','fontsize',20);
                    catch
                        suptitle('Joystick Deflection Pattern');
                    end
                    plot(obj.data(2).values, obj.data(3).values,'+');
                    axis equal;
                    limValue = max(abs([obj.data(2).values; obj.data(3).values]));
                    if( limValue >0)
                        axis ([-limValue limValue -limValue limValue]);
                    end
                    xlabel(obj.data(2).name);
                    ylabel(obj.data(3).name);
                                        
                    % *************** heatmap ****************
                    % 5x5 grid heatmap
                    R = 100;
                    XgridEdges = -R:(R*2)/5:R;
                    YgridEdges =-R:(R*2)/5:R;
                    cData = histcounts2(obj.data(2).values,obj.data(3).values,XgridEdges,YgridEdges);
                    cData = rot90(cData); % this is needed because the hitscounts2 rotates the result
                    cData = cData/size(obj.data(2).values,1)*100; %
                    
                    limit = 100/(5/2)*floor(5/2);
                    clusteredSpeed = linspace(limit,-limit,5);
                    clusteredTurn = linspace(-limit,limit,5);
                    % create heatmap
                    figure
                    h = heatmap(clusteredTurn,clusteredSpeed,cData);
                    h.ColorLimits = [0 100];
                    h.Title = "5x5 joystick deflection Heat Map";
                    colormap default
                    % ------- Adjustable heatmap --------
                    % binning data
                    gridSize =evalin('base', 'gridSize'); 
                    XgridEdges = -R:(R*2)/gridSize:R;
                    YgridEdges =-R:(R*2)/gridSize:R;
                    cData = histcounts2(obj.data(2).values,obj.data(3).values,XgridEdges,YgridEdges);
                    cData = rot90(cData); % this is needed because the hitscounts2 rotates the result
                    cData = cData/size(obj.data(2).values,1)*100; %
                    
                    limit = 100/(gridSize/2)*floor(gridSize/2);
                    clusteredSpeed = linspace(limit,-limit,gridSize);
                    clusteredTurn = linspace(-limit,limit,gridSize);
                    % create heatmap
                    figure
                    h = heatmap(clusteredTurn,clusteredSpeed,cData);
                    h.ColorLimits = [0 100];
                    h.Title = strcat(string(gridSize), "x", string(gridSize), " joystick deflection Heat Map");
                    colormap default
                case 177 % B1
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false);
                    subplotArray(2) =subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...
                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',20);
                    catch
                        suptitle(Title);
                    end
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
                case 178 % B2
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(1).plot(startTime,true,false);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(3,1,3);
                    obj.data(3).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...
                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',20);
                    catch
                        suptitle(Title);
                    end
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(4).plot(startTime,true,false);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(5).plot(startTime,true,false);
                    subplotArray(3) =subplot(3,1,3);
                    obj.data(6).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
                case 193 % C1
                    subplotArray(1) = subplot(2,1,1);
                    obj.data(1).plot(startTime,true,false);
                    subplotArray(2) = subplot(2,1,2);
                    obj.data(2).plot(startTime,true,true);
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...
                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',20);
                    catch
                        suptitle(Title);
                    end
                    linkaxes(subplotArray,'x');
                    figure();
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    subplotArray(1) = subplot(3,1,1);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(2) = subplot(3,1,2);
                    obj.data(4).plot(startTime,true,false);
                    subplotArray(3) =subplot(3,1,3);
                    obj.data(5).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
                    Title = [obj.name newline  '- ' ...
                        datestr(datetime(startTime, 'convertfrom','posixtime'), ...
                        'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - '];
                    try
                        sgtitle(Title,'fontsize',20);
                    catch
                        suptitle(Title);
                    end
                    figure()
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    plot(obj.data(1).values, obj.data(2).values,'+');
                    axis equal;
                    limValue = max(abs([obj.data(1).values; obj.data(2).values]))*1.1;
                    if( limValue >0)
                        axis ([-limValue limValue -limValue limValue]);
                    end
                    xlabel(obj.data(1).name);
                    ylabel(obj.data(2).name);
                case 194 % C2
                    disp([obj.name " is not yet programmed"]);
                case 195 % C3
                    disp([obj.name " is not yet programmed"]);
                case 209 % D1
                    obj.data(1).plot(startTime,false,true);
                case 210 % D2
                    obj.data(1).plot(startTime,false,true);
                case 211 % D3
                    subplotArray(1) =subplot(2,2,1:2);
                    obj.data(1).plot(startTime,true,true);
                    subplotArray(2) =subplot(2,2,3);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(2,2,4);
                    obj.data(3).plot(startTime,true,false);
                    linkaxes(subplotArray,'x');
                case 212 % D4
                    subplotArray(1) = subplot(2,3,1:3);
                    obj.data(1).plot(startTime,true,true);
                    subplotArray(2) = subplot(2,3,4);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(2,3,5);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) = subplot(2,3,5);
                    obj.data(4).plot(startTime,true,false);
                    linkaxes(subplotArray,'x');
                case 213 % D5
                    subplotArray(1) =subplot(2,4,1:4);
                    obj.data(1).plot(startTime,true,true);
                    subplotArray(2) = subplot(2,4,5);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(2,4,6);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) = subplot(2,4,7);
                    obj.data(4).plot(startTime,true,false);
                    subplotArray(5) = subplot(2,4,8);
                    obj.data(5).plot(startTime,true,false);
                    linkaxes(subplotArray,'x');
                case 214 % D6
                    subplotArray(1) = subplot(2,4,1:4);
                    obj.data(1).plot(startTime,true,true);
                    subplotArray(2) = subplot(2,4,5);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(2,4,6);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) = subplot(2,4,7);
                    obj.data(4).plot(startTime,true,false);
                    subplotArray(5) = subplot(2,4,8);
                    obj.data(5).plot(startTime,true,false);
                    linkaxes(subplotArray,'x');
                case 215 % D7
                    obj.data(1).plot(startTime,false,true);
                case 225 % E1
                    obj.data(1).plot(startTime,false,true);
                case 241 % F1
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
                case 242 % F2
                    subplotArray(1) = subplot(4,1,1);
                    obj.data(1).plot(startTime,true,false);
                    subplotArray(2) = subplot(4,1,2);
                    obj.data(2).plot(startTime,true,false);
                    subplotArray(3) = subplot(4,1,3);
                    obj.data(3).plot(startTime,true,false);
                    subplotArray(4) = subplot(4,1,4);
                    obj.data(4).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
                    figure()
                    set(gca,'fontsize',20) % set fontsize of the plot to 20
                    set(gcf,'units','normalized','outerposition',[0 0 1 1]) % full screen
                    set(0, 'DefaultAxesFontSize', 18);
                    subplotArray(1) = subplot(4,2,1);
                    obj.data(5).plot(startTime,true,false);
                    subplotArray(2) = subplot(4,2,2);
                    obj.data(6).plot(startTime,true,false);
                    subplotArray(3) = subplot(4,2,3);
                    obj.data(7).plot(startTime,true,false);
                    subplotArray(4) = subplot(4,2,4);
                    obj.data(8).plot(startTime,true,true);
                    subplotArray(5) = subplot(4,2,5);
                    obj.data(9).plot(startTime,true,false);
                    subplotArray(6) = subplot(4,2,6);
                    obj.data(10).plot(startTime,true,false);
                    subplotArray(7) = subplot(4,2,7);
                    obj.data(11).plot(startTime,true,false);
                    subplotArray(8) = subplot(4,2,8);
                    obj.data(12).plot(startTime,true,true);
                    linkaxes(subplotArray,'x');
            end
            Title = [obj.name newline  '- ' ...
                datestr(datetime(startTime, 'convertfrom','posixtime'), ...
                'dd/mm/yyyy') ' - measurement ID: ' num2str(measureID) ' - '];
            if obj.datatype ~= 161 && obj.datatype  ~= 162 && obj.datatype  ~= 242
                try
                    sgtitle(Title,'fontsize',20);
                catch
                    suptitle(Title);
                end
            end
            pause(0.1)
        end
    end
end