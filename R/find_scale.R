
find_scale <- function(level_code){
  if(level_code == "muni"){
    scale <- "3m"
  }else{
    scale <- "6m"
  }
  return(scale)
}
