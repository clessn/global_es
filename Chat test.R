library(shiny)
library(shinyFiles)

# Example function to determine if a file is cleaned (this should be replaced with your actual logic)
is_file_cleaned <- function(file_path) {
  # Placeholder logic to check if a file is cleaned
  # Replace with actual checks, for example, if the file contains certain data
  return(grepl("cleaned", file_path))
}

ui <- fluidPage(
  shinyDirButton('folder', 'Select a folder', 'Please select a folder', FALSE),
  tableOutput('file_table'),
  textOutput('file_status')
)

server <- function(input, output, session) {
  shinyDirChoose(input, 'folder', roots=c(wd='.'), filetypes=c('', 'txt'))
  
  files <- reactive({
    req(input$folder) # Ensure that input$folder is not NULL
    folder_path <- paste(unlist(input$folder$path)[-1], collapse = "/")
    list.files(path = folder_path)
  })
  
  output$file_table <- renderTable({
    req(files())
    data.frame(File = files())
  })
  
  observe({
    req(files())
    lapply(files(), function(file) {
      observeEvent(input[[file]], {
        selected_file_path <- file.path(paste(unlist(input$folder$path)[-1], collapse = "/"), file)
        output$file_status <- renderText({
          if (is_file_cleaned(selected_file_path)) {
            paste(file, "has been cleaned.")
          } else {
            paste(file, "has not been cleaned.")
          }
        })
      })
    })
  })
}

shinyApp(ui, server)
