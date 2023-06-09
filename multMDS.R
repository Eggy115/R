## ------------------------------------------------------------------------
wants <- c("vegan")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])

## ------------------------------------------------------------------------
cities <- c("Augsburg", "Berlin", "Dresden", "Hamburg", "Hannover",
            "Karlsruhe", "Kiel", "Muenchen", "Rostock", "Stuttgart")
N      <- length(cities)
dstMat <- matrix(numeric(N^2), nrow=N)
##             B   DD   HH    H   KA   KI    M  HRO    S
cityDst <- c(596, 467, 743, 599, 226, 838,  65, 782, 160, ## AUG
                  194, 288, 286, 673, 353, 585, 231, 633, ## B
                       477, 367, 550, 542, 465, 420, 510, ## DD
                            157, 623,  96, 775, 187, 665, ## HH
                                 480, 247, 632, 330, 512, ## H
                                      723, 298, 805,  80, ## KA
                                           872, 206, 752, ## KI
                                                777, 220, ## M
                                                     824) ## HRO

dstMat[upper.tri(dstMat)] <- rev(cityDst)
dstMat <- t(dstMat[ , N:1])[ , N:1]
dstMat[lower.tri(dstMat)] <- t(dstMat)[lower.tri(dstMat)]
dimnames(dstMat) <- list(city=cities, city=cities)

## ------------------------------------------------------------------------
(mds <- cmdscale(dstMat, k=2))

## ----results='hide'------------------------------------------------------
set.seed(123)
P   <- 3
obj <- matrix(sample(-20:20, N*P, replace=TRUE), ncol=P)
dst <- dist(obj, diag=TRUE, upper=TRUE)
cmdscale(dst, k=2)
# not shown

## ----rerMultMDS01--------------------------------------------------------
xLims <- range(mds[ , 1]) + c(0, 250)
plot(mds, xlim=xLims, xlab="North-South", ylab="East-West", pch=16,
     main="City locations according to MDS")
text(mds[ , 1]+50, mds[ , 2], adj=0, labels=cities)

## ------------------------------------------------------------------------
library(vegan)
(nmMDS <- monoMDS(dstMat, k=2))
scores(nmMDS)

## ------------------------------------------------------------------------
try(detach(package:vegan))
try(detach(package:permute))

