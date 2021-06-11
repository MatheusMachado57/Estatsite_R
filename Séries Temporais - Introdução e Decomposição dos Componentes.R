
## cria um vetor com valores qualquer
dados_teste = c(10,20,15,30);

## utiliza o vetor como serie anual que inicia em 2005
dados_teste_serie_1 = ts(dados_teste, 
                         start = 2005)

## utiliza o vetor como serie mensal que inicia em 2005
dados_teste_serie_2 = ts(dados_teste, 
                         start = 2005, 
                         frequency = 12)

## utiliza o vetor como serie mensal que inicia em fevereiro de 2015
dados_teste_serie_3 = ts(dados_teste, 
                         start = c(2005,2), 
                         frequency = 12)

## graficos dos 3 para mostrar a diferenca nos eixos
par(mfrow=c(1,3))
plot(dados_teste_serie_1)
plot(dados_teste_serie_2)
plot(dados_teste_serie_3)

## carrega dados de vendas
dados = read.table("sales.csv", 
                   header=T)

## da o nome de 'vendas_varejo' para a coluna 1
colnames(dados)[1] = "vendas_varejo"

## cria objeto ts, serie que comeca em janeiro de 1992
## dados sao mensais
dados_ts = ts(dados, 
              start=c(1992,1), 
              frequency=12);

## ajusta para um grafico apenas (por causa do 1o codigo)
par(mfrow = c(1,1));

## plota serie limitando eixo y
plot(dados_ts, 
     ylim = c(0,max(dados_ts[,])));

## decomposicao
decomposicao = decompose(dados_ts, 
                         type = "multiplicative")
plot(decomposicao)
