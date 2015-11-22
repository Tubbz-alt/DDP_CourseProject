library(shiny)
library(quantmod)
library(dygraphs)


shinyServer(function(input, output,session) {
        
                
                output$Dygraph <- renderDygraph({
                        # Create a Progress object
                        progress <- shiny::Progress$new()
                        # Make sure it closes when we exit this reactive, even if there's an error
                        on.exit(progress$close())
                        
                        progress$set(message = "Making plot", value = 0)
                        
                        userInput1=input$stock
                        Stock <- names(stockChoices[stockChoices==input$stock])
                        
                        # Increment the progress bar, and update the detail text.
                        progress$inc(1/4, detail = paste("Retrieving stock data"))
                        StockPrice<-as.data.frame(getSymbols(Symbols = userInput1, 
                                                             from = input$chrPeriod[1],to = input$chrPeriod[2], env = NULL))
                        
                        progress$inc(2/4, detail = paste("Retrieving index data"))
                        Index <- names(indexChoices[indexChoices==input$index])
                        userInput2=input$index
                        IndexPrice<-as.data.frame(getSymbols(Symbols = userInput2, 
                                                             from = input$chrPeriod[1],to = input$chrPeriod[2], env = NULL))
                        progress$inc(3/4, detail = paste("Merging"))
                        StockPrice_agg<- to.period(StockPrice,period=input$freq,OHLC=TRUE)
                        IndexPrice_agg<- to.period(IndexPrice,period=input$freq,OHLC=TRUE)
                        stocks <- cbind(StockPrice_agg[,2:4], IndexPrice_agg[,2:4])
                        progress$inc(4/4, detail = paste("Plotting"))
                        
                        return(dygraph(stocks, main = paste(Stock," vs. ",  Index , " share prices")) %>%
                                dySeries(c(colnames(stocks)[1],colnames(stocks)[2],colnames(stocks)[3]), label = userInput1) %>%
                                dyAnnotation(input$invPeriod[1], text = "Investment Start", tooltip = "Begining of the investment period",attachAtBottom = TRUE) %>%
                                dyAnnotation(input$invPeriod[2], text = "Investment End", tooltip = "End of the investment period",attachAtBottom = TRUE) %>%
                                dySeries(c(colnames(stocks)[4],colnames(stocks)[5],colnames(stocks)[6]), label = userInput2, axis = 'y2') %>%
                                dyOptions(colors = c("blue","brown")) %>%
                                dyAxis("y", label = "US Blue Chip Company", axisLabelColor = c("blue") ) %>%
                                dyAxis("y2", label = "Market Index", , axisLabelColor = c("brown"), independentTicks = TRUE) %>%
                                dyOptions(drawGrid = input$showgrid, logscale = TRUE) %>%
                                dyShading(color = "#FFE6E6",from = input$invPeriod[1],to = input$invPeriod[2]) %>%
                                dyRangeSelector())
                        }
                )
                
    
    
                output$StockPerformanceComment <- renderText({
                                                        
                                # Create a Progress object
                                progress <- shiny::Progress$new()
                                
                                # Make sure it closes when we exit this reactive, even if there's an error
                                on.exit(progress$close())
                                
                                progress$set(message = "Stock performance analysis", value = 0)
                                
                                # Increment the progress bar, and update the detail text.
                                progress$inc(1/3, detail = paste("Stock"))
                                
                                Stock <- names(stockChoices[stockChoices==input$stock])
                                Index <- names(indexChoices[indexChoices==input$index])
                                userInput1=input$stock
                                InvestmentStockPrice<-as.data.frame(getSymbols(Symbols = userInput1, from = input$chrPeriod[1],to = input$chrPeriod[2], env = NULL))
                                InvestmentStockPrice_agg<- to.period(InvestmentStockPrice,period="days",OHLC=TRUE)
                                s1PurchasePrice<-InvestmentStockPrice_agg[rownames(InvestmentStockPrice_agg)==input$invPeriod[1],1]
                                s1SellingPrice<-InvestmentStockPrice_agg[rownames(InvestmentStockPrice_agg)==input$invPeriod[2],1]
                                profit1<-round((input$invSize/s1PurchasePrice)*s1SellingPrice-input$invSize,0)
                                progress$inc(2/3, detail = paste("Index"))
                                userInput2=input$index
                                InvestmentIndexPrice<-as.data.frame(getSymbols(Symbols = userInput2, from = input$chrPeriod[1],to = input$chrPeriod[2], env = NULL))
                                InvestmentIndexPrice_agg<- to.period(InvestmentIndexPrice,period="days",OHLC=TRUE)
                                s2PurchasePrice<-InvestmentIndexPrice_agg[rownames(InvestmentIndexPrice_agg)==input$invPeriod[1],1]
                                s2SellingPrice<-InvestmentIndexPrice_agg[rownames(InvestmentIndexPrice_agg)==input$invPeriod[2],1]
                                profit2<-round((input$invSize/s2PurchasePrice)*s2SellingPrice-input$invSize,0)
                                progress$inc(3/3, detail = paste("Calculation"))
                                
                                profitComp<-round((profit1-profit2)/profit2,2)
                                
                                if( (profit1 > 0) & (profitComp < 0)) {paste(c("Investing ",format(input$invSize, decimal.mark=".", big.mark=",", digits = 0, format = "f"), " USD into ",Stock,
                                                                                                        " stocks back in ", as.character(as.Date(input$invPeriod[1]), "%B %Y") ," would have yielded the profit of ",
                                                                                                        format(profit1, decimal.mark=".", big.mark=",", digits = 0, format = "######"), " USD (",round((profit1/input$invSize)*100,1),"%) by ",
                                                                                                        as.character(as.Date(input$invPeriod[2]), "%B %d, %Y"),". Still, compared to the ",Index, " market index, ", Stock, " stocks underperformed by ", 
                                                                                                        format(profitComp, decimal.mark=".", big.mark=",", digits = 2, format = "######"), "%."))}
                                else if( (profit1 > 0) & (profitComp > 0)) {paste(c("Investing ",format(input$invSize, decimal.mark=".", big.mark=",", digits = 0, format = "f"), " USD into ",Stock,
                                                                                                       " stocks back in ", as.character(as.Date(input$invPeriod[1]), "%B %Y") ," would have yielded the profit of ",
                                                                                                       format(profit1, decimal.mark=".", big.mark=",", digits = 0, format = "f"), " USD (",round((profit1/input$invSize)*100,1),"%) by ",
                                                                                                       as.character(as.Date(input$invPeriod[2]), "%B %d, %Y"),". Compared to the ",Index, " market index, ", Stock, " stocks overperformed it by ", 
                                                                                                       format(profitComp, decimal.mark=".", big.mark=",", digits = 2, format = "######"), "%."))}
                                else if((profit1 < 0) & (profitComp > 0)) {paste(c("Investing ",format(input$invSize, decimal.mark=".", big.mark=",", digits = 0, format = "f"), " USD into ",Stock,
                                                                                                       " stocks back in ", as.character(as.Date(input$invPeriod[1]), "%B %Y") ," would have yielded the loss of ",
                                                                                                       format(profit1, decimal.mark=".", big.mark=",", digits = 0, format = "####"), " USD (",round((profit1/input$invSize)*100,1),"%) by ",
                                                                                                       as.character(as.Date(input$invPeriod[2]), "%B %d, %Y"),". Still, compared to the ",Index, " market index, ", Stock, " stocks overperformed it"))}
                                else if((profit1 < 0) & (profitComp < 0)) {paste(c("Investing ",format(input$invSize, decimal.mark=".", big.mark=",", digits = 0, format = "f"), " USD into ",Stock,
                                                                                                       " stocks back in ", as.character(as.Date(input$invPeriod[1]), "%B %Y") ," would have yielded the loss of ",
                                                                                                       format(profit1, decimal.mark=".", big.mark=",", digits = 0, format = "####"), " USD (",round((profit1/input$invSize)*100,1),"%) by ",
                                                                                                       as.character(as.Date(input$invPeriod[2]), "%B %d, %Y"),". Compared to the ",Index, " market index, ", Stock, " stocks underperformed as well."))}
                                
                                else {paste("")}
                                
                        })
                
                        output$StockPerformanceTitle <- renderText({
                                paste(c("Investment performance summary"))
                        })
                
                        output$ChartTitle <- renderText({
                                paste(c("Stock performance chart"))
                     })
})