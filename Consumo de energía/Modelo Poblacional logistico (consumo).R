#library(Rcmdr)
setwd("D:/Tesis/Datos/Datos y script")

library(readxl)
Consumo<-read_excel("Base de datos Vichada general.xlsx", sheet='Consumo')

Consumo2<-data.frame(Consumo)

for(i in 1:2){
	Consumo2[2]<-NULL
}

names(Consumo2)<-c('Año', 'C')
Consumo2<-Consumo2[-1,]

######################################################

##FUNCIONES##

#Logaritmo natural

Ln<-function(i){
	log(i,exp(1))
}

#Valor de K

k<-function(p0,p1,p2) {
	abs((2*p0*p1*p2-(p0+p2)*p1^2)/(p0*p2-p1^2))
}

#Valor de A

A<-function(k,c0) {
	(k-c0)/c0
}

#Población estimada en función de la población inicial, tiempo y tasa de crecimiento 

C.t<-function(c0,r,k,t,A){
	Ak<-(k-c0)/c0
	round(k/(1+Ak*exp(-r*(t-2004))),1)
}

#Residuales PRESS

PRESS<-function(i) {
	residuales<-resid(i)
	Pr<-residuales/(1-lm.influence(i)$hat)
	sum(Pr^2)
}

######################################################

##AJUSTE DEL TIEMPO##

Consumo2[3]<-Consumo2[1]-2004
names(Consumo2)<-c('año', 'C', 't')

##PARAMETROS DE LA REGRESIÓN LOGISTICA##

#Población inicial
C01<-Consumo2$C[1]
C11<-Consumo2$C[6]
C21<-Consumo2$C[13]

#Població límite
k1<-k(C01,C11,C21)
k1
#Tasa de crecimiento inicial
n1<-Consumo2$t[6]
n1
r1<-abs((1/n1)*Ln((C01*(k1-C11)/(C11*(k1-C01)))))
r1

#Valor de A

A1<-A(k1, C01)
A1

######################################################

##REGRESIÓN POR LINEALIZACIÓN##

Consumo2[4]<-C.t(C01,r1,k1,Consumo2[1],A1)
names(Consumo2)<-c('Año', 'C', 't', 'C.est1')
View(Consumo2)

#gráfica de dispersión

x11()
plot(Consumo2$C.est1~ Consumo2$t, main='gráfica de dispersión del consumo de energía\neléctrica en kWh/mes del departamentento del Vichada',lwd=5, xlab='tiempo en años contados a partir de 2004', ylab='Consumo', pch=19)


regresion1<-lm(Consumo2$C~Consumo2$C.est1)
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
plot(Consumo2$C ~ Consumo2$t, main='Regresión Crecimiento logistico del consumo de energía\neléctrica del departamentento del Vichada',lwd=5, xlab='tiempo en años contados a partir de 2004', ylab='Consumo (kWh/mes)', pch=19)
lines(seq(0, 12, 1),1.002*C.t(C01, r1, k1, seq(2004, 2016, 1),A1)+45472.338, col='blue', lwd=3)
text(8,800000,substitute("C(t)"==paste(frac(paste("3151910"), paste(1+3.97*"e"^"-0.144t")))+45472.34),cex=1.5) 

######################################################

##PROYECCIÓN DE LA POBLACIÓN##

a<-2019:2039
b<-C.t(C01, r1, 3151910, seq(2019, 2039, 1),A1)+45472.34
Proyeccion<-data.frame(cbind(a,b))
names(Proyeccion)<-c('Año','Consumo')
Proyeccion




