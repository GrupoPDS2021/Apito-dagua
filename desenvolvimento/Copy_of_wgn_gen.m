function X = wgn_gen(tam)
%Essa função gera um sinal gaussiano branco por meio da transformação
%Box-Muller
    u1 = rand(tam,1); %Gera um vetor u1 pseudoaleatóriode tamanho tam
    u2 = rand(tam,1); %Gera um vetor u2 pseudoaleatóriode tamanho tam
    r2 = -2*log(u1);
    th = 2*pi*u2;
    X = sqrt(r2).*sin(th); %Gera o vetor gaussiano X
end