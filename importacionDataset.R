library(readr)
icfes_20201 <- read_csv("icfes_20201.csv")
View(icfes_20201)
names(icfes_20201)
unique(icfes_20201$ESTU_LIMITA_MOTRIZ)
sum(is.na(icfes_20201$COLE_COD_DANE_SEDE))


# Convertir a factor

## Estrato socioeconómico
df$FAMI_ESTRATOVIVIENDA <- factor(
  df$FAMI_ESTRATOVIVIENDA,
  levels = c("Estrato 1", "Estrato 2", "Estrato 3", "Estrato 4", "Estrato 5", "Estrato 6", "Sin Estrato"),
  ordered = TRUE
)

## Educación del padre
df$FAMI_EDUCACIONPADRE <- factor(
  df$FAMI_EDUCACIONPADRE,
  levels = c(
    "Ninguno",
    "Primaria incompleta",
    "Primaria completa",
    "Secundaria (Bachillerato) incompleta",
    "Secundaria (Bachillerato) completa",
    "Técnica o tecnológica incompleta",
    "Técnica o tecnológica completa",
    "Educación profesional incompleta",
    "Educación profesional completa",
    "Postgrado",
    "No sabe",
    "No Aplica"
  ),
  ordered = TRUE
)

## Educación de la madre
df$FAMI_EDUCACIONMADRE <- factor(
  df$FAMI_EDUCACIONMADRE,
  levels = c(
    "Ninguno",
    "Primaria incompleta",
    "Primaria completa",
    "Secundaria (Bachillerato) incompleta",
    "Secundaria (Bachillerato) completa",
    "Técnica o tecnológica incompleta",
    "Técnica o tecnológica completa",
    "Educación profesional incompleta",
    "Educación profesional completa",
    "Postgrado",
    "No sabe",
    "No Aplica"
  ),
  ordered = TRUE
)

## Dedicación diaria a la lectura
df$ESTU_DEDICACIONLECTURADIARIA <- factor(
  df$ESTU_DEDICACIONLECTURADIARIA,
  levels = c(
    "No leo por entretenimiento",
    "30 minutos o menos",
    "Entre 30 y 60 minutos",
    "Entre 1 y 2 horas",
    "Más de 2 horas"
  ),
  ordered = TRUE
)

## Horas semanales de trabajo
df$ESTU_HORASSEMANATRABAJA <- factor(
  df$ESTU_HORASSEMANATRABAJA,
  levels = c(
    "0",
    "Menos de 10 horas",
    "Entre 11 y 20 horas",
    "Entre 21 y 30 horas",
    "Más de 30 horas"
  ),
  ordered = TRUE
)

## Número de libros
df$FAMI_NUMLIBROS <- factor(
  df$FAMI_NUMLIBROS,
  levels = c(
    "0 A 10 LIBROS",
    "11 A 25 LIBROS",
    "26 A 100 LIBROS",
    "MÁS DE 100 LIBROS"
  ),
  ordered = TRUE
)

## Frecuencia de consumo: leche y derivados
df$FAMI_COMELECHEDERIVADOS <- factor(
  df$FAMI_COMELECHEDERIVADOS,
  levels = c(
    "Todos o casi todos los días",
    "3 a 5 veces por semana",
    "1 o 2 veces por semana",
    "Nunca o rara vez comemos eso"
  ),
  ordered = TRUE
)

## Frecuencia de consumo: carne/pescado/huevo
df$FAMI_COMECARNEPESCADOHUEVO <- factor(
  df$FAMI_COMECARNEPESCADOHUEVO,
  levels = c(
    "Todos o casi todos los días",
    "3 a 5 veces por semana",
    "1 o 2 veces por semana",
    "Nunca o rara vez comemos eso"
  ),
  ordered = TRUE
)

## Frecuencia de consumo: cereal/frutas/legumbres
df$FAMI_COMECEREALFRUTOSLEGUMBRE <- factor(
  df$FAMI_COMECEREALFRUTOSLEGUMBRE,
  levels = c(
    "Todos o casi todos los días",
    "3 a 5 veces por semana",
    "1 o 2 veces por semana",
    "Nunca o rara vez comemos eso"
  ),
  ordered = TRUE
)