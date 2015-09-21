<h3> Twitter_Webscraping </h3>
Código para realizar webscraping no Twitter

<h4>Pré Requisitos : </h4>

<ul> 
  <li> <b> RSlenium - </b>( devtools::install_github("ropensci/RSelenium") ) </li>
  
  <li> <b> Selenium-server-standalone.jar : </b> 
      <ul> 
        <li> Após instalar a biblioteca, o módulo Selenium-server-standalone.jar deve ser carregado. 
          <ul>
          <li> <b>No Windows :</b> Iniciar ---> Pesquisar programas e arquivos ---> Digitar : Selenium-server-standalone.jar ---> Clicar no arquivo encontrado.</li>
          </ul>
        </li>
      </ul>
</ul> 

<hr>

<h4> Como usar : </h4>

```R
#Escolher um nome para a pesquisa 
titulo = paste0("standard","_tweet_data.csv") #(linha 14)

#Escolher o termo a ser buscado.Colocar aspas na(s) palavra(s) obrigatórias 
# https://dev.twitter.com/rest/public/search
termo = '"brasil" rebaixado OR rebaixamento da nota OR Standard and Poors' #(linha 22)

# Decindo datas a serem pesquisadas
data_inicio =  as.Date("2015-09-01",format = "%Y-%m-%d") #(linha 28)
data_fim = as.Date("2015-09-15",format = "%Y-%m-%d") #(linha 29)

#Salva o dataframe em um arquivo csv com o nome escolhido
write.csv(resultado_final, file=titulo, row.names=FALSE) #(linha 84)
```
<hr>

<h4>Arquivo .CSV gerado : </h4> 

number_of_tweets  | date
------------- | -------------
1009  | 2015-09-01
354  | 2015-09-02
2345  | 2015-09-03
...  | ...
