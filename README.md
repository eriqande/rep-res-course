# Reproducible Research Course

This is code and text behind the [Reproducible Research Course](http://eriqande.github.io/rep-res-course/)
taught by Eric C. Anderson of the National Marine Fisheries Service. 

The site is built using jekyll, with a custom plugin (written by Hadley Wickham for his [Advanced R programming](http://adv-r.had.co.nz) book) to render `.rmd` files with
knitr and pandoc. To create the site, you need:

* jekyll: `gem install jekyll`
* [pandoc](http://johnmacfarlane.net/pandoc/)
* [knitr](http://yihui.name/knitr/): `install.packages("knitr")`
* [rmarkdown](http://cran.r-project.org/web/packages/rmarkdown/index.html)  `install.packages("rmarkdown")`
* [bookdown](https://github.com/hadley/bookdown)  `devtools::install_github("bookdown", "hadley")` Note that I developed using commit ee48d6b75916c240ce06c40c2fa5430f386e6d78

You should make sure that you have recent versions of the R packages.  Here is what has worked for me:
```r
> sessionInfo()
R version 3.1.0 (2014-04-10)
Platform: x86_64-apple-darwin13.1.0 (64-bit)

locale:
[1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
[1] knitr_1.6       bookdown_0.1    rmarkdown_0.3.3

loaded via a namespace (and not attached):
[1] digest_0.6.4    evaluate_0.5.3  formatR_0.10    htmltools_0.2.6 stringr_0.6.2   tools_3.1.0     yaml_2.1.11    
```
## Internal links

To link between sections, use internal links of the form `#header-id`. See some of the files.

## Hosting on GitHub
I build this site locally, and I push the results up to the gh-pages branch.  That involves some gymnastics that I will
explain here once I figure it out.  For now, to build it locally, just do `./build-site.sh`.  If you want to build it locally
and have jekyll serve it up locally for you as well, do './build-site.sh -l`.
