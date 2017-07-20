## This function translates the input level of the user "3m" or "6m" 
#  and returns the folder where the maps should be



path_scale <- function(scale){
  if(scale == "3m"){
    path <- "SIANE_CARTO_BASE_S_3M"
  }else{
    path <- "SIANE_CARTO_BASE_S_6M5"
  }
  return(path)
}
