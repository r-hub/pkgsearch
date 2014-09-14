
all: README.md

README.md: vignettes/README.Rmd
	Rscript -e "library(methods); library(knitr); knit('$<', output = '$@', quiet = TRUE)"


