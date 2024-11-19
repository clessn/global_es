library(shiny)
library(dplyr)
library(tidyr)
library(rjson)
library(DT)
library(ggplot2)

# Charger plusieurs fichiers JSON dans une liste
file_paths <- list.files(path = "_SharedFolder_GlobalES/Dashboard/Canada/json_files/", 
                         pattern = "*.json", full.names = TRUE)

# Lire chaque fichier JSON et les stocker dans une liste nommée, en harmonisant la structure
list_json_data <- lapply(file_paths, function(file) {
  json_data <- fromJSON(file = file)
  
  # Convertir en dataframe, en gérant les cas où le fichier JSON est vide ou a des colonnes manquantes
  if (length(json_data) > 0) {
    df <- as.data.frame(json_data)
    
    # Harmoniser la structure en ajoutant des colonnes manquantes avec NA
    all_columns <- c("source_id.ces65.cleaned", "source_id.ces65.question_label", 
                     "source_id.ces68.cleaned", "source_id.ces68.question_label",
                     # Ajouter ici toutes les colonnes potentielles des JSON
                     "source_id.ces2021.cleaned", "source_id.ces2021.question_label")
    
    missing_columns <- setdiff(all_columns, colnames(df))
    df[missing_columns] <- NA  # Ajouter les colonnes manquantes avec des valeurs NA
    return(df)
  } else {
    return(NULL)  # Retourne NULL pour les fichiers JSON vides
  }
})

# Supprimer les fichiers JSON qui n'ont pas pu être convertis en dataframes (NULL)
list_json_data <- Filter(Negate(is.null), list_json_data)

# Extraire les noms des fichiers pour permettre la sélection
json_names <- basename(file_paths)
json_names <- json_names[sapply(list_json_data, function(df) !is.null(df))]  # Ne garder que les noms des fichiers valides
names(list_json_data) <- json_names

# Interface utilisateur
ui <- fluidPage(
  titlePanel("Visualisation des Données CES"),
  sidebarLayout(
    sidebarPanel(
      selectInput("json_file", "Sélectionner le JSON:", choices = json_names),  # Utiliser les noms des fichiers JSON
      selectInput("year", "Sélectionner l'année:", choices = NULL),  # Remplir dynamiquement
      selectInput("variable", "Sélectionner la variable:", choices = NULL)  # Remplir dynamiquement
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Tableau", DTOutput("dataTable")),
        tabPanel("Graphique", plotOutput("dataPlot"))
      )
    )
  )
)

# Serveur
server <- function(input, output, session) {
  
  # Réactif pour charger les données du fichier JSON sélectionné
  selected_data <- reactive({
    list_json_data[[input$json_file]]  # Sélectionner le fichier JSON selon l'input
  })
  
  observe({
    # Mettre à jour les choix d'année et de variable une fois le fichier JSON chargé
    updateSelectInput(session, "year", choices = unique(selected_data()$année))
    updateSelectInput(session, "variable", choices = unique(selected_data()$variable))
  })
  
  filtered_data <- reactive({
    selected_data() %>%
      filter(année == input$year, variable == input$variable)
  })
  
  output$dataTable <- renderDT({
    datatable(filtered_data())
  })
  
  output$dataPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = value)) +
      geom_bar() +
      labs(title = paste("Distribution de", input$variable, "en", input$year),
           x = input$variable,
           y = "Count")
  })
}

# Lancer l'application Shiny
shinyApp(ui = ui, server = server)
