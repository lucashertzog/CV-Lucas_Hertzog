# tinytex::reinstall_tinytex()
# tinytex::tlmgr_update(self = TRUE)
# tinytex::tlmgr_install("expl3")

library(tinytex)
lapply(list.files("R", full.names = TRUE), source)

cv_section(
  begin = FULL,
  config = FULL,
  contact = SHORT,
  education = SHORT,
  work_experience = SHORT,
  grants_awards = SHORT,
  un_consult = SHORT,
  skills = FULL,
  publications = FULL,
  in_press = FULL,
  in_prepar = FULL,
  in_pt = FULL,
  pub_other = FULL,
  presentations = FULL,
  talks = FULL,
  software = FULL,
  teaching = SHORT,
  projects  = FULL,
  supervision = FULL,
  policy = OMIT,
  admin = FULL,
  academic_community = FULL,
  capacity_building = OMIT,
  media = FULL,
  skills = FULL,
  referees = FULL
)


section_order <- c(
  "01.contact",
  "00.begin",
  "02.education",
  "03.work_experience",
  "17.un_consult",
  "06.grants_awards",
  "15.skills",
  "04.publications",
  "19.in_press",
  "20.in_prepar",
  "21.in_pt",
  "22.pub_other",
  "05.presentations",
  "23.talks",
  "14.media",
  "18.software",
  "07.teaching",
  "08.supervision",
  "09.projects",
  "12.academic_community",
  "11.admin",
  "10.policy",
  "13.capacity_building",
  "16.referees"
)

pg_break <- c(
  "08.supervision"
  # ,
  # "12.academic_community"
)

cv_compile("outdir/hertzog_cv.pdf")

cover_compile("outdir/hertzog_cover.pdf")
