#' @importFrom "maptools"  leglabs
#' @importFrom "rgdal" readOGR
#' @importFrom "RColorBrewer" brewer.pal
#' @importFrom "plyr" join
#' @importFrom "classInt" classIntervals
#' @importFrom "raster" plot
#' 
#' 
#' @title plot_siane
#' 
#' @description This is a function that plots coloured polygons of the territories over the map.
#' 
#' 
#' @param shp : A S4 object returned by the /code{get_siane_map} function.
#' @param df : The data frame with the data we want to plot
#' @param by : The name of the column that contains the ID's of the territories. 
#' @param level : The level of the territory.
#' @param value : The statistical values's we want to plot. Only one value per territory. 
#' @param pallete_colour : A pallete_colour of the RColorBrewer package. 
#' @param n : The number of breaks in the pallete. 
#' @param style : The way the breaks are numerically distributed.
#' @param plot_title : It's the title of the plot
#' @param subtitle : It's the subtitle of the plot



#' @details - \code{shp} is a S4 object. \cr
#' \code{df} is a data frame. This data frame should have at least two columns: one column of statistical data and another column of territorial codes. 
#' There will be as many missing territories as missing codes in the dataframe. \cr
#' \code{by} is the dataframe's codes column. \cr 
#' For \code{level} parameter choose one: "Municipios", "Provincias", "Comunidades" . It's very important that this level is consistent with the S4 object. \cr
#' \code{value} is the name of the column with the statistical values
#' \code{pallete_colour} is a parameter from the /code{RColorBrewer::brewer.pal} function. Check RColorBrewer:display.brewer.all() to list all possible colours.
#' \code{n} is a parameter from the /code{classInt::classIntervals} function.
#' \code{style} is a parameter from the /code{classInt::classIntervals} function. Check ?classInt::classIntervals to list more options.
#' \code{plot_title} is the title of the map.
#' \code{subtitle} is the subtitle of the map
#' \code{...} other parameters can be set to the legend() function. Please check ?legend to learn about them


#' @export


plot_siane <- function(shp, df, by, level, value, pallete_colour, n, style, plot_title, subtitle, x, ...){
  
  if((by %in% names(df)) == FALSE){ # Checking if the ID's column is in the dataframe
    stop(paste0("The column ",by," is not in the data frame. Try to run names(df) to check the data frame column names"))
  }
  if((value %in% names(df)) == FALSE){ # Checking if the ID's column is in the dataframe
    stop(paste0("The column ",value," is not in the data frame. Try to run names(df) to check the data frame column names"))
  }
  if(missing(plot_title)){
    plot_title <- ""
  }
  if(missing(pallete_colour)){
    pallete_colour <- "OrRd" # Orange and Red as the default colours for the pallete
  }
  if(missing(style)){
    style <- "quantile" # quantile style as the deafult one
  }
  if(missing(n)){
    n <- 5 # 5 default colour intervals
  }
  if(missing(x)){
    x <- "bottomright"
  }
  if(missing(subtitle)){
    subtitle <- ""
  }
  

  
  shp_code <- get_shp_code(level) # The shape file column that contains the code depends on the level  
  
  name_filter <- names(df) == by 
  names(df)[name_filter] <- shp_code # Changing the column name to make the join
  shp@data <- join(shp@data, df)  # Join data and shape object
  
  # Attention: Using plyr join because it doesn't change the data frame order.
  # base::merge function does disorder the data frame 
  
  values_ine_filter <- shp@data[[value]] # Extract ine values
  filter_map <- which(is.na(values_ine_filter)==FALSE) # Making the filter 
  shp<- shp[filter_map, ] # Filtering the map
  values_ine <- shp@data[[value]] # Values we want to plot are stored in the shape@data data frame
  
  colors <- brewer.pal(n, pallete_colour) # A pallete from RColorBrewer 
  my_pallete <- brks_color(n, pallete_colour,
                           values_ine, style) # breaks of the pallete 
  col <- colors[findInterval(values_ine, my_pallete,
                             all.inside=TRUE)] # Setting the final colors

  raster::plot(shp,col = col) # Plot the map
  title(main = plot_title, sub = subtitle) # Write the title
  legend(legend = leglabs(round(my_pallete)),fill = colors, x = x, ...) # Make the legend
  
}
