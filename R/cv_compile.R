cv_compile <- function(
    final_pdf_path = "outdir/cv_hertzog.pdf"
) {
  # Create temporary structured .tex file
  temp_file <- tempfile(fileext = ".tex")
  file_conn <- file(temp_file, "w")
  
  # Write structure
  writeLines("\\input{config/config.tex}", file_conn)
  
  for (section in section_order) {
    section_full <- paste0("cv/", section, ".tex")
    section_short <- paste0("cv/", section, "_short.tex")
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
  close(file_conn)
  
  # Flatten into main_cv.tex
  main_file <- "outdir/main_cv.tex"
  script_path <- file.path(tinytex::tinytex_root(), "texmf-dist", "scripts", "latexpand", "latexpand")
  cmd <- sprintf('perl "%s" %s', script_path, temp_file)
  flattened <- system(cmd, intern = TRUE)
  writeLines(flattened, main_file)
  
  # Compile flattened file
  latexmk(main_file, engine = "xelatex", bib_engine = "biber")
  
  # Copy resulting PDF to target location
  compiled_pdf <- gsub("\\.tex$", ".pdf", normalizePath(main_file, mustWork = TRUE))
  file.copy(compiled_pdf, final_pdf_path, overwrite = TRUE)
  file.remove(compiled_pdf)
  
  # Optional cleanup
  log_files <- list.files(pattern = "\\.log$")
  if (length(log_files) > 0) {
    file.remove(log_files)
  }
  
  # Open PDF
  final_pdf_absolute_path <- normalizePath(final_pdf_path, mustWork = FALSE)
  if (.Platform$OS.type == "windows") {
    shell.exec(final_pdf_absolute_path)
  } else {
    system(paste("open", shQuote(final_pdf_absolute_path)))
  }
}
