% Figure 2 for HIPPIE-DIPPIE manuscript
% Concentrations vs. time
%
% David T. Wang, June 8th, 2019

clear all;

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

%% Plot Figure

figure(2); clf;
set(gcf, 'Position', [925   309   879   583])

ha = tight_subplot(2, 3, [0.02 0.013], [0.12 0.05], [0.12 0.05]);

axes(ha(1))
semilogy(sam_t(1:3), sam_H2(1:3), 'b:v', 'MarkerFaceColor', 'w', 'LineWidth', 0.7, 'Color', [0.4 0.1 0.1], 'MarkerSize', 4); hold on;
h = semilogy(sam_t(3:end), sam_H2(3:end), 'b-o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7, 'Color', [0.4 0.1 0.1]); 
plot([429.88 429.88], [1e-7 6e-7], '--', 'Color', [0.4 0.4 0.4]);
plot([429.88 429.88], [7e-5 1e0], '--', 'Color', [0.4 0.4 0.4]);
text(427, 8e-7, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Color', [0.4 0.4 0.4])
% plot([429.88 429.88], [1e-7 1e0], '--', 'Color', [0.4 0.4 0.4]);
% text(430, 2e-7, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'Color', [0.4 0.4 0.4])
uistack(h,'top')
set(gca(), 'YGrid', 'on')
% set(gca(), 'YMinorGrid', 'on')
set(gca(), 'XTickLabel', [])
set(gca(), 'YLim', [1e-7 1e0])
set(gca(), 'XLim', [0 900])
ytickformat('%.1f')
set(gca(), 'TickLength', 4*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'off')
set(gca(), 'YTick', 10.^[-7:0])
set(gca(), 'YTickLabel', [-7:0])
text(65, 10^-0.35, 'A', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');
legend([h(1)], {'H_2'}, ...
    'Location', 'SE', ...
    'Box', 'off')
message = sprintf('?  BDL  ?');
text(90, 10^-5.05, message, ...
    'color', [0.4 0.1 0.1], ...
    'fontweight', 'normal', ...
    'fontsize', 8, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'top');
ylabel('log_{10} conc. (mol/kg fluid)')

axes(ha(2))
h = semilogy(sam_t, sam_CH4, 'k-o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7); hold on;
plot([429.88 429.88], [1e-7 6e-7], '--', 'Color', [0.4 0.4 0.4]);
plot([429.88 429.88], [7e-5 1e0], '--', 'Color', [0.4 0.4 0.4]);
text(427, 8e-7, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Color', [0.4 0.4 0.4])
% plot([429.88 429.88], [1e-7 1e0], '--', 'Color', [0.4 0.4 0.4]);
% text(430, 2e-7, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'Color', [0.4 0.4 0.4])
uistack(h,'top')
set(gca(), 'YGrid', 'on')
% set(gca(), 'YMinorGrid', 'on')
set(gca(), 'XTickLabel', [])
set(gca(), 'YLim', [1e-7 1e0])
set(gca(), 'XLim', [0 900])
ytickformat('%.1f')
set(gca(), 'TickLength', 4*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'off')
set(gca(), 'YTick', 10.^[-7:0])
set(gca(), 'YTickLabel', [])
text(65, 10^-0.35, 'B', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');
legend([h], {'CH_4'}, ...
    'Location', 'SE', ...
    'Box', 'off')

axes(ha(3))
h = semilogy(sam_t, sam_TCO2, 'r-o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7); hold on;
% plot([429.88 429.88], [1e-7 1e0], '--', 'Color', [0.4 0.4 0.4]);
% text(430, 2e-7, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'top', 'Color', [0.4 0.4 0.4])
plot([429.88 429.88], [1e-7 6e-7], '--', 'Color', [0.4 0.4 0.4]);
plot([429.88 429.88], [7e-5 1e0], '--', 'Color', [0.4 0.4 0.4]);
text(427, 8e-7, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'left', 'VerticalAlignment', 'middle', 'Color', [0.4 0.4 0.4])
uistack(h,'top')
set(gca(), 'YGrid', 'on')
% set(gca(), 'YMinorGrid', 'on')
set(gca(), 'XTickLabel', [])
set(gca(), 'YLim', [1e-7 1e0])
set(gca(), 'XLim', [0 900])
ytickformat('%.1f')
set(gca(), 'TickLength', 4*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'off')
set(gca(), 'YTick', 10.^[-7:0])
set(gca(), 'YTickLabel', [])
text(65, 10^-0.35, 'C', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');
legend([h], {'?CO_2'}, ...
    'Location', 'SE', ...
    'Box', 'off')

axes(ha(4))
h1 = semilogy(sam_t, sam_C2, 'm-o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7); hold on;
h2 = semilogy(sam_t, sam_C2ene, 'k--o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7, 'Color', [0.6 0.6 0.6]);
plot([429.88 429.88], [1e-7 1e0], '--', 'Color', [0.4 0.4 0.4]);
plot(sam_t([1,2]), 10.^[-2.8 -2.8], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([1,2])), 10^-2.8, '200 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([3:5]), 10.^[-2.2 -2.2 -2.2], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([3,5])), 10^-2.2, '300 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([6,7]), 10.^[-1.9 -1.9], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([6,7])), 10^-1.9, '325 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([8,9]), 10.^[-1.6 -1.6], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([8,9])), 10^-1.6, '350 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
% plot([429.88 429.88], [1e-7 4e-3], '--', 'Color', [0.4 0.4 0.4]);
% plot([429.88 429.88], [4e-1 1e0], '--', 'Color', [0.4 0.4 0.4]);
% text(427, 3e-1, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Color', [0.4 0.4 0.4])
uistack(h2,'top')
uistack(h1,'top')
set(gca(), 'YGrid', 'on')
% set(gca(), 'YMinorGrid', 'on')
% set(gca(), 'XTickLabel', [])
set(gca(), 'YLim', [1e-7 1e0])
set(gca(), 'XLim', [0 900])
ytickformat('%.1f')
set(gca(), 'TickLength', 4*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'off')
set(gca(), 'YTick', 10.^[-7:0])
set(gca(), 'YTickLabel', [-7:0])
text(65, 10^-0.35, 'D', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');
legend([h1 h2], {'ethane', 'ethylene'}, ...
    'Location', 'SE', ...
    'Box', 'off')
ylabel('log_{10} conc. (mol/kg fluid)')

axes(ha(5))
h1 = semilogy(sam_t, sam_C3, 'c-o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7); hold on;
h2 = semilogy(sam_t, sam_C3ene, '--o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7, 'Color', [0.6 0.6 0.6]); 
plot([429.88 429.88], [1e-7 1e0], '--', 'Color', [0.4 0.4 0.4]);
plot(sam_t([1,2]), 10.^[-2.8 -2.8], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([1,2])), 10^-2.8, '200 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([3:5]), 10.^[-2.2 -2.2 -2.2], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([3,5])), 10^-2.2, '300 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([6,7]), 10.^[-1.9 -1.9], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([6,7])), 10^-1.9, '325 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([8,9]), 10.^[-1.6 -1.6], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([8,9])), 10^-1.6, '350 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
% plot([429.88 429.88], [1e-7 4e-3], '--', 'Color', [0.4 0.4 0.4]);
% plot([429.88 429.88], [4e-1 1e0], '--', 'Color', [0.4 0.4 0.4]);
% text(427, 3e-1, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Color', [0.4 0.4 0.4])
uistack(h2,'top')
uistack(h1,'top')
set(gca(), 'YGrid', 'on')
% set(gca(), 'YMinorGrid', 'on')
% set(gca(), 'XTickLabel', [])
set(gca(), 'YLim', [1e-7 1e0])
set(gca(), 'XLim', [0 900])
ytickformat('%.1f')
set(gca(), 'TickLength', 4*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'off')
set(gca(), 'YTick', 10.^[-7:0])
set(gca(), 'YTickLabel', [])
text(65, 10^-0.35, 'E', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');
legend([h1 h2], {'propane', 'propylene'}, ...
    'Location', 'SE', ...
    'Box', 'off')
xlabel('Time (hours)')

axes(ha(6))
h1 = semilogy(sam_t, sam_nC4, 'k-o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7, 'Color', [0.2 0.4 0.8]); hold on;
h2 = semilogy(sam_t, sam_iC4, 'k-o', 'MarkerFaceColor', 'w', 'LineWidth', 0.7, 'Color', [0.6 0.6 0.6]);
plot([429.88 429.88], [1e-7 1e0], '--', 'Color', [0.4 0.4 0.4]);
plot(sam_t([1,2]), 10.^[-2.8 -2.8], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([1,2])), 10^-2.8, '200 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([3:5]), 10.^[-2.2 -2.2 -2.2], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([3,5])), 10^-2.2, '300 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([6,7]), 10.^[-1.9 -1.9], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([6,7])), 10^-1.9, '325 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
plot(sam_t([8,9]), 10.^[-1.6 -1.6], '.k-', 'MarkerFaceColor', 'w'); 
    text(mean(sam_t([8,9])), 10^-1.6, '350 °C', 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center', 'FontSize', 7, 'FontWeight', 'normal');
% plot([429.88 429.88], [4e-1 1e0], '--', 'Color', [0.4 0.4 0.4]);
% text(427, 3e-1, 'Injected fluid', 'Rotation', 90, 'FontSize', 8, 'HorizontalAlignment', 'right', 'VerticalAlignment', 'middle', 'Color', [0.4 0.4 0.4])
uistack(h2,'top')
uistack(h1,'top')
set(gca(), 'YGrid', 'on')
% set(gca(), 'YMinorGrid', 'on')
% set(gca(), 'XTickLabel', [])
set(gca(), 'YLim', [1e-7 1e0])
set(gca(), 'XLim', [0 900])
ytickformat('%.1f')
set(gca(), 'TickLength', 4*get(gca(),'TickLength'))
set(gca(), 'XMinorTick', 'on', 'YMinorTick', 'off')
set(gca(), 'YTick', 10.^[-7:0])
set(gca(), 'YTickLabel', [])
text(65, 10^-0.35, 'F', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');
legend([h1 h2], {'{\it n}-butane', 'isobutane'}, ...
    'Location', 'SE', ...
    'Box', 'off')

%% Save Figure
set(gcf, 'PaperPosition', [-0.3281    2.4635    9.1563    6.0729])
print('Figure 2_withD2_backtoH2.eps', '-depsc2')
print('Figure 2_withD2_backtoH2.pdf', '-dpdf')
savefig 'Figure 2_withD2.fig'