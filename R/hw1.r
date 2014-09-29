#! /usr/bin/env Rscript
#SBATCH -n 1               # (Max) number of tasks per job, for R usually 1
#SBATCH -o out.txt         # File for the standard output
#SBATCH -e err.txt         # File for the standard error
#SBATCH --open-mode=append # Append to standard output and error files
#SBATCH -p serial_requeue  # Partition to use
#SBATCH --mem-per-cpu=4096 # Memory required per CPU, in MegaBytes
#SBATCH --mail-user=csardi.gabor@gmail.com
#SBATCH --mail-type=ALL    # When to send mail
#SBATCH -a 1-9             # Array of 9 jobs, with ids 1, 2, ..., 9

if (Sys.getenv("SLURM_JOB_ID") != "") {
  library(stat221)

  true_cor <- c(0.5, 0.8, 0.9)
  noise_var <- c(0.1, 0.2, 0.5)
  my_id <- as.numeric(Sys.getenv("SLURM_ARRAY_TASK_ID"))
  params <- expand.grid(true_cor = true_cor, noise_var = noise_var)
  my_params <- params[my_id,]
  noisy_cor(num_genes = 5000, true_cor = my_params$true_cor,
            noise_var = my_params$noise_var, to_file = TRUE)

}
