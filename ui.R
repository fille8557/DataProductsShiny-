shinyUI(fluidPage(
    titlePanel("Height Prediction Model"), 
    sidebarLayout(
        sidebarPanel( 
            p("Using a historical dataset, I want to try and predict 
            your height, given only your parents' heights."),
            br(),
            p("First, I need some basic information:"),
            radioButtons("units", label=h5("Units"),
                choices=list("cenitmeters"="centimeters", "inches"
                             ="inches")),
            radioButtons("sex", label=h5("You are:"),
                choices=list("Male"="male", "Female"="female")),
            br(),
            p("Now I need your parents' heights:"),
            br(),
            numericInput("momh", label=h5("Your mother's height"),
                value=60, step=0.1),
            numericInput("dadh", label=h5("Your father's height"),
                 value=60, step=0.1),
            br(),
            p("When you're ready, click the Update button to get the
                prediction"),
            actionButton("update", "Update")),
    mainPanel(
        br(),
        strong("Here's a summary of the data you gave me:"),
        br(),
        textOutput("text1"),
        br(),
        textOutput("text2"),
        br(),
        strong("Here are my predictions:"),
        h6("if you change something on 
               the left, make sure to click the update button to get 
               the new prediction"),
        br(),
        textOutput("calc1"),
        br(),
        textOutput("calc2"),
        br(),
        strong("A few notes on this prediction tool:"),
        h6("This prediction is based on a simple linear model of the 
           GatlonFamilies dataset from the UsingR package. A separate 
           model was created for males and females. A 90% prediction 
           interval was used. The data is given in inches, and the 
           final result was multiplied by 2.54 to give the height in 
           centimeters."))
)))