#' @export
embed_png <- function(path, dpi = NULL) {
  meta <- attr(png::readPNG(path, native = TRUE, info = TRUE), "info")
  if (!is.null(dpi)) meta$dpi <- rep(dpi, 2)

  if (identical(doc_type(), "latex")) {
    width <- round(meta$dim[1] / meta$dpi[1], 2)
    if (width > 4.35) width <- 4.35

    knitr::asis_output(paste0(
      "\\includegraphics[",
      "width=", width, "in",
      "]{", path, "}"
    ))
  } else {
    knitr::asis_output(paste0(
      "<img src='", path, "'",
      " width=", round(meta$dim[1] / (meta$dpi[1] / 96)),
      " height=", round(meta$dim[2] / (meta$dpi[2] / 96)),
      " />"
    ))
  }
}

doc_type <- function() knitr::opts_knit$get('rmarkdown.pandoc.to')
