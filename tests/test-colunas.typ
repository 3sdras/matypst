#import "../lib.typ": *

// Teste: colunas
#colunas(quantidade: 3, espacamento: 0.5cm)[
  Primeira coluna com texto de exemplo.

  #quebra-coluna()

  Segunda coluna aqui.

  #quebra-coluna(fraco: true)

  Terceira coluna.
]

#line(length: 100%)

// Teste: grade simples
#grade(
  colunas: (1fr, 1fr),
  borda: 1pt,
  recuo: 5pt,
  [A], [B],
  [C], [D],
)

#v(1em)

// Teste: grade com sub-elementos
#grade(
  colunas: (auto, 1fr, 1fr),
  borda: 0.5pt,
  recuo: 8pt,
  cabecalho-grade(
    celula(preenchimento: luma(220), alinhamento: center)[*\#*],
    celula(preenchimento: luma(220), alinhamento: center)[*Nome*],
    celula(preenchimento: luma(220), alinhamento: center)[*Valor*],
  ),
  [1], [Alpha], [100],
  [2], [Beta],  [200],
  linha-horizontal(borda: 2pt),
  celula(extensao-coluna: 2, alinhamento: right)[*Total:*],
  [300],
)

#v(1em)

// Teste: linha-vertical
#grade(
  colunas: (1fr, 1fr, 1fr),
  recuo: 8pt,
  linha-vertical(x: 1, borda: 1pt + red),
  [Esq], [Centro], [Dir],
)

#v(1em)

// Teste: celula com rowspan/colspan
#grade(
  colunas: (1fr, 1fr, 1fr),
  borda: 0.5pt,
  recuo: 5pt,
  celula(extensao-coluna: 2, preenchimento: luma(240))[Mesclado], [C],
  [1], [2], [3],
)

#v(1em)

// Teste: rodape-grade
#grade(
  colunas: (1fr, 1fr),
  borda: 0.5pt,
  recuo: 5pt,
  [Dado 1], [Dado 2],
  [Dado 3], [Dado 4],
  rodape-grade(
    celula(extensao-coluna: 2, alinhamento: center, preenchimento: luma(230))[_Rodapé da grade_],
  ),
)
