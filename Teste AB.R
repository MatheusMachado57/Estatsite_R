
# DIMENSIONANDO O TESTE
# Para este nosso exemplo, vamos imaginar o teste AB mais simples de todos. 
# Você quer implementar uma mudança na cor do botão de cadastro do seu 
# site e quer saber se mais clientes estão se cadastrando. 
# Logo, a resposta é sim, efetuou o cadastro, ou não, não efetuou o cadastro. 
# Como um “efeito colateral”, você pode imaginar que o botão aumenta a receita. 
# Então vamos verificar a resposta da receita também.

# Inicialmente, você quer dimensionar seu teste AB. 
# Sendo assim, você precisa calcular o tamanho da amostra para que seu teste 
# tenha validade de acordo com o que você busca. Há duas formas de se fazer isso.
# A primeira é pela função SSizeLogisticBin():

library(powerMediation)
amostra <- SSizeLogisticBin(p1 = 0.54,
                            p2 = 0.64,
                            B = 0.5,
                            alpha = 0.05,
                            power = 0.8)


# Recentemente, comecei a utilizar o R para realizar meus testes AB. 
# Afinal, o R é a linguagem ideal quando o tema é estatística, logo, 
# não tinha motivos para não dar uma chance. Gostei bastante, 
# achei fácil de encontrar as funções que precisava e interessante de 
# como é possível executar um AB de ponta a ponta nessa linguagem que 
# eu abandonei por um tempo. Sendo assim, abaixo você encontrará completo 
# o código para realizar testes AB no R.

# Bom, vamos explicando o que significa cada parâmetro:
  
# p1:    Indica qual a taxa de conversão atual. 
#        Sendo assim, nosso exemplo nos diz que 54% dos clientes 
#        que caem na nossa home page clicam no botão de cadastro;
# p2:    Significa o efeito a ser observado. I.e., seria o efeito 
#        mínimo que você gostaria que o teste fosse capaz de identificar. 
#        Em outras palavras, queremos que o teste seja capaz de observar um 
#        ganho de 10pp (~18%);
# B:     É o “split” do teste, ou seja, como você irá dividir os envolvidos. 
#        No caso, nós conseguimos dividir em 50-50.
# alpha: Taxa do erro tipo I;
# power: Poder do teste.

# Outra possibilidade, é calcular qual o tamanho da amostra para um teste-t,
# quando você compara a média de dois grupos (caso a receita fosse a chave):

library(pwr)
pwr.t.test(power=0.8, sig.level = 0.05, d=0.6)

# power:     poder do teste;
# sig.level: Nível de significância, análogo ao alpha da função anterior;
# d:         Efeito mínimo que você gostaria que o teste fosse capaz de identificar.
# Sugestão:  Faça algumas brincadeiras com power, sig.level e d,
#            e veja como isso altera o tamanho da amostra!
  
# MONITORAMENTO DO TESTE E PRIMEIRAS IMPRESSÕES
# Em seguida, seria bacana observar como os valores dos dois 
# grupos estão se comportando ao longo do tempo. 
# Em outras palavras, criar gráficos que observem se o número de cliques 
# do grupo controle é sempre menor que do grupo variante, ou vice-versa. 
# O código abaixo te permite criar um gráfico de linhas em que o eixo-x é 
# o tempo de teste e o eixo-y a média de cliques, comparando grupo 
# controle (A) do grupo variante (B). Idealmente, as linhas não ficarão se 
# cruzando para que seu teste tenha maior confiabilidade:

# PARAMETROS
# df é nosso dataset inicial
# col_dt é nossa coluna data
# col_group é a coluna que indica se o indivíduo é do grupo A ou B
# col_cliques é a coluna indicando se clicou (1) ou não (0)

# GRAFICO:
# cria uma sumarização por dia para verificar evolucao da taxa de zero

df_summary = df %>%
  group_by(col_dt, col_group) %>%
  summarize(click_rate = mean(col_cliques))

# Plot comparativo de zeros
ggplot(df_summary,
       aes(x = col_dt,
           y = click_rate,
           color = col_group,
           linetype = col_group)) +
  geom_point() +
  geom_line() +
  scale_y_continuous(limits = c(0, 0.8)) +
  theme(legend.position='bottom')
  ggsave(file=paste("click_compare.png"))

# O resultado é algo como esse, mas comparando os cliques por grupo 
# (entenda var0 como sendo o grupo A e var1 o grupo B):
  
# AVALIANDO OS RESULTADOS
# Por fim, queremos verificar se os resultados observados possuem 
# validade estatística. Então, realizamos os devidos testes. 
# Primeiro, para os cliques:
    
# Checando se houve mais cliques
ab_experiment_results <- glm(col_cliques ~ col_group,
                             family = "binomial",
                             data = df)

summary(ab_experiment_results)

# Em seguida, para a receita:
t.test(col_receita ~ col_group, data = df)

# Em suma, é isso. Você pode alterar alguns parâmetros, 
# eu recomendo muito a leitura de todas as funções. 
# E, não tenho certeza se carreguei todas as bibliotecas, 
# mas é assim que eu inicio meu código:
             
library("tidyverse")
library(dplyr)
library(powerMediation)
library("broom")
library(data.table)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# Espero de verdade que tenha conseguido te ajudar. 
# Caso você sinta que algo ficou muito vago, 
# entre em contato deixando um comentário ou mandando mensagem
# em alguma DM. Todas minhas redes estão em  Sobre o Estatsite / Contato.
  
  
  