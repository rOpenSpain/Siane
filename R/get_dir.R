get_dir <- function(base_path, dirs_path,last_path, year){

  if(missing(year)){
    cat("Using default year as the latest year \n")
    for(each_dir in dirs_path){
      
      vec <- list.files(each_dir) # List all files from each dir
      vec_split <- sapply(vec, function(x) strsplit(x = x, "\\.")[[1]][1]) # Get the name of the file without the extension
      logic_vector <- vec_split == last_path # Comparing it to the name of the file we are looking for
      
      if(TRUE %in% logic_vector){ # If it is positive we have found the file
        final_dir <- each_dir # Declare a variable of the dir
        
        break
      }
    }
  }else{
    cat(paste0("Using maps from ", year, "\n")) # Message
    
    
    folder_years <- sapply(dirs_path,
                           function(x) tail(strsplit(x = x,split = "/")[[1]],1)) # If the user introduces a year we try to search for the newest map until that year
    
    
    folder_years_num <- sapply(folder_years,
                               function(x) suppressWarnings(as.numeric(substr(x = x, start = 1,stop = 4)))) # Picking the year from the folder name
    
    folder_years_num[which(is.na(folder_years_num)==TRUE)] <- FALSE # Substituting NAN with FALSE
    
    dirs_path <- dirs_path[folder_years_num <= year]
    for(each_dir in dirs_path){
      vec <- list.files(each_dir) # List all files from each dir
      vec_split <- sapply(vec, function(x) strsplit(x = x, "\\.")[[1]][1]) # Get the name of the file without the extension
      logic_vector <- vec_split == last_path # Comparing it to the name of the file we are looking for
      
      if(TRUE %in% logic_vector){ # If it is positive we have found the file
        final_dir <- each_dir # Declare a variable of the dir
        
        break
      }
    }
  }
  return(final_dir)
}
