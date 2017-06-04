
contains_year <- function(shp, year){
  alta <- as.numeric(sapply(shp@data$fecha_alta, function(x) substr(x = x, start=1, stop = 4 )))
  baja <- as.numeric(sapply(shp@data$fecha_baja, function(x) substr(x = x, start=1, stop = 4 )))
  baja[is.na(baja)] <- 2999
  
  my.logic <- (year>alta)&(year<baja)
  my.logic[which(is.na(my.logic)==TRUE)] <- FALSE
  shp$mylogic <- my.logic
  shp <- shp[shp$mylogic == TRUE,]
  
  
  
  return(shp)
}
