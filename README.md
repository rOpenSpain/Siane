# Siane

Siane(El Sistema de Información del Atlas Nacional de España) is a project that supports technologically the publications and productions of the National Spanish Atlas(ANE). Recently, this project released CARTOSIANE, a set of maps compatible with the National Institute of Statistics georreferenced data[(INE)](http://www.ine.es/).  
The aim of this package is to create useful functions that plot INE's data on polygons using SIANE maps.

First let's find out how to download how to download the maps.

[SIANE](http://centrodedescargas.cnig.es/CentroDescargas/catalogo.do?Serie=CAANE#selectedSerie) maps can be downloaded in this website. 
Scroll down to the bottom of the page and click in the highlighted button.  
![Please click in the download button](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_1.png)  
![You will enter in a new website. The next step is to click in __"Buscar por polígono"__](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_2.png)  
Then, draw a triangle in the surface of the map. It just has to be a closed polygon.  
A simple triangle will do it.  
![Unlist all the products by clicking on the  "+" button](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_4.png)  
![In this package we are using *"SIANE_CARTO_BASE_S_3M"*. Download these maps](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_5.png)  
The download should begin inmediately.

## Code 

Download and install the package.

```
library(devtools)  
install_github("Nuniemsis/Siane")
```

In order to plot the maps, siane needs the path of the entire 
```
siane_path <- "/Users/Nuniemsis/Desktop/SIANE_CARTO_BASE_S_3M/"
obj <- register_siane(siane_path)
```


```
level <- "muni"
canarias <- FALSE
year <- 2016
shp <- get_siane_map(obj = obj, level = level, year = year, canarias = canarias)
```

```
n <- 9 
subsetvars <- c("Sexo = Total","Periodo = 2016")
ine_path <- "/Users/Nuniemsis/Downloads/2879.px"
pallete_colour <- "OrRd"
n <- 9 
subsetvars <- c("Sexo = Total","Periodo = 2016")
style <- "quantile"

```


```

plot_siane(shp, ine_path, subsetvars, pallete_colour, n, style)

```





