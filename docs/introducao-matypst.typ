// Breve Introdução ao Matypst
// Documentação do pacote Matypst
// Caixas decorativas, ambientes matemáticos e código estilizado para Typst

#import "../../ABNTypst/lib.typ": *
#import "../lib.typ": *

#show: livro.with(
  titulo: "Breve Introdução ao Matypst",
  autor: "Matypst",
  editora: "",
  local: "",
  ano: 2026,
  fonte: "Times New Roman",
)

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
// Usa nome diferente de `exemplo` para evitar colisão com o ambiente matemático do Matypst
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

  #text(size: 36pt, weight: "bold")[Matypst]

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

#book-toc(profundidade: 3)

// ============================================================================
// PREFÁCIO
// ============================================================================

#book-preface(titulo: "PREFÁCIO")[
  O *Matypst* é um pacote companheiro do ABNTypst, fornecendo utilitários genéricos para Typst que não dependem de normas ABNT: caixas decorativas, ambientes matemáticos com numeração automática, estilização de código e funções matemáticas em português.

  Enquanto o ABNTypst cuida da formatação conforme normas ABNT (capa, folha de rosto, citações, referências), o Matypst oferece componentes visuais e matemáticos que podem ser usados em qualquer documento Typst --- com ou sem ABNTypst.

  O Capítulo 1 apresenta o Matypst e explica como instalá-lo. O Capítulo 2 cobre as caixas decorativas (`caixa` e `caixa-estilo`). O Capítulo 3 trata da estilização de código (`codigo-inline` e `codigo-bloco`).

  O Capítulo 4 apresenta os fundamentos do modo matemático em Typst. O Capítulo 5 apresenta as funções matemáticas em português: letras gregas, frações, raízes, derivadas, integrais, matrizes e delimitadores. O Capítulo 6 cobre os ambientes matemáticos (teoremas, definições, demonstrações) com numeração configurável e estilos visuais. O Capítulo 7 aborda diagramas e gráficos com os pacotes `fletcher`, `cetz` e `cetz-plot`.

  O Apêndice A contém tabelas de referência para todos os símbolos matemáticos em português fornecidos pelo Matypst.

  #v(1cm)

  #align(right)[
    Jataí, janeiro de 2026

    _Equipe Matypst_
  ]
]

// ============================================================================
// CAPÍTULO 1: O QUE É O MATYPST
// ============================================================================

#book-start-numbering()

= O que é o Matypst

== Visão geral

O Matypst é um pacote para Typst que fornece três funcionalidades principais:

+ *Caixas decorativas* --- blocos visuais configuráveis com título, cor, borda e estilos reutilizáveis (similar ao `tcolorbox` do LaTeX).

+ *Estilização de código* --- formatação de código inline e em bloco, com título, numeração de linhas e destaque de sintaxe.

+ *Matemática em português* --- operadores (`sen`), letras gregas (`alfa`, `gama`, `teta`), frações (`fracao`), raízes (`raiz`), derivadas (`leibniz`, `parcial`), integrais, matrizes, delimitadores, vetores e ambientes matemáticos (teoremas, definições, demonstrações) com numeração automática.

== Instalação e importação

Para usar o Matypst, importe-o no início do documento:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/matypst:0.1.0\": *")
]

Durante o desenvolvimento local, importe diretamente do caminho:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"caminho/para/matypst/lib.typ\": *")
]

== Usando com ABNTypst

O Matypst pode ser combinado com o ABNTypst para documentos acadêmicos brasileiros com recursos matemáticos avançados:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/abntypst:0.1.0\": *
#import \"@preview/matypst:0.1.0\": *

#show: abntcc.with(
  titulo: \"Meu TCC\",
  autor: \"Fulano de Tal\",
  // ...
)

#definicao[Um grupo é um conjunto $G$ munido de uma operação...]
#teorema(titulo: [de Lagrange])[Se $H$ é subgrupo de $G$...]")
]

== Usando sem ABNTypst

O Matypst não depende do ABNTypst. Pode ser usado em qualquer documento Typst:

#exemplo-doc[
  #raw(block: true, lang: "typst", "#import \"@preview/matypst:0.1.0\": *

#set page(paper: \"a4\", margin: 2cm)
#set text(lang: \"pt\", size: 12pt)

= Meu documento

#caixa(titulo: \"Nota\", cor: blue)[
  Uma caixa decorativa sem depender do ABNTypst.
]

$sen(x)$, $fracao(a, b)$, $raiz(2)$

#definicao[Um anel é um conjunto munido de duas operações...]")
]

#pagebreak()

// ============================================================================
// CAPÍTULO 2: CAIXAS DECORATIVAS
// ============================================================================

= Caixas Decorativas

O Matypst fornece duas funções para criar blocos visuais: `caixa()` para uso direto e `caixa-estilo()` para criar estilos reutilizáveis.

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
    [`titulo`], [`none`], [Título da caixa (exibido em barra superior)],
    [`cor`], [`blue`], [Cor principal (borda e fundo derivado)],
    [`borda`], [`"left"`], [Posição da borda: `"left"`, `"top"`, `"full"` ou `"none"`],
    [`espessura`], [`2pt`], [Espessura da borda],
    [`raio`], [`0pt`], [Raio dos cantos arredondados],
    [`preenchimento`], [`auto`], [Cor de fundo (auto = cor clara derivada)],
    [`titulo-fundo`], [`auto`], [Cor de fundo do título],
    [`titulo-cor`], [`black`], [Cor do texto do título],
    [`recuo`], [`1em`], [Espaçamento interno],
    [`largura`], [`100%`], [Largura da caixa],
    [`quebravel`], [`true`], [Se pode quebrar entre páginas],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `caixa()`],
  kind: table,
)

=== Com título

#exemplo-doc[
  #raw(block: true, lang: "typst", "#caixa(titulo: \"Informação\", cor: blue)[
  Uma caixa com título e borda esquerda.
]")
]

#caixa(titulo: "Informação", cor: blue)[
  Uma caixa com título e borda esquerda.
]

=== Estilos de borda

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Borda superior
#caixa(titulo: \"Atenção\", cor: orange, borda: \"top\")[
  Uma caixa com borda no topo.
]

// Borda completa com cantos arredondados
#caixa(titulo: \"Aviso\", cor: red, borda: \"full\", raio: 4pt)[
  Uma caixa com borda completa e cantos arredondados.
]

// Sem borda
#caixa(cor: green, borda: \"none\")[
  Uma caixa sem borda, apenas com preenchimento.
]")
]

#caixa(titulo: "Atenção", cor: orange, borda: "top")[
  Uma caixa com borda no topo.
]

#caixa(titulo: "Aviso", cor: red, borda: "full", raio: 4pt)[
  Uma caixa com borda completa e cantos arredondados.
]

#caixa(cor: green, borda: "none")[
  Uma caixa sem borda, apenas com preenchimento.
]

=== Cores customizadas

#exemplo-doc[
  #raw(block: true, lang: "typst", "#caixa(
  titulo: \"Customizada\",
  cor: purple,
  preenchimento: purple.lighten(95%),
  titulo-fundo: purple.lighten(70%),
  titulo-cor: white,
  borda: \"full\",
  espessura: 1.5pt,
  raio: 6pt,
)[
  Caixa com todas as cores customizadas.
]")
]

#caixa(
  titulo: "Customizada",
  cor: purple,
  preenchimento: purple.lighten(95%),
  titulo-fundo: purple.lighten(70%),
  titulo-cor: white,
  borda: "full",
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
    [`prefixo`], [`none`], [Rótulo do ambiente (ex: "Nota", "Aviso")],
    [`contador`], [`none`], [Chave de contador para numeração automática],
    [`numeracao`], [`"1"`], [Formato de numeração],
    [`por-secao`], [`false`], [Se numera por seção (ex: "1.1", "1.2")],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros extras de `caixa-estilo()`],
  kind: table,
)

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Criar estilo \"Nota\" com numeração automática
#let nota = caixa-estilo(
  cor: orange,
  borda: \"full\",
  raio: 3pt,
  prefixo: \"Nota\",
  contador: \"nota\",
)

#nota[Primeira nota: lembre-se de importar o Matypst.]

#nota[Segunda nota: a numeração é automática.]

// Estilo sem numeração
#let aviso = caixa-estilo(
  cor: red,
  borda: \"top\",
  prefixo: \"Aviso\",
)

#aviso[Cuidado com divisão por zero!]")
]

#let nota = caixa-estilo(
  cor: orange,
  borda: "full",
  raio: 3pt,
  prefixo: "Nota",
  contador: "nota",
)

#nota[Primeira nota: lembre-se de importar o Matypst.]

#nota[Segunda nota: a numeração é automática.]

#let aviso = caixa-estilo(
  cor: red,
  borda: "top",
  prefixo: "Aviso",
)

#aviso[Cuidado com divisão por zero!]

#pagebreak()

// ============================================================================
// CAPÍTULO 3: ESTILIZAÇÃO DE CÓDIGO
// ============================================================================

= Estilização de Código

O Matypst fornece duas funções para exibir código-fonte com formatação visual.

== Código inline

A função `codigo-inline()` exibe código no meio do texto, com fundo destacado:

#exemplo-doc[
  #raw(block: true, lang: "typst", "O comando #codigo-inline(`print(\"hello\")`) imprime uma saudação.

Use #codigo-inline(`pip install matypst`) para instalar.")
]

O comando #codigo-inline(`print("hello")`) imprime uma saudação.

Use #codigo-inline(`pip install matypst`) para instalar.

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
    println!(\"Hello, matypst!\");
}
```.text,
)")
]

#codigo-bloco(
  lang: "rust",
  titulo: "main.rs",
  ```
fn main() {
    println!("Hello, matypst!");
}
```.text,
)

=== Com numeração de linhas

#exemplo-doc[
  #raw(block: true, lang: "typst", "#codigo-bloco(
  lang: \"javascript\",
  titulo: \"app.js\",
  numerar-linhas: true,
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
  numerar-linhas: true,
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
    [`lang`], [`none`], [Linguagem para destaque de sintaxe],
    [`titulo`], [`none`], [Título exibido em barra superior],
    [`cor`], [`luma(245)`], [Cor de fundo do bloco],
    [`borda`], [`(left: 2pt + luma(180))`], [Estilo da borda],
    [`raio`], [`0pt`], [Raio dos cantos],
    [`numerar-linhas`], [`false`], [Se exibe números de linha],
    table.hline(stroke: 1pt),
  ),
  caption: [Parâmetros de `codigo-bloco()`],
  kind: table,
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
    return a + b\", bloco: true, lang: \"python\")")
]

#code("def soma(a, b):
    return a + b", bloco: true, lang: "python")

=== Bloco com numeração de linhas

#exemplo-doc[
  #raw(block: true, lang: "typst", "#code(\"const x = 1;
const y = 2;
console.log(x + y);\", bloco: true, lang: \"javascript\", numerar-linhas: true)")
]

#code("const x = 1;
const y = 2;
console.log(x + y);", bloco: true, lang: "javascript", numerar-linhas: true)

=== Bloco com título

#exemplo-doc[
  #raw(block: true, lang: "typst", "#code(\"fn main() {
    println!(\\\"Hello!\\\");
}\", bloco: true, lang: \"rust\", titulo: \"main.rs\")")
]

#code("fn main() {
    println!(\"Hello!\");
}", bloco: true, lang: "rust", titulo: "main.rs")

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Parâmetro*], [*Padrão*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`bloco`], [`false`], [Se `true`, exibe como bloco em vez de inline],
    [`lang`], [`none`], [Linguagem para destaque (apenas em bloco)],
    [`titulo`], [`none`], [Título do bloco (apenas em bloco)],
    [`numerar-linhas`], [`false`], [Se exibe números de linha (apenas em bloco)],
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

#pagebreak()

// ============================================================================
// CAPÍTULO 5: MATEMÁTICA EM PORTUGUÊS
// ============================================================================

= Matemática em Português

O Matypst fornece funções que traduzem operadores, símbolos e construções matemáticas do Typst para o português. Todas as funções são wrappers sobre os equivalentes nativos --- não adicionam funcionalidade nova, apenas tornam o código mais natural para falantes de português.

== Operadores

O Matypst fornece o operador `sen` (seno em português), que substitui o `sin` padrão do Typst:

#exemplo-doc[
  #raw(block: true, lang: "typst", "$sen(x)$, $cos(x)$, $tan(x)$
$log(x)$, $ln(x)$, $exp(x)$
$lim_(x -> 0) f(x)$
$max(a, b)$, $min(a, b)$")

  Resultado: $sen(x)$, $cos(x)$, $tan(x)$, $log(x)$, $ln(x)$, $exp(x)$
]

As demais funções (`cos`, `tan`, `log`, `ln`, `exp`, `lim`, `max`, `min`) são nativas do Typst e têm o mesmo nome em português.

== Letras gregas

O Matypst fornece nomes em português para as letras gregas que diferem do inglês. As letras que já possuem o mesmo nome em ambas as línguas (`beta`, `delta`, `epsilon`, `zeta`, `eta`, `iota`, `lambda`, `pi`, `sigma`, `tau`, `psi`, `omega`) podem ser usadas diretamente.

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
    [`capa`], [$capa$], [`lambda`], [$lambda$], [`mi`], [$mi$],
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
    [`teta.alt`], [$teta.alt$], [`capa.alt`], [$capa.alt$], [`ro.alt`], [$ro.alt$], [`fi.alt`], [$fi.alt$],
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

O Matypst fornece `leibniz()` para a notação de Leibniz e `parcial()` para derivadas parciais.

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

Variantes disponíveis: `integral.dupla`, `.tripla`, `.quadrupla`, `.contorno`, `.traco`, `.traco.dupla`, `.inter`, `.seta.gancho`.

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
$hat(x)$, $hat(i)$, $hat(j)$, $hat(k)$

// Til
$tilde(x)$")
]

$vetor(v)$, $vetor(A B)$, $vetorNegrito(v)$, $vetorNegrito(F)$, $conjugado(z)$, $segmento(A B)$, $hat(x)$, $tilde(x)$

== Matrizes e determinantes

O Matypst fornece quatro funções para matrizes, cada uma com seu delimitador:

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

No Typst, equações entre `$ ... $` (com espaço) ficam em _destaque_ e equações `$...$` (sem espaço) ficam _inline_. O Matypst oferece funções para forçar o tamanho:

#figure(
  table(
    columns: (auto, auto, 1fr),
    inset: 6pt,
    table.hline(stroke: 1pt),
    [*Matypst*], [*LaTeX*], [*Descrição*],
    table.hline(stroke: 0.5pt),
    [`exibicao()`], [`\displaystyle`], [Força tamanho de destaque (o maior)],
    [`emLinha()`], [`\textstyle`], [Força tamanho inline],
    [`subscrito()`], [`\scriptstyle`], [Tamanho de sub/sobrescrito],
    [`subSubscrito()`], [`\scriptscriptstyle`], [Tamanho de sub/sobrescrito de 2º nível (o menor)],
    table.hline(stroke: 1pt),
  ),
  caption: [Funções de tamanho matemático],
  kind: table,
)

Todas aceitam o parâmetro `compacto:` (`false` por padrão em `exibicao`/`emLinha`, `true` em `subscrito`/`subSubscrito`), que restringe a altura dos expoentes.

#exemplo-doc[
  #raw(block: true, lang: "typst", "// Sem exibicao(): somatório inline fica compacto
Temos $sum_(i=1)^n x_i$ como resultado.

// Com exibicao(): somatório inline fica grande como destaque
Temos $exibicao(sum_(i=1)^n x_i)$ como resultado.

// Inverso: forçar inline dentro de destaque
$ emLinha(sum_(i=1)^n x_i) quad \"versus\" quad sum_(i=1)^n x_i $")
]

Sem `exibicao`: temos $sum_(i=1)^n x_i$ como resultado. Com `exibicao`: temos $exibicao(sum_(i=1)^n x_i)$ como resultado.

#pagebreak()

// ============================================================================
// CAPÍTULO 6: AMBIENTES MATEMÁTICOS
// ============================================================================

= Ambientes Matemáticos

O Matypst fornece 14 ambientes matemáticos pré-configurados com caixas coloridas, numeração automática e três estilos visuais.

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
  caption: [Ambientes matemáticos disponíveis no Matypst],
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
- *por-secao*: `false` (padrão) ou `true`
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
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\", por-secao: true)

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
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"unificado\", por-secao: true)

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
  #raw(block: true, lang: "typst", "#show: configurar-numeracao(\"por-tipo\", por-secao: true, nivel: 2)

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
  #raw(block: true, lang: "typst", "#show: num-equacao(por-secao: true, nivel: 2)")
]

== Estilos visuais

O Matypst suporta três estilos globais, controlados por `configurar-ambientes`:

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
  cor: purple,
  espessura: 5pt,
  prefixo: \"Hipótese\",
  contador: \"hipotese\",
)

#hipotese[Toda função contínua em $[a,b]$ é integrável.]")
]

#let hipotese = ambiente-matematico(
  cor: purple,
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

#pagebreak()

// ============================================================================
// APÊNDICE A: TABELA DE SÍMBOLOS EM PORTUGUÊS
// ============================================================================

#heading(level: 1, numbering: none)[APÊNDICE A -- Símbolos Matemáticos em Português]
#label("apendice-a")

#set heading(numbering: "A.1")
#counter(heading).update((0,))

== Operadores binários

Os nomes em português são fornecidos pelo Matypst. Os símbolos nativos do Typst usam nomes em inglês (`times`, `plus.minus`, `and`, `union`, etc.).

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
    [`ponto`], [$dot$], [`ast`], [$ast$], [`estrela`], [$star$],
    [`circulo`], [$circle.small$], [`marcador`], [$bullet$], [`losango`], [$diamond$],
    [`eLogico`], [$and$], [`ou`], [$or$], [`ouExclusivo`], [$xor$],
    [`uniao`], [$union$], [`inter`], [$inter$], [`sem`], [$without$],
    table.hline(stroke: 1pt),
  ),
  caption: [Operadores binários],
  kind: table,
)

== Relações

Os nomes em português (`aprox`, `pertence`, `estaContido`, `contem`, `proporcional`, etc.) são fornecidos pelo Matypst. Os símbolos nativos do Typst usam nomes em inglês (`approx`, `in`, `subset`, `supset`, `prop`, etc.).

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

As setas `->`, `<-` e `<->` são atalhos nativos do Typst. As demais (`implica`, `sse`, `seta.*`) são fornecidas pelo Matypst.

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

Os nomes em português (`infinito`, `vazio`, `portanto`, `pois`, `paraTodo`, `existe`, `nao`, `alef`, `reticencias`) são fornecidos pelo Matypst. Os equivalentes nativos do Typst são `infinity`, `emptyset`, `therefore`, `because`, `forall`, `exists`, `not`, `aleph`, `dots`.

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
