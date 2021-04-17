
x = c(10,20,12,12,10,11,30)
unique(x)

y = c("a","b","c","d","e","f","a","b","d","e")
unique(y)

### Constroi uma tabela de exemplo
tabela_exemplo = data.frame(c("Andre","Marcos","Fernanda", 
                               "Julia","Maria","Maria", 
                               "Jose","Andre"),
                            c("BA","RJ","RJ","RS","SP", 
                              "SP","SP","BA"),
                            c(5,8,9,15,32,32,5,5))

colnames(tabela_exemplo) = c("Nome","UF","Valor")

### Verifica a tabela
head(tabela_exemplo)

### Tira duplicidade por todos os campos
unique(tabela_exemplo)

### se quiser salvar a tabela sem duplicidades
tabela_exemplo_unica <- unique(tabela_exemplo)

head(tabela_exemplo_unica)

# carrega pacote
library("plyr")

# consolida valor por cliente
ddply(tabela_exemplo,~Nome+UF,summarise,total_valor=sum(Valor))

# consolida valor por UF
ddply(tabela_exemplo,~UF,summarise,total_valor=sum(Valor))




