library(sparsereg)
library(shiny)
library(shinyBS)
data(mtcars)

runApp(
  list(
    
    ui = fluidPage(
      tabsetPanel( 
        
        # Data upload
        tabPanel("Upload File",
                 titlePanel("Uploading Files"),
                 sidebarLayout(
                   sidebarPanel(
                     fileInput('file1', 'Choose CSV File',
                               accept=c('text/csv', 
                                        'text/comma-separated-values,text/plain', 
                                        '.csv')),
                     
                     # added interface for uploading data from
                     # http://shiny.rstudio.com/gallery/file-upload.html
                     tags$br(),
                     checkboxInput('header', 'Header', TRUE),
                     radioButtons('sep', 'Separator',
                                  c(Comma=',',
                                    Semicolon=';',
                                    Tab='\t'),
                                  ','),
                     radioButtons('quote', 'Quote',
                                  c(None='',
                                    'Double Quote'='"',
                                    'Single Quote'="'"),
                                  '"')
                     
                   ),
                   mainPanel(
                     tableOutput('contents')
                   )
                 )
        ),
        
        # Linear regression
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
                                            actionButton("analysis","Run")
                                            
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
                                                                       'Carburetor' = 'carb'), selected = 'gear'),
                                            
                                                              
                                            selectInput(inputId = "iv.inst", label = h3("Select instrument"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 'cyl'),
                                            
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
                                            actionButton("iv.analysis","Run")
                                            
                               )
                               
                 )
        ),
        
        
        tabPanel(title = "sparseregIV",
                 titlePanel("Sparsereg IV"),
                 
                 sidebarLayout(position = "right",
                               mainPanel(h2("Your Model"), 
                                         textOutput('sp.txt'),
                                         #textOutput('sp.vars'),
                                         tableOutput(outputId = 'table'),
                                         verbatimTextOutput('sp.modelSummary')
                                         
                                         #actionButton('plotratio',"Plot ratio"),
                                         #plotOutput('corr')
                                         
                               ),
                               
                               
                               sidebarPanel(h2("Your Data"),
                                            
                                            textInput(inputId = "sp.title", 
                                                      label = "Write a title",
                                                      value = "Histogram of Random Normal Values"),
                                            
                                            selectInput(inputId = "sp.yvar", label = h3("Select response"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 1),
                                            
                                            selectInput(inputId = "sp.endog", label = h3("Select endogenous variable"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 'gear'),
                                            
                                            selectInput(inputId = "sp.inst", label = h3("Select instrument"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 'cyl'),
                                            
                                            checkboxGroupInput(inputId = "sp.xvars",
                                                               label = h3("Select predictors"),
                                                               choices = list('Gears' = 'gear',
                                                                              'Cylinders' = 'cyl',
                                                                              'Disp' = 'disp',
                                                                              'Horsepower' = 'hp',
                                                                              'Weight' = 'wt',
                                                                              'Carburetor' = 'carb'),
                                                               selected = 1),
                                            
                                            
                                            
                                            # fileInput("mydata", label = h4("Please upload the .xls, .txt, or.csv file you would like included in the analysis.")),
                                            
                                            # radioButtons("filetype", label = h4("Please select the type of data uploaded:"), c(".csv", ".txt", ".xls"), selected = ".xls"),
                                            
                                            #textInput("response", label=h4 ("What is the column name of your response variable?")),
                                            
                                            #textInput("explan1", label=h4 ("What is the column name of your explanitory variable?")),
                                            actionButton('sp.analysis',"Run")
                                            
                               )
                               
                 )
        ),
        
        # sparsereg
        tabPanel(title = "sparsereg",
                 titlePanel("Sparsereg"),
                 
                 sidebarLayout(position = "left",
                               
                               sidebarPanel(h2("Your Data"),
                                            
                                            textInput(inputId = "s.title",
                                                      label = "Write a title",
                                                      value = "Histogram of Random Normal Values"),

                                            selectInput(inputId = "s.yvar", label = h3("Select response"),
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 1),

                                            selectInput(inputId = "s.treat", label = h3("Select treatment"),
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 'gear'),

                                            checkboxGroupInput(inputId = "s.xvars",
                                                               label = h3("Select predictors"),
                                                               choices = list('Gears' = 'gear',
                                                                              'Cylinders' = 'cyl',
                                                                              'Disp' = 'disp',
                                                                              'Horsepower' = 'hp',
                                                                              'Weight' = 'wt',
                                                                              'Carburetor' = 'carb'),
                                                               selected = 1),
                                            
                                            # HUUUUUUUGE
                                            selectInput("Columns","Columns",
                                                        names(mtcars), multiple = TRUE),
                                            
                                            # LETS GOOOOO
                                            radioButtons("bins", "EM:",
                                                         choiceNames = list('TRUE', 'FALSE'),
                                                         choiceValues = list(TRUE, FALSE),
                                                         selected = 'FALSE'
                                            ),
                                            bsTooltip("bins", 'Whether to fit model via EM or MCMC. EM is much quicker, but only returns point estimates. MCMC is slower, but returns posterior intervals and approximate confidence intervals.',
                                                      "right", options = list(container = "body")),
                                            
                                            
                                            
                                            # fileInput("mydata", label = h4("Please upload the .xls, .txt, or.csv file you would like included in the analysis.")),
                                            
                                            # radioButtons("filetype", label = h4("Please select the type of data uploaded:"), c(".csv", ".txt", ".xls"), selected = ".xls"),
                                            
                                            #textInput("response", label=h4 ("What is the column name of your response variable?")),
                                            
                                            #textInput("explan1", label=h4 ("What is the column name of your explanitory variable?")),
                                            actionButton('s.analysis',"Run")
                                            
                               ),
                               mainPanel(h2("Your Model"), 
                                         textOutput('s.txt'),
                                         #textOutput('s.vars'),
                                         tableOutput(outputId = 's.table'),
                                         textOutput('s.em.text'),
                                         verbatimTextOutput('s.modelSummary')
                                         
                                         #actionButton('plotratio',"Plot ratio"),
                                         #plotOutput('corr')
                                         
                               )
                               
                 )
        ),
        
        # sparseregTE
        tabPanel(title = "sparseregTE",
                 titlePanel("Sparsereg TE"),
                 
                 sidebarLayout(position = "right",
                               mainPanel(h2("Your Model"), 
                                         textOutput('te.txt'),
                                         #textOutput('te.vars'),
                                         tableOutput(outputId = 'te.table'),
                                         #textOutput('s.em.text'),
                                         verbatimTextOutput('te.modelSummary')
                                         
                                         #actionButton('plotratio',"Plot ratio"),
                                         #plotOutput('corr')
                                         
                               ),
                               
                               
                               sidebarPanel(h2("Your Data"),
                                            
                                            textInput(inputId = "te.title", 
                                                      label = "Write a title",
                                                      value = "Histogram of Random Normal Values"),
                                            
                                            selectInput(inputId = "te.yvar", label = h3("Select response"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 1),
                                            
                                            selectInput(inputId = "te.treat", label = h3("Select treatment"), 
                                                        choices = list('MPG' = 'mpg',
                                                                       'Gears' = 'gear',
                                                                       'Cylinders' = 'cyl',
                                                                       'Disp' = 'disp',
                                                                       'Horsepower' = 'hp',
                                                                       'Weight' = 'wt',
                                                                       'Carburetor' = 'carb'), selected = 'gear'),
                                            
                                            checkboxGroupInput(inputId = "te.xvars",
                                                               label = h3("Select predictors"),
                                                               choices = list('Gears' = 'gear',
                                                                              'Cylinders' = 'cyl',
                                                                              'Disp' = 'disp',
                                                                              'Horsepower' = 'hp',
                                                                              'Weight' = 'wt',
                                                                              'Carburetor' = 'carb'),
                                                               selected = 1),
                                            
                                            
                                            # fileInput("mydata", label = h4("Please upload the .xls, .txt, or.csv file you would like included in the analysis.")),
                                            
                                            # radioButtons("filetype", label = h4("Please select the type of data uploaded:"), c(".csv", ".txt", ".xls"), selected = ".xls"),
                                            
                                            #textInput("response", label=h4 ("What is the column name of your response variable?")),
                                            
                                            #textInput("explan1", label=h4 ("What is the column name of your explanitory variable?")),
                                            actionButton('te.analysis',"Run")
                                            
                               )
                               
                 )
        )
        
      )
      
      
      
    ),
    
    server = function(input, output, session) {
      
      # This data is different from my data below
      data <- reactive({ 
        req(input$file1) ## ?req #  require that the input is available
        
        inFile <- input$file1 
        
        # tested with a following dataset: write.csv(mtcars, "mtcars.csv")
        # and                              write.csv(iris, "iris.csv")
        df <- read.csv(inFile$datapath, header = input$header, sep = input$sep,
                       quote = input$quote)
        
        
        # Update inputs (you could create an observer with both updateSel...)
        # You can also constraint your choices. If you wanted select only numeric
        # variables you could set "choices = sapply(df, is.numeric)"
        # It depends on what do you want to do later on.
        
        updateSelectInput(session, inputId = 'xcol', label = 'X Variable',
                          choices = names(df), selected = names(df))
        updateSelectInput(session, inputId = 'ycol', label = 'Y Variable',
                          choices = names(df), selected = names(df)[2])
        
        return(df)
      })
      
      output$contents <- renderTable({
        data()
      })
      
      
      
      # Linear regression
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
        paste(input$iv.yvar, '~', input$iv.endog, '+', paste(input$iv.xvars, collapse = ' + '), 
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
      
      # sparseregIV
      output$sp.txt <- renderText({
        input$sp.title
      })
      
      sp.eq <- reactive({
        paste0("c('", paste(input$sp.xvars, collapse = "','"), "')")
      })
      
      sp.dat <- reactive({
        parse(text = paste0("c('", paste(input$sp.xvars, collapse = "','"), "')"))
      })
      
      output$sp.vars <- renderTable({
        mtcars[eval(sp.dat())]
      })
      
      output$table <- renderTable({
        head(data())
      }, rownames = TRUE)
      
      data <- reactive({
        mtcars[, c(input$sp.yvar, input$sp.endog, input$sp.inst, input$sp.xvars), drop = FALSE]
      })
    
      
      observeEvent( input$sp.analysis, {
        # dat.full = complete.cases(mtcars)
        X<-as.matrix(data()[-(1:3)])
        keep.cols<-apply(X,2,sd)>0
        X<-X[,keep.cols]
        
        fit.sparseIV <- sparseregIV(y = data()[,1], endog = data()[,2], inst = data()[,3], X)

        output$sp.modelSummary <- renderPrint({
          summary(fit.sparseIV)
        })
        
      })
      

      
      # sparsereg
      output$s.txt <- renderText({
        input$s.title
      })
      
      # s.eq <- reactive({
      #   paste0("c('", paste(input$s.xvars, collapse = "','"), "')")
      # })
      
      s.dat <- reactive({
        parse(text = paste0("c('", paste(input$s.xvars, collapse = "','"), "')"))
      })
      
      output$s.vars <- renderTable({
        mtcars[eval(s.dat())]
      })
      
      output$s.table <- renderTable({
        head(s.data())
      }, rownames = TRUE)
      
      s.data <- reactive({
        mtcars[, c(input$s.yvar, input$s.treat, input$s.xvars), drop = FALSE]
      })
      
      observeEvent( input$s.analysis, {
        # dat.full = complete.cases(mtcars)
        X<-as.matrix(s.data()[-(1:2)])
        keep.cols<-apply(X,2,sd)>0
        X<-X[,keep.cols]
        
        fit.sparse <- sparsereg(y = s.data()[,1], X, treat = s.data()[,2], EM=eval(parse(text=input$bins)))
        
        output$s.modelSummary <- renderPrint({
          summary(fit.sparse)
        })
        
      })
      
      # addPopover(session, "s.rb", "Data", content = paste0("
      #                                                          Waiting time between ",
      #                                                          "eruptions and the duration of the eruption for the Old Faithful geyser ",
      #                                                          "in Yellowstone National Park, Wyoming, USA.
      #                                                          
      #                                                          Azzalini, A. and ",
      #                                                          "Bowman, A. W. (1990). A look at some data on the Old Faithful geyser. ",
      #                                                          "Applied Statistics 39, 357-365.
      #                                                          
      #                                                          "), trigger = 'click')
      
      
      
      # sparseregTE
      output$te.txt <- renderText({
        input$te.title
      })

      te.dat <- reactive({
        parse(text = paste0("c('", paste(input$te.xvars, collapse = "','"), "')"))
      })
      
      output$te.vars <- renderTable({
        mtcars[eval(te.dat())]
      })
      
      output$te.table <- renderTable({
        head(te.data())
      }, rownames = TRUE)
      
      te.data <- reactive({
        mtcars[, c(input$te.yvar, input$te.treat, input$te.xvars), drop = FALSE]
      })
      
      observeEvent( input$te.analysis, {
        # dat.full = complete.cases(mtcars)
        X<-as.matrix(te.data()[-(1:2)])
        keep.cols<-apply(X,2,sd)>0
        X<-X[,keep.cols]
        
        fit.sparseTE <- sparseregTE(y = te.data()[,1], X, treat = te.data()[,2])
        
        output$te.modelSummary <- renderPrint({
          summary(fit.sparseTE)
        })
        
      })

      
    }
    
  ))