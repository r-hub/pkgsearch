
#' @export

pkg_search_addin <- function(viewer = c("dialog", "browser")) {

  data <- list()
  wired <- character()

  needs_packages(c("shiny", "shinyWidgets"))

  if (is.character(viewer)) {
    mode <- match.arg(viewer)
    if (mode == "dialog") {
      viewer <- shiny::dialogViewer(
        "Package search",
        width = 800,
        height = 600
      )
    } else {
      viewer <- shiny::browserViewer()
    }
  }

  searchQuery <- function(id) {
    shiny::textInput(
      paste0("query-", id),
      label = NULL,
      value = "",
      placeholder = "Write your search query here..."
    )
  }

  searchResults <- function(id) {
    htmlOutput(paste0("results-", id))
  }

  styles <- function() {
    HTML(".packagename {
            margin-top: 20px;
          }
          .packagename .dropdown-menu {
            margin-top: 10px;
            padding: 0;
            border: 0;
          }
          .packagename li .btn {
            text-align: left;
            padding: 4px;
            font-size: 80%;
            border-radius: 0;
            width: 100%;
          }
          .btn-package {
            font-size: 140%;
            color: rgb(51, 122, 183);
            border: none;
            padding-left: 0px;
          }
          .packageauthor {
            color: #888;
            font-style: italic;
            font-size: 90%;
            padding-right: 10px;
          }
          .packagetitle {
            font-size: 110%;
            margin-bottom: 5px;
          }
          "
        )
  }

  ui <- shiny::navbarPage("Package search",
    shiny::tabPanel("Search", searchQuery("search"), searchResults("search")),
    shiny::tabPanel("Advanced search", shiny::verbatimTextOutput("summary")),
    shiny::tabPanel("New packages", shiny::tableOutput("table")),
    shiny::tabPanel("Top packages", shiny::tableOutput("table2")),
    shiny::tabPanel("My packages", shiny::tableOutput("table3")),
    header = tags$head(tags$style(styles()))
  )

  server <- function(input, output, session) {
    output$`results-search` <-
      shiny::renderUI(simple_search(input$`query-search`))
    wire_menu(input)
  }

  wire_menu <- function(input) {
    lapply(1:10, function(i) {
      id <- paste0("btn-search-", i, "-cran")
      if (! id %in% wired) {
        wired <<- c(wired, id)
        observeEvent(input[[id]], action_cran("search", i))
      }
    })
    lapply(1:10, function(i) {
      id <- paste0("btn-search-", i, "-metacran")
      if (! id %in% wired) {
        wired <<- c(wired, id)
        observeEvent(input[[id]], action_metacran("search", i))
      }
    })
    lapply(1:10, function(i) {
      id <- paste0("btn-search-", i, "-source")
      if (! id %in% wired) {
        wired <<- c(wired, id)
        observeEvent(input[[id]], action_source("search", i))
      }
    })
  }

  format_results <- function(results, id) {
    if (is.null(results)) return(NULL)
    meta <- attr(results, "metadata")
    took <- paste0(
      "Found ",
      meta$total,
      if (meta$total == 1) " package " else " packages ",
      "in ",
      round(meta$took / 1000, 3),
      " seconds"
    )
    pkgs <- lapply(
      seq_len(nrow(results)),
      function(i) format_pkg(results[i,], paste0(id, "-", i))
    )
    do.call(shiny::div, c(list(div(took)), pkgs))
  }

  format_pkg <- function(record, id) {
    by <- paste0(
      "\u2014 version ",
      record$version,
      ", by ",
      record$maintainer_name,
      ", ",
      time_ago(record$date)
    )
    p(
      div(
        span(
          shinyWidgets::dropdownButton(
            actionButton(
              paste0("btn-", id, "-home"),
              label = "View home page (external)"
            ),
            actionButton(
              paste0("btn-", id, "-cran"),
              label = "View on CRAN (external)"
            ),
            actionButton(
              paste0("btn-", id, "-metacran"),
              label = "View on METACRAN (external)",
            ),
            actionButton(
              paste0("btn-", id, "-source"),
              label = "Browse source code (external)"
            ),
            actionButton(
              paste0("btn-", id, "-install"),
              label = "Install, with dependencies"
            ),
            actionButton(
              paste0("btn-", id, "-bug"),
              label = "Report a bug about this package"
            ),
            label = record$package,
            circle = FALSE,
            inline = TRUE,
            size = "sm",
            status = "package",
            margin = "0"
          ),
          class = "packagename"
        ),
        span(by, class = "packageauthor")
      ),
      div(
        div(record$title, class = "packagetitle"),
        div(
          clean_description(record$description),
          class = "packagedescription"
        ),
        if (!is.na(record$url)) {
          div(HTML(highlight_urls(record$url)), class = "packageurl")
        }
      )
    )
  }

  simple_search <- function(query) {
    if (is.null(query) || nchar(query) == 0) return(NULL)
    result <- pkg_search(query)
    data$search <<- result
    format_results(result, "search")
  }

  action_cran <- function(set, row) {
    package <- data[[set]]$package[[row]]
    url <- paste0("https://cloud.r-project.org/package=", package)
    browseURL(url)
  }

  action_metacran <- function(set, row) {
    package <- data[[set]]$package[[row]]
    url <- paste0("https://r-pkg.org/pkg/", package)
    browseURL(url)
  }

  action_source <- function(set, row) {
    package <- data[[set]]$package[[row]]
    url <- paste0("https://github.com/cran/", package)
    browseURL(url)
  }

  shiny::runGadget(ui, server, viewer = viewer)
}

highlight_urls <- function(txt) {
  gsub("(https?://[^\\s,;]+)", "<a href=\"\\1\">\\1</a>", txt, perl = TRUE)
}
