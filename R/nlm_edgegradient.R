#' nlm_edgegradient
#'
#' @description Simulates an edge gradient neutral landscape model.
#'
#' @param nCol [\code{numerical(1)}]\cr
#' Number of columns for the raster.
#' @param nRow  [\code{numerical(1)}]\cr
#' Number of rows for the raster.
#' @param resolution  [\code{numerical(1)}]\cr
#' Resolution of the raster.
#' @param direction [\code{numerical(1)}]\cr
#' Direction of the gradient (between 0 and 360 degrees), if unspecified the
#' direction is randomly determined.
#' @param rescale [\code{logical(1)}]\cr
#' If \code{TRUE} (default), the values are rescaled between 0-1.
#'
#' @return RasterLayer
#'
#' @details
#' Simulates a linear gradient orientated on a specified or random direction
#' that has a central peak that runs perpendicular to the gradient direction.
#'
#' @examples
#' nlm_edgegradient(nCol = 100, nRow = 100, direction = 80)
#'
#' @references
#' Travis, J.M.J. & Dytham, C. (2004) A method for simulating patterns of
#' habitat availability at static and dynamic range margins. \emph{Oikos}, 104,
#' 410–416.
#'
#' @aliases nlm_edgegradient
#' @rdname nlm_edgegradient
#'
#' @export
#'

nlm_edgegradient <- function(nCol,
                             nRow,
                             resolution = 1,
                             direction = NA,
                             rescale = TRUE) {

  # Check function arguments ----
  checkmate::assert_count(nCol, positive = TRUE)
  checkmate::assert_count(nRow, positive = TRUE)
  checkmate::assert_numeric(resolution)
  checkmate::assert_numeric(direction)
  checkmate::assert_logical(rescale)

  # If direction was not set, give it a random value between 0 and 360 ---
  if (is.na(direction)) {
    direction <- stats::runif(1, 0, 360)
  }

  # Create planar gradient ----
  gradient_raster <-  nlm_planargradient(nCol, nRow, direction)

  # Transform to a central gradient ----
  edgegradient_raster <-
    (abs(0.5 - gradient_raster) * -2) + 1

  # specify resolution ----
  raster::extent(edgegradient_raster) <- c(0,
                                           ncol(edgegradient_raster)*resolution,
                                           0,
                                           nrow(edgegradient_raster)*resolution)

  # Rescale values to 0-1 ----
  if (rescale == TRUE) {
    edgegradient_raster <- util_rescale(edgegradient_raster)
  }

  return(edgegradient_raster)
}

#####
# Sebastians comment: Make transformation to planar gradient adjustable
#                     by the user
#####
