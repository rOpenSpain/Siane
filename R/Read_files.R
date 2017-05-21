


library(RColorBrewer)

library(maptools)
library(ggmap)
library(pxR)

library(rgdal)


Muni.codes <- read.csv("/Users/nunoc/Desktop/siane/11codmun.csv")
Prov.codes <- read.csv("/Users/nunoc/Desktop/siane/Relacionprovincias.csv",sep=";",encoding = "latin1")
Comu.codes <- read.csv("/Users/nunoc/Desktop/siane/Relacioncomunidades.csv",sep= ";",encoding = "latin1")



shp  <- readOGR(layer = "se89_3_admin_ccaa_a_x", dsn = "/Users/nunoc/Desktop/siane/SIANE_CARTO_BASE_S_3M/SIANE_CARTO_BASE_S_3M/historico", encoding="utf-8")

df <-as.data.frame(read.px("/Users/nunoc/Desktop/siane/TasaNatalidad.px"))


df <- df[df$Comunidades.y.Ciudades.Autónomas!="Total Nacional",]

df$Periodo <- sapply(df$Periodo, function(x) as.numeric(as.character(x)))


year = "2007"
Nationality = "Española"




  

  
  
df <- df[df$Periodo==year,]
df <- df[df$Nacionalidad==as.character(Nationality),]




shp@data$id_ccaa <- sapply(shp@data$id_ccaa, function(x) as.numeric(as.character(x))-60)
df
shp@data

df$Comunidades.y.Ciudades.Autónomas <- sapply(df$Comunidades.y.Ciudades.Autónomas,function(x) as.character(x))


df <- df[df$Comunidades.y.Ciudades.Autónomas!="Canarias",]
# Code



code <-pmatch(Comu.codes$Literal,df$Comunidades.y.Ciudades.Autónomas)

code


df
df[code,]

shp@data$rotulo <- sapply(shp@data$rotulo, function(x) as.character(x))

df <- df[code,]
df <- df[complete.cases(df),]

shp@data$Value <- df$value

plot(shp,col=shp@data$Value)


#The sequential palettes names are 
#Blues BuGn BuPu GnBu Greens Greys Oranges OrRd PuBu PuBuGn PuRd Purples RdPu Reds YlGn YlGnBu YlOrBr YlOrRd

#All the sequential palettes are available in variations from 3 different values up to 9 different values.

#The diverging palettes are 
#BrBG PiYG PRGn PuOr RdBu RdGy RdYlBu RdYlGn Spectral



paleta <-colorRampPalette(colors = brewer.pal(n = 8, name = "BuPu"))
plot(shp,col=paleta(shp@data$Value))





Read_Plot <- function(year = year,Nationality = Nationality,df = df, shp = shp){
  
  Muni.codes <- read.csv("/Users/nunoc/Desktop/siane/11codmun.csv")
  Prov.codes <- read.csv("/Users/nunoc/Desktop/siane/Relacionprovincias.csv",sep=";",encoding = "latin1")
  Comu.codes <- read.csv("/Users/nunoc/Desktop/siane/Relacioncomunidades.csv",sep= ";",encoding = "latin1")
  

  df <- df[df$Comunidades.y.Ciudades.Autónomas!="Total Nacional",]
  
  df$Periodo <- sapply(df$Periodo, function(x) as.numeric(as.character(x)))
  
  df <- df[df$Periodo==year,]
  df <- df[df$Nacionalidad==as.character(Nationality),]
  
  
  
  
  shp@data$id_ccaa <- sapply(shp@data$id_ccaa, function(x) as.numeric(as.character(x))-60)
  df$Comunidades.y.Ciudades.Autónomas <- sapply(df$Comunidades.y.Ciudades.Autónomas,function(x) as.character(x))
  
  df <- df[df$Comunidades.y.Ciudades.Autónomas!="Canarias",]
  code <-pmatch(Comu.codes$Literal,df$Comunidades.y.Ciudades.Autónomas)

  
  shp@data$rotulo <- sapply(shp@data$rotulo, function(x) as.character(x))
  
  df <- df[code,]
  df <- df[complete.cases(df),]
  
  shp@data$Value <- df$value
  
  #The sequential palettes names are 
  #Blues BuGn BuPu GnBu Greens Greys Oranges OrRd PuBu PuBuGn PuRd Purples RdPu Reds YlGn YlGnBu YlOrBr YlOrRd
  
  #All the sequential palettes are available in variations from 3 different values up to 9 different values.
  
  #The diverging palettes are 
  #BrBG PiYG PRGn PuOr RdBu RdGy RdYlBu RdYlGn Spectral
  
  
  
  paleta <-colorRampPalette(colors = brewer.pal(n = 8, name = "BuPu"))
  plot(shp,col=paleta(shp@data$Value))
  
  
  
}
  




df1<-as.data.frame(read.px("/Users/nunoc/Desktop/siane/TasaNatalidad.px"))
shp1  <- readOGR(layer = "se89_3_admin_ccaa_a_x", dsn = "/Users/nunoc/Desktop/siane/SIANE_CARTO_BASE_S_3M/SIANE_CARTO_BASE_S_3M/historico", encoding="utf-8")




Read_Plot(year = "2014",Nationality = "Española",df = df1,shp=shp1)
  




  