
brks_color <- function(n, pallete_colour, values_ine, style){
  colors <- brewer.pal(n, pallete_colour) 
  
  
  brks <- classIntervals(values_ine, n = n, style = style)
  brks <- brks$brks
  return(brks)
}
