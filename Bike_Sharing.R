# Librerías
library(dplyr)
library(tidyr)
library(ggplot2)
library(readr)
library(tidyverse)

#Carga de datos
setwd("C:/Users/natha/OneDrive/Desktop/MASTER - DS/2. TECNICAS DE ANALISIS ESTADISTICO/Data")
bikes<- read.csv("bikes.csv", header=TRUE, sep=",", dec=".", fileEncoding = "UTF-8")

#Detalle de los datos
str(bikes)
summary(bikes)

#NAs en el set de datos
bikes %>%
  summarise_all(.funs = ~ sum(is.na(.)))
#No hay valores faltantes


# Variables numéricas
# Histogramas 

# 1. número de bicicletas alquiladas
alquiler <-bikes %>%
  summarise(
    media = mean(cnt),
    mediana = median(cnt),
    media_winsorizada = mean(cnt, trim = 0.1),
    desviacion_tipica = sd(cnt),
    varianza = var(cnt),
    IQR = IQR(cnt),
    maximo = max(cnt),
    minimo = min(cnt))

bikes %>%
  ggplot() +
  geom_histogram(aes(x =  cnt)) +
  theme_light() +
  geom_vline(
    data = alquiler %>%
      select(media, mediana, media_winsorizada, maximo, minimo) %>%
      pivot_longer(everything(), names_to = "Estadísticos de localización"),
    aes(xintercept = value, col = `Estadísticos de localización`), size = 1.5
  )

bikes %>%
  ggplot() +
  ggdist::stat_halfeye(aes(y = cnt), adjust = .5, width = .3, .width = 0, justification = -.3) +
  geom_boxplot(aes(y = cnt),width = .1) +
  gghalves::geom_half_point(aes(y = cnt), side = "l", range_scale = .4, alpha = .5) +
  theme_light()





# Siendo la media  4504.349, la mediana 4548, podemos decir que la distribucion es  ligeramente asimetrica negativa, sin embargo en el histograma es poco perceptible,  por lo que La distribución normal parece ser una buena aproximación.
# Los valores mas habituales estan dentro de la franja entre 2274 y 6822
# No se observan outliers



# 2. Humedad
humedad <-bikes %>%
  summarise(
    media = mean(hum),
    mediana = median(hum),
    media_winsorizada = mean(hum, trim = 0.1),
    desviacion_tipica = sd(hum),
    varianza = var(hum),
    IQR = IQR(hum),
    maximo = max(hum),
    minimo = min(hum))

bikes %>%
  ggplot() +
  geom_histogram(aes(x =  hum)) +
  theme_light() +
  geom_vline(
    data = humedad %>%
      select(media, mediana, media_winsorizada, maximo, minimo) %>%
      pivot_longer(everything(), names_to = "Estadísticos de localización"),
    aes(xintercept = value, col = `Estadísticos de localización`), size = 1.5
  )

#Se muestran dos valores raros donde la humedad era por debajo de 0.18 y 0.00000 
#y que normalmente se concentra entre 0.40 y 0.75


# 3. Temperatura 
temperatura <-bikes %>%
  summarise(
    media = mean(temp),
    mediana = median(temp),
    media_winsorizada = mean(temp, trim = 0.1),
    desviacion_tipica = sd(temp),
    varianza = var(temp),
    IQR = IQR(temp),
    maximo = max(temp),
    minimo = min(temp))

bikes %>%
  ggplot() +
  geom_histogram(aes(x =  temp)) +
  theme_light() +
  geom_vline(
    data = temperatura %>%
      select(media, mediana, media_winsorizada, maximo, minimo) %>%
      pivot_longer(everything(), names_to = "Estadísticos de localización"),
    aes(xintercept = value, col = `Estadísticos de localización`), size = 1.5
  )

bikes %>%
  ggplot() +
  ggdist::stat_halfeye(aes(y = temp), adjust = .5, width = .3, .width = 0, justification = -.3, color = "blue") +
  geom_boxplot(aes(y = temp),width = .1) +
  gghalves::geom_half_point(aes(y = temp), side = "l", range_scale = 0.6, alpha = 0.5, color = "blue") +
  theme_light()

#Se realiza un grafico con un bandwith para observar que existe un subgrupo en la variable temperatura, 
#hay temperaturas bajas inferiores a 0.50 y altas superiores a 0.50
bikes %>%
  ggplot() +
  geom_histogram(mapping = aes(x =  temp),binwidth = 0.05)


#Velocidad del viento
viento <-bikes %>%
  summarise(
    media = mean(windspeed),
    mediana = median(windspeed),
    media_winsorizada = mean(windspeed, trim = 0.1),
    desviacion_tipica = sd(windspeed),
    varianza = var(windspeed),
    IQR = IQR(windspeed),
    maximo = max(windspeed),
    minimo = min(windspeed))

bikes %>%
  ggplot() +
  geom_histogram(aes(x =  windspeed)) +
  theme_light() +
  geom_vline(
    data = viento %>%
      select(media, mediana, media_winsorizada, maximo, minimo) %>%
      pivot_longer(everything(), names_to = "Estadísticos de localización"),
    aes(xintercept = value, col = `Estadísticos de localización`), size = 1.5
  )

#Se muestran 


#Situacion meteorologica
bikes %>%
  ggplot() +
  ggdist::stat_halfeye(aes(y = weathersit), adjust = .5, width = .3, .width = 0, justification = -.3) +
  geom_boxplot(aes(y = weathersit),width = .1) +
  gghalves::geom_half_point(aes(y = weathersit), side = "l", range_scale = .4, alpha = .5) +
  theme_light()

#Scatterplot de la variable count con el resto de variables numericas
bikes %>%
  select_if(is.numeric) %>% 
  pivot_longer(-cnt, names_to = "variable", values_to = "valor") %>%
  ggplot() + 
  geom_point(aes(y = cnt, x = valor)) + 
  facet_wrap(~ variable, scales = "free_x")

# 1. Mientras mas usuarios hay registrados, mas bicletas son rentadas
# 2. Cuando la velocidad del viento es mayor a 0.4 normalmente no se rentan bicicletas
# 3. 


#Correlacion de Pearson entre las variables numericas
bikes %>%
  select_if(is.numeric) %>%
  cor()%>%
  round(2)

bikes %>%
  select_if(is.numeric) %>%
  cor() %>%
  round(2) %>%
  ggcorrplot::ggcorrplot(hc.order = TRUE, 
           lab = TRUE)
# Visualizamos inicialmente la correlación de las variables de estudio
# Observamos la alta correlación entre la temperatura(temp) y la sensación térmica(atemp) de 0.99.
# Existe tambien una alta correlacion (0.95) entre la cantidad de bicicletas alquilada (cnt) y los usuarios registrados (registred) mientras que la correlacion entre la cantidad de bicicletas alquilas y los usuarios casuales es menor siendo ésta de un 0.67
# La humedad y la velocidad del viento también están ligeramente correlacionadas.
# Se evidencia una correlación media positiva entre el numero de alquiler de bicicletas con la temperatura 
# una relación débil negativa entre el alquiler y la humedad.
# vemos una correlacion negativa de 0.52 entre los usuarios casuales y los dias laborales, es decir, normalmente estos usuarios no alquilan las bicicletas los dias se semana (L-V)


#Correlación de Spearman
spearman = bikes %>%
           select_if(is.numeric) %>%
           cor(method = "spearman") %>%
           round(2) %>%
           ggcorrplot::ggcorrplot(hc.order = TRUE, 
                                   lab = TRUE)
#Correlación de pearson
pearson = bikes %>%
  select_if(is.numeric) %>%
  cor(method = "pearson") %>%
  round(2) %>%
  ggcorrplot::ggcorrplot(hc.order = TRUE, 
                         lab = TRUE)

#Correlación de kendall
kendall = bikes %>%
  select_if(is.numeric) %>%
  cor(method = "kendall") %>%
  round(2) %>%
  ggcorrplot::ggcorrplot(hc.order = TRUE, 
                         lab = TRUE)


#Vemos como cambia la correlacion de las variables con el test de correlacion
cor.test(bikes$cnt, bikes$workingday, method = "pearson")
cor.test(bikes$cnt, bikes$workingday, method = "spearman")
cor.test(bikes$cnt, bikes$workingday, method = "kendall")

cor.test(bikes$cnt, bikes$weekday, method = "pearson")
cor.test(bikes$cnt, bikes$weekday, method = "spearman")
cor.test(bikes$cnt, bikes$weekday, method = "kendall")


#se ha acentuado la correlación con cnt y las relacionadas con la madre mheight y mppwt.



###########################Variables Categoricas
#variables season 
bikes$season <- factor(format(bikes$season),
                          levels = c("1","2","3","4") , labels = c("Spring","Summer","Fall","Winter"))
table(bikes$season)

#Variable year
bikes$yr <- factor(format(bikes$yr),
                      levels = c("0", "1") , labels = c("2011","2012"))
table(bikes$yr)

#Variable Viento
bikes$weathersit <- factor(format(bikes$weathersit),
                              levels = c("1", "2","3","4") , 
                              labels = c("Good","Moderate","Bad","Worse"))
table(bikes$weathersit)

#Variable workingday
bikes$workingday <- factor(format(bikes$workingday),
                        levels = c("0", "1") , labels = c("Holiday","Working Day"))
table(bikes$workingday)

#Variable holiday
bikes$holiday <- factor(format(bikes$holiday),
                           levels = c("0", "1") , labels = c("Working Day","Holiday"))
table(bikes$holiday)

#Variable weekday
as.factor(bikes$weekday)
bikes$weekday <- factor(format(bikes$weekday),
                        levels = c("0", "1", "2", "3", "4","5","6") , 
                        labels = c("Dom","Lun", "Mar", "Mie", "Jue","Vie", "Sab"))
table(bikes$weekday)

#Variable month
as.factor(bikes$mnth)
bikes$mnth <- factor(format(bikes$mnth),
                     levels = c(" 1"," 2"," 3", " 4", " 5", " 6", " 7", " 8", " 9", "10", "11", "12"), 
                     labels = c("Ene","Feb", "Mar", "Abr", "May","Jun","Jul","Ago","Sep","Oct","Nov", "Dic"))
#Variable dteday
as.Date(bikes$dteday)



bikes %>% ggplot(aes(workingday, fill = workingday)) + geom_bar()
bikes %>% ggplot(aes(yr, fill = yr)) + geom_bar()
bikes %>% ggplot(aes(season, fill = season)) + geom_bar()
bikes %>% ggplot(aes(holiday, fill = holiday)) + geom_bar()
bikes %>% ggplot(aes(weathersit, fill = weathersit)) + geom_bar()
bikes %>% ggplot(aes(mnth, fill =mnth)) + geom_bar()
bikes %>% ggplot(aes(weekday, fill= weekday)) + geom_bar()




bikes %>%
  ggplot() +
  geom_boxplot(aes(y = hum)) +
  theme_light()


##Selecciono las variables numericas
bikes %>%
  select_if(is.numeric) %>% head
  pivot_longer(-charges, names_to = "variables", values_to= "valor") %>%
  ggplot() +
  geom_point(eas(y = , x = valor))+
  facet_wrap(~variable, scales = "free_x")
  
  
##Season 
  bikes %>%
    ggplot() + 
    geom_boxplot(aes(x = season, y = cnt, fill = season))
 
  
##Weekday 
  bikes %>%
    ggplot() + 
    geom_boxplot(aes(x = weekday, y = cnt, fill = weekday))  
  
  ##Month 
  
  bikes %>%
    ggplot() + 
    geom_boxplot(aes(x = mnth, y = cnt, fill = mnth))  
  
    
  ##Mejor grafico para variables categoricas es el boxplot
  
  
  ##Se realiza el calculo con un nivel de confianza del 95%
  

  
  #Media del Precio
  mm <- mean(bikes$cnt)
  
  #Desviacion Estandar
  dm = sd(bikes$cnt)
  
  #Nivel de confianza que queremos obtener
  p = 0.95
  
  #Tama?o del intervalo
  error= qnorm(1- (1-p)/2) *dm/sqrt(117)
  
  #Extremos
  Primer_Int <- mm-error
  Primer_Int
  
  Segundo_Int <- mm+error
  Segundo_Int
  
  ###Comprobacion del intervalo 90%   23800.45 28138.49
  t.test(bikes$cnt, conf.level = 0.95)
  
  
  
  bikes %>%
    ggplot() + 
    geom_boxplot(aes(x = workingday, y = cnt, fill = workingday))  
  
  
  Equipo_A = runif(n = 10000, min = 0, max = 7)
  Equipo_B = runif(n = 10000, min = 0, max = 7)
  
  c(10, 0) - c(10,5)
  
  Equipo_A - Equipo_B
  Equipo_B - EEquipo_A
  mean(abs(Equipo_A -Equipo_B) >= 4)

  #------------------------------------------------------------------------
  partidos = function() {
    juego = c() 
    rondas = 7
    while (length(juego) != 4) {
      nuevo_juego = sample(1:7, 1)
      juego = c(juego , nuevo_juego)
      juego = unique(juego)
      rondas = rondas + 1
    }
    return(rondas)
  }
  partidos()
  
  numero_juegos = replicate(10000, partidos())
  hist(numero_juegos)
  mean(numero_juegos)
  max(numero_juegos)
  
  
  