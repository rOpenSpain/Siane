
get_scale <- function(level_code){
  if(level_code == "muni"){
    scale <- "3"
  }else{
    scale <- "6m5"
  }
  return(scale)
}
