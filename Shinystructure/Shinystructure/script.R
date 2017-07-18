#prepare packages for chemical data processing
if (!require("rJava", quietly = TRUE))
    install.packages("rJava")
library(rJava)
if (!require("rcdk", quietly = TRUE))
    install.packages("rcdk")
library(rcdk)
if (!require("fingerprint", quietly = TRUE))
    install.packages("fingerprint")
library(fingerprint)
if (!require("ChemmineR", quietly = TRUE)) {
    source("https://bioconductor.org/biocLite.R")
    biocLite("ChemmineR")
}
library(ChemmineR)

#Load shiny and ggplot2
if (!require("shiny", quietly = TRUE))
    install.packages("shiny")
library(shiny)
if (!require("ggplot2", quietly = TRUE))
    install.packages("ggplot2")
library(ggplot2)

#load sdf
sdf_name <- "c:\\test\\test.sdf"

