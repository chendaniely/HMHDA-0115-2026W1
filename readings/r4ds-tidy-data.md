# R for Data Science: Tidy data

[Chapter 12, "Tidy data"](https://r4ds.had.co.nz/tidy-data.html), in *R for Data Science* by
Hadley Wickham and Garrett Grolemund. The book is free to read online.

It covers the same ideas as the tidy data paper (`tidy-data.pdf`), with tidyverse code you can
run. It uses the same functions as the 2026-10-22 session:

- [Pivoting](https://r4ds.had.co.nz/tidy-data.html#pivoting): `pivot_longer()` and
  `pivot_wider()`
- [Separating and uniting](https://r4ds.had.co.nz/tidy-data.html#separating-and-uniting):
  `separate()` and `unite()`
- [Missing values](https://r4ds.had.co.nz/tidy-data.html#missing-values-3)
- [Case study](https://r4ds.had.co.nz/tidy-data.html#case-study): the World Health
  Organization's tuberculosis data, whose column names, such as `new_sp_m014`, pack several
  variables together

This is the book's first edition. The second edition's version is
[chapter 5, "Data tidying"](https://r4ds.hadley.nz/data-tidy.html). It also uses
`pivot_longer()` and `pivot_wider()`, but splits a column name with `names_sep` inside
`pivot_longer()` instead of `separate()`.
