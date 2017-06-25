get_path_scale <- function(scale){
  if(scale == "3"){
    path <- "SIANE_CARTO_BASE_S_3M"
  }else{
    path <- "SIANE_CARTO_BASE_S_6M5"
  }
  return(path)
}
