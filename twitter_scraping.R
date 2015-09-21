##########################################
#WEB SCRAPING NO TWITTER by Bruno Rafaeli#
##########################################

library("RSelenium")
checkForServer()
startServer()

#Iniciando uma conexão
mybrowser <- remoteDriver()
mybrowser$open()

#Escolher um nome para a pesquisa
titulo = paste0("standard","_tweet_data.csv")

#Escolhendo termos a serem pesquisados

#Duas aspas para buscar exatamente esse termo
#termo = '"brasil vergonha"'

#Uma aspa para buscar todas essas palavras
termo = '"brasil" rebaixado OR rebaixamento da nota OR Standard and Poors'

#Usar OR para buscar qualquer uma dessas palavras
#termo = "brasil OR vergonha OR dilma"

# Decindo datas a serem pesquisadas
data_inicio =  as.Date("2015-09-01",format = "%Y-%m-%d")
data_fim = as.Date("2015-09-15",format = "%Y-%m-%d")

data_total <- seq(data_inicio,to = data_fim, by='days') 

#Cria data frame com o resultado das buscas
resultado_final <- data.frame(number_of_tweets=integer(),date=as.Date(character()))

for(x in 1:(length(data_total)-1))
{
  
  print(data_total[x])
  
  ini = "https://twitter.com/search?f=tweets&vertical=default&q="
  data_ini = data_total[x]
  data_fim = data_total[x+1]
  m_0 = "%20since%3A"
  m_1 = "%20until%3A"
  #m_2 = "&src=typd&lang=pt"
  
  #Para incluir retweets
  m_2 = "include%3Aretweets&src=typd&lang=pt"
  
  url_final = paste0(ini,termo,m_0,data_ini,m_1,data_fim,m_2)
  
  mybrowser$navigate(url_final)
  
  for (n in 1:100)
  {
    
    #Realiza scroll down na página
    mybrowser$executeScript("window.scrollTo(0, document.body.scrollHeight);")
    
    final <- mybrowser$findElement(using = "class name", "stream-footer")
    checar <- final$findChildElement(using = "xpath", "*")
    nome = checar$getElementAttribute("class")
    
    #Checa se ainda existem tweets para serem exibidos
    if(nome == "timeline-end has-items" | nome == "timeline-end  ")
    {
      break
    }
    
    Sys.sleep(2)
  }
  
  #Procura quantos tweets existem
  number_tweets <- mybrowser$findElement(using = "id",value = "stream-items-id")
  number_tweets <- number_tweets$findChildElements(using = "xpath" , "*")
  number_tweets <- length(number_tweets)
  
  #Adiciona uma nova linha ao dataframe
  new_row <- data.frame(number_of_tweets = number_tweets,date = data_ini)
  resultado_final <- rbind(resultado_final,new_row)
  
  #Salva o dataframe em um arquivo csv
  write.csv(resultado_final, file=titulo, row.names=FALSE)
  
}