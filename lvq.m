% wyczyszczenie przestrzeni ekranowej
clear all

% wy³¹czanie ostrze¿eñ, np. o przestarza³ych funkcjach
nntwarn off

format compact 
load danee;

% wczytanie macierzy wektorów wejœciowych
% wczytanie macierzy wektorów wejœciowych
P = we;

% wczytanie macierzy wektorów wyjœciowych
T = wy;


% transpozycja macierzy
P = P';
T = T';                                         

% normalizacja danych wejœciowych
ymax = 1;
ymin = -1;
pmax = max(P');
pmin = min(P');
Pn = zeros(size(P));
for i=1:length(pmax)
    Pn(i,:) = (ymax-ymin)/(pmax(i)-pmin(i))*(P(i,:)-pmin(i))+ymin;
end 

% liczba neuronów w pierwszej warstwie
S1 = 1;

nr=1;
  
for S1 = [10 : 10 : 10]
for lr = [0.01 : 0.05 : 0.50]
for epoch = [1000 : 1000 : 10000]

    % przekszta³cenie w macierz zerojedynkow¹
    Tv = ind2vec(T); 

    % parametry treningowe
    TP = [2000 epoch lr];  

    % inicjalizacja sieci LVQ
    [w1, w2] = initlvq(Pn, S1, Tv); 

    % trening sieci
    [w1, w2] = trainlvq(w1, w2, Pn, Tv, TP);

    % symulacja sieci          
    a = simulvq(Pn, w1, w2);              

    % przekszta³cenie macierzy zerojedynkowej w wektor indeksowy
    a = vec2ind(a);

    % [T' a' (T-a)' (abs(T-a)>0.5)']
    skutecznosc = (1-sum(abs(T-a)>0.5)/length(Pn))*100; 

    tab_w(nr,1) = S1;
    tab_w(nr,2) = lr;
    tab_w(nr,3) = epoch;
    tab_w(nr,4) = skutecznosc;
    nr = nr+1;

end              
end 
end
tablica=[tab_w];
save wyniki_tablica tablica