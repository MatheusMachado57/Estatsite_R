
# Quando você carregar seus dados de séries temporais no R, 
# você deve sempre convertê-los para o objeto ts. Isso facilita 
# o entendimento do programa e irá fazer com que seus tratamentos 
# sejam mais simples. O R entende os objetos de séries temporais 
# e por isso existem diversas funções específicas para serem 
# utilizadas com esses tipos de dados. Por exemplo, podemos 
# carregar um vetor qualquer com valores aleatórios e indicar para 
# o R que é uma série utilizando a função ts, escolhendo ainda em 
# qual ano (e mês se quiser) que começa e a frequência:

## cria um vetor com valores qualquer
dados_teste = c(10,20,15,30)

## utiliza o vetor como serie anual que inicia em 2005
dados_teste_serie_1 = ts(dados_teste, start = 2005)

## utiliza o vetor como serie mensal que inicia em 2005
dados_teste_serie_2 = ts(dados_teste, start = 2005, frequency = 12)

## utiliza o vetor como serie mensal que inicia em fevereiro de 2015
dados_teste_serie_3 = ts(dados_teste, start = c(2005,2), frequency = 12)

## graficos dos 3 para mostrar a diferenca nos eixos
par(mfrow=c(1,3))
plot(dados_teste_serie_1)
plot(dados_teste_serie_2)
plot(dados_teste_serie_3)

# Veja que frequency representa o número de observações até que a
# sazonalidade ocorra, 1 é anual, 4 é trimestral, 12 é mensal e 
# 52 semanal. A função plot() gera os gráficos normalmente;

## carrega dados de vendas
dados = read.table("sales.csv", header=T)

## da o nome de 'vendas_varejo' para a coluna 1
colnames(dados)[1] = "vendas_varejo"

## cria objeto ts, serie que comeca em janeiro de 1992
## dados sao mensais
dados_ts = ts(dados, start=c(1992,1), frequency=12)
## ajusta para um grafico apenas (por causa do 1o codigo)
par(mfrow=c(1,1));
## plota serie limitando eixo y
plot(dados_ts, ylim = c(0,max(dados_ts[,])))

# Vamos utilizar a função decompose() do tipo multiplicative para
# obter 4 informações: o que é aleatório, sazonalidade, tendência
# e o observado:

## decomposicao
decomposicao = decompose(dados_ts, type = "multiplicative")
plot(decomposicao)

# Agora, por conta do type utilizado acima você pode estar em 
# dúvida do que quer dizer multiplicative quando tratamos de 
# modelos. Mais especificamente, a pergunta que fica é: Qual 
# a diferença entre um modelo aditivo e um modelo multiplicativo 
# em séries temporais?
  
# Basicamente, séries temporais envolvem sazonalidade, tendência 
# e ciclo, além, é claro, dos resíduos. Porém, esses componentes
# podem se somar ou se multiplicar, e essa é a diferença básica.

# Modelo aditivo: Dado = Efeito Sazonal + Tendência + Ciclo + Resíduo

# Modelo multiplicativo: Dado = Efeito Sazonal x Tendência x Ciclo x Resíduos
