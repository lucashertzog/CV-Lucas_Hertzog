criteria_compile <- function(
    final_pdf_path = "outdir/criteria_hertzog.pdf"
){
  # Convert DOCX to TEX
  docx_file <- "criteria/criteria.docx"
  tex_file <- gsub("\\.docx$", ".tex", docx_file)
  system(paste("pandoc", docx_file, "-s -o", tex_file))
  
  # Read and process the converted TEX file
  tex <- "criteria/criteria.tex"
  lines <- readLines(tex)
  
  # Find the index where the section "Essential" starts
  start_index <- grep("^\\\\section\\{Essential\\}", lines)
  
  # Process lines starting from the "Essential" section onwards
  processed_lines <- lines[start_index:length(lines)]
  
  # Create a temporary file for the new .tex document
  temp_file <- tempfile(fileext = ".tex")
  
  # Open the temporary file for writing
  file_conn <- file(temp_file, "w")
  
  # Explicitly include config.tex at the beginning
  writeLines("\\input{config/config_criteria.tex}", file_conn)
  writeLines("\\input{criteria/01.begin_criteria.tex}", file_conn)
  writeLines("\\input{criteria/02.header_criteria.tex}", file_conn)
  writeLines(processed_lines, file_conn)
  
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
