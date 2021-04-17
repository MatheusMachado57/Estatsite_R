getwd()
setwd("C:\\Users\\mathe\\Desktop\\Arquivos\\Programação\\Machine Learn do 0 com R")

## le a base de dados excel - Primeiro instala pacote xlsx
install.packages("readxl")
library("readxl")
dados = read_xlsx("german_credit.xlsx", sheet = 1)

## cria variavel para quem tem montante maior que mil
dados$valor1000 = as.numeric(dados$CreditAmount >= 1000)
dados$valor1000
