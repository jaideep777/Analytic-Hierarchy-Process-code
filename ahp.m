%    Decision maker using the Analytic Hierarchy Process
%    Copyright (C) 2016  Jaideep Joshi
%
%    This file is part of program AHP_multilevel 
%
%    AHP_multilevel is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    AHP_multilevel is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.


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
