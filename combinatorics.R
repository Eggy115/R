## ------------------------------------------------------------------------
wants <- c("e1071", "permute")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])

## ------------------------------------------------------------------------
myN <- 5
myK <- 4
choose(myN, myK)
factorial(myN) / (factorial(myK)*factorial(myN-myK))

## ------------------------------------------------------------------------
combn(c("a", "b", "c", "d", "e"), myK)
combn(c(1, 2, 3, 4), 3)

## ------------------------------------------------------------------------
combn(c(1, 2, 3, 4), 3, sum)
combn(c(1, 2, 3, 4), 3, weighted.mean, w=c(0.5, 0.2, 0.3))

## ------------------------------------------------------------------------
factorial(7)

## ------------------------------------------------------------------------
set.seed(123)
set <- LETTERS[1:10]
sample(set, length(set), replace=FALSE)

## ------------------------------------------------------------------------
library(permute)
shuffle(length(set))

## ------------------------------------------------------------------------
set <- LETTERS[1:3]
len <- length(set)
library(e1071)
(mat <- permutations(len))
apply(mat, 1, function(x) set[x])

## ------------------------------------------------------------------------
(grp <- rep(letters[1:3], each=3))
N      <- length(grp)
nPerms <- 100
library(permute)
pCtrl <- how(nperm=nPerms, complete=FALSE)
for(i in 1:5) {
    perm <- permute(i, n=N, control=pCtrl)
    print(grp[perm])
}

## ------------------------------------------------------------------------
Njk    <- 4              ## cell size
P      <- 2              ## levels factor A
Q      <- 3              ## levels factor B
N      <- Njk*P*Q
nPerms <- 10             ## number of permutations
id     <- 1:(Njk*P*Q)
IV1    <- factor(rep(1:P,  each=Njk*Q))  ## factor A
IV2    <- factor(rep(1:Q, times=Njk*P))  ## factor B
(myDf  <- data.frame(id, IV1, IV2))

# choose permutation schemes for tests of factor A and B
library(permute)         ## for how(), permute()

## only permute across A (within B)
pCtrlA <- how(plots=Plots(strata=IV2), complete=FALSE, nperm=nPerms)

## only permute across B (within A)
pCtrlB <- how(plots=Plots(strata=IV1), complete=FALSE, nperm=nPerms)

## ----results='hide'------------------------------------------------------
for(i in 1:3) {
    perm <- permute(i, n=N, control=pCtrlA)
    print(myDf[perm, ])
# not shown
}

## ----results='hide'------------------------------------------------------
for(i in 1:3) {
    perm <- permute(i, n=N, control=pCtrlB)
    print(myDf[perm, ])
# not shown
}

## ------------------------------------------------------------------------
IV1 <- c("control", "treatment")
IV2 <- c("f", "m")
IV3 <- c(1, 2)
expand.grid(IV1, IV2, IV3)

## ------------------------------------------------------------------------
outer(1:5, 1:5, FUN="*")

## ------------------------------------------------------------------------
try(detach(package:e1071))
try(detach(package:permute))

