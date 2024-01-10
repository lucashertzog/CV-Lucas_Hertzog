# Function to set section flags for a list of sections
full_section <- function(
    sections, 
    include_main
    ){
  for (section_name in sections) {
    assign(
      section_name, 
      include_main, 
      envir = globalenv()
      )
    assign(
      paste0(section_name, "_short"), 
      !include_main, 
      envir = globalenv()
      )
  }
}


# # Function to set section flags
# full_section <- function(
#     section_name, 
#     include_main
#     ){
#   assign(
#     section_name,
#     include_main, 
#     envir = globalenv()
#     )
#   assign(
#     paste0(section_name, "_short"), 
#     !include_main, 
#     envir = globalenv()
#     )
# }