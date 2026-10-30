# Tidy Data: Definition, Problems, and the pivot_longer / pivot_wider / separate Toolkit

Date: 2026-10-22

Instructor: Daniel Chen

## Summary

This session introduced the concept of **tidy (clean) data** using Hadley Wickham's 2014 paper as a foundation. The instructor explained that real-world data — especially data collected in clinical or administrative settings — rarely arrives in a shape that analytics tools expect. He defined what makes a dataset tidy, walked through the three most common ways data get "messed up," and demonstrated live code transformations using the **tidyverse** in R to fix each problem.

The session also served as the first introduction to **GitHub Codespaces** — a browser-based coding environment that requires no local installation. Students were shown how to create a Codespace from the course repository, how to use the built-in GitHub Copilot coding agent, and how to manage their workspace (stopping vs. deleting a Codespace).

By the end, students could identify three classes of messy data (column headers as values, cells containing multiple units, and mixed units within a single column), apply `pivot_longer`, `pivot_wider`, and `separate` to clean them, and understand why tidy data is the prerequisite for grouping, summarizing, and visualizing with tidyverse tools.

## Knowledge Points

### 1. What is tidy data?

- **Tidy data definition (three rules):**
  - Each **variable** forms a **column**.
  - Each **observation** forms a **row**.
  - Each **cell** contains only **one unit of measurement**.
- A tidy dataset is not always the pretiest or most compact layout for humans — but it is the shape that analytics software (R, Python, BI tools) expects for analysis, modeling, and visualization.
- Once data is tidy, you can always reshape it (pivot back to wide, pivot to long, etc.). The key is to start from a clean base.

### 2. Three common ways data get messed up

1. **Column headers are values, not variable names.** Column names follow a pattern (e.g., `25000`, `30000`, `WK1`, `WK2`) that should be a column of values instead.
2. **Several observations are mixed into one cell.** A single cell may hold two pieces of information — e.g., "M0-14" encodes both sex and age group.
3. **Several types of observations are mixed into one column.** A single column (e.g., `value`) may contain different kinds of measurements (e.g., minimum temperature and maximum temperature), so computing a summary statistic on that column is meaningless.

These three cover almost every messy-data problem you will encounter.

### 3. Diagnosing the problems visually

- Look at your **column names**. If many follow a repeating pattern (income ranges, week numbers, country prefixes), that is your first clue: `pivot_longer` is needed.
- Look at **individual cells**. If a cell contains a number plus extra text (like "M52" for male, age 52), that is your second clue: `separate` is needed after pivoting long.
- Look at a **single column's values**. If the same column holds two kinds of measurements (cases AND deaths, min AND max temperature), that is your third clue: `pivot_wider` is needed.

### 4. The tidyverse reshaping functions

- **`pivot_longer()`** — turns wide data (many columns → few columns) into long data (few columns → many rows). You specify which columns to pivot, what the new "name" column should be called, and what the new "value" column should be called.
  - Common helpers: `-column` (everything except), `starts_with("wk")`, `all_of(c("x","y"))`.
  - Optional: `names_prefix` to strip a prefix, `names_transform` to coerce types, `values_drop_na` to drop missing rows.
- **`pivot_wider()`** — the inverse: turns long data into wide data. You specify which column's unique values become new column names (`names_from`) and which column fills those cells (`values_from`). This is the programmatic equivalent of an Excel pivot table.
- **`separate()`** — splits one column into multiple columns at a delimiter (e.g., `_`). You specify the source column, the target column names, and the separator character.

### 5. From tidy data to group-by summaries

- Once data is tidy, you can use `group_by()` followed by `summarize()` to compute summary statistics (sum, mean, max, etc.) for each group.
- A **summary function** takes many numbers as input and returns one number as output (e.g., `sum()`, `mean()`, `max()`).
- Grouping by multiple variables creates the equivalent of a multi-dimensional "data cube."
- This pattern is foundational for both analysis and later, visualization.

### 6. GitHub Codespaces workflow

- **To start:** open the course repository on GitHub → click the green **Code** button → select **Codespaces** → click **Create codespace** (or the **+** button).
- Loading takes ~5 minutes. While loading, you can follow the transcript.
- **To stop (save credits):** click the **⋯** (three dots) → **Stop Codespace**. Stopping preserves your environment for quick restart. Deleting resets it.
- **Free tier:** 1,500 GitHub Copilot requests per month on the free plan. Student packs may offer more.
- **Code persistence:** anything you type in a Codespace is lost if you delete it. The instructor saved today's examples in the repository as a fallback.
- **Using Copilot:** the agent on the right side can read your code and data, suggest transformations, and apply them — a real-time coding assistant, not just a chatbot.

### 7. Missing data in R

- R represents missing values with `NA` (uppercase, displayed in red by default in the console).
- `NA` means "unknown or not applicable." A blank cell is ambiguous; R treats it as `NA`.
- Use `values_drop_na = TRUE` in `pivot_longer()` to automatically remove rows where the pivoted value is missing.

## Code from class

### Loading the tidyverse and reading data

```r
library(tidyverse)

pew <- read_csv("pew.csv")
pew

billboard <- read_csv("billboard.csv")
billboard

ebola <- read_csv("ebola.csv")
ebola
```

This loads the three example datasets that correspond to the three messy-data examples in Wickham's paper. `read_csv()` returns a tibble — a modern data frame with nicer printing.

### Tidying the Pew dataset (pivot_longer)

The Pew data has income ranges (`25000`, `30000`, etc.) as column names. These are values, not variable names.

```r
pew_tidy <- pew |>
  pivot_longer(
    cols = -religion,
    names_to = "income",
    values_to = "frequency"
  )
pew_tidy
```

- `cols = -religion` → pivot everything except the `religion` column.
- `names_to = "income"` → the old column names become values in a new column called `income`.
- `values_to = "frequency"` → the cell values go into a column called `frequency`.

Result: 18 rows → 180 rows, but now fully tidy. Each observation (religion + income group) is one row.

**Summarizing tidy data:**

```r
pew_tidy |>
  group_by(religion) |>
  summarize(count = sum(frequency))
```

This answers: "How many people were surveyed for each religion?" The `summarize()` function takes grouped data and returns one row per group.

### Tidying the Billboard dataset (pivot_longer with type conversion)

The Billboard data has 66 week columns (`WK1` through `WK75`). Each week a song appeared on the chart is a new column — another case of column headers being values.

```r
billboard_tidy <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),
    names_to = "week",
    names_prefix = "wk",
    names_transform = list(week = as.integer),
    values_to = "rank",
    values_drop_na = TRUE
  )
billboard_tidy
```

- `cols = starts_with("wk")` → select all columns starting with "wk".
- `names_prefix = "wk"` → strip the "wk" prefix from the column names.
- `names_transform = list(week = as.integer)` → convert week names to integers (e.g., "1" → 1).
- `values_drop_na = TRUE` → drop weeks the song never appeared on the chart.

Result: 317 rows → 5,307 rows. Each row is one song at one week of charting.

**Exploring with Copilot + visualization:**

```r
billboard_tidy |>
  group_by(week) |>
  summarize(average_rank = mean(rank)) |>
  ggplot(aes(x = week, y = average_rank)) +
  geom_line()
```

This computes the average ranking per week across all songs and plots it as a line chart. The expected pattern: rankings decrease over time as songs drop off the charts.

### Tidying the Ebola dataset (pivot_longer → separate → pivot_wider)

The Ebola data has a dual problem: column names encode both the **type** of count (Cases/Deaths) and the **country** (Guinea/Sierra Leone), and the cell values themselves are counts.

**Step 1 — pivot_longer:**

```r
ebola_long <- ebola |>
  pivot_longer(
    cols = -c(Date, Day),
    values_to = "count",
    values_drop_na = TRUE
  )
ebola_long
```

This produces columns: `Date`, `Day`, `name` (e.g., "Cases_Guinea"), and `count`.

**Step 2 — separate the combined column names:**

```r
ebola_long <- ebola_long |>
  separate(col = "name",
    into = c("type", "country"),
    sep = "_"
  )
ebola_long
```

The underscore in "Cases_Guinea" is a **strategic marker** — a breadcrumb left by the data collector that makes splitting straightforward. The instructor recommends using underscores or dashes intentionally when hand-curating data, so it can be split later.

Result: `name` column is replaced by `type` (Cases/Deaths) and `country` (Guinea/Sierra Leone).

**Step 3 — summarize:**

```r
ebola_long |>
  group_by(country, type) |>
  summarize(max_count = max(count))
```

This answers: "What was the maximum (i.e., final cumulative) case count and death count for each country?"

**Step 4 — pivot_wider (the inverse of step 1):**

```r
ebola_tidy <- ebola_long |>
  pivot_wider(
    names_from = type,
    values_from = count
  )
ebola_tidy
```

Now each row has a `Date`, `Day`, `country`, `Cases`, and `Deaths` column. You can compute differences, rates, or visualize cases vs. deaths independently.

### What went wrong live

- **Copilot mis-grouped the Ebola summary.** When asking Copilot to compute the max count per country and type, it grouped by `day` and `country` instead. The instructor caught it mid-execution, stopped the agent, and corrected the `group_by()` call to `group_by(country, type)` before re-running. Lesson: always review Copilot's suggestions — especially the `group_by` clauses — before trusting the output.
- **Desktop notification "dings."** The instructor's computer was making sounds when code finished running. He did not know how to mute them during the session.

## Questions

- **Q:** Is the initial dataset provided for the Module 1 assignment already a tidy dataset?
  **A:** The instructor confirmed that the provided assignment data has already been cleaned. The tidy data lecture was mainly for students who want to bring and clean their own datasets.

## Assignments

- [ ] Module 1 assignment — initial dataset (already tidied by instructor; see Canvas for details)

---

- prompt: prompt-notes.md @ c082a6eab694
- prompt-hash: c082a6eab694
- model: qwen3.6-35b-a3b (requested: qwen3.6-35b-a3b)
- backend: opencode
- inputs: transcript-plaud.md, history.R, R-console.txt
- generated: 2026-10-23
