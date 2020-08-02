#####   Conectandose a una base de datos

#Importante desconectarse de db tan pronto como termine
#El valor devuelto debe ser VERDADERO, lo que indica que la consulta se ejecutó.

install.packages("RMySQL")
library(RMySQL)
ucscDb=dbConnect(MySQL(),user="genome",
                 host="genome-mysql.cse.ucsc.edu")
result=dbGetQuery(ucscDb,"show databases;"); dbDisconnect(ucscDb);
result



########   Conectandose a hg19 y ver tablas
#Lo siguiente obtiene una lista de tablas en una base de datos específica en el servidor.

hg19=dbConnect(MySQL(),user="genome",db="hg19",
               host="genome-mysql.cse.ucsc.edu")
allTables=dbListTables(hg19)
length(allTables)
allTables[1:5]

######## Dimensiones de una tabla especifica
#dbListFields devuelve una lista de los nombres de campo en una tabla
#dbGetQuery ejecuta una consulta

dbListFields(hg19,"affyU133Plus2")

dbGetQuery(hg19,"select count(*) from affyU133Plus2")



######### Leer desde una tabla
#dbReadTable lee todos los datos de una tabla en un marco de datos.
#Aquí se recomienda precaución, la tabla puede tener una gran cantidad de filas.

affyData=dbReadTable(hg19,"affyU133Plus2")
head(affyData)


######## Elegir un subconjunto específico

#La diferencia entre dbGetQuery y dbSendQuery es que el primero envía la consulta,
#obtiene todos los registros de salida y borra el conjunto de resultados en un 
#solo paso, pero el último no extrae ningún registro; necesitas usar fetch para 
#hacer eso.
#La primera declaración de recuperación a continuación obtiene todos los registros.
#El segundo solicita solo las primeras 10 filas (n = 10).
#El siguiente código parece no ser válido. Muestra dos comandos de recuperación 
#ejecutados en una sola consulta, y no creo que pueda hacerlo.

query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); quantile(affyMis$misMatches)

affyMisSmall <- fetch(query,n=10); dbClearResult(query);
dim(affyMisSmall)

# Don't forget to close the connection!
dbDisconnect(hg19)
