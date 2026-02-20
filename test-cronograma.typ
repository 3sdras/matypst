#import "lib.typ": *

#set page(width: 20cm, height: auto, margin: 1cm)
#set text(font: "Libertinus Serif", size: 11pt)

= Teste do Cronograma (Gantt)

== Exemplo básico

#cronograma(
  hoje: data(15, 3, 2026),
  (
    tarefa("Planejamento", data(1, 3, 2026), data(7, 3, 2026), progresso: 100, cor: verde),
    tarefa("Design", data(5, 3, 2026), data(14, 3, 2026), progresso: 50, cor: azul),
    tarefa("Implementação", data(10, 3, 2026), data(28, 3, 2026), cor: roxo),
    tarefa("Entrega", data(28, 3, 2026), data(28, 3, 2026), marco: true, cor: vermelho),
  ),
)

== Com dependências e grupos

#cronograma(
  hoje: data(10, 4, 2026),
  cor-padrao: azul-petroleo,
  mostrar-rotulo: true,
  (
    tarefa("Levantamento", data(15, 3, 2026), data(25, 3, 2026),
      progresso: 100, cor: verde, grupo: "Análise"),
    tarefa("Requisitos", data(22, 3, 2026), data(5, 4, 2026),
      progresso: 80, cor: verde, grupo: "Análise",
      depende-de: ("Levantamento",)),
    tarefa("Protótipo", data(1, 4, 2026), data(15, 4, 2026),
      progresso: 40, cor: azul, grupo: "Design"),
    tarefa("UI/UX", data(10, 4, 2026), data(25, 4, 2026),
      progresso: 10, cor: azul, grupo: "Design",
      depende-de: ("Protótipo",)),
    tarefa("Backend", data(15, 4, 2026), data(10, 5, 2026),
      cor: roxo, grupo: "Desenvolvimento"),
    tarefa("Frontend", data(20, 4, 2026), data(15, 5, 2026),
      cor: laranja, grupo: "Desenvolvimento",
      depende-de: ("UI/UX",)),
    tarefa("Release", data(15, 5, 2026), data(15, 5, 2026),
      marco: true, cor: vermelho),
  ),
)

== Com dependências visíveis

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

== Tarefa de 1 dia

#cronograma(
  (
    tarefa("Reunião", data(1, 6, 2026), data(1, 6, 2026), cor: laranja),
    tarefa("Sprint", data(1, 6, 2026), data(14, 6, 2026), cor: azul),
  ),
)
