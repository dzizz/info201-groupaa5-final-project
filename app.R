#Import the needed libraries
library("shiny")

#Import the server and UI files
source("server.R")
source("ui.R")

#Launch the shiny app with the imported server and UI
shinyApp(ui = main_ui, server = main_server)