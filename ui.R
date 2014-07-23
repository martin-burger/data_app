


library(shiny)

StartStation=read.csv("StartStations.csv",colClasses="character")
shinyUI(fluidPage(
  titlePanel("Citi Bike User Data"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Pick a start station to see where people traveled from there and how long it took them."),
      
      selectInput("startstation",
                  label = "Select a start station",
                  choices = StartStation$x,
                  selected="E 43 St & Vanderbilt Ave"),
      submitButton('Plot!')
    ),
    
    mainPanel(
      textOutput("text1"),
      plotOutput("bikeMapPlot")
    )
  )
))
