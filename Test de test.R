library(shiny)
library(dplyr)
library(tidyr)
library(rjson)
library(DT)
library(ggplot2)

# Charger plusieurs fichiers JSON dans une liste
file_paths <- list.files(path = "_SharedFolder_GlobalES/Dashboard/Canada/json_files/", 
                         pattern = "*.json", full.names = TRUE)

# Lire chaque fichier JSON et les stocker dans une liste nommée, en vérifiant la validité des fichiers
list_json_data <- lapply(file_paths, function(file) {
  json_data <- fromJSON(file = file)
  
  # Vérifier si le JSON contient des données valides
  if (length(json_data) > 0) {
    as.data.frame(json_data)
  } else {
    NULL  # Retourne NULL pour les fichiers vides ou mal formés
  }
})

# Supprimer les fichiers JSON qui n'ont pas pu être convertis en dataframes (NULL)
list_json_data <- Filter(Negate(is.null), list_json_data)

# Extraire les noms des fichiers pour permettre la sélection
json_names <- basename(file_paths)
json_names <- json_names[sapply(list_json_data, nrow) > 0]  # Ne garder que les noms des fichiers valides
names(list_json_data) <- json_names


# Lire chaque fichier JSON et les stocker dans une liste nommée
list_json_data <- lapply(file_paths, function(file) {
  fromJSON(file = file) %>% as.data.frame()
})

# Extraire les noms des fichiers pour permettre la sélection
json_names <- basename(file_paths)
names(list_json_data) <- json_names

# Interface utilisateur
ui <- fluidPage(
  titlePanel("Visualisation des Données CES"),
  sidebarLayout(
    sidebarPanel(
      selectInput("json_file", "Sélectionner le JSON:", choices = "canada_feel.json", "canadian_identity.json", "elec_intst.json", "iss_souv.json", "party_id_fed.json", "party_fed_prov.json", "party_id_srtght_fed.json", 
                    "party_id_strght_prov.json", "pol_intst.json", "prob_vote_fed.json", "prob_vote_prov.json", "ses_age_cat.json", "ses_age.json", "ses_area_code.json", "ses_constituency.json", "ses_educ.json", "ses_ethnicity.json",
                    "ses_family_income.json", "ses_gender.json", "ses_lang.json", "ses_main_source.json", "ses_origin_country.json", "ses_personal_income.json", "ses_postal_code.json", "ses_religion.json", "ses_religiosity.json", "ses_years_canada.json",
                    "vote_intent_ca.json", "vote_intent_qc.json"),  # Utiliser les noms des fichiers JSON
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