#import "../template.typ": *

#show heading: none
#heading(level: 1, numbering: none)[Abstract]

#smallcaps(align(center)[E.T.S. de Ingeniería de Telecomunicación, Universidad de Málaga])

#v(25pt)
#text(
  size: 16pt, 
  tracking: 0.6pt
)[
  #set par(leading: 0.7em)
  #set align(center)
  #strong[#smallcaps(titlenameENG)]
]

#v(25pt)
#block(width: 100%)[
  #set par(first-line-indent: 0pt)
  *Author:* #author
  #v(0.2em)
  *Supervisor:* #tutor
  #v(0.2em)
  *Department:* \<DEPARTAMENTO>
  #v(0.2em) 
  *Degree:* Master's Degree in \<TITULACIÓN>
  #v(0.2em) 
  *Keywords:* 
]
#v(25pt)
#align(center)[*Abstract*]
#v(9pt)

#lorem(30)

#chapterend()
