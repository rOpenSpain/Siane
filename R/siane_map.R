#'@title Loads a spanish map 
#'
#' @description A function that returns a S4 object(map) of a Spain specific map



#' @param obj : Path to the Siane maps.
#' @param level : Is a string that represents the administrative level. 
#' @param year : The numeric year of the maps requested.
#' @param canarias : A boolean value(TRUE/FALSE) to take Canarias into account.
#' @param scale : It's the scale of the map.

#' @return A S4 object specified by the user
#' 
#' 
#' @details - \code{obj} should be a string of the path to the maps. It should contain the subfolders \bold{SIANE_CARTO_BASE_S_3M} and \bold{SIANE_CARTO_BASE_S_6M5}. \cr 
#' - \code{level} can take the values of "Provincias","Municipios" or "Comunidades". The default value \cr is \code{level <- "Provincias"} \cr
#' - \code{canarias} set to TRUE returns the Canarias map. \code{canarias} set to FALSE returns to the Peninsulae maps. \cr
#' - The \code{year} variable should be numeric. If the map is not available for that year, the loaded map will be the latest available map. \cr
#' The default value for the year is the latest year in which the maps are available. \cr 
#' - The \code{scale} of the maps can be 1:3000000 or 1:6500000. The corresponding values for the \code{scale} variable are "3m" and "6m". \cr
#' The default value for the municipalities maps is \code{scale <- "3m"} . The default value for the other maps is \code{scale <- "6m"}
#' @export
#' 

siane_map <- function(obj, canarias, year, level, scale){
  level_code <- match_level(level) # Administrative level as a string 
  
  if(missing(scale)){
    scale <- find_scale(level_code) # Setting default scale to 3M for municipalities and 6M5 for provinces and regions 
  }
  
  if(missing(canarias)){  
    canarias <- FALSE  # Setting default canarias to FALSE. 
  }
  
  bool_can <- boolean_canarias(canarias) # Canarias indicator
  path_by_scale <- path_scale(scale) # Scale indicator

  base_path <- file.path(obj,path_by_scale,'anual') # base path 
  dirs_path <- list.dirs(base_path) # Listing the dirs in the path
  dirs_path <- sort(dirs_path, decreasing = TRUE) # We sort the dirs to be able to search the file from the newest year to the latest year 
  last_path <- file_name(level_code, bool_can, scale) # This is the path to the file

  
  shp <- readOGR(dsn = get_dir(base_path, dirs_path,last_path, year), 
                 layer = file_name(level_code, bool_can, scale),use_iconv = TRUE,encoding = "utf-8") # Read the map
}

