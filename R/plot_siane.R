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



#' @details - \code{shp} is a S4 object. \cr
#' \code{df} is a data frame. This data frame should have at least two columns: one column of statistical data and another column of territorial codes. 
#' There will be as many missing territories as missing codes in the dataframe. \cr
#' \code{by} is the dataframe's codes column. \cr 
#' For \code{level} parameter choose one: "Municipios", "Provincias", "Comunidades" . It's very important that this level is consistent with the S4 object. \cr
#' \code{value} is the name of the column with the statistical values
#' \code{pallete_colour} is a parameter from the /code{RColorBrewer::brewer.pal} function. Check RColorBrewer:display.brewer.all() to list all possible colours.
#' \code{n} is a parameter from the /code{classInt::classIntervals} function.
#' \code{style} is a parameter from the /code{classInt::classIntervals} function. Check ?classInt::classIntervals to list more options.
#' \code{...} other parameters can be set to the legend() function and the title() function.
#'Please check ?legend and ?title to learn about the parameters of these functions.


#' @export


plot_siane <- function(shp, df, by, level, value, pallete_colour, n, style, ...){
    
   # Stop sentences for column names: Values column and codes column.
  
    stop_advices(df,by,value)

    # Missing arguments
    
  
    pallete_colour <- missing_fun(pallete_colour, "OrRd")
    style <- missing_fun(style, "quantile")
    n <- missing_fun(n, 5)
    
    
    shp_code <- get_shp_code(level) # The shape file column that contains the code depends on the level. This function returns the code's shp column name 
    
    
    name_filter <- names(df) == by 
    names(df)[name_filter] <- shp_code # Changing the column name to make the join
    shp@data <- join(shp@data, df)  # Join data and shape object
    
    # Attention: Using plyr join because it doesn't change the data frame order.
    # base::merge function does disorder the data frame 
    
    values_ine_filter <- shp@data[[value]] # Extract ine values
    filter_map <- which(is.na(values_ine_filter)==FALSE) # Making the filter 
    shp <- shp[filter_map, ] # Filtering the map
    values_ine <- shp@data[[value]] # Values we want to plot are stored in the shape@data data frame
    
    colors <- brewer.pal(n, pallete_colour) # A pallete from RColorBrewer 
    my_pallete <- brks_color(n, pallete_colour,
                             values_ine, style) # breaks of the pallete 
    col <- colors[findInterval(values_ine, my_pallete,
                               all.inside=TRUE)] # Setting the final colors
    
    
    
    ellipsis_list <- list(...) # List of the ... variables and values
    
    params_fun_title  <- formals(title) # The possible parameters for the function title
    params_fun_legend <- formals(legend) # The possible parameters for the function legend
    
    
    title_params <- Filter(Negate(is.null), # Erase NAN elements from the title list parameters
                           ellipsis_list[names(params_fun_title)] ) # filter ellipsis list for  the function's parameters
    legend_params <- Filter(Negate(is.null), # Erase NAN elements from the legend list parameters
                            ellipsis_list[names(params_fun_legend)])  # filter ellipsis list for  the function's parameters
    
    
    legend_params <- append(list(legend = leglabs(round(my_pallete)), fill = colors), legend_params) # Appending hidden parameters and visible parametres
    
    raster::plot(shp,col = col) # Plot the map
    
    do.call(title,title_params) # Write the title
    do.call(legend,legend_params) # Make the legend
  
}
