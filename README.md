# Dalton Kutzen Resume

A reproducible resume built with [Quarto](https://quarto.org/) and rendered to PDF with [Typst](https://typst.app/).

The resume content lives in a plain-text `.qmd` file, making it easy to maintain in Git, tailor for different applications, and regenerate without manually editing a PDF.

## Requirements

Install Quarto:

- [Quarto installation instructions](https://quarto.org/docs/get-started/)

Quarto includes support for rendering Typst-based PDF documents. No full LaTeX installation is required.

To verify your installation:

```bash
quarto check
```

## Project Structure

```text
.
├── _quarto.yml          # Project-level Quarto configuration
├── resume.qmd           # Resume content and document metadata
├── resume-style.typ     # Optional Typst styling rules
├── README.md            # Project documentation
└── output/              # Rendered files; generated locally
    └── Dalton-Kutzen-Resume.pdf
```

## Render the Resume

From the project directory, run:

```bash
quarto render resume.qmd --to typst
```

Or render every Quarto document and configured output in the project:

```bash
quarto render
```

The rendered PDF is written to:

```text
output/Dalton-Kutzen-Resume.pdf
```

The output directory is configured in `_quarto.yml`.

## Preview in Positron

To preview the document in Positron:

1. Open `resume.qmd`.
2. Open the Command Palette with `Ctrl+Shift+P`.
3. Run **Quarto: Preview Format**.
4. Choose **Typst** or **PDF**.

For a final build without live preview, use **Quarto: Render Document** or run the render command in Positron’s integrated terminal.

## Change the Displayed Name

Edit the YAML front matter at the top of `resume.qmd`:

```yaml
***
title: "Dalton Kutzen"
author: "Dalton Kutzen"
output-file: "Dalton-Kutzen-Resume"
***
```

- `title` controls the name displayed at the top of the document.
- `author` supplies document metadata.
- `output-file` controls the generated PDF filename.

For example:

```yaml
output-file: "Dalton-Kutzen-Bioinformatics-Resume"
```

will generate:

```text
output/Dalton-Kutzen-Bioinformatics-Resume.pdf
```

## Formatting Dates on the Right

Use a raw Typst grid for education, experience, and project headings with dates aligned to the right margin:

````markdown
```{=typst}
#grid(
  columns: (1fr, auto),
  align: (left, right),
  gutter: 0pt,
  [#strong[Brigham Young University — B.S. Molecular Biology]],
  [Expected Apr. 2027],
)
```
````

This produces a layout similar to:

```text
Brigham Young University — B.S. Molecular Biology       Expected Apr. 2027
```

A typical education entry might look like:

````markdown
## Education

```{=typst}
#grid(
  columns: (1fr, auto),
  align: (left, right),
  gutter: 0pt,
  [#strong[Brigham Young University]],
  [Expected Apr. 2027],
)
```

B.S. Molecular Biology · Provo, Utah

- Relevant coursework: molecular biology, genetics, statistics, calculus, and bioinformatics.
````

## Contact Block

For a centered contact block in Typst/PDF output, use raw Typst alignment:

````markdown
```{=typst}
#align(center)[
```

Provo, Utah ·
[dalton@kutzen.org](mailto:dalton@kutzen.org) ·
[GitHub](https://github.com/dkutzen22) ·
[LinkedIn](https://www.linkedin.com/in/daltonkutzen)

```{=typst}
]
```
````

Do not rely on HTML-only CSS such as:

```markdown
style="text-align: center;"
```

when rendering to Typst. Native Typst alignment is more reliable for PDF output.

## Custom Styling

The optional `resume-style.typ` file contains Typst formatting rules. It can control:

- Font family and size
- Margins and page layout
- Heading colors and separator lines
- Link colors
- Paragraph spacing
- List spacing

A minimal example:

```typst
#let accent = rgb("#1F4E79")

#set text(