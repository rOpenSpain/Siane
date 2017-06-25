
brks_color <- function(n,pallete_colour, values_ine, style){
  brks <- classIntervals(values_ine, n = n, style = style)
  brks <- brks$brks
  
  return(brks)
}
