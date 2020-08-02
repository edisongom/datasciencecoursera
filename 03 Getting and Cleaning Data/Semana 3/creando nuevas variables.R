###### Creando nuevas variables
#Entonces podemos usar ¿Por qué crear nuevas variables?
#A menudo, los datos sin procesar no tendrán el valor que está buscando.
#Deberá transformar los datos para obtener los valores que necesita
#Por lo general, agrega esos valores al marco de datos con el que está trabajando
#Variables comunes para crear
#Indicadores de falta
#Variables cuantitativas de "corte" (binning)
#Aplicando transformaciones
#para crear tablas "planas".

# Datos:Restaurant
restdata=read.csv("C:/Users/ediso/Downloads/Coursera/datasciencecoursera/03 Getting and Cleaning Data/Semana 3/Restaurants.csv")
##### Creando Secuencias
# Las secuencias pueden ser útiles para crear índices para su conjunto de datos.
s1=seq(1,10,by=2) #crear secuencia de 1 al 10 de dos en dos
s1
s2=seq(1,10,length=32) # de 1 a 10 separado en 32
s2


####### Subsetting
restdata$nearme=restdata$neighborhood %in% c("Roland Park", "Homeland")
table(restdata$nearme)


#####Crear variables binarias

#(Me parece que lo siguiente en realidad debería verificar restdata$zipCode <= 0,
#o incluso algo como restData $ zipCode <= 9999, suponiendo que los códigos
#postales no pueden tener un primer dígito de 0. Además, ninguno de estos
#ejemplos de código postal manejar los códigos postales "extendidos").
restdata$zipWrong <- ifelse(restdata$zipCode < 0,
                            TRUE, FALSE) # look for "negative" zip codes
table(restdata$zipWrong, restdata$zipCode < 0)


#####Crear variables categóricas

#La función de cut se puede utilizar para "agrupar(bin)" los valores de una 
#variable cuantitativa en un factor.
#El ejemplo me parece bastante extraño, como si los códigos postales fueran
#valores numéricos.

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



# Usando la función de mutate
#La función mutate (de plyr) ejecuta transformaciones de forma iterativa para que 
#las transformaciones posteriores puedan usar las columnas creadas por 
#transformaciones anteriores (eso es de la ayuda para la función). Aquí, solo 
#agrega una columna, ¿creo? Tenga en cuenta que mutate devuelve un nuevo marco 
#de datos basado en el pasado.
library(plyr)
resdata2=mutate(restdata,zipGroups=cut2(zipGroups,g=4))



abs (x) valor absoluto
raíz cuadrada de sqrt (x)
valor de redondeo del ceiling(x) hasta el siguiente número entero, entonces el techo (3.1) es 4
floor (x) redondea el valor al siguiente número entero, entonces floor (3.9) es 3
round (x, dígitos = n) se redondea a n dígitos, round (3.457, dígitos = 2) es 3.46
signif (x, dígitos = n): signif (3.475, dígitos = 3) es 3.5
cos (x), sin (x), etc.
log (x): logaritmo natural
log2 (x), log10 (x): otros logaritmos comunes
exp (x): exponiendo x

