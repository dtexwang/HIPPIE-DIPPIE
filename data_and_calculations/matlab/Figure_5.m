% Figure 5 for HIPPIE-DIPPIE manuscript
% Relative and Absolute abundance of CH4 isotopologues and D/H-bound to CH4
%
% Use output from LSQNONNEG via TestSVD_HIPDIP.m
%
% David T. Wang, July 15th, 2019

figure(5); clf;     % four-panel figure

ha = tight_subplot(2, 2, [0.02 0.15], [0.20 0.05], [0.20 0.05]);

tp = {'2', '3', '4', '5', '6(1)', '6(2)', '7', '8', '9'};

%%

axes(ha(1))
    style = {'o-', 'o-', 'o--', 'o-', 'o-'};    % style for each isotopolgue's line
    color = {'k', [0.5 0.5 0.5], 'k', [95, 191, 255]./255, [66, 134, 244]./255};
    colornum = [0 0 0; 0.5 0.5 0.5; 0 0 0; [95, 191, 255]./255; [46, 134, 244]./255];
%     for i = 1:size(bfmrs_nn,2),
%         hp = plot(bfmrs_nn(:,i), style{i}, ...
%             'color', color{i}, ...
%             'MarkerEdgeColor', color{i}, ...
%             'MarkerFaceColor', 'w')
%         hold on
%     end
    hpa = area(fliplr(bfmrs_nn(:,:)));
    for i = 5:-1:1,
        set(hpa(i), 'EdgeColor', colornum(6-i,:)); hold on;
    end
%     hptc = findobj(hp,'type','patch'); 
    for i = 5:-1:1, 
        HatchLineStyle = {'-', ':', '-', '-', '-'};
        HatchLineWidth = [.25 .25 .25 .25 .25];
        HatchColor = colornum;
        HatchDensity = [300 100 100 100 100];
        HatchAngle = [45 -45 45 -45 45];
        
        hatchfill2(hpa(i), 'single', ...
            'HatchLineStyle', HatchLineStyle{6-i}, ...
            'HatchLineWidth', HatchLineWidth(6-i), ...
            'HatchColor', HatchColor(6-i,:), ...
            'HatchDensity', HatchDensity(6-i), ...
            'HatchAngle', HatchAngle(6-i) );
    end
    
    yinc = zeros(1,9);
    for i = 5:-1:1,
        xd = hpa(6-i).XData;
        yd = hpa(6-i).YData + yinc;
        plot(xd, yd, '-', 'Color', color{6-i})
        yinc = yd;
    end

%     legend(hpa(1:5), {'CH_4','CH_3D','CH_2D_2','CHD_3','CD_4'}, 'location', 'best')
%     set(gca,'XTickLabel',sams)
    set(gca,'XTickLabel',[])
    set(gca,'XTickLabelRotation',45)

    grid on;
    grid minor
    set(gca, 'YGrid', 'off')
    set(gca, 'XMinorGrid', 'off')
    
    set(gca, 'TickLength', [0.0200 0.0500])
    ylim([0 100])
    xlim([1 9])
    ylabel('Isotopologue abundance, %')
    
    isotopologue = {'CH_4','CH_3D','CH_2D_2','CHD_3','CD_4'};
    txtcolors = {'w', [0.3 0.3 0.3], 'k', [0.23 0.53 0.66], [0.1 0.2 0.55]};
    vtces = [2.2, 12;
        3.3, 28;
        3.55, 51;
        5.2, 45;
        7, 80];
    for vi = 1:5,
        text(vtces(vi,1), 100-vtces(vi,2), isotopologue{vi}, ...
            'Color', txtcolors{vi}, ...
            'FontWeight', 'normal', ...
            'HorizontalAlignment', 'left', ...
            'VerticalAlignment', 'middle');
    end
    plot([3.0 3.5], 100-[49 50.5], 'k-')
    
    yl = ylim;
    xl = xlim;
    text(xl(1)+diff(xl)*0.05, yl(2)-diff(yl)*0.05, 'A', ...
        'color', 'w', ...
        'fontweight', 'bold', ...
        'fontsize', 12, ...%     'FontName', 'Arial', ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'top');


axes(ha(3))
    style = {'o-', 'o-', 'o--', 'o-', 'o-'};    % style for each isotopolgue's line
    color = {'k', [0.5 0.5 0.5], 'k', [45, 171, 255]./255, [66, 134, 244]./255};
%     for i = 1:size(bfmrs_nn,2),
%         hp = plot(bsxfun(@times,bfmrs_nn(:,i)/100*1e3,methane), style{i}, ...
%             'color', color{i}, ...
%             'MarkerEdgeColor', color{i}, ...
%             'MarkerFaceColor', 'w');
%         hold on
%     end
    hpa = area(bsxfun(@times,bfmrs_nn(:,:)/100*1e3,methane));
    
    for i = 1:5,
        set(hpa(i), 'EdgeColor', colornum(i,:)); hold on;
    end
%     hptc = findobj(hp,'type','patch'); 
    for i = 1:5, 
        HatchLineStyle = {'-', ':', '-', '-', '-'};
        HatchLineWidth = [.25 .25 .25 .25 .25];
        HatchColor = colornum;
        HatchDensity = [300 100 100 100 100];
        HatchAngle = [45 -45 45 -45 45];
        
        hatchfill2(hpa(i), 'single', ...
            'HatchLineStyle', HatchLineStyle{i}, ...
            'HatchLineWidth', HatchLineWidth(i), ...
            'HatchColor', HatchColor(i,:), ...
            'HatchDensity', HatchDensity(i), ...
            'HatchAngle', HatchAngle(i) );
    end
    
    yinc = zeros(1,9);
    for i = 1:5,
        xd = hpa(i).XData;
        yd = hpa(i).YData + yinc;
        plot(xd, yd, '-', 'Color', color{6-i})
        yinc = yd;
    end
    
%     legend(hpa, {'CH_4','CH_3D','CH_2D_2','CHD_3','CD_4'}, 'location', 'best')
%     set(gca,'XTickLabel',sams)
    set(gca, 'XTickLabel',tp) 
%     set(gca,'XTickLabelRotation',45)

    grid on;
    grid minor
    set(gca, 'YGrid', 'off')
    set(gca, 'XMinorGrid', 'off')
    
    set(gca, 'TickLength', [0.0200 0.0500])
    ylabel('Isotopologue concentration, mmol/kg')
    
    ylim([0 4])
    xlim([1 9])
    
    ytickformat('%.1f')
    
    txtcolors = {'k', [0.3 0.3 0.3], 'k', [0.23 0.53 0.66], [0.1 0.2 0.55]};
    vtces = [2.2, -0.09;
        3.3, 0.08;
        3.55, 0.25;
        5.2, 0.5;
        7, 2];
    for vi = 1:5,
        text(9.15, vtces(vi,2), isotopologue{vi}, ...
            'Color', txtcolors{vi}, ...
            'FontWeight', 'normal', ...
            'Clipping', 'off', ...
            'HorizontalAlignment', 'left', ...
            'VerticalAlignment', 'middle');
    end
    
    yl = ylim;
    xl = xlim;
    text(xl(1)+diff(xl)*0.05, yl(2)-diff(yl)*0.05, 'B', ...
        'color', 'k', ...
        'fontweight', 'bold', ...
        'fontsize', 12, ...%     'FontName', 'Arial', ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'top');
    
    xlabel('Sample #')
    
axes(ha(2))
    plot(DH_nn(:,2), 'k-o', 'markerfacecolor', 'w')
    set(gca,'XTickLabel','')
    grid on
    grid minor
    set(gca, 'TickLength', [0.0200 0.0500])
    ylabel('Calculated methane-bound D/(D+H), %')
    
    ylim([0 100])
    xlim([1 9])
    
    yl = ylim;
    xl = xlim;
    text(xl(1)+diff(xl)*0.05, yl(2)-diff(yl)*0.05, 'C', ...
        'color', 'k', ...
        'fontweight', 'bold', ...
        'fontsize', 12, ...%     'FontName', 'Arial', ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'top');
    
axes(ha(4))
    methane = csvread('concentration\methane.csv');
    methane = methane(2:end,2);
    h = area(bsxfun(@times,[100-DH_nn(:,2),DH_nn(:,2)]/100,methane*4*1e3),'LineStyle','-');
    h(1).FaceColor = [1 1 1];
    h(2).FaceColor = [0.6800    0.8500    0.9000];
    set(gca,'XTickLabel','')
    grid on
    grid minor
    set(gca, 'TickLength', [0.0200 0.0500])
    ylabel('Calculated D or H equivalents in CH4 (mmol/kg)')
    hold on
    plot(methane*4*1e3, '-', 'color', 'k', 'linewidth', 3)
    hold off
    set(gca,'XTickLabel',[])
    legend({'methane-H', 'methane-D', 'methane-all*4'}, 'location', 'best')
    
    ylim([0 4]*4)
    xlim([1 9])
    
    yl = ylim;
    xl = xlim;    
    text(xl(1)+diff(xl)*0.05, yl(2)-diff(yl)*0.05, 'D', ...
        'color', 'k', ...
        'fontweight', 'bold', ...
        'fontsize', 12, ...%     'FontName', 'Arial', ...
        'HorizontalAlignment', 'left', ...
        'VerticalAlignment', 'top');
    
    
%% Print

set(gcf, 'Position', [2626          76        1038         824])
set(gcf, 'PaperPosition', [ -1.1563    1.2083   10.8125    8.5833 ] )

print('Figure 5_raw.eps', '-depsc2')
savefig('Figure 5')