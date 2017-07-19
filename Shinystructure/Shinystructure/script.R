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
sdf_name <- "D:\\ChemData\\DBF_all_compounds.sdf"
activity_col <- "L2 ECHCG WB2-POST PHYTO 4 kg/ha"
mols <- load.molecules(sdf_name)
#copy activity column in to activity
activity_list <- list()
smiles_list <- list()
for(mol in mols){
    set.property(mol, 'activity', get.property(mol, activity_col))
    append(activity_list, get.property(mol, activity_col))
    append(smiles_list, get.smiles(mol,type = 'unique'))
}
#view.molecule.2d(mols)

#calculate figerprint
fp_list <- lapply(mols, get.fingerprint, type = 'standard', fp.mode = 'bit', depth = 6, size = 1024, verbose = FALSE)
#fp_mat <- fp.factor.matrix(fp_list)
#calculate distance of compounds using tonimoto, you can change to Euclidian or Dice metrics
fp.sim <- fp.sim.matrix(fp_list, method = 'tanimoto')
fp.dist <- 1 - fp.sim

#reduce dimension using MDS
#classical MDS
fit <- cmdscale(fp.dist, eig = TRUE, k = 2)

# Nonmetric MDS
# N rows (objects) x p columns (variables)
# each row identified by a unique row name

library(MASS)
#fit <- isoMDS(fp.dist, k = 2) # k is the number of dim

# plot solution
x <- fit$points[, 1]
y <- fit$points[, 2]
plot(x, y, xlab = "Coordinate 1", ylab = "Coordinate 2",
  main = "MDS")

