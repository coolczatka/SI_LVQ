%LVQ Neural network training

clear all

nntwarn off
load danee
S1_vec          = [3:3:30];
lr_vec          = [0.01 .1:.1:.9 .95 .99];
q               = zeros(length(S1_vec),length(lr_vec));
liczba_petli    = length(S1_vec)*length(lr_vec);
licznik_petli   = 0;
we=we'
wy=wy'
for ind_S1 = 1:length(S1_vec),% S1 = 9; %for
    CVTrainTarget = ind2vec(wy);
    CVTrain = we;
    [w1, w2]= initlvq(CVTrain, S1_vec(ind_S1), CVTrainTarget);
    for ind_lr = 1: length(lr_vec),
        licznik_petli = licznik_petli + 1;
        TP = [2 4 lr_vec(ind_lr)]; %for
        [w1, w2] = trainlvq(w1, w2, CVTrain, CVTrainTarget, TP);
        a = simulvq(CVTrain, w1, w2);
        
        a = vec2ind(a);

        % [T' a' (T-a)' (abs(T-a)>=0.5)']
        q(ind_S1,ind_lr)=(1-sum(abs(T-a)>=0.5)/length(Pn))*100;
%         [ind_S1 ind_S2 q(ind_S1,ind_lr)]
        [licznik_petli/liczba_petli*100 q(ind_S1,ind_lr)]
    end
end

mesh(q)
% plot([1:length(T)],T,'r',[1:length(T)],a,'g')

