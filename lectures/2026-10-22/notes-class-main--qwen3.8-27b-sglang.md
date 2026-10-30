# Tidy Data in Code: Reshaping Messy Datasets with the Tidyverse

Instructor: Daniel Chen

## Summary

This office-hour lecture continued last week's thread (transactional vs. analytics servers, `GROUP BY`, roll-ups and drill-downs) by moving it into code. Daniel Chen walked through Hadley Wickham's 2014 paper *Tidy Data* (PDF in the course repo's `readings/` folder) and demonstrated, live in R, what "clean data" formally means and how to get messy real-world tables into that shape: `pivot_longer()` on the Pew religion/income table and the Billboard 2000 top-100 weekly rankings, `separate()` on the 2014 Ebola case/death counts, `group_by()` + `summarize()` for counts per religion and per-country totals, and `pivot_wider()` back to wide form for the Ebola data and the paper's weather example (days `d1`–`d31` across columns, `tmax`/`tmin` in a row).

It was also the first session run in the new no-install workflow: a public course repository (linked on Canvas) with all datasets at the top, opened in a GitHub Codespace in the browser, with GitHub Copilot available as an AI coding agent in the side panel. Chen showed how to create, stop, and delete a Codespace, that deleting one destroys any code you haven't saved elsewhere (the day's script will be committed to the repo so a fresh Codespace starts with it), and that the free tier gives roughly 1,500 AI requests per month plus a GitHub student pack for those with a university affiliation.

By the end, students left with the tidy-data vocabulary — `tidy`, `pivot_longer`, `pivot_wider`, `separate`, "group-by summaries" — which Chen stressed is exactly the vocabulary for prompting the coding agent. Copilot was used for real: it read the open `billboard_tidy` data, proposed and applied a `group_by(week) |> summarize(average_rank = mean(rank))` pipeline plus a `ggplot2` line (average song rank trends downward across a song's chart life), and once produced the wrong grouping, which the instructor caught and corrected. Next week uses the same Codespace environment to teach visualization; `ggplot2` was only glimpsed today.

## Knowledge Points

### 1. The three rules of tidy data

- **Tidy data (Wickham, *Tidy Data*, 2014)**: the formal shape that analytic software expects data in before you can plot, model, or aggregate it. Wickham is the originator of the R tooling built around this idea (the tidyverse).
- **Rule 1 — each variable is a column**: a variable is anything you measure. In `pew.csv`, the ten income brackets (`<$10k`, `$10-20k`, …, `$100-150k`, `>150k`, `Don't know/refused`) are *values of one variable* called `income`, not ten separate variables.
- **Rule 2 — each observation is a row**: the observation is the unit you measure (a person's response, a song in a given week, a country on a given day). Treatment A and treatment B are different observations of the same person, so they must be in different rows — which is why the paper's "table 3" (one row per person × treatment) is tidy even though it looks less nice for eyeballing.
- **Rule 3 — each cell holds exactly one value**: one measurement per cell. The classic violation is an Excel cell carrying a number *and* a color meaning good/bad: color disappears the moment the data is loaded into any software, so you need an extra flag column instead. Same logic for a cell like `52` in the paper's tuberculosis table, which simultaneously encodes a sex and an age group — once two facts are mashed into one value you can't compute anything on either one.
- **Paper point 3 — each type of observational unit forms its own table**: this is why databases split and join tables (in class: song facts vs. weekly ranks). The paper's last two points deal with splitting and joining tables; once you've fixed the three problems, the data is tidy, and you can always reshape it back for reporting.
- **The trade-off**: tidy form is less space-efficient and can look worse to a human than the wide table, but it's the shape plotting, model-fitting, and group-by calculations need — and wide forms are always recoverable from it.

### 2. How data gets messy: the patterns to look for (and their fixes)

- **Column headers are values, not variable names** — the most common mess in the wild. The diagnostic Chen gave: *look for patterns in a block of column names* (`$10k`, `$10-20k`, …; `wk1`…`wk76`; `Cases_Guinea`, `Deaths_SierraLeone`, …). When a chunk of headers follows a pattern, they're values of a hidden variable. Fix: `pivot_longer()` (called "melting"/"molten" in the 2014 paper) — headers become values in a new column, cell contents move into another new column, and you trade columns for more rows.
- **Multiple variables in one column** — e.g., the paper's tuberculosis table, where one column like `M014` packs sex + age group into a single cell. Fix: `separate()` on the delimiter.
- **Variables stored in both rows and columns** — the weather example: days of the month run across `d1`–`d31` columns while the temperature element (`tmax`/`tmin`) sits in a row; after melting, the single `temp` column mixes min and max temperatures, so "the average of this column" is nonsense (an average of a mix of mins and maxes). Same reasoning when a column mixes different *units* (counts next to dollar amounts in census data): everything is numeric, but any summary statistic is meaningless. Fix: `pivot_longer()` on the day columns, then `pivot_wider()` so each element gets its own column.
- **Multiple types of observational units in one table** — e.g., song facts repeating on every weekly-rank row. Fix: split into two tables sharing a key (the paper's last two points).
- **Real-world failure mode (story)**: during COVID, daily data — he referenced the NHS — gained one new column per day until Excel literally ran out of columns; updates stopped landing on the right column, modelling broke for a long stretch, and days of data went missing between the last updated column and "today". Rows are cheap to add; columns run out — that's why long/tidy storage matters.
- **Leave breadcrumbs when hand-curating data**: if you're keying a report by hand, leave machine-readable structure — a strategic one-letter prefix, or an underscore/dash between parts (`Cases_Guinea` = *what's being counted* `_` *where*). The Ebola column headers do exactly this, and it's what makes the later `separate()` a one-liner. "They will be very thankful" — for you or for the next person cleaning it.
- **Diagnostic heuristics**: if your eye has to jump around to explain what each number means, or you can't point a summary at a single column, the data isn't tidy yet.

### 3. The reshaping verbs (tidyr)

- **`pivot_longer()`** — melt wide columns into rows.
  - `cols`: which columns to melt. `-religion` means *everything except* `religion`; `starts_with("wk")` matches `wk1`…`wk76` by prefix; `-c(Date, Day)` keeps those two.
  - `names_to = "income"`: the new column that receives the old column *headers*.
  - `values_to = "frequency"`: the new column that receives the old cell *values*.
  - `names_prefix = "wk"`: strip that prefix from the new names, so `wk3` becomes `3`.
  - `names_transform = list(week = as.integer)`: cast the new names to numbers (otherwise they're text).
  - `values_drop_na = TRUE`: drop rows whose value is `NA` (billboard: weeks the song wasn't on the chart; ebola: country-days with no report).
  - Size changes in class: `pew` 18 × 11 → `pew_tidy` 180 × 3; `billboard` 317 × 81 → `billboard_tidy` 5,307 rows (a given song appears in up to ~57 of the week columns).
- **`separate()`** — split one column into several at a delimiter: `separate(col = 'name', into = c("type", "country"), sep = "_")` turned `Cases_SierraLeone` into `type = "Cases"` and `country = "SierraLeone"`.
- **`pivot_wider()`** — the inverse of `pivot_longer()`; conceptually what an Excel pivot table does. `names_from = type` turns each unique value of `type` (`Cases`, `Deaths`) into its own column; `values_from = count` supplies the cell values. Result: `ebola_tidy`, one row per country-day with `Cases` and `Deaths` side by side (375 × 5), so `max(Cases)` and `max(Deaths)` each mean something on their own — "the maximum case-and-death count" did not.

### 4. Grouping and summarizing

- **Summary function**: any calculation that takes many numbers and returns one — `sum()`, `mean()`, `max()` are the examples given.
- **`group_by()` + `summarize()`**: the code version of the roll-ups and drill-downs discussed last week with `GROUP BY`. `group_by(religion)` says "for each religion"; `summarize(count = sum(frequency))` says "sum the `frequency` column"; `count =` names the result column. You can compute several summaries at once, and grouping by multiple variables builds the higher-dimensional "cube" from last week (even 2-D, you can group by several variables).
- **In class**: per-religion survey totals (Catholic 8,054; Evangelical Protestant 9,472; Unaffiliated 3,707; …), and — for Ebola, whose daily counts are *cumulative* running totals, which is how the Ministries of Health reported — the per-country/type total is `max(count)`: Sierra Leone 10,030 cases / 2,977 deaths; Guinea 2,776 / 1,786; 8 countries × 2 types = 16 rows.
- **Why tidiness matters here**: none of these cuts are possible while the variable is hiding in a header or mashed into a cell — you can only point `sum()`/`max()`/`group_by()` at a real column. The tidy form "doesn't look nice" to a human, but the computer needs it to do the calculations.

### 5. Tidyverse plumbing seen in the logs

- **`library(tidyverse)`** loads the whole toolkit at once; the console message listed the attached packages and versions (`dplyr 1.2.1`, `tidyr 1.3.2`, `ggplot2 4.0.3`, `readr 2.2.0`, `lubridate 1.9.5`, …) and normal conflict notices (`dplyr::filter()` masks `stats::filter()`).
- **`read_csv("pew.csv")`** — the course datasets sit at the top of the repository, so no folder path is needed. It prints a column-specification message (row/column counts and inferred types) — read it, because it's where the mess shows up: Pew came in as 18 × 11 (`religion` character + ten numeric income columns), and Billboard as 317 × 81, where `wk66`–`wk76` even inferred as all-`NA` logicals.
- **The pipe `|>`**: passes the object on the left into the next function, so a pipeline reads almost like English. That's why the instructor prefers R: "it actually sounds like English when you think through the problem, and then see how the code relates to that" — say the transformation out loud, then write it.
- **`NA`**: R's missing-value placeholder, displayed in a distinct color and in uppercase — deliberately obvious, so you never confuse "missing" with `0` (which means something) or with a blank.
- **Date handling**: `mutate(date = date.entered + (week - 1) * 7)` computes the date a song held a given Billboard rank; `make_date(year, month, day)` assembles the weather dates; `mdy(date)` parses Ebola's character dates (`"1/5/2015"` is month-day-year).
- **Housekeeping verbs**: `select()` (keep/reorder columns), `arrange()` (sort), `distinct()` (drop duplicate fact rows), `row_number()` (assign ids; `.before = 1` puts the new column first), `left_join(x, by = ...)` (re-attach a key).
- **Splitting the Billboard table** (paper point 3): the tidy table still mixes two observational units — song facts (`year`, `artist`, `track`, `time`) repeat on every weekly-rank row. The fix is two tables sharing a key: `song` (one row per fact, with a generated `id`) and `rank` (`id`, `week`, `date`, `rank`) — the same split-and-join pattern databases use, and the shape an analytics server expects.

### 6. GitHub Codespaces: the no-install environment

- **Course repository on Canvas**: a public GitHub repo holding the recordings, text, AI summaries, the datasets (CSV/TSV at the top), and the *Tidy Data* paper PDF under `readings/`. No GitHub account is needed to *view* it (you can read it on a phone, no sign-in); an account is needed to run a Codespace.
- **Starting one**: repo → green `Code` button → `Codespaces` tab → `Create codespace` (or the `+` button if you already have one). First launch takes about five minutes to download and start — the instructor preloaded his for that reason; it starts faster after the first time.
- **Confirming it's ready**: in the R console, type `R` and hit Enter. Run selected code with `Ctrl+Enter` (macOS: `Cmd+Enter`).
- **Stopping vs. deleting (important)**: `…` menu → **Stop codespace** keeps the container warm so the next start is quick. **Delete** destroys it: anything you typed that wasn't saved elsewhere is *gone*, and the next launch costs the full download again (about five minutes). The instructor will commit the day's script to the repo so a brand-new Codespace starts with the class code; until then, treat the Codespace as a playground and copy out any code you want to keep.
- **Credits**: GitHub gives a free monthly allowance for Codespaces AI — he quoted roughly 1,500 AI requests per month on the free tier, and GitHub also offers a student developer pack with extra credits for people with a university affiliation; the class tasks don't need a top-end model.
- **Privacy (hard rule)**: because the agent can read your code *and* your data, and the repo/fork ecosystem is public — **real patient data or anything that can identify individuals never goes into the Codespace or the course repository.**

### 7. Working with Copilot in the Codespace

- **What it is**: the agent panel on the right ("the little coding chatbot"). It's *agentic* — unlike a web chatbot, it can read the open code and data, modify your actual codebase, and asks permission ("can I make this change to your codebase?") before applying; you accept, then decide whether to keep it.
- **The in-class demo**: prompt 1 — "take the Billboard tidy dataset and look at the average ranking over each week across all the songs" → Copilot proposed and applied `group_by(week) |> summarize(average_rank = mean(rank))`. Prompt 2 — "plot that result as a line" → `ggplot(aes(x = week, y = average_rank)) + geom_line()`. Result: average rank trends downward across a song's chart life (people get tired of a hit; the trend flattens off after roughly twenty weeks). `ggplot2` itself is next week's session; today was a glimpse.
- **Prompting strategy**: work in smaller steps — ask one question at a time, get one piece of code at a time. And the tidy-data vocabulary *is* the prompting vocabulary: `tidy`, `pivot_longer`, `pivot_wider`, `separate`, "group by / summarize" are words you can type to steer the agent ("go and tidy this").
- **Don't trust blindly**: in the Ebola example, Copilot first grouped by the wrong variables (day and country) when the question was per country and per count-type; the instructor caught it ("it just put it in the wrong location for me… the LLM did something I didn't want") and rewrote the grouping. Always read what the agent actually grouped and computed.

## Code from class

### 1. Load the toolkit and read the Pew data

```r
library(tidyverse)                # load the whole toolkit at once (dplyr, tidyr, readr, ggplot2, ...)
pew <- read_csv("pew.csv")        # datasets sit at the top of the repo; no folder path needed
```

The `read_csv()` message *is* the problem statement — ten income brackets masquerading as variables:

```text
Rows: 18 Columns: 11
── Column specification ─────────────────────────────────────────────
Delimiter: ","
chr  (1): religion
dbl (10): <$10k, $10-20k, $20-30k, $30-40k, $40-50k, $50-75k, $75-100k, $100...
```

### 2. Melt the income brackets into rows

```r
pew_tidy <- pew |>
  pivot_longer(
    cols = -religion,             # melt everything EXCEPT religion
    names_to = "income",          # old column headers become values here
    values_to = "frequency"       # old cell values become numbers here
  )
```

Before: 18 rows × 11 columns. After: 180 rows × 3 columns — one observation (religion × income group) per row, one number per cell.

```text
# A tibble: 180 × 3
   religion income             frequency
   <chr>    <chr>                  <dbl>
 1 Agnostic <$10k                     27
 2 Agnostic $10-20k                   34
 3 Agnostic $20-30k                   60
```

### 3. Summarize: how many people did we ask, per religion?

```r
pew_tidy |>
  group_by(religion) |>
  summarize(count = sum(frequency))   # "for each religion, sum the frequency column"
```

This is the code version of last week's roll-up. Note `count =` names the result column:

```text
# A tibble: 18 × 2
   religion                count
   <chr>                   <dbl>
 1 Agnostic                  826
 ...
 4 Catholic                 8054
 ...
 6 Evangelical Prot         9472
```

### 4. Billboard: melt weeks 1–76 into week + rank

```r
billboard <- read_csv("billboard.csv")

billboard_tidy <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),                 # grab wk1 ... wk76 by prefix pattern
    names_to = "week",
    names_prefix = "wk",                      # strip "wk" so names are 1, 2, 3, ...
    names_transform = list(week = as.integer),# ...and make them numbers, not text
    values_to = "rank",
    values_drop_na = TRUE                     # drop weeks the song was off the chart
  ) |>
  mutate(date = date.entered + (week - 1) * 7) # calendar date of each ranked week
  |>
  arrange(artist, track, week)
  |>
  select(year, artist, track, time, week, rank, date)
```

`read_csv()` reported 317 × 81 columns in; `wk66`–`wk76` even came in as all-`NA` logicals. Out: 5,307 (song, week) rows.

```text
# A tibble: 5,307 × 7
    year artist  track                   time   date.entered  week  rank
   <dbl> <chr>   <chr>                   <time> <date>       <int> <dbl>
 1  2000 2 Pac   Baby Don't Cry (Keep... 04:22  2000-02-26       1    87
```

### 5. Ask Copilot: average ranking per week, then plot it

Generated by GitHub Copilot after the prompts "average ranking over each week across all the songs" and "plot that result as a line":

```r
billboard_tidy |>
  group_by(week) |>
  summarize(average_rank = mean(rank)) |>
  ggplot(aes(x = week, y = average_rank)) +
  geom_line()
```

Average rank trends down over a song's chart life (listeners tire of a hit; the curve flattens after ~20 weeks). `ggplot2` gets its own session next week — this was a first look.

### 6. Ebola: melt the country-count columns, then split the combined codes

The paper's tuberculosis example (cells like `M014` = sex + age group) stood in for here as the 2014 Ebola dataset: `Cases_Guinea`, `Deaths_SierraLeone`, … — the count-type and country mashed into each header, with an underscore as the breadcrumb.

```r
ebola <- read_csv("ebola.csv")

# step 1: every Cases_*/Deaths_* column becomes rows; Date + Day stay
ebola_long <- ebola |>
  pivot_longer(
    cols = -c(Date, Day),
    values_to = "count",
    values_drop_na = TRUE
  )

# step 2: split the old header on the underscore into two real variables
ebola_long <- ebola_long |>
  separate(col = 'name',
    into = c("type", "country"),   # "Cases_Guinea" -> type = Cases, country = Guinea
    sep = "_"
  )
```

Before/after — the header value `name` becomes two clean variables:

```text
# A tibble: 738 × 4                       # A tibble: 738 × 5
   Date       Day name               count      Date       Day type   country     count
   <chr>    <dbl> <chr>              <dbl>      <chr>    <dbl> <chr>  <chr>       <dbl>
 1 1/5/2015   289 Cases_Guinea        2776     1 1/5/2015   289 Cases  Guinea       2776
 2 1/5/2015   289 Cases_SierraLeone  10030    2 1/5/2015   289 Cases  SierraLeone  10030
 3 1/5/2015   289 Deaths_Guinea       1786     3 1/5/2015   289 Deaths Guinea       1786
```

### 7. Total case and death counts per country

Because the daily counts are *cumulative* (that's how the Ministries of Health reported), the per-country total is the maximum:

```r
ebola_long |>
  group_by(country, type) |>
  summarize(max_count = max(count))   # one row per country × type
```

R printed a regrouping notice (expected — summaries collapse grouping levels as you go down):

```text
`summarise()` has regrouped the output.
ℹ Summaries were computed grouped by country and type.
ℹ Output is grouped by country.
```

```text
# A tibble: 16 × 3
# Groups:   country [8]
   country      type   max_count
   <chr>        <chr>      <dbl>
 1 Guinea       Cases       2776
 2 Guinea       Deaths      1786
 ...
11 SierraLeone  Cases      10030
12 SierraLeone  Deaths      2977
```

### 8. Back to wide form: one row per country-day

Now that `type` is a real variable, spread `Cases` and `Deaths` into their own columns so each summary makes sense on its own:

```r
ebola_tidy <- ebola_long |>
  pivot_wider(
    names_from = type,        # each unique value (Cases, Deaths) becomes a column
    values_from = count       # these values fill the cells
  ) |>
  rename(date = Date, day = Day, cases = Cases, deaths = Deaths) |>
  mutate(date = mdy(date))    # "1/5/2015" was text; mdy() parses month-day-year
  |>
  arrange(country, date)
```

```text
# A tibble: 375 × 5
   Date         Day country     Cases Deaths
   <chr>      <dbl> <chr>       <dbl>  <dbl>
 1 1/5/2015     289 Guinea       2776   1786
```

### 9. Weather: long the days, wide the temperature elements

The paper's final example (Mexican weather stations): days of the month spread across `d1`–`d31` columns, and the element (`tmax`/`tmin`) stuck in a row — so after melting, one `temp` column mixed two different measurements. Melt the days first, then widen the elements:

```r
weather <- read_csv("weather.csv")

weather_tidy <- weather |>
  pivot_longer(
    cols = starts_with("d"),              # d1 ... d31
    names_to = "day",
    names_prefix = "d",
    names_transform = list(day = as.integer),
    values_to = "temp",
    values_drop_na = TRUE
  ) |>
  mutate(date = make_date(year, month, day)) |>
  pivot_wider(
    names_from = element,                 # tmax / tmin become their own columns
    values_from = temp
  ) |>
  select(id, date, tmax, tmin) |>
  arrange(id, date)
```

### 10. Split the song/rank mix of observational units

The tidy Billboard table still mixes two units (song facts repeating on every rank row), so it ends as two tables sharing a key — the paper's guidance that each type of observational unit forms its own table:

```r
# song facts: one row per (artist, track, year, time), with a generated id
song <- billboard_tidy |>
  distinct(artist, track, year, time) |>
  mutate(id = row_number(), .before = 1)

# weekly ranks: one row per (song, week), re-attached through the shared key
rank <- billboard_tidy |>
  left_join(song, by = c("artist", "track", "year", "time")) |>
  select(id, week, date, rank)
```

## Questions

- **Q:** A student asked whether the starter data provided for the Module 1 assignment was already a tidy data set.
  **A:** Yes — the instructor said that assignment's data had already been cleaned for the class; the tidy-data session is aimed at students who want to bring their *own* (messy) data sets into an analysis-ready form.

## Assignments

- [ ] Create and explore a GitHub Codespace from the course repository (green `Code` button → `Codespaces` → `Create codespace`) and try it with Copilot — the instructor asked students to "give it a try" this week and report any issues (no due date stated).
- [ ] Watch the recording and follow along at your own pace this week; the first ~15 minutes are the setup guide, and the day's R script will be saved in the repository (no due date stated).

---

- prompt: prompt-notes.md @ 9540d32
- prompt-hash: c082a6eab694
- model: qwen3.8-27b-sglang (requested: qwen3.8-27b-sglang)
- backend: local (SGLang)
- inputs: transcript-plaud.md, history.R, R-console.txt
- generated: 2026-10-30
