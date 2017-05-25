
all: README.md

README.md: inst/README.Rmd
	Rscript -e "library(methods); library(knitr); knit('$<', output = '$@', quiet = TRUE)"


