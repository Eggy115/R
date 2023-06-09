## ------------------------------------------------------------------------
wants <- c("expm", "mvtnorm", "pracma")
has   <- wants %in% rownames(installed.packages())
if(any(!has)) install.packages(wants[!has])

## ------------------------------------------------------------------------
N  <- 4
Q  <- 2
(X <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12), nrow=N, ncol=Q))
t(X)

## ------------------------------------------------------------------------
diag(cov(X))

## ------------------------------------------------------------------------
diag(1:3)
diag(2)
diag(5, nrow=1)

## ------------------------------------------------------------------------
(Xc <- diag(N) - matrix(rep(1/N, N^2), nrow=N))
(Xdot <- Xc %*% X)
(SSP <- t(Xdot) %*% Xdot)
crossprod(Xdot)

## ------------------------------------------------------------------------
(1/(N-1)) * SSP
(S <- cov(X))
Ds <- diag(1/sqrt(diag(S)))
Ds %*% S %*% Ds
cov2cor(S)

## ------------------------------------------------------------------------
b <- 2
a <- c(-2, 1)
sweep(b*X, 2, a, "+")
colLens <- sqrt(colSums(X^2))
sweep(X, 2, colLens, "/")
X %*% diag(1/colLens)

## ------------------------------------------------------------------------
B <- cbind(c(1,1,1), c(0,2,0), c(0,0,2))
B %*% B %*% B
library(expm)
B %^% 3

## ------------------------------------------------------------------------
a <- c(1, 2, 3)
b <- c(4, 5, 6)
library(pracma)
cross(a, b)

## ------------------------------------------------------------------------
Y     <- matrix(c(1, 1, 1, -1), nrow=2)
(Yinv <- solve(Y))
Y %*% Yinv

## ------------------------------------------------------------------------
library(MASS)
gInv <- ginv(X)
zapsmall(gInv %*% X)

## ------------------------------------------------------------------------
A  <- matrix(c(9, 1, -5, 0), nrow=2)
b  <- c(5, -3)
(x <- solve(A, b))
A %*% x

## ------------------------------------------------------------------------
a1 <- c(3, 4, 1, 8, 2)
sqrt(crossprod(a1))
sqrt(sum(a1^2))

## ------------------------------------------------------------------------
a2 <- c(6, 9, 10, 8, 7)
A  <- cbind(a1, a2)
sqrt(diag(crossprod(A)))
sqrt(colSums(A^2))

## ------------------------------------------------------------------------
norm(A, type="F")
sqrt(crossprod(c(A)))

## ------------------------------------------------------------------------
set.seed(123)
B <- matrix(sample(-20:20, 12, replace=TRUE), ncol=3)
sqrt(crossprod(B[1, ] - B[2, ]))

## ------------------------------------------------------------------------
dist(B, diag=TRUE, upper=TRUE)

## ------------------------------------------------------------------------
library(mvtnorm)
N     <- 100
mu    <- c(-3, 2, 4)
sigma <- matrix(c(4,2,-3, 2,16,-1, -3,-1,9), byrow=TRUE, ncol=3)
Y     <- round(rmvnorm(N, mean=mu, sigma=sigma))

## ------------------------------------------------------------------------
ctr   <- colMeans(Y)
S     <- cov(Y)
Seig  <- eigen(S)
sqrtD <- sqrt(Seig$values)
SsqrtInv <- Seig$vectors %*% diag(1/sqrtD) %*% t(Seig$vectors)

Xdot  <- sweep(Y, 2, ctr, "-")
Xmt   <- t(SsqrtInv %*% t(Xdot))
zapsmall(cov(Xmt))
colMeans(Xmt)

## ------------------------------------------------------------------------
ideal <- c(1, 2, 3)
y1    <- Y[1, ]
y2    <- Y[2, ]
mat   <- rbind(y1, y2)

## ------------------------------------------------------------------------
mahalanobis(mat, ideal, S)

## ------------------------------------------------------------------------
Sinv <- solve(S)
t(y1-ideal) %*% Sinv %*% (y1-ideal)
t(y2-ideal) %*% Sinv %*% (y2-ideal)

## ------------------------------------------------------------------------
mDist <- mahalanobis(Y, ideal, S)
min(mDist)
(idxMin <- which.min(mDist))
Y[idxMin, ]

## ------------------------------------------------------------------------
idealM <- t(SsqrtInv %*% (ideal - ctr))
crossprod(Xmt[1, ] - t(idealM))
crossprod(Xmt[2, ] - t(idealM))

## ------------------------------------------------------------------------
(A <- matrix(c(9, 1, 1, 4), nrow=2))
sum(diag(A))
sum(diag(t(A) %*% A))
sum(diag(A %*% t(A)))
sum(A^2)

## ------------------------------------------------------------------------
det(A)
B <- matrix(c(-3, 4, -1, 7), nrow=2)
all.equal(det(A %*% B), det(A) * det(B))
det(diag(1:4))
Ainv <- solve(A)
all.equal(1/det(A), det(Ainv))

## ------------------------------------------------------------------------
qrA <- qr(A)
qrA$rank

## ------------------------------------------------------------------------
(eigA <- eigen(A))
zapsmall(eigA$vectors %*% t(eigA$vectors))
sum(eigA$values)
prod(eigA$values)

## ------------------------------------------------------------------------
library(MASS)
Xnull <- Null(X)
t(X) %*% Xnull

## ------------------------------------------------------------------------
X <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12, 17, 23, 27, 25), nrow=4)
kappa(X, exact=TRUE)
Xplus <- solve(t(X) %*% X) %*% t(X)
base::norm(X, type="2") * base::norm(Xplus, type="2")

## ------------------------------------------------------------------------
evX <- eigen(t(X) %*% X)$values
sqrt(max(evX) / min(evX[evX >= .Machine$double.eps]))
sqrt(evX / min(evX[evX >= .Machine$double.eps]))

## ------------------------------------------------------------------------
X  <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12, 17, 23, 27, 25), nrow=4)
(S <- cov(X))
eigS <- eigen(S)
G    <- eigS$vectors
D    <- diag(eigS$values)
G %*% D %*% t(G)

## ------------------------------------------------------------------------
svdX <- svd(X)
all.equal(X, svdX$u %*% diag(svdX$d) %*% t(svdX$v))
all.equal(sqrt(eigen(t(X) %*% X)$values), svdX$d)

## ------------------------------------------------------------------------
R <- chol(S)
all.equal(S, t(R) %*% R)

## ------------------------------------------------------------------------
qrX <- qr(X)
Q   <- base::qr.Q(qrX)
R   <- base::qr.R(qrX)
all.equal(X, Q %*% R)

## ------------------------------------------------------------------------
library(expm)
sqrtm(S)

## ------------------------------------------------------------------------
sqrtD <- diag(sqrt(eigS$values))
(A <- G %*% sqrtD %*% t(G))
A %*% A

## ------------------------------------------------------------------------
N <- eigS$vectors %*% sqrt(diag(eigS$values))
N %*% t(N)

## ------------------------------------------------------------------------
X    <- matrix(c(20, 26, 10, 19, 29, 27, 20, 12, 17, 23, 27, 25), nrow=4)
ones <- rep(1, nrow(X))
P1   <- ones %*% solve(t(ones) %*% ones) %*% t(ones)
P1x  <- P1 %*% X
head(P1x)

## ------------------------------------------------------------------------
a  <- ones / sqrt(crossprod(ones))
P2 <- a %*% t(a)
all.equal(P1, P2)

## ------------------------------------------------------------------------
IP1  <- diag(nrow(X)) - P1
IP1x <- IP1 %*% X
all.equal(IP1x, sweep(X, 2, colMeans(X), "-"))

## ------------------------------------------------------------------------
A   <- cbind(c(1, 0, 0), c(0, 1, 0))
P3  <- A %*% solve(t(A) %*% A) %*% t(A)
Px3 <- t(P3 %*% t(X))
Px3[1:3, ]

## ------------------------------------------------------------------------
qrX   <- qr(X)
Q     <- base::qr.Q(qrX)
R     <- base::qr.R(qrX)
Xplus <- solve(t(X) %*% X) %*% t(X)
all.equal(Xplus, solve(R) %*% t(Q))
all.equal(X %*% Xplus, tcrossprod(Q))

## ------------------------------------------------------------------------
try(detach(package:MASS))
try(detach(package:expm))
try(detach(package:Matrix))
try(detach(package:pracma))
try(detach(package:mvtnorm))

