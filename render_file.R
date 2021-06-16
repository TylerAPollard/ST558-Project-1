## Script to render Rmarkdown
# Author: Tyler Pollard
# Date: 06/15/2021

library(rmarkdown)

render(input = "Project1_Pollard.Rmd", output_format = "github_document", output_file = "README.md")
