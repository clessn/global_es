#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#
library(foreign)
library(jsonlite)
library(tidyverse) # for ggplot and dplyr
library(shiny)
options(shiny.maxRequestSize = 500 * 1024 ^ 2) # maximize data upload space
options(rsconnect.shiny.max.bundle.size = 500 * 1024 ^ 2) # maximize data upload space on the deployed app
function(input, output){ # server function
  Data <- shiny::reactive({jsonlite::read_json(input$data$datapath)})
}

server <- function(input, output) {
  
  generate_plot <- function(cleaned) {
    ggplot(data.frame(cleaned), aes(x = factor(cleaned), fill = factor(cleaned))) +
      geom_bar() +
      scale_fill_manual(values = c("FALSE" = "red", "TRUE" = "green"),
                        name = "Nettoyée") +
      labs(title = "Nettoyage de la variable")
  }
  
  output$plot1 <- renderPlot({
    # Generate some random data based on the number of observations chosen by the user
    x <- 1:input$obs
    y <- rnorm(input$obs)
    
    # Plot the data
    plot(x, y, main = "Random Data Plot", xlab = "X", ylab = "Y")
  })
  
  output$plot2 <- renderPlot({
    x <- 1:input$obs
    y <- rnorm(input$obs)
    
    plot(x,y, main = "Random Data Plot2", xlab = "X", ylab = "Y")
  })
}
