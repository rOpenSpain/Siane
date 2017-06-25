#'@title Load a spanish map 
#'
#' @description A function that returns a S4 object of a Spain specific map



#' @param obj : Path to the Siane maps.
#' @param level : Is the administrative level. Can take the values of "Provincia","Municipio" or "Comunidades"
#' @param year : The numeric year of the maps requested.
#' @param canarias : Canarias set to TRUE returns the Canarias map. Canarias set to FALSE returns to the Peninsulae maps.
#' @param scale : It's the scale of the map.

#' @return A S4 object specified by the user
#' 
#' 
#' @export

siane_map <- function(obj, canarias, year, level, scale){
  
  level_code <- get_level(level)
  
  if(missing(scale)){
    scale <- get_scale(level_code) # Setting default scale to 3M for municipalities and 6M5 for provinces and regions 
  }

  if(missing(canarias)){  
    canarias <- FALSE  # Setting default canarias to FALSE. 
  }
  
  
  boolean_canarias <- get_boolean_canarias(canarias) # Canarias indicator

  path_by_scale <- get_path_scale(scale) # Scale indicator

  base_path <- file.path(obj,path_by_scale,'anual') # base path 
  
  dirs_path <- list.dirs(base_path) # Listing the dirs in the path

  dirs_path <- sort(dirs_path, decreasing = TRUE) # We sort the dirs to be able to search the file from the newest year to the latest year 

  last_path <- file_name(level_code, boolean_canarias, scale) # This is the path to the file

  
  shp <- readOGR(dsn = get_dir(base_path, dirs_path,last_path, year), 
                 layer = file_name(level_code, boolean_canarias, scale)) # Read the map
}

