// formatters.typ - Reusable Typst layout and YAML rendering engine

#let doc-target = "resume"

#let md(text-str) = {
  if type(text-str) != str { return text-str }
  let s = text-str
  // Replace markdown **bold** with Typst *bold*
  s = s.replace(regex("\*\*([^*]+)\*\*"), m => "*" + m.captures.at(0) + "*")
  // Replace markdown `code` with Typst `code`
  s = s.replace(regex("`([^`]+)`"), m => "`" + m.captures.at(0) + "`")
  // Replace markdown [text](target_url) with Typst link
  s = s.replace(regex("\[([^\]]+)\]\(([^)]+)\)"), m => "#link(\"" + m.captures.at(1) + "\")[" + m.captures.at(0) + "]")
  eval(s, mode: "markup")
}

// Formats an experience, project, or role entry with right-aligned dates
#let cv-entry(
  title: "",
  organization: "",
  location: "",
  date: "",
  details: (),
  url: none,
) = {
  grid(
    columns: (1fr, auto),
    align: (left, right),
    gutter: 0pt,
    [
      #if url != none and url != "" [
        #strong(link(url)[#title])
      ] else [
        #strong(title)
      ]
    ],
    [
      #if date != "" [
        #text(fill: luma(60))[#date]
      ]
    ]
  )
  if organization != "" or location != "" {
    v(-4pt)
    text(fill: rgb("#1F4E79"))[
      #if organization != "" [#organization]
      #if organization != "" and location != "" [ · ]
      #if location != "" [#text(fill: luma(80))[#location]]
    ]
  }
  if details != () and details.len() > 0 {
    v(-3pt)
    list(..details.map(d => [#md(d)]))
  }
  v(3pt)
}

// Render Education entries
#let render-education(
  heading: "Education",
  path: "data/education.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  for item in filtered {
    grid(
      columns: (1fr, auto),
      align: (left, right),
      gutter: 0pt,
      [
        #strong[#item.institution — #item.degree]
      ],
      [
        #text(fill: luma(60))[#item.dates]
      ]
    )
    if "location" in item and item.location != "" {
      v(-4pt)
      text(fill: rgb("#1F4E79"))[#item.location]
    }
    if "details" in item and item.details != none and type(item.details) == array and item.details.len() > 0 {
      v(-3pt)
      list(..item.details.map(d => [#md(d)]))
    }
    v(3pt)
  }
}

// Render Experience entries with target filtering (resume vs cv)
#let render-experience(
  heading: "Experience",
  path: "data/experience.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  for item in filtered {
    cv-entry(
      title: item.title,
      organization: item.at("organization", default: ""),
      location: item.at("location", default: ""),
      date: item.at("dates", default: ""),
      details: item.at("details", default: ()),
      url: item.at("link", default: none),
    )
  }
}

// Render Projects with target filtering
#let render-projects(
  heading: "Selected Projects",
  path: "data/projects.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  for item in filtered {
    cv-entry(
      title: item.name,
      date: item.at("dates", default: ""),
      details: item.at("details", default: ()),
      url: item.at("link", default: none),
    )
  }
}

// Render Leadership & Service entries
#let render-leadership(
  heading: "Leadership & Service",
  path: "data/leadership.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  for item in filtered {
    cv-entry(
      title: item.title,
      organization: item.at("organization", default: ""),
      location: item.at("location", default: ""),
      date: item.at("dates", default: ""),
      details: item.at("details", default: ()),
      url: item.at("link", default: none),
    )
  }
}

// Render Publications
#let render-publications(
  heading: "Publications & Preprints",
  path: "data/publications.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  for item in filtered {
    [
      - #md(item.authors) (#item.year). #item.title. #emph(item.venue).
        #if "link" in item and item.link != "" [
          [#link(item.link)[#item.at("code_repo", default: "Code")]]
        ]
    ]
  }
}

// Render Presentations
#let render-presentations(
  heading: "Presentations & Posters",
  path: "data/presentations.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  for item in filtered {
    [
      - #strong(item.presenter) (#item.dates). #emph(item.title). #item.type, #item.event, #item.location.
    ]
  }
}

// Render Skills table
#let render-skills(
  heading: "Technical Skills",
  path: "data/skills.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  table(
    columns: (auto, 1fr),
    stroke: none,
    align: (left, left),
    table.hline(stroke: 0.5pt + luma(180)),
    table.header([*Area*], [*Tools & Proficiencies*]),
    table.hline(stroke: 0.8pt + luma(120)),
    ..filtered.map(row => (
      [*#row.category*],
      [#row.skills]
    )).flatten(),
    table.hline(stroke: 0.5pt + luma(180))
  )
}

// Render Awards
#let render-awards(
  heading: "Honors & Awards",
  path: "data/awards.yml",
  target: doc-target,
) = {
  let entries = yaml(path)
  if entries == none or type(entries) != array { return }
  let filtered = entries.filter(item => {
    let show-in = item.at("show_in", default: ("resume", "cv"))
    show-in.contains(target)
  })
  if filtered.len() == 0 { return }

  if heading != none and heading != "" [
    #heading(level: 1)[#heading]
  ]
  for item in filtered {
    grid(
      columns: (1fr, auto),
      align: (left, right),
      gutter: 0pt,
      [
        - #strong(item.name), #item.institution
      ],
      [
        #text(fill: luma(60))[#item.dates]
      ]
    )
  }
}
