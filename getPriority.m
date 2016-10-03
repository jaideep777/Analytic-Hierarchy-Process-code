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

function [aVec pVec] = getPriority(attTree, attNames)

% attVecFull contains all children lists from attTree. 
% attVecfull = [0 1 4 5 2 3 6 7 9 8] in depth first input, but this order is breadth-first
% pVecFull   = [1 p1 p4 p5 p2 p3 p6 p7 p9 p8 ] etc
% attVec = [2 3 4 6 8 9]

fprintf('\nNow pairwise compare each group of attributes...\n')
fprintf(  '------------------------------------------------\n')
fprintf('\nEnter ratio of importances. (Eg: Style / Cost = 1/6) \n')

sz = size(attTree); % [m, n]
pVecFull = 1;   % root priority
attVecFull = 0; % root number
attVec = [];
pVec = [];
aVec = [];

% compare all groups pairwise, obtain normalised priorities
for i=1:sz(1)
    parent = cell2mat(attTree(i,1));
    cql = cell2mat(attTree(i,2));
    cqn = cell2mat(attTree(i,3));
    atts = [cql cqn]';
    
    if (~isempty(atts))
        [W,w] = compareAttr(parent, atts, attNames); % gives normalized priority vector of children attributes
        
        indexofparent = 0;
        for k=1:length(attVecFull)  % search for parent in attVec
            if attVecFull(k) == parent
                indexofparent = k;  % store index of parent in attVec
                break;
            end
        end

        w = w * pVecFull(indexofparent); % p(parent) is at index found above, multiply p(children) by p(parent)
        
        attVecFull = [attVecFull; atts]; % filling all attributes
        pVecFull = [pVecFull; w];   % filling all priorities
    else
        attVec = [attVec; parent];  % collect leaf attributes
    end
end

% [attVecFull'; pVecFull']
[V I] = sort(attVecFull', 'ascend'); % sort the priorities according to attributes to get form [0 a1 a2 a3 ..; 1 p1 p2 p3 ...]

for i=1:length(attVec)
    pVec = [pVec; pVecFull(I(attVec(i)+1))];   % collect the priorities of leaf attributes collected in attVec
    aVec = [aVec; attVecFull(I(attVec(i)+1))]; % collect the leaf attributes collected in attVec
end

% [pVec, aVec]

end
