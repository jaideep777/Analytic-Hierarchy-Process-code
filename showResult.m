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

function [] = showResult(P, B, I, pVec, attVec, techNames, attNames)

fprintf('\n\n********** RESULT ***********\n\n')
fprintf('The final P matrix was:\n\n')
sz = size(P);
for i=1:length(pVec)
    s = char(attNames(attVec(i)+1));
    if length(s) > 4
        fprintf('\t%s', s(1:4));
    else
        fprintf('\t%s\t', s);
    end
end
fprintf('\n\t--------------------------------------------------\n');
for i=1:sz(1) % # rows in P = # Alts
    fprintf('\t%s    |   %s\n', num2str(P(i,:), '%5.4f\t'), char(techNames(i)) );
end

fprintf('\nThe final Priority Vector was:\n')
for i=1:length(pVec)
    fprintf('\t%5.4f  <-  %s\n', pVec(i), char(attNames(attVec(i)+1)));
end

fprintf('\nAlternatives are Ranked as follwos:\n')
fprintf('\nRank\tScore\tAlt\n');
for i=1:length(techNames)
    fprintf('\t%i\t%3.1f%%\t%s\n', i, B(i)*100, char(techNames(I(i))));
end


end
