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
  subtitle: [4 -- Formalisointi],
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
  - Mitä on formalisointi?
  - Miksi formalisoida?
  - Esimerkkejä matematiikan formalisoinnista
  - Formalisointi on yleensä jäljessä tutkimusmatematiikkaa
  - Logiikkaohjelmointi
  - Todistusassistentti
  - Harjoitellaan sanallisen lauseen kirjoittamista formaalisti loogisella notaatiolla
  - Lean ja tyyppiteoria formalisoinnissa
  - Mathlib
  - Lean esimerkkejä (formalisoidaan jotain yhdessä)
]

== Mitä on formalisointi?

- Tapa esittää 

== Formalisoinnin rajat


== Formaali logiikka

#slide(composer: (1fr, auto))[
  - Miten eroaa epäformaalista logiikasta?
    - Mitä tarkoittaa formaali kieli?
  - Nollannen asteen logiikkaa kutsutaan nimellä lauselogiikka
][
  $ (p quad p -> q) / q $
]




== Esimerkki

```lean4
def Even (n : Nat) := 2 ∣ n


```

== Reaaliluvut

- Reaaliluvut, noncomputable

```lean4
open Mathlib.Real


```



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

== TODO

- kongruenssi
- shakkilautapulma (täsmällinen päättely)