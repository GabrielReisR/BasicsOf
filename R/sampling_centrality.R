# Baixando pacotes
install.packages("sampling", dependencies = T)
install.packages("TeachingSampling", dependencies = T)


# Lendo pacotes
library(sampling)
library(TeachingSampling)


# Performando sampling
  sample_example <- sample(c(0,1), 150, 
                         replace = T, 
                         prob = c(0.5,0.5))   # 150 casos de 0 ou 1
  sample_example                              # objeto criado
  length(sample.iris[sample.iris==1])         # quantos com valor == 1?

  
# Sampling em um data.frame
  # Utilizando o data.frame iris, variável Species
  sample_iris <- strata(iris, "Species", 
                      size = c(25, 25, 25), 
                      method = "srswor")      # 25 casos por espécie

  sample_iris
  
  
  # Selecionando dados de forma sistemática
  dados_aleatorios2 <- S.SY(100, 2)           # Escolher aleatoriamente de 1:100
                                              # e depois avançar de 2 em 2
  
  dados_aleatorios15 <- S.SY(100, 15)         # Escolher aleatoriamente de 1:100
                                              # e depois avançar de 15 em 15
  
  iris_2  <- iris[dados_aleatorios2,  ]       # Dados aleatórios de 2 em 2
  iris_15 <- iris[dados_aleatorios15, ]       # Dados aleatórios de 15 em 15
  
  
# Medidas de centralidade
  salario_jogadores <- c(40000, 18000, 12000, 250000,
                         30000, 140000, 300000, 40000, 800000)
  mean(salario_jogadores) # média
  sd(salario_jogadores) # desvio-padrão
  var(salario_jogadores) #variância
  median(salario_jogadores) # mediana - valor no 'meio' da amostra
  quantile(salario_jogadores) # quartis
  summary(salario_jogadores) # quartis, mediana e média
  
