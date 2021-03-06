# datos: https://data.baltimorecity.gov/Community/Restaurants/k5ry-ef3g

if(!dir.create("./data")){
  dir.create("./data")
}
if(!file.exists("./data/Restaurants.csv")){
  fileUrl <- "https://data.baltimorecity.gov/api/views/k5ry-ef3g/rows.csv?accessType=DOWNLOAD"
  download.file(fileUrl, destfile="./data/Restaurants.csv", method="curl")
}

restdata=read.csv("Restaurants.csv")

#Mirando los datos
#El comando head por defecto devuelve las primeras 6 filas de un marco de datos.
#El argumento n puede ajustar el n�mero de filas.

head(restdata,n=3)

#tail
tail(restdata,n=3)

#Resumen (Summary)
summary(restdata)


# Ver datos con mayor profundidad
# la funci�n str muestra la estructura detr�s de los datos
str(restdata)

###### Cuantiles de variables cuantitativas

#A continuaci�n se muestran los valores cuantiles para 0%, 25%, 50%, 75% y 100%. 
#El par�metro na.rm se usa para garantizar que los valores de NA se ignoren. Sin
#embargo, tenga en cuenta que intent� configurar na.rm en FALSE y los resultados 
#fueron los mismos. (Aparentemente, los datos no contienen NA).
quantile(restdata$councilDistrict, probs = c(0.5,0.75,0.9))


#Hacer una tabla
#Esto crea una tabla de frecuencias para cada c�digo postal. useNA = "ifany" 
#pondr� un recuento de los valores de NA al final (de lo contrario, se ignorar�n
#y no se informar�n). Podemos ver:
#Un c�digo postal con un valor negativo, probablemente un error de entrada
#Los c�digos postales con los recuentos m�s altos.
table(restData$zipCode, useNA="ifany")


# de dos dimensiones
table(restData$councilDistrict, restData$zipCode)


#### Checkear datos missing
sum(is.na(restdata$councilDistrict)) #sumar los valores NA

any(is.na(restData$councilDistrict)) # True=exite alg�n NA

all(restData$councilDistrict > 0) #True si alg�n valor es mayor a 0

#### Suma de columnas y filas

# colSums y rowSums 

colSums(is.na(restdata)) #contar missing por columnas
all(colSums(is.na(restdata))==0) #True si ninguna de las columnas tiene NA
any(is.na(restdata))


##### Valores con caracter�sticas espec�ficas
#El operador %in% busca instancias de valores en la expresi�n de la derecha en la
#expresi�n de la izquierda.
table(restdata$zipCode %in% c("21211"))
table(restdata$zipCode %in% c("21212","21213"))
head(restdata[restdata$zipCode %in% c("21212", "21213"),])


##### Tabulaciones cruzadas
data(UCBAdmissions)
DF = as.data.frame(UCBAdmissions)
summary(DF)

xt <- xtabs(Freq ~ Gender + Admit, data=DF)
xt

##### xtabs

#Si hay muchas variables, la salida de xtabs puede ser dif�cil de examinar. Tenga
#en cuenta a continuaci�n que "." en una f�rmula significa "todas las columnas 
#excepto la que est� a la izquierda de ~".

warpbreaks$replicate <- rep(1:9, len=54)
xt <- xtabs(breaks ~ ., data=warpbreaks)
xt

#Entonces podemos usar ftable para crear tablas "planas".
ftable(xt)


