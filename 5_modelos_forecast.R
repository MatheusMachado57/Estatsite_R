# Há algumas formas básicas de se fazer projeções para valores 
# futuros (forecast), diferentes dos modelos geralmente falados 
# nesse blog, mas que podem ser úteis. A seguir, temos 5 métodos 
# simples que fazem parte do pacote fpp do R (na verdade são 
# parte do pacote forecast que é carregado junto).

# install.packages("fpp")
require("fpp")

# Os dados aqui utilizados são o ausbeer (produção trimestral 
# de cerveja na Austrália) que fazem parte do pacote fpp.

# 1 - Ingênuo (Naive): 
# Projeções com base no valor anterior. 
# Ou seja, se no trimestre disponível a produção foi de 374 
# megalitros, essa será a produção dos próximos trimestres 
# que queremos projetar:

## funcao naive
naive(ausbeer)

# Note que o valor previsto para o quarto trimestre de 2008 
# (e para os demais trimestres) é exatamente o valor do terceiro.

# Você pode traçar o gráfico das projeções utilizando a função 
# mais conhecida plot() ou então utilizar o autoplot() do pacote 
# ggplot2, que já produz um gráfico mais detalhado para suas projeções:
  
## grafico da projecao
plot(naive(ausbeer), 
     xlab="Ano", 
     ylab="Prod. de Cerveja", 
     main="Forecast Naive")

## grafico com autoplot()
autoplot(naive(dj))

# 2 - Ingênuo com Sazonalidade (Seasonal Naive): 
# Projeções com base no valor anterior, porém, 
# considerando a sazonalidade. Por exemplo, 
# se seus dados possuem sazonalidade trimestral, os valores serão 
# repetidos (assim como no forecast naive), mas referente ao trimestre 
# anterior. O valor projetado para o último trimestre do ano atual 
# refletirá o último trimestre do ano anterior. Assim, você não terá 
# uma projeção com um número se repetindo diversas vezes, mas sim quatro 
# números se repetindo (um para cada trimestre):

## funcao snaive
snaive(ausbeer)

# Se você deseja fazer uma projeção para um horizonte maior, 
# basta incluir o argumento com o número de períodos que 
# você quer fazer a projeção:
  
## funcao snaive com horizonte de 16 trimestres
snaive(ausbeer, 16)

## grafico com autoplot()
autoplot(snaive(ausbeer))

# 3 - Média: 
# Parte do princípio de que a projeção equivale a média dos 
# períodos anteriores. Por exemplo, se você teve uma produção de 10 
# no período 1 e 20 no período 2, a projeção (com essa técnica) 
# para o período 3 é de 15.

## projecao com media
meanf(ausbeer)

## projecao para os 12 prox periodos
meanf(ausbeer, 12)

## plota projecao
autoplot(meanf(ausbeer))

# 4 - Suavização Exponencial Simples (Simple Exponential Smoothing): 
# Uma mistura entre o método ingênuo e a média. É um método 
# interessante quando se quer atribuir maior peso aos valores mais 
# recentes. Como o próprio nome diz, o peso decresce exponencialmente 
# a medida que nos afastamos do presente. Nesse caso, controlamos 
# o peso através de um parâmetro ∝ pré-determinado. A fórmula 
# utilizada é a seguinte:Se optarmos por ∝ = 0,3, isso quer dizer 
# que o valor projetado para o período seguinte será o resultado da 
# soma do valor do período atual multiplicado por 0,2, com o período 
# anterior multiplicado por 0,21, com o do período anterior 
# multiplicado por 0,147 e assim em diante. No R, você pode utilizar 
# a função ses() para criar projeções similares à formula apresentada:

## simple exponential smoothing (ses) forecast com alpha 0.3
ses(ausbeer, alpha=0.3)

## grafico do forecast com ses
plot(ses(ausbeer,alpha=0.3),
     ylab="Prod.de Cerveja", 
     xlab="Ano", 
     main="Forecast com SES")

# Você pode chegar em um alpha mais preciso utilizando a função 
# HoltWinters(), e, inclusive, utilizar o forecast() ainda 
# não mencionada aqui nesse post:
  
## escolhe o melhor alpha (~0.15)
forecast_beer_SES = HoltWinters(ausbeer, 
                                beta = FALSE, 
                                gamma = FALSE)

## cria forecast com esse alpha (~419)
forecast(forecast_beer_SES )

## plot do forecast usando autoplot
autoplot(forecast(forecast_beer_SES))

# 5 - Regressão Linear: 
# Esse talvez seja o primeiro modelo “sofisticado” 
# que você irá aprender. Você pode entender mais sobre ele nos 
# posts Regressão Linear Simples – Parte 1, 
# Regressão Linear Simples – Parte 2, 
# Regressão Linear Simples – Parte 3 e 
# Regressão Linear Múltipla. 

# Aqui, apresento a função forecast.lm() fazer uma projeção com base 
# na regressão linear executada. Ou seja, tem como objetivo apenas 
# inserir as informações que você possui das variáveis independentes, 
# gerando projeções da variável dependente. No exemplo abaixo, 
# geramos o modelo utilizando parte dos dados (a chamada base treino) e
# fazemos a projeção dos valores com o restante dos dados (base teste). 

# Os dados utilizados são do próprio R, estão em faithful e consistem em 
# informações do tempo de duração de erupções (eruption) e o tempo 
# esperado entre as erupções (waiting):

## Gera indices que sao usados para separar base treino e teste (60-40)
treino_index = sample(1:nrow(faithful), 0.6*nrow(faithful), replace = FALSE);

## Separa a base treino e a teste
treino = data.frame()

treino = faithful[treino_index,]
teste = data.frame()

teste = faithful[-treino_index,]
## Roda regressao linear waiting em eruption utilizando dados da base treino

regressao = lm(eruptions~., data = treino)
summary(regressao)
## faz a projecao dos valores de eruption na base teste

forecast_teste = forecast:::forecast.lm(regressao, teste)

# Note que utilizamos forecast:::forecast.lm(), 
# isso porque essa é uma função escondida. 
# Diferente das outras, não conseguimos chamar diretamente. 
# Nesse caso não coloquei as projeções porque vai variar de 
# acordo com a amostra retirada. Mas não deve ser problema.

# É isso, esse é um post simples para quem quer uma 
# introdução a forecast utilizando o R.

# Parece bobo, mas essas técnicas não só servem de base para outras,
# como são aplicáveis em diversas oportunidades.

# Lembre-se de instalar o pacote fpp para ter acesso às 
# funções mencionadas nesse post.

