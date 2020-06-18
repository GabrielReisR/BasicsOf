# Lendo pacotes
import numpy  as np
import pandas as pd
from sklearn.model_selection import train_test_split
import os
# Abrindo data.frames
os.chdir("C:\\Users\\Marco2\\Desktop\\Gabriel\\Data Science\\Formação Cientista de Dados com Python e R\\Estudo\\Python")
iris    = pd.read_csv('iris.csv')
infert  = pd.read_csv('infert.csv')

# Criando amostras randômicas
sample = np.random.choice(a = [0, 1], size = 150, 
                          replace = True, p = [1/2, 1/2])    #150 casos 0 ou 1

len(sample)
len(sample[sample==1])
len(sample[sample==0])

iris['class'].value_counts()

# Dividindo randomicamente parte (50%) dos casos/colunas de uma mesma amostra

# 'valores' e 'classes' serão os novos data.frames criados
valores, _, classes, _ = train_test_split(iris.iloc[:, 0:4], iris.iloc[:, 4],
                              test_size = 0.5, stratify = iris.iloc[:, 4])

# Dividindo randomicamente parte (60%) dos casos/colunas de uma mesma amostra
# 'caracteristicas' e 'education' serão os novos data.frames criados
caracteristicas, _, education, _ = train_test_split(infert.iloc[:, 2:9], 
                                                infert.iloc[:, 1],
                                                test_size = 0.6, 
                                                stratify = infert.iloc[:, 1])

''' Os exemplos servem para ilustrar o parâmetro 'stratify', esse que irá 
    receber o valor pelo qual deve PROPORCIONALMENTE realizar a divisão da 
    amostra. Como em education são 3 valores diferentes com 3 contagens 
    diferentes, a função reconhece tais diferenças e divide a amostra 
    baseando-se nesta'''


# Medidas de centralidade
    
salario_jogadores = [40000, 18000, 12000, 250000,
             30000, 140000, 300000, 40000, 800000]

np.mean(salario_jogadores) # média

np.std(salario_jogadores, ddof = 1) # desvio-padrão

np.var(salario_jogadores) # variância

np.median(salario_jogadores) # mediana

np.quantile(salario_jogadores, [0, .25, .50, .75, 1]) # quartis


# Criando duas funções de amostragem

''' Criando uma função que pega um data.frame e retorna casos aleatórios de 
    acordo com o número desejado do novo n. Se N / n < 1, a função retorna os
    primeiros n casos de data.frame.
''' 
def sortearESeguir(df, amostra):
    k = int(len(df) / amostra)
    random_n  = np.random.randint(low = 1, high = k + 1, size = 1)
    acumulador = random_n[0]
    sorteados  = []
    
    for i in range(amostra):
        sorteados.append(acumulador)
        acumulador += k
        
    df_sorteado = df.reindex(sorteados)
    return df_sorteado

iris_sorteados = sortearESeguir(iris, 50) # exemplo 1

iris_sorteados = sortearESeguir(iris, 70) # exemplo 2


''' Corrigindo o problema anterior (N / n < 1), criaremos uma nova função que,
    dessa vez, escolhe n números aleatórios de 1 a N, retornando tais linhas
    de um data.frame.
''' 

def casosAleatorios(df, numeroDeCasos):
    if (numeroDeCasos > len(df) | numeroDeCasos <= 0):
        numeroDeCasos == len(df)
    
    casosSelecionados = np.random.choice(a = len(df), 
                                         size = numeroDeCasos,
                                         replace = False)
        
    df_aleatorios = df.reindex(casosSelecionados)
    return df_aleatorios

iris_aleatorios_120 = casosAleatorios(iris, numeroDeCasos = 120) # exemplo 1
# A função retornou 120 casos aleatórios do banco de dados "iris"

iris_aleatorios_1 = casosAleatorios(iris, numeroDeCasos = 1) # exemplo 2
# A função retornou 1 caso aleatório do banco de dados "iris"







