#' @importFrom "maptools"  leglabs
#' @importFrom "rgdal" readOGR
#' @importFrom "RColorBrewer" brewer.pal
#' @importFrom "plyr" join
#' @importFrom "classInt" classIntervals
#' @importFrom "raster" plot
#' 
#' 
#' @title Plot a map
#' 
#' @description This is a function that plots coloured polygons of the territories over the map.
#' 
#' 
#' @param shp : A S4 object returned by the /code{siane_merge} function.
#' @param pallete_colour : A pallete_colour of the RColorBrewer package. 
#' @param n : The number of breaks in the pallete. 
#' @param style : The way the breaks are numerically distributed.



#' @details - \code{shp} is a S4 object returned by the \code{siane_merge} function . \cr
#' \code{pallete_colour} is a parameter from the \code{RColorBrewer::brewer.pal} function. The default pallete is "OrRd". Check RColorBrewer:display.brewer.all() to list all possible colours.
#' \code{n} is a parameter from the /code{classInt::classIntervals} function. Default  \code{n = 5}  \cr
#' \code{style} is a parameter from the /code{classInt::classIntervals} function. Defauly \code{style = quantile} Check ?classInt::classIntervals to list more options. \cr
#' \code{...} other parameters can be set to the legend() function and the title() function. 
#'Please check ?legend and ?title to learn about the parameters of these functions. \cr

#' @export


siane_plot <- function(shp, pallete_colour, n, style, ...){
  
    pallete_colour <- missing_fun(pallete_colour, "OrRd") 
    style <- missing_fun(style, "quantile")
    n <- missing_fun(n, 5)
    
    
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
