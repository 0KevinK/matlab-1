%
%
%
fid = fopen('krypterad1.txt','rt');
textOriginal = fscanf(fid,'%c',Inf)
textUpper = upper(textOriginal);
textAsc = double(textUpper);
textTest = textAsc;

i = 1;
while i < length(textTest)
    if textTest(i) == 32
        textTest(i) = [];
    end
    i = i + 1;
end

textTest = sort(textTest);

throw = [];
i = 1;
while i < length(textTest)
    M = mode(textTest);
    if textTest(i) == M
        textTest(textTest==M) = [];
        throw = [throw M];
    end
    i = i + 1;
end     

for k = 1:length(throw)
    throw(k) = (throw(k) - 69);
end

rullning = [];
for k = 1:length(throw)
    rullning = [rullning throw(k)];
end

dek = zeros(length(rullning), length(textAsc));
i = 1;
while i <= length(rullning)
    for k = 1:length(textAsc)
        dek(i,k) = textAsc(k) - rullning(i);
        if dek(i,k) <= 64
            dek(i,k) = dek(i,k) + 26;
        elseif dek(i,k) > 90
            dek(i,k) = dek(i,k) - 26;
%         elseif dek(i,k) == 32
%             dek(i,k) = 32;
        end
    end
    i = i + 1;
end

dekrypterad = fopen('dekrypterad.txt','w');
fprintf(dekrypterad, char(dek));
fclose(dekrypterad);