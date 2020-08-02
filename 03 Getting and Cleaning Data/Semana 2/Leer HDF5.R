######## HDF5

#Se utiliza para almacenar grandes conjuntos de datos.
#Admite el almacenamiento de una variedad de tipos de datos.
#Formato de datos jerárquicos (HDF)
#grupos que contienen cero o más conjuntos de datos y metadatos
#Tener un encabezado de grupo con el nombre del grupo y la lista de atributos
#Tener una tabla de símbolos grupales con una lista de objetos en grupo
#conjuntos de datos matriz multidimensional de elementos de datos con metadatos
#Tener un encabezado con nombre, tipo de datos, espacio de datos y diseño de almacenamiento
#Tener una matriz de datos con los datos.

### Paquete R HDF5
if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("rhdf5")

library(rhdf5)
if (file.exists("example.h5")) {
  file.remove("example.h5")
}
created = h5createFile("example.h5")
created


#Crear grupos

#La función h5createGroup manipula un archivo HDF5 existente, creando grupos
#dentro de él.
#El comando h5ls es un poco como el comando bash ls, excepto que enumera los 
#grupos (que parecen rutas) dentro de un archivo HDF5.
#Tenga en cuenta que si los grupos ya existen en el archivo HDF5, no se 
#sobrescriben; en cambio, la salida indica que ya existen.

created = h5createGroup("example.h5", "foo")
created = h5createGroup("example.h5", "baa")
created = h5createGroup("example.h5", "foo/foobaa")
h5ls("example.h5")


#######Escribir a grupos

#El comando h5write escribe cualquier estructura de datos R en un archivo y 
#grupo específicos

A <- matrix(1:10, nr = 5, nc = 2)
h5write(A, "example.h5", "foo/A")
B = array(seq(0.1, 2, by = 0.1), dim = c(5, 2, 2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5", "foo/foobaa/B")
h5ls("example.h5")


#### Escribir un conjunto de datos

#El siguiente ejemplo crea un marco de datos y lo escribe en la parte superior 
#de la jerarquía del archivo HDF5, utilizando el nombre "df".

df = data.frame(1L:5L, seq(0, 1, length.out = 5), c("ab", "cde", "fghi", "a", 
                                                    "s"), stringsAsFactors = F)
h5write(df, "example.h5", "df")
h5ls("example.h5")


######Lectura de datos

#La función h5read lee desde un punto especificado en un archivo HDF5. He
#agregado al siguiente ejemplo de video para mostrar que puede leer no solo las
#estructuras de datos que escribió en el archivo, sino también las rutas. 
#Entonces "foo" es una lista, que contiene A (una matriz) y foobaa 
#(un subpath en el archivo HDF5, que en R tendrá otra lista).

readA = h5read("example.h5", "foo/A")
readB = h5read("example.h5", "foo/foobaa/B")
readdf = h5read("example.h5", "df")
readA

######Escribir y leer fragmentos

#Podemos escribir o leer desde subconjuntos de estructuras de datos en archivos
#HDF5.

h5write(c(12, 13, 14), "example.h5", "foo/A", index = list(1:3, 1))
h5read("example.h5", "foo/A")
