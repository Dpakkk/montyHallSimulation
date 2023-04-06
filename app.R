# Load required libraries
library(shiny)
library(plotly)

# Define the UI
ui <- fluidPage(
  titlePanel("Monte Hall Simulation"),
  
  sidebarLayout(
    sidebarPanel(
      numericInput("n_sims", "Number of simulations", value = 1000, min = 1),
      actionButton("run_sim", "Run Simulation")
    ),
    
    mainPanel(
      plotlyOutput("plot_wins"),
      plotlyOutput("plot_losses")
    )
  )
)

# Define the server
server <- function(input, output) {
  
  # Define a function to run the simulation
  run_simulation <- function(n_sims) {
    # Initialize the counts of wins and losses
    win_count <- 0
    loss_count <- 0
    
    # Run the simulations
    for (i in 1:n_sims) {
      # Randomly choose the door with the prize
      prize_door <- sample(1:3, 1)
      
      # Randomly choose the door chosen by the contestant
      chosen_door <- sample(1:3, 1)
      
      # Reveal one of the non-prize doors
      non_prize_doors <- setdiff(1:3, c(prize_door, chosen_door))
      revealed_door <- sample(non_prize_doors, 1)
      
      # Switch to the other unopened door
      new_door <- setdiff(1:3, c(revealed_door, chosen_door))
      
      # Check if the contestant won or lost
      if (new_door == prize_door) {
        win_count <- win_count + 1
      } else {
        loss_count <- loss_count + 1
      }
    }
    
    # Calculate the probabilities of winning and losing
    prob_win <- win_count / n_sims
    prob_loss <- loss_count / n_sims
    
    # Create a data frame with the results
    data.frame(outcome = c("Win", "Loss"), probability = c(prob_win, prob_loss))
  }
  
  # Define a reactive expression to run the simulation when the "Run Simulation" button is clicked
  sim_results <- eventReactive(input$run_sim, {
    run_simulation(input$n_sims)
  })
  
  # Define the plot for the probabilities of winning and losing
  output$plot_wins <- renderPlotly({
    plot_ly(sim_results(), x = ~outcome, y = ~probability, type = 'scatter', mode = 'lines', name = 'Winning Probability') %>%
      layout(title = 'Probabilities of Winning and Losing',
             xaxis = list(title = ''),
             yaxis = list(title = 'Probability', range = c(0, 1)))
  })
  
  output$plot_losses <- renderPlotly({
    plot_ly(sim_results(), x = ~outcome, y = ~probability, type = 'scatter', mode = 'lines', name = 'Losing Probability') %>%
      layout(title = 'Probabilities of Winning and Losing',
             xaxis = list(title = ''),
             yaxis = list(title = 'Probability', range = c(0, 1)))
  })
}

# Run the app
shinyApp(ui = ui, server = server)
