#import "@preview/touying:0.4.2": *
#import "slidetheme.typ"
#import "@preview/note-me:0.2.1": *
#import "@preview/prooftrees:0.1.0": *

#let palette = (
  rgb("#7287fd"), // lavender
  rgb("#209fb5"), // sapphire
  rgb("#40a02b"), // green
  rgb("#df8e1d"), // yellow
  rgb("#fe640b"), // peach
  rgb("#e64553"), // maroon
)
#let math-palette = palette.map(c => c.darken(20%))

#show raw: slidetheme.colorize-code(palette)
#show math.equation: it => slidetheme.colorize-math(math-palette, it)

#set raw(syntaxes: "Lean4.sublime-syntax", theme: "Catppuccin Latte.tmTheme")
#set text(font: "Fira Sans", weight: "light", size: 20pt)

// #show raw: it => box(
//   fill: rgb("#eff1f5"),
//   inset: 8pt,
//   radius: 12pt,
//   text(fill: rgb("#4c4f69"), it)
// )

#let s = slidetheme.register(aspect-ratio: "16-9")
#let s = (s.methods.info)(
  self: s,
  title: [Konstruktiivinen logiikka ja formaali todistaminen],
  subtitle: [1 – Lauselogiikka],
  author: [Niklas Halonen & Alma Nevalainen],
  date: datetime.today(),
  institution: [Otaniemen lukio],
)
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show strong: alert

#let (slide, empty-slide, title-slide, new-section-slide, focus-slide) = utils.slides(s)
#show: slides

== TODO

#todo[
  - luonnollinen päättely
  - todistus siitä, että $A -> A$ ja sama Leanillä
  - mikä on todistusassistentti?
  - miksi on todistusassistentti?
  - mitä leanillä voi tehdä?
  - tutkitaan $A -> A$-todistusta
    - mikä on A?
    - mikä on nuoli?
    - mikä on by?
    - mikä on intro?
    - mikä on exact?
  - implikaation sulutus, mitä eroa on $A -> (A -> B) -> B$ ja $A -> A -> B -> B$ välillä?
]

== Tällä tunnilla

#todo[tunnin oppimistavoitteet]

- Mitä vaaditaan osoittamaan looginen väite korrektiksi
- Päättelysääntöjä
- Milloin looginen väite on tautologia tai todistettavissa vääräksi
- Konstruktiivisen logiikan kieli
  - Natural deduction todistus
- Klassisen logiikan ominaispiirteet
== Todistukset totuustauluja käyttäen

Konjunktio, disjunktio, negaatio, ekvivalenssi ja implikaatio

== Luonnollinen päättely

$ (()/A ()/B)/((A and B)/(B -> (A and B))/(A -> (B -> (A and B)))) $

#tree(
    axi[],
    uni[$A$],
        axi[],
        uni[$B$],
    bin[$A and B$],
    uni[$B -> (A and B)$],
    uni[$A -> (B -> (A and B))$]
)

== Aksioomat

MAA11 s.85

== Päättelysäännöt

== Todistus luonnollista päättelyä käyttäen

$A -> A$ (identiteettifuntio)

Identiteettifuntio on funktio, joka kuvaa jokaisen lähtöjoukkonsa alkion itseensä.

Tarkastellaan identiteettifuntion todistusta luonnollista päättelyä käyttäen. Mitä aksioomia ja sääntöjä?

== $A -> A$, mutta Leanillä

#grid(columns:(1fr, 1fr), text(size:15pt, [
Kirjoitetaan edellisen dian todistus Leaniä käyttäen:

\

```lean4
def identity : A → A := by
  intro a
  exact a
```
]), text(size:15pt, [
  `def` aloittaa määritelmän (definition)

  `by` aloittaa taktiikkatodistuksen

  `A` tyyppi

  `→` implikaatio, jostakin seuraa jotakin

  `intro` siirretään hypoteesi *maalista* oletukseksi *kontekstiin*

  `exact` suljetaan maali tarjoamalla *todistustermi*

])
)

== Lause, eli _teoreema_

#todo[
  Esimerkkinä parilliset luvut (esitetään formaalisti 4 kappaleessa)
]

== Apulause, eli _lemma_


== Kontrapositio

MAA11 s.87

== Epäsuora todistus

- $A -> B$ on ekvivalentti $not B -> not A$ klassisessa logiikassa
  - Huom: ei päde konstruktiivisessa logiikassa (kaikilla A ja B)

== Epäsuora todistus esimerkki

#todo[

]

