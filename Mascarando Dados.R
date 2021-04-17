

## mascarando documentos na base base_dados
base_dados$cliente_id <- with(base_dados, as.numeric(factor(Documento, levels = unique(Documento))))

base_dados$cliente_id

## traz coluna id para primeira posicao e exclui campo documento
base_dados <- base_dados[,c(4,2,3)]

## poderiamos ter feito passo a passo excluindo a coluna Documento
## utilizando: base_dados <- base_dados[,-1];