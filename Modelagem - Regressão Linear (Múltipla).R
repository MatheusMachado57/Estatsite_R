

# lm(formula = dados$var1 ~ dados$var2)

# Residuals: São os resíduos da nossa equação. Você traçará um 
# gráfico dos resíduos contra a variáve independente para verificar
# que eles são aleatoriamente distribuídos e aí seus resultados serão 
# mais confiáveis.  Mas não confunda erro com resíduos! É confuso, 
# mas farei um post só sobre isso futuramente!
  
# Coefficients: a coluna estimate nada mais é do que os valores que
# formarão nossa reta. O do intercept é o valor que representa a 
# constante. Enquanto o valor que vem em seguida, logo abaixo, é o 
# que acompanha nossa variável independente. Ou seja, no nosso caso,
# para se obter o valor da nota do testão você deve multiplicar a 
# mesada do aluno por 1,66339 e somar a constante 5,39290. 
# E as outras colunas? Por enquanto vamos apenas considerar que 
# podemos usar os coeficientes caso o p-valor sera menor que 5%. 
# Em outros posts entraremos mais a fundo no assunto.

# Multiple R-squared: O R quadrado é o quanto nossa variável 
# independente é capaz de representar nossa variável dependente. Ou 
# seja, 97,38% da nota do testão é explicada pela mesada (lembrem-se 
# que esses dados são fictícios!).

# F-statistic: Será muito mais importante para quando falarmos de 
# regressão múltipla.

# Adjusted R-squared: Também será mais relevante ao falarmos de 
# regressão múltipla. Fiquem tranquilos por enquanto.

# O erro é a diferença entre o valor real, que não observamos, 
# e o valor estimado. 
# Já o resíduo é a diferença entre o valor estimado e o valor observado.


### 0: As premissas para uma regressão linear múltipla são:
  
# 1-: A variável dependente e as variáveis independentes 
# possuem uma relação linear, ou seja, assim como para regressão 
# linear simples, temos uma equação linear que explica nossa variável
# dependente. Ou como alguns livros dizem, é linear nos parâmetros 
# (parâmetros são as variáveis que você vai usar para explicar a 
# variável resposta).

# 2-: X são fixos ou covariância dos x e erros é zero. Se você não 
# está trabalhando com regressores pré-determinados ( fixos), então
# a covariância deles com os erros deve ser zero. Por que? Porque 
# não queremos dependência entre as variáveis explicativas e os erros.

# 3-: A esperança do erro é zero. Análogo ao que ocorre com a regressão
# linear simples. Lembra daquela intuição? Erramos um pouquinho para 
# cima, um pouquinho para baixo e fechou!
  
# 4-: A variância do erro é constante. Dá para perceber que os erros 
# são importantes aqui, certo? O que é até fácil de intuir, se eles 
# possuem um comportamento como alguma tendência, por exemplo de uma
# reta, ou eles explodem, então é provável que tenhamos variáveis 
# que expliquem a variável resposta e não foram incluídas. Veja as 
# fotos abaixo.

# 5-: Não há autocorrelação entre os erros.


