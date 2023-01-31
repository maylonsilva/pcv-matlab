# pcv-matlab
Resolução do Problema do Caixeiro Viajante utilizando MatLAB enquanto material de estudo da matéria Algoritmos Genéticos.

## Algoritmo Genético
Um Algoritmo Genético é um método de busca heurística inspirado pelo processo evolutivo da natureza. Ele é usado para encontrar soluções ótimas ou aproximadas para problemas difíceis ou de otimização.

Em um algoritmo genético, uma população de soluções é mantida e é submetida a operações de seleção, cruzamento (crossover) e mutação para criar uma nova geração de soluções. As soluções são avaliadas por uma função de aptidão que determina a qualidade da solução para o problema dado. A cada geração, as soluções melhores são mantidas e são combinadas para criar novas soluções que são avaliadas e mantidas ou descartadas. Este processo é repetido até que uma solução satisfatória seja encontrada ou o critério de parada seja atingido.

<div align="center">
<img src="http://computacaointeligente.com.br/assets/img/posts/GA/fluxograma.png" width="500px"/>
</div>

## O Problema do Caixeiro Viajante
O Problema do Caixeiro Viajante é um problema clássico de otimização de rotas em inteligência artificial e matemática. O objetivo é encontrar a rota mais curta para visitar e retornar a uma série de cidades, visitando cada uma delas apenas uma vez. É considerado um problema NP-difícil.

<div align="center">
<img src="https://otimizacaonapratica.files.wordpress.com/2015/11/pcv-soluc3a7c3a3o.png" width="350px"/>
</div>

## Técnicas Implementadas

### Seleção por torneio
A Seleção por Torneio é uma técnica para escolher indivíduos para reprodução. Neste processo, uma pequena amostra de indivíduos da população atual é selecionada aleatoriamente. Em seguida, a função de aptidão é aplicada a cada indivíduo da amostra para determinar a qualidade da solução que eles representam. O indivíduo com a melhor aptidão é selecionado para reprodução e é combinado com outros indivíduos selecionados para produzir uma nova geração.

A vantagem da seleção por torneio é que ela permite uma pressão de seleção forte, o que ajuda a manter as soluções de alta qualidade na população e evitar o declínio da aptidão. Além disso, a seleção por torneio é uma forma eficiente de seleção, pois apenas uma pequena amostra da população precisa ser avaliada a cada vez.

### Cruzamento com dois pontos
O Cruzamento de Dois Pontos é uma técnica de cruzamento utilizada para combinar as informações genéticas de dois indivíduos parentais para produzir filhos. Neste processo, dois pontos são escolhidos aleatoriamente ao longo da representação genética dos indivíduos parentais. Em seguida, os segmentos de informação genética entre esses pontos são trocados entre os indivíduos parentais para produzir dois novos indivíduos, os quais são considerados como filhos.

<div align="center">
<img src="https://bioinfo.com.br/wp-content/uploads/2021/04/word-image-2.png" width="500px"/>
</div>

A vantagem do cruzamento de dois pontos é que ele preserva informações genéticas de alta qualidade de ambos os indivíduos parentais. Além disso, o cruzamento de dois pontos pode gerar novas combinações de informações genéticas que podem resultar em soluções mais inovadoras e eficientes.

### Mutação 
A Mutação é uma técnica para introduzir variações na representação genética dos indivíduos. A mutação ocorre por meio da alteração aleatória de um ou mais genes em uma representação genética. Esse processo pode ser realizado de diferentes maneiras, como trocando o valor de um gene por outro, invertendo a ordem de segmentos de informação genética, ou adicionando ou removendo genes.

A mutação tem como objetivo introduzir novas soluções na população e evitar que a aptidão da população caia em um ponto de mínimo local. Além disso, a mutação também é importante para manter a diversidade genética da população, o que é crucial para o sucesso do algoritmo genético.

### Elitismo 
Elitismo é uma técnica que garante que a melhor solução encontrada até o momento sempre é mantida para a próxima geração de indivíduos. Isso significa que, em vez de deixar a solução ser completamente substituída pela geração subsequente, a melhor solução é mantida para garantir que a busca evolutiva não perca o melhor resultado já encontrado. O uso de elitismo pode melhorar a velocidade e a eficiência do algoritmo em encontrar uma solução ótima ou aproximada.
