% Lab 3
% 2017-12-02 Karl Hallberg
% (ditt datum ditt namn)

% Det som beh�vs g�ras som jag inte l�ste var att g�ra en pie() av de 10
% mest frekventa bokst�verna i text-filen, min funktion slutar efter att
% bokst�verna slutar vara j�ttefrekventa. N�gon sorts funktion som r�knar
% igenom alla elementen kr�vs och sedan g�ra ett diagram av det

% L�ser in en krypterad fil och g�r den till
% stora bokst�ver samt konverterar dem till ASCII
fid = fopen('krypterad1.txt','rt');
textOriginal = fscanf(fid,'%c',Inf);
textUpper = upper(textOriginal);
textAsc = double(textUpper);
textTest = textAsc; % anv�nder mig utav textTest f�r att kunna dekryptera fr�n originaltext sedan

% Kom p� att mellanslag �r 32 i ASCII s� tar bort
% dem fr�n min array jag modifierar men den verkar EJ FUNGERA det verkar
% inte beh�vas men det kan komma upp som en frekvent bokstav i sm� texter
% s� l�r beh�va fixa, find(textTest==0) = [] gissar jag skulle kunna
% fungera p� ngt s�tt
i = 1;
while i < length(textTest)
    if textTest(i) == 32
        textTest(i) = [];
    end
    i = i + 1;
end
% Sorterar i storleksordning
textTest = sort(textTest);

% mode kollar det mest frekventa tecknet i arrayn och jag kollar
% efter det sedan tar jag bort den och alla andra f�rekomster fr�n textTest
% f�r att kunna skaffa en samling av mest frekventa bokst�ver
throw = [];
i = 1;
while i < length(textTest) % den forts�tter tills det �r bara bokst�ver som f�rekommer lika m�nga ggr eller v�ldigt f� jag vet inte riktigt
    M = mode(textTest);    % vilket var smidigt f�r mig f�r d� har jag bara v�ldigt frekventa
    if textTest(i) == M
        textTest(textTest==M) = []; % s�ker alla f�rekomster av den mest frekventa och tar bort dem
        throw = [throw M]; % l�gger in dem i en egen array och anv�nder nu l�ngre inte textTest
    end
    i = i + 1;
end     

% f�r k fr�n 1 till antal frekventa bokst�ver jag samlade p� mig s� testar
% den fr�n E som �r 69 i ASCII, som �r den mest frekventa bokstaven. H�r
% samlar jag d� ett g�ng rullningar som jag sedan testar flera av, ifall E
% inte var det som f�rekom flest.
for k = 1:length(throw)
    throw(k) = (throw(k) - 69);
end

% skapar bara en vektor med alla rullningar som heter rullning, on�dig
% egentligen
rullning = [];
for k = 1:length(throw)
    rullning = [rullning throw(k)];
end

% skapar en matris med nollor som har lika m�nga rader som rullningar, s�
% att jag kan testa flera olika rullningar i samma matris sedan men p�
% separata rader, l�ngd av hela texten ocks�
dek = zeros(length(rullning), length(textAsc));

% huvud-loopen h�ller p� tills jag har slut p� rullningar att f�rs�ka men
% loopen inuti k�r hela texten, d�r den d� byter ut ASCII i originaltexten
% mot ASCII ifr�n mina rullningar, if-else och det �r f�r att de rullar
% �ver fr�n Z till B t.ex. och hade f�tt en ASCII som ej st�mde, alfabetet
% g�r fr�n A=65 till Z=90
i = 1;
while i <= length(rullning)
    for k = 1:length(textAsc)
        dek(i,k) = textAsc(k) - rullning(i); % rullar bak k:te elementet p� den raden som st�mmer med den specifika rullningen
        if dek(i,k) <= 64
            dek(i,k) = dek(i,k) + 26;
        elseif dek(i,k) > 90
            dek(i,k) = dek(i,k) - 26;
        elseif dek(i,k) == 32
            dek(i,k) = 32;
        end
    end
    i = i + 1;
end

% h�r skriver jag bara in det avkrypterade in i en egen fil f�r det var
% r�tt s� stora texter och jag trodde det skulle hj�lpa med formatteringen
dekrypterad = fopen('dekrypterad.txt','w');
fprintf(dekrypterad, char(dek)); %char g�r om till bokst�ver igen fr�n ASCII
fclose(dekrypterad);