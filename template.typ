
// PARAMETROS DE LA PLANTILLA
#let titlename = "<TÍTULO DEL TRABAJO>"
#let titlenameENG = "<TÍTULO DEL TRABAJO EN INGLÉS>"
#let author = "<AUTOR>"
#let tutor = "<TUTOR>"
#let titulacion = "<TITULACIÓN>"
#let anno = "202X"

// Función para citar acrónimos
#let acr(sigla) = {
  let sigla_str = sigla.text
  link(label("acr_" + sigla_str))[#sigla]
}

#let hide_header = state("hide_header", false)
#let chapterend() = {
  hide_header.update(true)
  pagebreak(to: "odd", weak: false)
  hide_header.update(false)
}

#let section-type = state("section-type", "Capítulo")

#let index_style(doc) = {
  show outline.entry: it => {
    let is_heading_l1 = it.level == 1 and it.element.func() == heading
    let is_figure = it.element.func() == figure

    if is_heading_l1 {
      v(1.8em, weak: true)
      set par(first-line-indent: 0pt)
      let number = if it.element.numbering != none {
        context {
          box(width: 0.9em)[
            #numbering(it.element.numbering, ..counter(heading).at(it.element.location()))
          ]
        }
      }
      strong(link(it.element.location())[#number #it.element.body #h(1fr) #it.page()])
    } else if is_figure {
      v(1em, weak: true)
      context {
        let loc = it.element.location()
        let fig_item = it.element

        let before = query(heading.where(level: 1).before(loc))
        let ch_prefix = if before.len() > 0 {
          let last_h = before.last()
          if (last_h.numbering == none) {return}
          numbering(last_h.numbering, ..counter(heading).at(last_h.location()))
        }
        let n = counter(figure.where(kind: fig_item.kind)).at(loc).first()

        link(loc)[
          #set par(first-line-indent: 0pt)
          #fig_item.supplement #ch_prefix.#n #h(0.5em) #it.inner()
        ]
      }
    } else {
      v(1em, weak: true)
      it
    }
  }
  doc
}



#let project(body) = {
  set page(
    paper: "a4",
    margin: (
      left: 3cm,
      right: 3cm,
      top: 3.5cm,
      bottom: 5.5cm,
    ),
    header: context {
      let current_page = here().page()
      if hide_header.at(here()) == true { return }

      let all_h1 = query(heading.where(level: 1))
      let is_start_of_ch = all_h1.any(h => h.location().page() == current_page)
      let chapters_before = query(heading.where(level: 1).before(here()))

      if chapters_before.len() > 0 and not is_start_of_ch {
        let is_odd = calc.odd(current_page)
        let current_chapter = chapters_before.last()
        let has_numbering = current_chapter.numbering != none
        let ch_num = counter(heading).at(current_chapter.location()).first()

        if is_odd {
          let all_sections = query(heading.where(level: 2))
          let sections_in_page = all_sections.filter(s => s.location().page() == current_page)
          let section_text = ""

          if sections_in_page.len() > 0 {
            let s = sections_in_page.first()
            section_text = numbering(s.numbering, ..counter(heading).at(s.location())) + "  " + s.body
          } else {
            let sections_before = all_sections.filter(s => s.location().page() < current_page)

            if sections_before.len() > 0 {
              let last_s = sections_before.last()
              let is_from_current_ch = (
                (last_s.location().page() > current_chapter.location().page())
                  or (
                    last_s.location().page() == current_chapter.location().page()
                      and last_s.location().position().y > current_chapter.location().position().y
                  )
              )

              if is_from_current_ch {
                section_text = (
                  numbering(last_s.numbering, ..counter(heading).at(last_s.location())) + "  " + last_s.body
                )
              } else {
                section_text = current_chapter.body
              }
            } else {
              section_text = current_chapter.body
            }
          }

          grid(
            columns: (1fr, auto),
            align(left, section_text), align(right, counter(page).display()),
          )
        } else {
          grid(
            columns: (auto, 1fr),
            align(left, counter(page).display()),
            align(right, context {
              let type = section-type.at(here())
              let num = if has_numbering {
                numbering(current_chapter.numbering, ..counter(heading).at(current_chapter.location()))
              }

              if has_numbering {
                [#type #num. #current_chapter.body]
              } else {
                [#current_chapter.body]
              }
            }),
          )
        }
        v(-0.6em)
        line(length: 100%, stroke: 0.8pt)
        v(-0.3em)
      }
    },
    footer: context {
      let current_page = here().page()
      let all_h1 = query(heading.where(level: 1))

      let is_start_of_ch = all_h1.any(h => h.location().page() == current_page)

      if is_start_of_ch {
        v(-0.7cm)
        set align(center)
        counter(page).display()
      }
    },
  )

  set text(font: "Arial", size: 12pt, lang: "es")
  set par(
    justify: true,
    leading: 0.5em,
    spacing: 0.91em,
    first-line-indent: (amount: 1.5em, all: true),
  )

  set heading(numbering: "1.1")

  set figure(
    numbering: n => context {
      let before = query(heading.where(level: 1).before(here()))

      if before.len() > 0 {
        let last_h = before.last()
        let h_counter = counter(heading).at(last_h.location())

        if last_h.numbering != none {
          let ch_prefix = numbering(last_h.numbering, ..h_counter)
          [#ch_prefix.#n]
        } else {
          [#n]
        }
      } else {
        [#n]
      }
    },
  )

  show figure: it => {
    v(0.8em)
    it
    v(0.8em)
  }

  show heading: it => {
    set par(first-line-indent: 0pt)
    if it.level == 1 {
      counter(figure.where(kind: image)).update(0)
      counter(figure.where(kind: table)).update(0)

      pagebreak(weak: true)
      v(2.4cm)
      set text(size: 25pt, weight: "bold")

      if it.numbering != none {
        let type = section-type.at(it.location())
        let num = numbering(it.numbering, ..counter(heading).at(it.location()))

        [#type #num]
        v(0.1cm)
        block(it.body)
      } else {
        block(it.body)
      }
      v(1.2cm)
    } else if it.level == 2 {
      v(0.8em)
      set text(size: 17pt, weight: "bold")
      it
      v(0.4em)
    } else if it.level == 3 {
      v(0.4em)
      set text(size: 14pt, weight: "bold")
      it
      v(0.2em)
    } else {
      it
    }
  }

  body
}

#let appendices(doc) = {
  counter(heading).update(0)
  set heading(numbering: "A.1")
  show heading.where(level: 1): it => {
    section-type.update("Apéndice")
    it
  }

  doc
}

#let minitoc() = context {
  let current_loc = here()
  let chapters_before = query(heading.where(level: 1).before(current_loc))
  if chapters_before.len() == 0 { return }

  let current_ch = chapters_before.last()
  let chapters_after = query(heading.where(level: 1).after(current_loc))
  let next_ch_loc = if chapters_after.len() > 0 { chapters_after.first().location() } else { none }

  v(0.5em)
  set par(first-line-indent: 0pt)
  text(size: 14pt, weight: "bold")[Contenido]
  v(-0.7em)
  line(length: 100%, stroke: 0.4pt)
  v(-0.4em)

  set text(size: 11pt)

  pad(left: 2em)[
    #block(width: 95%, breakable: true)[
      #set align(left)
      #show outline.entry: it => {
        let it_loc = it.element.location()
        let is_after_start = (
          it_loc.position().page > current_ch.location().position().page
            or (
              it_loc.position().page == current_ch.location().position().page
                and it_loc.position().y >= current_ch.location().position().y
            )
        )

        let is_before_next = if next_ch_loc != none {
          (
            it_loc.position().page < next_ch_loc.position().page
              or (
                it_loc.position().page == next_ch_loc.position().page and it_loc.position().y < next_ch_loc.position().y
              )
          )
        } else { true }

        if is_after_start and is_before_next and it.level > 1 {
          v(0.45em, weak: true)
          if it.level == 2 {
            strong(it)
          } else {
            it
          }
        } else {
          none
        }
      }

      #outline(
        title: none,
        target: heading.where(level: 2).or(heading.where(level: 3)),
      )
    ]
  ]

  v(-0.3em)
  line(length: 100%, stroke: 0.4pt)
}
