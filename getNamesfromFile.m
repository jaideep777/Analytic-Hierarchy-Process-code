function [techNames attNames attTree nA nT qualFlags] = getNamesfromFile(fname)

% techNames = [T1 T2 T3 ... ] in the order that they are input
% attNames  = [Root A1 A2 A3 a11 a12 a21 a22 a23 ...] in the order received
% qualFlag  = [     f1 f2 f3 f11 ...                ] f = 1 if qual, 0 if quant
% attTree (example) = 
%       node    qual children   quant children
%     [ 0       1 4             5             ]    in input from file, listing will be depth first
%     [ 1       2 3             -             ]
%     [ 2       -               -             ]
%     [ 3       -               -             ]
%     [ 4       -               -             ]
%     [ 5       -               6 7           ]
%     [ 6       -               -             ]
%     [ 7       9               8             ]
%     [ 8                                     ]

techNames = {};
attTree = {0 [] []};
attNames = {'Root'};
qualFlags = [];
qu = 0;
nprev = -1;
nA = 0;
nT =0;

% GET NAMES OF ALTERNATIVES
% fprintf('Please Provide the names of alternatives and attributes:\n\n')
% fprintf('Enter names of Alternatives. Press Enter when done.\n')
fin = fopen(fname);

while (1)
    s = fgetl(fin);
    if s == '$'
        break
    end
end

while (1)
    s = fgetl(fin);
    if s == '~'
        break
    else
        techNames = [techNames s];
        nT = nT +1;
    end
end

while (1)
    s = fgetl(fin);
    if s == '$'
        break
    end
end

% GET ATTRIBUTE NAMES

while (1)
    s = fgetl(fin);
    if s == '~'
        break;
    else
        nA = nA +1;
        n = 0;
        while(s(1) == '-')
            n = n+1;
            s(1) = [];
        end
        
        qualnum = s(length(s));
        qual = str2num(qualnum);
        qualFlags = [qualFlags, qual];
        name = s(1:length(s)-1);
        id = nA;
        
        attTree = [attTree; {id [] []}];
        attNames = [attNames name];
        
        
        while (n <= nprev)
            qu(1) = [];
            nprev = nprev-1;
        end
        
        if n > nprev
            head = qu(1);
            parent = cell2mat(attTree(head+1, 1));
            qualAtts = cell2mat(attTree(head+1, 2));
            quantAtts = cell2mat(attTree(head+1, 3));
            
            if qual == 1
                qualAtts = [qualAtts, nA];
            else
                quantAtts = [quantAtts, nA];
            end
            
            attTree(head+1,:) = {parent, qualAtts quantAtts};

        end
        qu = [id, qu];
        nprev = n;
        
    end
    
   
end

fprintf('Your %i Alternatives are:\n', length(techNames));
disp(techNames');

fprintf('\n\nYour Attribute Tree is:\n');
disp(attNames');
fprintf('\n')
for i=0:nA
    parent = cell2mat(attTree(i+1, 1));
    qualAtts = num2str(cell2mat(attTree(i+1, 2)), '%i ');
    quantAtts = num2str(cell2mat(attTree(i+1, 3)), '%i ');
    
    fprintf('  %4.0f  |  %s, %s\n', parent, qualAtts, quantAtts);
end

end