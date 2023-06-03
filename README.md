# Sistemas Bike Sharing


## Dataset

- [Dataset](https://archive.ics.uci.edu/ml/datasets/bike+sharing+dataset)

##  Analítica de datos


### Contexto
Los sistemas de Bike Sharing son variantes del alquiler tradicional de bicicletas, donde el proceso de alquiler y devolución está muy automatizado. Por lo general, las bicicletas se pueden alquilar en un lugar y devolver en otro sin tener que lidiar con un humano.
Actualmente hay varios cientos de programas para compartir bicicletas en diferentes ciudades, y un gran interés en su potencial.
Nos contacta una empresa de alquiler de bicicletas que le gustaría predecir el nivel diario de alquiler de bicicletas a partir de variables ambientales y estacionales.
 
## Preguntas
 **Se Realiza un análisis de las variables numéricas univariantemente y se responde con gráficos a las siguientes preguntas:**
 - ¿Se distribuyen simétricamente?
 - ¿Existe algún outlier?
 - ¿Puedes dar un buen estimador de localización de las variables? 
 - ¿Está la variable windspeed distribuida normalmente? 

 **Estudio de Variables categóricas:**
Recuerda que el **objetivo del negocio es aumentar sus ingresos** así que querremos estudiar las relaciones con la variable count.
 - Gráficos de barras para visualizar que niveles hay más en cada una de las categorías. 
 - Relación bivariante en las variables numéricas. 
 - Scatterplot de cada variable contra count.
 - ¿Se cree probable alguna interacción en base a los gráficos?
 - Distintos métodos de correlación y sus resultados.
 - 
 **Relaciones temporales:**
En datos temporales, normalmente podemos encontrar tendencias; según pasa el tiempo, aumenta o disminuyen los alquileres y también estacionalidades; las personas pueden coger más la bici los fines de semana que entre semana, por día de la semana… Estudia estas relaciones con un gráfico de cajas (como si fuera categórica). ¿Encuentras tendencias o estacionalidad en los datos? ¿Hay diferencia estadística con un α=0.05α=0.05 para asegurar que hay menos alquileres en fin de semana que entre semana?
 **Interacciones:** tanto en la relación con registered como con temp hay una interacción clara. Encuentra estas variables y representalo de un modo visual.

 **Extra :** ¿Ha cambiado el hábito de consumo de los clientes de un año a otro en cuanto a coger la bici los fines de semana?
 
 **Problema de probabilidad**
Hallar probabilidades con experimentos:
 - 	Creamos una función para un experimento
 - 	Lo repetimos muchas veces
 -  Hallamos la probabilidad
 
**Problema**
Dos equipos jugarán un partido al mejor de 7 (el partido terminará tan pronto como cualquiera de los equipos haya ganado 4 juegos). Cada juego termina con una victoria para un equipo y una derrota para el otro equipo.
Suponga que cada equipo tiene la misma probabilidad de ganar cada juego y que los juegos que se juegan son independientes.
Encuentre la media y la varianza del número de juegos jugados.
