function [] = ahp()

fprintf('\n*******************************************************\n')
fprintf(  '*       MULTI-LEVEL ANALYTIC HIERARCHY PROCESS        *\n')
fprintf(  '*              No. of Levels = Inf                    *\n')
fprintf(  '*                                                     *\n')
fprintf(  '*               Author: Jaideep Joshi                 *\n')
fprintf(  '*                                                     *\n')
fprintf(  '*******************************************************\n\n')

% Get names
[techNames, attNames, attTree, nA, nT, qualFlag] = getNamesfromFile('attrData.txt');

% get the priority vector
[attVec, pVec] = getPriority(attTree, attNames);

% compare alternatives
P = compareAlts(qualFlag, nT, techNames, attVec, attNames);

% Rank alternatives
scores = P * pVec;
[B, I] = sort(scores, 'descend');

% print results
showResult(P, B, I, pVec, attVec, techNames, attNames);

end
