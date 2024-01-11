library(tinytex)
lapply(list.files("R", full.names = TRUE), source)

cv_section(
  begin = FULL,
  end = FULL,
  config = FULL,
  contact = FULL,
  education = OMIT,
  work_experience = OMIT,
  grants_awards = SHORT,
  un_consult = FULL,
  skills = SHORT,
  publications = FULL,
  presentations = SHORT,
  teaching = SHORT,
  projects  = SHORT,
  supervision = SHORT,
  policy = SHORT,
  admin = SHORT,
  academic_community = SHORT,
  capacity_building = SHORT,
  media = SHORT,
  skills = SHORT,
  referees = SHORT
)

cv_compile()
