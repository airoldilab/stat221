
#' Generate noisy bivariate normal data and measure correlation
#'
#' @param num_genes Number of observations.
#' @param true_cor True correlation.
#' @param noise_var Variance of additional noise, independent for the
#'   two variables.
#' @param to_file Whether to write the results to an RData file.
#' @return Observerd correlation.
#'
#' @export
#' @importFrom mvtnorm rmvnorm

noisy_cor <- function(num_genes, true_cor, noise_var, to_file = FALSE) {

  seed <- fracSec()
  set.seed(seed)

  stopifnot(is.numeric(num_genes), length(num_genes) == 1,
            as.integer(num_genes) == num_genes, num_genes >= 2)
  stopifnot(is.numeric(true_cor), length(true_cor) == 1,
            true_cor >= 0.0, true_cor <= 1.0)
  stopifnot(is.numeric(noise_var), length(noise_var) == 1,
            noise_var >= 0)

  cov_mat <- cbind(c(1, true_cor), c(true_cor, 1))
  data <- rmvnorm(num_genes, sigma = cov_mat)

  data[,1] <- data[,1] + rnorm(num_genes, sd = sqrt(noise_var))
  data[,2] <- data[,2] + rnorm(num_genes, sd = sqrt(noise_var))

  obs_cor <- cor(data[,1], data[,2])

  if (to_file) {
    filename <- sprintf("noisy-cor-%g-%g.rda", true_cor, noise_var)
    save(obs_cor, seed, file = filename)
  }

  obs_cor
}
