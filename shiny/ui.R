# Define UI for application that draws a histogram
shinyUI(
    
    shiny::navbarPage(
        title = "Anomaly Datasets",
        
        shiny::tabPanel(
            title = "UCR",
            sidebarLayout(
                sidebarPanel(
                    width = 2,
                    selectInput("ucr_tab",
                                "Tables:",
                                ucr_tables)
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                    width = 10,
                    uiOutput("ucr_md"),
                    plotlyOutput("ucr_plot")
                )
            )
        ),
        
        shiny::tabPanel(
            title = "NAB",
            sidebarLayout(
                sidebarPanel(
                    width = 2,
                    selectInput("nab_tab",
                                "Tables:",
                                nab_tables)
                ),
                
                # Show a plot of the generated distribution
                mainPanel(
                    width = 10,
                    uiOutput("nab_md"),
                    plotlyOutput("nab_plot")
                )
            )
            
        )
    )
    
)
