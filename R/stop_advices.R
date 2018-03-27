
stop_advices <- function(df, by, value){

if((by %in% names(df)) == FALSE){ # Checking if the ID's column is in the dataframe
    stop(paste0("The column ", by, " is not in the data frame. Try to run names(df) to check the data frame column names"))
}
if((value %in% names(df)) == FALSE){ # Checking if the ID's column is in the dataframe
    stop(paste0("The column ", value," is not in the data frame. Try to run names(df) to check the data frame column names"))
}
  
}