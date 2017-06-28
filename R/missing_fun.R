missing_fun <- function(xi,vi){
  
  if(missing(xi)){ # If the variable is missing, input a default value
    xi <- vi
  }
  
  return(xi)
}