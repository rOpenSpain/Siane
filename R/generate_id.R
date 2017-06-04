generate_id <- function(df_ine_level){
  
  switch(df_ine_level,
         
         Municipios = "id_ine",
         Provincias = "id_prov",
         Comunidades = "id_ccaa"
         
         )
  
}