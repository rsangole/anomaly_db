# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    ucr_data <- reactive({
        con %>% 
            tbl(input$ucr_tab) %>% 
            filter(part == "train") %>% 
            mutate(id = as.character(id)) %>% 
            collect()
    })
    
    ucr_meta <- reactive({
        con %>% 
            tbl("ucr_00_meta") %>% 
            filter(table == local(input$ucr_tab)) %>% 
            pull(meta)
    })
    
    output$ucr_md <- renderUI({
        markdown(ucr_meta())
    })
    
    output$ucr_plot <- renderPlotly({

        ucr_data() %>% 
            ggplot(aes(x = time,
                   y = value,
                   color = id)) +
            geom_line() +
            facet_wrap(~ class) -> p
        
        ggplotly(p)

    })
    
    nab_data <- reactive({
        con %>% 
            tbl(input$nab_tab) %>% 
            collect()
    })

    output$nab_plot <- renderPlotly({
        
        nab_data() %>% 
            ggplot(aes(x = time,
                       y = value,
                       color = cat)) +
            geom_line() +
            facet_wrap(~ cat,
                       scales = "free",
                       ncol = 1) -> p
        
        ggplotly(p)
        
    })
})
