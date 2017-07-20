#' @title Merges data and maps
#' 
#' @description This is a function that binds data to polygons
#' 

#' @examples
#' obj <- register_siane(system.file("extdata",package = "Siane"))
#' shp <- siane_map(obj = obj, level = "Municipios", canarias = FALSE) # Loading the municipality's map of Spain
#' plot(shp) # Plot the map
#' df <- read.csv(system.file("extdata","sampleRiojaPopulation.csv",package = "Siane"))
#' by <- "codes"
#' df[[by]] <- sapply(df$Municipios,function(x) strsplit(x = as.character(x), split = " ")[[1]][1])
#' year <- 2016
#' df$Periodo <- as.numeric(as.character(df$Periodo))
#' df <- df[df$Sex == "Total" & df$Periodo == year, ]
#' value <- "value"
#' level <- "Municipios"
#' shp_merged <- siane_merge(shp = shp, df = df,by = by, level = level, value = value)
#' plot(shp_merged)
#'  




#' @param shp : A S4 object returned by the \code{siane_map} function.
#' @param df : The data frame with the data we want to plot
#' @param by : The name of the column that contains the ID's of the territories. 
#' @param level : The level of the territory.
#' @param value : The statistical values's we want to plot. Only one value per territory. 

#' @details - \code{shp} is a S4 object returned by the \code{siane_map} function. \cr
#' - \code{df} is a data frame. This data frame should have at least two columns:
#'  one column of statistical data and another column of territorial codes. 
#' There will be as many missing territories as missing codes in the dataframe. \cr
#' - \code{by} is the dataframe's codes column. These codes should be the
#'  INE's official codes. \cr 
#' - For the \code{level} parameter you pick one of these: "Municipios",
#'  "Provincias", "Comunidades" . It's very important that this level
#'   is consistent with the S4 object level. \cr
#' - \code{value} is the name of the column with the statistical values
#' 
#' 
#' 
#' 
#' @export
#' 
#' @return A S4 object with the statistical data provided. 


siane_merge <- function(shp, df, by, level, value){
  stop_advices(df, by, value) # Stop sentences for column names: Values column and codes column.
  
  shp_code <- shp_code(level) # The shape file column that contains the code depends on the level. This function returns the code's shp column name 
  
  
  name_filter <- names(df) == by # 
  names(df)[name_filter] <- shp_code # Renaming the column to make the join
  
  # Attention: Using plyr join because it doesn't change the data frame order.
  # base::merge function does disorder the data frame 
  
  shp@data <- join(shp@data, df)  # Join the data and shape object
  values_ine_filter <- shp@data[[value]] # Extract ine values
  filter_map <- which(is.na(values_ine_filter) == FALSE) # Making the filter 
  shp <- shp[filter_map, ] # Filtering the map
  
  return(shp) # Return the merged map
}