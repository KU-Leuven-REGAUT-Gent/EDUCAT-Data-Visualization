function popup(m,fctn)
fig = uifigure;

% Desired Window width and height
  GuiWidth = 500;
  if contains(fctn,'plot')
      instrumentList = isprop(m.instruments,'extracted');
      n_instruments = sum(instrumentList);
      instrumentList= find(instrumentList==1);
      lblText = 'Indicate which instruments that must be plotted:';
  else
      instrumentList = 1:m.n_instruments;
      n_instruments = m.n_instruments;
      lblText = 'Indicate which instruments that should not be retrieved:';
  end
  GuiHeight = 30+50+n_instruments*30+10;

% Find Screen Resolution
  temp = figposition([0,0,100,100]);
  ScreenWidth = temp(3);
  ScreenHeight = temp(4);
  
set (fig, 'position', [ScreenWidth/2 - GuiWidth/2, ScreenHeight/2 - GuiHeight/2, GuiWidth, GuiHeight]);

fig.Name = 'EDUCAT extraction option';
height= (n_instruments+1)*30+20;
lbl = uilabel(fig);
lbl.Text = lblText;
lbl.FontSize = 14;
lbl.FontWeight= 'bold';
lbl.Position = [10 height 400 30];
cb = gobjects(n_instruments,1);
for ii = instrumentList
  cb(ii) = uicheckbox('Parent',fig,'Position',[20 height - ii*30 200 30]);
      
  cb(ii).Text = m.instruments(ii).name; 
 
end
uibutton('Parent',fig,'Position',[10 15 50 30],'Text','confirm',...
            'ButtonPushedFcn', @(btn,event) plotButtonPushed(cb,instrumentList));
        uiwait (fig);
end



% Create the function for the ButtonPushedFcn callback
function plotButtonPushed(cb,instrumentList)
    ExcludedInstruments= zeros(1,size(instrumentList,2));
    for i=instrumentList
        ExcludedInstruments(i) = cb(i).Value;
    end
     assignin('base','ExcludedInstruments',ExcludedInstruments);
     closereq;
end


