
library("kernlab")
data(spam)

head(spam)
dim(spam)
summary(spam)

library(caret);
indice.treino <- createDataPartition(y=spam$type, 
                                     p=0.75, 
                                     list=FALSE)
treino = spam[indice.treino, ]
teste = spam[-indice.treino, ]

sapply(treino, function(x) sum(is.na(x)))

modelo = glm (type_new ~ our+over+remove, 
              data = treino, 
              family = binomial)
summary(modelo)

summary(modelo)$coefficients

odd.ratio = exp(coef(modelo))

pred.Teste = predict(modelo,teste, type = "response")
Teste_v2 = cbind(teste,pred.Teste)

library(ROCR)
pred.val = prediction(pred.Teste ,Teste_v2$type)

# calculo da auc (area under the curve)
auc = performance(pred.val,"auc")

# Plota curva ROC
performance = performance(pred.val, "tpr", "fpr")
plot(performance, col = "blue", lwd = 5)

#Calculo Estatística KS
ks <- max(attr(performance, 
               "y.values")[[1]] - (attr(performance, 
                                        "x.values")[[1]]))
ks

#confusion matrix
table(teste$type, pred.Teste > 0.5)
