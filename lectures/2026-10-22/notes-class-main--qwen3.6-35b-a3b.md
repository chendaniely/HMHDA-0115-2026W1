# Tidy Data Principles and Reshaping with Tidyverse

Instructor: Daniel Chen

## Summary

This session introduced the formal principles of tidy data as defined by Hadley Wickham's 2014 paper, bridging the gap between messy real-world clinical/data collection formats and the structured formats required for statistical computing. The instructor demonstrated how raw data—often optimized for manual entry, Excel reporting, or transactional logging—usually violates tidy data rules by packing multiple variables into single columns, using measurement values as column headers, or mixing data types across rows and columns.

Students worked through three primary data cleaning transformations using the `tidyverse` in GitHub Codespaces: `pivot_longer()` to convert header values into observation rows, `separate()` to split packed variable names into distinct columns, and `pivot_wider()` to spread mixed measurement types back into separate columns. The session also covered setting up the browser-based `Codespaces` environment, leveraging the `Copilot` agent for code generation, and handling common `dplyr` grouping behaviors when summarizing reshaped datasets.

## Knowledge Points

### 1. Tidy Data Definition

- **Tidy Data Rules**: A dataset is considered tidy when it strictly follows three principles:
  - Each variable forms a column.
  - Each observation forms a row.
  - Each cell contains only one unit of measurement.
- **Why it matters**: Raw clinical or survey data is frequently collected in a "wide" or dashboard-friendly format to save space or match physical reports. While human-readable, these formats prevent straightforward computation, grouping, and visualization. Tidy data ensures that every row represents a single observational unit and every column represents a measurable attribute, making aggregate functions and modeling mathematically sound.

### 2. Problem 1: Column Headers Are Values, Not Variable Names

- **Identification**: Column names follow a clear pattern representing levels of a single variable (e.g., income brackets like `$10-20k` or survey weeks like `wk1` through `wk76`).
- **Transformation**: Use `pivot_longer()` to gather these columns into a single column. The original column names become values in a new variable column, and the cell contents become values in a second column (e.g., `frequency` or `rank`). This increases the number of rows and aligns the data with tidy principles.

### 3. Problem 2: Multiple Variables in One Column

- **Identification**: A single column name or cell contains information about two distinct variables. Common in public health datasets where headers combine metrics and locations (e.g., `Cases_Guinea` mixes the measurement type `Cases` and the geographic unit `Guinea`).
- **Transformation**: Apply `pivot_longer()` first to consolidate the mangled headers into a single column. Then, use `separate()` to split that column into two distinct variables using a delimiter (usually `_`). This cleanly isolates the metric type and the geographic unit for independent analysis.

### 4. Problem 3: Variables in Both Rows and Columns

- **Identification**: After tidying with `pivot_longer()`, a single value column contains mixed measurement types (e.g., `tmax` and `tmin` temperatures, or cases and deaths). Calculating a summary statistic like an average across this column produces mathematically meaningless results because the units or definitions differ.
- **Transformation**: Use `pivot_wider()` to invert the long format. Specify which column holds the unique values to become new headers (`names_from`) and which column holds the corresponding data points to populate those new columns (`values_from`). This separates the mixed measurements into distinct, analyzable columns.

### 5. Development Environment: GitHub Codespaces & Copilot

- **Codespaces Setup**: Requires a free `GitHub.com` account. Load the course repository, click the `Code` button, select `Codespaces`, and click `Create Codespace`. Initialization takes approximately 5 minutes. Always click `Stop Codespace` (three-dot menu) when finished to preserve free monthly credits and ensure faster load times for the next session.
- **Copilot Agent**: The browser environment includes an AI coding agent capable of reading your active codebase and data structure. You can prompt it to write analysis code (e.g., calculating averages, generating plots), and it will directly modify your script. It is highly effective for learning syntax but requires careful review of the generated logic.

## Code from class

### Tidying Religion vs. Income Brackets (`pivot_longer`)

```r
pew <- read_csv("pew.csv")
pew_tidy <- pew |>
  pivot_longer(
    cols = -religion,
    names_to = "income",
    values_to = "frequency"
  )
```

The income brackets are stored as column headers in the raw CSV, but they represent values of a single `income` variable. `pivot_longer()` targets all columns except `religion`, turning the bracket names into the `income` column and the numeric counts into the `frequency` column.

### Tidying Billboard Top-100 Rankings (`pivot_longer` with prefix stripping)

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
```

The original dataset uses columns `wk1` through `wk76` to track weekly chart positions. `starts_with("wk")` isolates these time-point columns. `names_prefix = "wk"` strips the text from the headers, and `as.integer` converts the week identifiers to numeric values. `values_drop_na = TRUE` automatically removes rows representing weeks where the song was not charted.

### Tidying Ebola Case Counts (`pivot_longer` then `separate`)

```r
ebola_long <- ebola |>
  pivot_longer(
    cols = -c(Date, Day),
    values_to = "count",
    values_drop_na = TRUE
  )
ebola_long <- ebola_long |>
  separate(col = "name",
    into = c("type", "country"),
    sep = "_"
  )
```

Headers like `Cases_Guinea` and `Deaths_SierraLeone` pack two variables together. First, `pivot_longer()` gathers these headers into a single `name` column alongside the case counts. Then, `separate()` splits the `name` column at the underscore, creating distinct `type` and `country` columns that can be independently grouped.

### Tidying Weather Temperatures (`pivot_longer` then `pivot_wider`)

```r
weather_tidy <- weather |>
  pivot_longer(
    cols = starts_with("d"),
    names_to = "day",
    names_prefix = "d",
    names_transform = list(day = as.integer),
    values_to = "temp",
    values_drop_na = TRUE
  ) |>
  pivot_wider(
    names_from = element,
    values_from = temp
  )
```

The intermediate long format contains a `temp` column mixing `tmax` and `tmin` readings. Calculating an average across this column is invalid. `pivot_wider()` takes the unique values in the `element` column (`tmax`, `tmin`) and spreads them into new columns, populating them with the corresponding temperature values from the `temp` column.

## What went wrong live

- **Grouping/Summary warning**: When running `ebola_long |> group_by(country, type) |> summarize(max_count = max(count))`, the console printed `summarise()` has regrouped the output. This occurs in `dplyr` when a summarization operation is applied to data that already carries a grouping structure, or when the grouping variables shift unexpectedly during the pipe. The instructor recalibrated the group arguments on the fly and noted that the warning can be silenced by using `.by = c(country, type)` directly inside `summarize()`.

## Questions

- **Q:** Is the initial dataset provided for the Module 1 assignment already tidy?
  **A:** Yes, the starter data for the assignment has already been cleaned and formatted into a tidy structure. The concepts taught in these office hours are primarily intended for students who wish to import and clean their own raw or messy datasets for the course.

---

- prompt: prompt-notes.md @ 9540d32
- prompt-hash: c082a6eab694
- model: qwen3.6-35b-a3b (requested: qwen3.6-35b-a3b)
- backend: local (llama-swap)
- inputs: transcript-plaud.md, history.R, R-console.txt
- generated: 2026-10-30
