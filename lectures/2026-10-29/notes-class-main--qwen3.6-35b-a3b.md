# Visualizations in R with ggplot2

Date Time: [Omitted]

Location: [Omitted]

Instructor: Daniel Chen

## Summary

This session bridges the gap between point-and-click visualization tools like Looker and writing code in R. Using the `ggplot2` package and a clinical dataset on biochemical cancer recurrence after radical prostatectomy, the instructor demonstrated how to translate data types into appropriate visualizations. The lecture emphasized that the underlying analytical logic remains consistent whether you use a GUI or write code: you must first identify whether your variables are continuous, discrete, nominal, ordinal, or binary.

Students walked through building plots layer by layer in `ggplot2`, starting with base data, adding aesthetic mappings to tie columns to visual properties, and attaching geometry layers like bars, histograms, box plots, and scatter plots. Key practical takeaways included handling categorical variables that are stored as numbers (requiring conversion to factors), overlaying multiple geoms to show both distribution density and individual data points, and using faceting to split complex data into readable small multiples. The session also addressed common pitfalls like misleading continuous color scales and overplotting, providing concrete code fixes for each.

## Knowledge Points

### 1. The Grammar of Graphics and Plot Layers

- **`ggplot2` layering system**: Every plot is built by adding distinct layers. You start with a base layer that specifies the `data`, followed by a mapping layer (`aes`) that binds data columns to visual properties (like `x`, `y`, or `color`), and finally a geometry layer (`geom_`) that determines what shape or chart type is drawn.
- **Layer flexibility**: Data and aesthetic mappings can be defined globally in the base `ggplot()` call or passed locally to a specific `geom_` function. Local mappings override or add to global ones, allowing you to overlay different datasets or variables on the same axes.

### 2. Variable Types and Univariate Plots

- **Continuous vs. Discrete vs. Categorical**: Before plotting, classify variables. Continuous variables have infinite possible values (often decimals), discrete variables are counted in whole steps, and categorical variables represent groups (nominal = no order, ordinal = ordered, binary = two categories).
- **`geom_histogram()`**: The standard choice for continuous numeric variables. It automatically bins the data into ranges to show distribution. You can control bin density using the `bins` argument.
- **`geom_bar()`**: Used for discrete or categorical variables. By default, it tallies the frequency of each unique value. If your data is already pre-aggregated into counts, you must add `stat = "identity"` so `ggplot2` uses the supplied `y` values directly instead of recounting rows.

### 3. Bivariate Visualizations

- **Box and Violin Plots**: Ideal when one axis is categorical and the other is continuous. `geom_boxplot()` displays the median, quartiles, and outliers. `geom_violin()` mirrors a histogram to show the probability density of the data. They can be overlaid to give both summary statistics and distribution shape.
- **`geom_jitter()`**: Adds random horizontal noise to scatter points. This prevents overplotting (dots stacked directly on top of each other) when visualizing individual observations over a distribution plot, revealing the true number of cases in dense areas.
- **Scatter Plots and Color Mapping**: `geom_point()` visualizes two continuous variables. You can map a third categorical variable to `color` or `shape` inside `aes()`. This works cleanly only if the variable is converted to a factor; otherwise, `ggplot2` treats it as continuous and creates a misleading color gradient.
- **Faceting**: `facet_wrap()` splits a single plot into a grid of small multiples based on one categorical variable. `facet_grid()` splits data across two categorical variables (rows and columns), providing a structured way to compare subgroups without cluttering a single axes.

### 4. Handling Categorical Variables Stored as Numbers

- **Forcing factors with `as.factor()`**: Clinical data often encodes categories as integers (e.g., disease stages `1`, `2`, `3`, or tumor volume `1`, `2`, `3`). If left as numeric, `ggplot2` will plot them on a continuous scale, implying values like `1.5` exist and breaking categorical grouping. Wrapping the column in `as.factor()` inside the `aes()` mapping forces discrete grouping and correct legends.

## Code from class

### Loading data and pre-calculating frequencies

```r
# Load required packages
library(medicaldata)
library(tidyverse)

# Load the prostate cancer recurrence dataset
blood <- medicaldata::blood_storage
head(blood)

# Pre-calculate recurrence counts using tidyverse pipes
recurrence_freq <- blood |>
  group_by(Recurrence) |>
  summarize(count = n())
recurrence_freq
```

The `blood_storage` dataset contains patient demographics and biochemical markers. Pre-calculating counts allows us to demonstrate how `ggplot2` handles pre-aggregated data versus raw tallies.

### Building bar plots with different layer configurations

```r
# 1. Base data and aesthetic mapping only (shows empty plot area)
ggplot(data = blood, mapping = aes(x = Recurrence))

# 2. Add geometry: geom_bar() automatically tallies the x variable
ggplot(data = blood, mapping = aes(x = Recurrence)) + geom_bar()

# 3. Pre-aggregated data requires stat = "identity" to use provided y values
ggplot(data = recurrence_freq, mapping = aes(x = Recurrence, y = count)) +
  geom_bar(stat = "identity")

# 4. Defining layers locally within the geometry function
ggplot() +
  geom_bar(data = recurrence_freq, mapping = aes(x = Recurrence, y = count), stat = "identity")
```

`geom_bar()` is the workhorse for frequency counts. When `stat = "identity"` is used, it expects explicit `y` coordinates because it should not perform its default counting operation.

### Univariate continuous data: Histograms

```r
# Default histogram for continuous numeric data (Age)
ggplot(blood, aes(x = Age)) + geom_histogram()

# Adjusting bin count to refine distribution details
ggplot(blood, aes(x = Age)) + geom_histogram(bins = 10)
```

### Bivariate data: Box plots, Violin plots, and Jitter

```r
# TVol is numeric but represents distinct categories. 
# We convert it to a factor to group data correctly on the x-axis.
ggplot(blood) + geom_boxplot(aes(x = as.factor(TVol), y = Age))

# Overlaying violin and box plots for distribution + summary statistics
ggplot(blood) + 
  geom_violin(aes(x = as.factor(TVol), y = Age)) +
  geom_boxplot(aes(x = as.factor(TVol), y = Age))

# Jitter plot to reveal individual patient points without overplotting
ggplot(blood) +
  geom_violin(aes(x = as.factor(TVol), y = Age)) +
  geom_jitter(aes(x = as.factor(TVol), y = Age))
```

### Bivariate continuous data: Scatter plots, color mapping, and faceting

```r
# Scatter plot for two continuous variables (PVol and PreopPSA)
ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA))

# Adding color mapping for a categorical variable (converted to factor)
ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(sGS)))

# Facet wrap: small multiples split by one categorical variable
ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(sGS))) +
  facet_wrap(~ RBC.Age.Group)

# Facet grid: split by two categorical variables in a row/column layout
ggplot(blood) +
  geom_point(aes(x = PVol, y = PreopPSA, color = as.factor(FamHx))) +
  facet_grid(RBC.Age.Group ~ Recurrence)
```

When visualizing continuous data, adding categorical dimensions via `color` or `shape` requires explicit factor conversion to maintain accurate legends. Faceting scales better than adding multiple aesthetic dimensions to a single chart, which often leads to visual clutter.

## What went wrong live

- **Numeric categories plotted on a continuous scale**: When mapping `TVol` (total volume, coded as `1`, `2`, `3`) and `sGS` (a categorical grading score) directly to axes or color, `ggplot2` treated them as continuous numbers. This produced misleading x-axis ranges and continuous color gradients implying intermediate values like `1.5` exist. The fix was wrapping the variables in `as.factor()` inside the `aes()` mapping, which forced discrete grouping and correct categorical legends.
- **Overplotting in scatter plots**: The instructor noted that plotting raw points over categorical groups often results in dots stacking perfectly on top of each other, hiding the true sample size in dense regions. Switching to `geom_jitter()` added controlled random noise to the horizontal axis, revealing the actual distribution of observations without distorting the categorical grouping.

## Questions

- **Q:** How much RAM is required to run large local LLMs (like a 27-billion parameter model) for generating lecture summaries?
  **A:** The instructor shared that a 27B parameter model requires approximately 41 GB of RAM. Their local machine is equipped with over 120 GB to comfortably run these larger models, as well as test smaller variants that could eventually run on standard laptops.
- **Q:** Does the dataset and variables dictate which tool (R code vs. Looker) I should use for my analysis?
  **A:** The tool choice ultimately comes down to your comfort with code versus point-and-click interfaces. However, once a tool is selected, the analytical logic is identical: you still evaluate variable types to pick the right chart. AI can also help generate the code if you know the correct terminology, meaning the barrier to producing accurate visualizations is lower than ever, provided your underlying data is clean.

---

- prompt: prompt-notes.md @ 9540d32
- prompt-hash: c082a6eab694
- model: qwen3.6-35b-a3b (requested: qwen3.6-35b-a3b)
- backend: local (llama-swap)
- inputs: transcript-plaud.md, history.R
- generated: 2026-10-30
