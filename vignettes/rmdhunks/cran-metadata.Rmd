## Get CRAN metadata

For obtaining CRAN metadata, pkgsearch uses the crandb webservice.

### Get metadata about a package

```{r}
cran_package("pkgsearch")
cran_package("rhub")
```

### Get latest CRAN events (releases, archivals)

```{r}
cran_events()
cran_events(limit = 5, releases = FALSE)
cran_events(limit = 5, archivals = FALSE)
```

### List active (available) packages

```{r}
cran_packages()
cran_packages(from = "pkgsearch")
```

### List R releases in the CRANDB database

```{r}
cran_releases()
```