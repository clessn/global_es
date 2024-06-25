library(shinyFiles)

list.files(path = '_SharedFolder_GlobalES/Dashboard/Canada/json_files')

shinyApp(
  shinyUI(bootstrapPage(
    shinyDirButton('folder', 'Select a folder', 'Please select a folder', FALSE),
    tableOutput('file_table')
  )),
  
  shinyServer(function(input, output) {
    shinyDirChoose(input, 'folder', roots=c(wd='.'), filetypes=c('', 'txt'))
    output$file_table <- renderTable({
      req(input$folder) # Ensure that input$folder is not NULL
      print(input$folder)
      folder_path_list <- input$folder$path
      folder_path <- paste(unlist(folder_path_list)[-1],collapse = "/")
      print("folder_path")
      print(folder_path)
      files <- list.files(path = folder_path)
      print(files)
      data.frame(File = files)
    })  
  })     
)