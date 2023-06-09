## ------------------------------------------------------------------------
wants <- c("coin", "mvtnorm", "polycor", "pROC", "rms")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])

## ------------------------------------------------------------------------
set.seed(123)
library(mvtnorm)
N     <- 100
Sigma <- matrix(c(4,2,-3, 2,16,-1, -3,-1,9), byrow=TRUE, ncol=3)
mu    <- c(-3, 2, 4)
Xdf   <- data.frame(rmvnorm(n=N, mean=mu, sigma=Sigma))

## ------------------------------------------------------------------------
lOrd   <- lapply(Xdf, function(x) {
                 cut(x, breaks=quantile(x), include.lowest=TRUE,
                     ordered=TRUE, labels=LETTERS[1:4]) })
dfOrd  <- data.frame(lOrd)
matOrd <- data.matrix(dfOrd)

## ------------------------------------------------------------------------
cTab <- xtabs(~ X1 + X3, data=dfOrd)
addmargins(cTab)
library(coin)
lbl_test(cTab, distribution=approximate(B=9999))

## ------------------------------------------------------------------------
library(polycor)
polychor(dfOrd$X1, dfOrd$X2, ML=TRUE)

## ------------------------------------------------------------------------
polychor(cTab, ML=TRUE)

## ------------------------------------------------------------------------
library(polycor)
polyserial(Xdf$X2, dfOrd$X3)

## ------------------------------------------------------------------------
library(polycor)
Xdf2   <- rmvnorm(n=N, mean=mu, sigma=Sigma)
dfBoth <- cbind(Xdf2, dfOrd)
hetcor(dfBoth, ML=TRUE)

## ------------------------------------------------------------------------
N   <- 100
x   <- rnorm(N)
y   <- x + rnorm(N, 0, 2)
yDi <- ifelse(y <= median(y), 0, 1)

## ------------------------------------------------------------------------
library(rms)
lrm(yDi ~ x)$stats

## ----associationOrder01--------------------------------------------------
library(pROC)
(rocRes <- roc(yDi ~ x, plot=TRUE, ci=TRUE, main="ROC-curve",
               xlab="specificity (TN / (TN+FP))", ylab="sensitivity (TP / (TP+FN))"))
rocCI <- ci.se(rocRes)
plot(rocCI, type="shape")

## ------------------------------------------------------------------------
try(detach(package:rms))
try(detach(package:Hmisc))
try(detach(package:grid))
try(detach(package:lattice))
try(detach(package:Formula))
try(detach(package:SparseM))
try(detach(package:pROC))
try(detach(package:polycor))
try(detach(package:sfsmisc))
try(detach(package:coin))
try(detach(package:survival))
try(detach(package:mvtnorm))
try(detach(package:splines))

