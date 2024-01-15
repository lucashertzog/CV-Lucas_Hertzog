cv_compile <- function(
    final_pdf_path = "cv/cv_hertzog.pdf"
){
  # Read the lines from 00.index.tex
  lines <- readLines("sections/00.index.tex")
  
  # Create a temporary file for the new .tex document
  temp_file <- tempfile(fileext = ".tex")
  
  # Open the temporary file for writing
  file_conn <- file(temp_file, "w")
  
  # Explicitly include config.tex at the beginning
  writeLines("\\input{config/config.tex}", file_conn)
  
  for (section in section_order) {
    section_full <- paste0("sections/", section, ".tex")
    section_short <- paste0("sections/", section, "_short.tex")
    
    # Strip the numeric prefix for condition check
    variable_name <- gsub("^[0-9]+\\.", "", section)
    
    if (get(variable_name, envir = globalenv())) {
      writeLines(paste0("\\input{", section_full, "}"), file_conn)
    } else if (get(paste0(variable_name, "_short"), envir = globalenv())) {
      writeLines(paste0("\\input{", section_short, "}"), file_conn)
    }
    if (section %in% pg_break) {
      writeLines("\\newpage", file_conn)
    }
  }
  
  writeLines("\\end{document}", file_conn)
  
  # Close the file connection
  close(file_conn)
  
  # Compile the LaTeX document
  latexmk(temp_file, engine = "xelatex")
  
  temp_pdf_path <- gsub("\\.tex$", ".pdf", temp_file)
  file.rename(temp_pdf_path, final_pdf_path)
  
  # Convert the relative path to an absolute path
  final_pdf_absolute_path <- normalizePath(final_pdf_path, mustWork = FALSE)
  
  # Clean up log files
  log_files <- list.files(pattern = "\\.log$")
  if (length(log_files) > 0) {
    file.remove(log_files)
  }
  
  # Open the PDF if on Windows
  if (.Platform$OS.type == "windows") {
    shell.exec(final_pdf_absolute_path)
  } else {
    # For macOS and Linux
    system(paste("open", shQuote(final_pdf_absolute_path)))
  }
}
