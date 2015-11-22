library(shiny)
library(dygraphs)
library(htmlwidgets)

# Define UI for slider demo application
shinyUI(pageWithSidebar(
        
        #  Application title & introduction
        headerPanel(
                                
                tags$div(   
                        h2("Benchmark Your Returns With Indexes"),
                        hr(),
                        h5("Investors look to broad indexes as benchmarks to help them gauge not only how well the markets are performing, but also how well they, as investors, are performing. 
                           For those who own stocks, they look to indexes like the S&P 500, the Dow Jones Industrial Average and the Nasdaq Composite to tell them ''where the market is''. 
                           The values of these indexes are displayed every day by financial media outlets all over the world. Most investors hope to meet or exceed the returns of these indexes 
                           over time."),
                        h5("To read more about indexes, see ",a("The ABCs Of Stock Indexes",href="http://www.investopedia.com/articles/analyst/062502.asp")," and ",a("Index Investing Tutorial.", href="http://www.investopedia.com/university/indexes/")),                       
                        hr()
                        ),
                
                ),
        
        # Sidebar with sliders that demonstrate various available options
        sidebarPanel(
                # adding the new div tag to the sidebar            
                tags$div(
                        h4("Chart settings", style = "color:orange")
                ),
                
                # adding selectInput for Stock
                dateRangeInput("chrPeriod", "Chart period:",start = "01-01-2009",end=as.character(Sys.Date()-1),format="dd-mm-yyyy"),                
                selectInput("stock", "US Blue Chip Company",
                            choices = stockChoices,
                            selected = "IBM"),
                
                # adding selectInput for Market Index
                selectInput("index", "Market Index",
                            choices = indexChoices,
                            selected = "^DJI"),
                
                # adding selectInput for chart periodicity
                selectInput("freq", "Frequency",
                            choices = c("days", "weeks", "months", "quarters", "years"),
                            selected = "days"),
                
                # adding checkboxInput for showing chart gridlines or not
                checkboxInput("showgrid", label = "Show Grid", value = TRUE),
                
                # adding the new div tag to the sidebar    
                hr(),
                tags$div(
                        h4("Investment settings", style = "color:orange")
                ),
                                
                # adding dataRange for Investment period
                dateRangeInput("invPeriod", "Investment period:",start = "07-01-2009",end="11-20-2014",format="dd-mm-yyyy"),
                
                # adding sliderInput for Investment amount
                sliderInput("invSize", "Invested amount:", min=0, max=10000, value=10000,step=500),
                
                br(),
                p(em("Documentation:",a("Benchmark Your Returns With Indexes",href="http://rpubs.com/pluketic/129370"))),
                p(em("Presentation:",a("Benchmark Your Returns With Indexes",href="http://rpubs.com/pluketic/129484"))),
                p(em("Github repository:",a("DDP Course Project",href="http://github.com/pluketic/DDP_CourseProject")))
        ),
        
        
        # Show a table summarizing the values entered
        mainPanel(
                                h4(textOutput("ChartTitle")),
                                dygraphOutput("Dygraph"),
                                hr(),
                                br(),
                                h4(textOutput("StockPerformanceTitle")),
                                br(),
                                textOutput("StockPerformanceComment"),
                                hr()
                                )

))
