library(tinytex)
lapply(list.files("R", full.names = TRUE), source)

# Set the flags for including or excluding sections
config <- TRUE
begin <- TRUE
end <- TRUE
contact <- TRUE

education <- FALSE
education_short <- TRUE

work_experience <- TRUE
work_experience_short <- FALSE

publications <- TRUE
publications_short <- FALSE

presentations <- TRUE
presentations_short <- FALSE

grants_awards <- TRUE
grants_awards_short <- FALSE

teaching <- TRUE
teaching_short <- FALSE

supervision <- TRUE
supervision_short <- FALSE

projects <- TRUE
projects_short <- FALSE

policy <- TRUE
policy_short <- FALSE

admin <- TRUE
admin_short <- FALSE

academic_community <- TRUE
academic_community_short <- FALSE

capacity_building <- TRUE
capacity_building_short <- FALSE

media <- TRUE
media_short <- FALSE

skills <- TRUE
skills_short <- FALSE

referees <- TRUE
referees_short <- FALSE

# Run the compilation function
compile_cv()
