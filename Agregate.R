

## Visualizando a base View(mtcars)
## cria uma tabela com combinacoes de cyl e gear e uma estatistica
## descritiva do mpg para cada combinacao

mtcars

myData <- aggregate(mtcars$mpg,
                    by = list(cyl = mtcars$cyl, 
                              gears = mtcars$gear),
                    FUN = function(x) mean = mean(x))

myData
