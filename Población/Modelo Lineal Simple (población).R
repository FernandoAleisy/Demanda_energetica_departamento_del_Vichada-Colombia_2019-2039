# Para iniciar la interfaz usar library(Rcmdr)

setwd("D:/Tesis/Datos/Datos y script")

library(readxl)
Pobl<-read_excel("Base de datos Vichada general.xlsx", sheet='Poblacion')

Pobl2<-data.frame(Pobl)

######################################################

##FUNCIONES##

#Población estimada en función del tiempo 

P.t<-function(i) {
	round(coef[1]+coef[2]*i, 0)
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	Pr<-residuales/(1-lm.influence(i)$hat)
	sum(Pr^2)
}

######################################################

##REGRESIÓN LINEAL##

names(Pobl2)<-c('t', 'P')

regresion<-lm(Pobl2$P ~ Pobl2$t)
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
plot(Pobl2$P ~ Pobl2$t, main='Regresión Crecimiento lineal de la Población\ndel departamentento del Vichada', xlab='tiempo en años', ylab='Población', lwd=3, pch=19)
lines(seq(1985, 2018, 1),P.t(seq(1985, 2018, 1)), col='blue', lwd=3)
polygon(c(1996,1997), c(25000,25000), border='blue', lwd=3)
text(2008,25000,substitute("P(t)"==paste(-3655679.548+1850.436*'t')),cex=1.5)

a<-2003:2016
b<-P.t(2019:2039)
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Población')
Proyeccion