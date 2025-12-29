#import "../template.typ": *

#show heading: none
#heading(level: 1, numbering: none)[Resumen]

#smallcaps(align(center)[E.T.S. de Ingeniería de Telecomunicación, Universidad de Málaga])

#v(25pt)
#text(
  size: 16pt, 
  tracking: 0.6pt
)[
  #set par(leading: 0.7em)
  #set align(center)
  #strong[#smallcaps(titlename)]
]

#v(25pt)
#block(width: 100%)[
  #set par(first-line-indent: 0pt)
  *Autor:* #author
  #v(0.2em)
  *Tutor:* #tutor
  #v(0.2em)
  *Departamento:* \<DEPARTAMENTO>
  #v(0.2em) 
  *Titulación:* Máster en #titulacion
  #v(0.2em) 
  *Palabras clave:* 
]
#v(25pt)
#align(center)[*Resumen*]
#v(9pt)

#lorem(30)

#chapterend()
