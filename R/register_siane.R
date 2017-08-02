
#' @export 
#' @title Register the map's path
#' @description A function that validates the path of Siane maps

#' @examples
#' obj <- register_siane("/home/ncarvalho/Downloads/")


#' @param path : The path of the folder that contains the folder SIANE_CARTO_BASE_S_3M and the folder SIANE_CARTO_BASE_S_6M5.
#' 
#' @return It returns the same path as a string.

register_siane <- function(path){
  dirs <- list.dirs(path,full.names = FALSE) # List all the directories in the indicated path
                    
  validator_vector <- c("SIANE_CARTO_BASE_S_6M5","SIANE_CARTO_BASE_S_3M") %in% dirs # Search the directories we need
  if(FALSE %in% validator_vector){ # Tell the user that R couldn't find the maps
    stop("Can't find any of the following directories: SIANE_CARTO_BASE_S_6M5, SIANE_CARTO_BASE_S_3M")
  }
  path
}