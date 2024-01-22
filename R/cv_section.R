# Define the constants
FULL <- "FULL"
SHORT <- "SHORT"
OMIT <- "OMIT"

cv_section <- function(...) {
  args <- list(...)
  for (section_name in names(args)) {
    include_option <- args[[section_name]]
    
    # Strip the numeric prefix for variable assignment
    variable_name <- gsub("^[0-9]+\\.", "", section_name)
    
    if (include_option == FULL) {
      assign(variable_name, TRUE, envir = globalenv())
      assign(paste0(variable_name, "_short"), FALSE, envir = globalenv())
    } else if (include_option == SHORT) {
      assign(variable_name, FALSE, envir = globalenv())
      assign(paste0(variable_name, "_short"), TRUE, envir = globalenv())
    } else if (include_option == OMIT) {
      assign(variable_name, FALSE, envir = globalenv())
      assign(paste0(variable_name, "_short"), FALSE, envir = globalenv())
    } else {
      stop("Invalid inclusion option for section '", section_name, "'. Options are FULL, SHORT, or OMIT.")
    }
  }
}