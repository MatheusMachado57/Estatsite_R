require(forecast)
require(fpp)

## gera uma serie aleatoria
y <- ts(rnorm(50))

## plota o correlograma
ggAcf(y)

## instala pacote com a serie de dados beer2
# install.packages("fpp");

## plota correlograma de beer2
ggAcf(beer2)

## carrega dados
dados <- read.table("sales.csv", header=T);

## trata nome da coluna
colnames(dados)[1] <- "vendas_varejo"

## cria objeto ts
dados_ts <- ts(dados, start=c(1992,1), frequency=12);

## gera correlograma com 50 defasagens
ggAcf(dados_ts, lag.max=50)