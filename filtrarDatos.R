library(readr)
library(dplyr)

# Leer el archivo original y filtrar los datos de Bogotá
df_bogota <- read_csv("icfes_data.csv")
  filter(Ciudad == "Bogotá")

# Guardar el subconjunto en un nuevo archivo CSV
write_csv(df_bogota, "data/icfes/icfes_bogota.csv")


library(readr)
icfes_data <- read_delim("icfes_data.csv", 
                         delim = "\t", escape_double = FALSE, 
                         trim_ws = TRUE)
View(icfes_data)
install.packages("corrplot")
