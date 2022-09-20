setwd("D:/Tesis/Datos/Datos y script")

library(readxl)
Pobl<-read_excel("Base de datos Vichada general.xlsx", sheet='Poblacion')

Pobl2<-data.frame(Pobl)

######################################################

##FUNCIONES##

#Logaritmo natural

Ln<-function(i){
	log(i,exp(1))
}

#Población estimada en función de la población inicial, tiempo y tasa de crecimiento 

P.t<-function(p0,t,r){
	round(p0*exp(r*(t-1985)))	
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	Pr<-residuales/(1-lm.influence(i)$hat)
	sum(Pr^2)
}

######################################################

##REGRESIÓN POR LINEALIZACIÓN##


#Ajuste del tiempo

Pobl2[3]<-Pobl2[1]-1985
names(Pobl2)<-c('año', 'P', 't')

#Linealización

Pobl2$Ln.p<-Ln(Pobl2$P)

#gráfica de dispersión

plot(Pobl2$Ln.p ~ Pobl2$t, main='gráfica de dispersión de la Población\ndel departamentento del Vichada',lwd=5, xlab='tiempo en años contados a partir de 1985', ylab='Ln(Población)', pch=19)

regresion<-lm(Pobl2$Ln.p~Pobl2$t)
regresion

##PARAMETRSO OBTENIDOS DE LA LINEALIZACIÓN##

coef=coefficients(regresion)

#para la tasa de crecimiento estimada por linelaización
r.est<-coef[2]
r.est
#Población inicial teórica
Pit<-exp(coef[1])
Pit

##ANALISIS DE LA REGRESIÓN POR LINEALIZACIÓN##

summary(regresion)
anova(regresion)

#Residuales PRESS

PRESS(regresion)

#Gráficas de residuales

x11()
par(mfrow=c(2,2))
plot(regresion,1:4)

######################################################

##MODELO DIRECTO##

##TASA MEDIA DE CRECIMIENTO##

n<-Pobl2$t[4]

r<-(1/n)*Ln(Pobl2$P[4]/Pobl2$P[1])
r

##ESTIMACIÓN DE LA POBACIÓN##

Pobl2[5]<-P.t(Pobl2$P[1], Pobl2$año, r)
names(Pobl2)<-c('año', 'P', 't', 'Ln.p', 'P.est')

##MODELO##

regresion2<-lm(Pobl2$P ~ Pobl2$P.est)
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
plot(Pobl2$P ~ Pobl2$t, main='Regresión Crecimiento exponencial de la Población\ndel departamentento del Vichada',lwd=5, xlab='tiempo en años contados a partir de 1985', ylab='Población', pch=19)
lines(seq(0, 33, 1),P.t(Pit,seq(1985, 2018, 1),r.est), col='blue', lwd=3)
lines(seq(0, 33, 1),coef2[2]*P.t(Pobl2$P[1],seq(1985, 2018, 1),r)+coef2[1], col='orange', lwd=3)
legend(0, 75000, lty=c(1,1), col = c('blue', 'orange'), lwd=c(3,3),  legend = c ("r=0.048", "r=0.052"), bty="o", ncol=1)
polygon(c(14,15), c(30000,30000), border='blue', lwd=3)
text(25,30000,substitute("P(t)"==paste(18312*"e"^"0.048t")),cex=1.5)
polygon(c(14,15), c(20000,20000), border='orange', lwd=3) 
text(25,20000,substitute("P(t)"==paste(12411*"e"^"0.052t"+11796)),cex=1.5)

######################################################

##PROYECCIÓN##

a<-2019:2039
b<-P.t(Pit,a,r.est)
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Población')
Proyeccion


