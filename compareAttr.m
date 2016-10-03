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