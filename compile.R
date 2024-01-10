library(tinytex)
lapply(list.files("R", full.names = TRUE), source)

# Set the flags for including or excluding sections
config <- TRUE
contact <- TRUE
begin <- TRUE
education <- TRUE 
work_experience <- TRUE
publications <- TRUE
presentations <- TRUE
grants_awards <- TRUE
teaching <- TRUE
supervision <- TRUE
projects <- TRUE
policy <- TRUE
admin <- TRUE
academic_community <- TRUE
capacity_building <- TRUE
media <- TRUE
skills <- TRUE
referees <- TRUE
end <- TRUE

# Run the compilation function
compile_cv()
