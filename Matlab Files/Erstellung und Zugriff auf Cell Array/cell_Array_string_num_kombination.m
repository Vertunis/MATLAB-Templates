A={'string1', 'string2', 'string3'};
num=[1  2  3;
     4  5  6;
     7  8  9];

for i=1:3
    
    kombi_AB{1,i}=A{1,i};
    
    for j=2:4
    
    kombi_AB{j,i}=num(j-1,i);

    end    
    
end

show=kombi_AB