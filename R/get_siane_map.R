
#'@title get_siane_map
#'
#' @description A function that returns a S4 object of a specific map of Spain

#' @export

#' @param obj : Path of the Siane maps.
#' @param level : Is the administrative level. Can take the values of "Provincia","Municipio" or "Comunidades"
#' @param year : The numeric year of the maps requested.
#' @param canarias : Canarias set to TRUE returns the Canarias map. Canarias set to FALSE returns to the Peninsulae maps.

#' @return A S4 object specified by the user

get_siane_map <- function(obj, level, year, canarias){
  codes <- get_code(level,canarias)  # Extracting keywords
  shp <- readOGR(dsn = file.path(obj, "historico"), 
                 layer = path_to_map(codes)) # Read the map
  shp <- contains_year(shp, year) # Filter the map by year
}

