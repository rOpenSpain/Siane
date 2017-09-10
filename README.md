# Siane

Siane(El Sistema de Información del Atlas Nacional de España) is a project that supports technologically the publications and productions of the National Spanish Atlas(ANE). Recently, this project released CARTOSIANE, a set of maps compatible with the National Institute of Statistics georreferenced data[(INE)](http://www.ine.es/).  
The aim of this package is to create useful functions that plot INE's georreferenced data on Siane map's polygons.  
Before running the code let's first find out how to download the maps and the data.


## Siane Maps

Siane maps can be downloaded in [this website](http://centrodedescargas.cnig.es/CentroDescargas/catalogo.do?Serie=CAANE#selectedSerie).  
Scroll down to the bottom of the page and click in the highlighted button.  
![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_1.png)  


You will get into in a new website. The next step is to click in __"Buscar por polígono"__![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_2.png)  


Once you get here, draw a triangle in the surface of the map. It just has to be a closed polygon. A simple triangle will do it.
Now unlist all the products by clicking on the  "+" button.  
![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_4.png)  


In this package we are using *"SIANE_CARTO_BASE_S_3M"* and *"SIANE_CARTO_BASE_S_6M5"* maps. Download these maps. The download should begin inmediately.![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_5.png)    


Make sure you unzip the folders in the same directory. Siane should have access to both folders in order to get the maps. For instance, my folders(*"SIANE_CARTO_BASE_S_3M"* and *"SIANE_CARTO_BASE_S_6M5"*) are stored in __"/Users/nunoc/Desktop/siane"__. It is important that folder and file names remain the same as in the original download. Please, don't change them.


## Ine 

Siane maps are very useful because they have compatible territory codes with [INE data](http://www.ine.es/). I am going to download a pc-axis file from the INE database and show you how to plot it's data.
In this demonstration we will plot the population of the municipalities of [__La Rioja__](http://www.ine.es/jaxiT3/Tabla.htm?t=2879).   
Click in the button in the right side of the webpage and choose Pc-Axis format.![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_6.PNG)  

Now we are ready to go through the code.

## Code 

#### Download and install the package.

```
library(devtools)
install_github("Nuniemsis/Siane")
library(pxR) # install.packages("pxR")
library(Siane)
library(RColorBrewer)
```

Siane consists of a collection of maps. This package needs to locate the path of this folder in order to search the requested map. The `obj` variable should contain the path of the maps we are using.


#### Read the map
```
obj <- register_siane("/Users/Nuniemsis/Desktop/siane/")
```


Once we have located all the maps we can select one according with our data.
These parameters will define the selected map.
  - `obj` : Path to all the maps. 
  - `year` : Maps change over time. By now, The territories affected by the changes are just the municipalities(Municipios).  
  - `canarias` : It indicates whether we want to plot Canarias or not.  
  - `level` : It is the administrative level. For this set of maps there are three: "Municipios", "Provincias" and "Comunidades".  
  - `scale` : The scale of the maps. The default scale for municipalities is 1:3000000  `scale <- "3m" `. For provinces and regions the default scale is 1:6500000 `scale <- "6m"`.  
  - `peninsula`: It's the relative position of the Canarias island to the peninsulae. 


Now we call the `siane_map` function to extract and read a map from the entire map's collection.

```
shp <- siane_map(obj = obj, level = "Municipios", canarias = TRUE, peninsula = "close") # Reading the map from the maps collection 
```

You will be able to read the map from previous years.

```
shp_2011 <- siane_map(obj = obj, level = "Municipios", canarias = FALSE, year = 2011)  
```


#### Plot the map



```
raster::plot(shp)
```

#### Load the data


Once we have the correct map it's time to get the data.  
Please, specify the path INE's data path.  

#### Data frame reading 

Set the path of the INE data file. It should be in the pc-axis format.
```
ine_path <- "/Users/nunoc/Downloads/2879.px"
```

Let's explore the dataset before plotting the data
```
df <- as.data.frame(read.px(ine_path))


# if function read.px can't be found run install.packages("pxR") to install it



names(df) # List the column names  of the data frame
```

#### Data frame filtering 

First we need to understand the data frame. It's columns are the following:  
- `Periodo` is the time column in year's format.  
- `value` is a column with the numeric value of the population.  
- `Sexo` is the sex of that population.  
- `Municipios` is a character array with the municipality name and the municipality code
In this dataset there is only one value per territory.  

Split the `Municipios` column to get the municipality's codes.  
We are storing the codes in the column `codes`. This column is really important in order to plot the polygons with the correct colours. 


#### Data frame preparation 

```
by <- "codes"
```

We create a single column in the data frame with those codes.
```
df[[by]] <- sapply(df$Municipios,  # Splitting by white space and keeping the first element
                   function(x) strsplit(x = as.character(x), split = " ")[[1]][1])
```

```
df$Periodo <- as.numeric(as.character(df$Periodo)) #  From factor into numeric
```

Plotting polygons by colour intensity requires one unique value per territory.
Therefore, we have to filter the data frame.  
Keep this __Golden rule__: One value per territory.  
In this example I want to plot the total population in the year 2016.   

```
df <- df[df$Sex == "Total" & df$Periodo == 2016, ] 
```

#### Plot the map


We have to set parameters. 

```
by <- "codes"
value <- "value"
level <- "Municipios"

```

- `value` is the column name that contains the statistical information you want to plot(required).  
- `by` is the column name for the territory codes(required).  


Merge statistical and spatial data. 

```
shp_merged <- siane_merge(shp = shp, df = df, by = by, level = level,value = value)
```


We can plot the map with the `plot` function.
The `RColorBrewer` package provides lots of colour scales. We can use this colour scales to visualize data over the map.
The following function displays all the colour scales from that package.


In case we want to plot the population of certain municipalities in a province, we must use a sequential pallete.

```
pallete_colour <- "OrRd" # Scale of oranges and reds

```


Let's say that `n` is the number of colour intervals.
```
n <- 5
```


The brewer.pal function builds a pallete with `n` intervals and the `pallete_colour` colour.
```
values_ine <- shp_merged@data[[value]] # Values we want to plot are stored in the shape@data data frame
colors <- brewer.pal(n, pallete_colour) # A pallete from RColorBrewer 

```


The style is the distribution of colour within a numerical range. The `classIntervals` function generates numerical intervals. The upper and lower limits of these intervals are named breaks.
```
style <- "quantile" 
brks <- classIntervals(values_ine, n = n, style = style)
my_pallete <- brks$brks # my_pallete is a vector of breaks
```

Match each number with its corresponding interval to be able to decide its colour.
```
col <- colors[findInterval(values_ine, my_pallete,
                           all.inside=TRUE)] # Setting the final colors
```


Plot the map and set title and legends.

```

raster::plot(shp_merged,col = col) # Plot the map
title_plot <- "Población total por municipios en La Rioja"

title(main = title_plot)
legend(legend = leglabs(round(my_pallete)), fill = colors,x = "bottomright")
```




![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_7.png)

  
### Other examples

Let's try with a different [dataset](http://www.ine.es/jaxiT3/Tabla.htm?t=2852&L=0). This dataset has the spanish population for all the provinces.You can find the link in the README.MD file as well. Now we are going to go deeper in some options.
  
```
ine_path <- "/Users/nunoc/Downloads/2852.px"
df <- as.data.frame(read.px(ine_path))
names(df) # List the column names  of the data frame
```


#### Data preparation 

The same steps as before. 

```
df[[by]] <- sapply(df$Provincias,
                   function(x) strsplit(x = as.character(x), split = " ")[[1]][1])
```

```
df$Periodo <- as.numeric(as.character(df$Periodo))
```

```

year <- 2016 # year of the maps

df <- df[df$Sex == "Total" & df$Periodo == year,]
```

The options now will be slightly different:`level <- "Provincias"`. Remember that first we have to create the shapefile. We can't use the previous shapefile provided that the level has changed. These maps are provincial maps.

```
level <- "Provincias"
canarias <- FALSE
scale <- "6m" # "3m" also accepted 
```

#### Read the map

```
shp <- siane_map(obj = obj, canarias = canarias, year = year, level = level, scale = scale)
```

###### Map options

The values are in the `values` column and the codes are in the `codes` column.

```
value <- "value"
by <- "codes"
```


```

shp_merged <- siane_merge(shp = shp, df = df, by = by, value = value)
```


#### Plot the map.


```{r, fig.width = 7, fig.height = 7, eval = FALSE}
pallete_colour <- "BuPu"
n <- 7
style <- "kmeans"


values_ine <- shp_merged@data[[value]] # Values we want to plot are stored in the shape@data data frame
colors <- brewer.pal(n, pallete_colour) # A pallete from RColorBrewer 


brks <- classIntervals(values_ine, n = n, style = style)
my_pallete <- brks$brks


col <- colors[findInterval(values_ine, my_pallete,
                           all.inside=TRUE)] # Setting the final colors


raster::plot(shp_merged,col = col) # Plot the map

title_plot <- "Población de España a nivel de provincias"

title(main = title_plot)
legend(legend = leglabs(round(my_pallete)), fill = colors,x = "bottomright")


```




![Image](https://raw.githubusercontent.com/Nuniemsis/Siane/master/Images/image_8.png)

