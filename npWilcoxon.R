## ------------------------------------------------------------------------
wants <- c("coin", "DescTools")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])

## ------------------------------------------------------------------------
set.seed(123)
medH0 <- 30
DV    <- sample(0:100, 20, replace=TRUE)

library(DescTools)
SignTest(DV, mu=medH0)

## ------------------------------------------------------------------------
IQ    <- c(99, 131, 118, 112, 128, 136, 120, 107, 134, 122)
medH0 <- 110

## ------------------------------------------------------------------------
wilcox.test(IQ, alternative="greater", mu=medH0, conf.int=TRUE)

## ------------------------------------------------------------------------
Nj  <- c(20, 30)
DVa <- rnorm(Nj[1], mean= 95, sd=15)
DVb <- rnorm(Nj[2], mean=100, sd=15)
wIndDf <- data.frame(DV=c(DVa, DVb),
                     IV=factor(rep(1:2, Nj), labels=LETTERS[1:2]))

## ------------------------------------------------------------------------
library(coin)
median_test(DV ~ IV, distribution="exact", data=wIndDf)

## ------------------------------------------------------------------------
wilcox.test(DV ~ IV, alternative="less", conf.int=TRUE, data=wIndDf)

## ------------------------------------------------------------------------
library(coin)
wilcox_test(DV ~ IV, alternative="less", conf.int=TRUE,
            distribution="exact", data=wIndDf)

## ------------------------------------------------------------------------
N      <- 20
DVpre  <- rnorm(N, mean= 95, sd=15)
DVpost <- rnorm(N, mean=100, sd=15)
wDepDf <- data.frame(id=factor(rep(1:N, times=2)),
                     DV=c(DVpre, DVpost),
                     IV=factor(rep(0:1, each=N), labels=c("pre", "post")))

## ------------------------------------------------------------------------
medH0  <- 0
DVdiff <- aggregate(DV ~ id, FUN=diff, data=wDepDf)

library(DescTools)
SignTest(DVdiff$DV, mu=medH0)

## ------------------------------------------------------------------------
wilcoxsign_test(DV ~ IV | id, alternative="greater",
                distribution="exact", data=wDepDf)

## ------------------------------------------------------------------------
try(detach(package:DescTools))
try(detach(package:coin))
try(detach(package:survival))
try(detach(package:splines))

