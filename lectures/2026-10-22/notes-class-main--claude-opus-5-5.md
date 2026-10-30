# Tidy Data in R: Reshaping Messy Tables with `pivot_longer()`, `separate()` and `pivot_wider()`

Instructor: Daniel Chen

## Summary

This office-hour session started the move from point-and-click tools to code. Daniel introduced a public GitHub repository that holds the course datasets (CSV and TSV files), the readings (including the Tidy Data paper in the `readings` folder), and, from now on, the office-hour recordings, transcripts and summaries. From that repository you can launch a **GitHub Codespace**: a ready-made R coding environment that runs in the browser, so nothing has to be installed on your own computer. The Codespace also includes **GitHub Copilot**, an AI coding assistant that can read and edit your code. This was the first time the setup was used in this course, so Daniel asked students to try it during the week and report any problems.

The main topic was Hadley Wickham's 2014 paper *Tidy Data*. It gives a formal definition of a "clean" dataset, which is the shape analysis software expects: each variable is a column, each observation is a row, and each cell holds one value. Data is usually collected in whatever layout makes collection easy, which is why transactional systems and analytics systems differ. Daniel walked through the common ways data gets messy and the function that fixes each one:

- Column headers that are really values (fixed with `pivot_longer()`).
- One column that holds more than one variable (fixed with `separate()`).
- Variables stored in both rows and columns (fixed with `pivot_wider()`).

He demonstrated each fix in R with the `pew.csv`, `billboard.csv` and `ebola.csv` datasets.

The session also linked back to the previous week's ideas about roll-ups and drill-downs. Once data is tidy, `group_by()` plus `summarize()` produces grouped summaries, the coded version of a data cube or an Excel pivot table. Daniel used Copilot live to write a summary and a line plot. In one case it got the request wrong and he had to correct it, which showed both how useful these assistants are and why you must check what they produce. He also argued that knowing the vocabulary ("tidy", "pivot longer", "separate", "group by") helps you write better prompts for an AI assistant. Next week will use the same Codespace to cover visualization with `ggplot2`.

## Knowledge Points

### 1. The course repository and GitHub Codespaces

- **The course repository**: a public GitHub repository with all the datasets at the top level, the readings in a `readings` folder, and, going forward, the office-hour recordings, transcripts and AI-generated summaries. Daniel will link it on Canvas.
  - **No account is needed to read it.** You can browse the files and summaries on any device, including a phone.
  - **A GitHub.com account is needed to run code.** GitHub is a site for sharing code.
- **Launching a Codespace**:
  1. On the repository page, click the green **Code** button.
  2. Choose the **Codespaces** tab.
  3. Click **Create Codespace**, or click **+** if you already have one.
  4. Wait for it to start. The first start takes roughly five minutes.
- **Starting R in the Codespace**: when the terminal panel is ready, type a capital `R` and press Enter. You can then copy and paste code into it from the top of a script down.
  - Alternatively, select code in the editor and press **Ctrl+Enter** (Daniel believed it is **Cmd+Enter** on a Mac) to send the selection to the R console.
- **Stopping versus deleting**: when you are finished, open the **⋯** menu and choose **Stop Codespace**.
  - Stopping lets it restart much faster next time.
  - Deleting means the next start takes another five or so minutes.
- ⚠️ **Deleting a Codespace erases everything you wrote in it.** Treat the Codespace as a playground. If you want to keep code you wrote, copy it somewhere else, for example into your own notes. A fresh Codespace resets to the repository's original contents. Daniel will save the code from this session into the repository so it is there on a fresh start, and you can read it on GitHub without launching a Codespace at all.
- **Numbering files**: Daniel names in-class code files with a leading number so they sort to the top of the file list.

### 2. GitHub Copilot, the coding agent

- **What it is**: an AI chat panel on the right-hand side of the Codespace, running an OpenAI model.
  - GitHub gives monthly free credits. Daniel believed the free tier is about 1,500 requests a month, which is plenty for course work.
  - Students or people with a university affiliation may get more credits through the GitHub Student Developer Pack.
- **How it differs from web ChatGPT**: it is an *agentic* coding tool.
  - It reads your code, and potentially your data.
  - It edits your files directly, asking permission ("can I make this change?") and then asking whether to keep the change.
- **Work in small steps**: ask one question at a time, such as "average rank per week" and then "plot that as a line". It is easier to check each piece that way.
- **Always check what it wrote.** In class it grouped by the wrong variables, and Daniel had to correct the code by hand (see *What went wrong live*).
- ⚠️ **Privacy warning**: because the agent reads your code and data, be careful with any data about people that could identify individuals. The course repository is public. **Real patient data never goes into it, or into a Codespace launched from it.**
- **Vocabulary helps prompting**: words like *tidy*, *pivot longer*, *pivot wider*, *separate*, and *group by / summarize* let you tell the AI precisely what you want.

### 3. Recap from last week: transactional versus analytics servers

- **Transactional server**: optimized for *collecting* data.
- **Analytics server**: where data goes so it can be *analyzed*. In practice, if a hospital system gives you a dataset or a database connection, it is most likely on the analytics server, and you won't notice the difference.
- **Roll-ups and drill-downs**: these are grouping operations. In code they are `group_by()` followed by `summarize()`, which is very similar to what you may already do in Excel.

### 4. What "tidy data" means

- **Source**: Hadley Wickham, *Tidy Data* (2014). The PDF is in the repository's `readings` folder. Wickham is a founder of the R `tidyverse` tools for cleaning data.
- **Why rows and columns need a definition**: the paper's first two tables show the same treatment results (people × treatment A/B) laid out one way and then transposed.
  - Both are "rows and columns", so "a row runs horizontally" is not enough of a definition.
  - The tidy version (table 3) has columns `name`, `treatment` and `result`.
- **The rules of a tidy dataset**:
  1. **Each variable forms a column.** Treatment A and treatment B are values of one variable, `treatment`, not two variables.
  2. **Each observation forms a row.** An observation is one unit of what you are measuring.
  3. **Each cell holds one value.** This is the more modern rule Daniel emphasized. The paper's original third rule (also in the class script's comments) is *each type of observational unit forms a table*, which leads into databases, splitting tables, and joins.
- **Colour is information hiding in a cell.** Shading a cell red or green to mean "bad" or "good" puts two things in one cell. That is fine for eyeballing a spreadsheet, and Excel quickly turns into a dashboard that way. But colour does not exist once the data is loaded into software. Put the flag in its own column, for example `good`/`bad`.
- **Tidy is often less readable and less space-efficient**, and that is acceptable.
  - Wide tables are better for humans and for reports.
  - Tidy tables are what plotting and model-fitting need.
  - You can always pivot a tidy dataset back into a report layout, so keep a tidy version as your analysis-ready copy.
- **The common problems**: the paper lists five ways data gets messy. Daniel focused on the three he said cover almost every problem you will meet. The remaining two concern splitting and joining tables. A messy dataset may have one of these problems or several. Fix them one at a time, easiest first.

| Problem | How to spot it | Fix |
|---|---|---|
| Column headers are values, not variable names | Many column names follow a pattern (income brackets, `wk1`…`wk76`, dates) | `pivot_longer()` |
| Multiple variables stored in one column | One value encodes two things (`m014` = male + age 0–14; `Cases_Guinea` = count type + country) | `separate()` |
| Variables stored in both rows and columns | A summary of the value column is nonsense because it mixes different measures (min and max temperature, cases and deaths) | `pivot_wider()` |

### 5. Problem 1: Column headers are values → `pivot_longer()`

- **Pew example**: a Pew Research Center survey of religion by household income. Each row is a religion, and the columns are income brackets (`<$10k`, `$10-20k`, …, `Don't know/refused`) containing counts.
  - This is a typical frequency table and is fine for manual entry from a report.
  - The bracket columns follow a pattern. They are values of a variable that should be called *income*.
- **`pivot_longer()`** moves those columns down into rows: more rows, fewer columns, hence "longer".
  - The paper calls this *melting*.
  - The result for Pew has columns `religion`, `income` and `frequency`. It goes from 18 rows × 11 columns to 180 rows × 3 columns.
- **Its arguments**:
  - `cols`: which columns to pivot. `-religion` means "everything except `religion`". You could also list the columns, or use a helper such as `starts_with("wk")`.
  - `names_to`: the name of the new column that holds the old column headers.
  - `values_to`: the name of the new column that holds the cell values.
  - `names_prefix`: text to strip from the old headers, for example remove `wk` and keep the number.
  - `names_transform`: convert the new names column to another type, for example `as.integer`.
  - `values_drop_na = TRUE`: drop rows whose value is missing.
  - If you omit `names_to`, the new column is called `name` by default (this is what happened in the Ebola example).
- **Billboard example**: Billboard Hot 100 songs from the year 2000. Each row is a song (`artist`, `track`, `time`, `date.entered`), and weekly ranks sit in `wk1` to `wk76`.
  - After pivoting, there is one row per song per week it was on the chart. Weeks with no ranking are dropped.
- **Why this matters in practice (Daniel's NHS COVID story)**: as Daniel described it, a daily-updated COVID spreadsheet added a new *column* each day until Excel ran out of columns. The modelling silently broke until someone noticed.
  - Rows are easy to add; columns run out.
  - People tend to build datasets by adding columns, because that is easier to look at when curating by hand. Store new observations as rows.
- **`NA`**: R's placeholder for a missing value, shown in red uppercase in the console.
  - It is deliberately different from `0`, which is a real value.
  - It is also clearer than a blank cell, where you cannot tell what the blank means.

### 6. Grouped summaries: `group_by()` + `summarize()`

- **Summary function**: a calculation that takes many numbers and returns one, such as `sum()`, `mean()` (the average), or `max()`.
- **The pattern**: "for each X, give me a summary of Y."
  - "For each X" means `group_by(X)`.
  - "Give me a summary of Y" means `summarize(new_name = summary_function(Y))`.
  - You can compute several summaries at once.
- **Pew example**: "How many people were asked for each religion?"
  - In the wide table, you would have to add up each row.
  - In the tidy table, it is `group_by(religion)` then `summarize(count = sum(frequency))`.
- **Link to last week**: grouping by several variables builds the data cube used for drill-downs. This is only possible because the data is tidy.
- **Billboard example (written by Copilot)**: average rank per week across all songs, then plotted as a line.
  - The pattern changes after about 20 weeks. Daniel suggested this may be missing data, or simply that people stop listening to the same song.
  - `ggplot2` is next week's topic.

### 7. Problem 2: Multiple variables in one column → `separate()`

- **Tuberculosis example (from the paper)**: rows are country and year, and columns like `m014` mean *male, age 0–14*, through to female 65+ and female unknown.
  - The cell value 52 carries two facts: sex and age group.
  - You cannot `group_by()` sex, because sex is not a variable of its own.
  - **Fix order**: first `pivot_longer()`, then split the combined column. Here the split is by position: the first letter is sex, the rest is the age group.
- **Ebola example (used in code instead of TB)**: daily cumulative counts from the 2014 Ebola epidemic in West Africa, up to day 289 in this dataset.
  - Columns are `Date`, `Day`, and then `Cases_Guinea`, `Cases_Liberia`, `Cases_SierraLeone`, …, `Deaths_Mali`.
  - Each count therefore encodes *type* (cases or deaths) and *country*.
- **`separate()`** splits one column into several. Its arguments:
  - `col`: the column to split.
  - `into`: the names of the new columns.
  - `sep`: the separator to split on.
  - Here `name` is split on `"_"` into `type` and `country`.
- **Leave yourself breadcrumbs**: if you hand-curate data, use a deliberate separator such as an underscore, a dash, or a one-letter prefix between parts of a code. Even if you can't process it yet, you or someone else will be grateful later.
- **Why Daniel prefers R and the tidyverse**: the code reads like the English description of the problem. "Separate this column into type and country on the underscore."
- **Cumulative counts**: the ministries of health reported running totals. So the maximum count per country and type is the total.

### 8. Problem 3: Variables in rows and columns → `pivot_wider()`

- **Weather example (from the paper)**: rows are a station, year and month, with day columns `d1`…`d31`, plus an `element` column saying whether a row is `tmax` or `tmin`.
  - After pivoting the days longer, the table looks tidy, but the `value` column mixes minimum and maximum temperatures.
- **How to spot it**: ask whether a summary of the column makes sense.
  - The average of a mix of minimum and maximum temperatures is meaningless, even though the unit is the same (°C).
  - In census data the mixed values can even have different units (a count next to a dollar amount).
  - Another hint: you have to point all over the table just to explain what one number means.
- **Ebola again**: after `separate()`, `count` holds both cases and deaths. "Maximum count" across both is not something you would report. You want the maximum cases and the maximum deaths separately.
- **`pivot_wider()`** is the reverse of `pivot_longer()`. In Excel terms it is essentially a pivot table. Its arguments:
  - `names_from`: the column whose unique values become new column names (`type` → `Cases`, `Deaths`).
  - `values_from`: the column that fills those new columns (`count`).
- The resulting tidy Ebola table has one row per date and country, with `Cases` and `Deaths` columns. The original Ebola data had all three problems.

### 9. Problem 4 (in the class script): Multiple observational units in one table

- In tidy Billboard data, song facts (`year`, `artist`, `track`, `time`) repeat on every weekly-rank row.
- The script splits this into a `song` table with an `id` key and a `rank` table that refers back to it by `id`.
- This connects to the paper's "one observational unit per table" rule and to database joins. It was in the script but not run in class.

## Code from class

Everything below runs in R in the Codespace. The datasets sit at the top of the repository, so you can read them by filename alone.

### Loading the tidyverse and reading the Pew data

```r
library(tidyverse)          # loads dplyr, tidyr, readr, ggplot2, etc.

pew <- read_csv("pew.csv")  # save the dataset into a variable called pew
pew                         # print it to look at it
```

`read_csv()` reports how it read each column. This is worth reading every time:

```
Rows: 18 Columns: 11
── Column specification ──────────────────────
Delimiter: ","
chr  (1): religion
dbl (10): <$10k, $10-20k, $20-30k, $30-40k, $40-50k, $50-75k, $75-100k, $100...
```

### Tidying Pew with `pivot_longer()` and summarizing it

```r
pew_tidy <- pew |>            # |> is the pipe: "take this, then..."
  pivot_longer(
    cols = -religion,         # pivot every column except religion
    names_to = "income",      # old column headers go into "income"
    values_to = "frequency"   # old cell values go into "frequency"
  )
pew_tidy

pew_tidy |>
  group_by(religion) |>                 # for each religion...
  summarize(count = sum(frequency))     # ...add up the frequencies
```

The shape changes from 18 rows × 11 columns to:

```
# A tibble: 180 × 3
   religion income             frequency
   <chr>    <chr>                  <dbl>
 1 Agnostic <$10k                     27
 2 Agnostic $10-20k                   34
 3 Agnostic $20-30k                   60
```

The summary has one row per religion. For example, `Agnostic` totals 826 and `Catholic` totals 8054.

### Tidying Billboard and plotting average rank (Copilot-assisted)

```r
billboard <- read_csv("billboard.csv")
billboard

billboard_tidy <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),                  # every column starting with "wk"
    names_to = "week",
    names_prefix = "wk",                       # strip "wk", keep the number
    names_transform = list(week = as.integer), # make week a whole number
    values_to = "rank",
    values_drop_na = TRUE                      # drop weeks the song was not on the chart
  )
billboard_tidy

# written by Copilot from the prompts "average ranking over each week
# across all the songs" and then "plot that result as a line"
billboard_tidy |>
  group_by(week) |>
  summarize(average_rank = mean(rank)) |>
  ggplot(aes(x = week, y = average_rank)) +
  geom_line()
```

`read_csv()` showed something worth noticing. The last weekly columns are all empty, so R guessed they were logical (`lgl`, true/false) rather than numbers:

```
Rows: 317 Columns: 81
chr   (2): artist, track
dbl  (66): year, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, wk11, wk...
lgl  (11): wk66, wk67, wk68, wk69, wk70, wk71, wk72, wk73, wk74, wk75, wk76
date  (1): date.entered
time  (1): time
```

After pivoting, the table is 5,307 rows × 7 columns, with integer `week` and `rank` columns.

### Tidying Ebola: `pivot_longer()`, then `separate()`

```r
ebola <- read_csv("ebola.csv")
ebola

ebola_long <- ebola |>
  pivot_longer(
    cols = -c(Date, Day),     # pivot everything except Date and Day
    values_to = "count",      # no names_to, so headers land in a column called "name"
    values_drop_na = TRUE
  )
ebola_long

ebola_long <- ebola_long |>
  separate(col = 'name',
    into = c("type", "country"),  # split the header into two variables
    sep = "_"                     # on the underscore
  )
ebola_long
```

Before and after `separate()`:

```
   Date       Day name               count
 1 1/5/2015   289 Cases_Guinea        2776
 2 1/5/2015   289 Cases_SierraLeone  10030
```

```
   Date       Day type   country     count
 1 1/5/2015   289 Cases  Guinea       2776
 2 1/5/2015   289 Cases  SierraLeone 10030
```

### Total cases and deaths per country

The counts are cumulative, so the maximum is the total:

```r
ebola_long |>
  group_by(country, type) |>
  summarize(max_count = max(count))
```

```
`summarise()` has regrouped the output.
ℹ Summaries were computed grouped by country and type.
ℹ Output is grouped by country.
```

This message is information, not an error. After grouping by two variables, the result stays grouped by the first one (`country`).

### Spreading cases and deaths into their own columns with `pivot_wider()`

```r
ebola_tidy <- ebola_long |>
  pivot_wider(
    names_from = type,     # "Cases" and "Deaths" become column names
    values_from = count    # filled from the count column
  )
ebola_tidy
```

```
# A tibble: 375 × 5
   Date         Day country     Cases Deaths
 1 1/5/2015     289 Guinea       2776   1786
 2 1/5/2015     289 SierraLeone 10030   2977
```

### Further steps in the saved script (not run in class)

The class script takes the examples further. Note that `Date` was read as text (`chr`, for example `"1/5/2015"`), and the script converts it into a real date with `mdy()` (month-day-year).

```r
# Billboard: add the calendar date for each week's rank
billboard_tidy <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    names_transform = list(week = as.integer),
    values_to = "rank",
    values_drop_na = TRUE
  ) |>
  mutate(date = date.entered + (week - 1) * 7) |>  # date entered + (week - 1) weeks
  arrange(artist, track, week) |>
  select(year, artist, track, time, week, rank, date)

# Ebola: tidy names and real dates
ebola_tidy <- ebola_long |>
  pivot_wider(
    names_from = type,
    values_from = count
  ) |>
  rename(date = Date, day = Day, cases = Cases, deaths = Deaths) |>
  mutate(date = mdy(date)) |>
  arrange(country, date)

# Weather: gather days into rows, then spread tmax/tmin into columns
weather <- read_csv("weather.csv")

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

# Billboard: split song facts and weekly ranks into two tables sharing an id key
song <- billboard_tidy |>
  distinct(artist, track, year, time) |>
  mutate(id = row_number(), .before = 1)

rank <- billboard_tidy |>
  left_join(song, by = c("artist", "track", "year", "time")) |>
  select(id, week, date, rank)
```

### What went wrong live

- **Copilot grouped by the wrong variables**: asked for the maximum value for each type and country, Copilot grouped by day and country, and put the code in the wrong place. Daniel rewrote it by hand as `group_by(country, type) |> summarize(max_count = max(count))`, which is what the console shows running. Copilot also kept making changes after that, and he had to tell it to stop and skip. The lesson: read and check what the agent writes before accepting it.
- **Misremembered argument name**: when writing `pivot_wider()`, Daniel briefly doubted the argument name before settling on `names_from = type`. The arguments are `names_from` and `values_from`, mirroring `names_to` and `values_to` in `pivot_longer()`.
- **Mistyped `library`**: the first line was mistyped and corrected to `library(tidyverse)`. If R says it cannot find a function, check your spelling first.
- **Garbled echo when pasting a large block**: pasting the whole script into the R console at once made the console's echo of the code look scrambled. The code still ran, and every result printed normally afterwards. Running a selection from the editor with Ctrl+Enter / Cmd+Enter avoids this.

## Questions

- **Q:** Is the initial data provided for the Module 1 assignment essentially already a tidy dataset?
  **A:** Yes. It has already been cleaned for you. Today's material is for people who want to bring their own dataset and need to get it into that analysis-ready form.

## Assignments

- [ ] Before next week's office hour: create a GitHub.com account if you don't have one, launch a Codespace from the course repository, and work through this session's code while rewatching the recording. The first 15 minutes cover the setup.
- [ ] Report any problems with the Codespace or Copilot at next week's office hour.

---

- prompt: prompt-notes.md @ 9540d32
- prompt-hash: c082a6eab694
- model: claude-opus-5-5 (requested: opus)
- backend: claude
- inputs: transcript-plaud.md, history.R, R-console.txt
- generated: 2026-10-30
