library(shiny)
library(ggplot2)
library(dplyr)

# Charger les données (assurez-vous que le chemin est correct)
files <- list.files(
  "_SharedFolder_GlobalES/Dashboard/Canada/json_files",
  full.names = TRUE
)

# Parse only non-empty files, handling errors gracefully
json_list <- lapply(files, function(file) {
  tryCatch(
    rjson::fromJSON(file = file),
    error = function(e) NULL # Return NULL if parsing fails
  )
})

unique_source_id_values <- unique(unlist(sapply(json_list, function(json) if (!is.null(json)) names(json$source_id) else NULL)))

unique_source_id_values <- unique_source_id_values[grepl("ces", unique_source_id_values)]

# Create a dataframe with the required structure
result <- do.call(rbind, lapply(unique_source_id_values, function(survey_name) {
  data.frame(
    variable = basename(files), # File names
    ces = survey_name, # Survey name
    cleaned = sapply(json_list, function(json) {
      if (!is.null(json) && "source_id" %in% names(json) && 
          survey_name %in% names(json$source_id) && 
          "cleaned" %in% names(json$source_id[[survey_name]])) {
        json$source_id[[survey_name]]$cleaned
      } else {
        NA
      }
    }),
    stringsAsFactors = FALSE
  )
}))

# Ordre spécifique des CES
ces_order <- c(
  "ces65", "ces68", "ces74", "ces79", "ces84", "ces88", 
  "ces93", "ces97", "ces2000", "ces2004", "ces2006", 
  "ces2008", "ces2011", "ces2015", "ces2019", "ces2021"
)

# Préparer les données pour ggplot2
result_long <- result %>%
  mutate(
    ces = factor(ces, levels = ces_order), # Appliquer l'ordre personnalisé
    cleaned_color = case_when(
      cleaned == 1 ~ "Cleaned",
      cleaned == 0 ~ "À faire",
      is.na(cleaned) ~ "NA"
    )
  )

# Interface utilisateur
ui <- fluidPage(
  titlePanel("Statut des données 'Cleaned' par année et fichier"),
  sidebarLayout(
    sidebarPanel(
      helpText("Visualisez les données 'Cleaned' extraites des fichiers JSON."),
      p("L'ordre des années CES est spécifiquement défini :"),
      verbatimTextOutput("cesOrder")
    ),
    mainPanel(
      plotOutput("statusPlot")
    )
  )
)

# Logique serveur
server <- function(input, output) {
  # Afficher l'ordre des CES dans la barre latérale
  output$cesOrder <- renderText({
    paste(ces_order, collapse = ", ")
  })
  
  # Générer le graphique
  output$statusPlot <- renderPlot({
    ggplot(result_long, aes(x = ces, y = variable, fill = cleaned_color)) +
      geom_tile(color = "white") + # Ajouter des contours blancs pour les cases
      scale_fill_manual(
        values = c("Cleaned" = "lightgreen", "À faire" = "red", "NA" = "gray"),
        name = "Cleaned"
      ) +
      theme_minimal() +
      labs(
        x = "Année (CES)",
        y = "Fichiers JSON",
        title = "Statut des données 'Cleaned' par année et fichier"
      ) +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
  })
}

# Lancer l'application
shinyApp(ui = ui, server = server)

