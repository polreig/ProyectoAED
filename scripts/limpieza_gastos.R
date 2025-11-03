
# Cargamos librerias
library(dplyr)
library(tidyr)
library(data.table)

# Cambiar los nombres de las columnas usando dplyr
datos <- datos %>%
  rename(
    
    # Gastos en servicios educativos
    importe_matricula_clases = MCL,
    servicio_comedor = C08,
    importe_comedor = C09A,
    servicio_transporte = C10,
    importe_transporte = C11A,
    servicio_alojamiento = C12,
    importe_alojamiento = C13A,
    servicio_ampliacion_horario = C14,
    importe_ampliacion_horario = C15A,
    servicio_clases_apoyo = C16,
    importe_clases_apoyo = C17A,
    servicio_actividades_extraescolares = C18,
    importe_actividades_extraescolares = C19A,
    servicio_actividades_complementarias = C20,
    importe_actividades_complementarias = C21A,
    servicio_cuota_ampa = C22,
    importe_cuota_ampa = C23A,
    servicio_otros = C24,
    importe_otros_servicios = C25A,
    
    # Clases particulares y estudios no reglados
    servicio_clases_particulares = C26,
    importe_clases_particulares = C27A,
    importe_escuela_idiomas = C28A,
    importe_estudios_idiomas_no_reglados = C29A,
    importe_ensenanzas_artisticas = C31A,
    importe_oposiciones_pruebas_acceso = C33A,
    importe_otros_estudios = C34A,
    
    # Gastos en bienes
    gasto_libros = DLIB,
    importe_libros = LIB,
    gasto_fotocopias = D42,
    importe_fotocopias = D43,
    gasto_uniformes = D44,
    importe_uniformes = D45,
    gasto_papeleria = D47,
    importe_papeleria = D48,
    gasto_muebles_accesorios = D50,
    importe_muebles_accesorios = D51,
    gasto_productos_informaticos = D53,
    importe_productos_informaticos = D54,
    gasto_otros_bienes = D56,
    importe_otros_bienes = D57,
    
    # Totales de gasto
    gasto_total_educacion = GTT,
    gasto_total_servicios = GTS,
    gasto_total_servicios_reglados = GTSR,
    gasto_total_servicios_no_reglados = GTSNR,
    gasto_total_bienes = GTB
  )

# Verificar los cambios
colnames(datos)

# Identificar SI (1) estudiantes vs NO (0) estudiantes.

table(datos$ESTUDIANTE)

# Limpieza basada en los gastos totales de los estudiantes
limpieza_gastos <- function(datos) {
  
  datos_limpios <- datos %>%
    # Solo asegurar que tenemos estudiantes con gasto total conocido
    filter(ESTUDIANTE == 1, !is.na(gasto_total_educacion)) %>%
    
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

dataset_limpio <- limpieza_gastos(datos)
