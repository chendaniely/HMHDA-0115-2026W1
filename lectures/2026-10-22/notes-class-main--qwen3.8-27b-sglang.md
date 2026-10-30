# Tidy data in R: `pivot_longer()`, `separate()`, `pivot_wider()`

Date Time: 2026-10-22

Instructor: Daniel Chen

## Summary

This session continued the office-hours series that moves the course from point-and-click

tools to working code-first: R with the `tidyverse`, in a GitHub Codespace in the browser,

with the built-in coding agent. It was the first session using that setup. The instructor

walked through the new workflow — the course repository now holds the datasets at the top

level, the "tidy data" paper under `readings/`, and will hold every recording, transcript,

AI summary, and the class code — and showed how to open the repository, create a

Codespace, and tell when R is ready.

The main topic was the 2014 paper "Tidy Data" by Hadley Wickham. The session defined what

a tidy dataset is, named the three common ways data gets messed up, and demonstrated the

`tidyverse` fix for each one live in R: `pivot_longer()` on the Pew religion-by-income

survey data and the Billboard 2000 ranking data, `separate()` plus `pivot_wider()` on the

2014 Ebola case and death counts, with `group_by()` and `summarize()` answering real

questions along the way. The coding agent drafted part of the code live (the weekly

average rank and its line plot, and a first, wrong attempt at the Ebola summary), and the

instructor showed how to read, accept, or correct the agent's code.

As a result, a student can now open the course repository in a Codespace with no local

install, recognize the three messy-data problems by their visual cues, tidy each one with

the matching `tidyverse` function, and compute grouped summaries. The instructor asked

students to try the Codespace this week, report problems, and follow the recording; next

week's session uses the same setup to build visualizations with `ggplot2`.

## Knowledge Points

### 1. The new workflow: GitHub Codespaces in the browser

- **No install needed**: the course's code-first sessions run in a GitHub Codespace in the
  browser. Today is the first session trying this, and the instructor asked students to
  give it a try and report what breaks; the recording's first fifteen minutes are the
  setup guide, and the repository will be updated with a screenshot walkthrough.
- **GitHub account**: needed to create a Codespace. Not needed to read the repository:
  everything posted (summaries, recordings, code, data) is fully public and can be viewed
  without signing in, even on a phone.
- **Steps**: open the course repository → the green `Code` button → the `Codespaces` tab →
  the green "Create Codespace" button (or the `+` button if one already exists). It takes
  about five minutes to load.
- **Ready check**: when the environment is up, type a capital `R` and press Enter in the
  console. Run selected code with `Command+Enter` (Mac) or `Control+Enter`.
- **Stop vs. delete**: the three-dot menu → "Stop Codespace" lets the next session load
  faster. Deleting means waiting the full ~5 minutes again — and anything written inside
  the Codespace is lost when it is deleted, so treat it as a playground and copy out what
  you want to keep.
- **Credits**: GitHub Codespaces comes with a free monthly credit; the free AI tier
  mentioned gives 1,500 agent requests per month, and GitHub's student pack (for anyone
  with a university affiliation) adds more credits.
- **Where things live**: the course datasets (`pew.csv`, `billboard.csv`, `ebola.csv`,
  `gapminder.tsv`, `patients.csv`, `weather.csv`) sit at the top level of the repository,
  so `read_csv("pew.csv")` needs no folder. The tidy data paper is in `readings/`. The
  class code is saved in the repository in a numbered file ("1 - tidy") so it sorts to
  the top.

### 2. Follow-up from last week: analytics vs. transactional servers

- Last week's open question — does a given dataset live on the transactional or the
  analytics server — was answered: most likely you are given the dataset on the
  analytics server. In practice you don't feel the difference, and that is enough for the
  course. Last week's roll-up / drill-down and `group by` material connects directly to
  this week's `group_by()` + `summarize()`.

### 3. Tidy data: the three properties (Wickham, 2014)

- **The paper**: "Tidy Data" (2014) by Hadley Wickham, one of the originating creators of
  the R data-cleaning tooling; it sits in `readings/` in the course repository.
- **Each variable forms a column**: one variable = one column. "Treatment A" and
  "Treatment B" are two values of one variable (`treatment`), not two separate columns.
- **Each observation forms a row**: one unit of measurement = one row, which is why two
  different treatments do not share a row.
- **Each cell holds a single value**: if a cell mixes pieces of information — a value plus
  its color, two numbers, a code like `M014` — it violates this. Color "does not exist in
  a dataset": no software can read what your green/red highlighting meant, so if you flag
  good vs. bad, use a column.
- **Why accept the long, "ugly" form**: the tidy form is less compact for human reading
  and reporting, but it is the shape that plotting, model fitting, and `group_by()`
  summaries need. From a tidy dataset you can always reshape back into the reporting form;
  the reverse is not true.
- **Breadcrumbs**: when hand-curating data (e.g., typing it out of a report), leave
  systematic markers — a one-letter code prefix, or an underscore or dash between parts
  (`Cases_Guinea` style). The instructor recommends this even if you don't know how to
  process it yet; it makes the later split mechanical.

### 4. The three common ways data gets messed up

- **Column headers are values, not variable names**: a run of column names follows a
  pattern — income ranges (`<$10k`, `$10-20k`, …), `wk1`–`wk76`, `Cases_Guinea`, … — and
  that pattern is really one variable. The visual cue: look for column names that follow
  a pattern; they belong in one column with their names moved into a value column. Fix:
  `pivot_longer()`.
- **Multiple variables in one column**: one cell carries more than one piece of
  information. In the paper's tuberculosis table, the `M014`-style columns pack sex, age
  band, and count into each value (the `52` in a cell is *male, 0–14, count 52*). Once
  that happens you can't point at a variable anymore, so `group_by()` has nothing to
  point at. Fix: `separate()`.
- **Multiple observations in one row**: after `pivot_longer()`, the weather example's
  `value` column mixes minimum and maximum temperatures; averaging that column is
  meaningless ("the average of a bunch of min and max values"). Same logic when a
  `count` column mixes cases and deaths, or — in census-style data — counts and dollar
  amounts: even though everything is a number, a summary statistic is nonsense. Fix:
  `pivot_wider()`.
- **Fix the easier problem first**: a messy dataset may have one, two, or all three
  problems; solve them one step at a time. The Ebola dataset turns out to have all three.
- **Rows grow, columns run out**: you can always add rows, but columns eventually run
  out. The instructor's cautionary tale: during COVID the NHS added a new column every
  day for deaths and infected counts until Excel literally ran out of columns; their
  modeling broke for a long time, silently, because only the last column kept updating
  and every date after that was lost.

### 5. `pivot_longer()`: from "headers are values" to long form

- **What it does**: takes a set of columns and turns them into two — one holding the old
  column names (`names_to`) and one holding the old cell values (`values_to`). The result
  has more rows, hence "longer". The 2014 paper called this "molten" / melting.
- **Choosing the columns**: `cols = -religion` — the minus sign means *everything except*
  `religion` — or a selector like `cols = starts_with("wk")`, which picks only the columns
  whose names start with `wk`.
- **`names_to` / `values_to`**: the names of the two new columns, e.g.
  `names_to = "income"` and `values_to = "frequency"`. If `names_to` is omitted, the new
  column is called `name` (as in the Ebola example, where `separate()` then reads
  `col = 'name'`).
- **`names_prefix`**: strips a fixed prefix from the old column names —
  `names_prefix = "wk"` drops the `wk` from `wk1` so the names are plain numbers.
- **`names_transform`**: applies a function to the new name column, e.g.
  `names_transform = list(week = as.integer)` turns the week labels into integers.
- **`values_drop_na = TRUE`**: drops rows whose value is `NA` — for Billboard, the weeks a
  song was not on the chart at all.

### 6. `NA`: how R marks missing values

- **`NA`** is R's placeholder for "no value"; it prints as a red uppercase `NA`.
- It distinguishes *missing* from `0` — zero is a real, meaningful value, and the
  instructor stressed that dropping or keeping zeros is a different decision from
  dropping `NA`s — and from a blank whose meaning is unclear.
- `values_drop_na = TRUE` is the mechanism that drops the empty weeks (Billboard) and the
  country-days with no report (Ebola).

### 7. `group_by()` + `summarize()`: grouped summaries

- **Summary function**: takes a bunch of numbers in and returns one number out —
  `sum()`, `mean()`, `max()`.
- `pew_tidy |> group_by(religion) |> summarize(count = sum(frequency))` answers "how many
  people did we ask, for each religion?". In the original wide form this would have meant
  summing across each row by hand; the tidy form makes it one line. The name on the left
  of `=` (`count`) is simply the name of the new column.
- `billboard_tidy |> group_by(week) |> summarize(average_rank = mean(rank))` answers the
  average chart position per week.
- `ebola_long |> group_by(country, type) |> summarize(max_count = max(count))` answers "what
  was the total death or case count for each country?" — the Ebola counts are cumulative
  (the ministries of health reported running totals), so the maximum over the period is
  the final total.
- Multiple variables in `group_by()` build the "data cube" roll-ups and drill-downs from
  last week.
- `summarize()` printed a notice — "`summarise()` has regrouped the output. ℹ Summaries
  were computed grouped by country and type. ℹ Output is grouped by country." — the result
  keeps the outermost grouping; it is informational, and `summarize(.groups = "drop_last")`
  silences it.

### 8. `separate()`: one column that holds two variables

- **`separate(col = 'name', into = c("type", "country"), sep = "_")`**: splits one column
  on a separator into two new columns. In the Ebola data, `Cases_Guinea` becomes
  `type = Cases`, `country = Guinea`.
- The pattern generalizes: a deliberate marker — underscore, dash, or one-letter prefix —
  makes the split mechanical. The paper's tuberculosis columns (first letter = sex, rest
  = age band) are the same shape.
- Why R: the instructor's point is that the `tidyverse` reads like English — you can
  verbalize what you want ("take this column, split it on the underscore, make two
  columns called type and country") and the code mirrors the sentence.

### 9. `pivot_wider()`: one value column that holds several observations

- **What it does**: takes the unique values of one column and makes each one its own
  column, filling the cells from a value column —
  `pivot_wider(names_from = type, values_from = count)` turns the `type` values
  (`Cases`, `Deaths`) into two columns next to `Date`, `Day`, `country`. It is the
  inverse of `pivot_longer()`, and the same idea as an Excel pivot table, in code.
- **Why it was needed**: in `ebola_long`, the single `count` column mixed cases and
  deaths, so "the maximum of `count`" is not a number you can report — it would be "the
  maximum case-and-death count". After `pivot_wider()`, the maximum of `Cases` and the
  maximum of `Deaths` are each meaningful. The paper's weather example is the same: a
  `value` column mixing min and max temperatures makes `mean(value)` nonsense, whereas
  "across all of our data, the average maximum temperature was X" is a real statement.
- The result (`ebola_tidy`, 375 × 5) is the tidy form of the Ebola data: one row per
  country-day, with `Cases` and `Deaths` side by side — the shape you want for cumulative
  counts over time.

### 10. `read_csv()` and the column types R reports

- **`read_csv()`** (from `readr`, loaded with the `tidyverse`) prints, for each file, the
  row/column count and the detected type of every column (`chr`, `dbl`, `date`, `time`,
  `lgl`). Read that message: it tells you what R actually saw.
- In `billboard.csv`, 66 columns came in as `dbl` but `wk66`–`wk76` came in as `lgl`
  (logical) because they are entirely `NA` — a real quirk of the file, visible only in
  the column specification.
- Add `show_col_types = FALSE` to `read_csv()` to quiet the message.
- Note for later work: in `ebola.csv` the `Date` column is read as `chr` (text like
  `1/5/2015`), not as a date — a cleanup to do before time-series analysis.

### 11. The coding agent in Codespaces: how to use it, and its limits

- **What makes it different from a web chatbot**: it can read the code you are working
  on — and potentially your data — so it proposes and applies real edits to your script
  ("agentic coding"). It is not just answering in the abstract.
- **Work in small steps**: ask one question at a time and get one piece of code at a time.
  The instructor asked "average ranking over each week across all the songs", then
  "plot that result as a line"; each got a short block to review before accepting.
- **It will do things you did not ask**: the agent's first attempt at the Ebola maximum
  grouped by the wrong variables. Read the proposed code, reject or fix it, and keep
  going — see "What went wrong live".
- **Privacy, with force**: because the agent can read your data, never put data that can
  identify individuals in reach of it. The course repository is public, and a student's
  fork of it stays public — real patient data never goes in it.
- **Vocabulary is leverage**: knowing the words — *tidy*, `pivot_longer()`,
  `pivot_wider()`, `separate()`, `group_by()` + `summarize()` — is exactly what you type
  to steer the agent ("go and tidy this", "average ranking per week").

### 12. `ggplot2` preview

- `ggplot(aes(x = week, y = average_rank)) + geom_line()` drew the line plot of the
  weekly average chart position, generated from the agent's code. The line trends down —
  songs hit the top charts and listeners get sick of them — and the instructor noted the
  drop seems to steepen after about twenty weeks. `ggplot2` itself is next week's topic.

## Code from class

### Loading the `tidyverse`

```r
library(tidyverse)
```

R prints the attach message and, once, this normal masking notice:

```
── Conflicts ───────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()
```

### Reading and tidying `pew.csv`

```r
pew <- read_csv("pew.csv")
pew

pew_tidy <- pew |>
  pivot_longer(
    cols = -religion,          # everything except religion
    names_to = "income",       # the old column names become values
    values_to = "frequency"
  )
pew_tidy
```

The transformation in numbers: `pew` is 18 religions × 11 columns (the 10 income ranges

plus "Don't know/refused"); `pew_tidy` is 180 rows × 3 columns:

```
# A tibble: 18 × 11
    religion `<$10k` `$10-20k` `$20-30k` `$30-40k` `$40-50k` `$50-75k` `$75-100k`
# ...
# A tibble: 180 × 3
    religion income             frequency
    <chr>    <chr>                  <dbl>
  1 Agnostic <$10k                     27
  2 Agnostic $10-20k                   34
```

### How many respondents, per religion

```r
pew_tidy |>
  group_by(religion) |>
  summarize(count = sum(frequency))
```

```
# A tibble: 18 × 2
    religion                count
    <chr>                   <dbl>
  1 Agnostic                  826
  2 Atheist                   515
```

### Reading and tidying `billboard.csv`

```r
billboard <- read_csv("billboard.csv")
billboard

billboard_tidy <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),  # the 76 weekly ranking columns
    names_to = "week",
    names_prefix = "wk",       # drop the "wk" so the name is just a number
    names_transform = list(week = as.integer),
    values_to = "rank",
    values_drop_na = TRUE      # drop weeks the song was not on the chart
  )
billboard_tidy
```

317 songs × 81 columns (year, artist, track, `time`, `date.entered`, `wk1`–`wk76`) become

5,307 rows × 7 columns — one row per song-week that actually had a rank. The instructor

estimated from the paper's example table that one song might carry ~57 such rows; the log

shows the full file:

```
# A tibble: 5,307 × 7
    year artist  track                   time   date.entered  week  rank
    <dbl> <chr>   <chr>                   <time> <date>       <int> <dbl>
  1 2000 2 Pac   Baby Don't Cry (Keep... 04:22  2000-02-26       1    87
  2 2000 2 Pac   Baby Don't Cry (Keep... 04:22  2000-02-26       2    82
```

### Average chart position per week, and its line plot

This block was drafted by the coding agent, in response to "average ranking over each

week across all the songs" and then "plot that result as a line":

```r
billboard_tidy |>
  group_by(week) |>
  summarize(average_rank = mean(rank)) |>
  ggplot(aes(x = week, y = average_rank)) +
  geom_line()
```

The line trends down as listeners get sick of the hit; the fall steepens after about

twenty weeks.

### Reading and tidying `ebola.csv`

```r
ebola <- read_csv("ebola.csv")
ebola

ebola_long <- ebola |>
  pivot_longer(
    cols = -c(Date, Day),      # keep the two identifier columns
    values_to = "count",
    values_drop_na = TRUE
  )
ebola_long

# the column names encode two variables: "Cases_Guinea" -> type + country
ebola_long <- ebola_long |>
  separate(col = 'name',
    into = c("type", "country"),  # split the header into two variables
    sep = "_"
  )
ebola_long
```

Step by step: 122 country-days × 18 columns (`Date`, `Day`, and 16 `Cases_`/`Deaths_`

columns) → 738 × 4 after `pivot_longer()` (with the default name column `name`) → 738 × 5

after `separate()`:

```
# A tibble: 738 × 5
    Date       Day type   country     count
    <chr>    <dbl> <chr>  <chr>       <dbl>
  1 1/5/2015   289 Cases  Guinea       2776
  2 1/5/2015   289 Cases  SierraLeone 10030
  3 1/5/2015   289 Deaths Guinea       1786
```

Note the strategic underscore in the original headers (`Cases_Guinea`): it is what makes

the `separate()` split possible.

### Maximum case and death counts, per country

```r
ebola_long |>
  group_by(country, type) |>
  summarize(max_count = max(count))
```

The counts are cumulative, so the maximum over the 289 reported days is each country's

final total, separately for cases and for deaths:

```
`summarise()` has regrouped the output.
ℹ Summaries were computed grouped by country and type.
ℹ Output is grouped by country.
# A tibble: 16 × 3
# Groups:   country [8]
    country      type   max_count
  11 SierraLeone  Cases      10030
  12 SierraLeone  Deaths      2977
```

### Widening the Ebola data back to one row per country-day

```r
ebola_tidy <- ebola_long |>
    pivot_wider(
        names_from = type,     # Cases and Deaths each become a column
        values_from = count
)

ebola_tidy
```

```
# A tibble: 375 × 5
    Date         Day country     Cases Deaths
    <chr>      <dbl> <chr>       <dbl>  <dbl>
  1 1/5/2015     289 Guinea       2776   1786
  2 1/5/2015     289 SierraLeone 10030   2977
```

This is the tidy form of the Ebola data: from here, cumulative case or death counts over

time are straightforward grouped summaries. (`Date` is still text, `chr`, not a date —

clean that up before plotting by date.)

### What went wrong live

- **The agent grouped by the wrong variables**: asked for the maximum count per type and
  country, the coding agent's first attempt grouped by day and country ("Oh, it's doing by
  day and country… the LLM did something I didn't want"). What fixed it: the instructor
  wrote the grouping himself — `group_by(country, type) |> summarize(max_count = max(count))`.
  Read the agent's proposed code before accepting it.
- **`pivot_wider()` argument misspelled**: mid-demo the instructor typed the argument
  name wrong ("oh, it's not called names from. Oh yeah, `names_from` = type"). The
  working call is `pivot_wider(names_from = type, values_from = count)`.

## Questions

- **Q:** (about the module 1 assignment) Is the starter data provided for that assignment
  already a tidy dataset?
  **A:** Yes — it was cleaned for you. This week's material matters for people who bring
  their own dataset: this is how you get data into the tidy form that's ready for
  analysis.

## Assignments

- [ ] Create a Codespace from the course repository (`Code` → `Codespaces` →
  "Create Codespace") and try the workflow; report any problems to the instructor. No
  due date given — do it this week; the recording's first fifteen minutes are the guide,
  and the repository will be updated with a screenshot walkthrough.
- [ ] Spend the week going through the recording and following along in R. No due date
  given; next week's session continues with visualizations (`ggplot2`) in the same
  Codespace.

---

- prompt: prompt-notes.md @ c7623cc
- prompt-hash: c082a6eab694
- model: qwen3.8-27b-sglang (requested: qwen3.8-27b-sglang)
- backend: opencode
- inputs: transcript-plaud.md, history.R, R-console.txt
- generated: 2026-10-23
