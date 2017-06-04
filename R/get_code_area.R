
get_code_area <- function(df_ine, ine_level, id){
  codes <- sapply(as.character(df_ine[[ine_level]]), function(x) strsplit(x = x, split= " ")[[1]][1])
  df_ine[[id]] <- codes 
  
  return(df_ine)
} 
