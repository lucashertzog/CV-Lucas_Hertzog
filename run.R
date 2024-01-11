library(tinytex)
lapply(list.files("R", full.names = TRUE), source)

cv_section(
  begin = FULL,
  end = FULL,
  config = FULL,
  contact = FULL,
  education = FULL,
  work_experience = FULL,
  grants_awards = FULL,
  un_consult = FULL,
  skills = FULL,
  publications = FULL,
  presentations = FULL,
  teaching = FULL,
  projects  = FULL,
  supervision = FULL,
  policy = FULL,
  admin = FULL,
  academic_community = FULL,
  capacity_building = FULL,
  media = FULL,
  skills = FULL,
  referees = FULL
)

cv_compile()
