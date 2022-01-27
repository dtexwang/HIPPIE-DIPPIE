% Singular Value Decomposition to find mixing ratios of isotopologue in
% HIPPIE-DIPPIE Experiment Timepoints
% 
% 12/7/2018
% David T. Wang, ExxonMobil

% Matlab R2015b on 64-bit Windows 7

[num txt raw] = xlsread('b.csv');
sams = txt;
sams = sams(2:end);

A = csvread('A_new.csv',1,1)'   % [m n] matrix of m/z x 5 standard isotopologues (CH4 to CD4)
% A = A(1:end-3,:)   % drop last 3 masses, keep only m/z 14 to 20
A = A(1:end,:)   % for new integration with Malcom June 2019, keep m/z 12 to 20

[U,S,V] = svd(A,0);     % SVD of design matrix
disp 'Is A rank-deficient? I.e., does diag(S) have any zero elements?'
disp(find(~diag(S)))

W = diag(1./diag(S));   % element-wise reciprocal of singular matrix
 
b = csvread('b_new.csv',1,1)'   % [m #tp] matrix of m/z by timepoint
% b = b(1:end-3,:)                    % [#tp 7] matrix of m/z by timepoint
b = b(1:end,:)                    % [#tp 7] matrix of m/z by timepoint

%% SVD

bfmrs_svd = [];
uncmrs_svd = [];
DH_svd = [];

for i = 1:size(b,2),    % i = 1:#tp's
    bi = b(:,i);

    x = (V*W*U')*bi;    % best-guess inverse; mixing ratios!
    Covmat = V*W.^2*V'; % compute covariance matrix
    [m n] = size(A);    % size of design matrix A (row #m/z x col #iso)
    redchisqr = sum((A*x-bi).^2)/(m-n);     % compute reduced chi squared
    Covmat = redchisqr*Covmat;              % estimate errors 
    sx = sqrt(diag(Covmat));                % uncertainties in MR
    
    isofD = [0, 1, 2, 3, 4]/4;  % Pct of Each Isotopologue-H that is D
    fracD = sum(isofD .* x');
    
    disp '******************************'
    disp 'Best fit solution for sample #'
    disp(i)
    disp(sams{i})
    disp(cond(A))
    disp 'Mixing ratios: '
    disp '      CH4     CH3D      CH2D2     CHD3      CD4'
    disp(100*x')
    disp 'Uncertainties in mixing ratios'
    disp(100*sx')
    disp '      D/H    %D/(D+H)'
    disp([fracD/(1-fracD), 100*fracD])
    
    (A*x)'*100          % THis should equal original [1 row x #m/z's (7)] for each sample
    ((A*x-bi)./(bi)).^2 % I forgt what this is
    
    bfmrs_svd(i,:) = 100*x';        % MR's:     CH4     CH3D      CH2D2     CHD3      CD4
    uncmrs_svd(i,:) = 100*sx';      % Uncertainties in mixing ratios
    DH_svd(i,:) = [fracD/(1-fracD), 100*fracD];     % D/H    %D/(D+H)

end

csvwrite('SVDout.csv', [bfmrs_svd, uncmrs_svd, DH_svd])

%% LSQNONNEG

bfmrs_nn = [];  % best fit mixing ratios, [#tp x 5 isotopologues]
uncmrs_nn = []; % uncertainties
DH_nn = [];     % [D/H ratio, %D]

for i = 1:size(b,2),
    bi = b(:,i);
    
    [X,RESNORM,RESIDUAL,EXITFLAG] = lsqnonneg(A, bi)
    
    isofD = [0, 1, 2, 3, 4]/4;  % Pct of Each Isotopologue-H that is D
    fracD = sum(isofD .* X');
    
    bfmrs_nn(i,:) = 100*X
    DH_nn(i,:) = [fracD/(1-fracD), 100*fracD]  
    
end

csvwrite('NNout.csv', [bfmrs_nn, repmat([nan()], size(bfmrs_nn,1),5), DH_nn])

%% Plot LSQNONNEG result

figure(2); clf;

subplot(7,1,[ 2])
plot(DH_nn(:,2), 'k-o', 'markerfacecolor', 'w')
set(gca,'XTickLabel','')
grid on
grid minor
set(gca, 'TickLength', [0.0200 0.0500])
ylabel('Calculated D/(D+H), %')

subplot(7,1,[ 3 4])
methane = csvread('concentration\methane.csv');
% methane = methane(2:end,2)
methane = methane(1:end,2)
h = area(bsxfun(@times,[100-DH_nn(:,2),DH_nn(:,2)]/100,methane*4*1e6),'LineStyle','-')
h(1).FaceColor = [1 1 1];
h(2).FaceColor = [0.6800    0.8500    0.9000];
set(gca,'XTickLabel','')
grid on
grid minor
set(gca, 'TickLength', [0.0200 0.0500])
ylabel('Calculated D or H equivalents in CH4 (\mu mol/kg)')
hold on
plot(methane*4*1e6, '-', 'color', 'k')
hold off
set(gca,'XTickLabel',[])
legend({'methane-H', 'methane-D', 'methane-all*4'}, 'location', 'best')

% methane = csvread('concentration\methane.csv');
% methane = methane(2:end,2)
% semilogy(bsxfun(@times,[DH_nn(:,2), 100-DH_nn(:,2)]/100,methane*4*1e6), '-', 'LineWidth', 1.5)
% set(gca,'XTickLabel','')
% grid on
% set(gca, 'TickLength', [0.0200 0.0500])
% ylabel('Calculated D or H equivalents in CH4 (\mu mol/kg)')
% legend({'methane-D', 'methane-H'}, 'location', 'best')
% ylim([1e-1 1e5])

subplot(7,1,[5:7])
style = {'o-', 'o-', 'o--', 'o-', 'o-'};    % style for each isotopolgue's line
color = {'k', [0.5 0.5 0.5], 'k', [45, 171, 255]./255, [66, 134, 244]./255}
for i = 1:size(bfmrs_nn,2),
    hp = plot(bfmrs_nn(:,i), style{i}, ...
        'color', color{i}, ...
        'MarkerEdgeColor', color{i}, ...
        'MarkerFaceColor', 'w')
    hold on
end
legend({'CH_4','CH_3D','CH_2D_2','CHD_3','CD_4'}, 'location', 'best')
set(gca,'XTickLabel',sams)
set(gca,'XTickLabelRotation',45)
grid on
grid minor
set(gca, 'TickLength', [0.0200 0.0500])
ylim([0 100])
ylabel('Calculated isotopologue abundance, %')


%% Add EASYRo

maturities = csvread('maturityinterpolation\MATURITIES.csv',1,2)
maturities = [maturities(1:6); maturities(6:end)];
% maturities(1) = [];

subplot(7,1, [1])
semilogy(maturities, 'k-o', 'markerfacecolor', 'w')
ylabel('EASY%Ro')
set(gca,'XTickLabel',[])
grid on
grid minor
set(gca, 'TickLength', [0.0200 0.0500])
ylim([0.2 1.9])


%% PRINT FIGURE 2
set(gcf, 'position', [1087          68         574         980])
print('Figure 2_raw.eps', '-depsc2')

%% Another plot of CH4-H, linear this time

figure(1); clf
methane = csvread('concentration\methane.csv');
% methane = methane(2:end,2)
methane = methane(1:end,2)
area(bsxfun(@times,[100-DH_nn(:,2),DH_nn(:,2)]/100,methane*4*1e6))
set(gca,'XTickLabel','')
grid on
set(gca, 'TickLength', [0.0200 0.0500])
ylabel('Calculated D or H equivalents in CH4 (\mu mol/kg)')
hold on
plot(methane*4*1e6, 'o-', 'LineWidth', 2)
hold off
set(gca,'XTickLabel',sams)
set(gca,'XTickLabelRotation',45)
legend({'methane-D', 'methane-H', 'methane-all*4'}, 'location', 'best')

%% Pct Deuteration vs. Maturity

figure(6); clf;
semilogx(maturities,DH_nn(:,2),'k*-')
text(maturities,DH_nn(:,2)-2, sams, 'FontSize', 8)
xlabel('EASY%Ro')
ylabel('Percent Methane Deuteration')
grid on
set(gca, 'TickLength', [0.0200 0.0500]*1.5)
axis square

%% Actual Methane Isotopologues Concentration

figure(18); clf
style = {'o-', 'o-', 'o--', 'o-', 'o-'};    % style for each isotopolgue's line
color = {'k', [0.5 0.5 0.5], 'k', [45, 171, 255]./255, [66, 134, 244]./255}
for i = 1:size(bfmrs_nn,2),
    hp = semilogy(bsxfun(@times,bfmrs_nn(:,i)*1e6,methane), style{i}, ...
        'color', color{i}, ...
        'MarkerEdgeColor', color{i}, ...
        'MarkerFaceColor', 'w')
    hold on
end
legend({'CH_4','CH_3D','CH_2D_2','CHD_3','CD_4'}, 'location', 'best')
set(gca,'XTickLabel',sams)
set(gca,'XTickLabelRotation',45)
grid on
grid minor
set(gca, 'TickLength', [0.0200 0.0500])
ylabel('Calculated Concentration, \mu moles/kg')