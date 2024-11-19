library(shiny)
library(dplyr)
library(tidyr)
library(rjson)
library(DT)
library(ggplot2)

# Charger les données
file_path <- "_SharedFolder_GlobalES/Dashboard/Canada/json_files/ses_lang.json"
mesdonnees <- fromJSON(file = file_path)
df_donnees <- as.data.frame(mesdonnees)

# Liste des variables "ces" à regrouper
ces_variables <- c("ces65", "ces68", "ces74", "ces79", "ces84", "ces88", 
                   "ces93", "ces97", "ces2000", "ces2004", "ces2006", 
                   "ces2008", "ces2011", "ces2015", "ces2019", "ces2021")

# Réorganiser les colonnes pour chaque variable "ces"
reorder_columns <- function(df, ces_vars) {
  for (ces in ces_vars) {
    ces_columns <- paste0("source_id.", ces, c(".class", ".cleaned", ".question_label", ".raw_variable"))
    existing_columns <- intersect(ces_columns, colnames(df))
    df <- df %>% select(all_of(existing_columns), everything())
  }
  return(df)
}

df_donnees <- reorder_columns(df_donnees, ces_variables)

# Convertir toutes les colonnes en caractères
df_donnees <- df_donnees %>% mutate(across(everything(), as.character))

# Pivoter chaque groupe de colonnes CES séparément et ajouter l'année
pivot_and_add_year <- function(df, ces_var) {
  ces_columns <- paste0("source_id.", ces_var, c(".class", ".cleaned", ".question_label", ".raw_variable"))
  df_long <- df %>%
    select(all_of(ces_columns)) %>%
    pivot_longer(cols = everything(), 
                 names_to = "variable", 
                 values_to = "value") %>%
    mutate(année = as.integer(sub("ces", "", ces_var)))
  return(df_long)
}

# Appliquer la fonction à chaque variable CES et combiner les résultats
df_long_combined <- lapply(ces_variables, function(var) pivot_and_add_year(df_donnees, var)) %>%
  bind_rows()

# Interface utilisateur
ui <- fluidPage(
  titlePanel("Visualisation des Données CES"),
  sidebarLayout(
    sidebarPanel(
      selectInput("year", "Sélectionner l'année:", choices = unique(df_long_combined$année)),
      selectInput("variable", "Sélectionner la variable:", choices = unique(df_long_combined$variable))
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
server <- function(input, output) {
  filtered_data <- reactive({
    df_long_combined %>%
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