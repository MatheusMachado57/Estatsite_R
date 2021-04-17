

setwd("C:\\Users\\mathe\\Desktop\\Arquivos\\Programação\\Machine Learn do 0 com R")

dados = read.csv(file = 'Iris_Alterada.csv', 
                 header=TRUE, 
                 sep=',', 
                 dec = '.')
head(dados)

# qual tipo do 'dados'
typeof(dados)

# qual tipo da coluna ID
typeof(dados$ID)

#todas as colunas
sapply(dados, class)

# acessa a terceira linha da coluna Species
dados$Species[[3]]

# acessa linha 3 e coluna 4 da base
dados[3,4]

# acessa a coluna Species
dados['Species']

# acessa a linha 3 da coluna Species
dados['Species'][[3]]

# acessa primeira coluna da base
dados[1]

# acessa primeira linha da base
dados[1,]

# cria um vetor
x = c(1,2,3,3,3,1,1)

# acessa quarto elemento do vetor
x[4]

# exclui o elemento 2 do vetor
x[-2]

##### 3. PRÉ-PROCESSAMENTO DA BASE

# Altera nome da coluna
names(dados)[names(dados) == "ID"] = "Id"

dados = dados[-1]
head(dados)

# Localiza Duplicidade da linha inteira
duplicated(dados) #aponta linhas duplicadas

# remove linhas duplicadas
dados = dados[!duplicated(dados), ]
duplicated(dados)

duplicated(dados$Id) # aponta duplicados

sum(duplicated(dados$Id)) # traz a contagem de duplicados

dados = dados[!duplicated(dados$Id), ] # remove duplicidade do campo Id

# Cria nova coluna concatenando campos
dados$coluna_nova1 = paste(dados$Id,dados$Species)

# cria nova coluna somando campos
dados$coluna_nova2 = dados$Petal.Length+dados$Petal.Width

# verifica alteracoes
head(dados)

# Remove coluna criada agora e Id(nao precisaremos mais)
dados = dados[c(-1,-7, -8)]

# verifica alteracao
head(dados)

##### 4. ANÁLISE DESCRITIVA (E INSTALAÇÃO DE PACOTES)
summary(dados)

# instala pacote
install.packages("Hmisc");
library("Hmisc");

# aplica describe nos dados
describe(dados);

##### 5. ANÁLISE EXPLORATÓRIA (~ ANÁLISE GRÁFICA)
hist(dados$Sepal.Length)

# histograma colorido e com outros detalhes
histograma = hist(dados$Sepal.Length, 
                  breaks = 10, 
                  col="darkblue", 
                  xlim=c(4,8),
                  main="Histograma Sepal Length", 
                  xlab="Sepal Length", 
                  ylab= "Frequencia");

dev.off() #encerrar graf anterior

# grafico com varios paineis, aqui em uma linha e duas colunas
# define como vai ser painel (1 linha, 2 colunas)
par(mfrow=c(1,2))

# plota graficos
hist(dados$Sepal.Length)
hist(dados$Sepal.Width)

dev.off() #encerrar graf anterior

# define como vai ser painel (2 linhas, 1 coluna)
par(mfrow=c(2,1))

#plota graficos
hist(dados$Sepal.Length)
hist(dados$Sepal.Width)

dev.off() #encerrar graf anterior

plot(dados$Sepal.Length)

# grafico de dispersao com duas variaveis e linha da regressao
plot(dados$Sepal.Length, 
     dados$Sepal.Width, 
     xlab="Sepal Length", 
     ylab = "Sepal Width", 
     main = "Grafico Length x Width")

abline(lm(Sepal.Width~Sepal.Length, 
          data=dados), 
       col="red")

##### 6. MODELAGEM ESTATÍSTICA: KNN

# Scale data
# Scale: (x - media(x)) / desvpad(x)
iris_normal = iris
iris_normal[, -5] = scale(iris[, -5])

set.seed(000000)

# Separa em treino e teste
## Gera indices da base treino e teste
train_index = sample(1:nrow(iris_normal), 
                     0.6*nrow(iris_normal), 
                     replace = FALSE)

## Gera base treino e teste
treino = data.frame()
treino = iris_normal[train_index,]
head(treino)

teste = data.frame()
teste = iris_normal[-train_index,]
head(teste)

# Carrega biblioteca para rodar KNN
library("class")

# Roda com k=2
Knn_K2= knn(treino[,-5], 
            teste[,-5],
            treino$Species, 
            k=2, 
            prob=TRUE)
Knn_K2

# Roda com k=3
Knn_K3= knn(treino[,-5], 
            teste[,-5],
            treino$Species, 
            k=3, 
            prob=TRUE)
Knn_K3

# Analisa a matriz de confusao para cada um
table(teste$Species, Knn_K2)
table(teste$Species, Knn_K3)

# Analisa acuracia
sum(Knn_K2==teste$Species)/length(teste$Species)*100
sum(Knn_K3==teste$Species)/length(teste$Species)*100

# Método para comparar diferentes k's
# cria uma lista para receber as predicoes
Knn_Testes = list()

# cria variavel para receber acuracia
acuracia = numeric()

# cria loop para testar de k=1 ate k=20
for(k in 1:20){
  Knn_Testes[[k]] = knn(treino[,-5], 
                        teste[,-5], 
                        treino$Species, 
                        k, 
                        prob=TRUE)
  acuracia[k] = sum(Knn_Testes[[k]]==teste$Species)/
                length(teste$Species)*100
}

max(acuracia)
which.max(acuracia)

# Comparacao grafica das acuracias
plot(acuracia, 
     type="b", 
     col="blue", 
     cex=1, 
     pch=1,
     xlab="k", 
     ylab="Acuracia",
     main="Acuracia para cada k")

# Linha vertical vermelha marcando o maximo
abline(v=which(acuracia==max(acuracia)), 
       col="red", 
       lwd=1.5)

# Linha horizontal cinza marcando o maximo
abline(h=max(acuracia), 
       col="grey", 
       lty=2)

# Linha horizontal cinza para marcar o minimo
abline(h=min(acuracia), 
       col="grey", 
       lty=2)

acuracia

# informações da flor que queremos definir a especie
flor_exemplo = c(5, 3.6, 1.5, 0.5)

# copia o cabecalho da base teste
base_exemplo = teste[0:1, -5]
base_exemplo

# une cabecalho com a flor
base_exemplo = rbind(base_exemplo, 
                     flor_exemplo)
base_exemplo

# exclui primeira linha
base_exemplo = base_exemplo[2,]
base_exemplo

Knn_K5_Predicao = knn(treino[,-5], 
                      base_exemplo,
                      treino$Species, 
                      k=7, 
                      prob=TRUE)
Knn_K5_Predicao

##### 7. MODELAGEM ESTATÍSTICA: REGRESSÃO LINEAR

# verifica algumas linhas da base
head(cars)

# plota o grafico das duas variaveis
plot(cars$dist,cars$speed)

cor(cars$speed, cars$dist)

# constroi o modelo
linearMod = lm(dist ~ speed, data=cars)

# exibe os resultados
print(linearMod)

summary(linearMod)

##### 8. MODELAGEM ESTATÍSTICA: REGRESSÃO LOGÍSTICA
install.packages("kernlab", dependencies=TRUE)
library("kernlab")
data(spam)

head(spam)
dim(spam)
summary(spam)

install.packages("caret")
library(caret);
indice.treino = createDataPartition(y=spam$type, 
                                    p=0.75, 
                                    list=FALSE)
treino = spam[indice.treino, ]
teste = spam[-indice.treino, ]

sapply(treino, function(x) sum(is.na(x)))

modelo = glm (type_new ~ our+over+remove, 
              data = treino, 
              family = binomial)

summary(modelo)

odd.ratio = exp(coef(modelo))

pred.Teste = predict(modelo,
                     teste, 
                     type = "response")

Teste_v2 = cbind(teste,
                 pred.Teste)

install.packages("ROCR")
library(ROCR)
pred.val = prediction(pred.Teste,
                      Teste_v2$type)

# calculo da auc (area under the curve)
auc = performance(pred.val,"auc")

# Plota curva ROC
performance = performance(pred.val, "tpr", "fpr")
plot(performance, col = "blue", lwd = 5)

#Calculo Estatística KS
ks <- max(attr(performance, 
               "y.values")[[1]] - (attr(performance, "x.values")[[1]]))
ks

#confusion matrix
table(teste$type, pred.Teste > 0.5)

