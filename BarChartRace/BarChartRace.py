import sqlite3
import pandas as pd
import bar_chart_race as bcr

db = sqlite3.connect('Vendas.sdb')
'''
tabela = db.cursor()

tabela.execute('SELECT ID,PRODUTO, strftime("%Y/%m", Data_Venda) Periodo,  Count(*) Total_Periodo FROM VENDAS '+
               'GROUP BY strftime("%Y/%m", Data_Venda) , PRODUTO LIMIT 10')

print(tabela.fetchall())
print('')
'''

tabela = pd.read_sql('SELECT ID,PRODUTO, strftime("%Y/%m", Data_Venda) Periodo,  Count(*) Total_Periodo FROM VENDAS '+
                     ' WHERE strftime("%Y", Data_Venda) < "2022" '+   
                     'GROUP BY strftime("%Y/%m", Data_Venda) , PRODUTO ',con = db)

tabela = tabela.pivot_table(values = 'Total_Periodo',
                            index =['Periodo'],
                            columns = 'PRODUTO'
                            )

tabela.fillna(0,inplace=True)
print(tabela)

tabela = tabela.iloc[:,:].cumsum()

print(tabela)

bcr.bar_chart_race(df = tabela,
                  n_bars = 6,
                  sort = 'desc',
                  title = 'Gráfico de corrida de barras',
                  filename = 'vendas_youtube.mp4'

                  )



