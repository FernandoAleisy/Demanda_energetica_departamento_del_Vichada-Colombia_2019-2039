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

#Logaritmo natural

Ln<-function(i){
	log(i,exp(1))
}

#Población estimada en función de la población inicial, tiempo y tasa de crecimiento 

C.t<-function(p0,t,r){
	round(p0*exp(r*(t-2003)))	
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	Pr<-residuales/(1-lm.influence(i)$hat)
	sum(Pr^2)
}

######################################################

##MODELO DIRECTO##

#Ajuste del tiempo

Consumo2[3]<-Consumo2[1]-2003
names(Consumo2)<-c('año', 'C', 't')

##TASA MEDIA DE CRECIMIENTO##

n<-Consumo2$t[13]

r<-(1/n)*Ln(Consumo2$C[13]/Consumo2$C[1])
r

##ESTIMACIÓN DE LA POBACIÓN##

Consumo2[4]<-C.t(Consumo2$C[1], Consumo2$año, r)
names(Consumo2)<-c('año', 'C', 't', 'C.est')

##MODELO##

regresion2<-lm(Consumo2$C ~ Consumo2$C.est)
regresion2
coef2=coefficients(regresion2)

#ANALISIS DE LA REGRESIÓN##

summary(regresion2)
anova(regresion2)

#Residuales PRESS

PRESS(regresion2)

#Gráficas de residuales

x11()
par(mfrow=c(2,2))
plot(regresion2,1:4)

######################################################

##GRÁFICAS##

x11()
plot(Consumo2$C ~ Consumo2$t, main='Regresión Crecimiento exponencial del consumo de energía\neléctrica del departamentento del Vichada',lwd=5, xlab='tiempo en años contados a partir de 2004', ylab='Consumo (kWh/mes)', pch=19)
lines(seq(0, 13, 1),1.055*C.t(Consumo2$C[1],seq(2003, 2016, 1),r)-168775.356, col='blue', lwd=3)
text(9,900000,substitute("P(t)"==paste(1.055*"e"^"0.067t"-168775.356)),cex=1.5)

######################################################

##PROYECCIÓN##

a<-2019:2039
b<-1.055*C.t(Consumo2$C[1],a,r)-168775.356
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Consumo')
Proyeccion


