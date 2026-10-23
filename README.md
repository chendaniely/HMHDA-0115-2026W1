# HMHDA-0115-2026W1

Health Data and Visualization, term 2026W1: section `HMHDA_VM 0115 009`.

It is one of the three courses in UBC's
[Micro-certificate in Health Data Analytics: Opportunities and Applications](https://extendedlearning.ubc.ca/programs/health-data-analytics-opportunities-applications-microcertificate),
offered through UBC Extended Learning and developed by the UBC Department of Medicine and the
UBC Data Science Institute. The course page is
[extendedlearning.ubc.ca/courses/health-data-visualization/0115](https://extendedlearning.ubc.ca/courses/health-data-visualization/0115).

## Get set up

Work through these pages in order. You don't need to install anything on your own computer.

1. [Create a GitHub account](docs/01-github-account.md)
2. [Sign up for GitHub Copilot](docs/02-copilot.md)
3. [Open your Codespace](docs/03-open-codespace.md)
4. [Try R with `example.R`](docs/04-try-r.md)
5. [Try Quarto with `example.qmd`](docs/05-try-quarto.md)
6. [Stop your Codespace when you finish](docs/06-stop-codespace.md)

Something not working? See [Troubleshooting](docs/07-troubleshooting.md).

## Class notes

Notes from each live session are in [`lectures/`](lectures/), one folder per date. An AI model
writes them from a recording of the session; [`lectures/README-prompt.md`](lectures/README-prompt.md)
explains how.

## Data

The five datasets below were copied on 2026-10-22 from
[`chendaniely/2026-s1-ubc-dash-vis`](https://github.com/chendaniely/2026-s1-ubc-dash-vis) at
`26199ed`. Each one is byte for byte the same as the upstream copy named here.

They sit at the top level, next to the code and `patients.csv`, so `read_csv("pew.csv")` works
without a folder in the path. Decided 2026-10-22. Daniel: "don't need to worry about working
directories this way."

| File | What it is | Where it came from |
|---|---|---|
| `pew.csv` | Pew Forum survey counts by religion and income, in the US | [`chendaniely/pandas_for_everyone`](https://github.com/chendaniely/pandas_for_everyone/tree/master/data) `data/pew.csv`, the untidy table in Wickham (2014), made from `pew.sav` in [`hadley/tidy-data`](https://github.com/hadley/tidy-data/tree/master/data) |
| `billboard.csv` | Billboard Top 100 songs of 2000, one column per week on the chart | `pandas_for_everyone` `data/billboard.csv`, made from `billboard.csv` in `hadley/tidy-data` |
| `weather.csv` | Daily temperatures at one weather station (MX17004) in Mexico in 2010, from the Global Historical Climatology Network | `pandas_for_everyone` `data/weather.csv`, made from `weather.txt` in `hadley/tidy-data` |
| `ebola.csv` | Ebola cases and deaths by country, 2014–2015 West Africa outbreak, from WHO reports | `country_timeseries.csv` in [`cmrivers/ebola`](https://github.com/cmrivers/ebola) by Caitlin Rivers, renamed |
| `gapminder.tsv` | Life expectancy, population and GDP per capita by country, 1952–2007, from [Gapminder](https://www.gapminder.org/) | `inst/extdata/gapminder.tsv` in [`jennybc/gapminder`](https://github.com/jennybc/gapminder) |

`ebola.csv` comes with its own terms: the data may be copied and changed, the source must be
credited, and it may not be redistributed under a different licence.

`patients.csv` is a small practice dataset for `example.R` and `example.qmd`, from
[`ehsanx/HDSx-workspace`](https://github.com/ehsanx/HDSx-workspace).

## Finding more health data

- [Synthea downloads](https://synthetichealth.github.io/downloads.html): synthetic patient
  records from Synthea, an open-source patient simulator made by The MITRE Corporation. The
  patients aren't real, so the data has no privacy restrictions. Start with the small sample
  files: "100 Sample Synthetic Patient Records, CSV" is a 7 MB download. The million-patient
  archives (21 GB and more) are too big for a Codespace.
- [Kaggle datasets](https://www.kaggle.com/datasets): public datasets shared by many people,
  including lots of health data. Each dataset has its own licence and quality, so read its
  description before you use it.

## Readings

`readings/tidy-data.pdf` is the author's preprint of the tidy data paper, from
<https://vita.had.co.nz/papers/tidy-data.pdf>. Cite the published version:

> Wickham, H. (2014). Tidy Data. *Journal of Statistical Software*, *59*(10), 1–23.
> <https://doi.org/10.18637/jss.v059.i10>

```bibtex
@article{wickham2014tidy,
  title   = {Tidy Data},
  author  = {Wickham, Hadley},
  journal = {Journal of Statistical Software},
  year    = {2014},
  volume  = {59},
  number  = {10},
  pages   = {1--23},
  doi     = {10.18637/jss.v059.i10}
}
```

The tidy data chapter of *Data Science: A First Introduction* covers the same ideas:
<https://datasciencebook.ca/wrangling.html#tidy-data>.

## Credits

The setup pages in `docs/` and their screenshots in `img/` are adapted from the
[HDSx course book](https://ehsanx.github.io/HDSx/), *Health Data Science: AI and Knowledge
Translation* by M. Ehsan Karim and the AI-KT team (source:
[`ehsanx/HDSx`](https://github.com/ehsanx/HDSx) at `4056e84`). Each page links to the chapter it
adapts.

The Codespace setup (`.devcontainer/`), `.gitignore`, `patients.csv` and the structure of
`example.qmd` come from [`ehsanx/HDSx-workspace`](https://github.com/ehsanx/HDSx-workspace) at
`990153f`.
