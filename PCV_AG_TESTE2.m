clear
clc

n_individuos = 10;
geracoes = 50;
Cidades = [1 2 3 4 5 6 7 8 9 10]; %Declaração das cidades
Coordenadas = randi([0 100],10,2); %Cordenadas das cidades (x,y) ate 100km de distancia
C = zeros(10,11); %Matriz que recebera as sequencias geradas
Nome = {'A' 'B' 'C' 'D' 'E' 'F' 'G' 'H' 'I' 'J'};
plot(Coordenadas(:,1),Coordenadas(:,2),'--ws',...
        'LineWidth',1,...
        'MarkerSize',10,...
        'MarkerEdgeColor','b',...
        'MarkerFaceColor',[0.5,0.5,0.5])

for ger = 1:1:geracoes
    
    for g=1:1:n_individuos
        C(g,1:10)= Cidades(randperm(length(Cidades))); %Geração aleatória de caminhos
    end
    if ger >= 2 %A partir da segunda geração, Elitismo
        for d=1:1:2
            C(Ind_Elit(d)) = Elite(Ind_Elit(d));
        end
    end
    C(:,11) = C(:,1);
    %Seleção por torneio
    subpop_ind = randperm(10, 3); %Escolhendo 3 indivíduos aleatórios para formarem nova população
    for a = 1:1:length(subpop_ind)
        subpop(a,:) = C(subpop_ind(a),:); %Montando subpopulação para função objetivo
        for b = 1:1:n_individuos
            D(b) = sqrt((Coordenadas(subpop(a,b+1),2) - Coordenadas(subpop(a,b),2))^2+(Coordenadas(subpop(a,b+1),1)-Coordenadas(subpop(a,b),1))^2);
        end
        D4(a,:) = D;
        Distancias(a,:) = [sum(D) subpop_ind(a)];
        DistanciasRank = mink(Distancias,10);
    end
    Prob_T1 = rand; %Probabilidade Torneio Pai_1
    Prob_T2 = rand; %Probabilidade Torneio Pai_2
    if Prob_T1 > 0.7
        [linha, coluna] = find(Distancias==DistanciasRank(1,1));
        Pai_1(1,:) = C(Distancias(linha(end),2),:);
    else
        [linha, coluna] = find(Distancias==DistanciasRank(3,1));
        Pai_1(1,:) = C(Distancias(linha(end),2),:);
    end
    if Prob_T2 > 0.7
        if Prob_T1 < 0.7
            [linha2, coluna2] = find(Distancias==DistanciasRank(1,1));
            Pai_2(1,:) = C(Distancias(linha2(end),2),:);
        else
            [linha2, coluna2] = find(Distancias==DistanciasRank(2,1));
            Pai_2(1,:) = C(Distancias(linha2(end),2),:);
        end
    else
        if Prob_T1 < 0.7
            [linha2, coluna2] = find(Distancias==DistanciasRank(3,1));
            Pai_2 = C(Distancias(linha2(end),2),:);
        else
            [linha2, coluna2] = find(Distancias==DistanciasRank(2,1));
            Pai_2 = C(Distancias(linha2(end),2),:);
        end
    end
    %Cruzamento dois pontos
    Ponto_1 = randi([2 4]);
    Ponto_2 = randi([6 10]);
    Filho_1 = [Pai_1(1:Ponto_1) Pai_2(Ponto_1+1:Ponto_2) Pai_1(Ponto_2+1:end)]; %Filho_1
    Filho_2 = [Pai_2(1:Ponto_1) Pai_1(Ponto_1+1:Ponto_2) Pai_2(Ponto_2+1:end)]; %Filho_2
    %_____________Tratamento para o caso de repetição de números após o cruzamento_________
    Posic_Filho1 = 0;
    Posic_Filho1 = histc(Filho_1,1:max(Filho_1));
    if length(Posic_Filho1) < 10
        Posic_Filho1(length(Posic_Filho1)+1:10) = 0;
    end
    Posic_Filho2 = 0;
    Posic_Filho2 = histc(Filho_2,1:max(Filho_2));
    if length(Posic_Filho2) < 10
        Posic_Filho2(length(Posic_Filho2)+1:10) = 0;
    end
    for p = 1:1:length(Posic_Filho1)
        if Posic_Filho1(p) > 1
            rep_f1(p,1) = p;
            rep_f1(p,2) = Posic_Filho1(p)-1;
            if (Posic_Filho1(p) == 2) && (Filho_1(1) == rep_f1(p,1))
                rep_f1(p,1) = 0;
                rep_f1(p,2) = 0;
            elseif (Posic_Filho1(p) > 2) && (Filho_1(1) == rep_f1(p,1))
                rep_f1(p,1) = p;
                rep_f1(p,2) = 1;
            end
        end
        if Posic_Filho2(p) > 1
            rep_f2(p,1) = p;
            rep_f2(p,2) = Posic_Filho2(p)-1;
            if (Posic_Filho2(p) == 2) && (Filho_2(1) == rep_f2(p,1))
                rep_f2(p,1) = 0;
                rep_f2(p,2) = 0;
            elseif (Posic_Filho2(p) > 2) && (Filho_2(1) == rep_f2(p,1))
                rep_f2(p,1) = p;
                rep_f2(p,2) = 1;
            end
        end
    end
    if length(rep_f1) < 10
        rep_f1(length(rep_f1)+1:10,1) = 0;
        rep_f1(length(rep_f1)+1:10,2) = 0;
    end
    if length(rep_f2) < 10
        rep_f2(length(rep_f2)+1:10,1) = 0;
        rep_f2(length(rep_f2)+1:10,2) = 0;
    end
    trocar_f1 = find(rep_f1(:,2)>=1);
    trocar_f2 = find(rep_f2(:,2)>=1);
    if length(trocar_f1) > length(trocar_f2)
        tam = length(trocar_f2);
    else
        tam = length(trocar_f1);
    end
    for p2 = 1:1:tam
        for p3 = 1:1:length(Filho_1)
            if (trocar_f1(p2) == Filho_1(p3)) && (p3~=1)
                Filho_1(p3) = trocar_f2(p2);
                break;
            end
        end
        for p4 =1:1:length(Filho_2)
            if (trocar_f2(p2) == Filho_2(p4)) && (p4~=1)
                Filho_2(p4) = trocar_f1(p2);
                break;
            end
        end
    end
    %________________Mutação______________________
        Prob_mut_1 = randi([1 100])/1000;
        Prob_mut_2 = randi([1 100])/1000;
        if Prob_mut_1 < 0.01 %Mutação Filho 1
            posic_1 = randi([2 10],1,1);
            posic_2 = randi([2 10],1,1);
            var = Filho_1(posic_1);
            Filho_1(posic_1) = Filho_1(posic_2);
            Filho_1(posic_2) = var;
        end
        if Prob_mut_2 < 0.01 %Mutação Filho 2
            posic_1 = randi([2 10],1,1);
            posic_2 = randi([2 10],1,1);
            var = Filho_2(posic_1);
            Filho_2(posic_1) = Filho_2(posic_2);
            Filho_2(posic_2) = var;
        end
    C(Distancias(linha(end),2),:) = Filho_1; %Substituindo Pai_1 por Filho_1 na População
    C(Distancias(linha2(end),2),:) = Filho_2; %Substituindo Pai_2 por Filho_1 na População
    %     %Elitismo = 2 individuos
    for a1 = 1:1:10
        for b1 = 1:1:n_individuos
            D2(b1) = sqrt((Coordenadas(C(a1,b1+1),2) - Coordenadas(C(a1,b1),2))^2+(Coordenadas(C(a1,b1+1),1)-Coordenadas(C(a1,b1),1))^2);
        end
        D3(a1,:) = D2;
        Distancias1(a1,:) = [sum(D2) C(a1)];
        [N_Av,Ind_Av] = min(Distancias1(:,1));
    end
    m_aval(ger,:) = C(Ind_Av,:); %Indica o indivíduo e armazena
    [Elit, Ind_Elit] = mink(Distancias1(:,1),2);
    for cont=1:1:2
        Elite(cont,:) = C(Ind_Elit(cont),:);
    end
end
for a2 = 1:1:10
    for b2 = 1:1:n_individuos
        D5(b2) = sqrt((Coordenadas(C(a2,b2+1),2) - Coordenadas(C(a2,b2),2))^2+(Coordenadas(C(a2,b2+1),1)-Coordenadas(C(a2,b2),1))^2);
    end
    D6(a1,:) = D5;
    Distancias2(a2,:) = [sum(D5) C(a2)];
    [result_ag,posic_ag] = min(Distancias2(:,1));
end
final = m_aval(posic_ag,:)
disp(result_ag);