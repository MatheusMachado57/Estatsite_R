
# Falo de Regressão Linear desde o começo desse blog porque 
# é um dos primeiros tópicos em modelagem estatística. 
# Não menos importante, acredito que regressão logística 
# seria o segundo passo para quem quer realmente fazer modelos. 
# Se você já se aproximou de alguma forma de modelagem estatística, 
# você com certeza já ouviu falar dela.

# O motivo dessa regressão ser ensinada e ter tanto foco é simples, 
# ela traz a resposta de questões que precisamos responder no 
# mundo de crédito, vendas, etc. 
# Uma das coisas que mais gostaríamos de saber quando trabalhamos 
# com crédito é se o cliente vai pagar ou não o dinheiro 
# que tomou emprestado. 
# Veja que a variável resposta aqui é se o cliente paga ou não 
# o crédito, é binária: sim ou não.

# Enquanto na regressão linear temos uma variável resposta contínua 
# (e.g.: o valor da dívida), na regressão logística nossa variável 
# resposta é binária, 0 ou 1.

# Vamos supor que você emprestou dinheiro para um colega. 
# Há dois eventos possíveis desse empréstimo: seu amigo paga ou não. 
# Se o seu amigo tiver um bom salário, um emprego estável e 
# um histórico impecável, é provável que ele te pague. 
# Agora, se ele estiver desempregado, tiver fama de caloteiro e 
# estiver atolado em dívidas, a probabilidade de ele não pagar é maior. 
# Pois é isso que a regressão logística (ou o logit) vai te proporcionar.


##### **Assim como Árvore de Decisão, é 
#       simples de entender e fácil de se implementar.**

# A saída do Logit não é exatamente a probabilidade, 
# mas te leva a ela através do odds ratio:
  
# logit(p) = ln(p/(1-p))
# ln(odds) = ln(p/(1-p))
# odds = p/ (1-p)

# Sendo p = probabilidade de ocorrência do evento e 
# 1-p = probabilidade de não ocorrência

##### **Alguns pontos que valem mencionar:**

# Na regressão logística não assumimos uma relação linear entre 
# a variável dependente e independente;

# Erros não têm distribuição normal;

# Utilizamos a máxima verossimilhança, e não mínimos quadrados.

# **----------------------------------------------------------------------**
  
# Regressão logística é uma técnica estatística muito poderosa, 
# utilizada para modelagem de saídas binárias (sim ou não). 
# Quando se quer medir a relação de uma variável dependente 
# binária com uma ou mais variáveis independentes, 
# é comum utilizar esta técnica. 
# Pense, por exemplo, numa empresa que empresta dinheiro para um cliente. 
# Com base nas informações deste cliente (idade, profissão, etc.), 
# é interessante a empresa tentar prever se o cliente vai 
# pagar a dívida ou não. 
# Uma forma de tentar prever isso é utilizando a regressão logística. 

# Neste post, vamos entender como construir uma regressão logística no R. 
# Claro, é importante ter conhecimento da matemática por trás desta técnica. 
# Mas isso deixarei para outro post. 
# Por enquanto, vamos nos focar na execução. 
# Sei que não é a melhor forma de ensinar, mas como já tenho o 
# código preparado, acho que postar de imediato pode ser útil para quem 
# já entende o conceito. 
# Um pouco mais sobre a regressão logística, você pode encontrar 
# no post Regressão Logística: Primeiros Passos.

# Vamos construir nossa regressão logística utilizando como exemplo 
# os dados de spam. Inicialmente, vamos carregar o pacote kernlab e 
# os dados de spam:
  
# **---------------------------------------------------------------------**
  
### Pacotes usados:
  
library("kernlab")
library(caret)
library(ROCR)

# **---------------------------------------------------------------------**
  
# Como você pode não saber exatamente o que há dentro de spam, 
# é importante verificar algumas coisas, 
# como as primeiras linhas da tabela, o total de linhas e colunas, 
# uma estatística descritiva resumida:
  
data(spam)
head(spam)
dim(spam)
summary(spam)

spam$type_new = ifelse(spam$type == "spam", 1, 0)

# Como você pode ver, temos 58 colunas e 4.601 linhas. 
# A base tem diversas características de e-mails 
# (e.g.: quantidade de letras maiúsculas, 
# quantidade de ponto e vírgula, etc.) e uma coluna marcando 
# se o e-mail é um spam ou não. 
# Ou seja, temos um histórico de e-mails, as informações deles e 
# se o e-mail é um spam ou não. 
# Com isso, podemos tentar construir um modelo que seja capaz de 
# prever se um e-mail é um spam ou não, 
# com base em algumas características.

# Em primeiro lugar, precisamos separar a base treino e teste. 
# Para facilitar o trabalho, vamos carregar o pacote caret que 
# possui várias funções de modelagem. 
# Em seguida, utilizamos a função createDataPartition para separar 
# a base de forma aleatória na proporção 75-25. 
# Com base na separação feita, criamos a base treino e o que 
# não estiver nela será a base teste:
  
indice.treino <- createDataPartition(y = spam$type, 
                                     p = 0.75, 
                                     list = FALSE)
treino = spam[ indice.treino, ]
teste  = spam[-indice.treino, ]


# Você pode, e deve, fazer algumas análises na sua base. 
# Por exemplo, temos algum missing nela?
  
sapply(treino, function(x) sum(is.na(x)))

# Note que, para nossa sorte, não há nenhum NA na base inteira. 
# Se houvesse, poderíamos trata-los de diversas formas: 
# excluindo as linhas, preenchendo-as com a média da coluna a 
# qual pertence, preenchendo-a através do método KNN, etc.

# Poderíamos, também, fazer uma análise gráfica. 
# Porém, você pode ver diversos tutoriais de gráficos no R e aplicá-los aqui 
# (veja Gráficos em R, Personalizando seu gráfico do 
# ggplot2 – Exports and Imports, William Playfair, Mais gráficos no R: 
# qqplot(), Histograma no R).

# **Vamos então ao modelo:**

modelo = glm(type_new ~ our + over + remove, 
             data   = treino, 
             family = binomial)

summary(modelo)


# Veja que as todas as variáveis são estatisticamente significantes. 
# Você poderia ainda utilizar o stepwise na seleção de variáveis, 
# bastaria rodar step(modelo). 
# No stepwise, as variáveis vão sendo testadas e mantidas de acordo 
# com sua significância.

# **Se você quiser ver os coeficientes da regressão:**

summary(modelo)$coefficients


# Lembre-se, os coeficientes de uma regressão logística não 
# são como os de uma regressão linear. 
# Enquanto na regressão linear tínhamos algo como y = beta0 + beta1.x, 
# na regressão logística temos log(p/1-p) = beta0 + beta1.x. 
# Não é necessário, mas você poderia, por causa disso, calcular 
# agora o odds ratio (veja também Regressão Logística: 
# Primeiros Passos):
  
odd.ratio = exp(coef(modelo))

# Seria um outro jeito de ler a equação.

# Agora, usamos a função predict para aplicar o modelo em nossa 
# base teste e já aproveitamos para criar uma nova base teste com 
# as projeções feitas pelo modelo:
  
pred.Teste = predict(modelo,
                     teste, 
                     type = "response")

Teste_v2   = cbind(teste, pred.Teste)

# Para saber se o modelo está bom, vamos usar a curva ROC e o KS:

pred.val = prediction(pred.Teste, Teste_v2$type)

# calculo da auc (area under the curve)
auc = performance(pred.val,"auc")


# Plota curva ROC
performance = performance(pred.val, "tpr", "fpr")

plot(performance, col = "blue", lwd = 5)

# Calculo Estatística KS
ks <- max(attr(performance, 
               "y.values")[[1]] - (attr(performance, 
                                        "x.values")[[1]]))
ks


# Um KS de 0.48 e uma curva ROC com AUC de 0.78 tornam nosso modelo ótimo.

# Poderíamos usar uma matriz de confusão também, 
# porém precisaríamos definir o corte usado na projeção para dizer se o 
# e-mail é spam ou não. 
# Aqui, vamos trabalhar com 0.5:
  

# confusion matrix
table(teste$type, pred.Teste > 0.5)

# Dos 697 nonspam, o modelo previu corretamente 655. Dos 352 que eram spam, 
# o modelo acertou corretamente 189.

# Os códigos aqui inseridos se destinam muito mais a quem já tem 
# alguma familiaridade com o conceito de regressão logística e as métricas 
# de avaliação de um modelo. 
# Para os que não compreenderam muita coisa, fiquem tranquilos que 
# em breve solto um material de regressão logística e todas essas 
# métricas de avaliação de performance do modelo.

# Se tiver qualquer dúvida, sugestão ou crítica, deixe seu comentário. 
# É importante para eu tentar manter um bom nível de posts no blog!
  
# Abraços e bons estudos!
