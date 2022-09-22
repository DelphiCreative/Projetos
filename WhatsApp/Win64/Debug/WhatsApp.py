#pip install sqlite3
import time
import urllib
import sqlite3 as Firedac

from selenium import webdriver
from selenium.webdriver.common.keys import Keys

 
navegador = webdriver.Chrome()

navegador.get('https://web.whatsapp.com/')

while len(navegador.find_elements_by_id("side")) <1:
    time.sleep(1)

FDConnection = Firedac.connect('mensagem.db')

FDQuery = FDConnection.cursor()

for row in FDQuery.execute('SELECT * FROM mensagens'):
    contato = row[1]
    numero = '55'+row[2]

    mensagem = row[3]
    texto = urllib.parse.quote(mensagem)
    link = f"https://web.whatsapp.com/send?phone={numero}&text={texto}"
    navegador.get(link)
    while len(navegador.find_elements_by_id("side")) <1:
        time.sleep(1)

    navegador.find_element_by_xpath('//*[@id="main"]/footer/div[1]/div[2]/div/div[1]/div/div[2]').send_keys(Keys.ENTER)
    time.sleep(10)
 
