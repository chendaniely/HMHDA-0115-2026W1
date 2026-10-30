# Examples from Hadley Wickham's "Tidy Data" (JSS, 2014), using tidyr
#
# tidy data:
#   1. each variable = a column
#   2. each observation = a row
#   3. each type of observational unit = a table
#
# the paper lists 5 ways data gets messy, 4 of them here
# (ebola stands in for the paper's tuberculosis data, same problem)
#
#   - column headers are values, not variable names  -> pew, billboard
#   - multiple variables in one column                -> ebola (subs for TB)
#   - variables in both rows and columns              -> weather
#   - multiple types in one table                     -> billboard

library(tidyverse)


# ---------------------------------------------------------------------------
# Problem 1: Column headers are values, not variable names
# ---------------------------------------------------------------------------

# religion vs income
# the income brackets are column headers
# but they are values of an "income" variable, not variables
pew <- read_csv("pew.csv")
pew

# gather everything but religion into 2 columns
# bracket (from the old column name), count (from the cell)
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


# ---------------------------------------------------------------------------
# Problem 1 again: Multiple types in one table
# ---------------------------------------------------------------------------

# billboard top-100
# wk1..wk76 hold the rank that week
# so the week number is a value hiding in the column header
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
  ) |>
  # date at a rank = date it entered + (week - 1) weeks
  mutate(date = date.entered + (week - 1) * 7) |>
  arrange(artist, track, week) |>
  select(year, artist, track, time, week, rank, date)
billboard_tidy


# ---------------------------------------------------------------------------
# Problem 2: Multiple variables stored in one column
# ---------------------------------------------------------------------------

# ebola case counts
# Cases_Guinea = 2 variables in one header
# the count type (Cases/Deaths) and the country, joined by an underscore
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


# ---------------------------------------------------------------------------
# Problem 3: Variables are stored in both rows and columns
# ---------------------------------------------------------------------------

# mexican weather stations
# tmax/tmin are stuck in the element rows
# days of the month are spread across d1..d31
# so: gather days into rows, spread element into columns
weather <- read_csv("weather.csv")
weather

weather_tidy <- weather |>
  pivot_longer(
    cols = starts_with("d"),
    names_to = "day",
    names_prefix = "d",
    names_transform = list(day = as.integer),
    values_to = "temp",
    values_drop_na = TRUE
  ) |>
  mutate(date = make_date(year, month, day)) |>
  pivot_wider(
    names_from = element,      # tmax / tmin become their own columns
    values_from = temp
  ) |>
  select(id, date, tmax, tmin) |>
  arrange(id, date)
weather_tidy

ebola_tidy <- ebola_long |>
  pivot_wider(
    names_from = type,
    values_from = count
  ) |>
  rename(date = Date, day = Day, cases = Cases, deaths = Deaths) |>
  mutate(date = mdy(date)) |>
  arrange(country, date)
ebola_tidy


# ---------------------------------------------------------------------------
# Problem 4: Multiple observational units in one table
# ---------------------------------------------------------------------------

# this tidy table still mixes 2 units
# song facts (year, artist, track, time) repeat on every weekly-rank row
# split into 2 tables sharing an id key
song <- billboard_tidy |>
  distinct(artist, track, year, time) |>
  mutate(id = row_number(), .before = 1)
song

rank <- billboard_tidy |>
  left_join(song, by = c("artist", "track", "year", "time")) |>
  select(id, week, date, rank)
rank