import sqlite3 
import pandas as pd
import bar_chart_race as bcr

db = sqlite3.connect('Vendas.sdb')

tabela = pd.read_sql('SELECT strftime("%Y/%m", DATA_VENDA) PERIODO, PRODUTO, COUNT(*) TOTAL_PERIODO FROM VENDAS '+
                     ' WHERE strftime("%Y%m", DATA_VENDA) < "202201"'                  
                     ' GROUP BY strftime("%Y/%m", DATA_VENDA), PRODUTO' ,con= db )

tabela = tabela.pivot_table(values='TOTAL_PERIODO',
                            index= 'PERIODO',
                            columns='PRODUTO'  )

tabela.fillna(0,inplace=True)

tabela = tabela.cumsum()

bcr.bar_chart_race(df=tabela, 
                   n_bars=6,
                   title='GRÁFICO DE CORRIDA DE BARRAS',
                   sort= 'desc',
                   filename='vendas_canal.mp4'       
)