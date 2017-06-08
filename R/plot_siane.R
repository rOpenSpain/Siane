#' @importFrom "pxR" read.px
#' @importFrom "maptools"  leglabs
#' @importFrom "rgdal" readOGR
#' @importFrom "sp" plot
#' @importFrom "RColorBrewer" brewer.pal
#' @importFrom "plyr" join
#' @importFrom "classInt" classIntervals

#' 
#' @title plot_siane
#' 
#' @description This is a function that plots coloured polygons of the territories over the map.
#' 
#' 
#' @param shp : Is the shapefile return by the /code{get_siane_map} function.
#' @param inepath : The path of the Ine Data we want to plot.
#' @param subsetvars : A vector of expressions. These expresions have to define univocally the values that we are plotting.
#' @param pallete_colour : A pallete_colour of the RColorBrewer package. It is a parameter from the /code{RColorBrewer::brewer.pal} function
#' @param n : The number of breaks in the pallete. It is a parameter from the /code{classInt::classIntervals} function
#' @param style : The way the breaks are numerically distributed. It is a parameter from the /code{classInt::classIntervals} function

#' @export


plot_siane <- function(shp, ine_path, subsetvars, pallete_colour, n, style){
  
  
  px_ine <- read_ine(ine_path) # Read in pc-axis formar
  df_ine <- read_ine_df(px_ine) # From pc-axis to dataframe
  
  df_ine_level <- get_level_ine(px_ine) # Fetching the territory name from the pc-axis file
  
  id <- generate_id(df_ine_level) # Get the name of the variable in the pc-axis file
  df_ine <- get_code_area(df_ine, df_ine_level, id) # Get the code of the territory
  
  
  df_ine <- filter_params(df_ine,subsetvars) # filter the data frame
  
  shp@data <- join(shp@data, df_ine)  # Join data and shape object
  
  values_ine_filter <- shp@data$value # Extract ine values
  filter_map <- which(is.na(values_ine_filter)==FALSE) # make the filter 
  shp<- shp[filter_map, ] # Filtering
  
  values_ine <- shp@data$value # We need the values to calculate the colors
  
  my_pallete <- brks_color(n, pallete_colour,
                           values_ine, style) # Palette
  colors <- brewer.pal(n, pallete_colour) # brks
  col <- colors[findInterval(values_ine, my_pallete,
                             all.inside=TRUE)] # Final colors
  
  sp::plot(shp,col = col) # Plot the map
  build_title(px_ine) # Get the title from the pc-axis object
  make_legend(my_pallete,colors) # Make the legend with maptools
}

