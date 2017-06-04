
get_siane_map <- function(obj, level, year, canarias, provincia, comunidad){
  codes <- get_code(level,canarias)  # Extracting keywords
  shp <- readOGR(dsn = file.path(obj, "historico"), 
                 layer = path_to_map(codes)) # Read the map
  shp <- contains_year(shp, year) # Filter the map by year
}

