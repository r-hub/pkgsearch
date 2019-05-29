package_search <- function() {
  if (!requireNamespace("shiny", quietly = TRUE)) {
    stop("The shiny package is required for this gadget to work. Please install it.",
         call. = FALSE
    )
  }
  
  if (!requireNamespace("miniUI", quietly = TRUE)) {
    stop("The miniUI package is required for this gadget to work. Please install it.",
         call. = FALSE
    )
  }  
  
  if (!requireNamespace("DT", quietly = TRUE)) {
    stop("The DT package is required for this gadget to work. Please install it.",
         call. = FALSE
    )
  }  
  
  if (!requireNamespace("rstudioapi", quietly = TRUE)) {
    stop("The rstudioapi package is required for this gadget to work. Please install it.",
         call. = FALSE
    )
  }
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
      
      res$url <- lapply(res$url, strsplit, ",")
      res$url <- lapply(res$url, format_urls)
      res$bugreports <- format_url(res$bugreports)
      res$package <- format_url(paste0("https://r-pkg.org/pkg/", res$package),
                                res$package)
      
     output$result <- DT::renderDataTable(
       res[, colnames(res) != "package_data"],
      options = list(scrollX = TRUE),
      escape = FALSE, width = "100%")
  })}
  
  shiny::runGadget(ui, server)
}

format_url <- function(url, name = url){
  paste0('<a href="', url, '" target="_blank">', name, '</a>')
}

format_urls <- function(urls){
  l <- unlist(lapply(urls, format_url))
  toString(l)
}

