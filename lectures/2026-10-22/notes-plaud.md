> Date Time: 2026-10-22 17:59:24
>
> Location: Location
>
> Instructor: Daniel Chen

## Summary

On October 22, 2026, Daniel Chen delivered a comprehensive lecture on the principles and practical execution of data cleaning using Hadley Wickham’s foundational "Tidy Data" (2014) framework and the Tidyverse in R. The session introduced students to a browser-based computing setup via GitHub Codespaces paired with an integrated AI coding assistant, eliminating the need for local installations. The lecture systematically walked through core tidy data transformations—including `pivot_longer`, `separate`, and `pivot_wider`—using real-world datasets such as the Pew Research Center survey, Billboard weekly rankings, a WHO tuberculosis dataset, and the 2014 Ebola outbreak data. Chen addressed the problems with wide report-style spreadsheets, cell contamination, handling missing values (`NA`), avoiding invalid aggregations on mixed metrics, and the scalability benefits of adding rows instead of columns. Course logistics, assignment guidelines, and an upcoming focus on data visualization with `ggplot2` were also outlined.

## Knowledge Points

### 1. Cloud-Based Coding Environment and Agentic Workflow

- **GitHub Codespaces Setup**
  - Enables execution of R and analytical code entirely in the browser without local software installation.
  - Materials, lecture notes, and datasets are hosted in a centralized GitHub repository accessible on any device.
  - To launch: log into GitHub.com, navigate to the repository, click the green "Code" button, select "Codespaces," and click "Create Codespace" (or the `+` button).
  - Initial container provisioning takes approximately 5 minutes. Stopping the container via the three-dots menu preserves the state and speeds up future launches, whereas deleting the container resets the environment and removes unsaved local work.
- **AI Coding Agent Integration**
  - GitHub Codespaces provides monthly free credits (1,500 requests/month on the free tier; additional perks available via GitHub Student Pack) and includes an LLM-based coding agent interface.
  - Agents can directly inspect and edit code files, offer context-aware refactoring, and provide stepwise guidance.
  - **Data Privacy Warning:** Be cautious with Personally Identifiable Information (PII), as agentic tools process underlying data context.
- **R Environment Operations**
  - Start the interactive REPL in the terminal by typing `R` and pressing Enter.
  - Run selected lines of code using `Control + Enter` (Windows) or `Command + Enter` (Mac).
  - Instructor code is saved directly to the repository so it loads automatically in new sessions.

### 2. Principles of Tidy Data

- **Theoretical Foundations (Hadley Wickham, 2014)**
  - Tidy data structures formalize datasets for statistical modeling and visualization, distinguishing analysis-ready formats from transactional or data-entry layouts.
  - **Rule 1 (Columns):** Each variable forms its own column.
  - **Rule 2 (Rows):** Each observation forms a row.
  - **Rule 3 (Cells):** Each cell contains a single value/measurement.
- **Spreadsheet Pitfalls and Data Contamination**
  - Data collection often favors visual layouts (wide tables) or embeds metadata using cell formatting (e.g., color highlights). Analytic software cannot parse cell colors upon import; all status flags or metadata must exist as explicit column values.
  - Patterned column headers indicating values (e.g., income brackets, age-sex categories, or weeks) violate tidy principles.

### 3. Data Transformation & Reshaping Techniques (Tidyverse)

- **`pivot_longer` (Melting/Unpivoting)**
  - **Purpose:** Converts wide datasets with patterned column headers into a tall/long tidy format, transforming headers into a new variable column and cell contents into a value column.
  - **Pew Dataset Example:** Income ranges stored as headers (`<$10k`, `$10-20k`, etc.) across religions are pivoted to create an `income` column and a `frequency` column while preserving `religion` (`select = -religion`).
  - **Billboard Dataset Example:** Weekly columns (`WK1` through `WK75`) are pivoted into `week` and `rank` columns. Dropping `NA` values leaves only observed ranking weeks.
- **`separate`**
  - **Purpose:** Splits composite values in a single column into multiple distinct variable columns based on a delimiter (e.g., `_` or `-`).
  - **Tuberculosis & Ebola Examples:** Headers combining sex and age (`M014`, `F65`) or metric and country (`cases_Guinea`, `deaths_Sierra Leone`) are pivoted longer and then split via `separate` into distinct columns (e.g., `sex` and `age_group`, or `type` and `country`).
  - **Data Curation Tip:** When manually preparing datasets, embed clear delimiters (underscores/dashes) in header names to facilitate automated splitting.
- **`pivot_wider`**
  - **Purpose:** Spreads values from a single column across multiple columns based on a key identifier.
  - **Use Case:** Applied when a single column contains heterogeneous measurement types (e.g., mixing counts of `cases` and `deaths`, or `min_temp` and `max_temp`). Mixing disparate metrics in one column leads to invalid aggregations; pivoting wider restores each distinct measurement to its own column.
  - **Ebola Dataset Example:** Pivoting with `names_from = type` and `values_from = count` produces separate, analyzable `cases` and `deaths` columns for each date and country.

### 4. Data Aggregation, Scalability, and Analysis

- **Summary Operations (`group_by` and `summarize`)**
  - Summary functions reduce vectors of values to a single statistic (e.g., `sum()`, `mean()`, `max()`).
  - Example: Grouping tidy Pew data by `religion` and summarizing total `frequency` with `sum()` counts respondents per religion.
  - Example: Grouping Billboard data by `week` to track average song ranking decay over time.
  - Ensuring data is properly separated into distinct variables prevents invalid operations across mixed measurement units.
- **Scalability: Rows vs. Columns**
  - Data models scale efficiently across rows rather than columns. Adding daily or category columns causes systems to hit column boundaries (e.g., historical UK NHS COVID spreadsheet failures where Excel's column limits silently truncated data).

### 5. Course Logistics and Next Steps

- **Upcoming Topics:** The next lecture (2026-10-29) will cover data visualization using `ggplot2`.
- **Resources:** Lecture recordings, passwords, AI summaries, and updated repository documentation with screenshots will be posted to Canvas.
- **Module 1 Notes:** Assignment data for Module 1 is pre-tidied; lecture techniques apply directly when importing raw external datasets.

## Questions

- [Insert Question/Confusion]

## Assignments

- [ ] 1. Create a GitHub.com account (if needed) and launch the course repository via GitHub Codespaces.
- [ ] 2. Review Hadley Wickham’s "Tidy Data" (2014) paper in the `readings` folder of the repository.
- [ ] 3. Load `Pew.csv` in R using `tidyverse`, apply `pivot_longer` to produce `income` and `frequency` columns, and use `group_by(religion)` with `summarize(sum(frequency))` to calculate counts per religion.
- [ ] 4. Load the `Billboard` dataset, pivot columns starting with `WK` into `week` and `rank`, strip non-numeric prefixes, remove `NA` entries, and compute average weekly rankings.
- [ ] 5. Clean the 2014 Ebola dataset: pivot longer (excluding `date` and `day`), use `separate` to extract `type` and `country`, and apply `pivot_wider` to separate `cases` and `deaths` columns before computing maximum counts per country.
- [ ] 6. Experiment with the GitHub Codespaces AI coding assistant using incremental prompts, and practice generating a basic time-series line plot using `ggplot2`.
- [ ] 7. Save and back up any exploratory code locally from Codespaces to avoid data loss upon container deletion.
