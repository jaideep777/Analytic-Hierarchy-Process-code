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