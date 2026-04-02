# TCD Stocking Inc. — Database Project

[![Render LaTeX](https://github.com/lolkat247/theoretical-chair-degree-database/actions/workflows/render.yml/badge.svg)](https://github.com/lolkat247/theoretical-chair-degree-database/actions/workflows/render.yml)

COP3710 Database 1, Professor Navarro

[View the latest rendered PDF](https://github.com/lolkat247/theoretical-chair-degree-database/blob/build/proposal.pdf)

## Rendering locally

Requires a LaTeX distribution (e.g. TeX Live, MacTeX).

```
./render.fish
```

The PDF is also built on every push via GitHub Actions and pushed to the `build` branch.

## Project structure

```
latex/          LaTeX source files
  main.tex     Document entry point
  cover.tex    Title page
  ch01-ch19    Chapter files
render.fish    Build script (fish shell)
outline.md     Planning notes
```
