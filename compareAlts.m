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

function P = compareAlts(qualFlag, nT, techNames, attVec, attNames)

fprintf('\nComparison of Alternatives by each attribute...\n')
fprintf(  'For Qualitative Attributes, enter ratio of goodness, i.e.\n')
fprintf(  'How good is Alt A compared to Alt B.\n')
fprintf(  'For Quantitative Attributes, enter actual values.\n')
fprintf(  '----------------------------------------------------\n\n')


P = [];
    
for i=1:length(attVec)
    
    attr = attVec(i);
    
    if qualFlag(attr) == 1
        fprintf(['\nComparing alternatives wrt Qualitative Attribute "' char(attNames(attr+1)) '"...\n'])
        v = compareByQual(nT, techNames);
    else
        fprintf(['\nComparing alternatives wrt Quantitative Attribute "' char(attNames(attr+1)) '"...\n'])
        v = compareByQuant(nT, techNames);    
    end
    P = [P v];
    
end



end

