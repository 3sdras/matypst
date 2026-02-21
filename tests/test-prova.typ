#import "../lib.typ": *

#set page(paper: "a4", margin: 2cm)
#set text(size: 12pt, lang: "pt")

#cabecalho-prova(
  instituicao: "Universidade Federal de Jataí",
  disciplina: "Cálculo I",
  professor: "Prof. Dr. Esdras Costa",
  data: "21/02/2026",
  titulo: "1ª Prova",
  campos: ("Nome", "Matrícula", "Turma"),
  instrucoes: [
    - Prova individual, sem consulta.
    - Apresente todos os cálculos.
    - Duração: 2 horas.
  ],
)

#questao(pontos: 2.5)[
  Calcule o limite:
  $ lim_(x -> 0) (sin x) / x $
  #espaco-resposta(altura: 5cm)
]

#questao[
  Derive as seguintes funções:
  #subquestao(pontos: 1.5)[$f(x) = x^3 + 2x$]
  #preencher-linhas(altura: 3cm)
  #subquestao(pontos: 1.5)[$g(x) = ln(x^2 + 1)$]
  #preencher-linhas(altura: 3cm)
]

#questao(pontos: 1.5)[
  Marque V (verdadeiro) ou F (falso):
  #verdadeiro-falso(
    [Toda função contínua é derivável.],
    [Toda função derivável é contínua.],
    [$lim_(x -> a) f(x) = f(a)$ para toda função $f$.],
  )
]

#questao(pontos: 2.0)[
  Qual alternativa apresenta a derivada de $f(x) = e^(2x)$?
  #alternativas(
    [$f'(x) = e^(2x)$],
    [$f'(x) = 2e^(2x)$],
    [$f'(x) = 2x e^(2x)$],
    [$f'(x) = e^(2)$],
  )
]

#questao(pontos: 1.0)[
  Esboce o gráfico de $f(x) = x^2 - 4$:
  #preencher-grade(altura: 5cm, celula: 0.5cm)
]

// ── Edge cases ──

#questao[
  Questão sem pontos (deve funcionar normalmente).
  #preencher-pontilhado(altura: 2cm)
]

#questao(pontos: 0.5)[
  Alternativas horizontais com 2 colunas:
  #alternativas(
    [$2$],
    [$4$],
    [$6$],
    [$8$],
    horizontal: true,
    colunas: 2,
  )
]

#questao(pontos: 1)[
  V/F com marcador de caixa:
  #verdadeiro-falso(
    marcador: "caixa",
    [A Terra é plana.],
    [O sol é uma estrela.],
  )
]

#questao(pontos: 0.5)[
  Alternativas com checkbox:
  #alternativas(
    marcador: "caixa",
    [Sim],
    [Não],
    [Talvez],
  )
]

#questao(pontos: 1.0, separador: false, negrito: false)[
  Questão sem separador e sem negrito:
  #espaco-resposta(altura: 2cm, borda: "completa")
]

#questao(pontos: 0.5)[
  Espaço com borda pontilhada:
  #espaco-resposta(altura: 2cm, borda: "pontilhada")
]

#v(1fr)
#total-pontos()
#v(0.5em)
#tabela-pontos()
