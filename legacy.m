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


id = input('ID: ');
disp("type a date or type full to get the full measurement")  
date = input('Date: ','s');
if ~contains(date,'full')
    duration = input('Duration: ');
end

if( size(find(m.list.id == id),1)==1 && m.list.count(find(m.list.id == id,1)) > 2)
    disp('ID exists, running...')
    tic
    m=m.set_measurement_ID(id);
   % profile on
    m = m.declaration(date,duration);
    disp("Time declaration: " + toc)
    % ******* get data ********
    tic
    m = m.get_dataset_DB();
    disp("Time getting data from DB: " + toc)
    % ******* process data ******
     tic
     m= m.processData_DB();
     disp("Time processing the data: " + toc)
%     disp("done")
%     %profile viewer
    disp("Max cycle count: "+ m.max_cycleCount)
    duration = datetime(m.end_time, 'convertfrom','posixtime') - datetime(m.start_time, 'convertfrom','posixtime');
    disp(['duration: ' datestr(duration,'HH:MM:SS.FFF')])
elseif m.list.count(find(m.list.id == id,1)) < 2
    disp("measurement contains no data")
else
    disp("ID does not exist in database")
end


%% Export data to workspace
export = input('export to workspace (Y/N): ','s');
if  export== "y" || export == "Y" || export == "yes" 
    m.exportData();
end

%% Plot all measurement information

plotting = input('plot the measurement (Y/N): ','s');
if  plotting== "y" || plotting == "Y" || plotting == "yes" 
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
   
end

%% save workspace to .mat file in data folder
SaveWorkspace = input('Save workspace to .mat (Y/N): ','s');
if  SaveWorkspace== "y" || SaveWorkspace == "Y" || SaveWorkspace == "yes" 
    StoreName = 'filename'; 
    if ~exist('data', 'dir')
        mkdir('data')
    end
    store = fullfile(pwd, 'data', [StoreName '.mat']);
    save(store);  
end

%% Own analysis: type your own commands
ownCode = input('Execute own code (Y/N): ','s');
if  ownCode== "y" || ownCode == "Y" || ownCode == "yes" 
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
end


function m = paste(obj)
    m = obj;
end






