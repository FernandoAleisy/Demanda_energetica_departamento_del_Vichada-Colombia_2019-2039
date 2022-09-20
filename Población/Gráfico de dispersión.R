#library(Rcmdr)
setwd("D:/Tesis/Datos/Datos y script")

library(readxl)
Pobl<-read_excel("Base de datos Vichada general.xlsx", sheet='Poblacion')
Pobl2<-data.frame(Pobl)

names(Pobl2)<-c('t','P')
#Gráfica de la dispersión

plot(Pobl2$P ~ Pobl2$t, main='pobalción del departamento del Vichada\nsegún censos del DANE',lwd=5, xlab='Tiempo en años', ylab='Población',pch=19)

x11()
plot(Pobl2$P ~ Pobl2$t, main='pobalción del departamento del Vichada\nsegún censos del DANE', xlab='Tiempo en años', ylab='Población',pch=19)
legend(1985, 75000, lty=c(1,1), col = c("blue", "orange", "green"), lwd=c(3,3),  legend = c ("Crecimiento medio", "Mayor crecimiento", "Menor crecimiento"), bty="o", ncol=1)
lines(c(Pobl2$t[1],Pobl2$t[2]),c(Pobl2$P[1],Pobl2$P[2]), col='blue', lwd=2)
lines(c(Pobl2$t[2],Pobl2$t[3]),c(Pobl2$P[2],Pobl2$P[3]), col='orange', lwd=2)
lines(c(Pobl2$t[3],Pobl2$t[4]),c(Pobl2$P[3],Pobl2$P[4]), col='green', lwd=2)
