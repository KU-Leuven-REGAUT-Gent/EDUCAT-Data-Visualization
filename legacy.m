%% GITHUB
git_pull = input(' Do you want to pull the latest version from GITHUB (Y/N): ','s');
if git_pull == "Y" || git_pull == "y" || git_pull == "yes"
    !git pull
    warning off backtrace;  
    warning("Script executing has stopped to allow for a Github pull");
    warning on backtrace;  
    return;
end

%% EDUCAT database visualization
% TIP: When requesting new data or starting a new connection  --> right click and select " clear all Output" 
clear
clc
close all
import classes.*
m = measurement();
m = m.connect();

m.list

%% Declaration of measurement
id = 58;
if( size(find(m.list.id == id),1)==1 && m.list.count(find(m.list.id == id,1)) > 2)
    disp('ID exists, running...')
    m=m.set_measurement_ID(id);
    m = m.declaration();
    % ******* get data ********
    m = m.get_dataset_DB();
    disp("done")
    duration = datetime(m.end_time, 'convertfrom','posixtime') - datetime(m.start_time, 'convertfrom','posixtime');
    disp(['duration: ' datestr(duration,'HH:MM:SS.FFF')])
elseif m.list.count(find(m.list.id == id,1)) < 2
    disp("measurement contains no data")
else
    disp("ID does not exist in database")
end

%% Export data to workspace
m.exportData();


%% Plot all measurement information
close all;
 
display(['Moment of measurement: ' datestr(datetime(m.start_time, 'convertfrom','posixtime'),'yyyy-mm-dd HH:MM:SS.FFF')]);

if  exist('id','var')
    if  m.list.count(find(m.list.id == id,1)) > 2
        m.plot_all();
    elseif m.list.count < 2
        disp("measurement contains no data")
    else
        disp("ID does not exist in database")
    end
else
    disp("get first the data")
end


%% save workspace to .mat file in data folder
StoreName = 'filename'; 
if ~exist('data', 'dir')
    mkdir('data')
end
store = fullfile(pwd, 'data', [StoreName '.mat']);
save(store);


%% Own analysis: type your own commands
 
time = (1:size(m.instruments(1,2).data(1,6).values,2))*0.02 + m.start_time;
figure();
fontsize = 20;
set(gca,'fontsize',fontsize) % set fontsize of the plot to 20
set(gcf, 'Position', get(0,'Screensize')); % automatic full screen
set(0, 'DefaultAxesFontSize', fontsize);
plot(time,m.instruments(1,1).data(1,2).values,'LineWidth',2)
ylabel("Turn",'fontsize',fontsize);
ax1 = gca;
yyaxis right
plot(time, m.instruments(1,2).data(1,6).values,'LineWidth',2)
xlabel('Time [s]','fontsize',fontsize);
ylabel("gz",'fontsize',fontsize);
xlim(([min(time) (max(time))]));
title("gz vs turn" ,'fontsize',fontsize);
legend(["turn","gz"]);

%% Heatmaps
% figure()
% heatmap([m.instruments(1,1).data(1,2).values m.instruments(1,2).data(1,6).values])











