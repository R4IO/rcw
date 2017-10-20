filename_in <- "/home/xps13/src/javascript/web-components/lib/rcw-charts/public/real-world/bar.js"
filename_out <- "/home/xps13/src/javascript/web-components/lib/rcw-charts/public/real-world/bar-es5.js"

con1 <- file(filename_in)
tt <- readLines(con1)
close(con1)

tt_str <- paste(tt, collapse = "")

library(reactR)

tt_new <- reactR::babel_transform(code = tt_str)

con2 <- file(filename_out)
writeLines(tt_new, con2)
close(con2)

