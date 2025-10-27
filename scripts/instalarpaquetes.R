# scripts/00_setup.R
# Configuración inicial del proyecto

# Instalar y cargar librerías necesarias
required_packages <- c(
  "tidyverse",    # Manipulación y visualización
  "readxl",       # Leer Excel
  "haven",        # Leer SPSS, Stata
  "ggplot2",      # Gráficos
  "dplyr",        # Manipulación
  "tidyr",        # Datos tidy
  "knitr",        # Reportes
  "kableExtra",   # Tablas formateadas
  "corrplot",     # Correlaciones
  "naniar",       # Valores missing
  "summarytools", # Resúmenes
  "rmarkdown",    # Reportes
  "rticles"       # Plantilla artículo
)

# Instalar paquetes faltantes
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

# Cargar librerías
lapply(required_packages, require, character.only = TRUE)

# Configurar opciones
options(scipen = 999)  # Desactivar notación científica