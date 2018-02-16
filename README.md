rcw
===

<img src="https://raw.githubusercontent.com/r4io/rcw/master/assets/img/rcw_logo.png" width="10%" />

Install Package
---------------

    git clone git@github.com:R4IO/rcw.git
    cd rcw
    devtools::install()

Example Usage
-------------

Creating a bar chart

    library(rcw)
    rcwData <- data.frame(
      x = c(1000, 1001, 1010, 1011, 1100, 1101, 1110, 1111),
      y = c(15, -20, 10, 40, 30, 25, 65, 27),
      highlightIndex = c(-1, -1, 0, -1, -1, -1, 1, -1)
    )
    rcwChart(rcwData, type = "bar", height=300)

<img src="https://raw.githubusercontent.com/r4io/rcw/master/assets/img/screenshot_bar_chart.png" width="100%" />

<!-- get JS library and map -->
<!-- : execute `./node_modules/.bin/wce bundle --lib` in `web-components/lib/rcw-charts` (upon error, set permissions using `chmod -R u+x .`) -->
<!-- render README -->
<!-- :   `Rscript -e 'rmarkdown::render("README.Rmd", output_format = "md_document")'` -->
<!-- render flexdashboard -->
<!-- :   `Rscript -e 'rmarkdown::render("vignettes/rcwChart2.Rmd")'` -->
<!-- Rscript -e 'rmarkdown::render("vignettes/rcwChart.Rmd")' -->
<!-- build website -->
<!-- :   `Rscript -e 'pkgdown::build_site()'` -->
<!-- update articles -->
<!-- :   `Rscript -e 'pkgdown::build_articles()'` -->
