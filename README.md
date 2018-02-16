rcw
===

<img src="https://raw.githubusercontent.com/r4io/rcw/master/assets/img/rcw_logo.png" width="10%" />

<!-- get JS library and map -->
<!-- : execute `./node_modules/.bin/wce bundle --lib` in `web-components/lib/rcw-charts` (upon error, set permissions using `chmod -R u+x .`) -->
<!-- render README -->
<!-- :   `Rscript -e 'rmarkdown::render("README.Rmd", output_format = "md_document")'` -->
<!-- render flexdashboard -->
<!-- :   `Rscript -e 'rmarkdown::render("vignettes/rcwChart2.Rmd")'` -->
<!-- Rscript -e 'rmarkdown::render("vignettes/rcwChart.Rmd")' -->
build website  
`Rscript -e 'pkgdown::build_site()'`

update articles  
`Rscript -e 'pkgdown::build_articles()'`
