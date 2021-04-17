install.packages("rpart.plot")
library("rpart.plot")

rpart.plot(train_tree, 
           type = 2, 
           yesno=F, 
           fallen.leaves = F,
           extra = 102, 
           under = T, 
           cex=NULL, 
           uniform=T, 
           varlen=3, 
           gap=0,
           space=0, 
           tweak=1.2)

# type se refere à forma como a figura será apresentada e as legendas.
# Por exemplo, para o type = 2 você terá todos os rótulos em todos os nós, 
# já para type = 4 você terá somente rótulos ao fim dos galhos;

# under se refere aos detalhes de cada nó. Por exemplo, se under = T,
# então os detalhes (percentual e número de indivíduos) ficará embaixo 
# da caixa com a marcação de indivíduo bom ou ruim;

# tweak e cex são utilizados para ajustar o tamanho dos caracteres. 
# Se o gráfico ficar muito poluído, ajuste um deles;

# varlen e faclen indicam a quantidade de caracteres que você quer 
# apresentar para rótulo. São argumentos interessantes quando se têm
# nomes compridos. O primeiro é utilizado para variáveis e o segundo
# para factor level;

# extra apresenta informações adicionais, como por exemplo o número 
# de indivíduos por cada nó se for 1, o número de indivíduos dada 
# a classificação de bom ou ruim para 2, etc. Adicionamos 100 ao 
# número para apresentar também o percentual. Ex.: Para extra = 102 
# teremos o número de indivíduos no nó que possuem a classificação 
# anotada (bom ou ruim) e o percentual que eles representam;

# space e gap iguais a 0 podem ser utilizados para reduzir os 
# espaços em branco;

## filtrando quem tem AccB menor que 2.5
train_filtro <- train[(train$AccountBalance < 2.5),]

## verificando como fica a distribuicao
table(train_filtro$AccountBalance, train_filtro$Creditability)

rpart.plot(train_tree, 
           type = 1, 
           yesno=F, 
           fallen.leaves = T,
           extra = 102, 
           under = T, 
           cex=NULL, 
           uniform=T, 
           varlen=3, 
           gap=0,
           space=0, 
           tweak=1.2)

rpart.plot(train_tree, 
           type = 1, 
           yesno=F, 
           fallen.leaves = T,
           extra = 101, 
           under = F, 
           cex=NULL, 
           uniform=T, 
           varlen=3, 
           tweak=2.4)
