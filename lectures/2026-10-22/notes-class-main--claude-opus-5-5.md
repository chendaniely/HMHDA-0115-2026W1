# Tidy Data in R: Pivoting, Separating and Summarising Messy Datasets

Instructor: Daniel Chen

## Summary

This office-hours session was the first in a series that moves the course from point-and-click tools to working code-first. The instructor introduced a new course repository on GitHub. It holds the datasets, readings, and from now on the recordings, transcripts and summaries of these sessions. He showed how to open it in a GitHub Codespace, which is a full R coding environment that runs in the browser, so nothing needs to be installed on your own computer. The Codespace also includes GitHub Copilot, an AI coding agent that can read your code and data and edit your files for you. He followed up briefly on last week's question about servers: in practice, a dataset you receive from a hospital system almost certainly comes from the analytics server, not the transactional one.

The main topic was Hadley Wickham's 2014 paper *Tidy Data*, found in the repository's readings folder. The paper defines a "clean" or tidy dataset with three rules: each variable is a column, each observation is a row, and each cell holds one piece of information. It then names the common ways real data breaks those rules. The instructor worked through each problem in R using the `tidyverse`:

- **Column headers that are really values**: Pew religion-by-income survey and Billboard chart data. Fixed with `pivot_longer()`.
- **One column that packs two variables together**: Ebola case and death counts by country. Fixed with `separate()`.
- **One column that mixes different measurements**: Ebola cases and deaths in one `count` column. Fixed with `pivot_wider()`.

Once the data was tidy, he showed how `group_by()` plus `summarize()` produces the roll-ups and drill-downs discussed last week.

The practical takeaway has three parts. First, tidy data is often *less* pleasant for a human to read than a report-style table, but it is the shape that plotting, modelling and aggregation software expects. You can always pivot it back into a report layout later. Second, the main skill is diagnosis: spot a pattern in the column names, a cell that holds two facts, or a column whose average would be meaningless. Third, knowing words like "tidy", "pivot longer/wider", "separate" and "group by / summarize" makes you much better at prompting an AI agent. The live demo showed Copilot getting a grouping wrong, and the instructor had to correct it.

## Knowledge Points

### 1. Getting into the coding environment (GitHub Codespaces)

- **GitHub**: a website for sharing code. The course repository is fully public. You can read everything in it, including on your phone, **without** an account. You **do** need a free GitHub account to run code in it.
- **Starting a Codespace**:
  1. Open the course repository (the link will be posted on Canvas).
  2. Click the green **Code** button.
  3. Select the **Codespaces** tab at the top.
  4. Click **Create Codespace**, or the **+** button if you already have one.
  5. The first launch takes about five minutes.
- **Starting R**: when the environment is ready, type a capital `R` in the terminal panel and press Enter. You can then:
  - copy and paste code into the console, or
  - select code in a file and press Ctrl+Enter (Cmd+Enter on a Mac) to send it to R. The instructor said "I believe" about this shortcut, so check it yourself.
- **Stopping a Codespace**: when you are done, click the three-dots menu and choose **Stop Codespace**. Stopping (rather than deleting) means the next start-up is much faster. Deleting it means another five-or-so-minute build next time.
- ⚠️ **Your work is not saved if the Codespace is deleted.** Deleting the container wipes any code you wrote. A fresh Codespace resets to the original course files. Treat it as a playground, and copy anything you want to keep into your own notes. The instructor's code from class will be added to the repository, so a fresh Codespace (or simply browsing the repo) will include it.
- **File naming**: the instructor names class files with a leading number ("one dash tidy") so they sort to the top of the file list.
- **Repository contents**:
  - CSV and TSV datasets sit at the top level, so they can be read without a folder path.
  - The *Tidy Data* PDF is in the `readings` folder.
  - Navigation instructions, with screenshots still being added, are in the repository's front page.

### 2. GitHub Copilot as a coding agent

- **What it is**: an AI chat panel on the right-hand side of the Codespace, which loaded one of the OpenAI models in class. GitHub gives a free monthly allowance. The instructor believed the free tier is about 1,500 requests per month, which is plenty for course work. Students with a university affiliation can apply for the GitHub Student Developer Pack for more credits.
- **How it differs from web ChatGPT**: it is *agentic*. It reads your code and potentially your data, proposes edits, and asks permission to change your files ("keep this change?"). That is what "agentic coding" means.
- ⚠️ **Privacy warning**: because the agent can read your data, be careful with any data about people that could identify individuals. The course repository is public. **Never put real patient data into the repository or a Codespace.**
- **Work in small steps**: ask one question at a time, for example "average rank per week", then "plot that as a line". You get code one piece at a time and can check each step.
- **Check its work**: in class Copilot grouped the Ebola data by the wrong variables and kept acting after the instructor wanted it to stop. You still need to understand the code well enough to catch mistakes.
- **Vocabulary is leverage**: knowing the terms "tidy", "pivot longer", "pivot wider", "separate" and "group by / summarize" lets you tell the agent exactly what you want.

### 3. Follow-up: analytics vs transactional servers

- **Transactional server**: optimised for *collecting* data, the way data is entered day to day.
- **Analytics server**: where data goes so you can *do things* with it.
- **In practice**: if you are given a dataset or database connection from a hospital system, it is almost certainly on the analytics server. You will not notice a difference.
- Data is usually stored in whatever shape made collection easy. Getting it into a shape that suits analysis is the subject of this session.

### 4. What tidy (clean) data means

- **Source**: Hadley Wickham, *Tidy Data* (2014). Wickham is a founding creator of the `tidyverse` tools in R.
- **Why "row" and "column" need defining**: the paper's Tables 1 and 2 show the same treatment results (people × treatment A/B), one the transpose of the other. Rows running horizontally doesn't tell you what a row *should* be.
- **The three rules of a tidy dataset**:
  - **Each variable forms a column.** "Treatment A" and "treatment B" are two values of one variable, `treatment`, so they belong in one column.
  - **Each observation forms a row.** One unit of measurement per row. The original paper also says each type of observational unit forms a table, which leads into databases and joins. The modern framing keeps the focus on a single dataset.
  - **Each cell contains one piece of information.**
- **Tidy is not "nicer to read"**: Table 3 (`name`, `treatment`, `result`) is longer and less space-efficient. Comparisons by eye can be harder. But it is the shape that plotting and model-fitting software needs. From tidy data you can always pivot into any reporting layout.
- **Colour in Excel breaks the one-fact-per-cell rule**: highlighting a value green or red adds a second piece of information to the cell. That is fine for scanning a spreadsheet, and the instructor does it himself. But colour does not exist once the data is loaded into analysis software. Record it as a separate column instead, such as a good/bad flag.
- **Messy data can break the rules in several ways at once**: a dataset may have one problem or a combination. Fix them one at a time, easiest first.

### 5. The common messy-data problems and their fixes

The paper lists five problems. The first three cover almost everything you will meet. The last two concern splitting and joining tables.

- **Problem 1 — Column headers are values, not variable names**
  - *How to spot it*: a large chunk of the column names follows a pattern. Examples: income ranges `<$10k`, `$10-20k`; weeks `wk1`, `wk2`; dates.
  - *Fix*: `pivot_longer()`. The patterned columns are stacked into rows: one new column holds the old header names, and another holds the cell values.
    - It is called "longer" because you end up with more rows.
    - The 2014 paper calls this *melting*.
  - *Examples*: Pew religion × income, and Billboard weekly rankings.
- **Problem 2 — Multiple variables stored in one column**
  - *How to spot it*: one value encodes two facts.
    - In the paper's tuberculosis data, a header like `m014` means *male* and *age 0–14*.
    - In the Ebola data, `Cases_Guinea` means *case count* and *Guinea*.
  - *Why it matters*: you can't ask "how many males in total?" with a group-by, because there is no single variable to point to.
  - *Fix*: first `pivot_longer()`, then `separate()` the combined column. Split it on a delimiter such as `_`, or take the first letter as sex and the rest as age group.
- **Problem 3 — Variables stored in both rows and columns**
  - *How to spot it*: ask "would a summary of this column make sense?"
    - In the paper's weather data, one `value` column holds both maximum and minimum temperatures. The average of a mix of mins and maxes means nothing.
    - Census tables sometimes mix counts and dollar amounts in one numeric column.
    - Even when the unit is the same (two counts), if they measure different things, the column needs splitting.
    - Another hint: if you have to keep pointing at different parts of the table to explain what each number means, it is probably not tidy.
  - *Fix*: `pivot_wider()`. Each unique value of one column (for example `element` or `type`) becomes its own new column, filled from a value column. This is what an Excel pivot table does.

### 6. Reading R / tidyverse code from scratch

- **`library(tidyverse)`**: loads the tidyverse packages, including `readr`, `dplyr`, `tidyr` and `ggplot2`. You run it once per session before using their functions.
- **`read_csv("pew.csv")`**: reads a CSV file into a table, called a *tibble*. It reports how many rows and columns it found and what type it guessed for each column:
  - `chr`: text
  - `dbl`: number
  - `lgl`: TRUE/FALSE
  - `date`, `time`: dates and times
- **`<-` (assignment)**: saves the result under a name. `pew <- read_csv("pew.csv")` means "store this table as `pew`". You then refer to it by that name.
- **`|>` (the pipe)**: read it as "and then". It passes the table on the left into the function on the right.
- **Choosing columns**:
  - `-religion` means "every column *except* `religion`".
  - `-c(Date, Day)` means "everything except `Date` and `Day`".
  - `starts_with("wk")` means "every column whose name begins with `wk`".
  - There are other ways to select columns; the instructor suggested exploring them with Copilot.
- **Why the instructor prefers R for this**: tidyverse code reads close to English. For example, "separate the `name` column into `type` and `country` on the underscore" is almost word for word what the code says.

### 7. Summary functions and group-by aggregation

- **Summary function**: takes many numbers in and returns one number out. Examples include `sum()`, `mean()` (average) and `max()`.
- **`group_by()` + `summarize()`**: the tidyverse way to build a table of summaries.
  - `group_by()` says "for each…".
  - `summarize()` computes one or more summary values per group. You name each new column, as in `count = sum(frequency)`.
- **Link to last week's data cube**: grouping by one variable gives a two-dimensional table. Grouping by several variables gives the roll-ups and drill-downs of the data cube. This is the same idea as grouping in Excel.
- **Why tidy first**: on the original Pew table, "people per religion" needs a row-sum across columns. That works only because of this particular layout. On tidy data it is simply group by `religion`, sum `frequency`.

### 8. Missing values

- **`NA`** ("not available") is R's placeholder for a missing value. It prints in a different colour and in capitals, so it stands out.
- A missing value is **not** zero. Zero means something, and a blank cell is ambiguous. `NA` makes "missing" explicit.
- `values_drop_na = TRUE` in `pivot_longer()` drops rows where the value is missing. In the Billboard data, these are the weeks a song was no longer on the chart.

### 9. Why this matters in practice

- **Rows scale; columns run out**: the instructor described a COVID-era case from the UK's NHS. A spreadsheet that added a new column for each day hit Excel's column limit. New data silently stopped updating and modelling was broken for a long time before anyone noticed. You can almost always add rows; columns eventually run out.
- **Leave breadcrumbs when you hand-curate data**: if you enter data in a wide, report-friendly layout, build in strategic delimiters (underscores or dashes) or fixed one-letter codes, as in `Cases_Guinea` or `m014`. Then you, or whoever cleans it later, can split the parts apart easily.
- **Diagnosing a difficult dataset**: work through the three common problems in turn, and you should end up with something tidy.

## Code from class

All code was run in the course Codespace. The datasets are at the top of the repository, so no folder path is needed.

### Loading the tidyverse and reading the Pew survey data

```r
library(tidyverse)            # load readr, dplyr, tidyr, ggplot2, ...

pew <- read_csv("pew.csv")    # read the CSV and save it as `pew`
pew                           # print it to look at it
```

`read_csv()` reports the shape and column types. One text column (`religion`) is followed by ten numeric columns whose *names* are income ranges. That is Problem 1.

```
Rows: 18 Columns: 11
chr  (1): religion
dbl (10): <$10k, $10-20k, $20-30k, $30-40k, $40-50k, $50-75k, $75-100k, $100...
```

### Tidying Pew with `pivot_longer()`

```r
pew_tidy <- pew |>
  pivot_longer(
    cols = -religion,           # pivot every column except religion
    names_to = "income",        # old column headers go into a column called income
    values_to = "frequency"     # old cell values go into a column called frequency
  )
pew_tidy
```

The result goes from 18 rows × 11 columns to 180 rows × 3 columns:

```
# A tibble: 180 × 3
   religion income             frequency
   <chr>    <chr>                  <dbl>
 1 Agnostic <$10k                     27
 2 Agnostic $10-20k                   34
 3 Agnostic $20-30k                   60
```

### Aggregating the tidy Pew data

```r
pew_tidy |>
  group_by(religion) |>                 # for each religion...
  summarize(count = sum(frequency))     # ...add up the frequencies into a column named count
```

This answers "how many people were asked in each religion?" It returns one row per religion, for example `Agnostic 826` and `Catholic 8054`.

### Tidying the Billboard chart data

```r
billboard <- read_csv("billboard.csv")
billboard

billboard_tidy <- billboard |>
  pivot_longer(
    cols = starts_with("wk"),                    # every column whose name starts with "wk"
    names_to = "week",
    names_prefix = "wk",                         # strip the "wk" so only the number is left
    names_transform = list(week = as.integer),   # store week as a whole number, not text
    values_to = "rank",
    values_drop_na = TRUE          # drop weeks the song was not on the chart
  )
billboard_tidy
```

The column report shows the weekly columns run from `wk1` to `wk76`. The last ones (`wk66`–`wk76`) were read as `lgl` because they are entirely empty: no song stayed on the chart that long.

```
Rows: 317 Columns: 81
chr   (2): artist, track
dbl  (66): year, wk1, wk2, wk3, wk4, wk5, wk6, wk7, wk8, wk9, wk10, wk11, wk...
lgl  (11): wk66, wk67, wk68, wk69, wk70, wk71, wk72, wk73, wk74, wk75, wk76
date  (1): date.entered
time  (1): time
```

After pivoting and dropping missing weeks, the data has 5,307 rows, with `week` stored as an integer:

```
# A tibble: 5,307 × 7
    year artist  track                   time   date.entered  week  rank
   <dbl> <chr>   <chr>                   <time> <date>       <int> <dbl>
 1  2000 2 Pac   Baby Don't Cry (Keep... 04:22  2000-02-26       1    87
 2  2000 2 Pac   Baby Don't Cry (Keep... 04:22  2000-02-26       2    82
```

### Average rank per week, and a line plot (written with Copilot)

The instructor asked Copilot to "look at the average ranking over each week across all the songs". It proposed the `group_by()` / `summarize()` step. He then asked it to "plot that result as a line".

```r
billboard_tidy |>
  group_by(week) |>
  summarize(average_rank = mean(rank)) |>         # mean() is a summary function
  ggplot(aes(x = week, y = average_rank)) +       # week on the x-axis, average rank on the y-axis
  geom_line()                                     # draw it as a line
```

`ggplot2` will be covered properly next week. The plot showed songs fading over time as they stop being new. After around 20 weeks there was a change in pattern. The instructor suggested this might be missing data or simply listeners tiring of a song.

### Tidying the Ebola data: `pivot_longer()`, then `separate()`

```r
ebola <- read_csv("ebola.csv")
ebola

ebola_long <- ebola |>
  pivot_longer(
    cols = -c(Date, Day),        # pivot everything except Date and Day
    values_to = "count",
    values_drop_na = TRUE
  )
ebola_long
```

The original has 122 rows × 18 columns, with headers such as `Cases_Guinea` and `Deaths_SierraLeone`. Each header encodes *what* is counted and *which country*. No `names_to` was given, so the old headers land in a default column called `name`:

```
# A tibble: 738 × 4
   Date       Day name               count
   <chr>    <dbl> <chr>              <dbl>
 1 1/5/2015   289 Cases_Guinea        2776
 2 1/5/2015   289 Cases_SierraLeone  10030
 3 1/5/2015   289 Deaths_Guinea       1786
```

```r
ebola_long <- ebola_long |>
  separate(col = 'name',
    into = c("type", "country"),  # split the header into two variables
    sep = "_"                     # split on the underscore
  )
ebola_long
```

```
# A tibble: 738 × 5
   Date       Day type   country     count
   <chr>    <dbl> <chr>  <chr>       <dbl>
 1 1/5/2015   289 Cases  Guinea       2776
 2 1/5/2015   289 Cases  SierraLeone 10030
 3 1/5/2015   289 Deaths Guinea       1786
```

### Maximum count per country and type

The counts were reported cumulatively each day, so the maximum is the total.

```r
ebola_long |>
  group_by(country, type) |>
  summarize(max_count = max(count))
```

This gives 16 rows, for example `Guinea Cases 2776`, `Liberia Deaths 3496` and `SierraLeone Cases 10030`. Grouping by two variables makes R print this message. It is information, not an error:

```
`summarise()` has regrouped the output.
ℹ Summaries were computed grouped by country and type.
ℹ Output is grouped by country.
ℹ Use `summarise(.groups = "drop_last")` to silence this message.
```

### Final tidy form with `pivot_wider()`

```r
ebola_tidy <- ebola_long |>
    pivot_wider(
        names_from = type,     # each unique value of type (Cases, Deaths) becomes a column
        values_from = count    # fill those columns from count
)

ebola_tidy
```

Cases and deaths are now separate columns, one row per date per country (375 rows). This is the tidy form of the Ebola dataset:

```
# A tibble: 375 × 5
   Date         Day country     Cases Deaths
   <chr>      <dbl> <chr>       <dbl>  <dbl>
 1 1/5/2015     289 Guinea       2776   1786
 2 1/5/2015     289 SierraLeone 10030   2977
 3 1/4/2015     288 Guinea       2775   1781
```

### What went wrong live

- **Copilot grouped by the wrong variables**: asked for the maximum value for each type for each country, Copilot grouped by day and country, and put the code in the wrong place. The instructor rewrote it as `group_by(country, type) |> summarize(max_count = max(count))`. Copilot then carried on making changes he hadn't asked for, and he had to tell it to stop and skip. Always read what the agent proposes before accepting it.
- **Unsure of the `pivot_wider()` argument name**: the instructor briefly second-guessed whether the argument was `names_from`. It is. The working call is `pivot_wider(names_from = type, values_from = count)`.
- **Typo loading packages**: the first attempt to type `library()` was mistyped and corrected before running `library(tidyverse)`.
- **Pasting a large chunk into the terminal**: when the whole script was pasted into the R console at once, the echoed code appeared jumbled, with stray markers and overlapping lines. All the code still ran and every result printed correctly. The echo is cosmetic; check the output, not the echo.

## Questions

- **Q:** A student asked whether the data provided for the Module 1 assignment is essentially already a tidy dataset.
  **A:** Yes. It has already been cleaned for you. Today's material is for students who want to bring their own dataset and need to get it into that analysis-ready form.

## Assignments

- [ ] Before next week's office hours: create a GitHub account if you don't have one, open the course repository in a Codespace, and work through this session's code using the recording. Report any problems with the Codespace. The first ~15 minutes of the recording walk through setup.
- [ ] Remember to **Stop** (not delete) your Codespace when you finish, and copy any code you want to keep.

---

- prompt: prompt-notes.md @ c7623cc
- prompt-hash: c082a6eab694
- model: claude-opus-5-5 (requested: opus)
- backend: claude
- inputs: transcript-plaud.md, history.R, R-console.txt
- generated: 2026-10-23
