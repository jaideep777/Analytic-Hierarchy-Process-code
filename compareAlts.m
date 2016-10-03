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

