## carrega ISLR
install.packages("ISLR", dependencies = TRUE)
library("ISLR")

## visualizando dados de WAGE
head(Wage)

## carregando o pacote CARET
install.packages("caret", dependencies = TRUE)
library(caret)

indice_treino = createDataPartition(y=Wage$wage, p=0.7, list=FALSE)
treino = Wage[indice_treino, ]
teste  = Wage[-indice_treino, ]
treino
teste

#####

serie_tempo = 1:1000
bases = createTimeSlices(y=serie_tempo, initialWindow = 20, horizon=10)

# verifica primeira base treino
bases$train

# verifica primeira base teste
bases$test
