> Date Time: 2026-10-29 18:00:24
>
> Location: [Location]
>
> Instructor: Daniel Chen

## Summary

This lecture covered course logistics, GitHub Codespaces setup, and an AI-driven workflow for summarizing lecture transcripts, followed by foundational-to-advanced data visualization in R using ggplot2 on the medicaldata package’s blood_storage dataset. Topics included tidy data principles, class imbalance in recurrence outcomes, data type classification (continuous, discrete, nominal, ordinal, binary), Grammar of Graphics layering (data, aes, geoms, coordinates, themes), and practical plotting techniques. Univariate and bivariate visualizations were demonstrated (bar plots, histograms, box plots, violin plots, jittered points, scatter plots), along with aesthetic encodings (color, fill, shape, size), correct handling of discrete numeric variables via factor conversion, faceting with facet_wrap and facet_grid, and strategies to address overplotting (hexbin, binning, macro-level summaries). The session emphasized preparing variables for modeling (e.g., logistic regression with binary outcomes), trade-offs in binarizing categories, and tool selection between code-based ggplot2 and GUI tools like Looker, augmented by AI assistants such as Copilot.

## Knowledge Points

### 1. Course Workflow, Tools, and LLM Summarization

- GitHub Codespaces: Launch via the repository’s Code button; initialization takes ~10 minutes. Copilot access (~1,500 queries/month) auto-selects models.
- LLM summarization workflow: Zoom recordings processed by Claude/other local models; local 27B model example requires ~41 GB memory. prompt_notes in lectures directory guides structured summaries.

### 2. Clinical Dataset and Tidy Data Principles

- medicaldata package (by Peter Higgins); install via install.packages("medicaldata").
- Dataset: blood_storage (blood) tracking biochemical recurrence post–radical prostatectomy; includes age groups, median age, biomarkers, time to recurrence, and binary recurrence status (1 yes, 0 no).
- Tidy data: variables as columns, observations as rows, single values per cell.
- Class imbalance: 262 non-recurrence vs. 54 recurrence (~4:1), important for ML/logistic regression.

### 3. Grammar of Graphics and ggplot2 Architecture

- Layering: ggplot(data) + aes() + geom_*() with optional coordinates/themes; empty canvas without mapped aes/geom.
- Global vs. local mappings: Define aes/data globally or per-geom to overlay subsets or distinct datasets.
- Pre-calculated data: Use stat = "identity" in geom_bar() to plot provided counts.

### 4. Univariate Visualizations

- Categorical/discrete: geom_bar() for frequency distributions; orientation via x/y mapping.
- Continuous: geom_histogram() with adjustable binwidth (e.g., 5-year age bins).

### 5. Bivariate Visualizations

- Categorical vs. continuous:
  - Box plots (geom_boxplot): median, quartiles, IQR, outliers.
  - Violin plots (geom_violin): distribution shape/density across categories.
  - Jitter (geom_jitter): mitigates overplotting, reveals sample density.
  - Factor conversion: cast discrete numeric categories (e.g., t_vol = 1,2,3) to factor for proper grouping.
  - Layering: combine violin + box + jitter to convey distribution and sample size.
- Continuous vs. continuous: geom_point() for relationships (e.g., prostate volume vs. labs).

### 6. Aesthetic Mappings and Data Type Handling

- Encodings: map color, fill, shape, size to variables; preferably align shape and color to the same variable to reduce clutter.
- Discrete numeric to color: convert to factor to avoid misleading continuous gradients and legends (no intermediate values exist).

### 7. Faceting and Multi-variable Exploration

- facet_wrap: small multiples by one categorical variable (e.g., RBC_age_group).
- facet_grid: two-dimensional grid by two categorical variables (e.g., RBC_age_group × recurrence).
- Insights: visually assess subgroup patterns (e.g., family history concentrated in recurrence facets).

### 8. Overplotting and High-Density Strategies

- Hexbin: bin points into hexagons to reveal density (2D histogram/heatmap).
- Macro-level summaries: move between detailed scatter plots and aggregated means/medians with error bars; standard plot types aid publication readability.

### 9. Variable Encodings and Modeling Preparation

- Identify variable types (continuous, discrete; nominal, ordinal, binary) for appropriate visualization and modeling.
- Logistic regression: requires binary outcomes (0/1).
- Binarization: simplifies analysis (e.g., stage 0 vs. others) but reduces nuance and potential statistical power.

### 10. Tool Selection and AI Assistance

- ggplot2 (code) vs. Looker (GUI): choice depends on workflow preference; data conceptualization principles are consistent.
- AI assistants (Copilot, GPT/Anthropic models): generate/explain visualization code when prompted with precise terminology; visual outputs facilitate rapid verification.

## Questions

- [Insert Question/Confusion]

## Assignments

- [ ] Install the medicaldata package in R: install.packages("medicaldata").
- [ ] Test launching the course environment via GitHub Codespaces.
- [ ] Practice layered ggplot2 visuals: bar plots (raw vs. pre-calculated with stat="identity"), histograms with binwidth, box/violin plots with factor-converted categories, jitter overlays.
- [ ] Experiment with AI tools (Copilot) to generate/explain ggplot2 code using accurate visualization terminology.
- [ ] Upload lecture transcription, notes, and code to the GitHub repository by 2026-10-30.
- [ ] Review local environment setup for running R and ggplot2 scripts before next week.
- [ ] Read Chapter 7 on visualizations to prepare for upcoming modeling topics.
