# Visualizing Health Data with `ggplot2` in GitHub Codespaces

Instructor: Daniel Chen

## Summary

This office-hour session moved from the course’s normal point-and-click `Looker` work to a code-first environment. Daniel showed how to open the course’s GitHub repository in a browser-based GitHub Codespace, how the session files are organized, and how `GitHub Copilot` can be used to explain or generate R code. The session also described how the office-hour notes are produced: recordings are transcribed, then transcripts and code logs are fed to large language models using a written prompt. A student asked about running local large language models, and the instructor answered with the approximate RAM needed for a 27-billion-parameter model.

The main teaching content was visualization in R using the `tidyverse` and `ggplot2`. The instructor worked through the `medicaldata::blood_storage` dataset, which concerns biochemical cancer recurrence after radical prostatectomy. The session reviewed tidy data, variable types, and the `ggplot2` layer system: data, aesthetic mappings, geometry layers, and facets. The class built frequency counts for `Recurrence`, then made bar charts, histograms, box plots, violin plots, jittered points, scatter plots, color-coded scatter plots, faceted scatter plots, and grid facets.

By the end of the session, a student should be able to explain how a `ggplot2` plot is built, choose a plot type based on whether variables are continuous or categorical, recognize when a numeric variable is really a category and must be converted with `as.factor()`, and use facets to add another categorical dimension. The session also reinforced that visualization code can be checked visually once the plot is drawn, while data cleaning and modeling code often contains more subtle mistakes. A course-wide privacy rule also matters: because a student’s fork of the course repository can be public, real patient data should not be put in it.

## Knowledge Points

### 1. Office-hour setup: GitHub Codespaces, Copilot, and AI-assisted notes

- **GitHub Codespaces**: a cloud coding environment that opens in the browser. The instructor described opening the course repository, choosing the green `Code` button, selecting the `GitHub Codespaces` tab, and waiting for the environment to download/install.
  - If the Codespaces button is not available, one option is to fork the repository into your own account and then open a Codespace from the fork.
  - A student’s fork may be public, so do not put real patient data in it.
- **Session files**: the office-hour code is stored in the course repository. The instructor referenced a last-week tidy-data file and a current visualizations file.
- **Running R code in the editor**:
  - On macOS, select the code and use `Command + Enter`.
  - On Windows, the equivalent was described as `Control + Enter`.
- **`Copilot`**: the Codespace environment includes access to GitHub Copilot.
  - The instructor mentioned getting about 1,500 Copilot requests or questions per month.
  - Copilot was set to `auto`, meaning it chooses an available model.
  - Copilot can be used to explain code, for example by asking, “Can you explain what is happening in this code?”
- **AI-generated notes**: the instructor has been converting audio transcripts into study notes using large language models.
  - Some notes were generated with Claude.
  - Other experiments used local models.
  - A prompt file in the course materials contains the instructions used to turn a transcript and optional code files into a structured summary.
- **Local LLM hardware question**: a student asked how much RAM is needed for a 27-billion-parameter local model. The instructor said the 27B model takes about 41 GB, and mentioned having around 120 GB total.
- **Future sessions**:
  - The next office hour was planned to be shorter and focused on installing/running the tools on a local computer.
  - The final office hour would be mostly open for last-minute questions.

### 2. The `blood_storage` dataset and tidy data

- **`medicaldata` package**: an R package containing health-related datasets.
  - The dataset used in this session is `medicaldata::blood_storage`.
  - The instructor described it as curated by Peter Higgins, a gastroenterologist at Michigan.
  - The dataset is about biochemical cancer recurrence after radical prostatectomy.
- **Radical prostatectomy**: removal of the prostate and surrounding tissue. The “radical” part refers to removing the surrounding tissue.
- **Key variables used in the session**:
  - `Recurrence`: binary outcome, `1` for yes and `0` for no.
  - `Age`: patient age, often treated as continuous even if stored as whole numbers.
  - `TVol`: a numeric column with values such as 1, 2, 3, and missing values, but conceptually categorical.
  - `PVol`: continuous variable used in scatter plots.
  - `PreopPSA`: continuous lab result used in scatter plots.
  - `sGS`: a numeric-looking variable that is actually categorical, such as stage-like values.
  - `RBC.Age.Group`: categorical grouping variable used in facets.
  - `FamHx`: family-history variable used in a faceted scatter plot.
- **Tidy data**:
  - Each column represents one variable.
  - Each row represents one observation.
  - Each cell contains one value.
  - There is no hidden color-coding or multiple meanings inside a cell.
- **Why tidy data matters**:
  - `ggplot2` needs tidy columns so that aesthetic mappings can point to specific variables.
  - Statistical models also need tidy data because they must refer to specific columns.
- **Imbalanced binary outcome**:
  - The transcript reported 262 observations with `Recurrence = 0` and 54 observations with `Recurrence = 1`.
  - That is roughly a 4-to-1 imbalance.
  - Imbalanced binary outcomes can raise flags for modeling, especially if model error rates are not carefully evaluated.

### 3. Variable types and how they guide plot choice

- **Continuous variables**:
  - Numeric values that can include decimals.
  - Example: a measurement that can vary smoothly.
  - Common univariate plot: histogram.
- **Discrete numeric variables**:
  - Whole-number values.
  - Count-like values may be discrete, but they can still be treated continuously depending on the question.
  - Age was discussed as a case where the data may be whole numbers but the variable is often treated as continuous.
- **Categorical variables**:
  - Values represent groups or categories.
  - They can be nominal, ordinal, or binary.
- **Nominal variables**:
  - Categories with no natural order.
  - Example: favorite sport.
- **Ordinal variables**:
  - Categories with a meaningful order.
  - Examples: Likert-scale responses or disease stages, such as stage 1, stage 2, stage 3, stage 4.
- **Binary variables**:
  - A special categorical variable with only two categories.
  - Often encoded as `0` and `1`.
  - Binary outcomes are commonly modeled with logistic regression.
  - Many categorical variables can be converted into binary variables for an initial analysis, though this can lose information.
- **Numeric categories that need `as.factor()`**:
  - Some variables are stored as numbers but are really categories.
  - Examples from this session:
    - `TVol` had values like 1, 2, and 3, but the instructor did not want R to treat it as a continuous scale.
    - `sGS` had numeric values, but the plot legend initially made it look like intermediate values such as 1.5 were possible.
  - Converting these with `as.factor()` tells R to treat the values as categories.

### 4. `ggplot2` and the grammar of graphics

- **`ggplot2`**: an R package for making graphics.
  - It is based on the Grammar of Graphics.
  - The package was written by Hadley Wickham; the broader grammar-of-graphics concept is not exclusively his.
- **Layer-based design**:
  - A plot is built by adding layers.
  - The main layers discussed were:
    - Data layer: the dataset being plotted.
    - Aesthetic mapping: which variables are mapped to visual properties.
    - Geometry layer: what kind of mark or plot is drawn.
    - Facet layer: how the plot is split into panels.
- **Base plot**:
  - `ggplot(data = blood)` creates the base plot.
  - If no aesthetic mapping or geometry is provided, the result can be a blank gray square.
- **Aesthetic mapping with `aes()`**:
  - `aes()` maps variables to visual properties such as position, color, fill, shape, or size.
  - Common aesthetic mappings include:
    - `x = Recurrence`
    - `y = Age`
    - `color = sGS`
  - The instructor mentioned `color`, `fill`, `shape`, and `size` as examples of aesthetics that can be mapped.
- **Geometry layers**:
  - Geometry layers determine what is drawn.
  - Geometry functions begin with `geom_`.
  - Examples used or discussed:
    - `geom_bar()`: bar chart.
    - `geom_histogram()`: histogram.
    - `geom_boxplot()`: box plot.
    - `geom_violin()`: violin plot.
    - `geom_point()`: point/scatter plot.
    - `geom_jitter()`: point plot with random horizontal jitter.
- **`geom_bar()` with raw data**:
  - When `ggplot2` is given raw data and `geom_bar()`, it can count values automatically.
  - This is useful when you want the bar heights to be frequency counts.
- **`geom_bar(stat = "identity")`**:
  - Use this when the data already contains the bar heights.
  - In the session, `recurrence_freq` contained `Recurrence` and `count`.
  - `stat = "identity"` tells `ggplot2` to use the supplied `count` values directly instead of recounting rows.
  - Without `stat = "identity"`, `ggplot2` may count rows in the current data frame, which can produce bars of height 1 if the data has one row per category.
- **Moving data and mappings into geometry layers**:
  - Data and aesthetic mappings can be specified in the base `ggplot()` call or inside individual `geom_*()` calls.
  - This flexibility allows overlays:
    - Different geometry layers can use the same data.
    - Different geometry layers can use different data.
    - Different visualizations can be layered on top of one another.
- **Facets**:
  - Facets create small multiples of the same plot.
  - `facet_wrap(~ RBC.Age.Group)` creates a panel for each level of one variable.
  - `facet_grid(RBC.Age.Group ~ Recurrence)` creates a grid of panels using two variables.
  - Facets are useful when color or shape encoding becomes too busy.

### 5. Choosing plots by the number and type of variables

- **Univariate plot**: one variable.
  - Ask whether the variable is numeric or categorical.
  - If numeric:
    - Continuous: histogram is a common choice.
    - Discrete or categorical-like: bar chart is a common choice.
  - `geom_histogram()` creates bins/ranges of values.
  - `geom_bar()` counts unique values or categories.
- **Bivariate plot**: two variables.
  - Ask the type of each variable:
    - Two continuous variables: scatter plot.
    - One categorical variable and one continuous variable: box plot, violin plot, or similar grouped distribution plot.
    - Two categorical variables: bar plot or other categorical summary plot.
- **Adding a third categorical variable**:
  - One approach is to map it to an aesthetic such as `color`, `fill`, `shape`, or `size`.
  - If too many groups are being encoded, use facets to split the plot into panels.
- **Color and shape advice**:
  - If using both color and shape, it is often easier for readers when they encode the same variable.
  - This can make categories easier to distinguish, especially for viewers with color-vision differences.
- **Publication vs exploration**:
  - Published research often uses traditional plots that readers already know.
  - Exploratory analysis can use many plot types that are not ultimately published.
  - A plot that is hard to interpret may require a lot of extra text to explain.

### 6. Box plots, violin plots, jitter, and overplotting

- **Box plot**:
  - Shows a summary distribution for each category.
  - The line inside the box is the median.
  - The box represents the 25th, 50th, and 75th percentiles.
  - The interquartile range is shown by the box height.
  - Points outside a rule based on the interquartile range can be shown as potential outliers.
- **Violin plot**:
  - Shows the shape of the distribution.
  - It is like a mirrored histogram.
  - It can make the bulk of the data easier to see than a box plot.
- **Overlaying layers**:
  - A violin plot can be overlaid with:
    - `geom_boxplot()`
    - `geom_point()`
    - `geom_jitter()`
  - This uses the same base data and aesthetic mappings while drawing additional marks.
- **Overplotting**:
  - Occurs when many points have the same or very similar coordinates.
  - Points can hide one another.
  - Making points larger can worsen overplotting.
- **`geom_jitter()`**:
  - Adds a small random offset, usually horizontally for a categorical x-axis.
  - It helps reveal how many points are present in a category.
  - The jittered horizontal position is not exact; it is a visual aid.
  - The vertical position still represents the actual numeric value.
- **Other ways to handle overplotting**:
  - `hexbin`-style plots: plot the count of points in local regions instead of drawing every point.
  - Summary statistics: show means, medians, or modes with confidence intervals.
  - Traditional bar or line summaries.

### 7. Scatter plots, categorical color, and factors

- **Scatter plot**:
  - Used for two continuous variables.
  - In the session: `PVol` on `x` and `PreopPSA` on `y`.
  - `geom_point()` draws one point per observation.
- **Adding a categorical variable with color**:
  - `color = sGS` colors points by the `sGS` values.
  - If `sGS` is numeric but categorical, the legend can look like a continuous color scale.
  - That can misleadingly suggest that intermediate values exist.
- **Fixing numeric categories**:
  - Use `as.factor(sGS)` so R treats the values as categories.
  - The legend then shows discrete category labels instead of implying continuous intermediate values.
- **Faceted scatter plots**:
  - `facet_wrap(~ RBC.Age.Group)` created a separate scatter plot panel for each age group.
  - `facet_grid(RBC.Age.Group ~ Recurrence)` created a two-variable grid.
  - In one faceted plot, `FamHx` was used for color, and the instructor noted an apparent pattern where family history and recurrence seemed related in some panels.
  - This was described as exploratory observation, not proof.

### 8. Connecting code-first visualization to `Looker`

- **`Looker` connection**:
  - Many `ggplot2` ideas have point-and-click equivalents in `Looker`.
  - Choosing fields, chart type, categorical vs numeric treatment, color, and facets are similar conceptual tasks.
- **Choosing a tool**:
  - If choosing between R/`ggplot2` and a no-code tool such as `Looker`, the instructor said the decision is often about how comfortable the user is with code.
  - Once the tool is chosen, the data and variable types still determine the visual approach.
- **Why visualization code may be easier to verify**:
  - Data cleaning code can be hard to check because the wrong result may still look plausible.
  - Modeling code has many subtle assumptions and gotchas.
  - Once a plot is drawn, it is often possible to visually inspect which variables are being used and whether the plot looks correct.

## Code from class

### Load packages and get the blood storage dataset

```r
# code from
# https://ds4biomed.tech/visualization-intro#data-geometries

library(medicaldata)
library(tidyverse)

blood <- medicaldata::blood_storage
head(blood) # use head to look at the first 6 rows
```

If `library(medicaldata)` reports that the package is not found, the instructor said to install it first with `install.packages("medicaldata")`. The `head(blood)` line is just a quick way to inspect the first few rows of the dataset.

### Count recurrence and build basic bar charts

```r
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
```

The first two `ggplot()` calls show why layers are needed: data alone gives a blank gray square, and adding `aes(x = Recurrence)` tells `ggplot2` which variable to use but still does not specify what to draw. The first `geom_bar()` call works with the raw `blood` data and counts categories. The `recurrence_freq` version uses pre-calculated counts and therefore uses `stat = "identity"`.

### Univariate plot: histogram for a continuous variable

```r
# univariate

ggplot(blood, aes(x = Age)) + geom_histogram()

ggplot(blood, aes(x = Age)) + geom_histogram(bins = 10)
```

A histogram is used for `Age` because age is usually treated as a continuous numeric variable. The `bins = 10` argument controls how many bins/ranges are used to summarize the distribution.

### Bivariate plots: box plot, violin plot, points, and jitter

```r
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
```

These examples compare one categorical variable, `TVol`, with one continuous variable, `Age`. The first box plot treats `TVol` as numeric, which does not properly represent its category-like values. The later versions use `as.factor(TVol)` so each value is treated as a category. The sequence then overlays a violin plot with a box plot, points, and jittered points. The final version moves the shared aesthetic mapping into the base `ggplot()` call.

### Scatter plots, categorical color, and facets

```r
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
```

The first three blocks show a scatter plot between two continuous variables, `PVol` and `PreopPSA`, and then add a categorical color variable. The first color version, `color = sGS`, can make the legend look continuous. Using `as.factor(sGS)` makes the legend show discrete categories. The facet examples add more categorical structure: `facet_wrap()` creates one panel per `RBC.Age.Group`, while `facet_grid()` creates a two-dimensional panel layout using `RBC.Age.Group` and `Recurrence`.

### What went wrong live

- **`TVol` treated as continuous**: `ggplot(blood) + geom_boxplot(aes(x = TVol, y = Age))` did not show `TVol` properly because its values behave like categories, not a continuous scale. The fix was `as.factor(TVol)` inside the aesthetic mapping.
- **`sGS` color legend implied continuous values**: `color = sGS` made the legend look like a continuous color scale, suggesting that intermediate values such as 1.5 might exist. The fix was `color = as.factor(sGS)`, which displays the values as discrete categories.
- **Blank gray square from incomplete plot**: `ggplot(data = blood)` produced only a gray square because no aesthetic mapping or geometry layer was supplied. The plot became meaningful after adding `aes(x = Recurrence)` and then a `geom_bar()` layer.

## Questions

- **Q:** A student asked about running local large language models: how much RAM does the instructor’s 27-billion-parameter local LLM setup need?
  **A:** Daniel said the 27-billion-parameter model takes about 41 GB, and that his total setup is around 120 GB. The student said they had 48 GB and were struggling with models approaching that size.

- **Q:** A student asked whether the procedure was correctly called “prostatectomy.”
  **A:** Daniel confirmed it was radical prostatectomy, meaning removal of the prostate along with surrounding tissue; the “radical” part refers to that wider removal.

- **Q:** A student asked whether the dataset and the variable being examined determine the tool used in the analysis.
  **A:** Daniel said that if the choice is between a code tool such as `ggplot2` and a no-code tool such as `Looker`, the decision is usually about how comfortable the user is with code. Once the tool is chosen, the same thinking applies: examine the variables, decide whether each is continuous or categorical, choose the appropriate visualization type, and add categories through color, shape, or facets as needed. He also noted that visualization code is often easier to check visually once the plot is drawn, while data cleaning and modeling code can have more subtle errors.

---

- prompt: prompt-notes.md @ 9540d32
- prompt-hash: c082a6eab694
- model: qwen3.8-27b-sglang (requested: qwen3.8-27b-sglang)
- backend: local (SGLang)
- inputs: transcript-plaud.md, history.R
- generated: 2026-10-30
