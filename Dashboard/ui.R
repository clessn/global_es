#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#



library(shiny)
library(shinydashboard)
library(ggplot2)
library(jsonlite)
library(shinyFiles)


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


shiny::fluidPage( # create user interface
  theme = shinythemes::shinytheme("slate"), # add custom theme
  shiny::titlePanel("Global ES"), # add title
  shiny::sidebarLayout( # add a layout with a sidebar and a main panel
    shiny::sidebarPanel(
      shiny::fileInput(inputId = "data", label = "", accept = c(".csv", ".xlsx", ".rds",".json"),
                       buttonLabel = "Données", placeholder = "Données"), # add data entry files
      shiny::selectInput(inputId = "tout", label = "Vue d'ensemble", choices = list(
        "Sans vue d'ensemble" = "Sans vue d'ensemble",
        "Vue d'ensemble" = "Vue d'ensemble")),
      shiny::selectInput(inputId = "variable", label = "Variable", choices = list(
        "ces65" = "ces65",
        "ces68" = "ces68",
        "ces74" = "ces74",
        "ces79" = "ces79",
        "ces84" = "ces84",
        "ces88" = "ces88",
        "ces93" = "ces93",
        "ces97" = "ces97",
        "ces2000" = "ces2000",
        "ces2004" = "ces2004",
        "ces2006" = "ces2006",
        "ces2008" = "ces2008",
        "ces2011" = "ces2011",
        "ces2015" = "ces2015",
        "ces2019" = "ces2019",
        "ces2021" = "ces2021")),
    shiny::selectInput(inputId = "année", label = "Année", choices = list(
      "1965" = "1965",
      "1968" = "1968",
      "1974" = "1974",
      "1979" = "1979",
      "1984" = "1984",
      "1988" = "1988",
      "1993" = "1993",
      "1997" = "1997",
      "2000" = "2000",
      "2004" = "2004",
      "2006" = "2006",
      "2008" = "2008",
      "2011" = "2011",
      "2015" = "2015",
      "2019" = "2019",
      "2021" = "2021")),
    ),
    shiny::mainPanel(
      shiny::tabsetPanel(
        shiny::tabPanel(title = "Nettoyées ou pas",
                        shiny::plotOutput(outputId = "plot", height = "700px")),
      ),
      ),
    ),
  )





  #dashboardPage(
    #dashboardHeader(title = " État variable GlobalES"),
    #dashboardSidebar(
     # sidebarMenu(
                 # menuItem("Vue d'ensemble", tabName = "dashboard", icon = icon("dashboard")),
                 # menuItem("Par variable", tabName = "par_variable", icon = icon("dashboard")),
                 # menuItem("Par élection", tabName = "par_election", icon = icon("dashboard"))
    #dashboardBody(
      #selectInput("par_variable",
                  #"Choisir la variable:",
                  #choices = c("ses_age","ses_income", "ses_gender","ses_sex_orientation")),
      
      #selectInput("par_élection",
        #"Choisir banque de données" ,choices = c("ces65","ces68","ces74","ces79","ces84","ces88","ces93","ces97","ces2000","ces2004","ces2006","ces2008","ces2011","ces2015","ces2019","ces2021"),
    #  tabItems(
        #tabItem(tabName = "dashboard",
                #fluidPage(
                  #box(plotOutput("plot1", height = 250)),
                #))),
              
      #)
    #)
  
