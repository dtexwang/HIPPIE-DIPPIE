% Figure 6 for HIPPIE-DIPPIE manuscript
% Deuteration (D/H+D in CH4) vs. Maturity (EASY%Ro)
%
% Run after TestSVD_HIPDIP.m, then Figure_1.m
%
% David T. Wang, July 16th, 2019
% modified 6 April 2020


deuteration = DH_nn(:,2);
deuteration = [deuteration(1:4); mean(deuteration(5:6)); deuteration(7:end)];
    % average the 6(1) and 6(2) samples

sam_maturity = sam_EASYRo(2:end);   % drop tp 1 where we have no GC-MS data


figure(6); clf;
hsp = tight_subplot(1, 2, [0.02], [0.15 0.25], [0.15 0.13]);

%% Pct Deuteration vs. Maturity

axes(hsp(1))

litdata = csvread('literaturedataFig6a.csv');   % [EASYRo, %HfromWater]
                                                % first 9 rows are my data
                                                % 10:end Wei et al 2019 OG

semilogx(sam_maturity, deuteration, 'g--'); hold on;
plot(litdata(10:end,1), litdata(10:end,2), '.k', ...
    'MarkerSize', 7);                    % Wei et al 2019 OG
plot(sam_maturity, deuteration, 'ok', ...
    'MarkerSize', 10, ...
    'MarkerFaceColor', 'w');
text(sam_maturity, deuteration, num2str(sam_num(2:end), '%.0g'), ...
    'color', 'k', ...
    'fontsize', 8, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');
set(gca(), 'XLim', [0.2 1.7])
ylim([0 100])

xlabel('EASY%Ro')
ylabel('Methane Deuteration (%)')
grid on
set(gca, 'TickLength', [0.0200 0.0500]*1.5)
axis square

xl = xlim
yl = ylim

text(0.5, 105, '| \leftarrow', ...
    'Color', 'r', ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'Clipping', 'off', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'middle');

text(10^mean([log10(1.3),log10(0.5)]), 105, 'OIL WINDOW', ...
    'Color', 'r', ...
    'FontWeight', 'normal', ...
    'FontSize', 7.5, ...
    'Clipping', 'off', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');

text(1.3, 105, '\rightarrow |', ...
    'Color', 'r', ...
    'FontWeight', 'bold', ...
    'FontSize', 8, ...
    'Clipping', 'off', ...
    'HorizontalAlignment', 'right', ...
    'VerticalAlignment', 'middle');

text(10.^(log10(xl(1))+diff(log10(xl))*0.05), yl(2)-diff(yl)*0.05, 'A', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');


%% Pct Deuteration vs. Methane Concentration

axes(hsp(2))

[num txt raw] = xlsread('concentration\TOTAL_GENERATED.xlsx','TOTGEN');
spl = num(:,1);             % sample number
umolesCH4 = num(:,2)*1e6;   % total umoles CH4 generated

semilogx(umolesCH4(2:end), deuteration, 'g-'); hold on;
hpc = plot(umolesCH4(2:end), deuteration, 'ok', ...
    'MarkerSize', 10, ...
    'MarkerFaceColor', 'w');
text(umolesCH4(2:end), deuteration, num2str(spl(2:end), '%.0g'), ...
    'color', 'k', ...
    'fontsize', 8, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'center', ...
    'VerticalAlignment', 'middle');
% set(gca(), 'XLim', [0.2 1.5])
ylim([0 100])

New_XTickLabel = get(gca,'xtick');
set(gca,'XTickLabel',New_XTickLabel);
% xtickformat('%.1g')

xlabel('Cum. Methane Generated (µmol)')
% ylabel('Methane Deuteration (%)')
set(gca, 'YTickLabel', [])

grid on
set(gca, 'TickLength', [0.0200 0.0500]*1.5)
axis square

xl = xlim
yl = ylim

text(10.^(log10(xl(1))+diff(log10(xl))*0.05), yl(2)-diff(yl)*0.05, 'B', ...
    'color', 'k', ...
    'fontweight', 'bold', ...
    'fontsize', 12, ...%     'FontName', 'Arial', ...
    'HorizontalAlignment', 'left', ...
    'VerticalAlignment', 'top');

%% Pie Inset Charts

pcts = bfmrs_nn;
pcts(pcts==0) = 0.001;  % replace 0 with 0.001 in %isotopologue

color = {'k', [0.5 0.5 0.5], 'w', [45, 171, 255]./255, [66, 134, 244]./255};
colornum = [0 0 0; 0.5 0.5 0.5; 0 0 0; [95, 191, 255]./255; [46, 134, 244]./255];

% tp 2
row = 1;
ax2 = axes('Position', [0.1 0.1 0.6 0.6]);
set(ax2, 'Position', [0.51-0.02 0.81 0.12 0.12])
explode = [0 0 0 0 0];  % explode CH2D2 only
hpb = pie([1], [0], {''}); hold on;
hpb(1).LineWidth = 2;
hpb(1).FaceColor = 'k';
% hpb(1).EdgeColor = [0.7 0.7 0.7];
labels = {'CH_4','','','',''};
hp2 = pie(pcts(row,:), explode, labels);
HA = {'center', 'left', 'center', 'left', 'left'}
VA = {'top', 'bottom', 'top', 'top', 'bottom'};
for i = 1:5,
    hp2(2*i-1).FaceColor = color{i};
    if i == 3, 
        hp2(2*i-1).EdgeColor = 'k';
        hp2(2*i-1).LineWidth = 0.01;
    else
        hp2(2*i-1).EdgeColor = 'k';
    end
%     hp2(2*i).String = '';
    hp2(2*i).FontSize = 7;
    hp2(2*i).HorizontalAlignment = HA{i};
    hp2(2*i).VerticalAlignment = VA{i};
    hp2(2*i).Color = colornum(i,:);
end
% plot(0, 0, 'ok', ...
%     'MarkerSize', 10, ...
%     'MarkerFaceColor', 'w');
% text(0, 0, '2', ...
%     'color', 'w', ...
%     'fontsize', 8, ...%     'FontName', 'Arial', ...
%     'fontweight', 'bold', ...
%     'HorizontalAlignment', 'center', ...
%     'VerticalAlignment', 'middle');
title(' 2 ', ...
    'FontSize', 8, ...
    'FontWeight', 'bold', ...
    'EdgeColor', 'k', ...
    'Margin', 1, ...
    'LineWidth', 0.25)

% tp 4
row = 3;
ax2 = axes('Position', [0.1 0.1 0.6 0.6]);
set(ax2, 'Position', [0.655-0.02 0.81 0.12 0.12])
explode = [0 0 0 0 0];  % explode CH2D2 only
hpb = pie([1], [0], {''}); hold on;
hpb(1).LineWidth = 1.5;
hpb(1).FaceColor = 'k';
% hpb(1).EdgeColor = [0.7 0.7 0.7];
labels = {'CH_4 ','CH_3D','CH_2D_2','CHD_3','CD_4'};
hp2 = pie(pcts(row,:), explode, labels);
HA = {'right', 'right', 'center', 'left', 'left'}
VA = {'middle', 'middle', 'top', 'top', 'bottom'};
for i = 1:5,
    hp2(2*i-1).FaceColor = color{i};
    if i == 3, 
        hp2(2*i-1).EdgeColor = 'k';
        hp2(2*i-1).LineWidth = 0.01;
    else
        hp2(2*i-1).EdgeColor = 'k';
    end
%     hp2(2*i).String = '';
    hp2(2*i).FontSize = 7;
    hp2(2*i).HorizontalAlignment = HA{i};
    hp2(2*i).VerticalAlignment = VA{i};
    hp2(2*i).Color = colornum(i,:);
end
% plot(0, 0, 'ok', ...
%     'MarkerSize', 10, ...
%     'MarkerFaceColor', 'w');
% text(0, 0, '4', ...
%     'color', 'w', ...
%     'fontsize', 8, ...%     'FontName', 'Arial', ...
%     'fontweight', 'bold', ...
%     'HorizontalAlignment', 'center', ...
%     'VerticalAlignment', 'middle');
title(' 4 ', ...
    'FontSize', 8, ...
    'FontWeight', 'bold', ...
    'EdgeColor', 'k', ...
    'Margin', 1, ...
    'LineWidth', 0.25)

% tp 9
row = 9;
ax2 = axes('Position', [0.1 0.1 0.6 0.6]);
set(ax2, 'Position', [0.80-0.02 0.81 0.12 0.12])
explode = [0 0 0 0 0];  % explode CH2D2 only
hpb = pie([1], [0], {''}); hold on;
hpb(1).LineWidth = 1.5;
hpb(1).FaceColor = 'k';
% hpb(1).EdgeColor = [0.7 0.7 0.7];
labels = {'','CH_3D ','','CHD_3','CD_4'};
hp2 = pie(pcts(row,:), explode, labels);
HA = {'right', 'right', 'center', 'right', 'left'}
VA = {'bottom', 'middle', 'top', 'middle', 'top'};
for i = 1:5,
    hp2(2*i-1).FaceColor = color{i};
    if i == 3, 
        hp2(2*i-1).EdgeColor = 'k';
        hp2(2*i-1).LineWidth = 0.01;
    else
        hp2(2*i-1).EdgeColor = 'k';
    end
%     hp2(2*i).String = '';
    hp2(2*i).FontSize = 7;
    hp2(2*i).HorizontalAlignment = HA{i};
    hp2(2*i).VerticalAlignment = VA{i};
    hp2(2*i).Color = colornum(i,:);
end
% plot(0, 0, 'ok', ...
%     'MarkerSize', 10, ...
%     'MarkerFaceColor', 'w');
% text(0, 0, '9', ...
%     'color', 'w', ...
%     'fontsize', 8, ...%     'FontName', 'Arial', ...
%     'fontweight', 'bold', ...
%     'HorizontalAlignment', 'center', ...
%     'VerticalAlignment', 'middle');
title(' 9 ', ...
    'FontSize', 8, ...
    'FontWeight', 'bold', ...
    'EdgeColor', 'k', ...
    'Margin', 1, ...
    'LineWidth', 0.25)

% 
% % LEGEND
% ax2 = axes('Position', [0.1 0.1 0.6 0.6]);
% set(ax2, 'Position', [0.83 0.31 0.1 0.1])
% 
% ax20 = copyobj(ax2,gcf());
% axes(ax20);
% set(ax20, 'Position', get(ax2,'Position')+[-0.03 -0.03 +0.06 +0.06])
% hp2 = pie([0.2 0.2 0.2 0.2 0.2], explode, labels);
% for i = 1:5,
%     hp2(2*i-1).FaceColor = color{i};
%     if i == 3, 
%         hp2(2*i-1).EdgeColor = 'k';
%         hp2(2*i-1).LineWidth = 0.01;
%     else
%         hp2(2*i-1).EdgeColor = 'k';
%     end
%     hp2(2*i).FontSize = 7;
%     hp2(2*i).Color = colornum(i,:);
% end
% % hpb(1).EdgeColor = [0.7 0.7 0.7];
% title('Pie Chart Legend', ...
%     'FontSize', 8, ...
%     'FontWeight', 'bold')
% delete(hp2(2*[1:5]-1))
% 
% axes(ax2);
% explode = [0 0 0 0 0];  % explode CH2D2 only
% 
% hp2 = pie([0.2 0.2 0.2 0.2 0.2], explode, labels);
% for i = 1:5,
%     hp2(2*i-1).FaceColor = color{i};
%     if i == 3, 
%         hp2(2*i-1).EdgeColor = 'k';
%         hp2(2*i-1).LineWidth = 0.01;
%     else
%         hp2(2*i-1).EdgeColor = 'k';
%     end
%     hp2(2*i).FontSize = 7;
%     hp2(2*i).Color = colornum(i,:);
%     hp2(2*i).String = '';
% end

%% Print

% set(gcf, 'Position', [764   451   303   352])
set(gcf, 'Position', [ 764   451   633   352])
set(gcf, 'PaperPosition', [2.6719    3.6667    3.1563    3.6667])

set(gcf,'renderer','opengl','renderermode','manual')
print('Figure 6_raw_wLit.eps', '-depsc2')
savefig('Figure 6_wLit')