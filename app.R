#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(jsonlite)
library(AzureGraph)

# Do this once:
# Authenticate with AAD to create a Token
# gr <- create_graph_login()
# my user information
# me <- gr$get_user("me")
# save(me, file = "token.RData")

# https://docs.microsoft.com/en-us/graph/api/resources/onedrive?view=graph-rest-1.0
# https://developer.microsoft.com/en-us/graph/graph-explorer

load("token.RData")

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("AzureGraph Demo"),

    # Sidebar with a slider input for number of bins 
    fluidPage(
        verbatimTextOutput("sampleQuery"),
        a(href = "https://github.com/Azure/AzureGraph", "https://github.com/Azure/AzureGraph")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    res <- call_graph_url(me$token, url = "https://graph.microsoft.com/v1.0/me")
    output$sampleQuery <- renderText({
        jsonlite::toJSON(res, pretty = TRUE)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
