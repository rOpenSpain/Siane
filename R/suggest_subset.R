
#' @title suggest_subset

#' @description This function allows the user to create a random subset of vars to plot


#' @param path_ine : Is the path of the INE pc-axis file.
#' 
#' 
#' @return Returns a vector of the filtering variable for the INE dataframe.
#' 
#' @export

suggest_subset <- function(path_ine){
  df_ine <- as.data.frame(read.px(path_ine)) # Read the dataframe
  
  not_subset_vars <- c("Municipios", "Provincias",
                       "Comunidades", "value") # Select nonsubsettable vars
  my_logic <- (names(df_ine) %in% not_subset_vars) == FALSE 
  df_ine <- df_ine[, my_logic] # Eliminate those columns
  
  sample_filter <-sample(nrow(df_ine), 1) # Build a random filter
  sample_ine <- df_ine[sample_filter, ] # Apply the random filter
  
  sample_subsetvars <- c() # Generate empty vector
  for(cols in names(sample_ine)){ # Creatiing the subset vector
    sample_subsetvars <- c(sample_subsetvars,
                           paste(cols,
                                 sample_ine[[cols]],
                                 sep = " = "))
  }
  
  cat(sample_subsetvars)
  return(sample_subsetvars)
}



