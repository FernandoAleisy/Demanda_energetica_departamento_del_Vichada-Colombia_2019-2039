# Para iniciar la interfaz usar library(Rcmdr)

setwd("D:/Tesis/Datos/Datos y script")

library(readxl)
Consumo<-read_excel("Base de datos Vichada general.xlsx", sheet='Consumo')

Consumo2<-data.frame(Consumo)


for(i in 1:2){
	Consumo2[2]<-NULL
}

names(Consumo2)<-c('Año', 'C')
Consumo2<-Consumo2[-2,]

######################################################

##FUNCIONES##

#Consumo estimado en función del tiempo 

C.t<-function(i) {
	round(coef[1]+coef[2]*i, 2)
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	Cr<-residuales/(1-lm.influence(i)$hat)
	sum(Cr^2)
}

######################################################

##REGRESIÓN LINEAL##

names(Consumo2)<-c('t', 'C')

regresion<-lm(Consumo2$C ~ Consumo2$t)
regresion

coef=coefficients(regresion)

##ANALISIS DE LA REGRESIÓN##

summary(regresion)
anova(regresion)

#Correlación diferente de 0
#Ho=0
#Ha!=0
#Se pine a prueba la hipotesis nula

#Residuales PRESS

PRESS(regresion)

#Gráficas de residuales

x11()
par(mfrow=c(2,2))
plot(regresion,1:4)

#1-aleatoriedad
#2-distribución normal
#3-hemocedasticidad de los datos
#4-dato extremo

######################################################

##GRÁFICAS##

x11()
plot(Consumo2$C ~ Consumo2$t, main='Regresión Crecimiento lineal del Consumo de energía\n eléctrica del departamentento del Vichada', xlab='tiempo en años', ylab='Consumo (kWh/mes)', lwd=3, pch=19)
lines(seq(2003, 2016, 1),C.t(seq(2003, 2016, 1)), col='blue', lwd=3)
text(2012,900000,substitute("C(t)"==paste(-182335758+91346*'t')),cex=1.5)

a<-2019:2039
b<-C.t(2019:2039)
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Consumo')
Proyeccion