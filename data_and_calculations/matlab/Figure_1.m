% Figure 1 for HIPPIE-DIPPIE manuscript
% Temperature and Maturity (EASY%Ro) vs. time
%
% David T. Wang, June 8th, 2019

% clear all;

%% Import Temperature Profile, Maturity Model, and Concentration Data

model = csvread('MaturityCalculation_Redone\Calculated_Mats_for_Paper_EASYRo.csv');
sim_t = model(:,1);     % Simulation time, hours
t_mod = model(:,2);     % Experiment time, hours
T_mod = model(:,3);     % Experiment Temperature, degC
EASYRo_mod = model(:,4);% EASYRo, simulated %Ro

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

%% Plot Figure 

figure(74); clf;
ha = tight_subplot(2, 1, 0.03, [0.12 0.05], [0.12 0.05])
axes(ha(1))
plot(t_mod, T_mod, 'b-', 'LineWidth', 0.7); hold on;
plot(sam_t, sam_T, 'ok', ...
    'MarkerSize', 10, ...
    'MarkerFaceColor', 'w');
text(sam_t, sam_T, num2str(sam_num, '%.0g'), ...
    'color', 'k', ...
    'fontsize', 8, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');
% set(gca(), 'FontName', 'Arial')
set(gca(), 'YLim', [0 380])
grid on
grid minor
set(gca(), 'TickLength', 2.5*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'on')
set(gca(), 'XTickLabel', [])
ylabel('Temperature (\circ{}C)')
text(-65, 360, 'A', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');

axes(ha(2))
semilogy(t_mod, EASYRo_mod, 'r--'); hold on;
plot(sam_t, sam_EASYRo, 'ok', ...
    'MarkerSize', 10, ...
    'MarkerFaceColor', 'w');
text(sam_t, sam_EASYRo, num2str(sam_num, '%.0g'), ...
    'color', 'k', ...
    'fontsize', 8, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');
set(gca(), 'YLim', [0.2 1.5])
% set(gca(), 'FontName', 'Arial')
grid on
grid minor
set(gca(), 'TickLength', 2.5*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'on')
ytickformat('%.1f')
ylabel('EASY%Ro')
xlabel('Time (hours)')
text(-65, 1.35, 'B', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');

%% Save Figure
set(gcf, 'PaperPosition', [1.3333    2.8073    5.8333    5.3854])
print('Figure 1_raw_new0322.eps', '-depsc2')
print('Figure 1_raw_new0322.pdf', '-dpdf')