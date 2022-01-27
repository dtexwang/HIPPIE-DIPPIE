% Figure 3 for HIPPIE-DIPPIE manuscript
% MS of standards
%
% David T. Wang, July 15th, 2019

clear all;

figure(3); clf;
set(gcf, 'Position', [ 2176         -53         116         924])
set(gcf, 'PaperPosition', [3.6458    0.6875    1.2083    9.6250])

nsp = 9
h = tight_subplot(nsp,1,[0.01], [0.20 0.05], [0.20 0.05])
isotopologue = {'CH_4','CH_3D','CH_2D_2','CHD_3','CD_4'};
color = {'k', [0.5 0.5 0.5], 'w', [45, 171, 255]./255, [66, 134, 244]./255}

%% Read data

A = csvread('A.csv',1,1)'   % [m n] matrix of m/z x 5 standard isotopologues (CH4 to CD4)
A = A(1:end-3,:)            % drop last 3 masses, keep only m/z 14 to 20
A = A*100;                  % convert to pct

ii = [5:-1:1];

for i = 1:5,
    axes(h(ii(i)))
    bar([14:20]', A(:,i), 0.4, 'FaceColor', color{i}, 'EdgeColor', 'k')
    ylim([0 60])
    if i > 1,
        set(gca, 'XTickLabel',[])
    elseif i == 1,
        set(gca, 'XTickLabel', {'14', '', '16', '', '18', '', '20'})
        xlabel('m/z')
    end
    set(gca, 'TickLength', [0 0])
    set(gca, 'YTickLabel', [])
    set(gca, 'FontSize', 8)

    grid on;
    set(gca, 'YGrid', 'off')
    
    yl = ylim;
    xl = xlim;
    
    text(xl(1)+diff(xl)*0.05, yl(2)-diff(yl)*0.05, isotopologue{i}, ...
        'FontSize', 8, ...
        'VerticalAlignment', 'top')
end

for i = 6:nsp,
    axes(h(i))
    set(gca,'visible','off')
end

%% Print

print('Figure 3_raw.eps', '-depsc2')
savefig('Figure 3')