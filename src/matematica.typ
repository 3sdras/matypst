// Ambientes matemáticos (numeração, QED, demonstrações)

#import "caixas.typ": caixa, _build-titulo

#let qed(simbolo: $square$) = {
  h(1fr)
  simbolo
}

#let demonstracao(
  body,
  titulo: "Demonstração",
  simbolo-qed: $square$,
) = {
  [*#titulo.*]
  body
  qed(simbolo: simbolo-qed)
}

#let num-equacao(
  formato: "(1)",
  por-secao: false,
  nivel: 1,
  body,
) = {
  if por-secao {
    set math.equation(numbering: n => {
      let hd = counter(heading).get()
      let sec-nums = hd.slice(0, calc.min(nivel, hd.len()))
      numbering(formato, ..sec-nums, n)
    })
    show heading.where(level: nivel): it => {
      counter(math.equation).update(0)
      it
    }
    body
  } else {
    set math.equation(numbering: formato)
    body
  }
}

// ============================================================================
// Ambientes matemáticos pré-configurados
// ============================================================================

// Estado global de estilo visual: "colorido" (padrão), "cinza", "sem-caixa"
#let ambiente-estilo = state("ambiente-estilo", "colorido")
#let configurar-ambientes(estilo) = ambiente-estilo.update(estilo)

// Estado global de numeração
#let numeracao-ambientes = state("numeracao-ambientes", (modo: "por-tipo", por-secao: false))

// Contadores dos ambientes pré-configurados
#let _contadores-ambientes = ("teorema", "lema", "corolario", "proposicao", "axioma", "conjectura", "afirmacao", "definicao", "notacao", "propriedade", "exemplo", "problema", "resultado")

/// Configura o modo de numeração dos ambientes matemáticos.
///
/// Parâmetros:
/// - modo: `"por-tipo"` (padrão) ou `"unificado"`
/// - por-secao: se `true`, numera como "seção.número" e reinicia a cada heading do nível configurado
/// - nivel: nível do heading que dispara reinício de contadores (padrão: `1`).
///   Use `1` para capítulos (TCC/tese) ou `2` para seções em artigos onde `= Título` é nível 1
///   e `== Seção` é nível 2. A numeração exibe todos os níveis até o configurado
///   (ex.: `nivel: 2` gera "1.2.1" para capítulo 1, seção 2, ambiente 1).
///
/// Uso:
/// ```typst
/// #show: configurar-numeracao("por-tipo")
/// #show: configurar-numeracao("unificado", por-secao: true)
/// #show: configurar-numeracao("por-tipo", por-secao: true, nivel: 2)
/// ```
#let configurar-numeracao(modo, por-secao: false, nivel: 1) = {
  body => {
    numeracao-ambientes.update((modo: modo, por-secao: por-secao, nivel: nivel))
    if por-secao {
      show heading.where(level: nivel): it => {
        if modo == "unificado" {
          counter("resultado").update(0)
        } else {
          for key in _contadores-ambientes {
            counter(key).update(0)
          }
        }
        it
      }
      body
    } else {
      body
    }
  }
}

#let ambiente-matematico(
  cor: blue,
  espessura: 2pt,
  prefixo: none,
  contador: none,
  italico: false,
  por-secao: false,
) = {
  (body, titulo: none) => {
    let corpo = if italico { emph(body) } else { body }

    // Ambos os contadores são sempre incrementados para que a troca de modo
    // funcione retroativamente. Trocar de modo no meio do documento NÃO é recomendado.
    if contador != none {
      counter(contador).step()
      counter("resultado").step()
    }

    context {
      let estilo-val = ambiente-estilo.get()
      let config = numeracao-ambientes.get()
      let modo-num = config.at("modo", default: "por-tipo")
      let secao-global = config.at("por-secao", default: false)

      let contador-efetivo = if modo-num == "unificado" and contador != none {
        "resultado"
      } else {
        contador
      }

      let usar-secao = secao-global or por-secao

      let nivel-cfg = config.at("nivel", default: 1)
      let num = if contador-efetivo != none {
        if usar-secao {
          let hd = counter(heading).get()
          let sec-nums = hd.slice(0, calc.min(nivel-cfg, hd.len()))
          let sec-str = sec-nums.map(str).join(".")
          let c = counter(contador-efetivo).at(here()).first()
          [#sec-str.#c]
        } else {
          numbering("1", ..counter(contador-efetivo).at(here()))
        }
      }

      if estilo-val == "sem-caixa" {
        let rotulo = if prefixo != none and num != none {
          if titulo != none {
            [*#prefixo #num* (#titulo).]
          } else {
            [*#prefixo #num.*]
          }
        } else if prefixo != none {
          if titulo != none {
            [*#prefixo* (#titulo).]
          } else {
            [*#prefixo.*]
          }
        }
        block(above: 0.8em, below: 0.8em)[#rotulo #corpo]
      } else {
        let cor-efetiva = if estilo-val == "cinza" {
          if espessura >= 3pt { luma(35%) }
          else if espessura >= 2pt { luma(50%) }
          else { luma(65%) }
        } else {
          cor
        }

        caixa(
          corpo,
          titulo: _build-titulo(prefixo, num, titulo),
          cor: cor-efetiva,
          borda: "left",
          espessura: espessura,
        )
      }
    }
  }
}

// --- Enunciados (azul — corpo em itálico) ---
#let teorema = ambiente-matematico(cor: blue, espessura: 3pt, prefixo: "Teorema", contador: "teorema", italico: true)
#let lema = ambiente-matematico(cor: blue.darken(10%), espessura: 2pt, prefixo: "Lema", contador: "lema", italico: true)
#let corolario = ambiente-matematico(cor: blue.lighten(10%), espessura: 2pt, prefixo: "Corolário", contador: "corolario", italico: true)
#let proposicao = ambiente-matematico(cor: eastern, espessura: 2pt, prefixo: "Proposição", contador: "proposicao", italico: true)
#let axioma = ambiente-matematico(cor: navy, espessura: 3pt, prefixo: "Axioma", contador: "axioma", italico: true)
#let conjectura = ambiente-matematico(cor: purple, espessura: 2pt, prefixo: "Conjectura", contador: "conjectura", italico: true)
#let afirmacao = ambiente-matematico(cor: teal, espessura: 2pt, prefixo: "Afirmação", contador: "afirmacao", italico: true)

// --- Definições (verde — corpo normal) ---
#let definicao = ambiente-matematico(cor: green, espessura: 3pt, prefixo: "Definição", contador: "definicao")
#let notacao = ambiente-matematico(cor: olive, espessura: 2pt, prefixo: "Notação", contador: "notacao")
#let propriedade = ambiente-matematico(cor: green.darken(10%), espessura: 2pt, prefixo: "Propriedade", contador: "propriedade")

// --- Exemplos e problemas (cinza/laranja — corpo normal) ---
#let exemplo = ambiente-matematico(cor: gray, espessura: 2pt, prefixo: "Exemplo", contador: "exemplo")
#let problema = ambiente-matematico(cor: orange, espessura: 2pt, prefixo: "Problema", contador: "problema")

// --- Informais ---
#let observacao = ambiente-matematico(cor: maroon, espessura: 1pt, prefixo: "Observação")
// demonstracao: já definida acima com QED

// ============================================================================
// Operadores e funções matemáticas em português
// ============================================================================

/// Seno — exibe "sen" em vez de "sin" no modo matemático.
///
/// Uso:
/// ```typst
/// $sen(x)$
/// ```
#let sen = math.op("sen")

/// Fração com parâmetro `estilo` em português.
/// Wrapper sobre `math.frac()`.
///
/// Parâmetros:
/// - numerador: conteúdo do numerador
/// - denominador: conteúdo do denominador
/// - estilo: "vertical" (padrão), "inclinada" ou "horizontal"
///
/// Uso:
/// ```typst
/// $fracao(a+b, c+d)$
/// $fracao(a, b, estilo: "inclinada")$
/// ```
#let fracao(numerador, denominador, estilo: "vertical") = {
  let resolved-style = if estilo == "inclinada" { "skewed" }
    else if estilo == "horizontal" { "horizontal" }
    else { "vertical" }

  math.frac(numerador, denominador, style: resolved-style)
}

/// Matriz com parênteses. Wrapper sobre `math.mat(delim: "(")`.
///
/// Uso:
/// ```typst
/// $matriz(1, 2; 3, 4)$
/// ```
#let matriz(..args) = math.mat(delim: "(", ..args)

/// Matriz com colchetes. Wrapper sobre `math.mat(delim: "[")`.
///
/// Uso:
/// ```typst
/// $colchete(1, 2, 3; 4, 5, 6)$
/// ```
#let colchete(..args) = math.mat(delim: "[", ..args)

/// Matriz com barras (determinante). Wrapper sobre `math.mat(delim: "|")`.
///
/// Uso:
/// ```typst
/// $barra(a, b; c, d)$
/// ```
#let barra(..args) = math.mat(delim: "|", ..args)

/// Matriz com barras duplas (norma). Wrapper sobre `math.mat(delim: "‖")`.
///
/// Uso:
/// ```typst
/// $norma(a, b; c, d)$
/// ```
#let norma(..args) = math.mat(delim: "‖", ..args)

/// Binômio em português.
/// Wrapper sobre `math.binom()`.
///
/// Parâmetros:
/// - superior: índice superior
/// - ..inferior: índice(s) inferior(es)
///
/// Uso:
/// ```typst
/// $binomio(n, k)$
/// $binomio(n, k_1, k_2, k_3)$
/// ```
#let binomio(superior, ..inferior) = {
  math.binom(superior, ..inferior)
}

/// Raiz em português.
/// Com um argumento: raiz quadrada. Com dois: raiz n-ésima.
///
/// Uso:
/// ```typst
/// $raiz(2)$           // √2
/// $raiz(3, 8)$        // ∛8
/// $raiz(n, x)$        // ⁿ√x
/// ```
#let raiz(..args) = {
  let pos = args.pos()
  assert(pos.len() >= 1 and pos.len() <= 2, message: "raiz() requer 1 ou 2 argumentos: raiz(x) ou raiz(n, x)")
  if pos.len() == 1 {
    math.sqrt(pos.at(0))
  } else {
    math.root(pos.at(0), pos.at(1))
  }
}

/// Estilo de exibição (display) — equivalente ao \displaystyle do LaTeX.
/// Força o tamanho normal de equações em bloco.
///
/// Parâmetros:
/// - corpo: conteúdo matemático
/// - compacto: restringe altura de expoentes (padrão: false)
///
/// Uso:
/// ```typst
/// $exibicao(sum_(i=1)^n x_i)$
/// ```
#let exibicao(corpo, compacto: false) = {
  math.display(corpo, cramped: compacto)
}

/// Estilo em linha (inline) — equivalente ao \textstyle do LaTeX.
/// Força o tamanho normal de equações em linha.
///
/// Parâmetros:
/// - corpo: conteúdo matemático
/// - compacto: restringe altura de expoentes (padrão: false)
///
/// Uso:
/// ```typst
/// $ emLinha(sum_(i=1)^n x_i) $
/// ```
#let emLinha(corpo, compacto: false) = {
  math.inline(corpo, cramped: compacto)
}

/// Estilo de subscrito (script) — equivalente ao \scriptstyle do LaTeX.
/// Tamanho menor, usado em potências e sub/sobrescritos.
///
/// Parâmetros:
/// - corpo: conteúdo matemático
/// - compacto: restringe altura de expoentes (padrão: true)
///
/// Uso:
/// ```typst
/// $subscrito(sum_(i=1)^n x_i)$
/// ```
#let subscrito(corpo, compacto: true) = {
  math.script(corpo, cramped: compacto)
}

/// Estilo de sub-subscrito (sscript) — equivalente ao \scriptscriptstyle do LaTeX.
/// Menor tamanho, usado em sub/sobrescritos de segundo nível.
///
/// Parâmetros:
/// - corpo: conteúdo matemático
/// - compacto: restringe altura de expoentes (padrão: true)
///
/// Uso:
/// ```typst
/// $subSubscrito(sum_(i=1)^n x_i)$
/// ```
#let subSubscrito(corpo, compacto: true) = {
  math.sscript(corpo, cramped: compacto)
}

/// Delimitador auto-dimensionável — wrapper sobre `math.lr()`.
///
/// Uso:
/// ```typst
/// $delimitar((frac(a, b)))$
/// $delimitar(| x |)$
/// ```
#let delimitar(..args) = {
  math.lr(..args)
}

/// Vetor com seta — wrapper sobre `math.arrow()`.
/// Funciona com um ou mais caracteres.
///
/// Uso:
/// ```typst
/// $vetor(v)$        // v com seta
/// $vetor(A B)$      // AB com seta (vetor de A a B)
/// ```
#let vetor(..args) = {
  math.arrow(..args)
}

/// Vetor em negrito — wrapper sobre `math.bold()`.
///
/// Uso:
/// ```typst
/// $vetorNegrito(v)$, $vetorNegrito(F)$
/// ```
#let vetorNegrito(..args) = {
  math.bold(..args)
}

/// Conjugado — barra superior sobre um caractere.
/// Wrapper sobre `math.overline()`.
///
/// Uso:
/// ```typst
/// $conjugado(z)$
/// ```
#let conjugado(..args) = {
  math.overline(..args)
}

/// Segmento — barra superior sobre dois pontos.
/// Wrapper sobre `math.overline()`.
///
/// Uso:
/// ```typst
/// $segmento(A B)$
/// ```
#let segmento(..args) = {
  math.overline(..args)
}

// ============================================================================
// Derivadas em português
// ============================================================================

/// Derivada na notação de Leibniz.
///
/// Parâmetros:
/// - num: variável do numerador
/// - denom: variável do denominador
/// - ordem (opcional): ordem da derivada
///
/// Uso:
/// ```typst
/// $leibniz(y, x)$      // dy/dx
/// $leibniz(y, x, 2)$   // d²y/dx²
/// $leibniz(y, x, n)$   // dⁿy/dxⁿ
/// ```
#let leibniz(..args) = {
  let pos = args.pos()
  assert(pos.len() >= 2, message: "leibniz() requer ao menos 2 argumentos: leibniz(y, x)")
  let num = pos.at(0)
  let denom = pos.at(1)
  if pos.len() <= 2 {
    $frac(dif num, dif denom)$
  } else {
    let ordem = pos.at(2)
    $frac(dif^ordem num, dif denom^ordem)$
  }
}

/// Derivada parcial.
///
/// Com uma variável no denominador: derivada parcial simples.
/// Com múltiplas variáveis: derivada parcial mista.
///
/// Parâmetros:
/// - num: função no numerador
/// - ..denoms: variável(is) do denominador
/// - ordem: ordem da derivada (padrão: inferida do número de variáveis)
///
/// Uso:
/// ```typst
/// $parcial(f, x)$              // ∂f/∂x
/// $parcial(f, x, ordem: 2)$    // ∂²f/∂x²
/// $parcial(f, x, y)$           // ∂²f/∂x∂y
/// ```
#let parcial(num, ..denoms, ordem: none) = {
  let vars = denoms.pos()
  assert(vars.len() >= 1, message: "parcial() requer ao menos uma variável: parcial(f, x)")
  if vars.len() == 1 {
    let v = vars.at(0)
    if ordem == none {
      $frac(partial num, partial #v)$
    } else {
      $frac(partial^ordem num, partial #v^ordem)$
    }
  } else {
    let n = if ordem != none { ordem } else { vars.len() }
    let denom = vars.map(v => $partial #v$).join()
    $frac(partial^#n num, #denom)$
  }
}

// ============================================================================
// Símbolos matemáticos em português
// ============================================================================

/// Infinito — símbolo ∞.
///
/// Uso:
/// ```typst
/// $lim_(n -> infinito) a_n$
/// ```
#let infinito = symbol("∞")

/// Integral — símbolo ∫ com variantes em português.
///
/// Variantes:
/// - `integral` → ∫
/// - `integral.dupla` → ∬
/// - `integral.tripla` → ∭
/// - `integral.quadrupla` → ⨌
/// - `integral.contorno` → ∮
/// - `integral.traco` → ⨍
/// - `integral.traco.dupla` → ⨎
/// - `integral.inter` → ⨙
/// - `integral.seta.gancho` → ⨗
///
/// Uso:
/// ```typst
/// $integral_a^b f(x) dif x$
/// $integral.dupla_D f(x,y) dif x dif y$
/// ```
#let integral = symbol(
  "∫",
  ("dupla", "∬"),
  ("tripla", "∭"),
  ("quadrupla", "⨌"),
  ("contorno", "∮"),
  ("traco", "⨍"),
  ("traco.dupla", "⨎"),
  ("inter", "⨙"),
  ("seta.gancho", "⨗"),
)

/// Somatório — símbolo ∑ com variantes.
///
/// Variantes:
/// - `somatorio` → ∑
/// - `somatorio.integral` → ⨋
///
/// Uso:
/// ```typst
/// $somatorio_(i=1)^n a_i$
/// ```
#let somatorio = symbol(
  "∑",
  ("integral", "⨋"),
)

/// Produtório — símbolo ∏ com variantes.
///
/// Variantes:
/// - `produtorio` → ∏
/// - `produtorio.co` → ∐
///
/// Uso:
/// ```typst
/// $produtorio_(i=1)^n a_i$
/// ```
#let produtorio = symbol(
  "∏",
  ("co", "∐"),
)

/// União — símbolo ∪ com variantes.
///
/// Variantes:
/// - `uniao` → ∪
/// - `uniao.maior` → ⋃
/// - `uniao.seta` → ⊌
/// - `uniao.ponto` → ⊍
/// - `uniao.ponto.maior` → ⨃
/// - `uniao.dupla` → ⋓
/// - `uniao.menos` → ⩁
/// - `uniao.ou` → ⩅
/// - `uniao.mais` → ⊎
/// - `uniao.mais.maior` → ⨄
/// - `uniao.quad` → ⊔
/// - `uniao.quad.maior` → ⨆
/// - `uniao.quad.dupla` → ⩏
///
/// Uso:
/// ```typst
/// $uniao.maior_(i=1)^n A_i$
/// ```
#let uniao = symbol(
  "∪",
  ("maior", "⋃"),
  ("seta", "⊌"),
  ("ponto", "⊍"),
  ("ponto.maior", "⨃"),
  ("dupla", "⋓"),
  ("menos", "⩁"),
  ("ou", "⩅"),
  ("mais", "⊎"),
  ("mais.maior", "⨄"),
  ("quad", "⊔"),
  ("quad.maior", "⨆"),
  ("quad.dupla", "⩏"),
)

/// Interseção — símbolo ∩ com variantes.
///
/// Variantes:
/// - `inter` → ∩
/// - `inter.maior` → ⋂
/// - `inter.e` → ⩄
/// - `inter.ponto` → ⩀
/// - `inter.dupla` → ⋒
/// - `inter.quad` → ⊓
/// - `inter.quad.maior` → ⨅
/// - `inter.quad.dupla` → ⩎
///
/// Uso:
/// ```typst
/// $inter.maior_(i=1)^n A_i$
/// ```
#let inter = symbol(
  "∩",
  ("maior", "⋂"),
  ("e", "⩄"),
  ("ponto", "⩀"),
  ("dupla", "⋒"),
  ("quad", "⊓"),
  ("quad.maior", "⨅"),
  ("quad.dupla", "⩎"),
)

// ============================================================================
// Letras gregas em português
// ============================================================================
//
// As seguintes letras já possuem o mesmo nome em português e inglês,
// e podem ser usadas diretamente no modo matemático sem wrapper:
// beta (β), delta (δ), epsilon (ε), zeta (ζ), eta (η), iota (ι),
// lambda (λ), omicron (ο), pi (π), sigma (σ), tau (τ), psi (ψ), omega (ω).

// --- Minúsculas ---

/// Alfa (α).
///
/// Uso: `$alfa$`
#let alfa = sym.alpha

/// Gama (γ).
///
/// Uso: `$gama$`
#let gama = sym.gamma

/// Teta (θ) com variante cursiva.
///
/// - `teta` → θ
/// - `teta.alt` → ϑ
///
/// Uso: `$teta$`, `$teta.alt$`
#let teta = symbol("θ", ("alt", "ϑ"))

/// Capa (κ) com variante cursiva.
///
/// - `capa` → κ
/// - `capa.alt` → ϰ
///
/// Uso: `$capa$`
#let capa = symbol("κ", ("alt", "ϰ"))

/// Mi (μ).
///
/// Uso: `$mi$`
#let mi = sym.mu

/// Ni (ν).
///
/// Uso: `$ni$`
#let ni = sym.nu

/// Csi (ξ).
///
/// Uso: `$csi$`
#let csi = sym.xi

/// Rô (ρ) com variante cursiva.
///
/// - `ro` → ρ
/// - `ro.alt` → ϱ
///
/// Uso: `$ro$`, `$ro.alt$`
#let ro = symbol("ρ", ("alt", "ϱ"))

/// Ípsilon (υ).
///
/// Uso: `$ipsilon$`
#let ipsilon = sym.upsilon

/// Fi (φ) com variante.
///
/// - `fi` → φ
/// - `fi.alt` → ϕ
///
/// Uso: `$fi$`, `$fi.alt$`
#let fi = symbol("φ", ("alt", "ϕ"))

/// Qui (χ).
///
/// Uso: `$qui$`
#let qui = sym.chi

// --- Maiúsculas (apenas as visualmente distintas das letras latinas) ---

/// Gama maiúsculo (Γ).
///
/// Uso: `$Gama$`
#let Gama = sym.Gamma

/// Teta maiúsculo (Θ).
///
/// Uso: `$Teta$`
#let Teta = sym.Theta

/// Csi maiúsculo (Ξ).
///
/// Uso: `$Csi$`
#let Csi = sym.Xi

/// Ípsilon maiúsculo (Υ).
///
/// Uso: `$Ipsilon$`
#let Ipsilon = sym.Upsilon

/// Fi maiúsculo (Φ).
///
/// Uso: `$Fi$`
#let Fi = sym.Phi

// ============================================================================
// Símbolos matemáticos em português
// ============================================================================
//
// Nomes usam camelCase (não hífens) para funcionar em modo matemático:
// $paraTodo$ funciona, $para-todo$ seria interpretado como "para" - "todo".

// --- Operadores binários ---

/// Vezes (×) — multiplicação.
///
/// Uso: `$a vezes b$`
#let vezes = sym.times

/// Mais ou menos (±).
///
/// Uso: `$a maisMenos b$`
#let maisMenos = sym.plus.minus

/// Menos ou mais (∓).
///
/// Uso: `$a menosMais b$`
#let menosMais = sym.minus.plus

/// Ponto (⋅) — produto escalar ou multiplicação.
///
/// Uso: `$a ponto b$`
#let ponto = sym.dot

/// Estrela (⋆).
///
/// Uso: `$a estrela b$`
#let estrela = sym.star

/// Marcador (•).
///
/// Uso: `$marcador$`
#let marcador = sym.bullet

/// Losango (⋄).
///
/// Uso: `$a losango b$`
#let losango = sym.diamond

/// Círculo (∘) — composição.
///
/// Uso: `$f circulo g$`
#let circulo = sym.circle.small

/// Sem — diferença de conjuntos (∖).
///
/// Uso: `$A sem B$`
#let sem = sym.without

/// Ou lógico (∨).
///
/// Uso: `$p ou q$`
#let ou = sym.or

/// E lógico (∧).
///
/// Uso: `$p eLogico q$`
#let eLogico = sym.and

/// Ou exclusivo (⊻).
///
/// Uso: `$p ouExclusivo q$`
#let ouExclusivo = sym.xor

// --- Relações ---

/// Aproximadamente (≈).
///
/// Uso: `$x aprox y$`
#let aprox = sym.approx

/// Equivalente (≡).
///
/// Uso: `$a equiv b$`
#let equiv = sym.equiv

/// Precede (≺).
///
/// Uso: `$a precede b$`
#let precede = sym.prec

/// Sucede (≻).
///
/// Uso: `$a sucede b$`
#let sucede = sym.succ

/// Está contido (⊂) com variantes.
///
/// - `estaContido` → ⊂
/// - `estaContido.eq` → ⊆
///
/// Uso: `$A estaContido B$`, `$A estaContido.eq B$`
#let estaContido = symbol("⊂", ("eq", "⊆"))

/// Contém (⊃) com variantes.
///
/// - `contem` → ⊃
/// - `contem.eq` → ⊇
///
/// Uso: `$A contem B$`, `$A contem.eq B$`
#let contem = symbol("⊃", ("eq", "⊇"))

/// Pertence (∈) com variante negada.
///
/// - `pertence` → ∈
/// - `pertence.nao` → ∉
///
/// Uso: `$x pertence A$`, `$x pertence.nao A$`
#let pertence = symbol("∈", ("nao", "∉"))

/// Proporcional (∝).
///
/// Uso: `$y proporcional x$`
#let proporcional = sym.prop

/// Paralelo (∥).
///
/// Uso: `$a paralelo b$`
#let paralelo = sym.parallel

/// Perpendicular (⊥).
///
/// Uso: `$a perpendicular b$`
#let perpendicular = sym.perp

// --- Setas ---
//
// Direções usam WASD: w=cima, s=baixo, a=esquerda, d=direita.

/// Seta com variantes direcionais.
///
/// - `seta` → → (direita, padrão)
/// - `seta.d` → →, `seta.a` → ←, `seta.w` → ↑, `seta.s` → ↓
/// - `seta.w.s` → ↕, `seta.a.d` → ↔
/// - `seta.d.longa` → ⟶, `seta.a.longa` → ⟵, `seta.a.d.longa` → ⟷
/// - `seta.gancho` → ↪, `seta.d.cauda` → ↣, `seta.mapa` → ↦
///
/// Uso: `$A seta.d B$`, `$seta.w$`
#let seta = symbol(
  "→",
  ("d", "→"),
  ("a", "←"),
  ("w", "↑"),
  ("s", "↓"),
  ("w.s", "↕"),
  ("a.d", "↔"),
  ("d.longa", "⟶"),
  ("a.longa", "⟵"),
  ("a.d.longa", "⟷"),
  ("gancho", "↪"),
  ("d.cauda", "↣"),
  ("mapa", "↦"),
)

/// Implica (⇒).
///
/// Uso: `$p implica q$`
#let implica = sym.arrow.r.double

/// Se e somente se (⇔).
///
/// Uso: `$p sse q$`
#let sse = sym.arrow.l.r.double

// --- Símbolos diversos ---

/// Conjunto vazio (∅).
///
/// Uso: `$vazio$`
#let vazio = sym.emptyset

/// Portanto (∴).
///
/// Uso: `$portanto x = 1$`
#let portanto = sym.therefore

/// Pois / porque (∵).
///
/// Uso: `$pois x > 0$`
#let pois = sym.because

/// Para todo (∀).
///
/// Uso: `$paraTodo x in RR$`
#let paraTodo = sym.forall

/// Existe (∃).
///
/// Uso: `$existe x$`
#let existe = sym.exists

/// Negação (¬).
///
/// Uso: `$nao p$`
#let nao = sym.not

// Parcial (∂) — símbolo de derivada parcial.
//
// Nota: a função `parcial(f, x)` gera a fração ∂f/∂x completa.
// Este alias é para o símbolo isolado ∂.
//
// Uso: `$parcial f / parcial x$`
// Não definido como wrapper porque conflita com a função parcial().
// Use `partial` (built-in do Typst) para o símbolo isolado,
// ou `parcial(f, x)` para a notação completa.

/// Alef (ℵ).
///
/// Uso: `$alef_0$`
#let alef = sym.aleph

/// Reticências com variantes.
///
/// - `reticencias` → … (genérica)
/// - `reticencias.h` → ⋯ (horizontal)
/// - `reticencias.v` → ⋮ (vertical)
/// - `reticencias.c` → ⋯ (centralizada)
/// - `reticencias.diagonal` → ⋱ (diagonal descendente)
/// - `reticencias.diagonal.w` → ⋰ (diagonal ascendente)
///
/// Uso: `$a_1, reticencias, a_n$`
#let reticencias = symbol(
  "…",
  ("h", "⋯"),
  ("v", "⋮"),
  ("c", "⋯"),
  ("diagonal", "⋱"),
  ("diagonal.w", "⋰"),
)

