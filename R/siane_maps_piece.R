
siane_map_piece <- function(obj, canarias, year, level, scale){
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

