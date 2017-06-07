
# This is the user-interface definition of a Shiny web application.
#install.packages("shinytheme")
library(shiny)
library(shinythemes)
# Define UI for dataset viewer application
shinyUI(fluidPage(
  theme=shinytheme("superhero"),
                  
  
  # Application title
  titlePanel("Testing Classification Algorithms on ransomware Dataset"),
  
  # Sidebar with controls for the algorithms and output
  sidebarLayout(
    position = "left",
    
    sidebarPanel(
      
      numericInput("obs", "Number of observations to view:", 5), 
      
      sliderInput("slidertrainsplit",
                  "Proportion of Training observations",
                  min = 0, max = 1, value = 0.7, step = 0.1),
      
      selectInput("algorithm", "Choose a Classification algorithm:", 
                  choices = c("randomForest","naivebayes","Decision tree"))
      
      
      
    ),
    
    
    # Show the some example of observations, a summary of the dataset 
    # and the results on the model
    mainPanel(
      tabsetPanel(
        tabPanel("Classification",#splitLayout(cellwidths= c("50%","50%"),plotOutput(outputId="map"),plotOutput(outputId="map2")),
                 
               # splitLayout(cellwidths= c("50%","50%"),verbatimTextOutput(outputId ="stats"), verbatimTextOutput(outputId ="statsxyz")),  
      HTML("<p>This app shows the application of 4 different classification algorithms(rpart, randomForest, naivebayes and decision tree)to the ransomware dataset.</p>
           <p>First it shows randomaly n observation  of ransomware dataset, where n is the number of observations specified on the sidebar panel (5 by default).</p>
           <p>Then it shows summary statistics for the ransomware dataset.</p>
           <p>Lastly it trains a classification algorithm chosen by the user on the sidepar panel, splitting the dataset in training and testing sets based on the chosen proportion chosen on the sidebar (by defuault 70% training 30% testing).</p>"
           ), 
    
     h2("Dataset"),
      tableOutput("view"), 
      
      #h2("Summary Statistics"),
      #verbatimTextOutput("summary"), 
      
      h2("Results"),
      verbatimTextOutput("results"),
      br(),
      plotOutput(outputId="map"),
      verbatimTextOutput(outputId="stats") ),
     tabPanel(" Compare Model ",plotOutput(outputId = "compare"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 0:100.</b></p>"),plotOutput(outputId = "compare1"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 10:90.</b></p>"),plotOutput(outputId = "compare2"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 20:80.</b></p>"),plotOutput(outputId = "compare3"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 30:70.</b></p>"),plotOutput(outputId = "compare4"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 40:60.</b></p>"),plotOutput(outputId = "compare5"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 50:50.</b></p>"),plotOutput(outputId = "compare6"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 60:40.</b></p>"),plotOutput(outputId = "compare7"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 70:30.</b></p>"),plotOutput(outputId = "compare8"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 80:20.</b></p>"),plotOutput(outputId = "compare9"),HTML("<hr><p><b>comparision among the  different machine learning 
     alogorithms for ratio 90:10.</b></p>"),plotOutput(outputId = "compare10"),HTML("<hr><p><b> comparision among the  different machine learning 
     alogorithms for ratio 100:0.</b></p>")),
     
     tabPanel("Best Algorithm",plotOutput(outputId="best"))
     
    
               
     
      ) 
    )
  )
))
