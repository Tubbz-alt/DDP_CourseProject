##__Benchmark Your Returns With Indexes__
Petar Luketic   
21-Nov-2015

###__Links__

1. **Shiny application** can be accessed [here](http://pluketic.shinyapps.io/DDP_CourseProject/index.html).   
<small>If by any chance, chart doen't appear in the html link provided, please try with this [link](http://pluketic.shinyapps.io/DDP_CourseProject) first.</small>    

2. **R presentation** can be found [here](http://rpubs.com/pluketic/129484).   
   

###__Background__   

Investors look to broad indexes as benchmarks to help them gauge not only how well the markets are performing, but also how well they, as investors, are performing. For those who own stocks, they look to indexes like the S&P 500, the Dow Jones Industrial Average and the Nasdaq Composite to tell them ''where the market is''. 
                           
The values of these indexes are displayed every day by financial media outlets all over the world. Most investors hope to meet or exceed the returns of these indexes over time.     
                           
#####**Blue Chip definition**   

A nationally recognized, well-established and financially sound company. Blue chips generally sell high-quality, widely accepted products and services. Blue chip companies are known to weather downturns and operate profitably in the face of adverse economic conditions, which helps to contribute to their long record of stable and reliable growth.

Read more: [Blue Chip Definition](Investopedia http://www.investopedia.com/terms/b/bluechip.asp)   

#####**Market Index definition**   

It's not unusual for people to talk about "the market" as if there were a common meaning for the word. But in reality, the many indexes of the differing segments of the market don't always move in tandem. If they did, there would be no reason to have multiple indexes. By gaining a clear understanding of how indexes are created and how they differ, you will be on your way to making sense of the daily movements in the marketplace. Here we'll compare and contrast the main market indexes so that the next time you hear someone refer to "the market", you'll have a better idea of just what they mean.

Read more: [An Introduction To Stock Market Indexes](http://www.investopedia.com/articles/analyst/102501.asp)   

###__Data__   

Application is based on the data coming directly from yahoo finance API, based on the input parameters defined within the app's UI.

###__Input parameters__        

#####**Chart Settings**    
- ***Chart period*** - Select period you want prices to plotted
- ***US Blue Chip Company*** - Select a stock you want to invest into
- ***Market Index*** - Select market index you want your stock performance to be compared with
- ***Frequency*** - Select period which you would like to be presented on the chart
- ***Show Grid*** - Defines whether to show gridlines on the chart or not   

#####**Investment Settings**       
- ***Investment period*** - Select period for which you would like to see investment performance evaluation
- ***Investment amount*** - Define amount to be invested at the beginning of the investment period

###__Output__     

As you change input parameters, chart or investment summary are being updated simulteniously.

#####**Stock Performance Chart**      

Graph plots selected US Blue chip company and market index price developments throughout the selected period of time.     

#####**Investment Performance Summary**      

Application calculates selected US Blue Chip Copmany's stock returns and compares them to the returns one whould have had if invested in the selected index instead of in an stock.



