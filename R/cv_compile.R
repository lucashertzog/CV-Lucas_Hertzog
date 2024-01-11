cv_compile <- function() {
  # Read the lines from cvtwo.tex
  lines <- readLines("skeleton.tex")
  
  # Create a temporary file for the new .tex document
  temp_file <- tempfile(fileext = ".tex")
  
  # Open the temporary file for writing
  file_conn <- file(temp_file, "w")
  
  # Iterate through each line in cvtwo.tex
  for (line in lines) {
    # Check if the line corresponds to a section
    if (grepl("^\\\\input\\{sections", line)) {
      # Extract the section name from the line
      section_name <- gsub("^\\\\input\\{sections/[0-9]+\\.(.*)\\.tex\\}$", "\\1", line)
      short_version <- grepl("_short", section_name)
      
      # Adjust section name for short versions
      if (short_version) {
        section_name <- gsub("_short", "", section_name)
      }
      
      # Decide whether to include this line based on cv_section settings
      if ((!short_version && get(section_name, envir = globalenv())) ||
          (short_version && get(paste0(section_name, "_short"), envir = globalenv()))) {
        writeLines(line, file_conn)
      }
    } else {
      # Write non-section lines directly to the file
      writeLines(line, file_conn)
    }
  }
  
  # Close the file connection
  close(file_conn)
  
  # Compile the LaTeX document
  latexmk(temp_file, engine = "xelatex")
  
  final_pdf_path <- "cv/cv_hertzog.pdf"
  temp_pdf_path <- gsub("\\.tex$", ".pdf", temp_file)
  file.rename(temp_pdf_path, final_pdf_path)
  
  # Clean up log files
  log_files <- list.files(pattern = "\\.log$")
  if (length(log_files) > 0) {
    file.remove(log_files)
  }
}
