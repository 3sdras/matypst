// Breve Introdução ao FerrMat
// Documentação do pacote FerrMat
// Caixas decorativas, ambientes matemáticos e código estilizado para Typst
// Adaptado de "Breve Introdução ao LaTeX 2ε" de Lenimar Nunes de Andrade

#import "../lib.typ": *

// --- Setup standalone (sem dependência do ABNTyp) ---

#set document(title: "Breve Introdução ao FerrMat", author: "FerrMat")

#set page(paper: "a4", margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm))

#set text(font: "Times New Roman", size: 12pt, lang: "pt", region: "BR")

#set par(leading: 1.5em * 0.65, justify: true, first-line-indent: (amount: 1.25cm, all: true))

#set list(indent: 2em, body-indent: 0.5em)
#set enum(indent: 2em, body-indent: 0.5em)
#set terms(indent: 0em, hanging-indent: 2em, separator: [: ])

#set heading(numbering: "1.1")

#show heading.where(level: 1): it => {
  pagebreak(weak: true)
  v(1.5em)
  text(weight: "bold", size: 14pt)[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #upper(it.body)
  ]
  v(1.5em)
}

#show heading.where(level: 2): it => {
  v(1.5em)
  text(weight: "regular", size: 12pt)[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #upper(it.body)
  ]
  v(1.5em)
}

#show heading.where(level: 3): it => {
  v(1.5em)
  text(weight: "bold", size: 12pt)[
    #if it.numbering != none {
      counter(heading).display()
      h(0.5em)
    }
    #it.body
  ]
  v(1em)
}

#show heading: set par(first-line-indent: 0pt)
#show figure: set par(first-line-indent: 0pt)
#show raw.where(block: true): set par(first-line-indent: 0pt)
#show outline: set par(first-line-indent: 0pt)
#show terms: set par(first-line-indent: 0pt)

#set footnote.entry(separator: line(length: 5cm, stroke: 0.5pt))

// Latex escrito como LaTeX
#let LaTeX = {
  [L]
  h(-0.1em)
  text(baseline: -0.2em, size: 0.7em)[A]
  h(-0.1em)
  [T]
  h(-0.1em)
  text(baseline: 0.2em)[E]
  h(-0.1em)
  [X]
}

#show "LaTeX": LaTeX

// Função auxiliar para exemplos numerados
// Usa nome diferente de `exemplo` para evitar colisão com o ambiente matemático do FerrMat
// NOTA: cada exemplo aparece 2x (raw + chamada real) porque eval() em Typst não herda
// imports do módulo. Ao editar exemplos, manter ambas as cópias sincronizadas.
#let exemplo-doc-counter = counter("exemplo-doc")

#let exemplo-doc(body) = {
  exemplo-doc-counter.step()
  block(
    width: 100%,
    inset: 1em,
    stroke: (left: 2pt + gray),
    fill: luma(245),
  )[
    #set par(first-line-indent: 0pt)
    #text(weight: "bold")[Exemplo #context exemplo-doc-counter.display():]
    #body
  ]
}

// ============================================================================
// CAPA
// ============================================================================

#align(center)[
  #v(2cm)

  #text(size: 14pt)[Breve Introdução ao]

  #v(0.5cm)

  #text(size: 36pt, weight: "bold")[FerrMat]

  #v(0.5cm)

  #text(size: 14pt)[Caixas Decorativas, Ambientes Matemáticos]

  #text(size: 14pt)[e Código Estilizado para Typst]

  #v(3cm)

  #text(size: 12pt)[
    versão 0.1 -- Janeiro/2026
  ]

  #v(1fr)
]

#pagebreak()

// ============================================================================
// SUMÁRIO
// ============================================================================

// Formatação do sumário conforme NBR 6024/6027
// Nível 1: MAIÚSCULAS + negrito
#show outline.entry.where(level: 1): it => {
  v(1em)
  block[
    #link(it.element.location())[
      #text(weight: "bold")[#upper(it.body())]
      #box(width: 1fr, it.fill)
      #it.page()
    ]
  ]
}

// Nível 2: MAIÚSCULAS (normal)
#show outline.entry.where(level: 2): it => {
  block[
    #link(it.element.location())[
      #h(1em)
      #upper(it.body())
      #box(width: 1fr, it.fill)
      #it.page()
    ]
  ]
}

// Nível 3: Minúsculas + negrito
#show outline.entry.where(level: 3): it => {
  block[
    #link(it.element.location())[
      #h(2em)
      #text(weight: "bold")[#it.body()]
      #box(width: 1fr, it.fill)
      #it.page()
    ]
  ]
}

#align(center)[
  #text(weight: "bold", size: 12pt, "SUMÁRIO")
]
#v(1.5em)
#outline(title: none, depth: 3, indent: auto)
#pagebreak()

// ============================================================================
// PREFÁCIO
// ============================================================================

#heading(level: 1, numbering: none, upper[Prefácio])

Estas notas são uma adaptação do trabalho original "Uma breve introdução ao $"LaTeX" 2 epsilon$", de Lenimar Nunes de Andrade, para o caso do Typst, com o objetivo de servir de material didático para a disciplina "Software Livre para digitação de textos matemáticos" na UFJ.

O *FerrMat* é um pacote companheiro do ABNTyp, fornecendo utilitários genéricos para Typst que não dependem de normas ABNT: caixas decorativas, ambientes matemáticos com numeração automática, estilização de código e funções matemáticas em português.

Enquanto o ABNTyp cuida da formatação conforme normas ABNT (capa, folha de rosto, citações, referências), o FerrMat oferece componentes visuais e matemáticos que podem ser usados em qualquer documento Typst --- com ou sem ABNTyp.

O Capítulo 1 introduz os conceitos básicos do Typst e do FerrMat. O Capítulo 2 cobre as caixas decorativas (`caixa` e `caixa-estilo`). O Capítulo 3 trata da estilização de código (`codigo-inline` e `codigo-bloco`).

O Capítulo 4 apresenta os fundamentos do modo matemático em Typst. O Capítulo 5 apresenta as funções matemáticas em português: letras gregas, frações, raízes, derivadas, integrais, matrizes e delimitadores. O Capítulo 6 cobre os ambientes matemáticos (teoremas, definições, demonstrações) com numeração configurável e estilos visuais. O Capítulo 7 aborda diagramas e gráficos com os pacotes `fletcher`, `cetz` e `cetz-plot`.

O Apêndice A contém tabelas de referência para todos os símbolos matemáticos em português fornecidos pelo FerrMat.

#v(1cm)

#align(right)[
  Jataí, janeiro de 2026

  _Equipe FerrMat_
]

#pagebreak()

// ============================================================================
// CAPÍTULO 1: O QUE É O MATYPST
// ============================================================================

#counter(page).update(1)
#set page(numbering: "1", number-align: bottom + center)

= Conceitos Básicos

== Introdução ao Typst

O Typst é um sistema de composição tipográfica moderno, criado em 2019 por Laurenz Mädje e Martin Haug na Universidade Técnica de Berlim. Diferente do LaTeX, que foi desenvolvido na década de 1980, o Typst foi projetado desde o início para ser mais acessível e intuitivo.

Um documento em Typst é formado pelo texto propriamente dito, mais alguns comandos e funções. Os comandos em Typst iniciam com `#` ('jogo da velha' ou cerquilha), diferente do \ LaTeX que usa `\` (barra invertida).

Ao contrário de processadores de texto como o Microsoft Word, o texto em Typst não é digitado na forma como vai ser impresso (WYSIWYG). O texto é digitado com marcações, similar ao Markdown ou HTML. Por exemplo, $sqrt(2)$ é digitado como `$sqrt(2)$` e a letra grega $pi$ é digitada como `$pi$`.

As principais vantagens do Typst sobre o LaTeX são:

- *Compilação instantânea*: O Typst compila documentos em milissegundos, permitindo visualização em tempo real
- *Sintaxe mais simples*: Comandos mais intuitivos e menos verbosos
- *Mensagens de erro claras*: Erros são indicados com precisão e explicações úteis
- *Instalação fácil*: Um único executável, sem dependências complexas
- *Webapp disponível*: Pode ser usado diretamente no navegador sem instalar nada

== O que é o FerrMat

O FerrMat é um pacote para Typst que fornece três funcionalidades principais:

+ *Caixas decorativas* --- blocos visuais configuráveis com título, cor, borda e estilos reutilizáveis (similar ao `tcolorbox` do LaTeX).

+ *Estilização de código* --- formatação de código inline e em bloco, com título, numeração de linhas e destaque de sintaxe.

+ *Matemática em português* --- operadores (`sen`), letras gregas (`alfa`, `gama`, `teta`), frações (`fracao`), raízes (`raiz`), derivadas (`leibniz`, `parcial`), integrais, matrizes, delimitadores, vetores e ambientes matemáticos (teoremas, definições, demonstrações) com numeração automática.

O FerrMat é o pacote companheiro do ABNTyp, mas não depende dele. Pode ser usado em qualquer documento Typst.

== Usando o Typst

=== typst.app (webapp online)

A forma mais fácil de começar com Typst é usando o webapp online em #link("https://typst.app")[typst.app]. Não é necessário instalar nada --- basta criar uma conta gratuita e começar a escrever.

O webapp oferece:
- Editor com destaque de sintaxe
- Visualização em tempo real do PDF
- Armazenamento na nuvem
- Colaboração em tempo real (similar ao Google Docs)
- Acesso a pacotes da comunidade

Para usar o FerrMat no webapp, basta importar o pacote no início do documento:

#raw(block: true, lang: "typst", "#import \"@preview/ferrmat:0.1.0\": *")

=== Instalação local (CLI)

Para trabalhar offline ou em projetos maiores, você pode instalar o Typst localmente. O Typst está disponível para Windows, macOS e Linux.

/ Windows (via winget):
#raw(block: true, lang: "bash", "winget install --id Typst.Typst")

/ MacOS (via Homebrew):
#raw(block: true, lang: "bash", "brew install typst")

/ Linux (via pacotes):
#raw(block: true, lang: "bash", "# Arch Linux
pacman -S typst

# Ubuntu/Debian (via cargo)
cargo install typst-cli")

Para compilar um documento, use:
#raw(block: true, lang: "bash", "typst compile documento.typ")

Para compilar e assistir mudanças em tempo real:
#raw(block: true, lang: "bash", "typst watch documento.typ")

=== Editores e extensões

O Typst pode ser editado em qualquer editor de texto, mas alguns oferecem suporte especial:

/ Neovim:
- Instale o plugin `tinymist` para LSP completo, destaque de sintaxe e autocompletar
- Visualização em tempo real integrada

/ Visual Studio Code:
- Instale a extensão "Tinymist Typst" para LSP e destaque de sintaxe
- Instale a extensão "Typst Preview" para visualização em tempo real

/ Outros editores:
- Emacs: modo `typst-mode`
- Sublime Text: pacote "Typst"

=== Um exemplo simples

Vejamos o documento Typst mais simples possível:

#exemplo-doc[
  #raw(block: true, lang: "typst", "Olá, mundo!")
]

Este código acima produz um documento de uma página contendo apenas "Olá, mundo!".

Para um documento usando FerrMat, o exemplo mínimo seria:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/ferrmat:0.1.0\": *

#set page(paper: \"a4\", margin: 2cm)
#set text(lang: \"pt\", size: 12pt)

= Meu documento

#caixa(titulo: \"Nota\", cor: azul)[
  Uma caixa decorativa.
]

$sen(x)$, $fracao(a, b)$, $raiz(2)$

#definicao[Um anel é um conjunto munido de duas operações...]")
]

Para usar o FerrMat junto com o ABNTyp:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/abntyp:0.1.0\": *
#import \"@preview/ferrmat:0.1.0\": *

#show: abntcc.with(
  titulo: \"Meu TCC\",
  autor: \"Fulano de Tal\",
  // ...
)

#definicao[Um grupo é um conjunto $G$ munido de uma operação...]
#teorema(titulo: [de Lagrange])[Se $H$ é subgrupo de $G$...]")
]

== Estrutura de um documento Typst

Um documento Typst pode ser dividido em três partes:

1. *Preâmbulo (opcional)*: Importações de pacotes e definições de funções
2. *Configuração (opcional)*: Comandos `#set` e `#show` que definem formatação
3. *Conteúdo*: O texto propriamente dito

#exemplo-doc[
  #raw(block: true, lang: "typst", "// 1. Preâmbulo (importações)
#import \"@preview/ferrmat:0.1.0\": *

// 2. Configuração
#set page(paper: \"a4\", margin: 2cm)
#set text(font: \"Times New Roman\", size: 12pt)
#set par(justify: true)

// 3. Conteúdo
= Introdução

Texto do documento...")
]

== Tipos e tamanhos de letras

O Typst oferece várias formas de alterar o estilo do texto. A @tab:estilos-m resume os principais estilos disponíveis, a @tab:tamanhos-m mostra como alterar o tamanho e, em seguida, apresentamos como trocar a fonte.

=== Estilos de texto

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Resultado*],
    table.hline(stroke: 0.5pt),
    [`*negrito*`], [*negrito*],
    [`_itálico_`], [_itálico_],
    [`*_negrito itálico_*`], [*_negrito itálico_*],
    [#raw("`código`")], [`código`],
    [`#underline[sublinhado]`], [#underline[sublinhado]],
    [`#strike[riscado]`], [#strike[riscado]],
    [`#smallcaps[Versalete]`], [V#text(size: 0.8em)[ERSALETE]],
    table.hline(stroke: 1pt),
  ),
  caption: [Estilos de texto em Typst],
  kind: table,
) <tab:estilos-m>

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)
  *Observação sobre versalete:* A função `#smallcaps` do Typst depende de a fonte possuir suporte nativo a small caps (feature OpenType "smcp"). Fontes como Times New Roman não possuem esse recurso. Para garantir versalete em qualquer fonte, pode-se criar uma função que simula o efeito:

  #raw(block: true, lang: "typst", "#let versalete(texto) = {
  let chars = texto.clusters()
  if chars.len() > 0 {
    chars.first()
    text(size: 0.8em, upper(chars.slice(1).join()))
  }
}

// Uso: #versalete(\"Texto em Versalete\")")
]

=== Tamanhos de texto

#figure(
  table(
    columns: (1fr, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Resultado*],
    table.hline(stroke: 0.5pt),
    [`#text(size: 8pt)[pequeno]`], [#text(size: 8pt)[pequeno]],
    [`#text(size: 10pt)[menor]`], [#text(size: 10pt)[menor]],
    [`#text(size: 12pt)[normal]`], [#text(size: 12pt)[normal]],
    [`#text(size: 14pt)[maior]`], [#text(size: 14pt)[maior]],
    [`#text(size: 18pt)[grande]`], [#text(size: 18pt)[grande]],
    table.hline(stroke: 1pt),
  ),
  caption: [Tamanhos de texto em Typst],
  kind: table,
) <tab:tamanhos-m>

=== Fontes

Para alterar a fonte de todo o documento, use `#set text(font: ...)`. Para alterar pontualmente, use `#text(font: ...)[...]`:

#raw(block: true, lang: "typst", "#set text(font: \"Arial\")  // Todo o documento em Arial

#text(font: \"Courier New\")[Texto em Courier]")

== Parágrafos e espaçamentos

Em Typst, um novo parágrafo é criado deixando uma linha em branco, assim como no LaTeX e Markdown:

#exemplo-doc[
  #raw(block: true, lang: "typst", "Este é o primeiro parágrafo. Ele continua
na mesma linha porque não há linha em branco.

Este é o segundo parágrafo, pois há
uma linha em branco acima.")
]

Para configurar o espaçamento entre linhas e o recuo de parágrafo:

#raw(block: true, lang: "typst", "#set par(
  leading: 0.65em,           // Espaçamento entre linhas (padrão ≈ 1,5)
  spacing: 0.65em,           // Espaço entre parágrafos
  first-line-indent: (amount: 1.25cm, all: true), // Recuo da primeira linha
  justify: true,             // Texto justificado
)")

#block(
  width: 100%,
  inset: 1em,
  stroke: 0.5pt + gray,
  radius: 3pt,
)[
  #set text(size: 10pt)
  #set par(first-line-indent: 0pt)
  *Observação sobre indentação no Brasil:* Por padrão, o Typst não indenta o primeiro parágrafo após um título --- seguindo a convenção tipográfica anglo-saxônica, conhecida em editoração portuguesa como "composição à inglesa". No entanto, no Brasil, a norma ABNT é indentar _todos_ os parágrafos, inclusive o primeiro. Para isso, é necessário usar `first-line-indent` com o parâmetro `all: true`:

  #raw(block: true, lang: "typst", "// Indenta TODOS os parágrafos (padrão brasileiro)
#set par(first-line-indent: (amount: 1.25cm, all: true))

// Comportamento padrão do Typst (NÃO indenta o primeiro parágrafo)
#set par(first-line-indent: 1.25cm)")

  *Atenção:* ao usar `all: true`, evite `#show raw: set par(first-line-indent: 0pt)` --- essa regra genérica quebra o fluxo de código inline (backticks), forçando-o para linhas separadas. Use `#show raw.where(block: true): set par(first-line-indent: 0pt)` para excluir apenas blocos de código da indentação, sem afetar o inline.
]

Para forçar uma quebra de linha sem iniciar novo parágrafo, use `\`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "Primeira linha \\
Segunda linha (mesmo parágrafo)")
]

== Comentários

Comentários são trechos de texto ignorados na compilação. São úteis para anotações e organização do código:

#raw(block: true, lang: "typst", "// Isto é um comentário de linha única

/* Isto é um comentário
   de múltiplas linhas */

Texto normal // comentário ao final da linha")

== Compilação e visualização

Ao usar o typst.app, a compilação e visualização são automáticas. Ao usar o CLI:

#figure(
  table(
    columns: (auto, 1fr),
    stroke: none,
    inset: 8pt,
    table.hline(stroke: 1pt),
    [*Comando*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`typst compile doc.typ`], [Compila uma vez, gera `doc.pdf`],
    [`typst watch doc.typ`], [Compila e fica observando mudanças],
    [`typst compile doc.typ -o saida.pdf`], [Especifica nome do arquivo de saída],
    [`typst fonts`], [Lista fontes disponíveis],
    table.hline(stroke: 1pt),
  ),
  caption: [Comandos do Typst CLI],
  kind: table,
)

#pagebreak()

// ============================================================================
// CAPÍTULO 2: CAIXAS DECORATIVAS
// ============================================================================

= Caixas Decorativas

O FerrMat fornece duas funções para criar blocos visuais: `caixa()` para uso direto e `caixa-estilo()` para criar estilos reutilizáveis.

== Caixa básica

A função `caixa()` cria um bloco visual com fundo colorido e borda configurável:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#caixa[Este é o estilo padrão: borda esquerda azul.]")
]

#caixa[Este é o estilo padrão: borda esquerda azul.]

=== Parâmetros

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`titulo`], [`nenhum`], [Título da caixa (exibido em barra superior)],
    [`cor`], [`azul`], [Cor principal (borda e fundo derivado); veja @tab:cores],
    [`borda`], [`"esquerda"`], [Posição da borda: `"esquerda"`, `"topo"`, `"completa"` ou `"nenhuma"`],
    [`espessura`], [`2pt`], [Espessura da borda],
    [`raio`], [`0pt`], [Raio dos cantos arredondados],
    [`preenchimento`], [`auto`], [Cor de fundo (auto = cor clara derivada)],
    [`titulo-fundo`], [`auto`], [Cor de fundo do título],
    [`titulo-cor`], [`preto`], [Cor do texto do título],
    [`recuo`], [`1em`], [Espaçamento interno],
    [`largura`], [`100%`], [Largura da caixa],
    [`quebravel`], [`verdadeiro`], [Se pode quebrar entre páginas],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `caixa()`],
  kind: table,
)

O parâmetro `cor` aceita qualquer cor do Typst. O FerrMat fornece nomes em português para todas as cores nativas:

#figure(
  table(
    columns: (auto, auto, 3em, auto, auto, 3em),
    inset: 6pt,
    align: (left, left, center, left, left, center),
    table.hline(stroke: 1pt),
    [*Português*], [*Typst*], [*Cor*], [*Português*], [*Typst*], [*Cor*],
    table.hline(stroke: 0.5pt),
    [`preto`], [`black`], [#box(width: 100%, height: 1em, fill: black)],
    [`azul`], [`blue`], [#box(width: 100%, height: 1em, fill: blue)],
    [`cinza`], [`gray`], [#box(width: 100%, height: 1em, fill: gray)],
    [`roxo`], [`purple`], [#box(width: 100%, height: 1em, fill: purple)],
    [`prata`], [`silver`], [#box(width: 100%, height: 1em, fill: silver)],
    [`fucsia`], [`fuchsia`], [#box(width: 100%, height: 1em, fill: fuchsia)],
    [`branco`], [`white`], [#box(width: 100%, height: 1em, fill: white, stroke: 0.5pt)],
    [`bordo`], [`maroon`], [#box(width: 100%, height: 1em, fill: maroon)],
    [`azul-marinho`], [`navy`], [#box(width: 100%, height: 1em, fill: navy)],
    [`vermelho`], [`red`], [#box(width: 100%, height: 1em, fill: red)],
    [`agua`], [`aqua`], [#box(width: 100%, height: 1em, fill: aqua)],
    [`laranja`], [`orange`], [#box(width: 100%, height: 1em, fill: orange)],
    [`azul-petroleo`], [`teal`], [#box(width: 100%, height: 1em, fill: teal)],
    [`amarelo`], [`yellow`], [#box(width: 100%, height: 1em, fill: yellow)],
    [`oriental`], [`eastern`], [#box(width: 100%, height: 1em, fill: eastern)],
    [`oliva`], [`olive`], [#box(width: 100%, height: 1em, fill: olive)],
    [`verde`], [`green`], [#box(width: 100%, height: 1em, fill: green)],
    [`lima`], [`lime`], [#box(width: 100%, height: 1em, fill: lime)],
    table.hline(stroke: 1pt),
  ),
  caption: [Cores disponíveis em português],
  kind: table,
) <tab:cores>

=== Com título

#exemplo-doc[
  #raw(block: true, lang: "typst", "#caixa(titulo: \"Informação\", cor: azul)[
  Uma caixa com título e borda esquerda.
]")
]

#caixa(titulo: "Informação", cor: azul)[
  Uma caixa com título e borda esquerda.
]

=== Estilos de borda

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Borda superior
#caixa(titulo: \"Atenção\", cor: laranja, borda: \"topo\")[
  Uma caixa com borda no topo.
]

// Borda completa com cantos arredondados
#caixa(titulo: \"Aviso\", cor: vermelho, borda: \"completa\", raio: 4pt)[
  Uma caixa com borda completa e cantos arredondados.
]

// Sem borda
#caixa(cor: verde, borda: \"nenhuma\")[
  Uma caixa sem borda, apenas com preenchimento.
]")
]

#caixa(titulo: "Atenção", cor: laranja, borda: "topo")[
  Uma caixa com borda no topo.
]

#caixa(titulo: "Aviso", cor: vermelho, borda: "completa", raio: 4pt)[
  Uma caixa com borda completa e cantos arredondados.
]

#caixa(cor: verde, borda: "nenhuma")[
  Uma caixa sem borda, apenas com preenchimento.
]

=== Cores customizadas

#exemplo-doc[
  #raw(block: true, lang: "typst", "#caixa(
  titulo: \"Customizada\",
  cor: roxo,
  preenchimento: purple.lighten(95%),
  titulo-fundo: purple.lighten(70%),
  titulo-cor: branco,
  borda: \"completa\",
  espessura: 1.5pt,
  raio: 6pt,
)[
  Caixa com todas as cores customizadas.
]")
]

#caixa(
  titulo: "Customizada",
  cor: roxo,
  preenchimento: purple.lighten(95%),
  titulo-fundo: purple.lighten(70%),
  titulo-cor: branco,
  borda: "completa",
  espessura: 1.5pt,
  raio: 6pt,
)[
  Caixa com todas as cores customizadas.
]

== Estilos reutilizáveis

A função `caixa-estilo()` retorna uma closure (função) que pode ser usada repetidamente com a mesma configuração visual. Aceita os mesmos parâmetros de `caixa()`, mais opções de numeração:

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`prefixo`], [`nenhum`], [Rótulo do ambiente (ex: "Nota", "Aviso")],
    [`contador`], [`nenhum`], [Chave de contador para numeração automática],
    [`numeracao`], [`"1"`], [Formato de numeração],
    [`por-secao`], [`falso`], [Se numera por seção (ex: "1.1", "1.2")],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros extras de `caixa-estilo()`],
  kind: table,
)

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Criar estilo \"Nota\" com numeração automática
#let nota = caixa-estilo(
  cor: laranja,
  borda: \"completa\",
  raio: 3pt,
  prefixo: \"Nota\",
  contador: \"nota\",
)

#nota[Primeira nota: lembre-se de importar o FerrMat.]

#nota[Segunda nota: a numeração é automática.]

// Estilo sem numeração
#let aviso = caixa-estilo(
  cor: vermelho,
  borda: \"topo\",
  prefixo: \"Aviso\",
)

#aviso[Cuidado com divisão por zero!]")
]

#let nota = caixa-estilo(
  cor: laranja,
  borda: "completa",
  raio: 3pt,
  prefixo: "Nota",
  contador: "nota",
)

#nota[Primeira nota: lembre-se de importar o FerrMat.]

#nota[Segunda nota: a numeração é automática.]

#let aviso = caixa-estilo(
  cor: vermelho,
  borda: "topo",
  prefixo: "Aviso",
)

#aviso[Cuidado com divisão por zero!]

#pagebreak()

// ============================================================================
// CAPÍTULO 3: ESTILIZAÇÃO DE CÓDIGO
// ============================================================================

= Estilização de Código

O FerrMat fornece duas funções para exibir código-fonte com formatação visual.

== Código inline

A função `codigo-inline()` exibe código no meio do texto, com fundo destacado:

#exemplo-doc[
  #raw(block: true, lang: "typst", "O comando #codigo-inline(`print(\"hello\")`) imprime uma saudação.

Use #codigo-inline(`pip install ferrmat`) para instalar.")
]

O comando #codigo-inline(`print("hello")`) imprime uma saudação.

Use #codigo-inline(`pip install ferrmat`) para instalar.

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`fundo`], [`luma(240)`], [Cor de fundo],
    [`raio`], [`2pt`], [Raio dos cantos],
    [`recuo`], [`(x: 3pt, y: 1pt)`], [Espaçamento interno],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `codigo-inline()`],
  kind: table,
)

== Bloco de código

A função `codigo-bloco()` exibe código em um bloco com destaque de sintaxe, título opcional e numeração de linhas:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#codigo-bloco(lang: \"python\", ```
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```.text)")
]

#codigo-bloco(lang: "python", ```
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```.text)

=== Com título

#exemplo-doc[
  #raw(block: true, lang: "typst", "#codigo-bloco(
  lang: \"rust\",
  titulo: \"main.rs\",
  ```
fn main() {
    println!(\"Hello, ferrmat!\");
}
```.text,
)")
]

#codigo-bloco(
  lang: "rust",
  titulo: "main.rs",
  ```
fn main() {
    println!("Hello, ferrmat!");
}
```.text,
)

=== Com numeração de linhas

#exemplo-doc[
  #raw(block: true, lang: "typst", "#codigo-bloco(
  lang: \"javascript\",
  titulo: \"app.js\",
  numerar-linhas: verdadeiro,
  ```
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(3000);
```.text,
)")
]

#codigo-bloco(
  lang: "javascript",
  titulo: "app.js",
  numerar-linhas: verdadeiro,
  ```
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello World!');
});

app.listen(3000);
```.text,
)

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`lang`], [`nenhum`], [Linguagem para destaque de sintaxe],
    [`titulo`], [`nenhum`], [Título exibido em barra superior],
    [`cor`], [`luma(245)`], [Cor de fundo do bloco],
    [`borda`], [`(left: 2pt + luma(180))`], [Estilo da borda],
    [`raio`], [`0pt`], [Raio dos cantos],
    [`numerar-linhas`], [`falso`], [Se exibe números de linha],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `codigo-bloco()`],
  kind: table,
)

Os parâmetros `cor` e `borda` usam `luma()`, a função de tons de cinza do Typst. Ela recebe um valor de 0 (preto) a 255 (branco):

#figure(
  table(
    columns: (1fr, 3em, 1fr, 3em, 1fr, 3em),
    inset: 6pt,
    align: (left, center, left, center, left, center),
    table.hline(stroke: 1pt),
    [*Valor*], [*Tom*], [*Valor*], [*Tom*], [*Valor*], [*Tom*],
    table.hline(stroke: 0.5pt),
    [`luma(0)`], [#box(width: 100%, height: 1em, fill: luma(0))],
    [`luma(80)`], [#box(width: 100%, height: 1em, fill: luma(80))],
    [`luma(160)`], [#box(width: 100%, height: 1em, fill: luma(160))],
    [`luma(40)`], [#box(width: 100%, height: 1em, fill: luma(40))],
    [`luma(120)`], [#box(width: 100%, height: 1em, fill: luma(120))],
    [`luma(200)`], [#box(width: 100%, height: 1em, fill: luma(200))],
    [`luma(220)`], [#box(width: 100%, height: 1em, fill: luma(220))],
    [`luma(240)`], [#box(width: 100%, height: 1em, fill: luma(240))],
    [`luma(255)`], [#box(width: 100%, height: 1em, fill: luma(255), stroke: 0.5pt)],
    table.hline(stroke: 1pt),
  ),
  caption: [Escala `luma()` --- tons de cinza (0 = preto, 255 = branco)],
  kind: table,
)

Qualquer cor do Typst pode ser usada nos parâmetros `cor` e `borda`, incluindo as cores nomeadas (@tab:cores), `rgb()` e `luma()`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Bloco com fundo azul claro e borda azul
#codigo-bloco(
  lang: \"python\",
  cor: azul.lighten(90%),
  borda: (left: 3pt + azul),
  \"print('Olá!')\"
)")
]

#codigo-bloco(
  lang: "python",
  cor: azul.lighten(90%),
  borda: (left: 3pt + azul),
  "print('Olá!')"
)

== Atalho `code()`

A função `code()` é um atalho que aceita uma *string* e exibe código inline ou em bloco, delegando para `codigo-inline()` ou `codigo-bloco()` conforme o parâmetro `bloco`:

=== Inline (padrão)

#exemplo-doc[
  #raw(block: true, lang: "typst", "O valor de #code(\"x\") é 42.

A expressão #code(\"a + b\") retorna a soma.")
]

O valor de #code("x") é 42. A expressão #code("a + b") retorna a soma.

=== Bloco sem numeração

#exemplo-doc[
  #raw(block: true, lang: "typst", "#code(\"def soma(a, b):
    return a + b\", bloco: verdadeiro, lang: \"python\")")
]

#code("def soma(a, b):
    return a + b", bloco: verdadeiro, lang: "python")

=== Bloco com numeração de linhas

#exemplo-doc[
  #raw(block: true, lang: "typst", "#code(\"const x = 1;
const y = 2;
console.log(x + y);\", bloco: verdadeiro, lang: \"javascript\", numerar-linhas: verdadeiro)")
]

#code("const x = 1;
const y = 2;
console.log(x + y);", bloco: verdadeiro, lang: "javascript", numerar-linhas: verdadeiro)

=== Bloco com título

#exemplo-doc[
  #raw(block: true, lang: "typst", "#code(\"fn main() {
    println!(\\\"Hello!\\\");
}\", bloco: verdadeiro, lang: \"rust\", titulo: \"main.rs\")")
]

#code("fn main() {
    println!(\"Hello!\");
}", bloco: verdadeiro, lang: "rust", titulo: "main.rs")

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`bloco`], [`falso`], [Se `verdadeiro`, exibe como bloco em vez de inline],
    [`lang`], [`nenhum`], [Linguagem para destaque (apenas em bloco)],
    [`titulo`], [`nenhum`], [Título do bloco (apenas em bloco)],
    [`numerar-linhas`], [`falso`], [Se exibe números de linha (apenas em bloco)],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `code()`],
  kind: table,
)

#pagebreak()

// ============================================================================
// CAPÍTULO 4: FÓRMULAS MATEMÁTICAS
// ============================================================================

= Fórmulas Matemáticas

Uma das grandes vantagens do Typst sobre processadores de texto convencionais é a facilidade de escrever fórmulas matemáticas com qualidade tipográfica profissional.

== Modo matemático em Typst

Em Typst, fórmulas são escritas entre cifrões (`$`). Existem dois modos:

- *Inline* (na linha): `$x + y$` produz $x + y$
- *Destaque* (display): `$ x + y $` (com espaços) produz uma equação centralizada

#exemplo-doc[
  #raw(block: true, lang: "typst", "A fórmula $a^2 + b^2 = c^2$ é o teorema de Pitágoras.

A mesma fórmula em destaque:
$ a^2 + b^2 = c^2 $")
]


== Espaçamentos

O Typst oferece duas funções nativas para inserir espaço em qualquer ponto do documento:

- `h(tamanho)` --- espaço *horizontal*
- `v(tamanho)` --- espaço *vertical*

Ambas aceitam qualquer unidade de medida (`cm`, `mm`, `pt`, `em`, `fr`, etc.) e funcionam tanto no texto quanto no modo matemático (com `#`):

#exemplo-doc[
  #raw(block: true, lang: "typst", "Palavra#h(2cm)distante

#v(1cm)

Parágrafo com 1cm de distância vertical acima.

// No modo matemático:
$ f(x) #h(1cm) g(x) #h(1cm) h(x) $")
]

Palavra#h(2cm)distante

#v(1cm)

Parágrafo com 1cm de distância vertical acima.

No modo matemático:

$ f(x) #h(1cm) g(x) #h(1cm) h(x) $

No modo matemático, existe também `quad` --- um espaço padrão usado para separar expressões dentro de uma equação. Compare sem e com `quad`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Sem quad: tudo colado
$ f(x) g(x) h(x) $

// Com quad: separação clara
$ f(x) quad g(x) quad h(x) $")
]

Sem `quad`: $ f(x) g(x) h(x) $

Com `quad`: $ f(x) quad g(x) quad h(x) $

== Outros tipos de letras

O Typst oferece várias variantes de letras para matemática:

#figure(
  table(
    columns: (1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Resultado*], [*Uso comum*],
    table.hline(stroke: 0.5pt),
    [`bb(R)`], [$bb(R)$], [Conjuntos numéricos],
    [`cal(L)`], [$cal(L)$], [Operadores, transformadas],
    [`frak(g)`], [$frak(g)$], [Álgebras de Lie],
    [`bold(x)`], [$bold(x)$], [Vetores (alternativa)],
    [`italic(f)`], [$italic(f)$], [Funções (padrão)],
    [`upright(d)`], [$upright(d)$], [Operador diferencial],
    table.hline(stroke: 1pt),
  ),
  caption: [Variantes de letras matemáticas],
  kind: table,
)

#exemplo-doc[
  #raw(block: true, lang: "typst", "$bb(R)$, $bb(N)$, $bb(Z)$, $bb(Q)$, $bb(C)$
// Conjuntos reais, naturais, inteiros, racionais, complexos

$cal(F)[f(t)] = F(omega)$  // Transformada de Fourier

$frak(g) = frak(sl)(2, bb(C))$  // Álgebra de Lie")
]

== Potências e índices

Potências (sobrescritos) usam `^` e índices (subscritos) usam `_`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$x^2$, $x^n$, $x^{n+1}$
$a_1$, $a_n$, $a_{i,j}$
$x_1^2$, $x_n^{k+1}$")

  Resultado: $x^2$, $x^n$, $x^(n+1)$, $a_1$, $a_n$, $a_(i,j)$, $x_1^2$, $x_n^(k+1)$
]

Em Typst, use parênteses para agrupar quando necessário: `x^(n+1)` em vez de chaves.

== Equações numeradas

Equações em destaque são numeradas automaticamente ao ativar `numbering` em `math.equation`. Cada equação pode receber um rótulo (`<nome>`) para ser referenciada no texto com `@nome`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#set math.equation(numbering: \"(1)\")

$ E = m c^2 $ <eq:einstein>

$ integral_0^infinity e^(-x^2) dif x = frac(sqrt(pi), 2) $ <eq:gauss>

Pela equação @eq:einstein e @eq:gauss...")
]

#set math.equation(numbering: "(1)")

$ E = m c^2 $ <eq:einstein>

$ integral_0^infinity e^(-x^2) dif x = frac(sqrt(pi), 2) $ <eq:gauss>

Pela equação @eq:einstein e @eq:gauss, temos resultados fundamentais da física e da análise.

#set math.equation(numbering: none)

== Alinhamento de equações

Para alinhar múltiplas equações, use `&` para marcar o ponto de alinhamento:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$
(a + b)^2 &= (a + b)(a + b) \\
          &= a^2 + a b + b a + b^2 \\
          &= a^2 + 2 a b + b^2
$")
]

$
(a + b)^2 &= (a + b)(a + b) \
          &= a^2 + a b + b a + b^2 \
          &= a^2 + 2 a b + b^2
$

== Função por partes

O FerrMat fornece `porPartes()` para definir funções por partes com alinhamento à direita. As linhas são separadas por `;` e as colunas por `,`. O operador `se` permite escrever as condições sem aspas:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ f(x) = porPartes(
  x, se x > 0;
  0, se x = 0;
  -x, se x < 0;
) $")
]

$ f(x) = porPartes(
  x, se x > 0;
  0, se x = 0;
  -x, se x < 0;
) $

O delimitador pode ser alterado com `delim`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ n! = porPartes(delim: \"[\",
  1, se n = 0;
  n dot (n-1)!, se n > 0;
) $")
]

$ n! = porPartes(delim: "[",
  1, se n = 0;
  n dot (n-1)!, se n > 0;
) $

#block(
  width: 100%,
  inset: 1em,
  stroke: (left: 3pt + eastern),
  fill: eastern.lighten(95%),
)[
  #set par(first-line-indent: 0pt)
  *Nota:* O operador `se` é definido como `math.op("se")` com espaço extra, renderizando em fonte romana com espaçamento equilibrado. Sem o FerrMat, seria necessário usar `cases()` com `"se"` entre aspas. Como consequência, o produto das variáveis _s_ e _e_ deve ser escrito como `s dot e` ou `s e` (com espaço) --- mas na prática essa colisão é rara.

  O espaçamento entre colunas pode ser ajustado com o parâmetro `gap` (padrão: `0.5em`).
]

== Texto em equações

Para inserir texto dentro do modo matemático, use aspas duplas:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ x > 0 \"para todo\" x in RR^+ $

$ A = { x in ZZ : x \"é par\" } $

$ lim_(n -> infinity) a_n = L \"se e somente se\" forall epsilon > 0, exists N $")
]

$ x > 0 "para todo" x in RR^+ $

$ A = { x in ZZ : x "é par" } $

$ lim_(n -> infinity) a_n = L "se e somente se" forall epsilon > 0, exists N $

== Sobre-linhas, sub-linhas e acentos

=== Sobre-linha e sub-linha

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ sobreLinha(A union B) = sobreLinha(A) inter sobreLinha(B) $

$ subLinha(x + y + z) $")
]

$ sobreLinha(A union B) = sobreLinha(A) inter sobreLinha(B) $

$ subLinha(x + y + z) $

As funções `sobreLinha()` e `subLinha()` são wrappers para `overline()` e `underline()` do Typst. Veja também `conjugado()` e `segmento()` no Capítulo 5.

=== Sobre-chave e sub-chave

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ sobreChave(a + b + c, \"n termos\") $

$ subChave(x_1 + x_2 + dots + x_n, \"soma total\") $")
]

$ sobreChave(a + b + c, "n termos") $

$ subChave(x_1 + x_2 + dots + x_n, "soma total") $

As funções `sobreChave()` e `subChave()` são wrappers para `overbrace()` e `underbrace()` do Typst.

=== Acentos matemáticos

O FerrMat fornece wrappers em português para os acentos matemáticos:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ chapeu(x), tilde(x), ponto(x), pontoDuplo(x), traco(x) $")
]

$ chapeu(x), tilde(x), ponto(x), pontoDuplo(x), traco(x) $

Onde `chapeu` = `hat`, `ponto` = `dot`, `pontoDuplo` = `dot.double`, `traco` = `macron`, e `tilde` permanece como no Typst (já é português).

Para acentos que se estendem sobre vários caracteres, use `chapeuLargo()` e `tilLargo()`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ chapeuLargo(A B C), tilLargo(x + y) $")
]

$ chapeuLargo(A B C), tilLargo(x + y) $

== Notação de ângulo

O FerrMat fornece `angulo` (wrapper para `angle`) com variantes em português, e `grau`/`graus` (wrapper para `degree`):

#exemplo-doc[
  #raw(block: true, lang: "typst", "$ angulo A B C = 90 graus $

$ angulo.arco A B C $")
]

$ angulo A B C = 90 graus $

$ angulo.arco A B C $

Todas as variantes de `angulo`:

#figure(
  table(
    columns: 3,
    align: (left, center, left),
    table.header[*FerrMat*][*Símbolo*][*Typst nativo*],
    [`angulo`], [$angulo$], [`angle`],
    [`angulo.arco`], [$angulo.arco$], [`angle.arc`],
    [`angulo.agudo`], [$angulo.agudo$], [`angle.acute`],
    [`angulo.reto`], [$angulo.reto$], [`angle.right`],
    [`angulo.esferico`], [$angulo.esferico$], [`angle.spheric`],
    [`grau` / `graus`], [$graus$], [`degree`],
  ),
  caption: [Variantes de ângulo em português],
)

#pagebreak()

// ============================================================================
// CAPÍTULO 5: MATEMÁTICA EM PORTUGUÊS
// ============================================================================

= Matemática em Português

O FerrMat fornece funções que traduzem operadores, símbolos e construções matemáticas do Typst para o português. Todas as funções são wrappers sobre os equivalentes nativos --- não adicionam funcionalidade nova, apenas tornam o código mais natural para falantes de português.

== Operadores

O FerrMat fornece o operador `sen` (seno em português), que substitui o `sin` padrão do Typst:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$sen(x)$, $cos(x)$, $tan(x)$
$log(x)$, $ln(x)$, $exp(x)$
$lim_(x -> 0) f(x)$
$max(a, b)$, $min(a, b)$")

  Resultado: $sen(x)$, $cos(x)$, $tan(x)$, $log(x)$, $ln(x)$, $exp(x)$
]

As demais funções (`cos`, `tan`, `log`, `ln`, `exp`, `lim`, `max`, `min`) são nativas do Typst e têm o mesmo nome em português.

=== Trigonometria em português

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*FerrMat*], [*Typst*], [*Exemplo*],
    table.hline(stroke: 0.5pt),
    [`sen`], [`sin`], [$sen(x)$],
    [`tg`], [`tan`], [$tg(x)$],
    [`ctg`], [`cot`], [$ctg(x)$],
    [`csc`], [`csc`], [$csc(x)$],
    [`arcsen`], [`arcsin`], [$arcsen(x)$],
    [`arccos`], [`arccos`], [$arccos(x)$],
    [`arctg`], [`arctan`], [$arctg(x)$],
    [`senh`], [`sinh`], [$senh(x)$],
    [`tgh`], [`tanh`], [$tgh(x)$],
    table.hline(stroke: 1pt),
  ),
  caption: [Funções trigonométricas em português],
  kind: table,
)

As funções `cos`, `cosh`, `sec` e `cot` já possuem o mesmo nome em português e inglês.

=== Operadores em português

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*FerrMat*], [*Typst*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`mdc`], [`gcd`], [Máximo divisor comum],
    [`mmc`], [`lcm`], [Mínimo múltiplo comum],
    [`grau`], [`deg`], [Grau de um polinômio],
    [`resto`], [`mod`], [Resto da divisão],
    [`angulo`], [`angle`], [Símbolo de ângulo],
    table.hline(stroke: 1pt),
  ),
  caption: [Operadores em português],
  kind: table,
)

Os seguintes operadores já possuem nome universal e não precisam de wrapper: `det`, `tr`, `ker`, `dim`, `sup`, `inf`, `lim`, `limsup`, `liminf`, `mod`, `max`, `min`, `Pr` (probabilidade).

=== Notação em português

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*FerrMat*], [*Typst*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`sobreLinha`], [`overline`], [Barra superior],
    [`subLinha`], [`underline`], [Barra inferior],
    [`sobreChave`], [`overbrace`], [Chave superior com rótulo],
    [`subChave`], [`underbrace`], [Chave inferior com rótulo],
    [`chapeuLargo`], [`accent(..., hat)`], [Chapéu sobre vários caracteres],
    [`tilLargo`], [`accent(..., tilde)`], [Til sobre vários caracteres],
    table.hline(stroke: 1pt),
  ),
  caption: [Notação em português],
  kind: table,
)

== Letras gregas

O FerrMat fornece nomes em português para as letras gregas que diferem do inglês. As letras que já possuem o mesmo nome em ambas as línguas (`beta`, `delta`, `epsilon`, `zeta`, `eta`, `iota`, `lambda`, `pi`, `sigma`, `tau`, `psi`, `omega`) podem ser usadas diretamente.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Português*], [*Letra*], [*Português*], [*Letra*], [*Português*], [*Letra*],
    table.hline(stroke: 0.5pt),
    [`alfa`], [$alfa$], [`beta`], [$beta$], [`gama`], [$gama$],
    [`delta`], [$delta$], [`epsilon`], [$epsilon$], [`zeta`], [$zeta$],
    [`eta`], [$eta$], [`teta`], [$teta$], [`iota`], [$iota$],
    [`kapa`], [$kapa$], [`lambda`], [$lambda$], [`mi`], [$mi$],
    [`ni`], [$ni$], [`csi`], [$csi$], [`pi`], [$pi$],
    [`ro`], [$ro$], [`sigma`], [$sigma$], [`tau`], [$tau$],
    [`ipsilon`], [$ipsilon$], [`fi`], [$fi$], [`qui`], [$qui$],
    [`psi`], [$psi$], [`omega`], [$omega$], [], [],
    table.hline(stroke: 1pt),
  ),
  caption: [Letras gregas minúsculas],
  kind: table,
)

Quatro letras possuem variantes cursivas acessíveis com `.alt`:

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Letra*], [*Código*], [*Letra*], [*Código*], [*Letra*], [*Código*], [*Letra*],
    table.hline(stroke: 0.5pt),
    [`teta.alt`], [$teta.alt$], [`kapa.alt`], [$kapa.alt$], [`ro.alt`], [$ro.alt$], [`fi.alt`], [$fi.alt$],
    table.hline(stroke: 1pt),
  ),
  caption: [Variantes cursivas],
  kind: table,
)

Para maiúsculas, use a primeira letra em maiúsculo:

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Português*], [*Letra*], [*Português*], [*Letra*], [*Português*], [*Letra*],
    table.hline(stroke: 0.5pt),
    [`Gama`], [$Gama$], [`Delta`], [$Delta$], [`Teta`], [$Teta$],
    [`Lambda`], [$Lambda$], [`Csi`], [$Csi$], [`Pi`], [$Pi$],
    [`Sigma`], [$Sigma$], [`Ipsilon`], [$Ipsilon$], [`Fi`], [$Fi$],
    [`Psi`], [$Psi$], [`Omega`], [$Omega$], [], [],
    table.hline(stroke: 1pt),
  ),
  caption: [Letras gregas maiúsculas],
  kind: table,
)

== Frações

Frações são criadas com `fracao(numerador, denominador)`. O parâmetro `estilo` controla o layout:

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Inline — a fração fica compacta automaticamente
$fracao(a, b)$, $fracao(x+1, x-1)$, $a/b$

// Destaque — a fração fica maior
$ fracao(a+b, c+d) $")
]

Inline: $fracao(a, b)$, $fracao(x+1, x-1)$, $a/b$. Em destaque:

$ fracao(a+b, c+d) $

O parâmetro `estilo` controla o layout da fração:

#figure(
  table(
    columns: (auto, 1fr, auto),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Estilo*], [*Descrição*], [*Resultado*],
    table.hline(stroke: 0.5pt),
    [`"vertical"`], [Numerador sobre denominador com barra (padrão)], [$fracao(a+b, c+d)$],
    [`"inclinada"`], [Separados por barra inclinada], [$fracao(a+b, c+d, estilo: "inclinada")$],
    [`"horizontal"`], [Em linha, mantendo parênteses], [$fracao(a+b, c+d, estilo: "horizontal")$],
    table.hline(stroke: 1pt),
  ),
  caption: [Estilos de fração],
  kind: table,
)

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Vertical (padrão)
$fracao(a+b, c+d)$

// Inclinada — útil para frações simples no meio do texto
$fracao(a+b, c+d, estilo: \"inclinada\")$

// Horizontal — mantém parênteses explícitos
$fracao(a+b, c+d, estilo: \"horizontal\")$")
]

$fracao(a+b, c+d)$, #h(1em) $fracao(a+b, c+d, estilo: "inclinada")$, #h(1em) $fracao(a+b, c+d, estilo: "horizontal")$

Por padrão, frações inline ficam compactas. Para forçar o tamanho de destaque dentro do texto, use `destaque()`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "Compacta: $fracao(1, 2)$. Grande: $destaque(fracao(1, 2))$.")
]

Compacta: $fracao(1, 2)$. Grande: $destaque(fracao(1, 2))$.

== Binômios

Coeficientes binomiais usam `binomio(n, k)`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$binomio(n, k)$

$ binomio(n, k) = fracao(n!, k!(n-k)!) $

// Multinomial (vários índices inferiores)
$binomio(n, k_1, k_2, k_3)$")
]

$binomio(n, k)$, $binomio(n, k_1, k_2, k_3)$

== Raízes

A função `raiz()` aceita um ou dois argumentos. Com um argumento é raiz quadrada, com dois é raiz n-ésima:

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Raiz quadrada (um argumento)
$raiz(2)$, $raiz(x+1)$

// Raiz n-ésima (dois argumentos: índice, radicando)
$raiz(3, 8)$, $raiz(n, x)$")

  Resultado: $raiz(2)$, $raiz(x+1)$, $raiz(3, 8)$, $raiz(n, x)$
]

== Somatórios, produtórios, uniões, interseções

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Somatório
$somatorio_(i=1)^n a_i$

// Produtório
$produtorio_(i=1)^n a_i$

// União
$uniao.maior_(i=1)^n A_i$

// Interseção
$inter.maior_(i=1)^n A_i$")
]

Resultado:

$ somatorio_(i=1)^n a_i quad quad produtorio_(i=1)^n a_i quad quad uniao.maior_(i=1)^n A_i quad quad inter.maior_(i=1)^n A_i $

Cada símbolo possui variantes acessíveis com `.`:

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Símbolo*], [*Variantes*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`somatorio`], [`.integral`], [Somatório (∑) e integral-soma (⨋)],
    [`produtorio`], [`.co`], [Produtório (∏) e coproduto (∐)],
    [`uniao`], [`.maior`, `.ponto`, `.dupla`, `.mais`, `.quad`, ...], [União (∪) e variantes],
    [`inter`], [`.maior`, `.e`, `.ponto`, `.dupla`, `.quad`, ...], [Interseção (∩) e variantes],
    table.hline(stroke: 1pt),
  ),
  caption: [Símbolos com variantes],
  kind: table,
)

== Limites

#exemplo-doc[
  #raw(block: true, lang: "typst", "$lim_(x -> 0) fracao(sen x, x) = 1$

$lim_(n -> infinito) (1 + 1/n)^n = e$

$lim_(x -> 0^+) ln x = -infinito$")
]

$ lim_(x -> 0) fracao(sen x, x) = 1 $

$ lim_(n -> infinito) (1 + 1/n)^n = e $

$ lim_(x -> 0^+) ln x = -infinito $

== Derivadas

O FerrMat fornece `leibniz()` para a notação de Leibniz e `parcial()` para derivadas parciais.

Em `leibniz`, a ordem é o terceiro argumento: `leibniz(y, x, 2)`. Em `parcial`, a ordem precisa ser nomeada (`ordem: 2`) para não ser confundida com uma segunda variável --- `parcial(f, x, y)` é a derivada mista $partial^2 f \/ partial x partial y$.

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Derivada com notação de Leibniz
$leibniz(y, x)$, $leibniz(y, x, 2)$

// Derivadas parciais
$parcial(f, x)$, $parcial(f, x, ordem: 2)$

// Derivada parcial mista
$parcial(f, x, y)$

// Notação de Newton (ponto)
$dot(x)$, $dot.double(x)$

// Notação de Lagrange (linha)
$f'(x)$, $f''(x)$")
]

$ leibniz(y, x) quad leibniz(y, x, 2) quad parcial(f, x) quad parcial(f, x, ordem: 2) quad parcial(f, x, y) $

$ dot(x) comma dot.double(x) comma f'(x) comma f''(x) $

== Integrais

O símbolo `integral` possui variantes em português:

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Integral simples
$integral_a^b f(x) dif x$

// Integral dupla
$integral.dupla_D f(x,y) dif x dif y$

// Integral tripla
$integral.tripla_V f dif V$

// Integral de contorno
$integral.contorno_C bold(F) dot dif bold(r)$")
]

$ integral_a^b f(x) dif x quad quad integral.dupla_D f(x,y) dif x dif y quad quad integral.tripla_V f dif V quad quad integral.contorno_C bold(F) dot dif bold(r) $

#figure(
  table(
    columns: 3,
    align: (left, center, left),
    table.header[*FerrMat*][*Símbolo*][*Descrição*],
    [`integral`], [$integral$], [Integral simples],
    [`integral.dupla`], [$integral.dupla$], [Integral dupla],
    [`integral.tripla`], [$integral.tripla$], [Integral tripla],
    [`integral.quadrupla`], [$integral.quadrupla$], [Integral quádrupla],
    [`integral.contorno`], [$integral.contorno$], [Integral de contorno],
    [`integral.traco`], [$integral.traco$], [Integral com traço],
    [`integral.traco.dupla`], [$integral.traco.dupla$], [Integral com traço duplo],
    [`integral.inter`], [$integral.inter$], [Integral com interseção],
    [`integral.seta.gancho`], [$integral.seta.gancho$], [Integral com seta-gancho],
  ),
  caption: [Variantes de integral],
)

== Delimitadores

A função `delimitar()` faz delimitadores se ajustarem automaticamente ao tamanho do conteúdo (wrapper de `lr`):

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Com delimitar: delimitadores ajustam ao conteúdo
$delimitar(chevron.l frac(1+frac(a,b), c) chevron.r)$
$delimitar(( frac(1+frac(a,b), c) ))$

// Sem delimitar: delimitadores ficam pequenos
$chevron.l frac(1+frac(a,b), c) chevron.r$
$( frac(1+frac(a,b), c) )$")
]

Com `delimitar`: $delimitar(chevron.l frac(1+frac(a,b), c) chevron.r)$ $delimitar((frac(1+frac(a,b), c)))$ #h(1em) Sem: $chevron.l frac(1+frac(a,b), c) chevron.r$ $(frac(1+frac(a,b), c))$

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Tipos de delimitadores
$delimitar(( frac(a, b) ))$  // parênteses
$delimitar([ frac(a, b) ])$  // colchetes
$delimitar(| x |)$           // valor absoluto
$delimitar(|| x ||)$         // norma
$delimitar(chevron.l x chevron.r)$  // produto interno
$delimitar({ x : x > 0 })$  // conjunto")
]

$ delimitar((frac(a, b))) quad delimitar([frac(a, b)]) quad delimitar(|x|) quad delimitar(||x||) quad delimitar(chevron.l x chevron.r) quad delimitar({x : x > 0}) $

== Vetores e conjugados

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Vetor com seta
$vetor(v)$, $vetor(A B)$

// Vetor em negrito
$vetorNegrito(v)$, $vetorNegrito(F)$

// Conjugado
$conjugado(z)$

// Segmento (barra superior)
$segmento(A B)$

// Chapéu
$chapeu(x)$, $chapeu(i)$, $chapeu(j)$, $chapeu(k)$

// Til
$tilde(x)$")
]

$vetor(v)$, $vetor(A B)$, $vetorNegrito(v)$, $vetorNegrito(F)$, $conjugado(z)$, $segmento(A B)$, $chapeu(x)$, $tilde(x)$

== Matrizes e determinantes

O FerrMat fornece quatro funções para matrizes, cada uma com seu delimitador:

- `matriz()` --- parênteses $(med)$
- `colchete()` --- colchetes $[med]$
- `barra()` --- barras $|med|$ (determinante)
- `norma()` --- barras duplas $‖med‖$

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Parênteses
$matriz(a, b; c, d)$

// Colchetes
$colchete(1, 2, 3; 4, 5, 6)$

// Barras (determinante)
$barra(a, b; c, d)$

// Barras duplas (norma)
$norma(a, b; c, d)$")
]

$ matriz(a, b; c, d) quad colchete(1, 2, 3; 4, 5, 6) quad barra(a, b; c, d) quad norma(a, b; c, d) $

== Tamanhos: destaque vs. inline

No Typst, equações entre `$ ... $` (com espaço) ficam em _destaque_ e equações `$...$` (sem espaço) ficam _inline_. O FerrMat oferece funções para forçar o tamanho:

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*FerrMat*], [*LaTeX*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`destaque()`], [`\displaystyle`], [Força tamanho de destaque (o maior)],
    [`emLinha()`], [`\textstyle`], [Força tamanho inline],
    [`subscrito()`], [`\scriptstyle`], [Tamanho de sub/sobrescrito],
    [`subSubscrito()`], [`\scriptscriptstyle`], [Tamanho de sub/sobrescrito de 2º nível (o menor)],
    table.hline(stroke: 1pt),
  ),
  caption: [Funções de tamanho matemático],
  kind: table,
)

Todas aceitam o parâmetro `compacto:` (`falso` por padrão em `destaque`/`emLinha`, `verdadeiro` em `subscrito`/`subSubscrito`), que restringe a altura dos expoentes.

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Sem destaque(): somatório inline fica compacto
Temos $sum_(i=1)^n x_i$ como resultado.

// Com destaque(): somatório inline fica grande como destaque
Temos $destaque(sum_(i=1)^n x_i)$ como resultado.

// Inverso: forçar inline dentro de destaque
$ emLinha(sum_(i=1)^n x_i) quad \"versus\" quad sum_(i=1)^n x_i $")
]

Sem `destaque`: temos $sum_(i=1)^n x_i$ como resultado. Com `destaque`: temos $destaque(sum_(i=1)^n x_i)$ como resultado.

#pagebreak()

// ============================================================================
// CAPÍTULO 6: AMBIENTES MATEMÁTICOS
// ============================================================================

= Ambientes Matemáticos

O FerrMat fornece 14 ambientes matemáticos pré-configurados com caixas coloridas, numeração automática e três estilos visuais.

== Ambientes pré-configurados

#figure(
  table(
    columns: (auto, auto, auto, auto),
    align: (left, left, left, left),
    table.header[*Ambiente*][*Categoria*][*Cor*][*Corpo*],
    [`teorema`], [Enunciado], [azul], [itálico],
    [`lema`], [Enunciado], [azul escuro], [itálico],
    [`corolario`], [Enunciado], [azul claro], [itálico],
    [`proposicao`], [Enunciado], [eastern], [itálico],
    [`axioma`], [Enunciado], [navy], [itálico],
    [`conjectura`], [Enunciado], [roxo], [itálico],
    [`afirmacao`], [Enunciado], [teal], [itálico],
    [`definicao`], [Definição], [verde], [normal],
    [`notacao`], [Definição], [olive], [normal],
    [`propriedade`], [Definição], [verde escuro], [normal],
    [`exemplo`], [Exemplo], [cinza], [normal],
    [`problema`], [Exemplo], [laranja], [normal],
    [`observacao`], [Informal], [maroon], [normal (sem numeração)],
    [`demonstracao`], [Informal], [---], [normal (com QED)],
  ),
  caption: [Ambientes matemáticos disponíveis no FerrMat],
  kind: table,
)

== Uso básico

Cada ambiente aceita conteúdo direto e um título opcional:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#definicao[
  Um *grupo* é um conjunto $G$ munido de uma operação
  $dot : G times G -> G$ satisfazendo associatividade,
  existência de elemento neutro e existência de inversos.
]

#teorema(titulo: [de Lagrange])[
  Se $H$ é um subgrupo de um grupo finito $G$, então
  a ordem de $H$ divide a ordem de $G$.
]

#demonstracao[
  As classes laterais à esquerda de $H$ particionam $G$
  em subconjuntos de mesmo tamanho $|H|$.
]

#observacao[Nem todo subconjunto de um grupo é subgrupo.]")
]

#definicao[
  Um *grupo* é um conjunto $G$ munido de uma operação $dot : G times G -> G$ satisfazendo associatividade, existência de elemento neutro e existência de inversos.
]

#teorema(titulo: [de Lagrange])[
  Se $H$ é um subgrupo de um grupo finito $G$, então a ordem de $H$ divide a ordem de $G$.
]

#demonstracao[
  As classes laterais à esquerda de $H$ particionam $G$ em subconjuntos de mesmo tamanho $|H|$, logo $|G| = [G : H] dot |H|$.
]

#observacao[Nem todo subconjunto de um grupo é subgrupo.]

== Numeração

A numeração dos ambientes é controlada por `configurar-numeracao`, que recebe três parâmetros:

- *modo*: `"por-tipo"` (padrão) ou `"unificado"`
- *por-secao*: `falso` (padrão) ou `verdadeiro`
- *nivel*: nível do heading que dispara reinício dos contadores (padrão: `1`)

O parâmetro `nivel` indica qual nível de heading delimita as "seções" para fins de numeração. O padrão `nivel: 1` é adequado para monografias e teses, onde `= Capítulo` é nível 1. Em artigos, onde `= Título do artigo` é nível 1 e as seções reais são `== Seção`, use `nivel: 2` para que os contadores reiniciem a cada `==` e a numeração exiba o formato "seção.subseção.número" (ex.: 1.2.1).

Coloque no início do documento, como show rule:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\")  // padrão")
]

Isso gera quatro combinações possíveis, detalhadas a seguir.

=== Por tipo, global

Cada tipo de ambiente tem seu próprio contador, numerado do início ao fim do documento. Este é o comportamento padrão:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\")

#definicao[...]   // Definição 1
#teorema[...]    // Teorema 1
#lema[...]       // Lema 1
#teorema[...]    // Teorema 2
#lema[...]       // Lema 2
#definicao[...]  // Definição 2")
]

=== Por tipo, por seção

Cada tipo mantém seu próprio contador, mas a numeração inclui o número da seção (ou capítulo) e reinicia automaticamente:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\", por-secao: verdadeiro)

= Capítulo 1
#definicao[...]  // Definição 1.1
#teorema[...]   // Teorema 1.1
#teorema[...]   // Teorema 1.2

= Capítulo 2
#teorema[...]   // Teorema 2.1 (reinicia)
#definicao[...]  // Definição 2.1 (reinicia)")
]

=== Unificado, global

Todos os ambientes compartilham um único contador sequencial. Isso facilita localizar resultados no texto:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"unificado\")

#definicao[...]   // Definição 1
#teorema[...]    // Teorema 2
#lema[...]       // Lema 3
#teorema[...]    // Teorema 4")
]

=== Unificado, por seção

Contador único com número da seção, reiniciando a cada capítulo:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"unificado\", por-secao: verdadeiro)

= Capítulo 1
#definicao[...]  // Definição 1.1
#teorema[...]   // Teorema 1.2
#lema[...]      // Lema 1.3

= Capítulo 2
#teorema[...]   // Teorema 2.1 (reinicia)")
]

=== Usando `nivel` em artigos

Em artigos acadêmicos, o heading nível 1 (`=`) costuma ser o título do artigo, e as seções reais usam nível 2 (`==`). Use `nivel: 2` para que a numeração por seção reinicie a cada `==`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\", por-secao: verdadeiro, nivel: 2)

= Título do Artigo
== Introdução
#definicao[...]  // Definição 1.1.1
#teorema[...]   // Teorema 1.1.1

== Resultados
#teorema[...]   // Teorema 1.2.1 (reinicia na subseção)
#lema[...]      // Lema 1.2.1")
]

A numeração inclui todos os níveis de heading até o configurado. Com `nivel: 1` (padrão), o prefixo é "capítulo.número" (ex.: 2.1). Com `nivel: 2`, é "capítulo.seção.número" (ex.: 1.2.1).

== Numeração de equações

A função `num-equacao` aceita o parâmetro `nivel` com a mesma semântica. Use como show rule:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#show: num-equacao(por-secao: verdadeiro, nivel: 2)")
]

== Estilos visuais

O FerrMat suporta três estilos globais, controlados por `configurar-ambientes`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#configurar-ambientes(\"colorido\")  // padrão: cada ambiente com sua cor
#configurar-ambientes(\"cinza\")      // todos em tons de cinza
#configurar-ambientes(\"sem-caixa\")  // apenas rótulo em negrito, sem fundo/borda")
]

=== Estilo colorido (padrão)

#configurar-ambientes("colorido")

#teorema(titulo: [colorido])[Se $H$ é um subgrupo de $G$, então $|H|$ divide $|G|$.]

#definicao[Um *anel* é um conjunto munido de duas operações satisfazendo certas propriedades.]

=== Estilo cinza

#configurar-ambientes("cinza")

#teorema(titulo: [em cinza])[Se $H$ é um subgrupo de $G$, então $|H|$ divide $|G|$.]

#definicao[Um *anel* é um conjunto munido de duas operações satisfazendo certas propriedades.]

=== Estilo sem caixa

#configurar-ambientes("sem-caixa")

#teorema(titulo: [sem caixa])[Se $H$ é um subgrupo de $G$, então $|H|$ divide $|G|$.]

#definicao[Um *anel* é um conjunto munido de duas operações satisfazendo certas propriedades.]

#configurar-ambientes("colorido")

== Ambientes personalizados

Para criar ambientes com configuração própria, use `ambiente-matematico`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#let hipotese = ambiente-matematico(
  cor: roxo,
  espessura: 5pt,
  prefixo: \"Hipótese\",
  contador: \"hipotese\",
)

#hipotese[Toda função contínua em $[a,b]$ é integrável.]")
]

#let hipotese = ambiente-matematico(
  cor: roxo,
  espessura: 5pt,
  prefixo: "Hipótese",
  contador: "hipotese",
)

#hipotese[Toda função contínua em $[a,b]$ é integrável.]

#pagebreak()

// ============================================================================
// CAPÍTULO 7: DIAGRAMAS E GRÁFICOS
// ============================================================================

= Diagramas e Gráficos

Typst oferece pacotes externos para criação de diagramas, gráficos e visualizações. Os principais são:

- *fletcher*: Diagramas de fluxo e comutativos
- *cetz* e *cetz-plot*: Gráficos vetoriais e de funções (similar ao TikZ)

== Diagramas comutativos

#import "@preview/fletcher:0.5.8": diagram, node, edge, shapes

Diagramas comutativos são essenciais em álgebra e teoria das categorias. Use o pacote `fletcher`:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/fletcher:0.5.8\": diagram, node, edge

#diagram(
  node((0, 0), $A$),
  node((1, 0), $B$),
  node((0, 1), $C$),
  node((1, 1), $D$),
  edge((0, 0), (1, 0), $f$, \"->\"),
  edge((0, 0), (0, 1), $g$, \"->\"),
  edge((1, 0), (1, 1), $h$, \"->\"),
  edge((0, 1), (1, 1), $k$, \"->\"),
)")
]

#align(center,
  diagram(
    node((0, 0), $A$),
    node((1, 0), $B$),
    node((0, 1), $C$),
    node((1, 1), $D$),
    edge((0, 0), (1, 0), $f$, "->"),
    edge((0, 0), (0, 1), $g$, "->"),
    edge((1, 0), (1, 1), $h$, "->"),
    edge((0, 1), (1, 1), $k$, "->"),
  )
)

== Fluxogramas

O `fletcher` também serve para fluxogramas:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/fletcher:0.5.8\": diagram, node, edge, shapes

#diagram(
  node((0, 0), [Início], shape: shapes.ellipse),
  edge(\"->\"),
  node((0, 1), [Processar]),
  edge(\"->\"),
  node((0, 2), [Decisão?], shape: shapes.diamond),
  edge(\"r\", \"->\", [Sim]),
  node((1, 2), [Ação A]),
  edge((0, 2), (0, 3), \"->\", [Não]),
  node((0, 3), [Ação B]),
  edge((1, 2), (0, 4), \"->\"),
  edge((0, 3), (0, 4), \"->\"),
  node((0, 4), [Fim], shape: shapes.ellipse),
)")
]

#align(center,
  diagram(
    node((0, 0), [Início], shape: shapes.ellipse),
    edge("->"),
    node((0, 1), [Processar]),
    edge("->"),
    node((0, 2), [Decisão?], shape: shapes.diamond),
    edge("r", "->", [Sim]),
    node((1, 2), [Ação A]),
    edge((0, 2), (0, 3), "->", [Não]),
    node((0, 3), [Ação B]),
    edge((1, 2), (0, 4), "->"),
    edge((0, 3), (0, 4), "->"),
    node((0, 4), [Fim], shape: shapes.ellipse),
  )
)

== Gráficos de funções

Para gráficos matemáticos, há duas abordagens principais: programar o gráfico diretamente em Typst com os pacotes `cetz` e `cetz-plot`, ou criá-lo em um software externo como o GeoGebra e importar a imagem.

=== Gráficos com cetz-plot

Os pacotes `cetz` e `cetz-plot` permitem criar gráficos diretamente no documento:

#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/cetz-plot:0.1.1": plot

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/cetz:0.3.4\": canvas, draw
#import \"@preview/cetz-plot:0.1.1\": plot

#canvas({
  import draw: *

  plot.plot(
    size: (8, 5),
    x-label: $x$,
    y-label: rotate(90deg, $y$),
    x-min: -2, x-max: 2,
    y-min: -1, y-max: 4,
    {
      plot.add(
        domain: (-2, 2),
        x => calc.pow(x, 2),
        label: $y = x^2$,
      )
    }
  )
})")
]

#let y-vertical = rotate(90deg, $y$)
#align(center,
  canvas({
    import draw: *

    plot.plot(
      size: (8, 5),
      x-label: $x$,
      y-label: y-vertical,
      x-min: -2, x-max: 2,
      y-min: -1, y-max: 4,
      {
        plot.add(
          domain: (-2, 2),
          x => calc.pow(x, 2),
          label: $y = x^2$,
        )
      }
    )
  })
)

=== Gráficos com GeoGebra

Para gráficos mais elaborados ou interativos, o GeoGebra (#link("https://www.geogebra.org")[geogebra.org]) é uma excelente alternativa. Crie o gráfico no GeoGebra e exporte como SVG (_Arquivo → Exportar → Gráficos como SVG_). O formato SVG é o mais indicado para Typst porque é vetorial --- a imagem mantém qualidade perfeita em qualquer escala, diferente de formatos rasterizados como PNG.

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Gráfico criado no GeoGebra e exportado como SVG
#imagem(\"grafico-geogebra.svg\", largura: 80%)")

  Gráficos complexos com múltiplas curvas, regiões hachuradas, pontos notáveis e anotações são muito mais fáceis de construir visualmente no GeoGebra do que programar com `cetz-plot`. A exportação em SVG garante que o resultado no PDF terá a mesma nitidez de um gráfico programado diretamente.
]

== Cronograma (Gantt)

O FerrMat inclui a função `#cronograma()` para criar gráficos de Gantt diretamente no documento Typst --- sem dependências externas pesadas e com aparência moderna: barras arredondadas (_pill-shaped_), fundo alternado entre linhas, cabeçalho com dois níveis (mês + semanas), indicador de progresso e linha "hoje".

É ideal para projetos de pesquisa, TCCs e relatórios técnicos, onde um cronograma visual substitui a tradicional tabela estática.

=== Funções auxiliares

Antes de criar o gráfico, é preciso conhecer duas funções auxiliares:

/ `data(dia, mes, ano)`: cria um dicionário de data. Exemplo: `data(1, 3, 2026)` representa 1 de março de 2026.
/ `tarefa(nome, inicio, fim, ..)`: cria um dicionário de tarefa para uso no cronograma. Parâmetros opcionais: `cor`, `progresso` (0--100), `grupo`, `marco` (losango), `depende-de` (nomes de tarefas) e `rotulo`.

=== Exemplo básico

O caso mais simples: um punhado de tarefas com datas e cores.

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma((
  tarefa(\"Levantamento\", data(1, 3, 2026), data(10, 3, 2026),
    progresso: 100, cor: verde),
  tarefa(\"Redação\", data(8, 3, 2026), data(22, 3, 2026),
    progresso: 40, cor: azul),
  tarefa(\"Revisão\", data(20, 3, 2026), data(31, 3, 2026),
    cor: roxo),
))")
]

#cronograma((
  tarefa("Levantamento", data(1, 3, 2026), data(10, 3, 2026),
    progresso: 100, cor: verde),
  tarefa("Redação", data(8, 3, 2026), data(22, 3, 2026),
    progresso: 40, cor: azul),
  tarefa("Revisão", data(20, 3, 2026), data(31, 3, 2026),
    cor: roxo),
))

Observe que o intervalo de datas é inferido automaticamente (do início da primeira tarefa ao fim da última), as barras têm cantos arredondados e o fundo alterna entre branco e cinza claro.

=== Progresso e rótulos

Use `progresso: 0..100` para exibir um preenchimento parcial dentro da barra. Com `mostrar-rotulo: true`, a porcentagem (ou um texto personalizado via `rotulo`) aparece centralizada na barra.

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma(
  mostrar-rotulo: true,
  (
    tarefa(\"Análise\", data(1, 4, 2026), data(14, 4, 2026),
      progresso: 100, cor: verde),
    tarefa(\"Prototipação\", data(10, 4, 2026), data(30, 4, 2026),
      progresso: 65, cor: azul),
    tarefa(\"Testes\", data(25, 4, 2026), data(15, 5, 2026),
      progresso: 20, cor: laranja),
    tarefa(\"Deploy\", data(10, 5, 2026), data(20, 5, 2026),
      progresso: 0, cor: roxo, rotulo: \"pendente\"),
  ),
)")
]

#cronograma(
  mostrar-rotulo: true,
  (
    tarefa("Análise", data(1, 4, 2026), data(14, 4, 2026),
      progresso: 100, cor: verde),
    tarefa("Prototipação", data(10, 4, 2026), data(30, 4, 2026),
      progresso: 65, cor: azul),
    tarefa("Testes", data(25, 4, 2026), data(15, 5, 2026),
      progresso: 20, cor: laranja),
    tarefa("Deploy", data(10, 5, 2026), data(20, 5, 2026),
      progresso: 0, cor: roxo, rotulo: "pendente"),
  ),
)

Quando `rotulo` é fornecido, ele substitui a porcentagem. "Deploy" mostra "pendente" em vez de "0%".

=== Linha "hoje"

O parâmetro `hoje` traça uma linha vertical tracejada (vermelha por padrão) que indica a data corrente --- útil para apresentações e acompanhamento de projetos.

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma(
  hoje: data(18, 6, 2026),
  cor-hoje: vermelho,
  (
    tarefa(\"Etapa 1\", data(1, 6, 2026), data(14, 6, 2026),
      progresso: 100, cor: verde),
    tarefa(\"Etapa 2\", data(10, 6, 2026), data(25, 6, 2026),
      progresso: 60, cor: azul),
    tarefa(\"Etapa 3\", data(22, 6, 2026), data(5, 7, 2026),
      cor: roxo),
  ),
)")
]

#cronograma(
  hoje: data(18, 6, 2026),
  cor-hoje: vermelho,
  (
    tarefa("Etapa 1", data(1, 6, 2026), data(14, 6, 2026),
      progresso: 100, cor: verde),
    tarefa("Etapa 2", data(10, 6, 2026), data(25, 6, 2026),
      progresso: 60, cor: azul),
    tarefa("Etapa 3", data(22, 6, 2026), data(5, 7, 2026),
      cor: roxo),
  ),
)

=== Grupos e marcos

Tarefas podem ser organizadas em grupos com `grupo: "Nome"`. Quando o nome do grupo muda entre tarefas consecutivas, uma linha separadora com o título em destaque é inserida automaticamente. Marcos (`marco: true`) são representados como losangos --- ideais para entregas ou _deadlines_.

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma(
  hoje: data(1, 5, 2026),
  (
    tarefa(\"Requisitos\", data(1, 3, 2026), data(20, 3, 2026),
      progresso: 100, cor: verde, grupo: \"Planejamento\"),
    tarefa(\"Aprovação\", data(20, 3, 2026), data(20, 3, 2026),
      marco: true, cor: verde, grupo: \"Planejamento\"),
    tarefa(\"Interface\", data(15, 3, 2026), data(10, 4, 2026),
      progresso: 80, cor: azul, grupo: \"Desenvolvimento\"),
    tarefa(\"Backend\", data(1, 4, 2026), data(5, 5, 2026),
      progresso: 50, cor: roxo, grupo: \"Desenvolvimento\"),
    tarefa(\"Testes\", data(1, 5, 2026), data(20, 5, 2026),
      cor: laranja, grupo: \"Qualidade\"),
    tarefa(\"Release v1\", data(20, 5, 2026), data(20, 5, 2026),
      marco: true, cor: vermelho),
  ),
)")
]

#cronograma(
  hoje: data(1, 5, 2026),
  (
    tarefa("Requisitos", data(1, 3, 2026), data(20, 3, 2026),
      progresso: 100, cor: verde, grupo: "Planejamento"),
    tarefa("Aprovação", data(20, 3, 2026), data(20, 3, 2026),
      marco: true, cor: verde, grupo: "Planejamento"),
    tarefa("Interface", data(15, 3, 2026), data(10, 4, 2026),
      progresso: 80, cor: azul, grupo: "Desenvolvimento"),
    tarefa("Backend", data(1, 4, 2026), data(5, 5, 2026),
      progresso: 50, cor: roxo, grupo: "Desenvolvimento"),
    tarefa("Testes", data(1, 5, 2026), data(20, 5, 2026),
      cor: laranja, grupo: "Qualidade"),
    tarefa("Release v1", data(20, 5, 2026), data(20, 5, 2026),
      marco: true, cor: vermelho),
  ),
)

=== Dependências entre tarefas

O parâmetro `depende-de` recebe um array com os nomes de tarefas predecessoras. Para exibir as setas de conexão, ative `mostrar-dependencias: true` (desativado por padrão). Setas em L conectam a parte inferior da barra predecessora ao lado esquerdo da barra dependente.

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma(
  mostrar-rotulo: true,
  mostrar-dependencias: true,
  (
    tarefa(\"Pesquisa\", data(1, 8, 2026), data(15, 8, 2026),
      progresso: 100, cor: verde),
    tarefa(\"Escrita\", data(12, 8, 2026), data(5, 9, 2026),
      progresso: 40, cor: azul,
      depende-de: (\"Pesquisa\",)),
    tarefa(\"Revisão\", data(1, 9, 2026), data(15, 9, 2026),
      cor: laranja,
      depende-de: (\"Escrita\",)),
    tarefa(\"Defesa\", data(15, 9, 2026), data(15, 9, 2026),
      marco: true, cor: vermelho,
      depende-de: (\"Revisão\",)),
  ),
)")
]

#cronograma(
  mostrar-rotulo: true,
  mostrar-dependencias: true,
  (
    tarefa("Pesquisa", data(1, 8, 2026), data(15, 8, 2026),
      progresso: 100, cor: verde),
    tarefa("Escrita", data(12, 8, 2026), data(5, 9, 2026),
      progresso: 40, cor: azul,
      depende-de: ("Pesquisa",)),
    tarefa("Revisão", data(1, 9, 2026), data(15, 9, 2026),
      cor: laranja,
      depende-de: ("Escrita",)),
    tarefa("Defesa", data(15, 9, 2026), data(15, 9, 2026),
      marco: true, cor: vermelho,
      depende-de: ("Revisão",)),
  ),
)

=== Personalização visual

O `cronograma` aceita diversos parâmetros para ajuste fino. Veja um exemplo com cor de fundo escura, barras maiores e grade discreta:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma(
  cor-padrao: oriental,
  cor-texto: white,
  cor-cabecalho: luma(60),
  cor-fundo: luma(45),
  cor-alternada: luma(55),
  cor-grade: luma(70),
  cor-hoje: amarelo,
  altura-linha: 28pt,
  raio-barra: 8pt,
  espessura-grade: 0.2pt,
  fonte-tarefa: 0.9em,
  hoje: data(15, 7, 2026),
  (
    tarefa(\"Modelagem\", data(1, 7, 2026), data(14, 7, 2026),
      progresso: 100, cor: agua),
    tarefa(\"Simulação\", data(10, 7, 2026), data(28, 7, 2026),
      progresso: 35, cor: oriental),
    tarefa(\"Validação\", data(25, 7, 2026), data(10, 8, 2026),
      cor: lima),
  ),
)")
]

#cronograma(
  cor-padrao: oriental,
  cor-texto: white,
  cor-cabecalho: luma(60),
  cor-fundo: luma(45),
  cor-alternada: luma(55),
  cor-grade: luma(70),
  cor-hoje: amarelo,
  altura-linha: 28pt,
  raio-barra: 8pt,
  espessura-grade: 0.2pt,
  fonte-tarefa: 0.9em,
  hoje: data(15, 7, 2026),
  (
    tarefa("Modelagem", data(1, 7, 2026), data(14, 7, 2026),
      progresso: 100, cor: agua),
    tarefa("Simulação", data(10, 7, 2026), data(28, 7, 2026),
      progresso: 35, cor: oriental),
    tarefa("Validação", data(25, 7, 2026), data(10, 8, 2026),
      cor: lima),
  ),
)

O tema escuro é conseguido com `cor-fundo`, `cor-alternada` e `cor-grade` em tons de `luma()` baixos, `cor-cabecalho` para o fundo do cabeçalho, e `cor-texto: white` para legibilidade.

=== Cronograma de TCC completo

Um exemplo realista com todas as funcionalidades combinadas: grupos, marcos, dependências, progresso e linha "hoje".

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma(
  largura: 100%,
  hoje: data(20, 5, 2026),
  mostrar-rotulo: true,
  mostrar-dependencias: true,
  (
    // --- Fase 1 ---
    tarefa(\"Revisão bibliográfica\", data(1, 3, 2026), data(15, 4, 2026),
      progresso: 100, cor: verde, grupo: \"Fundamentação\"),
    tarefa(\"Definição do problema\", data(1, 4, 2026), data(20, 4, 2026),
      progresso: 100, cor: verde, grupo: \"Fundamentação\",
      depende-de: (\"Revisão bibliográfica\",)),
    tarefa(\"Qualificação\", data(20, 4, 2026), data(20, 4, 2026),
      marco: true, cor: verde, grupo: \"Fundamentação\"),
    // --- Fase 2 ---
    tarefa(\"Coleta de dados\", data(21, 4, 2026), data(30, 5, 2026),
      progresso: 60, cor: azul, grupo: \"Desenvolvimento\",
      depende-de: (\"Definição do problema\",)),
    tarefa(\"Análise dos resultados\", data(15, 5, 2026), data(30, 6, 2026),
      progresso: 10, cor: azul, grupo: \"Desenvolvimento\"),
    // --- Fase 3 ---
    tarefa(\"Redação final\", data(15, 6, 2026), data(31, 7, 2026),
      cor: roxo, grupo: \"Finalização\"),
    tarefa(\"Revisão do orientador\", data(15, 7, 2026), data(10, 8, 2026),
      cor: laranja, grupo: \"Finalização\",
      depende-de: (\"Redação final\",)),
    tarefa(\"Defesa\", data(15, 8, 2026), data(15, 8, 2026),
      marco: true, cor: vermelho,
      depende-de: (\"Revisão do orientador\",)),
  ),
)")
]

#cronograma(
  largura: 100%,
  hoje: data(20, 5, 2026),
  mostrar-rotulo: true,
  (
    tarefa("Revisão bibliográfica", data(1, 3, 2026), data(15, 4, 2026),
      progresso: 100, cor: verde, grupo: "Fundamentação"),
    tarefa("Definição do problema", data(1, 4, 2026), data(20, 4, 2026),
      progresso: 100, cor: verde, grupo: "Fundamentação",
      depende-de: ("Revisão bibliográfica",)),
    tarefa("Qualificação", data(20, 4, 2026), data(20, 4, 2026),
      marco: true, cor: verde, grupo: "Fundamentação"),
    tarefa("Coleta de dados", data(21, 4, 2026), data(30, 5, 2026),
      progresso: 60, cor: azul, grupo: "Desenvolvimento",
      depende-de: ("Definição do problema",)),
    tarefa("Análise dos resultados", data(15, 5, 2026), data(30, 6, 2026),
      progresso: 10, cor: azul, grupo: "Desenvolvimento"),
    tarefa("Redação final", data(15, 6, 2026), data(31, 7, 2026),
      cor: roxo, grupo: "Finalização"),
    tarefa("Revisão do orientador", data(15, 7, 2026), data(10, 8, 2026),
      cor: laranja, grupo: "Finalização",
      depende-de: ("Redação final",)),
    tarefa("Defesa", data(15, 8, 2026), data(15, 8, 2026),
      marco: true, cor: vermelho,
      depende-de: ("Revisão do orientador",)),
  ),
)

=== Tarefa de 1 dia e nomes longos

Tarefas com início igual ao fim recebem uma barra com largura mínima garantida para permanecerem visíveis. *Se os nomes das tarefas ficarem sobrepostos ou cortados, aumente `altura-linha`* para que o texto caiba em duas linhas dentro de cada faixa. Espaço vertical é barato; horizontal é limitado pelas margens. No exemplo abaixo, `altura-linha: 32pt` acomoda nomes longos como "Workshop de integração contínua":

#exemplo-doc[
  #raw(block: true, lang: "typst", "#cronograma(
  altura-linha: 32pt,
  (
    tarefa(\"Reunião de alinhamento\", data(1, 10, 2026), data(1, 10, 2026),
      cor: laranja),
    tarefa(\"Workshop de integração contínua\", data(1, 10, 2026), data(3, 10, 2026),
      cor: azul),
    tarefa(\"Sprint 1\", data(1, 10, 2026), data(14, 10, 2026), cor: roxo),
    tarefa(\"Sprint 2\", data(15, 10, 2026), data(28, 10, 2026), cor: verde),
    tarefa(\"Entrega\", data(28, 10, 2026), data(28, 10, 2026),
      marco: true, cor: vermelho),
  ),
)")
]

#cronograma(
  altura-linha: 32pt,
  (
    tarefa("Reunião de alinhamento", data(1, 10, 2026), data(1, 10, 2026),
      cor: laranja),
    tarefa("Workshop de integração contínua", data(1, 10, 2026), data(3, 10, 2026),
      cor: azul),
    tarefa("Sprint 1", data(1, 10, 2026), data(14, 10, 2026), cor: roxo),
    tarefa("Sprint 2", data(15, 10, 2026), data(28, 10, 2026), cor: verde),
    tarefa("Entrega", data(28, 10, 2026), data(28, 10, 2026),
      marco: true, cor: vermelho),
  ),
)

Alternativamente, se os nomes forem longos mas couberem em uma única linha, aumente `largura-nomes` (padrão: `8em`). Exemplo: `largura-nomes: 12em`.

=== Referência de parâmetros

A tabela a seguir resume todos os parâmetros aceitos por `#cronograma()`:

#figure(
  table(
    columns: (auto, auto, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`tarefas`], [---], [Array de tarefas (obrigatório). Use `tarefa()` para criar.],
    [`inicio`], [`auto`], [Data de início do gráfico. `auto` = mais cedo das tarefas.],
    [`fim`], [`auto`], [Data de fim do gráfico. `auto` = mais tarde + 2 dias.],
    [`largura`], [`100%`], [Largura total do gráfico.],
    [`altura-linha`], [`22pt`], [Altura de cada linha de tarefa.],
    [`largura-nomes`], [`8em`], [Largura da coluna de nomes à esquerda.],
    [`cabecalho`], [`"mes-semana"`], [Modo do cabeçalho: `"mes-semana"`, `"mes-dia"`, `"semana"` ou `"dia"`.],
    [`meses-pt`], [`true`], [Nomes dos meses em português (Jan, Fev, ...).],
    [`cor-cabecalho`], [`auto`], [Cor de fundo do cabeçalho. `auto` = derivada de `cor-padrao`.],
    [`cor-padrao`], [`azul`], [Cor padrão das barras (quando a tarefa não especifica).],
    [`cor-texto`], [`auto`], [Cor do texto dos nomes das tarefas. `auto` = herda do contexto. Use `white` para temas escuros.],
    [`cor-fundo`], [`branco`], [Cor de fundo geral do gráfico.],
    [`cor-alternada`], [`luma(248)`], [Cor de fundo das linhas ímpares.],
    [`cor-grade`], [`luma(220)`], [Cor das linhas de grade.],
    [`raio-barra`], [`4pt`], [Raio dos cantos arredondados das barras.],
    [`espessura-grade`], [`0.3pt`], [Espessura das linhas de grade.],
    [`mostrar-progresso`], [`true`], [Exibir barra de progresso (preenchimento parcial).],
    [`cor-progresso`], [`auto`], [Cor do progresso. `auto` = cor da barra escurecida.],
    [`hoje`], [`none`], [Data "hoje" para a linha vertical tracejada. `none` = sem linha.],
    [`cor-hoje`], [`vermelho`], [Cor da linha "hoje".],
    [`mostrar-dependencias`], [`false`], [Desenhar setas de dependência entre tarefas.],
    [`cor-dependencia`], [`cinza`], [Cor das setas de dependência.],
    [`fonte-tarefa`], [`0.85em`], [Tamanho da fonte dos nomes de tarefa.],
    [`fonte-cabecalho`], [`0.8em`], [Tamanho da fonte do cabeçalho.],
    [`mostrar-rotulo`], [`false`], [Exibir texto (% ou rótulo) dentro das barras.],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros da função `cronograma()`],
  kind: table,
)

Os parâmetros de `tarefa()`:

#figure(
  table(
    columns: (auto, auto, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`nome`], [---], [Nome da tarefa (obrigatório). Aparece na coluna à esquerda.],
    [`inicio`], [---], [Data de início (obrigatório). Use `data(dia, mes, ano)`.],
    [`fim`], [---], [Data de fim (obrigatório). Use `data(dia, mes, ano)`.],
    [`cor`], [`auto`], [Cor da barra. `auto` = usa `cor-padrao` do cronograma.],
    [`progresso`], [`none`], [Porcentagem concluída (0--100). `none` = sem indicador.],
    [`grupo`], [`none`], [Nome do grupo. Agrupa tarefas com separador visual.],
    [`marco`], [`false`], [Se `true`, renderiza como losango (diamond) em vez de barra.],
    [`depende-de`], [`()`], [Array de nomes de tarefas predecessoras.],
    [`rotulo`], [`none`], [Texto personalizado dentro da barra (substitui a %).],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros da função `tarefa()`],
  kind: table,
)

// ============================================================================
// CAPÍTULO 8: CONFIGURAÇÃO DE PÁGINA EM PORTUGUÊS
// ============================================================================

#pagebreak()

= Configuração de Página em Português

O Typst usa nomes em inglês para as propriedades de `page()` e `pagebreak()`. O FerrMat oferece wrappers que traduzem esses nomes para português, facilitando a escrita de documentos sem precisar consultar a documentação em inglês.

== `configurar-pagina` -- configurar a página

A função `configurar-pagina` é usada como show-rule e aceita todos os parâmetros principais de `set page()` com nomes em português:

```typst
#show: configurar-pagina.with(
  papel: "a4",
  margem: (superior: 3cm, inferior: 2cm, esquerda: 3cm, direita: 2cm),
  numeracao: "1",
)
```

Equivalente nativo do Typst:

```typst
#set page(
  paper: "a4",
  margin: (top: 3cm, bottom: 2cm, left: 3cm, right: 2cm),
  numbering: "1",
)
```

#figure(
  table(
    columns: (auto, auto, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro PT*], [*Original EN*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`papel`], [`paper`], [Tamanho do papel: `"a4"`, `"a5"`, `"us-letter"`, etc.],
    [`largura`], [`width`], [Largura da página (alternativa a `papel`).],
    [`altura`], [`height`], [Altura da página (alternativa a `papel`).],
    [`margem`], [`margin`], [Margens. Valor único (ex: `2cm`) ou dicionário com chaves em PT.],
    [`paisagem`], [`flipped`], [Se `true`, troca largura e altura (modo paisagem).],
    [`colunas`], [`columns`], [Número de colunas de texto (padrão: 1).],
    [`preenchimento`], [`fill`], [Cor de fundo da página.],
    [`numeracao`], [`numbering`], [Padrão de numeração: `"1"`, `"i"`, `"a"`, `none`, etc.],
    [`alinhamento-numero`], [`number-align`], [Alinhamento do número de página (ex: `center`).],
    [`cabecalho`], [`header`], [Conteúdo do cabeçalho.],
    [`rodape`], [`footer`], [Conteúdo do rodapé.],
    [`pre-cabecalho`], [`header-ascent`], [Espaço entre o cabeçalho e o topo do corpo.],
    [`pre-rodape`], [`footer-descent`], [Espaço entre o rodapé e a base do corpo.],
    [`encadernacao`], [`binding`], [Lado da encadernação (`left` ou `right`).],
    [`plano-de-fundo`], [`background`], [Conteúdo posicionado atrás do corpo.],
    [`primeiro-plano`], [`foreground`], [Conteúdo posicionado à frente do corpo.],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `configurar-pagina()`],
  kind: table,
)

=== Chaves de margem em português

Quando `margem` recebe um dicionário, as chaves podem ser em português:

#figure(
  table(
    columns: (1fr, 1fr, 2fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Chave PT*], [*Chave EN*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`superior`], [`top`], [Margem superior],
    [`inferior`], [`bottom`], [Margem inferior],
    [`esquerda`], [`left`], [Margem esquerda],
    [`direita`], [`right`], [Margem direita],
    [`interna`], [`inside`], [Margem interna (para encadernação)],
    [`externa`], [`outside`], [Margem externa (para encadernação)],
    [`resto`], [`rest`], [Valor padrão para chaves não especificadas],
    [`x`], [`x`], [Atalho para esquerda + direita],
    [`y`], [`y`], [Atalho para superior + inferior],
    table.hline(stroke: 1pt),
  ),
  caption: [Chaves de margem em português],
  kind: table,
)

As chaves originais em inglês também são aceitas, permitindo migração gradual.

== `margem` -- helper para margens

A função `margem()` constrói o dicionário de margens com parâmetros nomeados, evitando a sintaxe de dicionário:

```typst
// Com dicionário (funciona igualmente):
#show: configurar-pagina.with(
  margem: (superior: 3cm, inferior: 2cm, esquerda: 3cm, direita: 2cm),
)

// Com a função margem():
#show: configurar-pagina.with(
  margem: margem(superior: 3cm, inferior: 2cm, esquerda: 3cm, direita: 2cm),
)
```

Para documentos com encadernação frente-e-verso, use `interna`/`externa` em vez de `esquerda`/`direita`:

```typst
#show: configurar-pagina.with(
  margem: margem(superior: 3cm, inferior: 2cm, interna: 3cm, externa: 2cm),
)
```

== `quebra-pagina` -- quebra de página

Wrapper para `pagebreak()` com parâmetros em português:

```typst
#quebra-pagina()                       // quebra simples
#quebra-pagina(fraco: true)            // só quebra se não estiver no topo
#quebra-pagina(para: "impar")          // pula até a próxima página ímpar
#quebra-pagina(para: "par")            // pula até a próxima página par
```

#figure(
  table(
    columns: (auto, auto, auto, 1fr),
    stroke: none,
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro PT*], [*Original EN*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`fraco`], [`weak`], [`false`], [Se `true`, evita quebra se já estiver no topo da página.],
    [`para`], [`to`], [`none`], [`"impar"` ou `"par"` para pular até página ímpar/par.],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `quebra-pagina()`],
  kind: table,
)

== Exemplo completo

```typst
#import "@preview/ferrmat:0.1.0": *

#show: configurar-pagina.with(
  papel: "a4",
  margem: margem(superior: 3cm, inferior: 2cm, esquerda: 3cm, direita: 2cm),
  numeracao: "1",
  preenchimento: luma(252),
  cabecalho: align(right)[Meu Documento],
  rodape: align(center)[Página #context counter(page).display()],
)

= Introdução

Conteúdo do documento...

#quebra-pagina()

= Segunda seção

Mais conteúdo...
```

#pagebreak()

// ============================================================================
// APÊNDICE A: TABELA DE SÍMBOLOS EM PORTUGUÊS
// ============================================================================

#heading(level: 1, numbering: none)[APÊNDICE A -- Símbolos Matemáticos em Português]
#label("apendice-a")

#set heading(numbering: "A.1")
#counter(heading).update((0,))

== Operadores binários

Os nomes em português são fornecidos pelo FerrMat. Os símbolos nativos do Typst usam nomes em inglês (`times`, `plus.minus`, `and`, `union`, etc.).

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`+`], [$+$], [`-`], [$-$], [`vezes`], [$times$],
    [`div`], [$div$], [`maisMenos`], [$plus.minus$], [`menosMais`], [$minus.plus$],
    [`pontoMedio`], [$dot$], [`ast`], [$ast$], [`estrela`], [$star$],
    [`circulo`], [$circle.small$], [`marcador`], [$bullet$], [`losango`], [$diamond$],
    [`eLogico`], [$and$], [`ou`], [$or$], [`ouExclusivo`], [$xor$],
    [`uniao`], [$union$], [`inter`], [$inter$], [`sem`], [$without$],
    table.hline(stroke: 1pt),
  ),
  caption: [Operadores binários],
  kind: table,
)

== Relações

Os nomes em português (`aprox`, `pertence`, `estaContido`, `contem`, `proporcional`, etc.) são fornecidos pelo FerrMat. Os símbolos nativos do Typst usam nomes em inglês (`approx`, `in`, `subset`, `supset`, `prop`, etc.).

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`=`], [$=$], [`!=`], [$!=$], [`<`], [$<$],
    [`>`], [$>$], [`<= `], [$<=$], [`>=`], [$>=$],
    [`aprox`], [$approx$], [`equiv`], [$equiv$], [`tilde`], [$tilde$],
    [`precede`], [$prec$], [`sucede`], [$succ$], [`tilde.eq`], [$tilde.eq$],
    [`estaContido`], [$subset$], [`contem`], [$supset$], [`pertence`], [$in$],
    [`estaContido.eq`], [$subset.eq$], [`contem.eq`], [$supset.eq$], [`pertence.nao`], [$in.not$],
    [`proporcional`], [$prop$], [`paralelo`], [$parallel$], [`perpendicular`], [$perp$],
    table.hline(stroke: 1pt),
  ),
  caption: [Símbolos de relação],
  kind: table,
)

== Setas

As setas `->`, `<-` e `<->` são atalhos nativos do Typst. As demais (`implica`, `sse`, `seta.*`) são fornecidas pelo FerrMat.

A função `seta` usa subcampos direcionais baseados nas teclas WASD: *w* = cima (↑), *a* = esquerda (←), *s* = baixo (↓), *d* = direita (→). Combinações como `seta.w.s` (↕) e `seta.a.d` (↔) indicam dupla direção.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`->`], [$->$], [`<-`], [$<-$], [`<->`], [$<->$],
    [`implica`], [$=>$], [`sse`], [$<=>$], [], [],
    [`seta.w`], [$arrow.t$], [`seta.s`], [$arrow.b$], [`seta.w.s`], [$arrow.t.b$],
    [`seta.d.longa`], [$arrow.r.long$], [`seta.a.longa`], [$arrow.l.long$], [`seta.a.d.longa`], [$arrow.l.r.long$],
    [`seta.mapa`], [$|->$], [`seta.gancho`], [$arrow.hook$], [`seta.d.cauda`], [$arrow.r.tail$],
    table.hline(stroke: 1pt),
  ),
  caption: [Setas],
  kind: table,
)

== Símbolos diversos

Os nomes em português (`infinito`, `vazio`, `portanto`, `pois`, `paraTodo`, `existe`, `nao`, `alef`, `reticencias`) são fornecidos pelo FerrMat. Os equivalentes nativos do Typst são `infinity`, `emptyset`, `therefore`, `because`, `forall`, `exists`, `not`, `aleph`, `dots`.

#figure(
  table(
    columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
    stroke: none,
    inset: 5pt,
    table.hline(stroke: 1pt),
    [*Código*], [*Símbolo*], [*Código*], [*Símbolo*], [*Código*], [*Símbolo*],
    table.hline(stroke: 0.5pt),
    [`infinito`], [$infinito$], [`vazio`], [$emptyset$], [`portanto`], [$therefore$],
    [`pois`], [$because$], [`paraTodo`], [$forall$], [`existe`], [$exists$],
    [`nao`], [$not$], [`parcial`], [$partial$], [`nabla`], [$nabla$],
    [`ell`], [$ell$], [`planck`], [$planck$], [`Re`], [$Re$],
    [`Im`], [$Im$], [`alef`], [$aleph$], [`reticencias`], [$dots$],
    table.hline(stroke: 1pt),
  ),
  caption: [Símbolos diversos],
  kind: table,
)

// ============================================================================
// REFERÊNCIAS
// ============================================================================

#pagebreak()

#heading(level: 1, numbering: none)[REFERÊNCIAS]

#set par(
  hanging-indent: 1.25cm,
  first-line-indent: 0pt,
)

ANDRADE, Lenimar Nunes de. *Breve Introdução ao LaTeX 2ε*. Versão 2.1. João Pessoa: UFPB, 2000. Disponível em: ftp:\/\/mat.ufpb.br/pub/textos/tex/. Acesso em: 15 jan. 2026.
