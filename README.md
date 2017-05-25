# Siane

Siane(El Sistema de Información del Atlas Nacional de España) is a project that supports technologically the publications and productions of the National Spanish Atlas(ANE). Recently, this project released CARTOSIANE, a set of maps compatible with the National Institute of Statistics georreferenced data. [INE](http://www.ine.es/)
The aim of this package is to create easy understanding functions that plot INE's data polygons using SIANE maps.


Siane maps are intended to be consistent with the statistical information provided by the INE, in order to be able to cross the graphical information with the statistic. Although it tries to assign as entry date / leaving date the corresponding to the BOE's. According to The NGMEP database it is not always possible to do that because the INE generates the codes of the municipalities based on the date of registration of the changes in the REL. In any case, for the ANE, the important thing is that the date of the change is within the same year ("annual resolution") in which the INE generates the new code.


[SIANE maps](http://www.ign.es/ane/bane/) can be downloaded here. Click in the top right corner button ["Descargar cartografía base Siane"](http://centrodedescargas.cnig.es/CentroDescargas/catalogo.do?Serie=CAANE#selectedSerie).Once the download is completed you will have to unzip five folders.

### Main Folders

These five folders are the following:

1 - *"SIANE_CARTO_BASE_S_3M"*   
2 - *"SIANE_CARTO_BASE_E_14M"*  
3 - *"SIANE_CARTO_BASE_S_6M5"*  
4 - *"SIANE_CARTO_BASE_S_10M"*  
5 - *"SIANE_CARTO_BASE_W_60M"*  

We can easily figure out which maps are contained in each folder using these two rules:

1 - "S" stands for Spain, "E" for Europe and "W" for World.  
2 - 3M stands for scale 1:3.000.000, 14M for 1:14.000.000 and so on.

For instance, the folder named "SIANE_CARTO_BASE_W_60M" contains world maps in a scale of 1:60.000.000.

#### Spatial resolution

The main scales are:

Spain: 1:3.000.000, 1:6.500.000, 1:10.000.000  
Europe: 1:14.000.000  
World: 1:60.000.000



### Data maintenance

The evolution of the records of a geographic object is reflected on its life cycle. A municipality, for example, may face two situations:  

1. Segregation(To constitute an independent municipality)  
2. Change of denomination(Punctual geometric changes or name changes)

Fortunately, Siane keeps information about these changes to mantain its compatibility with the INE.
Each one of the previously five mentioned folders contains two more folders named "Anual" and "Histórico". These spanish words mean "annual" and "historical".  
In the historical folder, a geographical object can have several records in the database with the same identifier, but with different dates.  
In the annual folder, we will find information from a reference date(indicated in the name of the Shapefile). To plot the maps we will rather prefer the annual folders. 



### Distribution Units

Geographic information is layered into shapefiles, mainly by geographical area and scale. Each shapefile represents a type of geographic object. One type of geographic object is often represented by several shapefiles; For example the data of Peninsula and Baleares, are delivered separately with respect to the data of the Canary Islands.

Sample file Shapefile: se89_3_admin_ccaa_a_x.shp

Let's go through each part of the sample file to understand it's content. The following sections are separated by a "_" symbol.

#### __Geographic ID__

Most common: *s* (España), *e* (Europa), *w* (Mundo).

#### __Reference Dystem ID__

Examples: e89 stands for ETRS89 and w84 for WGS84. 

#### __Scale ID__

Usually indicated in units of million for shapefiles.  

Values - *6m5*- 1:6.500.000;  *3* - 1:3.000.000

#### __Internal Thematic Classifier ID__

Values: *admin*,*hidro*,*urban*,*vias*,*orog*
See other possible values in the file: tematica_ane_permanente.dbf


#### __Class entity ID__

Identifier of the represented data.  
Values: __*ccaa*__, __*prov*__, __*muni*__  

__*ccaa*__ : Comunidades Autónomas(Spanish autonomous communities)  
__*prov*__ : Provincias(Provinces)  
__*muni*__ : Municipios(Municipalities)


#### __Geometry ID__.

Values - __*p*__ : dot; __*l*__: line; __*a*__ : area (polygons)

#### __Auxiliar ID(Optional)__

Generally identifies the geographical area for individual treatment of the data in different projections.

Values - __*x*__ : Península and Baleares;  __*y*__ : Canarias


