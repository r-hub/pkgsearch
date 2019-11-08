
#' RStudio addin to search CRAN packages
#'
#' Call this function from RStudio.
#'
#' @param query Query string to start the addin with.
#' @param viewer Whether to show the addin within RStudio (`"dialog"`),
#'   or in a web browser (`"browser"`).
#'
#' @export

pkg_search_addin <- function(
  query = "",
  viewer = c("dialog", "browser")) {

  query

  wired <- character()
  data <- list(
    `cnt-search-prev` = 0L,
    `cnt-search-next` = 0L,
    `cnt-new-prev`    = 0L,
    `cnt-new-next`    = 0L,
    `cnt-topdl-prev`  = 0L,
    `cnt-topdl-next`  = 0L
  )

  needs_packages(c("memoise", "shiny", "shinyjs", "shinyWidgets"))

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
      value = query,
      placeholder = "Write your search query here..."
    )
  }

  searchResults <- function(id) {
    shiny::htmlOutput(paste0("results-", id))
  }

  ui <- shiny::navbarPage("Package search",
    shiny::tabPanel("Search", searchQuery("search"), searchResults("search")),
    shiny::tabPanel("Advanced search", searchResults("advanced")),
    shiny::tabPanel("New packages", searchResults("new")),
    shiny::navbarMenu("Top packages",
      tabPanel("Top downloaded", searchResults("topdl")),
      tabPanel("Most depended upon", searchResults("topdep")),
      tabPanel("Trending packages", searchResults("toptrend"))
    ),
    shiny::tabPanel("My packages", shiny::tableOutput("table3")),
    header = shiny::tagList(
      shiny::tags$head(shiny::tags$style(addin_styles())),
      shinyjs::useShinyjs()
    )
  )

  reactives <- shiny::reactiveValues(
    "search-prev" = 0L,
    "search-next" = 0L,
    "new-prev" = 0L,
    "new-next" = 0L,
    "topdl-prev" = 0L,
    "topdl-next" = 0L
  )

  server <- function(input, output, session) {
    output$`results-search` <- shiny::renderUI({
      ret <- simple_search(
        input$`query-search`,
        reactives$`search-prev`,
        reactives$`search-next`
      )
      shinyjs::runjs("window.scrollTo(0, 0)")
      ret
    })

    output$`results-new` <- shiny::renderUI({
      ret <- new_search(
        reactives$`new-prev`,
        reactives$`new-next`
      )
      shinyjs::runjs("window.scrollTo(0, 0)")
      ret
    })

    output$`results-topdl` <- shiny::renderUI({
      ret <- topdl_search(
        reactives$`topdl-prev`,
        reactives$`topdl-next`
      )
      shinyjs::runjs("window.scrollTo(0, 0)")
      ret
    })

    wire_menu(input, output)
  }

  wire_menu <- function(input, output) {
    lapply(c("search", "new", "topdl"), function(tab) {
      lapply(1:10, function(i) {
        id <- paste0("btn-", tab, "-", i, "-cran")
        if (! id %in% wired) {
          wired <<- c(wired, id)
          shiny::observeEvent(input[[id]], action_cran(tab, i))
        }
      })
      lapply(1:10, function(i) {
        id <- paste0("btn-", tab, "-", i, "-metacran")
        if (! id %in% wired) {
          wired <<- c(wired, id)
          shiny::observeEvent(input[[id]], action_metacran(tab, i))
        }
      })
      lapply(1:10, function(i) {
        id <- paste0("btn-", tab, "-", i, "-source")
        if (! id %in% wired) {
          wired <<- c(wired, id)
          shiny::observeEvent(input[[id]], action_source(tab, i))
        }
      })
      id1 <- paste0(tab, "-prev")
      if (! id1 %in% wired) {
        wired <<- c(wired, id1)
        shiny::observeEvent(
          input[[id1]],
          shiny::isolate(reactives[[id1]] <- reactives[[id1]] + 1)
        )
      }
      id2 <- paste0(tab, "-next")
      if (! id2 %in% wired) {
        wired <<- c(wired, id2)
        shiny::observeEvent(
          input[[id2]],
          shiny::isolate(reactives[[id2]] <- reactives[[id2]] + 1)
        )
      }
    })
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

  new_search <- function(btn_prev, btn_next) {

    btn_prev
    btn_next

    if (btn_next > data$`cnt-new-next`) {
      from <- meta(data$new)$from + meta(data$new)$size
      data$`cnt-new-next` <<- btn_next
    } else if (btn_prev > data$`cnt-new-prev`) {
      from <- meta(data$new)$from - meta(data$new)$size
      data$`cnt-new-prev` <<- btn_prev
    } else {
      from <- 1
    }

    result <- rectangle_events(cran_events(archivals = FALSE, from = from))
    attr(result, "metadata") <- list(from = from, size = 10, total = 15000)
    data$new <<- result
    format_results(result, "new")
  }

  topdl_search <- function(btn_prev, btn_next) {

    btn_prev
    btn_next

    if (btn_next > data$`cnt-topdl-next`) {
      from <- meta(data$topdl)$from + meta(data$topdl)$size
      data$`cnt-topdl-next` <<- btn_next
    } else if (btn_prev > data$`cnt-topdl-prev`) {
      from <- meta(data$topdl)$from - meta(data$topdl)$size
      data$`cnt-topdl-prev` <<- btn_prev
    } else {
      from <- 1
    }

    result <- get_topdl(from = from)
    attr(result, "metadata") <- list(from = from, size = 10, total = 100)
    data$topdl <<- result
    format_results(result, "topdl")
  }

  # Cache the top downloaded packages for one hour
  get_topdl <- memoise::memoise(get_topdl0, ~ memoise::timeout(60 * 60))

  action_cran <- function(set, row) {
    package <- data[[set]]$package[[row]]
    url <- paste0("https://cloud.r-project.org/package=", package)
    utils::browseURL(url)
  }

  action_metacran <- function(set, row) {
    package <- data[[set]]$package[[row]]
    url <- paste0("https://r-pkg.org/pkg/", package)
    utils::browseURL(url)
  }

  action_source <- function(set, row) {
    package <- data[[set]]$package[[row]]
    url <- paste0("https://github.com/cran/", package)
    utils::browseURL(url)
  }

  shiny::runGadget(ui, server, viewer = viewer)
}

highlight_urls <- function(txt) {
  gsub("(https?://[^\\s,;]+)", "<a href=\"\\1\">\\1</a>", txt, perl = TRUE)
}

addin_styles <- function() {
  shiny::HTML("
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

format_results <- function(results, id) {
  if (is.null(results)) return(NULL)
  meta <- attr(results, "metadata")
  took <- format_took(results)
  pkgs <- lapply(
    seq_len(nrow(results)),
    function(i) format_pkg(results[i,], id, i, meta$from)
  )
  paginate <- format_paginate(results, id)

  do.call(
    shiny::div,
    c(list(shiny::div(took)),
      pkgs,
      list(shiny::div(paginate, class = "paginate"))
    )
  )
}

format_took <- function(results) {
  meta <- meta(results)
  page <- if (meta$from != 1) {
    paste0("Page ", (meta$from - 1)/meta$size + 1)
  }
  if (is.null(meta$took)) return(page)

  paste0(
    if (meta$from != 1) paste0(page, " of "),
    meta$total,
    if (meta$total == 1) " package, " else " packages, ",
    "found in ",
    round(meta$took / 1000, 3),
    " seconds"
  )
}

format_paginate <- function(results, id) {
  meta <- attr(results, "metadata")
  has_prev <- meta$from != 1
  has_next <- meta$from + nrow(results) - 1L < meta$total
  btns <- zap_null(list(
    if (has_prev) shiny::actionButton(paste0(id, "-prev"), "Previous"),
    if (has_next) shiny::actionButton(paste0(id, "-next"), "Next")
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
  shiny::p(
    shiny::div(
      class = "packagetitlerow",
      shiny::span(
        shinyWidgets::dropdownButton(
          shiny::actionButton(
            paste0("btn-", id, "-", num, "-home"),
            label = "View home page (in browser)"
          ),
          shiny::actionButton(
            paste0("btn-", id, "-", num, "-cran"),
            label = "View on CRAN (in browser)"
          ),
          shiny::actionButton(
            paste0("btn-", id, "-", num, "-metacran"),
            label = "View on METACRAN (in browser)",
          ),
          shiny::actionButton(
            paste0("btn-", id, "-", num, "-source"),
            label = "Browse source code (in browser)"
          ),
          # shiny::actionButton(
          #   paste0("btn-", id, "-", num, -install"),
          #   label = "Install, with dependencies"
          # ),
          # shiny::actionButton(
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
      shiny::span(by, class = "packageauthor")
    ),
    shiny::div(
      shiny::div(record$title, class = "packagetitle"),
      shiny::div(
        clean_description(record$description),
        class = "packagedescription"
      ),
      if (!is.na(record$url)) {
        shiny::div(shiny::HTML(highlight_urls(record$url)), class = "packageurl")
      }
    )
  )
}

get_topdl0 <- function(from) {
  dl <- cran_top_downloaded()
  pkgs <- cran_packages(dl$package[from:(from + 10 - 1)])
  rectangle_pkgs(pkgs)
}

rectangle_pkgs <- function(pkgs) {
  maintainer <- parse_maint(pkgs$Maintainer)
  tibble::tibble(
    package =          pkgs$Package,
    version =          pkgs$Version,
    title =            pkgs$Title,
    description =      pkgs$Description,
    date =             parsedate::parse_iso_8601(pkgs$date),
    maintainer_name =  maintainer$maintainer_name,
    maintainer_email = maintainer$maintainer_email,
    license =          pkgs$License,
    url =              pkgs$URL,
    bugreports =       pkgs$BugReports,
  )
}

parse_maint <- function(x) {
  tibble::tibble(
    maintainer_name = gsub("\\s+<.*$", "", x),
    maintainer_email = gsub("^.*<([^>]+)>.*$", "\\1", x, perl = TRUE)
  )
}

rectangle_events <- function(ev) {
  maintainer <- parse_maint(map_chr(ev, function(x) x$package$Maintainer %||% NA_character_))
  tibble::tibble(
    package =          map_chr(ev, function(x) x$package$Package),
    version =          map_chr(ev, function(x) x$package$Version),
    title =            map_chr(ev, function(x) x$package$Title),
    description =      map_chr(ev, function(x) x$package$Description),
    date =
      parsedate::parse_iso_8601(map_chr(ev, "[[", "date")),
    maintainer_name =  maintainer$maintainer_name,
    maintainer_email = maintainer$maintainer_email,
    license =          map_chr(ev, function(x) x$package$License),
    url =
      map_chr(ev, function(x) x$package$URL %||% NA_character_),
    bugreports =
      map_chr(ev, function(x) x$package$BugReports %||% NA_character_),
    package_data =     map(ev, "[[", "package")
  )
}
