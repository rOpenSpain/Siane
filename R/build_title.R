build_title <- function(px_ine){
  title_plot <- px_ine$TITLE$value # Get the title from the pc-axis file
  
  title(title_plot) # add a title
}