# Siane

Siane(El Sistema de Información del Atlas Nacional de España) is a project that supports technologically the publications and productions of the National Spanish Atlas(ANE). Recently, this project released CARTOSIANE, a set of maps compatible with the National Institute of Statistics georreferenced data[(INE)](http://www.ine.es/).  
The aim of this package is to create useful functions that plot INE's data on polygons using SIANE maps.  
First let's find out how to download how to download the maps and the data.


## Siane Maps

[SIANE](http://centrodedescargas.cnig.es/CentroDescargas/catalogo.do?Serie=CAANE#selectedSerie) maps can be downloaded in this website.  
Scroll down to the bottom of the page and click in the highlighted button.  
![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_1.png)  
You will get into in a new website. The next step is to click in __"Buscar por polígono"__![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_2.png)  
Once you get there, draw a triangle in the surface of the map. It just has to be a closed polygon. A simple triangle will do it.
Now unlist all the products by clicking on the  "+" button.  
![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_4.png)  
In this package we are using *"SIANE_CARTO_BASE_S_3M"* maps. Download these maps.The download should begin inmediately.![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_5.png)  


## Ine data

As I already explained, siane maps are only compatible with [INE data](http://www.ine.es/) in the pc-axis format. I am going to download a pc-axis file from the INE database and show you how to do it.
In this demonstration we will plot the municipalities population of[__La Rioja__](http://www.ine.es/jaxiT3/Tabla.htm?t=2879).   
Click in the button in the right side of the webpage and choose Pc-Axis format.![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_6.png)  

Now we are ready to go through the code.

## Code 

Download and install the package.

```
library(devtools)  
install_github("Nuniemsis/Siane")
```
It is necessary to specify the path in which the maps are located.   
The __obj__ variable should contain the path of the maps we are using. 
```
obj <- register_siane("/Users/Nuniemsis/Desktop/SIANE_CARTO_BASE_S_3M/")
```

There are plenty of maps in our cartographic data. The user has to set a filter to get a specific map.  
I am listing all the choices you can make:
There are three levels of territories: __"Comunidades"__, __"Provincias"__ and __"Municipios"__ accepted in the parameter *__level__*.
You can choose to have the Canarias maps or the peninsulae maps.
Maps are not immutable. Municipalities are constantly changing. The third parameter *__year__* let's the user ask for a map of that year.
The map

```
level <- "municipios"
canarias <- FALSE
year <- 2016
```

The function __get_siane_map__ pick's the correct map for the user's data.
We store the map in the __shp__ variable.
```
shp <- get_siane_map(obj = obj, level = level, year = year, canarias = canarias)
```

Once we have the correct map it is time to get the data.  
Please, specify the path of the INE data. 

```
ine_path <- "/Users/Nuniemsis/Downloads/2879.px"
```

We aren't going to represent all the data of that file in the same map.
You will have to explore the dataset to make an appropriate filter. The following filter is taking all the rows for 2016 total population in each municipality.

```
subsetvars <- c("Sexo = Total","Periodo = 2016")
```

The *__pallete_colour__* is a colour from the RColorBrewer package. In this example we will use a pallete of orange and red colours.

```
pallete_colour <- "OrRd"
```

__n__ and __style__ are the corresponding number of classes required and the style used in the __classIntervals()__ function from the *classInt* package.

```
n <- 9 
style <- "quantile"
```

After running __plot_siane__ function, the data will be plotted over the polygons. 

```
plot_siane(shp, ine_path, subsetvars, pallete_colour, n, style)
```





