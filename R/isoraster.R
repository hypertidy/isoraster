#' Iso bands and iso lines for terra
#'
#' Produce contours for a raster and return a vector dataset.
#'
#' `isoline_terra` returns lines, use 'line' to specify or an automatic set will be computed
#'
#' `isoband_terra` returns polygons, use 'lo' AND 'hi' to specify breaks, or an automatic set will be computed
#'
#' These lines and boundaries are nice because isoband uses marching squares, not literal pixel outlines.
#'
#' @param x  a terra raster, only first layer is considered
#' @param line a contour level for isoline_terra
#' @param lo a polygon level interval minimum for the low values (must have a corresponding hi value)
#' @param hi a polygon level interval maximum for the high values (cf. lo)
#' @return
#' @export
#' @aliases isoband_terra
#' @examples
isoline_terra <- function(x, line) {
  x <- x[[1]]
  if (missing(line)) {
    line <- pretty(x)

  }

  b <- isoband::isolines(terra::xFromCol(x), terra::yFromRow(x), as.array(x)[,,1, drop = TRUE], levels = line)
  terra::vect(sf::st_sf(line = line, geometry  = sf::st_sfc(isoband::iso_to_sfg(b), crs = terra::crs(x))))
}


#' @export
isoband_terra <- function(x, lo, hi) {
  x <- x[[1]]
  if (missing(lo)) {
    breaks <- pretty(x)
    lo <- head(breaks, -1)
    hi <- tail(breaks, -1)
  }
  b <- isoband::isobands(terra::xFromCol(x), terra::yFromRow(x), as.array(x)[,,1, drop = TRUE], levels_low = lo, levels_hi = hi)
  terra::vect(sf::st_sf(lo = lo, hi = hi, geometry  = sf::st_sfc(isoband::iso_to_sfg(b), crs = projection(x))))
}
