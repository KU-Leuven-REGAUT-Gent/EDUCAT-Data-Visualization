%******************* EDUCAT visualization legacy ********************
%{
%                               Authors:
%                Frederic Depuydt and Dimitri De Schuyter
%
%                               Company: 
%                              KU Leuven  
%
%**********************************************************************
%
%This script is made and optimized for MATLAB R2019a
%Some functions are unsupported in older versions of MATLAB
%-   datetime: the property 'TicksPerSecond' is not supported
%
%This script is made for getting the data from the educat database.
%
%%---------------------- Dependencies ----------------------
%  Needed classes in the folder "+classes":
%
%   *  measurement ( for more info type: doc classes.measurement) 
%   *  instrument  ( for more info type: doc classes.instrument) 
%   *  data        ( for more info type: doc classes.data) 
%
%-  The following toolboxes are needed:
%   -   database_toolbox
%   
%-  For the connection with de EDUCAT database a JDBC MYSQL Connector is
%   required. This driver must be located in the jdbc folder, which is in 
%   the same directory as this script.
%
%-  Optional: installation of git on your computer. This allows to pull the
%   most recent version of the script. For this git software need to be
%   installed. 
%   This can be downloaded from: https://git-scm.com/downloads
%   
% _If you made changes and you get a warning than you can revert the
%   changes by right click on the script which has a blue state.Then click
%   "Source control" --> "Revert local changes"_
%
%Installation guide if not present:
%1) Download the JDBC driver from:
%   https://dev.mysql.com/downloads/file/?id=490495
%2) Unzip the folder in the jdbc folder at the same directory as this
%   legacy.m script
%3) mysql-connector-java-8.0.18.jar musn't be placed in a subdirectory,
%   but directly in the root of the jdbc folder.
%
%---------------------- methods ----------------------
%
%---------------------- Execution order ----------------------
%For each function can be chosen whether or not to execute it.
%1) pull the latest version from GITHUB (only when git is installed on the
%   pc).
%2) Initializing, creating measurement object and start database
%   connection.
%3) Declaration, getting the data and processing of measurement.
%4) Export each sensor to the workspace.
%5) Plot the standard implemented plots.
%6) Save the workspace to .mat
%7) Own analysis code
%}

%% 1) GITHUB
git_pull = input(' Do you want to pull the latest version from GITHUB (Y/N): ','s');
if git_pull == "Y" || git_pull == "y" || git_pull == "yes"
    !git pull
    warning off backtrace;  
    warning("Script executing has stopped to allow for a Github pull");
    warning on backtrace;  
    return;
end

%% 2) EDUCAT database visualization
% TIP: When requesting new data or starting a new connection  --> right click and select " clear all Output" 
% the help function is available trough help classes.measurement
clear
clc
close all
import classes.*
m = measurement();
m = m.connect();

m.list

%% 3) Declaration, getting the data and processing of measurement

id = input('ID: ');
if( size(find(m.list.id == id),1)==1 && m.list.count(find(m.list.id == id,1)) > 2)
    disp("type a date or type full to get the full measurement")  
    date = input('Date: ','s');
    if (~contains(date,'full') && ~isempty(date)) || ~isempty(date)
        duration = input('Duration: ');
    end

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
    disp("done")
    %profile viewer
    disp("Max cycle count: "+ m.max_cycleCount)
    duration = datetime(m.end_time, 'convertfrom','posixtime') - datetime(m.start_time, 'convertfrom','posixtime');
    disp(['duration: ' datestr(duration,'HH:MM:SS.FFF')])
elseif m.list.count(find(m.list.id == id,1)) < 2
    disp("measurement contains no data")
else
    disp("ID does not exist in database")
    exit
end
clear  date duration 

%% 4) Export data to workspace
export = input('export to workspace (Y/N): ','s');
if  contains( export,{'y','j'})
    tic
    m.exportData();
    disp("Time export to workspace: " + toc)
end
clear export

%% 5) Plot all measurement information

plotting = input('plot the measurement (Y/N): ','s');
if   contains(plotting,{'y','j'})
    close all;
    display(['Moment of measurement: ' datestr(datetime(m.start_time, 'convertfrom','posixtime'),'yyyy-mm-dd HH:MM:SS.FFF')]);
    tic  
    if  exist('m','var')
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
    disp("Time plotting: " + toc)
end
clear plotting

%% 6) save workspace to .mat file in data folder
saveWorkspace = input('Save workspace to .mat (Y/N): ','s');
if  contains(saveWorkspace,{'y','j'})
    storeName = strcat('ID',num2str(m.id),'_workspace_ST',datestr(m.start_time,'yyyy_mm_dd_HHMMSS'));
    nameQuestion = strcat('Do you want to change the name of the file: "', storeName, '.mat" \n y/n: ');
    questionResult = input(nameQuestion,'s');
    tic
    if contains(questionResult,{'y','j'})
        storeName = input("filename (without .mat): ",'s'); 
    end
    if ~exist('data', 'dir')
        mkdir('data')
    end
    
    store = fullfile(pwd, 'data', [storeName '.mat']);
    warning off
    clear questionResult nameQuestion storeName  saveWorkspace id
    save(store,'-regexp','^(?!(store|m)$).');  
    if contains(lastwarn ,'serialize object')
        warning(lastwarn);
    end
    disp("Time save workspace: " + toc)
else
  clear  saveWorkspace
end

%% 7 Own analysis: type your own commands
ownCode = input('Execute own code (Y/N): ','s');
if contains(ownCode,{'y','j'}) 
    time = seconds((1:size(m.instruments(1,2).data(1,6).values,2))*0.02) + m.start_time;
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
clear ownCode ans





