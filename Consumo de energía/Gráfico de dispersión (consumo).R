#library(Rcmdr)
setwd("D:/Tesis/Datos/Datos y script")

library(readxl)
Consumo<-read_excel("Base de datos Vichada general.xlsx", sheet='Consumo')
Consumo2<-data.frame(Consumo)

######################################################

##CORRELACIÓN##

plot(Consumo2, main='Matriz de dispersión del Año, usuarios (Viviendas),\nPoblación y Consumo del departamento del Vichada')
cor(Consumo2)

#Se eliminan las variables que estan relacionadas con el tiempo

for(i in 1:2){
	Consumo2[2]<-NULL
}

names(Consumo2)<-c('t', 'C')

##DISPERSIÓN##

x11()
plot(Consumo2$C ~Consumo2$t, main='Consumo de energía eléctrica del\ndepartamento del Vichada según SUI',lwd=5, xlab='Tiempo en años', ylab='Consumo (kWh/mes)',pch=19)
Consumo2<-Consumo2[-2,]
x11()
plot(Consumo2$C ~Consumo2$t, main='Consumo de energía eléctrica del\ndepartamento del Vichada según SUI',lwd=5, xlab='Tiempo en años', ylab='Consumo (kWh/mes)',pch=19)


