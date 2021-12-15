# copied from https://github.com/ErdaradunGaztea/versionsort

ver_order <- function(x) {
  version_components <- strsplit(x, "[^\\w]+", perl = TRUE)
  Reduce(
    function(list_order, position) {
      # Extract n-th components of version code
      # Empty components are extracted as NA (e.g. 4-th component of 1.5.0)
      nth_components <- vapply(
        version_components[list_order], `[`, FUN.VALUE = character(1), position
      )
      # Separate NA components
      empty_components_indices <- which(is.na(nth_components))
      other_components_indices <- which(!is.na(nth_components))
      nth_components <- nth_components[other_components_indices]
      # Split components into initial numeric value and additional code
      # e.g. "0b8a" => 0 + "b8a"
      initial_number_match <- regexpr("^\\d+", nth_components)
      initial_number <- as.numeric(
        substring(nth_components, 1, attr(
          initial_number_match, "match.length", exact = TRUE)
        )
      )
      additional_code <- substring(nth_components, 1 + attr(
        initial_number_match, "match.length", exact = TRUE)
      )
      # Order code alphabetically, then number numerically
      # Append empty components' indices at the beginning
      code_order <- order(additional_code, na.last = TRUE)
      list_order[
        c(empty_components_indices,
          other_components_indices[code_order][order(initial_number[code_order], na.last = TRUE)])
      ]
    },
    rev(seq_len(max(lengths(version_components)))),
    init = seq_along(version_components)
  )
}

ver_sort <- function(x) {
  x[ver_order(x)]
}