library(tidyverse)

pew <- read_csv("pew.csv")
pew

pew_tidy <- pew |>
  pivot_longer(
    cols = -religion,
    names_to = "income",
    values_to = "frequency"
  )
pew_tidy

pew_tidy |>
  group_by(religion) |>
  summarize(count = sum(frequency))



billboard <- read_csv("billboard.csv")
billboard

billboard_tidy <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    names_transform = list(week = as.integer),
    values_to = "rank",
    values_drop_na = TRUE          # drop weeks the song was not on the chart
  )
billboard_tidy

billboard_tidy |>
  group_by(week) |>
  summarize(average_rank = mean(rank)) |>
  ggplot(aes(x = week, y = average_rank)) +
  geom_line()



ebola <- read_csv("ebola.csv")
ebola

ebola_long <- ebola |>
  pivot_longer(
    cols = -c(Date, Day),
    values_to = "count",
    values_drop_na = TRUE
  )
ebola_long

ebola_long <- ebola_long |>
  separate(col = 'name',
    into = c("type", "country"),  # split the header into two variables
    sep = "_"
  )
ebola_long

ebola_long |>
  group_by(country, type) |>
  summarize(max_count = max(count))

ebola_tidy <- ebola_long |>
    pivot_wider(
        names_from = type,
        values_from = count
) 

ebola_tidy