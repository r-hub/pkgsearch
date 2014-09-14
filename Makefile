
all: README.md

README.md: README.Rmd
	Rscript -e "library(methods); library(knitr); knit('README.Rmd', quiet = TRUE)"


