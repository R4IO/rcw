## code to prepare `param_chart_type` dataset goes here

library(yaml)

param_chart_type <- yaml::yaml.load_file(input = "./param_chart_type.yml")

usethis::use_data(param_chart_type, internal = TRUE)
