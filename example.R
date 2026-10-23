# A first R script: run it to check that R works in your Codespace.
#
# Click on a line and press Ctrl+Enter (Cmd+Enter on a Mac) to run it. R starts
# in the terminal at the bottom the first time. To run the whole file, select
# everything first (Ctrl+A, or Cmd+A on a Mac), then press Ctrl+Enter.

# Read the small practice dataset that sits next to this file,
# and show the first few rows
patients <- read.csv("patients.csv")
head(patients)

# The average age, and the average systolic blood pressure
mean(patients$age)
mean(patients$systolic_bp)

# A first chart: it opens in an "R Plot" tab
hist(patients$age,
     main = "Age distribution of practice patients",
     xlab = "Age (years)",
     col  = "steelblue")

# A chart with ggplot2, which also checks that the course packages are installed
library(ggplot2)

ggplot(patients, aes(x = age, y = systolic_bp, colour = diabetes)) +
  geom_point(size = 3) +
  labs(x = "Age (years)", y = "Systolic blood pressure (mm Hg)",
       colour = "Diabetes")
