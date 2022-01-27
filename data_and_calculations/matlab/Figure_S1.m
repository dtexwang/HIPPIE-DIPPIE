% Supplmeentary Figure S1 for HIPPIE-DIPPIE manuscript
% Maturity (EASY%Ro, EASY%RoB, EASY%RoV) vs. time and vs. Temperature
%
% David T. Wang, June 8th, 2019

clear all;

%% Import Temperature Profile, Maturity Model, and Concentration Data

model = csvread('MaturityCalculation_Redone\Calculated_Mats_for_Paper_EASYRo.csv');
sim_t = model(:,1);     % Simulation time, hours
t_mod = model(:,2);     % Experiment time, hours
T_mod = model(:,3);     % Experiment Temperature, degC
EASYRo_mod = model(:,4);% EASYRo, simulated %Ro

model = csvread('MaturityCalculation_Redone\Calculated_Mats_for_Paper_EASYRoB.csv');
EASYRoB_mod = model(:,4);

model = csvread('MaturityCalculation_Redone\Calculated_Mats_for_Paper_EASYRoV.csv');
EASYRoV_mod = model(:,4);

[num txt raw] = xlsread('concentration\DATAFORMATLAB.xlsx','SummaryConcs');
sam_num = num(:,1);
sam_t = num(:,2);
sam_T = num(:,3);
sam_H2 = num(:,4);      % H2, mol/kg fluid
sam_CH4 = num(:,5);     % CH4
sam_TCO2 = num(:,6);    % TotCO2
sam_C2ene = num(:,7);   % ethylene
sam_C2 = num(:,8);      % ethane
sam_C3ene = num(:,9);   % propylene
sam_C3 = num(:,10);     % propane
sam_MeSH = num(:,11);   % methanethiol
sam_iC4 = num(:,12);    % isobutane
sam_1C4ene = num(:,13); % 1-butene
sam_nC4 = num(:,14);    % n-butane
sam_neoC5 = num(:,15);  % neopentane
sam_iC5 = num(:,16);    % isopentane
sam_1C5ene = num(:,17); % 1-pentene
sam_nC5 = num(:,18);    % n-pentane
sam_1C6ene = num(:,19); % 1-hexene
sam_nC6 = num(:,20);    % n-hexane
sam_H2S = num(:,21);    % H2S, gravimetric
sam_pH = num(:,22);     % pH measured with electrode.  pD = pHmeas + 0.41

%% Interpolate EASYRo for data points
sam_EASYRo = interp1(t_mod, EASYRo_mod, sam_t);
sam_EASYRoB = interp1(t_mod, EASYRoB_mod, sam_t);
sam_EASYRoV = interp1(t_mod, EASYRoV_mod, sam_t);

%% Plot Figure 

figure(54); clf;
ha = tight_subplot(1, 2, 0.03, [0.12 0.05], [0.10 0.05])

axes(ha(1))
semilogy(t_mod, [EASYRo_mod EASYRoB_mod EASYRoV_mod], '-'); hold on;
plot(sam_t, [sam_EASYRo sam_EASYRoB sam_EASYRoV], 'o', ...
    'MarkerFaceColor', 'w');
set(gca(), 'XLim', [-100 900])
set(gca(), 'YLim', [0.2 1.8])
set(gca(), 'FontName', 'EMprint')
% grid on
% grid minor
set(gca(), 'TickLength', 2.5*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'on')
ytickformat('%.1f')
set(gca(), 'LineWidth', 0.5)    % default box line width is 0.5
legend({'EASY%Ro', 'EASY%RoB', 'EASY%RoV'}, ...
    'Location', 'SE', ...
    'Box', 'off')

axes(ha(2))
semilogy(T_mod, [EASYRo_mod EASYRoB_mod EASYRoV_mod], '-'); hold on;
plot(sam_T, [sam_EASYRo sam_EASYRoB sam_EASYRoV], 'o', ...
    'MarkerFaceColor', 'w');
set(gca(), 'YLim', [0.2 1.8])
set(gca(), 'XLim', [0 400])
set(gca(), 'FontName', 'EMprint')
text(sam_t+5, sam_T-5, num2str(sam_num, '%.0g'), ...
    'color', 'k', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top')
% grid on
% grid minor
set(gca(), 'TickLength', 2.5*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'on')
set(gca(), 'YTickLabel', [])
set(gca(), 'LineWidth', 0.5)    % default box line width is 0.5


%% Save Figure
set(gcf, 'PaperPosition', [-0.4375    3.1094    9.3750    4.7813])
print('Figure S1_raw.eps', '-depsc2')