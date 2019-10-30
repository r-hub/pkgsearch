
library(asciicast)

process <- asciicast_start_process(
  startup = quote(library(pkgsearch))
)

casts <- lapply(1:13, function(i) {
  fn <- paste0("pkgsearch", i, ".R")
  cat(fn, sep = "\n")
  record(fn, process = process)
})

cast <- merge_casts(
  casts[[1]],
  pause(10),
  clear_screen(),
  casts[[2]],
  pause(10),
  clear_screen(),
  casts[[3]],
  pause(10),
  clear_screen(),
  casts[[4]],
  pause(10),
  clear_screen(),
  casts[[5]],
  pause(10),
  clear_screen(),
  casts[[6]],
  pause(10),
  clear_screen(),
  casts[[7]],
  pause(10),
  clear_screen(),
  casts[[8]],
  pause(10),
  clear_screen(),
  casts[[9]],
  pause(10),
  clear_screen(),
  casts[[10]],
  pause(10),
  clear_screen(),
  casts[[11]],
  pause(10),
  clear_screen(),
  casts[[12]],
  pause(10),
  clear_screen(),
  casts[[13]]
)
