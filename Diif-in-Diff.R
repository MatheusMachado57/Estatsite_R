## dummy de periodo: o experimento ocorreu no mes 6
dados_modelo$time = ifelse(dados_modelo$mes > 6, 1, 0);

## dummy de tratamento: grupo tratado tem campo tratamento = 1
dados_modelo$treated = ifelse(dados_modelo$tratamento == 1, 1, 0 );

## dummy tratamento * periodo ~ efeito do experimento
dados_modelo$did = dados_modelo$time * dados_modelo$treated;

## regressao diff-in-diff cujo tratamento eh ter ou nao tratamento
## com efeito fixo por paciente
regressao = lm(variavel_resposta ~ treated + time + did +
                 factor(paciente_id),data = dados_modelo);
summary(regressao);
