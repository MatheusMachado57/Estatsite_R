# Só a prática mesmo;

# Carrega pacote Caret para funcoes de modelagem
# Carrega pacote AppliedPredictiveModeling por causa da base
library(caret)
library(AppliedPredictiveModeling)

# Separa a base inicial em treino e teste (75-25)
set.seed(3433);
indice.amostra = createDataPartition(base$variavel.resposta, 
                                     p = 3/4)[[1]]
treino = base[ indice.amostra,]
teste  = base[-indice.amostra,]

# cria a funcao que faz a transformacao em pca na base treino 
# (sem a variavel resposta)
# encontrando os principal components que respondem 
# por 0.8 da variancia
# estamos supondo que a coluna 10 eh a da variavel resposta
preProc = preProcess(treino[ , -10],
                     method="pca",
                     thres=.8)

# Veja o resultado
preProc

# Agora, aplica a funcao na base treino sem a variavel resposta
treino.PC = predict(preProc,treino[,-10])
modelo = train(x = treino.PC, 
               y = treino$diagnosis, 
               method = "glm")

# Agora, primeiro aplicamos na base teste,
# a transformacao que fizemos no treino
teste.PC = predict(preProc, 
                   treste[,-10])

# agora, vejamos qual a acuracia do nosso modelo
# predict() serve para aplicar a funcao na base declarada
# ou seja, estamos aplicando o modelo na base teste
confusionMatrix(teste$diagnosis,
                predict(modelo,teste.PC))

# EXTRA: caso voce nao saiba a posicao da sua variavel resposta
# voce pode usar o codigo abaixo, substituindo o campo
# variavel_resposta pelo nome da sua variavel. Lembrando
# que o R eh case sensitive
treino[ , -which(names(treino) %in% 
                 c("variavel_resposta"))]

        
