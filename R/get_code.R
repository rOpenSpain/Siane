
# Extract the keywords

get_code <- function(level,canarias){
  if (missing(level)){
    level <- "p"
  }else{
    level <- tolower(substr(level,1,1))
  }
  
  return(
    c(
      switch(level,
             m = "muni",
             p = "prov",
             c = "ccaa"
      ),
      ifelse(canarias,"y","x")
    )
  )
}
