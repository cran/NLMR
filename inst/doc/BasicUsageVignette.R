## ---- fig.height=7, fig.width=7, fig.align='center'----------------------
 x <- NLMR::nlm_random(20,20)
 NLMR::util_plot(x)

## ---- fig.height=7, fig.width=7, fig.align='center'----------------------
  #Create primary landscape raster
  pL <- NLMR::nlm_edgegradient(nCol = 100,
                              nRow = 100)

  NLMR::util_plot(pL)

  #Create secondary landscape rasters
  sL1 <- NLMR::nlm_distancegradient(nCol = 100,
                                    nRow = 100,
                                    origin = c(10, 10, 10, 10))
  sL2 <- NLMR::nlm_random(nCol = 100,
                          nRow = 100)

  mL1 <- NLMR::util_merge(pL,
                          c(sL1, sL2),
                          scalingfactor = 1)
  
  NLMR::util_plot(mL1)

## ----fig.height=7, fig.width=7, fig.align='center'-----------------------
nr <- NLMR::nlm_randomcluster(nCol = 50,
                              nRow = 50,
                              resolution = 1,
                              neighbourhood = 4,
                              p = 0.5)
                              
weighting <- c(0.5, 0.25, 0.25)

cr <- NLMR::util_classify(nr,
                          weighting = weighting,
                          level_names = c("L1", "L2", "L3"))

NLMR::util_plot(cr, discrete = TRUE)

NLMR::metric_area(cr)

## ----raster-example, message=FALSE, warning=FALSE------------------------
library(raster)
r <- raster(ncol=10, nrow=10, xmn=0, xmx=100, ymn=0, ymx=100)
r

## ----raster-example2, dependson='raster-example', message=FALSE, warning=FALSE----
values(r) <- runif(ncell(r))
r

## ----dependson='raster-example2', message=FALSE, warning=FALSE, fig.height=7, fig.width=7, fig.align='center'----
plot(r)

## ----dependson='raster-example2', message=FALSE, warning=FALSE, fig.height=7, fig.width=7, fig.align='center'----
r2 <- r * (abs(0.5 - r) * -2) + 1
r3  <- NLMR::util_classify(r, c(0.5, 0.5))
s <- stack(r, r2, r3)
s
plot(s)

## ----dependson='raster-example', message=FALSE, warning=FALSE------------
r <- raster(ncol=10, nrow=10, xmn=0, xmx=100, ymn=0, ymx=100)
dim(r)
ncol(r) <- 42
dim(r)

## ----dependson='raster-example', message=FALSE, warning=FALSE------------
r <- raster(ncol=10, nrow=10, xmn=0, xmx=100, ymn=0, ymx=100)
res(r)
res(r) <- 42
res(r)

## ----dependson='raster-example', message=FALSE, warning=FALSE------------
r <- raster(ncol=10, nrow=10, xmn=0, xmx=100, ymn=0, ymx=100)
extent(r)
extent(r) <- c(0, 42, 0, 42)
extent(r)

## ----dependson='raster-example', message=FALSE, warning=FALSE------------
r <- raster(ncol=10, nrow=10)
values(r) <- 1:ncell(r)

# do some math
s <- sqrt(r)
s <- s * r + 5

## ----dependson='raster-example', message=FALSE, warning=FALSE------------
r <- raster(ncol=5, nrow=5)
values(r) <- 1:ncell(r)

r[s == c(1,3,5,9,13)] <- 45
r

## ----dependson='raster-example', message=FALSE, warning=FALSE, fig.height=7, fig.width=7, fig.align='center'----
r <- raster(ncol=100, nrow=100)
values(r) <- 1:ncell(r)

# aggregate/disaggregate raster
ra <- aggregate(r, 20)
rd <- disaggregate(ra, 20)
par(mfrow=c(1,2))
plot(ra)
plot(rd)

## ----dependson='raster-example', message=FALSE, warning=FALSE, fig.height=7, fig.width=7, fig.align='center'----
r <- raster(ncol=100, nrow=100)
values(r) <- 1:ncell(r)

# crop and merge
r1 <- crop(r, extent(-50,0,0,30))
r2 <- crop(r, extent(-10,50,-20, 10))
m <- merge(r1, r2)
plot(m)

## ----message=FALSE, warning=FALSE----------------------------------------
r <- raster(ncol=10, nrow=10)
values(r) <- 1:ncell(r)

# access the values via @
r@data@values

# ... or by treating the raster like a vector
r[]


# this vector can then be coerced to a matrix:
matrix(r[], nrow(r), ncol(r))

