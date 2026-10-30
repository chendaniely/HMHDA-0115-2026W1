# code from
# https://ds4biomed.tech/visualization-intro#data-geometries

library(medicaldata)
library(tidyverse)

blood <- medicaldata::blood_storage
head(blood) # use head to look at the first 6 rows

recurrence_freq <- blood |>
  group_by(Recurrence) |>
  summarize(count = n())
recurrence_freq

# add a data layer
ggplot(data = blood)


# add a data later with an asthetic mapping
ggplot(data = blood, mapping = aes(x = Recurrence))

# add a geometry layer
# by default the stat layer for geom_bar will count values
ggplot(data = blood, mapping = aes(x = Recurrence)) + geom_bar()

# everything in the base layer
ggplot(data = recurrence_freq, mapping = aes(x = Recurrence, y = count)) +
  geom_bar(stat = "identity")

# move astetic mapping to geom layer
ggplot(data = recurrence_freq) +
  geom_bar(mapping = aes(x = Recurrence, y = count), stat = "identity")

# move data to geom layer
ggplot() +
  geom_bar(data = recurrence_freq, mapping = aes(x = Recurrence, y = count), stat = "identity")



# univariate

ggplot(blood, aes(x = Age)) + geom_histogram()

ggplot(blood, aes(x = Age)) + geom_histogram(bins = 10)


# bivariate

# Does not show TVol properly
ggplot(blood) + geom_boxplot(aes(x = TVol, y = Age))

# please a box plot for each value of TVol as a factor
ggplot(blood) + geom_boxplot(aes(x = as.factor(TVol), y = Age))

ggplot(blood) + 
  geom_violin(aes(x = as.factor(TVol), y = Age)) +
  geom_boxplot(aes(x = as.factor(TVol), y = Age))

ggplot(blood) + 
  geom_violin(aes(x = as.factor(TVol), y = Age)) +
  geom_point(aes(x = as.factor(TVol), y = Age))

ggplot(blood) +
  geom_violin(aes(x = as.factor(TVol), y = Age)) +
  geom_jitter(aes(x = as.factor(TVol), y = Age))

ggplot(blood, aes(x = as.factor(TVol), y = Age)) +
  geom_violin() +
  geom_jitter()

# other

ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA))

ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = sGS))

ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(sGS)))

# facets

# use facet wrap for a single variable
ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(sGS))) +
  facet_wrap(~ RBC.Age.Group)

# use facet grid for 2 variables
ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(FamHx))) +
  facet_grid(RBC.Age.Group ~ Recurrence)
