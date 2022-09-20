# Para iniciar la interfaz usar library(Rcmdr)

setwd("D:/Tesis/Datos/Datos y script")

library(readxl)
Pobl<-read_excel("Base de datos Vichada general.xlsx", sheet='Poblacion')

Pobl2<-data.frame(Pobl)



######################################################

##SE ESTABLECE UNA NUEVA VARIABLE COMO EL CUADRADO DEL TIEMPO##

Pobl2[3]<-(Pobl2[1])^2
names(Pobl2)<-c('t', 'P', 't2')
View(Pobl2)



Regresion<-lm(Pobl2$P ~ Pobl2$t+Pobl2$t2)
Regresion

coef=coefficients(Regresion)
coef


##FUNCIONES##

##Estimador del la pobación

P.t<-function(i){
	round(coef[1]+coef[2]*(i)+coef[3]*(i)^2, 0)
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	residuales
	Pr<-residuales/(1-lm.influence(i)$hat)
	sum(Pr^2)
}

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
plot(Pobl2$P ~ Pobl2$t, main='Regresión Crecimiento parabolico de la Población\ndel departamentento del Vichada',lwd=5, xlab='Año', ylab='Población', pch=19)
lines(seq(1985, 2018, 1),P.t(seq(1985, 2018, 1)), col='orange', lwd=2)
text(2005,25000,substitute("P(t)"==paste(-90970422+89096*'t'-22*"t"^"2")),cex=1.5)

#Correlación diferente de 0
#Ho=0
#Ha!=0
#Se pone a prueba la hipotesis nula

######################################################

##ESTIMACIONES DE LA POBLACIÓN##

a<-2019:2039
b<-P.t(2019:2039)
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Población')
Proyeccion