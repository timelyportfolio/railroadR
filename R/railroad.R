#' Railroad Diagram
#'
#' Create interactive railroad diagrams for use in html.
#' 
#' @param ... string arguments to form the diagram spec
#' @param width,height width and height in any valid CSS unit for
#'                the htmlwidget container
#'
#' @example inst/examples/examples.R
#' @import htmlwidgets
#'
#' @export
railroad <- function(..., width = NULL, height = NULL) {
  diagram <- lazyeval::auto_name(lazyeval::lazy_dots(...))
  
  # forward options using x
  x = list(
    diagram = unname(lapply(
      diagram,
      function(x) as.character(unclass(x)[1])
    ))
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'railroad',
    x,
    width = width,
    height = height,
    package = 'railroadR'
  )
}

#' Shiny bindings for railroad
#'
#' Output and render functions for using railroad within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a railroad
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name railroad-shiny
#'
#' @export
railroadOutput <- function(outputId, width = '100%', height = '400px'){
  shinyWidgetOutput(outputId, 'railroad', width, height, package = 'railroadR')
}

#' @rdname railroad-shiny
#' @export
renderRailroad <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  shinyRenderWidget(expr, railroadOutput, env, quoted = TRUE)
}
