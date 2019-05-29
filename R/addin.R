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
      
     output$result <- DT::renderDataTable(
       pkgsearch::pkg_search(
            query = input$query,
                format = input$format,
                from = input$from,
                size = input$limit
      ))
  })}
  
  shiny::runGadget(ui, server)
}
