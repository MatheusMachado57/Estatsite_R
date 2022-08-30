install.packages('pdftools')
library('pdftools')

base = pdftools::pdf_text(pdf = "https://growthecon.com/assets/Wu_EJMR_paper.pdf")
base = gsub(" ", base, replacement = "")
base = gsub("\n", base, replacement = "")
base = as.list(base)
base