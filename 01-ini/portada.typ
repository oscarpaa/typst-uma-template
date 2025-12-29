#import "../template.typ": *

#set align(center)

#text(size: 16pt)[UNIVERSIDAD DE MÁLAGA ]
#v(16pt)
#block(width: 100%)[
  #set par(leading: 0.7em) 
  #text(size: 16pt)[ESCUELA TÉCNICA SUPERIOR DE \ INGENIERÍA DE TELECOMUNICACIÓN]
]

#v(2fr)

#text(size: 16pt)[
  #smallcaps[TRABAJO FIN DE MÁSTER]
]

#v(2fr)

// --- TÍTULO ---
#block(width: 80%)[
  #set par(leading: 0.8em)
  #text(size: 24pt)[
    #smallcaps(titlename)
  ]
]

#v(2fr)

// --- TITULACIÓN ---
#block(width: 60%)[
  #set par(leading: 0.7em)
  #text(size: 16pt)[
  #smallcaps[Máster en]
  #smallcaps(titulacion)
]]

#v(2fr) 

// --- AUTOR Y FECHA (Alineado a la derecha) ---
#align(right)[
  #set text(size: 14pt)
  #smallcaps(author) \
  #smallcaps[Málaga, #anno]
]

#chapterend()