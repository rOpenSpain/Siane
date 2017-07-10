
match_level <- function(level){
  if (missing(level)){
    level <- "p"
  }else{
    level <- tolower(substr(level,1,1))
  }
  
  return(
    switch(level,
           m = "muni",
           p = "prov",
           c = "ccaa"
    )
  )
}