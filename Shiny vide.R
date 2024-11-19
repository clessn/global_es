library(shiny)
library(rjson)
library(DT)

# Exemple de données JSON pour tester
json_data <- list(
  name = "John",
  age = 30,
  city = "New York"
)
write(toJSON(json_data), "test.json")

shinyApp(
  ui = fluidPage(
    fileInput("Json", "Choose Json File",
              multiple = FALSE,
              accept = c(".json")),
    DTOutput('tbl')
  ),
  server = function(input, output) {
    output$tbl <- renderDT({
      req(input$Json)
      json_data <- fromJSON(file = input$Json$datapath)
      as.data.frame(json_data)
    })
  }
)

