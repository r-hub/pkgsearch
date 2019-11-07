
#' @export

pkg_search_addin <- function(viewer = c("dialog", "browser")) {

  wired <- character()
  data <- list(
    `cnt-search-next` = 0L,
    `cnt-search-prev` = 0L
  )

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
    shiny::htmlOutput(paste0("results-", id))
  }

  styles <- function() {
    shiny::HTML("
          .packagetitlerow span {
            vertical-align: middle;
          }
          .packagename {
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
          .paginate {
            padding-top: 10px;
            padding-bottom: 10px;
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
    header = shiny::tags$head(shiny::tags$style(styles()))
  )

  reactives <- reactiveValues(
    "search-next" = 0L,
    "search-prev" = 0L
  )

  server <- function(input, output, session) {
    output$`results-search` <- shiny::renderUI({
      simple_search(
        input$`query-search`,
        reactives$`search-prev`,
        reactives$`search-next`
      )
    })

    wire_menu(input, output)
  }

  wire_menu <- function(input, output) {
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
    if (! "search-prev" %in% wired) {
      wired <<- c(wired, "search-prev")
      observeEvent(
        input$`search-prev`, isolate({
          reactives$`search-prev` <- reactives$`search-prev` + 1
        })
      )
    }
    if (! "search-next" %in% wired) {
      wired <<- c(wired, "search-next")
      observeEvent(
        input$`search-next`, isolate({
          reactives$`search-next` <- reactives$`search-next` + 1
        })
      )
    }
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
      function(i) format_pkg(results[i,], id, i, meta$from)
    )
    paginate <- format_paginate(results, id)

    do.call(
      shiny::div,
      c(list(div(took)),
        pkgs,
        list(shiny::div(paginate, class = "paginate"))
      )
    )
  }

  format_paginate <- function(results, id) {
    meta <- attr(results, "metadata")
    has_prev <- meta$from != 1
    has_next <- meta$from + nrow(results) - 1L < meta$total
    btns <- zap_null(list(
      if (has_prev) actionButton(paste0(id, "-prev"), "Previous"),
      if (has_next) actionButton(paste0(id, "-next"), "Next")
    ))
    btns
  }

  format_pkg <- function(record, id, num, from) {
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
        class = "packagetitlerow",
        span(paste0(from + num - 1L, ". ")),
        span(
          shinyWidgets::dropdownButton(
            actionButton(
              paste0("btn-", id, "-", num, "-home"),
              label = "View home page (in browser)"
            ),
            actionButton(
              paste0("btn-", id, "-", num, "-cran"),
              label = "View on CRAN (in browser)"
            ),
            actionButton(
              paste0("btn-", id, "-", num, "-metacran"),
              label = "View on METACRAN (in browser)",
            ),
            actionButton(
              paste0("btn-", id, "-", num, "-source"),
              label = "Browse source code (in browser)"
            ),
            # actionButton(
            #   paste0("btn-", id, "-", num, -install"),
            #   label = "Install, with dependencies"
            # ),
            # actionButton(
            #  paste0("btn-", id, "-", num, "-bug"),
            #  label = "Report a bug about this package"
            #),
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

  simple_search <- function(query, btn_prev, btn_next) {

    # Create dependencies
    btn_next
    btn_prev

    if (identical(query, meta(data$search)$query)) {
      if (btn_next > data$`cnt-search-next`) {
        from <- meta(data$search)$from + meta(data$search)$size
        data$`cnt-search-next` <<- btn_next
      } else {
        from <- meta(data$search)$from - meta(data$search)$size
        data$`cnt-search-prev` <<- btn_prev
      }
    } else {
      from <- 1
    }

    if (is.null(query) || nchar(query) == 0) return(NULL)

    result <- pkg_search(query, from = from)
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
