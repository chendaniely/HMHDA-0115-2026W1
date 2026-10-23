# HMHDA-0115-2026W1

Health Data and Visualization, term 2026W1: section `HMHDA_VM 0115 009`.

It is one of the three courses in UBC's
[Micro-certificate in Health Data Analytics: Opportunities and Applications](https://extendedlearning.ubc.ca/programs/health-data-analytics-opportunities-applications-microcertificate),
offered through UBC Extended Learning and developed by the UBC Department of Medicine and the
UBC Data Science Institute. The course page is
[extendedlearning.ubc.ca/courses/health-data-visualization/0115](https://extendedlearning.ubc.ca/courses/health-data-visualization/0115).

## Course code

`HMHDA-0115` is the Workday code `HMHDA_VM 0115` with the `_VM` suffix and the section (`009`)
dropped, the same way `SPPH_V 381H` became `SPPH-381H`. `0115` is Extended Learning's course
number. Its sister courses are `0114` and `0116`.

Each term gets its own repo named for the term, here `HMHDA-0115-2026W1`, inside
`~/git/ubc/HMHDA-0115/`.

Decided 2026-10-22. Daniel: "let's put the term in the repo name as well."

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
