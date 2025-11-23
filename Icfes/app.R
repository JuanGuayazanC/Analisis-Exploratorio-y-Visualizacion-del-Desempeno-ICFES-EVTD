library(shiny)
library(readr)
library(dplyr)
library(ggplot2)

# ---- Cargar el dataset ----
icfes_20201 <- read_csv("icfes_20201.csv")

# ---- Interfaz (UI) ----
ui <- fluidPage(
  
  titlePanel("Análisis ICFES 2020-1"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("genero", "Género:",
                  choices = c("Todos", sort(unique(icfes_20201$ESTU_GENERO)))),
      
      selectInput("estrato", "Estrato:",
                  choices = c("Todos", sort(unique(icfes_20201$FAMI_ESTRATOVIVIENDA)))),
      
      selectInput("libros", "Número de libros:",
                  choices = c("Todos", sort(unique(icfes_20201$FAMI_NUMLIBROS)))),
      
      selectInput("jornada", "Jornada del colegio:",
                  choices = c("Todos", sort(unique(icfes_20201$COLE_JORNADA)))),
      
      selectInput("area", "Variable a graficar:",
                  choices = c("PUNT_LECTURA_CRITICA",
                              "PUNT_MATEMATICAS",
                              "PUNT_C_NATURALES",
                              "PUNT_SOCIALES_CIUDADANAS",
                              "PUNT_INGLES",
                              "PUNT_GLOBAL"))
    ),
    
    mainPanel(
      plotOutput("histograma"),
      tableOutput("tabla")
    )
  )
)

# ---- Servidor (SERVER) ----
server <- function(input, output, session) {
  
  # Reactivo con filtros
  datos_filtrados <- reactive({
    icfes_20201 %>%
      filter(
        (input$genero == "Todos" | ESTU_GENERO == input$genero),
        (input$estrato == "Todos" | FAMI_ESTRATOVIVIENDA == input$estrato),
        (input$libros == "Todos" | FAMI_NUMLIBROS == input$libros),
        (input$jornada == "Todos" | COLE_JORNADA == input$jornada)
      )
  })
  
  # ---- Gráfico ----
  output$histograma <- renderPlot({
    ggplot(datos_filtrados(), aes_string(input$area)) +
      geom_histogram(bins = 30, fill = "steelblue", color = "white") +
      labs(title = paste("Distribución de", input$area),
           x = input$area,
           y = "Frecuencia")
  })
  
  # ---- Tabla ----
  output$tabla <- renderTable({
    head(datos_filtrados(), 20)
  })
}

# ---- Lanzar Shiny ----
shinyApp(ui, server)
