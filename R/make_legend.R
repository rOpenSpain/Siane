make_legend <- function(my_pallete,colors){
  legend(x = "bottomright", y = 0.10,
         legend = leglabs(round(my_pallete)),
         fill = colors, bty = "n",
         x.intersp = .2, y.intersp = .8)
}