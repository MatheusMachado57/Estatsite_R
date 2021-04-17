# Em s?ries temporais, ? importante realizar uma an?lise da 
# autocorrela??o de uma s?rie, para entender, principalmente 
# sua aleatoriedade, j? que v?rias t?cnicas partem dessa premissa. 
# Autocorrela??o ? simplesmente a correla??o entre uma s?rie e ela 
# mesma defasada. Ou seja, ? a correla??o entre os valores da s?rie 
# em um determinado per?odo de tempo, e os valores da mesma s?rie em
# um outro momento no tempo.

# Um exemplo simples seria tomar os valores de venda de uma loja de 
# Fevereiro a Dezembro de um ano e calcular a correla??o desses valores
# com os de vendas da mesma loja de Janeiro a Novembro desse mesmo ano 
# (comparar t com t-1). Essa ? uma autocorrela??o de defasagem igual a 1
# (lag=1). Para defasagem 2 bastaria pular dois meses. Quando a s?rie for
# aleat?ria, observaremos autocorrela??es pr?ximas de zero. No entanto,
# quando temos uma tend?ncia ou uma sazonalidade, observamos uma tend?ncia
# de queda ou picos positivos nos valores. Uma forma de analisar a 
# autocorrela??o ? atrav?s de um correlograma.

#O correlograma ? o gr?fico utilizado em s?ries temporais para tra?ar as 
# autocorrela??es (tamb?m chamadas em ingl?s de ACF = autocorrelation 
# function) em diversas defasagens. A an?lise desse gr?fico permite 
# entender se a s?rie ? aleat?ria ou possui alguma tend?ncia ou 
# sazonalidade. Para tra?ar esse gr?fico no R, podemos utilizar a fun??o 
# ggACF() do pacote forecast. Vamos ver alguns exemplos e interpret?-los.

## gera uma serie aleatoria
y <- ts(rnorm(50))

## plota o correlograma
ggAcf(y)

# No gr?fico, o eixo vertical indica a autocorrela??o e o horizontal a 
# defasagem. A linha tracejada azul indica onde ? significativamente 
# diferente de zero. Como ? poss?vel ver na imagem, praticamente todos
# os valores ACF est?o dentro do limite da linha tracejada azul. Ou seja,
# autocorrela??o igual a zero, indicando que a s?rie ? aleat?ria - 
# conforme o esperado.

## instala pacote com a serie de dados beer2
require(fpp)

## plota correlograma de beer2
ggAcf(beer2)

# A s?rie beer2 cont?m os dados trimestrais para a produ??o de cerveja 
# na Austr?lia, iniciando no ano de 1992. Para cada linha voc? ter? o 
# valor de um trimestre. ? poss?vel observar aqui que o maior valor 
# est? em 4. Isso ocorre porque a s?rie tem sazonalidade trimestral. 
# Obviamente, os valores m?ltiplos de 4 tamb?m ser?o altos, mas v?o 
# diminuindo com o passar do tempo.

## carrega dados
dados <- read.table("sales.csv", header=T);

## trata nome da coluna
colnames(dados)[1] <- "vendas_varejo"

## cria objeto ts
dados_ts <- ts(dados, start=c(1992,1), frequency=12)

## gera correlograma com 50 defasagens
ggAcf(dados_ts, lag.max=50)

# Novamente utilizando dados do varejo dos EUA como exemplo (foram 
# utilizados tamb?m no post S?ries Temporais: Introdu??o e Decomposi??o
# dos Componentes em R).

# Aqui, podemos ver que o maior valor est? em 12, al?m de valores 
# positivos altos em m?ltiplos de 12. Isso porque a sazonalidade aqui 
# ? mensal. ? poss?vel observar inclusive um padr?o sendo seguido a 
# cada 12 defasagens. Os picos s?o causados pela sazonalidade, 
# enquanto que o comportamento decrescente dos valores de autocorrela??o
# ocorrem por conta de uma tend?ncia nas vendas (tamb?m j? demonstradas
# no post S?ries Temporais: Introdu??o e Decomposi??o dos Componentes em R).

# O correlograma tamb?m ? utilizado (e talvez at? com maior relev?ncia) 
# para analisar os res?duos de um modelo. Quando voc? faz, por exemplo, 
# uma proje??o (forecast) do pre?o de uma a??o, o correlograma do res?duo 
# desse modelo deve estar contido no tracejado azul. Ou seja, os res?duos
# n?o podem ter autocorrela??o. Caso contr?rio, sua proje??o pode ser 
# melhorada, pois alguma informa??o relevante no modelo est? contida nos 
# res?duos (an?logo ao que foi comentado nos textos de Regress?o Linear).



