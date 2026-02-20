// Wrappers em português para configuração de página do Typst
// Traduz nomes de parâmetros de page(), pagebreak() e margin

// ---------------------------------------------------------------------------
// Utilitário interno: traduz chaves de margem PT → EN
// ---------------------------------------------------------------------------

#let _traduzir-margem(m) = {
  if type(m) == dictionary {
    let resultado = (:)
    for (chave, valor) in m {
      let en = if chave == "superior" { "top" }
        else if chave == "inferior" { "bottom" }
        else if chave == "esquerda" { "left" }
        else if chave == "direita" { "right" }
        else if chave == "interna" { "inside" }
        else if chave == "externa" { "outside" }
        else if chave == "resto" { "rest" }
        else if chave in ("x", "y", "top", "bottom", "left", "right", "inside", "outside", "rest") { chave }
        else { panic("margem: chave desconhecida '" + chave + "'. Use: superior, inferior, esquerda, direita, interna, externa, resto, x, y") }
      resultado.insert(en, valor)
    }
    resultado
  } else {
    m // valor único (length, auto, etc.)
  }
}

// ---------------------------------------------------------------------------
// configurar-pagina — show-rule para configurar a página
// ---------------------------------------------------------------------------

/// Configura a página do documento com parâmetros em português.
/// Uso: `#show: configurar-pagina.with(papel: "a4", margem: (superior: 3cm, inferior: 2cm))`
#let configurar-pagina(
  papel: auto,
  largura: auto,
  altura: auto,
  margem: auto,
  paisagem: auto,
  colunas: auto,
  preenchimento: auto,
  numeracao: auto,
  alinhamento-numero: auto,
  cabecalho: auto,
  rodape: auto,
  pre-cabecalho: auto,
  pre-rodape: auto,
  encadernacao: auto,
  plano-de-fundo: auto,
  primeiro-plano: auto,
  corpo,
) = {
  let args = (:)
  if papel != auto { args.insert("paper", papel) }
  if largura != auto { args.insert("width", largura) }
  if altura != auto { args.insert("height", altura) }
  if margem != auto { args.insert("margin", _traduzir-margem(margem)) }
  if paisagem != auto { args.insert("flipped", paisagem) }
  if colunas != auto { args.insert("columns", colunas) }
  if preenchimento != auto { args.insert("fill", preenchimento) }
  if numeracao != auto { args.insert("numbering", numeracao) }
  if alinhamento-numero != auto { args.insert("number-align", alinhamento-numero) }
  if cabecalho != auto { args.insert("header", cabecalho) }
  if rodape != auto { args.insert("footer", rodape) }
  if pre-cabecalho != auto { args.insert("header-ascent", pre-cabecalho) }
  if pre-rodape != auto { args.insert("footer-descent", pre-rodape) }
  if encadernacao != auto { args.insert("binding", encadernacao) }
  if plano-de-fundo != auto { args.insert("background", plano-de-fundo) }
  if primeiro-plano != auto { args.insert("foreground", primeiro-plano) }
  set page(..args)
  corpo
}

// ---------------------------------------------------------------------------
// margem — helper para construir dicionário de margens em português
// ---------------------------------------------------------------------------

/// Constrói um dicionário de margens com chaves em português.
/// Uso: `margem(superior: 3cm, inferior: 2cm, esquerda: 3cm, direita: 2cm)`
#let margem(
  superior: auto,
  inferior: auto,
  esquerda: auto,
  direita: auto,
  interna: auto,
  externa: auto,
  resto: auto,
  x: auto,
  y: auto,
) = {
  let resultado = (:)
  if superior != auto { resultado.insert("top", superior) }
  if inferior != auto { resultado.insert("bottom", inferior) }
  if esquerda != auto { resultado.insert("left", esquerda) }
  if direita != auto { resultado.insert("right", direita) }
  if interna != auto { resultado.insert("inside", interna) }
  if externa != auto { resultado.insert("outside", externa) }
  if resto != auto { resultado.insert("rest", resto) }
  if x != auto { resultado.insert("x", x) }
  if y != auto { resultado.insert("y", y) }
  resultado
}

// ---------------------------------------------------------------------------
// quebra-pagina — wrapper para pagebreak()
// ---------------------------------------------------------------------------

/// Insere uma quebra de página.
/// - `fraco`: se `true`, só quebra se não estiver já no topo da página
/// - `para`: `"impar"` ou `"par"` para pular até página ímpar/par
#let quebra-pagina(fraco: false, para: none) = {
  if para != none {
    assert(para in ("impar", "par"),
      message: "quebra-pagina: 'para' deve ser \"impar\" ou \"par\", recebeu " + repr(para))
    let val = if para == "impar" { "odd" } else { "even" }
    pagebreak(weak: fraco, to: val)
  } else {
    pagebreak(weak: fraco)
  }
}
