#import "lib.typ": *

#set page(margin: 2cm)
#set text(lang: "pt", size: 11pt)

= Teste do Matypst

== Caixas básicas (`caixa`)

=== Borda esquerda (padrão)

#caixa[Este é o estilo padrão: borda esquerda azul.]

=== Borda esquerda com título

#caixa(titulo: "Informação", cor: blue)[
  Uma caixa com título e borda esquerda.
]

=== Borda superior

#caixa(titulo: "Atenção", cor: orange, borda: "top")[
  Uma caixa com borda no topo.
]

=== Borda completa

#caixa(titulo: "Aviso", cor: red, borda: "full", raio: 4pt)[
  Uma caixa com borda completa e cantos arredondados.
]

=== Sem borda

#caixa(cor: green, borda: "none")[
  Uma caixa sem borda, apenas com preenchimento.
]

=== Cores customizadas

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

== Ambientes matemáticos pré-configurados

=== Enunciados (corpo em itálico)

#definicao[Um *grupo* é um conjunto $G$ munido de uma operação $dot : G times G -> G$ satisfazendo associatividade, existência de elemento neutro e existência de inversos.]

#teorema(titulo: [de Lagrange])[
  Se $H$ é um subgrupo de um grupo finito $G$, então a ordem de $H$ divide a ordem de $G$.
]

#demonstracao[
  As classes laterais à esquerda de $H$ particionam $G$ em subconjuntos de mesmo tamanho $|H|$, logo $|G| = [G : H] dot |H|$.
]

#lema[Se $a^2 = e$ para todo $a in G$, então $G$ é abeliano.]

#corolario[Todo grupo de ordem prima é cíclico.]

#proposicao[A interseção de dois subgrupos é um subgrupo.]

#axioma[Para todo conjunto $A$, existe um conjunto $cal(P)(A)$ cujos elementos são exatamente os subconjuntos de $A$.]

#conjectura(titulo: [de Goldbach])[Todo número par maior que $2$ é soma de dois primos.]

#afirmacao[O conjunto dos números racionais é denso em $RR$.]

=== Definições, notações e propriedades

#notacao[Denotamos por $NN$, $ZZ$, $QQ$, $RR$ e $CC$ os conjuntos dos números naturais, inteiros, racionais, reais e complexos, respectivamente.]

#propriedade[A soma de dois números pares é par.]

=== Exemplos e problemas

#exemplo[O grupo $ZZ slash 6 ZZ$ tem ordem $6$. Seus subgrupos são $\{0\}$, $\{0, 3\}$, $\{0, 2, 4\}$ e o próprio $ZZ slash 6 ZZ$.]

#problema[Determine todos os subgrupos do grupo $ZZ slash 12 ZZ$.]

=== Informais

#observacao[Nem todo subconjunto de um grupo é subgrupo.]

=== Estilos de ambientes

==== Estilo cinza

#configurar-ambientes("cinza")

#teorema(titulo: [em cinza])[Este teorema aparece em tons de cinza.]

#definicao[Uma definição em estilo cinza.]

==== Estilo sem caixa

#configurar-ambientes("sem-caixa")

#teorema(titulo: [sem caixa])[Este teorema aparece sem caixa, apenas com rótulo em negrito.]

#definicao[Uma definição sem caixa.]

// Restaurar estilo colorido
#configurar-ambientes("colorido")

=== caixa-estilo personalizado

#let nota = caixa-estilo(
  cor: orange,
  borda: "full",
  raio: 3pt,
  prefixo: "Nota",
)

#nota[Lembre-se: $1$ não é considerado primo por convenção.]

== Código

=== Código inline

O comando #codigo-inline(`print("hello")`) imprime uma saudação.

Use #codigo-inline(`pip install matypst`) para instalar.

=== Bloco de código simples

#codigo-bloco(lang: "python", ```
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```.text)

=== Bloco com título

#codigo-bloco(
  lang: "rust",
  titulo: "main.rs",
  ```
fn main() {
    println!("Hello, matypst!");
    let x = vec![1, 2, 3];
    for i in &x {
        println!("{}", i);
    }
}
```.text,
)

=== Bloco com números de linha

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

== Matemática

=== QED isolado

Fim de uma demonstração: #qed()

=== Demonstração com QED

#teorema(titulo: [de Pitágoras])[
  Em um triângulo retângulo com catetos $a$, $b$ e hipotenusa $c$:
  $ a^2 + b^2 = c^2 $
]

#demonstracao[
  A demonstração clássica usa a comparação de áreas de quadrados construídos sobre os lados do triângulo.
]

=== Numeração de equações por seção

#show: num-equacao.with(formato: "(1.1)", por-secao: true)

A equação de Euler:
$ e^(i pi) + 1 = 0 $

A identidade trigonométrica fundamental:
$ sin^2(x) + cos^2(x) = 1 $

=== Operadores em português

Seno em português: $sen(x)$, $sen(pi/2) = 1$

=== Frações com estilo

Vertical: $fracao(a+b, c+d)$

Inclinada: $fracao(a, b, estilo: "inclinada")$

Horizontal: $fracao(a+b, c+d, estilo: "horizontal")$

=== Binômios

$binomio(n, k)$, $binomio(n, k_1, k_2, k_3)$

=== Raízes

Quadrada: $raiz(2)$, $raiz(x+1)$

N-ésima: $raiz(3, 8)$, $raiz(n, x)$

=== Tamanhos matemáticos

Inline com `exibicao`: $exibicao(sum_(i=1)^n x_i)$

Display com `emLinha`: $ #emLinha($sum_(i=1)^n x_i$) quad "versus" quad sum_(i=1)^n x_i $

Subscrito: $subscrito(sum_(i=1)^n x_i)$

Sub-subscrito: $#subSubscrito($sum_(i=1)^n x_i$)$

=== Derivadas em português

Leibniz: $leibniz(y, x)$, segunda ordem: $leibniz(y, x, 2)$

Parcial simples: $parcial(f, x)$, segunda ordem: $parcial(f, x, ordem: 2)$

Parcial mista: $parcial(f, x, y)$

=== Integral em português

Simples: $integral_a^b f(x) dif x$

Dupla: $integral.dupla_D f(x,y) dif x dif y$

Tripla: $integral.tripla_V f dif V$

Contorno: $integral.contorno_C bold(F) dot dif bold(r)$

Quadrupla: $integral.quadrupla$, traço: $integral.traco$, traço dupla: $integral.traco.dupla$, inter: $integral.inter$, seta gancho: $integral.seta.gancho$

=== Símbolos em português

Somatório: $somatorio_(i=1)^n a_i$, integral: $somatorio.integral$

Produtório: $produtorio_(i=1)^n a_i$, coproduto: $produtorio.co$

União: $uniao$, maior: $uniao.maior_(i=1)^n A_i$, seta: $uniao.seta$, ponto: $uniao.ponto$, ponto maior: $uniao.ponto.maior$, dupla: $uniao.dupla$, menos: $uniao.menos$, ou: $uniao.ou$, mais: $uniao.mais$, mais maior: $uniao.mais.maior$, quad: $uniao.quad$, quad maior: $uniao.quad.maior$, quad dupla: $uniao.quad.dupla$

Interseção: $inter$, maior: $inter.maior_(i=1)^n A_i$, e: $inter.e$, ponto: $inter.ponto$, dupla: $inter.dupla$, quad: $inter.quad$, quad maior: $inter.quad.maior$, quad dupla: $inter.quad.dupla$

=== Letras gregas em português

Minúsculas: $alfa$, $gama$, $teta$, $capa$, $mi$, $ni$, $csi$, $ro$, $ipsilon$, $fi$, $qui$

Variantes: $teta.alt$, $capa.alt$, $ro.alt$, $fi.alt$

Maiúsculas: $Gama$, $Teta$, $Csi$, $Ipsilon$, $Fi$

Fórmula com gregas em português: $alfa + beta = gama$, $fi(teta) = ro dot e^(i teta)$, $sum_(ni=1)^infinito fracao(1, ni^2) = fracao(pi^2, 6)$
