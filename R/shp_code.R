shp_code <- function(level){
  
  if (missing(level)){
    level <- "p"
  }else{
    level <- tolower(substr(level,1,1))
  }
  
  return(
      switch(level,
             m = "id_ine",
             p = "id_prov",
             c = "id_ccaa"
    )
  )
}