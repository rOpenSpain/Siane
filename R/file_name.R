file_name <- function(level_code, boolean_canarias,scale){
  scale <- switch(scale,
                  "3m" = "3",
                  "6m" = "6m5")
  path_to <- paste("se89",scale,"admin",level_code,"a",boolean_canarias,sep="_")
}
