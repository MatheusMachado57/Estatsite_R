library(ggplot2) # apenas para gerar o autoplot
library(fpp)     # pacote de forecast

autoplot(a10) +
  ggtitle("Graf. Autoplot para Vendas de Antibioticos na Australia") +
  ylab("$ milhoes") + 
  xlab("Ano")

# Grafico de sazonalidade
seasonplot(a10, 
           year.labels=TRUE, 
           main="Graf. Seasonplot para Vendas de Antibioticos na Australia")

# Grafico de sazonalidade com mais detalhes
ggseasonplot(a10, 
             year.labels = TRUE, 
             year.labels.left = TRUE) +
  ylab("$ milhoes") +
  xlab("Mes") + 
  ggtitle("Graf. GGSeasonplot para Vendas de Antibioticos na Australia")

ggseasonplot(a10, polar=TRUE) +
  ylab("$ milhoes") + 
  xlab("Mes") + 
  ggtitle("Graf. Polar")

ggsubseriesplot(a10) + 
      ylab("$ milhoes") + 
      xlab("Mes")+
      ggtitle("Graf. GGSubseriesplot")