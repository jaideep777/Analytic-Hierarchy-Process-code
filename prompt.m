function n = prompt(prompt_s, mode)

t = input(prompt_s, 's');

if mode == 0    % mode = 0 for defaults, else prompt till provided
    t = 1;      % use default value if not provided
else
    while isempty(t)    % prompt until value is entered
        t = input('', 's');
    end
end
n = str2num(t);

end