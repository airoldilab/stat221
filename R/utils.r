
#' Generate a random seed based on microseconds
#'
#' @export

fracSec <- function() {
  now <- as.vector(as.POSIXct(Sys.time())) / 1000
  as.integer(abs(now - trunc(now)) * 10^8)
}
