###### Creando nuevas variables
#Entonces podemos usar �Por qu� crear nuevas variables?
#A menudo, los datos sin procesar no tendr�n el valor que est� buscando.
#Deber� transformar los datos para obtener los valores que necesita
#Por lo general, agrega esos valores al marco de datos con el que est� trabajando
#Variables comunes para crear
#Indicadores de falta
#Variables cuantitativas de "corte" (binning)
#Aplicando transformaciones
#para crear tablas "planas".

# Datos:Restaurant
restdata=read.csv("C:/Users/ediso/Downloads/Coursera/datasciencecoursera/03 Getting and Cleaning Data/Semana 3/Restaurants.csv")
##### Creando Secuencias
# Las secuencias pueden ser �tiles para crear �ndices para su conjunto de datos.
s1=seq(1,10,by=2) #crear secuencia de 1 al 10 de dos en dos
s1
s2=seq(1,10,length=32) # de 1 a 10 separado en 32
s2


####### Subsetting
restdata$nearme=restdata$neighborhood %in% c("Roland Park", "Homeland")
table(restdata$nearme)


#####Crear variables binarias

#(Me parece que lo siguiente en realidad deber�a verificar restdata$zipCode <= 0,
#o incluso algo como restData $ zipCode <= 9999, suponiendo que los c�digos
#postales no pueden tener un primer d�gito de 0. Adem�s, ninguno de estos
#ejemplos de c�digo postal manejar los c�digos postales "extendidos").
restdata$zipWrong <- ifelse(restdata$zipCode < 0,
                            TRUE, FALSE) # look for "negative" zip codes
table(restdata$zipWrong, restdata$zipCode < 0)


#####Crear variables categ�ricas

#La funci�n de cut se puede utilizar para "agrupar(bin)" los valores de una 
#variable cuantitativa en un factor.
#El ejemplo me parece bastante extra�o, como si los c�digos postales fueran
#valores num�ricos.

restdata$zipGroups <- cut(restdata$zipCode, breaks=quantile(restdata$zipCode))
table(restdata$zipGroups, restdata$zipCode)


###### Corte mas sencillo
install.packages("Hmisc")
library(Hmisc)
restdata$zipGroups <- cut2(restdata$zipCode,g=4) # "agrupar" zipCode en 4 grupos
table(restdata$zipGroups)

# Creand factores
restData$zcf <- factor(restData$zipCode)
restData$zcf[1:10]
class(restData$zcf)



# Usando la funci�n de mutate
#La funci�n mutate (de plyr) ejecuta transformaciones de forma iterativa para que 
#las transformaciones posteriores puedan usar las columnas creadas por 
#transformaciones anteriores (eso es de la ayuda para la funci�n). Aqu�, solo 
#agrega una columna, �creo? Tenga en cuenta que mutate devuelve un nuevo marco 
#de datos basado en el pasado.
library(plyr)
resdata2=mutate(restdata,zipGroups=cut2(zipGroups,g=4))



abs (x) valor absoluto
ra�z cuadrada de sqrt (x)
valor de redondeo del ceiling(x) hasta el siguiente n�mero entero, entonces el techo (3.1) es 4
floor (x) redondea el valor al siguiente n�mero entero, entonces floor (3.9) es 3
round (x, d�gitos = n) se redondea a n d�gitos, round (3.457, d�gitos = 2) es 3.46
signif (x, d�gitos = n): signif (3.475, d�gitos = 3) es 3.5
cos (x), sin (x), etc.
log (x): logaritmo natural
log2 (x), log10 (x): otros logaritmos comunes
exp (x): exponiendo x

