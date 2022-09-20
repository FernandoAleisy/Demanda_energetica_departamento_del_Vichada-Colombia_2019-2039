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

##SE ESTABLECE UNA NUEVA VARIABLE COMO EL CUADRADO DEL TIEMPO##

Consumo2[3]<-(Consumo2[1])^2
names(Consumo2)<-c('t', 'C', 't2')
View(Consumo2)

Regresion<-lm(Consumo2$C ~ Consumo2$t+Consumo2$t2)
Regresion

coef=coefficients(Regresion)
coef

######################################################

##FUNCIONES##

##Estimador del la pobación

C.t<-function(i){
	round(coef[1]+coef[2]*(i)+coef[3]*(i)^2, 2)
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	residuales
	Pr<-residuales/(1-lm.influence(i)$hat)
	sum(Pr^2)
}

######################################################

##ANALISIS DE LA REGRESIÓN##

summary(Regresion)
anova(Regresion)

#Residuales PRESS

PRESS(Regresion)

#Gráficas de residuales

par(mfrow=c(2,2))
plot(Regresion,1:4)
#1-aleatoriedad
#2-distribución normal
#3-hemocedasticidad de los datos
#4-dato extremos

######################################################

##GRÁFICA DE LA REGRESIÓN##

x11()
plot(Consumo2$C ~ Consumo2$t, main='Regresión Crecimiento parabólico del consumo de energía\n eléctrica del departamentento del Vichada',lwd=5, xlab='Año', ylab='Consumo (kWh/mes)', pch=19)
lines(seq(2003, 2016, 1),C.t(seq(2003, 2016, 1)), col='orange', lwd=2)
text(2010.5,850000,substitute("C(t)"==paste(31747264640-31684061*'t'+7906*"t"^"2")),cex=1.5)

#Correlación diferente de 0
#Ho=0
#Ha!=0
#Se pone a prueba la hipotesis nula

######################################################

##ESTIMACIONES DE LA POBLACIÓN##

a<-2019:2039
b<-C.t(2019:2039)
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Consumo')
Proyeccion