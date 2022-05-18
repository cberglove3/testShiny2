# App 1

library(shiny)
library(tidyverse)

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Hello World!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      
      # Input: Slider for the number of bins ----
      sliderInput(inputId = "bins",
                  label = "Number of bins:",
                  min = 5,
                  max = 50,
                  value = 30)
      
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )
)

# Define server logic required to draw a histogram ----
server <- function(input, output) {
  
  # Histogram of the Old Faithful Geyser Data ----
  # with requested number of bins
  # This expression that generates a histogram is wrapped in a call
  # to renderPlot to indicate that:
  #
  # 1. It is "reactive" and therefore should be automatically
  #    re-executed when inputs (input$bins) change
  # 2. Its output type is a plot
  output$distPlot <- renderPlot({
    
    x    <- faithful %>% pull(waiting)
    
    bin_breaks <- seq(min(x), max(x), length.out = input$bins + 1)
    
    
    ggplot(faithful, aes(x = waiting)) +
      geom_histogram(breaks = bin_breaks,
                     colour = "orange", fill = "#75AADB") +
      theme_minimal() +
      labs(title = "Histogram of waiting times",
           x = "Waiting time to next eruption (in mins)",
           y = "Frequency") +
      theme(plot.title = element_text(hjust = 0.5, face = "bold"))
    
  })
  
}
# Run the application 
shinyApp(ui = ui, server = server)
