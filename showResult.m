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