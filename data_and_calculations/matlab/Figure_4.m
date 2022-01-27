% Figure 4 for HIPPIE-DIPPIE manuscript
% MS of samples
%
% David T. Wang, July 15th, 2019

clear all;

figure(4); clf;
set(gcf, 'Position', [ 2176         -53         116         924])
set(gcf, 'PaperPosition', [3.6458    0.6875    1.2083    9.6250])

nsp = 9
h = tight_subplot(nsp,1,[0.01], [0.20 0.05], [0.20 0.05])
tp = {'2', '3', '4', '5', '6(1)', '6(2)', '7', '8', '9'}
% color = {'k', [0.5 0.5 0.5], 'k', [45, 171, 255]./255, [66, 134, 244]./255}

%% Read data

b = csvread('b.csv',1,1)'   % [m n] matrix of m/z x number of samples
b = b(1:end-3,:)            % drop last 3 masses, keep only m/z 14 to 20
b = b*100;                  % convert to pct

ii = [9:-1:1];

for i = 1:nsp,
    axes(h(ii(i)))
    bar([14:20]', b(:,i), 0.4, 'FaceColor', colors('smokey topaz'), 'EdgeColor', colors('otter brown') )
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
    
    text(xl(1)+diff(xl)*0.05, yl(2)-diff(yl)*0.05, tp{i}, ...
        'FontSize', 8, ...
        'VerticalAlignment', 'top')
end

% for i = 6:nsp,
%     axes(h(i))
%     set(gca,'visible','off')
% end

%% Print

print('Figure 4_raw.eps', '-depsc2')
savefig('Figure 4')