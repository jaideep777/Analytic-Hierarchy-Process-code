function v = compareByQual(nT, techNames)

mu=10;
while (mu > 0.1)
% compare alternatives by qualititive attributes
    Wt = ones(nT,nT);
    for j=1+1:nT
        prompt_s = sprintf([char(techNames(1)), ' / ', char(techNames(j)), ' = ']);
        Wt(1,j) = prompt(prompt_s, 1);
        Wt(j,1) = 1/Wt(1,j);
    end
    
    cont = input('Do you want AHP to fill remaining entries? \nElse, pairwise comparison will continue. <y/n> : ', 's');

    for i=2:nT
        for j=i+1:nT
            if cont == 'n'
                prompt_s = sprintf([char(techNames(i)), ' / ', char(techNames(j)), ' = ']);
                Wt(i,j) = prompt(prompt_s, 1);
            else
                Wt(i,j) = Wt(1,j) / Wt(1,i);
            end
            Wt(j,i) = 1/Wt(i,j);
        end
    end
        
    [V,D] = eigs(Wt);
    [lmax, imax] = max(abs(diag(D)));
    v = V(:,imax);
    v = v/sum(v);

    mu = (lmax - nT) / (nT - 1);

    fprintf('\n\n[ Weights matrix | Eigenvector ] = \n\n')
    for i=1:length(v)
        fprintf('%s    |   %4.2f   |  %s\n', num2str(Wt(i,:), '%4.2f\t'), v(i), char(techNames(i)) );
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
