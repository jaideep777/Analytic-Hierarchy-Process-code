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

function v = compareByQuant(nT, techNames)

tj = zeros(nT,1);

for j=1:nT
    prompt_s = sprintf(['Value for ' char(techNames(j)) ' = ']);
    tj(j,1) = prompt(prompt_s, 1);
end

tmax = max(tj); tmin = min(tj);
Lki = input('Is this value a Cost or Benefit? <c/b> : ', 's');

if Lki == 'b'
    v = (tj-tmin)/(tmax - tmin);
else
    v = (tmax - tj)/(tmax - tmin);
end

v = v/sum(v);

fprintf('\n\nWeights vector = \n\n')
for i=1:length(v)
    fprintf('  %4.2f   |  %s\n', v(i), char(techNames(i)) );
end

end
