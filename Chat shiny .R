library(shiny)
library(shinyFiles)
library(ggplot2)

ui <- bootstrapPage(
  shinyDirButton('folder', 'Select a folder', 'Please select a folder', FALSE),
  selectInput(inputId = 'variable', label = 'Variable', choices = NULL),
  textOutput('folder_path_output'),  # Add an output to show the selected folder path (optional)
  tableOutput('file_contnt'),
  plotOutput('json_plot')
)

server <- function(input, output, session) {
  # Define the roots
  roots <- c(wd = normalizePath("."))
  
  # Enable directory selection
  shinyDirChoose(input, 'folder', roots = roots, session = session)
  
  observeEvent(input$folder, {
    req(input$folder)
    
    # Get the selected folder path
    folder_path <- parseDirPath(roots, input$folder)
    
    # Print the selected folder path for debugging
    print("Selected folder path:")
    print(folder_path)
    
    if (length(folder_path) > 0 && file.exists(folder_path)) {
      files <- list.files(path = folder_path)
      
      # Update the selectInput choices
      updateSelectInput(session, 'variable', choices = files)
      
      # (Optional) Display the selected folder path in the UI for user confirmation
      #output$folder_path_output <- renderText({
      #  paste("Selected folder path:", folder_path)
      #})
      
    } else {
      # Handle invalid folder path
      updateSelectInput(session, 'variable', choices = NULL)
      #output$folder_path_output <- renderText({
      #  "Invalid folder selection. Please select a valid folder."
      #})
    }
  })
  observeEvent(input$variable, {
    req(input$variable)
    file_path <- file.path(parseDirPath(roots, input$folder), input$variable)
    
    # Print file path for debugging
    print(file_path)
    
    # Try reading the JSON file
    file_content <- tryCatch({
      fromJSON(file_path)
    }, error = function(e) {
      print(paste("Error reading JSON file:", e$message))
      NULL
    })
    
    if (!is.null(file_content)) {
      output$file_content <- renderTable({
        file_content
      })
    } else {
      output$file_content <- renderText({
        "Error reading JSON file. Please check the file format and try again."
      })
  output$json_plot <- renderPlot({
    ggplot(data = file_content, aes (x=x, y=y)) +
      geom_bar() +
      clessnverse::theme_clean_light() +
      labs(title = "Cleaner ?")
  })
    }
  })
}

shinyApp(ui, server)