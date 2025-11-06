EGHE_2019<-read.delim("data/EGHE_2019.csv")
library(dplyr)

unique(EGHE_2019["SEXO"])
EGHE_2019<-EGHE_2019%>%mutate(SEXO=factor(SEXO, levels=c(1, 2), labels=c("Hombre", "Mujer")))

unique(EGHE_2019["NACIONALIDAD"])
EGHE_2019<-EGHE_2019%>%mutate(NACIONALIDAD=factor(NACIONALIDAD, levels=c(1,2,3), labels=c("Española", "Extrangera", "Doble nacionalidad")))

unique(EGHE_2019["EDAD"])
RANGOS_EDAD<-cut(EGHE_2019$EDAD, breaks=c(-1, 2, 5, 11, 17, 25, 35, 45, Inf), labels=c("0-2 años", "3-5 años", "6-11 años", "12-17 años", "18-25 años", "26-35 años", "36-45 años", "46 años o más"), ordered=TRUE)
EGHE_2019<-EGHE_2019%>%mutate(EDAD=RANGOS_EDAD)

unique(EGHE_2019["ESTUDIANTE"])
EGHE_2019<-EGHE_2019%>%mutate(ESTUDIANTE=factor(ESTUDIANTE, levels=c(0,1), labels=c("No", "Sí")))

unique(EGHE_2019["REGLADO"])
EGHE_2019<-EGHE_2019%>%mutate(REGLADO=factor(REGLADO, levels=c(0,1), labels=c("No", "Sí")))

unique(EGHE_2019["NOREGLADO"])
EGHE_2019<-EGHE_2019%>%mutate(NOREGLADO=factor(NOREGLADO, levels=c(0,1), labels=c("No", "Sí")))

unique(EGHE_2019["NEST"])
EGHE_2019<-EGHE_2019%>%mutate(NEST=factor(NEST, levels=c(0, 1, 2, 3, 4, 5), labels=c("No realiza estudios", "Educación Infantil", "Educación Primaria", "Educación Secundaria", "Educación Superior", "Otros estudios sin nivel académico")))%>%rename(Nivel_estudios=NEST)

unique(EGHE_2019["NEST2"])
EGHE_2019<-EGHE_2019%>%mutate(NEST2=factor(NEST2, levels=c(00, 01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11), labels = c("No realiza estudios", "1º Ciclo de Educación Infantil", "2º Ciclo de Educación Infantil", "Educación Primaria", "Educación Secundaria Obligatoria (ESO)", "Bachillerato", "Ciclos Formativos de FP", "Otros estudios de educación secundaria", "Estudios Universitarios", "Ciclos Formativos de Grado Superior", "Otros estudios de educación superior", "Otros estudios sin nivel académico")))%>%rename(Nivel_estudios_especifico=NEST2)

sum(is.na(EGHE_2019$C01))/dim(EGHE_2019)[1]
table(EGHE_2019$ESTUDIANTE[is.na(EGHE_2019$C01)])
datos<-EGHE_2019%>%filter(ESTUDIANTE=="Sí" & !is.na(C01))%>%mutate(C01=factor(C01, levels=c(1,2,3), labels=c("Enseñanza pública", "Enseñanza concertada", "Enseñanza privada")))%>%rename(Tipo_educacion=C01)
