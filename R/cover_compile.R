cover_compile <- function(
    final_pdf_path = "outdir/cover_hertzog.pdf"
){
  # Convert DOCX to TEX
  docx_file <- "cover/cover.docx"
  tex_file <- gsub("\\.docx$", ".tex", docx_file)
  system(paste("pandoc", docx_file, "-s -o", tex_file))
  
  # Read and process the converted TEX file
  tex <- "cover/cover.tex"
  lines <- readLines(tex)
  start_index <- grep("^Dear", lines)
  processed_lines <- lines[start_index:length(lines)]
  
  # Create a temporary file for the new .tex document
  temp_file <- tempfile(fileext = ".tex")
  
  # Open the temporary file for writing
  file_conn <- file(temp_file, "w")
  
  # Explicitly include config.tex at the beginning
  writeLines("\\input{config/config_cover.tex}", file_conn)
  writeLines("\\input{cover/01.begin_cover.tex}", file_conn)
  writeLines("\\input{cover/02.header_cover.tex}", file_conn)
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
