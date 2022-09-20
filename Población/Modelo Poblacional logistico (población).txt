#library(Rcmdr)
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

#Valor de K

k<-function(p0,p1,p2) {
	(2*p0*p1*p2-(p0+p2)*p1^2)/(p0*p2-p1^2)
}

#Valor de A

A<-function(k,p0) {
	(k-p0)/p0
}

#Población estimada en función de la población inicial, tiempo y tasa de crecimiento 

P.t<-function(p0,r,k,t,A){
	Ak<-(k-p0)/p0
	round(k/(1+A*exp(r*(t-1985))))
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	Pr<-residuales/(1-lm.influence(i)$hat)
	sum(Pr^2)
}

######################################################

##AJUSTE DEL TIEMPO##

Pobl2[3]<-Pobl2[1]-1985
names(Pobl2)<-c('año', 'P', 't')

##PARAMETROS DE LA REGRESIÓN LOGISTICA##

#Población inicial
P01<-Pobl2$P[1]
P11<-Pobl2$P[3]
P21<-Pobl2$P[4]

#Població límite
k1<-k(P01,P11,P21)
k1
#Tasa de crecimiento inicial
n1<-Pobl2$t[4]/2
n1
r1<-(1/n1)*Ln((P01*(k1-P11)/(P11*(k1-P01))))
r1

#Valor de A

A1<-A(k1, P01)
A1

######################################################

##REGRESIÓN POR LINEALIZACIÓN##

Pobl2[4]<-P.t(P01,r1,k1,Pobl2[1],A1)
names(Pobl2)<-c('Año', 'P', 't', 'P.est1')
View(Pobl2)

#gráfica de dispersión

x11()
plot(Pobl2$P ~ Pobl2$P.est1, main='gráfica de dispersión de la Población\ndel departamentento del Vichada',lwd=5, xlab='Primera estimación de la población', ylab='Población Real', pch=19)


regresion1<-lm(Pobl2$P~Pobl2$P.est1)
regresion1

##PARAMETRSO OBTENIDOS DE LA LINEALIZACIÓN##

coef=coefficients(regresion1)

##ANALISIS DE LA REGRESIÓN POR LINEALIZACIÓN##

summary(regresion1)
anova(regresion1)

#Residuales PRESS

PRESS(regresion1)

#Gráficas de residuales

x11()
par(mfrow=c(2,2))
plot(regresion1,1:4)

######################################################

##GRÁFICA DE LA REGRESIÓN##

x11()
plot(Pobl2$P ~ Pobl2$t, main='Regresión Crecimiento logistico de la Población\ndel departamentento del Vichada',lwd=5, xlab='tiempo en años contados a partir de 1985', ylab='Población', pch=19)
lines(seq(0, 33, 1),0.9263*P.t(P01, r1, k1, seq(1985, 2018, 1),A1)+2707, col='blue', lwd=3)
text(25,30000,substitute("P(t)"==paste(frac(73657, paste(1+4.78*"e"^"0.146t"))+2707)),cex=1)

######################################################

##PROYECCIÓN DE LA POBLACIÓN##

a<-2019:2039
b<-round(0.9263*P.t(P01, r1, k1, seq(2019, 2039, 1),A1)+2707, 0)
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Población')
Proyeccion