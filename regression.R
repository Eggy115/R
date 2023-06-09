## ----echo=FALSE----------------------------------------------------------
knit_hooks$set(rgl=hook_rgl)

## ------------------------------------------------------------------------
wants <- c("car", "leaps", "lmtest", "sandwich")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])

## ------------------------------------------------------------------------
set.seed(123)
N  <- 100
X1 <- rnorm(N, 175, 7)
X2 <- rnorm(N,  30, 8)
X3 <- abs(rnorm(N, 60, 30))
Y  <- 0.5*X1 - 0.3*X2 - 0.4*X3 + 10 + rnorm(N, 0, 7)
dfRegr <- data.frame(X1, X2, X3, Y)

## ------------------------------------------------------------------------
(fit12 <- lm(Y ~ X1 + X2, data=dfRegr))
lm(scale(Y) ~ scale(X1) + scale(X2), data=dfRegr)

## ----rerRegression01, rgl=TRUE-------------------------------------------
library(car)
scatter3d(Y ~ X1 + X2, fill=FALSE, data=dfRegr)

## ------------------------------------------------------------------------
coef(fit12)
E <- residuals(fit12)
head(E)
Yhat <- fitted(fit12)
head(Yhat)

## ------------------------------------------------------------------------
(fit123 <- update(fit12,  . ~ . + X3))
(fit13 <- update(fit123, . ~ . - X1))
(fit1 <- update(fit12,  . ~ . - X2))

## ------------------------------------------------------------------------
sumRes <- summary(fit123)
sumRes$r.squared
sumRes$adj.r.squared
sumRes$sigma

## ------------------------------------------------------------------------
AIC(fit1)
extractAIC(fit1)
extractAIC(fit1, k=log(N))

## ------------------------------------------------------------------------
summary(fit12)
confint(fit12)
vcov(fit12)

## ------------------------------------------------------------------------
add1(fit1, . ~ . + X2 + X3, test="F")

## ------------------------------------------------------------------------
anova(fit1, fit123)

## ----rerRegression02-----------------------------------------------------
data(longley)
head(longley)
library(leaps)
subs <- regsubsets(GNP.deflator ~ ., data=longley)
summary(subs, matrix.logical=TRUE)
plot(subs, scale="bic")

## ------------------------------------------------------------------------
Xmat <- data.matrix(subset(longley, select=c("GNP", "Unemployed", "Population", "Year")))
(leapFits <- leaps(Xmat, longley$GNP.deflator, method="Cp"))

## ----rerRegression03-----------------------------------------------------
plot(leapFits$size, leapFits$Cp, xlab="model size", pch=20, col="blue",
     ylab="Mallows' Cp", main="Mallows' Cp agains model size")
abline(a=0, b=1)

## ------------------------------------------------------------------------
X1new <- c(177, 150, 192, 189, 181)
dfNew <- data.frame(X1=X1new)
predict(fit1, dfNew, interval="prediction", level=0.95)
predOrg <- predict(fit1, interval="confidence", level=0.95)

## ----rerRegression04-----------------------------------------------------
hOrd <- order(X1)
par(lend=2)
plot(X1, Y, pch=20, xlab="Predictor", ylab="Dependent variable and prediction",
     xaxs="i", main="Data and regression prediction")

polygon(c(X1[hOrd],             X1[rev(hOrd)]),
        c(predOrg[hOrd, "lwr"], predOrg[rev(hOrd), "upr"]),
        border=NA, col=rgb(0.7, 0.7, 0.7, 0.6))

abline(fit1, col="black")
legend(x="bottomright", legend=c("Data", "prediction", "confidence region"),
       pch=c(20, NA, NA), lty=c(NA, 1, 1), lwd=c(NA, 1, 8),
       col=c("black", "blue", "gray"))

## ------------------------------------------------------------------------
try(detach(package:leaps))
try(detach(package:lmtest))
try(detach(package:sandwich))
try(detach(package:zoo))
try(detach(package:car))

