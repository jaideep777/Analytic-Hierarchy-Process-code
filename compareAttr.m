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

function [W,v] = compareAttr(parent, attVec, attNames)

% attVec = combined vector of Ql, Qn attributes by index
% attNames always starts with "Root"
% PAIRWISE COMPARISON

nA = length(attVec);
W = ones(nA,nA);
mu = 10;

fprintf('\n\nComparing attributes within "%s" group = \n', char(attNames(parent+1)) )

while (mu > 0.1)
    for i=1:nA
        for j=i+1:nA
            prompt_s = sprintf([char(attNames(attVec(i)+1)), ' / ', char(attNames(attVec(j)+1)), ' = ']);
            W(i,j) = prompt(prompt_s, 1);
            W(j,i) = 1/W(i,j);
        end
    end

    [V,D] = eigs(W);
    [lmax, imax] = max(abs(diag(D)));
    v = V(:,imax);
    v = v/sum(v);

    mu = (lmax - nA) / (nA - 1);



    fprintf('\n\n[ Weights matrix | Eigenvector ] for the group "%s" = \n\n', char(attNames(parent+1)) )
    for i=1:length(v)
        fprintf('%s    |   %4.2f   |  %s\n', num2str(W(i,:), '%4.2f\t'), v(i), char(attNames(attVec(i)+1)) );
    end
    fprintf('\nConsistency Index = %f\n', mu)
    
    if mu > 0.1
        s = input('\nYour answers were not consistent enough.\nDo you wish to repeat the comparisons? <y/n> ', 's');
        if s == 'n' 
            break
        end
    end
end

end
