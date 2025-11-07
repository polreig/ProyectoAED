# limpieza_hogar.R
# Fecha: 2025-10-30

# Librerías necesarias
library(readr)
library(dplyr)
library(tidyr)


# Limpieza de datos: variables de contexto geográfico
# Recodificación de TMUNI (tamaño del municipio)
datos <- datos %>% 
  mutate(TMUNI = factor(TMUNI,
                       levels = c(1,2,3,4,5),
                       labels = c("<10.000 habitantes",
                                  "10.000-49.999 habitantes",
                                  "50.000-99.999 habitantes",
                                  "100.000-499.999 habitantes",
                                  ">500.000 habitantes")))

#Recodificación de C03 (Localización Centro) y eliminación de columnas innecesarias

datos <- datos %>%
  rename(Localización_Centro=C03) %>%
  mutate(Localización_Centro = factor(Localización_Centro, levels = c(1,2,3,4,5), labels = c("Municipio Residencia","Misma Provincia","Misma CA", "Otra CA", "Extranjero"))) %>%
  select(-C04, -matches("E[0-9]+"))

# Limpieza de datos: variables de contexto familiar
# EHOGAR: nº estudiantes del hogar
# NHOGAR: nº personas del hogar
# Convertir a tipo entero
datos <- datos %>%
  mutate(IDHOGAR = as.integer(IDHOGAR),
         NHOGAR = as.integer(NHOGAR),
         EHOGAR = as.integer(EHOGAR))

# Filtrar inconsistencias lógicas en NHOGAR
datos <- datos %>%
  filter(NHOGAR >= 1)



