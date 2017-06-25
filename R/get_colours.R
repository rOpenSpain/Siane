get_colours <- function(pallete_colour, n, style,values_ine){
  if(missing(pallete_colour)){
    pallete_colour <- "OrRd" # Orange and Red as the default colours for the pallete
  }
  if(missing(style)){
    style <- "quantile" # quantile style as the deafult one
  }
  if(missing(n)){
    n <- 5 # 5 colour intervals
  }
  
  colors <- brewer.pal(n, pallete_colour) # pallete
  my_pallete <- brks_color(n, pallete_colour,
                           values_ine, style) # breaks of the pallete 
  col <- colors[findInterval(values_ine, my_pallete,
                             all.inside=TRUE)] # Setting the final colors
  
}