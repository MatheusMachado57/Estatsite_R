# Árvore de decisão é um modelo simples e extremamente útil para fazer predições. 
# É fácil de explicar para as pessoas mais alheias ao mundo de ciência de 
# dados e machine learning. Além disso, é simples de identificar o poder 
# preditivo das variáveis, requer pouco pré-processamento, etc. 
# Hoje, vou apresentar o código em R para uma árvore de decisão.

# Primeiramente, a ideia aqui é apenas passar o esqueleto que você 
# precisa ter em mãos. Em outras palavras, não teremos teoria, 
# mas você vai poder pegar o código abaixo e trocar os dados pelo que 
# você tiver aí. Tive que fazer um trabalho sobre este tema em uma aula 
# do mestrado e por isso resolvi compartilhá-lo. Nesse exercício, 
# nós tínhamos a informação de um banco alemão (veja o link Statlog 
# (German Credit Data) Data Set  contendo as informações a 
# respeito dos clientes) e tínhamos que montar uma árvore de decisão 
# que retornasse se o cliente era um bom ou mau pagador.

# O arquivo utilizado no código estava em formato .cvs, 
# que o wordpress aparentemente não suporta pelo método tradicional 
# de adicionar arquivos, então vocês podem pegar o arquivo no formato 
# .xlsx para testarem: german_credit_21.

# Não há muito o que comentar aqui, divirtam-se com o código abaixo, 
# sigam os comentários que eu deixei e qualquer dúvida é só comentar o post.

setwd("C:/Users/mathe/Documents/GitHub/EstatSite_R")

require(readxl)
library("rpart")
library("ROCR")

dados <- read_xlsx("german_credit_21-1.xlsx")

## Discretiza as variaveis
Creditability_index1 = which(dados$Creditability == 1)
Creditability_index2 = which(dados$Creditability == 0)

dados$Creditability[Creditability_index1] = 'good' 
dados$Creditability[Creditability_index2] = 'bad'

## ifelse avalia antes de executar
dados$CreditAmount = ifelse(dados$CreditAmount <= 2500, 
                            "0-2500", 
                            ifelse(dados$CreditAmount < 5000, 
                                   "5000+", 
                                   "2500-5000"))

## Gera indices da base treino e teste
train_index = sample(1:nrow(dados), 
                     0.6*nrow(dados), 
                     replace = FALSE)

## Gera base treino e teste
train = data.frame()
train = dados[train_index,] 
test = data.frame()
test = dados[-train_index,]

## Usa rpart para decision tree
train_tree = rpart(Creditability~., 
                   data = train)

## Plota a árvore de decisão
plot(train_tree)

## Insere a legenda dos galhos
text(train_tree, 
     pretty = 0, 
     cex = 0.6)

## Predict como funcao para trazer a probabilidade do cliente ser mau/bom
test_tree_predict = predict(train_tree, 
                            newdata = test)

## Predict com tipo 'classe' retorna se é bom ou mau
test_tree_predict = predict(train_tree, 
                            newdata = test, 
                            type = "class")

## confusion matrix
table(test_tree_predict, 
      test$Creditability)
