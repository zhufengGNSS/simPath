x = [-3 -2 -1 0 1 2 3]';
Y = [1 11 13; 2 9 14; 6 14 5; 5 10 10; 5 14 6; 7 13 5;...
    8 11 6];
bar(x,Y,'stacked'); ylim([0 25]);

% Now fit a nominal model for the individual response 
% category probabilities, with separate slopes on the
% single predictor variable, x, for each
% category:

% The first row of betaHatNom contains the intercept terms 
% for the first two response categories.  The second row 
% contains the slopes.
betaHatNom = mnrfit(x,Y,'model','nominal',...
'interactions','on')

% Compute the predicted probabilities for the three 
% response categories:
xx = linspace(-4,4)';
pHatNom = mnrval(betaHatNom,xx,'model','nominal',...
'interactions','on');
line(xx,cumsum(25*pHatNom,2),'LineWidth',2);
