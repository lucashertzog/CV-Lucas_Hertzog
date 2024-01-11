cv_compile <- function() {
  original_cv_lines <- readLines("cv.tex")
  cv_lines <- c()  # Initialize an empty vector to store the processed lines
  
  include_section <- function(tag, include, short_version = FALSE) {
    section_tag = ifelse(short_version, paste0(tag, "_short"), tag)
    section_start <- grep(paste0("%#", section_tag), original_cv_lines)
    section_end <- grep(paste0("%%", section_tag), original_cv_lines)

    if (length(section_start) == 0 || length(section_end) == 0) {
      warning(paste("Section markers for", section_tag, "not found. Skipping this section."))
      return(character(0))
    }

    if (include) {
      message("Including section: ", section_tag)
      return(original_cv_lines[section_start:section_end])
    } else {
      message("Excluding section: ", section_tag)
      return(character(0))
    }
  }

  # Concatenate each section to cv_lines based on flags
  cv_lines <- c(cv_lines, include_section("Config", config))
  cv_lines <- c(cv_lines, include_section("Contact", contact))
  cv_lines <- c(cv_lines, include_section("Contact Short", contact_short))
  cv_lines <- c(cv_lines, include_section("Begin", begin))
  cv_lines <- c(cv_lines, include_section("Education", education))
  cv_lines <- c(cv_lines, include_section("Education Short", education_short))
  cv_lines <- c(cv_lines, include_section("Work", work_experience))
  cv_lines <- c(cv_lines, include_section("Work Short", work_experience_short))
  cv_lines <- c(cv_lines, include_section("Awards Short", grants_awards_short))
  cv_lines <- c(cv_lines, include_section("UN Consultancy Short", un_consult_short))
  cv_lines <- c(cv_lines, include_section("UN Consultancy", un_consult))
  cv_lines <- c(cv_lines, include_section("Skills Short", skills_short))
  cv_lines <- c(cv_lines, include_section("Publications", publications))
  cv_lines <- c(cv_lines, include_section("Publications Short", publications_short))
  cv_lines <- c(cv_lines, include_section("Presentations", presentations))
  cv_lines <- c(cv_lines, include_section("Presentations Short", presentations_short))
  cv_lines <- c(cv_lines, include_section("Awards", grants_awards))
  cv_lines <- c(cv_lines, include_section("Teaching", teaching))
  cv_lines <- c(cv_lines, include_section("Teaching Short", teaching_short))
  cv_lines <- c(cv_lines, include_section("Supervision", supervision))
  cv_lines <- c(cv_lines, include_section("Supervision Short", supervision_short))
  cv_lines <- c(cv_lines, include_section("Projects", projects))
  cv_lines <- c(cv_lines, include_section("Projects Short", projects_short))
  cv_lines <- c(cv_lines, include_section("Policy", policy))
  cv_lines <- c(cv_lines, include_section("Policy Short", policy_short))
  cv_lines <- c(cv_lines, include_section("Admin", admin))
  cv_lines <- c(cv_lines, include_section("Admin Short", admin_short))
  cv_lines <- c(cv_lines, include_section("Service in the academic community", academic_community))
  cv_lines <- c(cv_lines, include_section("Service in the academic community Short", academic_community_short))
  cv_lines <- c(cv_lines, include_section("Capacity building", capacity_building))
  cv_lines <- c(cv_lines, include_section("Capacity building Short", capacity_building_short))
  cv_lines <- c(cv_lines, include_section("Media coverage", media))
  cv_lines <- c(cv_lines, include_section("Media coverage Short", media_short))
  cv_lines <- c(cv_lines, include_section("Skills", skills))
  cv_lines <- c(cv_lines, include_section("Referees", referees))
  cv_lines <- c(cv_lines, include_section("Referees Short", referees_short))
  cv_lines <- c(cv_lines, include_section("End", end))
  
  # Write to a temporary file and compile
  temp_file <- file.path("temp", "temp_cv.tex")
  writeLines(cv_lines, temp_file)
  tinytex::latexmk(temp_file, engine = "xelatex")
  
  # Rename and move the final PDF
  temp_pdf_path <- file.path("temp", "temp_cv.pdf")
  renamed_pdf_path <- file.path("temp", "cv_hertzog.pdf")
  file.rename(temp_pdf_path, renamed_pdf_path)
  final_pdf_path <- file.path("cv", "cv_hertzog.pdf")
  if (file.copy(renamed_pdf_path, final_pdf_path, overwrite = TRUE)) {
    file.remove(renamed_pdf_path)
  }
  file.remove("temp_cv.log")
}
