function measurement_popup(m)
fig = uifigure;

% Desired Window width and height
GuiWidth = 400;
GuiHeight = 250;

% Find Screen Resolution
temp =get(0,'screensize');
ScreenWidth = temp(3);
ScreenHeight = temp(4);

set (fig, 'position', [ScreenWidth/2 - GuiWidth/2, ScreenHeight/2 - GuiHeight/2, GuiWidth, GuiHeight]);

fig.Name = 'EDUCAT measurement option';

lbl = uilabel(fig);
lbl.Text = "Choose start and end time";
lbl.FontSize = 14;
lbl.FontWeight= 'bold';
lbl.Position = [110 200 400 30];

lblStrt = uilabel(fig);
lblStrt.Text = "Start time";
lblStrt.FontSize = 14;
lblStrt.Position = [10 148 90 30];
StrtTime = uieditfield(fig,...
    'Position',[80 150 300 22]);
StrtTime.Value = datestr(m.start_time,'dd/mm/yyyy HH:MM:SS.FFF');

lblEnd = uilabel(fig);
lblEnd.Text = "End time";
lblEnd.FontSize = 14;
lblEnd.Position = [10 98 90 30];
EndTime = uieditfield(fig,...
    'Position',[80 100 300 22]);
EndTime.Value = datestr(m.end_time,'dd/mm/yyyy HH:MM:SS.FFF');

% Confirm button
uibutton('Parent',fig,'Position',[(GuiWidth/2-40) 40 80 30],'Text','Confirm','FontWeight','bold',...
    'ButtonPushedFcn', @(btn,event) plotButtonPushed(StrtTime.Value,EndTime.Value));
uiwait (fig);
end



% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(strtTime,endTime)

assignin('base','startTime', strtTime);
assignin('base','endTime', endTime);
closereq;
end


