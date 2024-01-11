# Define the constants
FULL <- "FULL"
SHORT <- "SHORT"
OMIT <- "OMIT"

# Modified cv_section function to handle named arguments
cv_section <- function(...) {
  args <- list(...)
  for (section_name in names(args)) {
    include_option <- args[[section_name]]
    
    if (include_option == FULL) {
      assign(section_name, TRUE, envir = globalenv())
      assign(paste0(section_name, "_short"), FALSE, envir = globalenv())
    } else if (include_option == SHORT) {
      assign(section_name, FALSE, envir = globalenv())
      assign(paste0(section_name, "_short"), TRUE, envir = globalenv())
    } else if (include_option == OMIT) {
      assign(section_name, FALSE, envir = globalenv())
      assign(paste0(section_name, "_short"), FALSE, envir = globalenv())
    } else {
      stop("Invalid inclusion option for section '", section_name, "'. Options are FULL, SHORT, or OMIT.")
    }
  }
}