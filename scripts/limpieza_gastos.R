# Verificar los cambios
colnames(datos)

# Identificar SI (1) estudiantes vs NO (0) estudiantes.

table(datos$ESTUDIANTE)

# Limpieza basada en los gastos totales de los estudiantes
limpieza_gastos <- function(datos) {
  
  datos_limpios <- datos %>%
    # Solo asegurar que tenemos estudiantes con gasto total conocido
    filter(!is.na(gasto_total_educacion)) %>%
    
    # Imputación solo para análisis específicos
    mutate(
      # Para servicios: NAs = 2 (No)
      across(starts_with("servicio_"), ~ ifelse(is.na(.), 2, .)),
      
      # Importes: NAs = 0 (no gastaron en ese concepto)
      across(starts_with("importe_"), ~ ifelse(is.na(.), 0, .)),
      
      # Gastos Totales: NAs = 0
      across(starts_with("gasto_total_"), ~ ifelse(is.na(.), 0, .)),
      
      # Gastos en bienes: NAs = 2 (no gastaron)
      across(starts_with("gasto_"), ~ ifelse(is.na(.), 2, .)),
      
    )
  
  return(datos_limpios)
}

datos <- limpieza_gastos(datos)