####Subconjunto

##Crear un marco de datos con algunos datos.
##Revuelva los datos para que las filas no est�n en orden ascendente
##Asignar algunos valores de NA a var2

set.seed(13435)
x=data.frame("var1"=sample(1:5),"var2"=sample(6:10),"var3"=sample(11:15))
x <- x[sample(1:5),]; x$var2[c(1,3)] = NA
x
x[,1] # retorna la primera fila
x[,"var1"] # retorna la primera fila
x[1:2,"var2"] #segunda columna, primera dos filas


##### Logica: Y y o (ands and ors)

x[x$var1<=3 & x$var3>11,] #filas donde var1 menor igual a 3 y var3 mayor a 11

x[x$var1 <=3 | x$var3> 15,] #filas donde var 1 es menor igual a 3 o var3 mayor a 15


##### Manejo de valores missing
x[x$var > 8,]

#La funci�n which proporciona los �ndices TRUE para un objeto l�gico
#entonces la presencia de NA significar�a que no se devolvieron filas.
#Pero la funci�n which() ignorar� los valores de NA.
x[which(x$var2 > 8),]


# Clasificaci�n (sort)
#La funci�n sort solo funciona en vectores. Por lo tanto, puede usarlo contra una
#columna en un marco de datos, pero clasificar� y devolver� solo esa columna, no
#todo el marco de datos.
sort(x$var1)
sort(x$var1,decreasing=TRUE) 
sort(x$var2) #sin NA
sort(x$var2, na.last=TRUE) #con NA


#### Ordenando
# La funci�n de order funciona para un marco de datos completo.
x[order(x$var1),] #ordenar x dado el orden de var1
x[order(x$var1,x$var3),] #ordenar var1 y despu�s de var3


# Ordenar con plyr
install.packages("plyr")
library(plyr)
arrange(x,var1) #ordenar x pr var1
arrange(x,desc(var1)) #orden descencdiente
arrange(x, desc(var1), var2)


######## Agregando Columnas y filas
# agregar var4 a x
x$var4=rnorm(5)
x$var4


#Otro m�todo es cbind. El siguiente ejemplo agrega una columna en el lado derecho
#de X. Si X debajo aparece como el segundo par�metro, entonces rnorm (5) se
#agregar�a como la columna m�s a la izquierda en lugar de la m�s a la derecha.
y=cbind(x,rnorm(5))
y
