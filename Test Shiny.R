
list.files(path = '_SharedFolder_GlobalES/Dashboard/Canada/json_files')

shinyApp(
  shinyUI(bootstrapPage(
    shinyDirButton('folder', 'Select a folder', 'Please select a folder', FALSE)
  )),
  
  shinyServer(function(input, output) {
    shinyDirChoose(input, 'folder', roots=c(wd='.'), filetypes=c('', 'txt'))
    
    observe({
      print(input$folder)
    })
  })
)