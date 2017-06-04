filter_params <- function(df_ine,subsetvars){
  for(elem in subsetvars){
    a <- trimws(strsplit(elem, "=")[[1]][1])
    b <- trimws(strsplit(elem, "=")[[1]][2])
    
    
    expr <- df_ine[[a]] == b
    df_ine <- df_ine[expr,]
  }
  return(df_ine)
} 
