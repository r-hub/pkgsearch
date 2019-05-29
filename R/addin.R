package_search <- function() {
  
  ui <- miniUI::miniPage(
    miniUI::gadgetTitleBar("Search Packages"),
      shiny::inputPanel(
        shiny::textInput(
          "query",
          label = "Query",
          value = ""
        ),
        shiny::radioButtons("format",
                            label = "format",
                            choices = c("short", "long"),
                            select = "short"
        ),
       shiny::numericInput("from",
                           label = "From",
                           value = 1),
    shiny::numericInput("limit",
                        label = "Limit",
                        value = 10)   
      ),
    shiny::mainPanel(
      DT::dataTableOutput("result")
    )
    
)
  
  server <- function(input, output, session) {
    
    shiny::observeEvent(input$done, {
      #shiny::stopApp()
      
      res <- pkgsearch::pkg_search(
        query = input$query,
        format = input$format,
        from = input$from,
        size = input$limit
      )
      res$bugreports <-
        paste0('<a href="', res$bugreports,
               '" target="_blank">', res$bugreports,
               '</a>')
     output$result <- DT::renderDataTable(
       res[, colnames(res) != "package_data"],
      options = list(scrollX = TRUE),
      escape = FALSE)
  })}
  
  shiny::runGadget(ui, server)
}
