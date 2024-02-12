# tinytex::reinstall_tinytex()
# tinytex::tlmgr_update(self = TRUE)
# tinytex::tlmgr_install("expl3")

library(tinytex)
lapply(list.files("R", full.names = TRUE), source)

cv_section(
  begin = FULL,
  end = FULL,
  config = FULL,
  contact = SHORT,
  education = FULL,
  work_experience = SHORT,
  grants_awards = SHORT,
  un_consult = FULL,
  skills = FULL,
  publications = FULL,
  presentations = FULL,
  software = FULL,
  teaching = SHORT,
  projects  = FULL,
  supervision = FULL,
  policy = OMIT,
  admin = FULL,
  academic_community = FULL,
  capacity_building = FULL,
  media = FULL,
  skills = SHORT,
  referees = FULL
)

section_order <- c(
  "01.contact",
  "00.begin",
  "02.education",
  "03.work_experience",
  "17.un_consult",
  "06.grants_awards",
  "04.publications",
  "05.presentations",
  "18.software",
  "12.academic_community",
  "07.teaching",
  "08.supervision",
  "10.policy",
  "11.admin",
  "09.projects",
  "13.capacity_building",
  "14.media",
  "15.skills",
  "16.referees"
)

pg_break <- c(
  "17.un_consult",
  "11.admin",
  "07.teaching",
  "09.projects"
)

cv_compile("outdir/cv_hertzog.pdf")

cover_compile("outdir/cover_hertzog.pdf")
