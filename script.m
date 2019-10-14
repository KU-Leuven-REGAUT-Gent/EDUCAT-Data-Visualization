%% INITIALIZE THE OBJECT(S)
m = measurement(53);

%% LOAD all current datasets
m = m.get_datasets();

%% Plot all measurement information
close all;
m.plot_all();

%% Loop and add live datasets
% loop and plot