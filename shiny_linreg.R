library(shiny)
data(mtcars)

runApp(
  list(
    ui = fluidPage(
      tabsetPanel(  
        
        tabPanel(title = "Linear Regression",
                 titlePanel("Linear Regression"),
                 
                 sidebarLayout(position = "right",
                               mainPanel(h2("Your Model"), 
                                         textOutput('txt'),
                                         textOutput('vars'),
                                         verbatimTextOutput("modelSummary")
                               ),
                               
                               
                               sidebarPanel(h2("Your Data"),
                                            
                                            textInput(inputId = "title", 
                                                      label = "Write a title",
                                                      value = "Histogram of Random Normal Values"),
                                            
                                            selectInput(inputId = "yvar", label = h3("Select response"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 1),
                                            
                                            checkboxGroupInput(inputId = "xvars",
                                                               label = h3("Select predictors"),
                                                               choices = list('Gears' = 'gear',
                                                                              'Cylinders' = 'cyl',
                                                                              'Disp' = 'disp',
                                                                              'Horsepower' = 'hp',
                                                                              'Weight' = 'wt',
                                                                              'Carburetor' = 'carb'),
                                                               selected = 1),
                                            
                                            #tableOutput(outputId = 'table'),
                                            
                                            # fileInput("mydata", label = h4("Please upload the .xls, .txt, or.csv file you would like included in the analysis.")),
                                            
                                            # radioButtons("filetype", label = h4("Please select the type of data uploaded:"), c(".csv", ".txt", ".xls"), selected = ".xls"),
                                            
                                            #textInput("response", label=h4 ("What is the column name of your response variable?")),
                                            
                                            #textInput("explan1", label=h4 ("What is the column name of your explanitory variable?")),
                                            actionButton("analysis","Analyze!")
                                            
                               )
                               
                 )
        ),
        
        tabPanel(title = "IV regression",
                 titlePanel("IV regression"),
                 
                 sidebarLayout(position = "right",
                               mainPanel(h2("Your Model"), 
                                         textOutput('iv.txt'),
                                         textOutput('iv.vars'),
                                         verbatimTextOutput('iv.modelSummary')
                               ),
                               
                               
                               sidebarPanel(h2("Your Data"),
                                            
                                            textInput(inputId = "iv.title", 
                                                      label = "Write a title",
                                                      value = "Histogram of Random Normal Values"),
                                            
                                            selectInput(inputId = "iv.yvar", label = h3("Select response"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 1),
                                            
                                            selectInput(inputId = "iv.endog", label = h3("Select endogenous variable"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 1),
                                            
                                            selectInput(inputId = "iv.inst", label = h3("Select instrument"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 1),
                                            
                                            checkboxGroupInput(inputId = "iv.xvars",
                                                               label = h3("Select predictors"),
                                                               choices = list('Gears' = 'gear',
                                                                              'Cylinders' = 'cyl',
                                                                              'Disp' = 'disp',
                                                                              'Horsepower' = 'hp',
                                                                              'Weight' = 'wt',
                                                                              'Carburetor' = 'carb'),
                                                               selected = 1),
                                            
                                            #tableOutput(outputId = 'table'),
                                            
                                            # fileInput("mydata", label = h4("Please upload the .xls, .txt, or.csv file you would like included in the analysis.")),
                                            
                                            # radioButtons("filetype", label = h4("Please select the type of data uploaded:"), c(".csv", ".txt", ".xls"), selected = ".xls"),
                                            
                                            #textInput("response", label=h4 ("What is the column name of your response variable?")),
                                            
                                            #textInput("explan1", label=h4 ("What is the column name of your explanitory variable?")),
                                            actionButton("iv.analysis","Analyze!")
                                            
                               )
                               
                 )
        )
        
      )
      
      
      
    ),
    
    server = function(input, output) {
      output$txt <- renderText({
        input$title
      })
      
      eq <- reactive({
        paste(input$yvar, '~', paste(input$xvars, collapse = ' + '))
        #paste(input$xvars, collapse = ' + ')
      })
      
      # f <- reactive({
      #   cat(input$yvar, ' ~ ', eq(), sep = '')
      # })
      
      output$vars <- renderText({
        eq()
      })
      
      observeEvent( input$analysis, {
        #form = as.formula(paste0('mpg ~ ', eq()))
        form = as.formula(eq())
        model=lm(form, data = mtcars)

        output$modelSummary <- renderPrint({
          summary(model)
        })

      })
      
      # IV reg
      output$iv.txt <- renderText({
        input$iv.title
      })
      
      iv.eq <- reactive({
        paste(input$yvar, '~', input$iv.endog, '+', paste(input$iv.xvars, collapse = ' + '), 
              '|', input$iv.inst, '+', paste(input$iv.xvars, collapse = ' + '))
        #paste(input$xvars, collapse = ' + ')
      })
      
      # f <- reactive({
      #   cat(input$yvar, ' ~ ', eq(), sep = '')
      # })
      
      output$iv.vars <- renderText({
        iv.eq()
      })
      
      observeEvent( input$iv.analysis, {
        #form = as.formula(paste0('mpg ~ ', eq()))
        form = as.formula(iv.eq())
        model=ivreg(form, data = mtcars)
        
        output$iv.modelSummary <- renderPrint({
          summary(model)
        })
        
      })
      
      
      
    }
    
  ))