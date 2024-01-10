library(tinytex)
lapply(list.files("R", full.names = TRUE), source)

fixed <- c(
  "begin",
  "end",
  "config"
)

twopg <- c(
  "contact",
  "education",
  "work_experience",
  "grants_awards",
  "un_consult",
  "publications",
  "presentations",
  "skills",
  "teaching",
  "projects"
)

full_section(fixed, TRUE)
full_section(twopg, FALSE)
# full_section("supervision", F)
# full_section("policy", F)
# full_section("admin", F)
# full_section("academic_community", F)
# full_section("capacity_building", F)
# full_section("media", F)
# full_section("skills", F)
# full_section("referees", F)

compile_cv()
