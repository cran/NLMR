## ----global_options, include=FALSE---------------------------------------
library(raster)
library(NLMR)
library(classInt)
library(rasterVis)

## ---- fig.height=7, fig.width=7, fig.align='center'----------------------
x <- NLMR::nlm_random(20,20)
rasterVis::levelplot(x, margin = FALSE, par.settings = viridisTheme())

## ---- fig.height=7, fig.width=7, fig.align='center'----------------------
  #Create primary landscape raster
  pL <- NLMR::nlm_edgegradient(ncol = 100,
                               nrow = 100)

  rasterVis::levelplot(pL, margin = FALSE, par.settings = viridisTheme())

  #Create secondary landscape rasters
  sL1 <- NLMR::nlm_distancegradient(ncol = 100,
                                    nrow = 100,
                                    origin = c(10, 10, 10, 10))
  sL2 <- NLMR::nlm_random(ncol = 100,
                          nrow = 100)

  mL1 <- pL + (sL1 + sL2)
  
  rasterVis::levelplot(mL1, margin = FALSE, par.settings = viridisTheme())

## ----fig.height=7, fig.width=7, fig.align='center'-----------------------
nr <- NLMR::nlm_randomcluster(ncol = 50,
                              nrow = 50,
                              resolution = 1,
                              neighbourhood = 4,
                              p = 0.5)
                              
breaks <- classIntervals(raster::getValues(nr), n=5, style="jenks")

cr <-  raster::cut(nr, breaks=breaks$brks, include.lowest=T)

rasterVis::levelplot(cr, margin = FALSE, par.settings = viridisTheme())

