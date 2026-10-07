# Dalton Kutzen — Resume & CV

A reproducible resume and academic CV built with [Quarto](https://quarto.org/) and rendered to PDF using [Typst](https://typst.app/).

All biographical and professional content is maintained as structured YAML files in `data/`. The documents are automatically formatted by a shared Typst engine (`formatters.typ`), which aligns dates to the right margin, formats markdown syntax inside bullet points, and suppresses empty sections based on document scoping (`resume` vs `cv`).

---

## Requirements

Install Quarto:
- [Quarto Installation Guide](https://quarto.org/docs/get-started/)

Quarto bundles native Typst support for rendering PDFs without requiring a LaTeX installation.

Verify your installation:
```bash
quarto check
```

---

## Project Structure

```text
.
├── _quarto.yml              # Quarto project configuration
├── resume.qmd               # Resume master document (1-page, industry/lab focused)
├── cv.qmd                   # CV master document (multi-page, academic/research comprehensive)
├── formatters.typ           # Typst layout engine (right-aligned dates, auto-suppression)
├── data/                    # Structured YAML data sources
│   ├── education.yml        # Degrees, coursework, institution
│   ├── experience.yml       # Research, software, and IT roles
│   ├── projects.yml         # Selected projects and repositories
│   ├── publications.yml     # Preprints and journal publications
│   ├── presentations.yml    # Conference talks and poster presentations
│   ├── skills.yml           # Grouped technical competencies table
│   ├── leadership.yml       # Mentorship, civic engagement, initiative leads
│   └── awards.yml           # Scholarships, grants, and honors
├── sections/                # Quarto partials invoking Typst formatters
│   ├── _contact.qmd         # Centered contact block
│   ├── _education.qmd       # Calls #render-education(target: doc-target)
│   ├── _experience.qmd      # Calls #render-experience(target: doc-target)
│   ├── _projects.qmd        # Calls #render-projects(target: doc-target)
│   ├── _skills.qmd          # Calls #render-skills(target: doc-target)
│   ├── _leadership.qmd      # Calls #render-leadership(target: doc-target)
│   ├── _publications.qmd    # Calls #render-publications(target: doc-target)
│   ├── _presentations.qmd   # Calls #render-presentations(target: doc-target)
│   └── _awards.qmd          # Calls #render-awards(target: doc-target)
├── README.md                # Project documentation
└── output/                  # Rendered PDF output
    ├── Dalton_Kutzen-Resume.pdf
    └── Dalton_Kutzen-CV.pdf
```

---

## Rendering Documents

Render both Resume and CV simultaneously:

```bash
quarto render
```

Or render individually:

```bash
quarto render resume.qmd
quarto render cv.qmd
```

Rendered outputs are written to `output/`:
- `output/Dalton_Kutzen-Resume.pdf`
- `output/Dalton_Kutzen-CV.pdf`

---

## Preview in Positron / VS Code

1. Open `resume.qmd` or `cv.qmd`.
2. Open the Command Palette (`Ctrl+Shift+P`).
3. Run **Quarto: Preview Format** and select **Typst** or **PDF**.
4. Edits to any file in `data/` will automatically trigger a live recompile in the preview pane.

---

## How It Works

### 1. Document Scoping (`show_in`)

Each entry in a YAML file can specify which document(s) it belongs to using `show_in`:

```yaml
- title: "Bioinformatics Researcher"
  organization: "Terooatea Lab, Brigham Young University"
  location: "Provo, UT"
  dates: "Aug 2026 – Present"
  show_in: ["resume", "cv"]   # Appears in both
  details:
    - "Developed computational methods for single-cell Perturb-seq screens (`anchor-op`)."

- title: "IT Service Desk Technician"
  organization: "Brigham Young University"
  location: "Provo, UT"
  dates: "Aug 2025 – May 2026"
  show_in: ["cv"]             # Only appears in the CV
  details:
    - "Managed deployment and security across 1,000+ campus workstations."
```

- **`show_in: ["resume", "cv"]`**: Appears in both documents.
- **`show_in: ["cv"]`**: Appears only in the CV.
- **`show_in: ["resume"]`**: Appears only in the Resume.
- *(If omitted, entries default to `["resume", "cv"]`)*.

### 2. Automatic Section Suppression

Both `resume.qmd` and `cv.qmd` include all section partials. If a section has **0 entries scoped to the target document** (for example, if all publications are tagged `show_in: ["cv"]`), the Typst formatter automatically suppresses the section entirely—**no empty heading or whitespace is rendered** on the resume.

### 3. Date Alignment & Typography

The Typst module [`formatters.typ`](formatters.typ) uses responsive two-column grids:

```typst
#grid(
  columns: (1fr, auto),
  align: (left, right),
  [#strong(title)],
  [#date]
)
```

This guarantees dates stay flush with the right margin regardless of title length. Bullet points also support standard Markdown formatting such as `**bold**`, `` `code` ``, and `[links](url)`.

---

## Customizing Layout and Styling

### Margins and Font Sizes

Modify the YAML header in `resume.qmd` or `cv.qmd`:

```yaml
format:
  typst:
    papersize: us-letter
    margin:
      x: 0.62in
      y: 0.55in
    fontsize: 9.5pt
    linkcolor: "#1F4E79"
```

### Changing Output Filenames

In `resume.qmd` or `cv.qmd`:

```yaml
output-file: "Dalton_Kutzen-Resume"
```
