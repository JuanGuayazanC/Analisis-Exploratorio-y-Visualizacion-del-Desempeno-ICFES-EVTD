library(readr)
icfes <- read_delim("icfes_data.csv", 
                         delim = ";", escape_double = FALSE, trim_ws = TRUE)
View(icfes)
library(robustbase)
library(ggplot2)
library(dplyr)
library(e1071)
library(moments)

# Eliminar puntajes inválidos (0 o NA)
icfes <- subset(icfes, PUNT_GLOBAL > 0 & !is.na(PUNT_GLOBAL))

# ---- ESTU_NACIONALIDAD ----
ggplot(icfes, aes(x = icfes$ESTU_NACIONALIDAD)) +
  geom_bar(fill = "#4C72B0", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  labs(
    title = "Frecuencia de Nacionalidad",
    x = "Países",
    y = "Frecuencia"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 45, hjust = 1)
  )

# Crear variable binaria Colombia / Extranjero
icfes$NAC_BIN <- ifelse(icfes$ESTU_NACIONALIDAD == "COLOMBIA",
                        "Colombia", "Extranjero")

# Convertirla a factor con orden claro
icfes$NAC_BIN <- factor(icfes$NAC_BIN, levels = c("Colombia", "Extranjero"))

# Adjbox con nombres correctos
boxplot(
  PUNT_GLOBAL ~ NAC_BIN,
  data = icfes,
  main = "Diagrama de cajas ajustado",
  xlab = "Nacionalidad",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = c("lightgreen", "lightblue"),
  notch = TRUE
)

nombres <- c("Colombiano", "Extranjero")
adjbox(
  PUNT_GLOBAL ~ NAC_BIN,
  data = icfes,
  main = "Diagrama de cajas ajustado",
  xlab = "Nacionalidad",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = c("lightgreen", "lightblue"),
  notch = TRUE,
  names = nombres
)

adjbox(PUNT_GLOBAL ~ NAC_BIN, data = icfes)
info <- adjbox(PUNT_GLOBAL ~ NAC_BIN, data = icfes)$stats
info
asimetria <- skewness(icfes$NAC_BIN, na.rm = TRUE)
asimetria

# ---- ESTU_GENERO ----
icfes$ESTU_GENERO <- ifelse(is.na(icfes$ESTU_GENERO),
                            "No reporta",
                            icfes$ESTU_GENERO)

icfes$ESTU_GENERO <- factor(icfes$ESTU_GENERO,
                            levels = c("M", "F", "No reporta"),
                            labels = c("Masculino", "Femenino", "No reporta"))

ggplot(icfes, aes(x = ESTU_GENERO, fill = ESTU_GENERO)) +
  geom_bar(color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  scale_fill_manual(values = c(
    "Masculino" = "#4A90E2",
    "Femenino" = "#FF69B4",
    "No reporta" = "#C7C7C7"
  )) +
  labs(
    title = "Frecuencia de Género",
    x = "Género",
    y = "Frecuencia",
    fill = "Categoría"
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 30, hjust = 0.5)
  )

adjbox(
  PUNT_GLOBAL ~ ESTU_GENERO,
  data = icfes,
  main = "Distribución del puntaje global según el género",
  xlab = "Género",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = "lightgreen",
  notch = TRUE
)

info <- adjbox(icfes$ESTU_GENERO)$stats
info

info <- adjbox(icfes$PUNT_GLOBAL)$stats
info

lim_inf <- info[1]
lim_sup <- info[5]

lim_inf
lim_sup

# Valores atípicos
atip <- adjbox(icfes_col$PUNT_GLOBAL)$out
atip



# ---- FAMI_ESTRATOVIVIENDA ----
ggplot(icfes, aes(x = FAMI_ESTRATOVIVIENDA)) +
  geom_bar(fill = "red", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  labs(
    title = "Frecuencia de Estrato Vivienda",
    x = "Estrato",
    y = "Frecuencia",
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 30, hjust = 0.5)
  )

# 1) Seleccionar SOLO los niveles que quieres
niveles_seleccionados <- c(
  "Educación profesional completa",
  "Secundaria (Bachillerato) completa",
  "Primaria completa",
  "Técnica o tecnológica completa"
)

# 2) Filtrar el dataset
icfes_filtrado <- subset(
  icfes,
  FAMI_EDUCACIONPADRE %in% niveles_seleccionados &
    !is.na(FAMI_EDUCACIONPADRE) &
    !is.na(PUNT_GLOBAL)
)

# 3) Limpiar niveles vacíos
icfes_filtrado$FAMI_EDUCACIONPADRE <- droplevels(icfes_filtrado$FAMI_EDUCACIONPADRE)

# 4) Gráfico adjbox
adjbox(
  PUNT_GLOBAL ~ FAMI_EDUCACIONPADRE,
  data = icfes_filtrado,
  main = "Distribución del puntaje global según nivel educativo del padre",
  xlab = "Nivel educativo del padre",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = "lightgreen",
  notch = TRUE
)

info <- adjbox(PUNT_GLOBAL ~ FAMI_ESTRATOVIVIENDA, data = icfes)$stats

# Medianas por estrato (fila 3)
medianas <- info[3, ]
medianas


# ---- FAMI_EDUCACIONPADRE ----
ggplot(icfes, aes(x = FAMI_EDUCACIONPADRE)) +
  geom_bar(fill = "blue", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  labs(
    title = "Frecuencia de Educación del Padre",
    x = "Educación del Padre",
    y = "Frecuencia",
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 90, hjust = 1)
  )

sort(table(icfes$FAMI_EDUCACIONPADRE), decreasing = TRUE)

# ---- FAMI_EDUCACIONMADRE ----
ggplot(icfes, aes(x = FAMI_EDUCACIONMADRE)) +
  geom_bar(fill = "blue", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  labs(
    title = "Frecuencia de Educación del Madre",
    x = "Educación del Madre",
    y = "Frecuencia",
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 90, hjust = 1)
  )
# 1) Seleccionar SOLO los niveles que quieres
niveles_seleccionados <- c(
  "Educación profesional completa",
  "Secundaria (Bachillerato) completa",
  "Primaria completa",
  "Técnica o tecnológica completa"
)

# 2) Filtrar el dataset
icfes_filtrado <- subset(
  icfes,
  FAMI_EDUCACIONMADRE %in% niveles_seleccionados &
    !is.na(FAMI_EDUCACIONMADRE) &
    !is.na(PUNT_GLOBAL)
)

# 3) Limpiar niveles vacíos
icfes_filtrado$FAMI_EDUCACIONMADRE <- droplevels(icfes_filtrado$FAMI_EDUCACIONMADRE)

# 4) Gráfico adjbox
adjbox(
  PUNT_GLOBAL ~ FAMI_EDUCACIONMADRE,
  data = icfes_filtrado,
  main = "Distribución del puntaje global según nivel educativo de la Madre",
  xlab = "Nivel educativo de la Madre",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)


# ---- FAMI_TIENEINTERNET ----
ggplot(icfes, aes(x = FAMI_TIENEINTERNET, fill = FAMI_TIENEINTERNET)) +
  geom_bar(color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  scale_fill_manual(values = c(
    "Si" = "#4A90E2",
    "No" = "#FF69B4",
    "No reporta" = "#C7C7C7"
  )) +
  labs(
    title = "Frecuencia de Familias que poseen Internet",
    x = "Familias",
    y = "Frecuencia",
    fill = "Categoría"
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 30, hjust = 0.5)
  )

adjbox(PUNT_GLOBAL ~ ESTU_NACIONALIDAD, data = icfes,
       main="Puntaje global según nacionalidad", notch=TRUE)

boxplot(
  PUNT_GLOBAL ~ FAMI_TIENEINTERNET,
  data = icfes,
  main = "Diagrama de cajas (Boxplot)",
  xlab = "¿Tiene internet?",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = "lightgreen",
  notch = TRUE
)

nombres <- c("No", "Si")

adjbox(
  PUNT_GLOBAL ~ FAMI_TIENEINTERNET,
  data = icfes,
  main = "Diagrama de cajas ajustado (Adjbox)",
  xlab = "¿Tiene internet?",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = "lightgreen",
  notch = TRUE,
  names = nombres
)

adjbox(PUNT_GLOBAL ~ FAMI_TIENEINTERNET, data = icfes)
info <- adjbox(PUNT_GLOBAL ~ FAMI_TIENEINTERNET, data = icfes)$stats
info

# ---- FAMI_TIENECOMPUTADOR ----
ggplot(icfes, aes(x = FAMI_TIENECOMPUTADOR, fill = FAMI_TIENECOMPUTADOR)) +
  geom_bar(color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  scale_fill_manual(values = c(
    "Si" = "#4A90E2",
    "No" = "#FF69B4",
    "No reporta" = "#C7C7C7"
  )) +
  labs(
    title = "Frecuencia de Familias que poseen Computador",
    x = "Familias",
    y = "Frecuencia",
    fill = "Categoría"
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 30, hjust = 0.5)
  )

adjbox(PUNT_GLOBAL ~ ESTU_NACIONALIDAD, data = icfes,
       main="Puntaje global según nacionalidad", notch=TRUE)

adjbox(
  PUNT_GLOBAL ~ FAMI_TIENECOMPUTADOR,
  data = icfes,
  main = "Distribución del puntaje global según si tiene computador",
  xlab = "Categoría",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)

# ---- FAMI_NUMLIBROS ----
ggplot(icfes, aes(x = FAMI_NUMLIBROS)) +
  geom_bar(fill = "green", color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  labs(
    title = "Frecuencia de Número de Libros por Familia",
    x = "Familias",
    y = "Frecuencia",
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 20, hjust = 0.7)
  )

# Adjbox con nombres correctos
boxplot(
  PUNT_GLOBAL ~ FAMI_NUMLIBROS,
  data = icfes,
  main = "Diagrama de cajas ajustado",
  xlab = "Nacionalidad",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = c("lightgreen", "lightblue", "yellow", "red"),
  notch = TRUE
)

nombres <- c("0 a 10 Libros", "11 a 25 Libros", "26 a 100 Libros", "Más de 100 Libros")
adjbox(
  PUNT_GLOBAL ~ FAMI_NUMLIBROS,
  data = icfes,
  main = "Diagrama de cajas ajustado",
  xlab = "Cantidad de Libros en el hogar",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = c("lightgreen", "lightblue", "yellow", "red"),
  notch = TRUE,
  names = nombres
)

# ---- COLE_AREA_UBICACION ----
ggplot(icfes, aes(x = COLE_AREA_UBICACION, fill = COLE_AREA_UBICACION)) +
  geom_bar(color = "black") +
  geom_text(stat = "count", aes(label = ..count..), 
            vjust = -0.5, size = 4, color = "black") +
  scale_fill_manual(values = c(
    "URBANO" = "lightgreen",
    "RURAL" = "darkgreen"
  )) +
  labs(
    title = "Frecuencia por Área de Ubicación del Colegio",
    x = "Área del Colegio",
    y = "Frecuencia",
    fill = "Categoría"
  ) +
  theme_minimal(base_size = 20) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.text.x = element_text(angle = 30, hjust = 0.5)
  )


adjbox(
  PUNT_GLOBAL ~ COLE_AREA_UBICACION,
  data = icfes,
  main = "Distribución del puntaje global según zona habitada",
  xlab = "Categorías",
  ylab = "Puntaje global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)

# ---- PUNT_LECTURA_CRITICA ----
ggplot(icfes, aes(x = PUNT_LECTURA_CRITICA)) +
  geom_histogram(aes(y = ..density..),
                 bins = 30,
                 fill = "#1E90FF",
                 color = "black",
                 alpha = 0.7) +
  geom_density(color = "red", size = 1.2) +
  theme_minimal(base_size = 14) +
  labs(
    title = "Distribución del Puntaje de Lectura Crítica",
    x = "Puntaje",
    y = "Densidad"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

adjbox(
  icfes$PUNT_LECTURA_CRITICA,
  main = "Diagrama de cajas ajustado de Lectura Crítica",
  ylab = "Puntaje Global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)
asimetria <- skewness(icfes$PUNT_LECTURA_CRITICA, na.rm = TRUE)
asimetria
kurtosis(icfes$PUNT_LECTURA_CRITICA, na.rm = TRUE)

# ---- PUNT_C_NATURALES ----
ggplot(icfes, aes(x = PUNT_C_NATURALES)) +
  geom_histogram(aes(y = ..density..),
                 bins = 30,
                 fill = "#8590FF",
                 color = "black",
                 alpha = 0.7) +
  geom_density(color = "red", size = 1.2) +
  theme_minimal(base_size = 14) +
  labs(
    title = "Distribución del Puntaje de Ciencias Naturales",
    x = "Puntaje",
    y = "Densidad"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

adjbox(
  icfes$PUNT_C_NATURALES,
  main = "Diagrama de cajas ajustado de Ciencias Naturales",
  ylab = "Puntaje Global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)
asimetria <- skewness(icfes$PUNT_C_NATURALES, na.rm = TRUE)
asimetria
kurtosis(icfes$PUNT_C_NATURALES, na.rm = TRUE)

# ---- PUNT_SOCIALES_CIUDADANAS ----
ggplot(icfes, aes(x = PUNT_SOCIALES_CIUDADANAS)) +
  geom_histogram(aes(y = ..density..),
                 bins = 30,
                 fill = "#21A4B2",
                 color = "black",
                 alpha = 0.7) +
  geom_density(color = "red", size = 1.2) +
  theme_minimal(base_size = 14) +
  labs(
    title = "Distribución del Puntaje de Ciencias Sociales",
    x = "Puntaje",
    y = "Densidad"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

adjbox(
  icfes$PUNT_SOCIALES_CIUDADANAS,
  main = "Diagrama de cajas ajustado de Ciencias Sociales",
  ylab = "Puntaje Global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)
asimetria <- skewness(icfes$PUNT_SOCIALES_CIUDADANAS, na.rm = TRUE)
asimetria
kurtosis(icfes$PUNT_SOCIALES_CIUDADANAS, na.rm = TRUE)

# ---- PUNT_INGLES ----
ggplot(icfes, aes(x = PUNT_INGLES)) +
  geom_histogram(aes(y = ..density..),
                 bins = 30,
                 fill = "#21B522",
                 color = "black",
                 alpha = 0.7) +
  geom_density(color = "red", size = 1.2) +
  theme_minimal(base_size = 14) +
  labs(
    title = "Distribución del Puntaje de Inglés",
    x = "Puntaje",
    y = "Densidad"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

adjbox(
  icfes$PUNT_INGLES,
  main = "Diagrama de cajas ajustado del Ingles",
  ylab = "Puntaje Global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)
asimetria <- skewness(icfes$PUNT_INGLES, na.rm = TRUE)
asimetria
kurtosis(icfes$PUNT_INGLES, na.rm = TRUE)

# ---- PUNT_MATEMATICAS ----
adjbox(
  icfes$PUNT_MATEMATICAS,
  main = "Diagrama de cajas ajustado de Matemáticas",
  ylab = "Puntaje Global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)
asimetria <- skewness(icfes$PUNT_MATEMATICAS, na.rm = TRUE)
asimetria
kurtosis(icfes$PUNT_MATEMATICAS, na.rm = TRUE)
# ---- PUNT_GLOBAL ----
ggplot(icfes, aes(x = PUNT_GLOBAL)) +
  geom_histogram(aes(y = ..density..),
                 bins = 30,
                 fill = "#FD623A",
                 color = "black",
                 alpha = 0.7) +
  geom_density(color = "red", size = 1.2) +
  theme_minimal(base_size = 14) +
  labs(
    title = "Distribución del Puntaje Global",
    x = "Puntaje",
    y = "Densidad"
  ) +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5)
  )

adjbox(
  icfes$PUNT_GLOBAL,
  main = "Diagrama de cajas ajustado del Puntaje Global",
  ylab = "Puntaje Global (Saber 11 - 2020)",
  col = "lightblue",
  notch = TRUE
)
info <- adjbox(icfes$PUNT_GLOBAL)$stats
info

lim_inf <- info[1]
lim_sup <- info[5]

lim_inf
lim_sup

kurtosis(icfes$PUNT_GLOBAL, na.rm = TRUE)
asimetria <- skewness(icfes$PUNT_GLOBAL, na.rm = TRUE)
asimetria



library(robustbase)  # por si ajdbox no está cargado

par(mfrow = c(1,5))  # para poner las 5 cajas en una fila

adjbox(
  icfes$PUNT_LECTURA_CRITICA,
  main = "Lectura Crítica",
  ylab = "Puntaje",
  col = "lightblue",
  notch = TRUE
)

adjbox(
  icfes$PUNT_MATEMATICAS,
  main = "Matemáticas",
  ylab = "Puntaje",
  col = "lightgreen",
  notch = TRUE
)

adjbox(
  icfes$PUNT_SOCIALES_CIUDADANAS,
  main = "Sociales",
  ylab = "Puntaje",
  col = "lightyellow",
  notch = TRUE
)

adjbox(
  icfes$PUNT_INGLES,
  main = "Inglés",
  ylab = "Puntaje",
  col = "lightpink",
  notch = TRUE
)

adjbox(
  icfes$PUNT_C_NATURALES,
  main = "Ciencias Naturales",
  ylab = "Puntaje",
  col = "lightcoral",
  notch = TRUE
)

par(mfrow = c(1,1))  # restaurar formato normal

