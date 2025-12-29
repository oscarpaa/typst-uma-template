#import "../template.typ": *

= Código
#minitoc()

#lorem(10)

== Estructura de carpetas
Aquí se detalla la jerarquía del proyecto como se menciona en @Intel4004

#figure(
  rect(
    width: 4cm,
    height: 3cm,
    fill: blue,
    radius: 2pt // Opcional: bordes ligeramente redondeados
  ),
  caption: [Este es un rectángulo azul],
)


#figure(
  table(
    columns: 2,
    align: center + horizon,
    [A], [A],
    [B], [B],
  ),
  caption: [Título TABLA], 
)

#chapterend()
