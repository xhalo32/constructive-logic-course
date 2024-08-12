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
  subtitle: [3 -- Aritmetiikka],
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
  - Peano-aksioomat ympäripyöreästi
  - Yhtäsuuruus ja yhtäsuuruustodistukset
    - rfl, määritelmällinen yhtäsuuruus
    - rw, tapa purkaa yhtäsuuruus (Genzenin inversioperiaate)
  - Yhteenlasku funktionaalisessa ohjelmoinnissa
  - Kertolasku funktionaalisessa ohjelmoinnissa
  - Potenssilaskut funktionaalisessa ohjelmoinnissa
  - Liitännäisyys ja vaihdannaisuus luonnollisten lukujen laskutoimituksille
  - Johdatus induktioon
    - Spoileri (pelkkää rekursiota)
    - Käydään läpi todistus siitä, että $x : "Nat" tack.r 0 + x = x$
      - Määritelmällinen yhtäsuuruus ja miksi eroaa $x + 0 = x$:stä
]

== Peano-aksioomat 

Nolla on luonnollinen luku.

Jos n on luonnollinen luku, `succ n` on luonnollinen luku.

Kaikki luonnolliset luvut ovat joko `zero` tai `succ n`, jossa n on luonnollinen luku.

==

Lause "Nolla on luonnollinen luku.", voidaan ilmaista Leanissä seuraavalla tavalla:

```lean4 zero : Nat```

"Jos n on luonnollinen luku, `succ n` on luonnollinen luku.", voidaan ilmaista:

```lean4 succ (n : Nat) : Nat```

== Induktiivinen määritelmä

"Kaikki luonnolliset luvut ovat joko `zero` tai `succ n`, jossa n on luonnollinen luku."

Ilmaistaan Leanissä käyttäen *induktiivista* määritelmää:

```lean4
inductive Nat where
  | zero : Nat
  | succ (n : Nat) : Nat
```

Näin ollen saadaan luonnollisten lukujen induktioperiaate, johon palataan myöhemmin. (Kuuluisa yhdeksäs aksiooma)

== Mitä tarkoittaa luonnollisten lukujen yhteenlasku?

Tapa muodostaa kahdesta luvusta kolmas, joka on suuruudeltaan ne molemmat yhdessä.

```lean4 
a : Nat
b : Nat
a + b : Nat
```

== Yhteenlaskun neutraalialkio

Luonnollisilla luvuilla on yhteenlaskun suhteen neutraalialkio nolla, jonka lisääminen mihin tahansa lukuun x tuottaa saman luvun x.

```lean4 
x : Nat
x + 0 ≡ x
0 + x = x
```

#note[
  ≡ selitetään pian
]

== Yhteenlaskun määritelmä

```lean4 
n : Nat
m : Nat
n + succ m ≡ succ (n + m)
```

#todo[
  - palkki-visualisaatio
  - rekursiivinen ajattelu
    - Miksi yhteenlaskua saadaan käyttää yhteenlaskun määritelmässä?
    - Miten vältytään viime tunnilla opitusta kehäpäätelmästä
]


== Luonnollisten lukujen yhteenlaskun vaihdannaisuus

```lean4 
n : Nat
m : Nat
n + m = m + n
```

== Luonnollisten lukujen yhteenlaskun liitännäisyys

```lean4 
n : Nat
m : Nat
k : Nat
n + (m + k) = (n + m) + k
```

== Peanon yhdeksäs aksiooma

== Luonnollisten lukujen päättelysäännöt

#tree(
  axi[],
  uni[```lean4 zero : Nat```]
)

#tree(
  axi[```lean4 n : Nat```],
  uni[```lean4 succ n : Nat```]
  
)

#tree(
  axi[```lean4 motive : Nat → Type*```],
  axi[```lean4 hZero : motive zero```],
  axi[```lean4 hSucc : motive n → motive (succ n)```],
  tri[```lean4 ∀ (n : Nat), motive n```]
)

#todo[
  - Selitetään kaikki auki
    - ```lean4 Type* ``` 
    - ```lean4 motive ``` 
]

== Induktiotodistus

#tree(
    axi[],
    uni[$A$],
        axi[],
        uni[$B$],
    bin[$A and B$],
    uni[$B -> (A and B)$],
    uni[$A -> (B -> (A and B))$]
)