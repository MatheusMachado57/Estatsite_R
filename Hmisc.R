# Frequência no R utilizando o pacote Hmisc

# Como estou acostumado com o proc freq do SAS para validar algumas 
# informações e ver se faz sentido o que estou fazendo, 
# procurei algo semelhante no R. Encontrei o describe() do pacote Hmisc. 
# Claro que deve existir outro pacote que faz isso, 
# mas esse foi o primeiro que encontrei.

# O proc freq do SAS, como o nome já indica, 
# calcula a frequência de seus dados. Por exemplo, se você tem uma 
# base que contém homem e mulher, você pode utilizar 
# um código parecido com esse:
  
# proc freq data = base_de_dados; table sexo; run;

# Onde base_de_dados seria o nome da sua base e sexo o nome da 
# coluna contendo o sexo das pessoas.Esse código retorna para você o 
# número e a porcentagem de pessoas de cada sexo. Analogamente, 
# você poderia fazer o seguinte código no R:
  
# install.packages("Hmisc");

# library("Hmisc");

# describe(base_de_dados$sexo);

# E o resultado seria o mesmo.

# Para não ficar muito abstrato, segue um exemplo com a base 
# de dados german_credit_21 já utilizada no post Árvore de Decisão 
# no R. Eu tinha discretizado algumas variáveis naquela época, 
# e estava refazendo isso hoje. Apenas para garantir que tinha 
# feito da forma correta, utilizei o describe(). Veja que ele me 
# retornou que 30% da minha base possui Creditability ‘bad’ e
# 70% ‘good’. Além disso, pude ver também como foi dividido o 
# CreditAmount. Bem simples, uma função só e você já tem uma bela 
# descrição para trabalhar:

setwd("C:/Users/mathe/Documents/GitHub/EstatSite_R")

require(Hmisc)
require(readxl)

base_de_dados <- read_xlsx("german_credit_21-1.xlsx")

describe(base_de_dados)  