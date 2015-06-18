library(shiny)
library(UsingR)
##use simple linear model of galton data separated by male and female children
data(GaltonFamilies)
fitm<- lm(childHeight~midparentHeight, gender=="male", data=GaltonFamilies)
fitf<- lm(childHeight~midparentHeight, gender=="female", data=GaltonFamilies)

shinyServer(function(input, output) {
        ##reactive statements
        calcunits <- reactive({
                switch(input$units,
                       "centimeters"=0.393701,
                       "inches"=1)
        })
        finalunits <- reactive({
                switch(input$units,
                       "centimeters"=2.54,
                       "inches"=1)
        })
        midheight <- reactive({
                (((input$momh*1.08)+input$dadh)/2)*calcunits()
        })
        df <- reactive({
                data.frame(midparentHeight=midheight())
        })
        gender <- reactive({
                switch(input$sex,
                       "male"= predict(fitm, df(), 
                                       interval="prediction",
                                       level=0.90),
                       "female"= predict(fitf, df(), 
                                         interval="prediction",
                                         level=0.90))
        })
        predictfinal <- reactive({
                round(gender()[1]*finalunits(),1)
        })
   
        
        ##output statements
        output$text1 <- renderText({ 
                paste("Your mother's height is", input$momh," ", 
                      input$units)
        })
        output$text2 <- renderText({
                paste("Your father's height is", input$dadh, " ",
                      input$units)
        })

        output$calc1 <- renderText({
                if(input$update>=1)
                isolate(paste("Your predicted height is", 
                      predictfinal(),
                      input$units))
                else "click the Update button"
        })
        output$calc2 <- renderText({
                if(input$update>=1)
                isolate(paste("Not quite right? Well, I'm pretty sure 
                        that you are between", 
                      round(gender()[2]*finalunits(),1),"and",
                      round(gender()[3]*finalunits(),1),input$units))
                else "click the Update button"
        })
        
})