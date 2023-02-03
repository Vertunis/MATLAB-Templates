%{
Bitwise Operations Befehle:
bitand 	 Bit-wise AND
bitcmp 	 Bit-wise complement
bitget 	 Get bit at specified position
bitor 	 Bit-wise OR
bitset 	 Set bit at specific location
bitshift Shift bits specified number of places
bitxor 	 Bit-wise XOR
swapbytes 	Swap byte ordering
%}
i=1;

switch i
    
    case 1
a = 21; %Binär '10101', Dezimal 21
b = 10; %Binär '01010', Dezimal 10
c = 10; %Binär '01010', Dezimal 10

    case 2
a = dec2bin(21); %Binär '10101', Dezimal 21
b = dec2bin(10); %Binär '01010', Dezimal 10
c = dec2bin(10); %Binär '01010', Dezimal 10

end


e1 = bitand(a,b,'int8') %ergibt Binär '00000', Dezimal 0
e2 = bitand(b,c,'int8') %ergibt Binär '01010', Dezimal 10
e3 = bitor(a,b,'int8')  %ergibt Binär '11111', Dezimal 31
e4 = bitor(b,c,'int8')  %ergibt Binär '01010', Dezimal 10