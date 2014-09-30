

library(rmarkdown)


render(input = "index.rmd", output_format = c("pdf_document", "word_document"), output_dir = "word_and_pdf")
