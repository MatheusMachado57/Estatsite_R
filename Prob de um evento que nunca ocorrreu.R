# Probabilidade de um evento que nunca ocorreu
# A técnica desse post provavelmente será pouco utilizada por ser 
# algo atípico. Mas achei interessante, pode ser útil no dia a dia 
# de um cientista de dados. 
# Encontrei no ótimo blog do John D. Cook. Vamos lá então…

# Você quer saber a probabilidade de que um parafuso tenha defeito. 
# Ao examinar 100 casos na sua fábrica, não encontrou defeito algum. 
# Você poderia dizer então que a probabilidade de fazer um parafuso 
# com defeito é 0% na sua empresa?
  
# É claro que não. Para calcular essa probabilidade, 
# uma técnica simples pode ser utilizada aqui: statistical rule of three. 
# Traduzindo ao pé da letra, a regra estatística de três.

# Essa regra diz que se em uma amostra de n elementos, 
# você não encontrou o evento, então, a probabilidade do evento 
# ocorrer é de 3/N.

# Ou seja, se você tem uma amostra de 100 parafusos e nenhum apresentou 
# defeito, você pode dizer com certa segurança que há 3% de chance de 
# um parafuso apresentar defeitos. Já para uma amostra de 1.000 sem 
# defeitos, a probabilidade já fica em 0,3% – obviamente muito menor.

# E a explicação matemática para isso?
  
# É bem breve. Do ponto de vista frequentista, quando se busca a 
# probabilidade p de um evento ocorrer com um intervalo de confiança 
# de 95%, estamos solucionando (1-p)^n=0.05. Resolvendo a equação, 
# temos p~3/N.

# Do ponto de vista bayesiano, a distribuição posterior em p após 0 
# sucessos e N fracassos é beta(1,N+1). A probabilidade de p ser menor 
# que 3/N a medida que aumenta N se aproxima a 0.95.

# Fonte: Statistical Rule of Three