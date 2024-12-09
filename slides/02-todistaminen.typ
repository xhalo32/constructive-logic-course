#import "@preview/touying:0.4.2": *
#import "slidetheme.typ"
#import "@preview/note-me:0.2.1": *
#import "@preview/curryst:0.3.0": rule, proof-tree

#let palette = (
  rgb("#7287fd"), // lavender
  rgb("#209fb5"), // sapphire
  rgb("#40a02b"), // green
  rgb("#df8e1d"), // yellow
  rgb("#fe640b"), // peach
  rgb("#e64553"), // maroon
)
#let math-palette = palette.map(c => c.darken(20%))

// #show math.equation: set text(bottom-edge: -0.25em, top-edge: 0.75em)

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
  subtitle: [2 – Todistaminen],
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
  - todistus siitä, että $A -> A$
  - implikaation sulutus, mitä eroa on $A -> (A -> B) -> B$ ja $A -> A -> B -> B$ välillä?
]

== Tällä tunnilla käydään...

- Mitä vaaditaan osoittamaan looginen väite korrektiksi
- Päättelysääntöjä
- Milloin looginen väite on tautologia tai todistettavissa vääräksi
- Konstruktiivisen logiikan kieli
  - Konstruktiivisen logiika päättelysääntöjä
  - Todistus luonnollisella päättelyllä
- Klassisen logiikan ominaispiirteet
  - Ristiriitatodistus
- Kvanttorit ja todistaminen predikaattilogiikassa

== Todistukset totuustauluja käyttäen

// Konjunktio, disjunktio, negaatio, ekvivalenssi ja implikaatio

#align(center)[
0. $not(A and not A)$
1. $A or not A$
2. $A <=> A and A$
3. $A <=> A or A$
4. $A => A or B$
5. $(A => B) <=> not A or B$
]

== Logiikan päättelysäännöt

#let hyp = $script("hyp")$
#let impIntro = $script(scripts(->)_"intro")$
#let impElim = $script(scripts(->)_"elim")$
#let andIntro = $script(scripts(and)_"intro")$
#let notElim = $script(scripts(not)_"elim")$

- Koostuvat _tuonti_- ja _eliminointisäännöistä_.
  - Tuonti on verrattavissa rakenteen muodostumiseen
  - Eliminointi rakenteen purkamiseen
- Päättelysääntö vastaa yhtä jakoviivaa.
- Lause $Gamma tack A$ sanoo, että oletuksista $Gamma$ seuraa *johtopäätös* $A$.
- Päättelysäännöillä muovataan oletuksia ja johtopäätöstä.
- Jotkin päättelysäännöt ovat molempisuuntaisia, mutta joillakin päättely menee vain yhteen suuntaan.
- Päättelysäännöt yleensä kirjoitetaan lyhennettynä ilman kontekstia tai $tack$ merkkiä

#v(2em)

#grid(columns: (1fr,)*3, align: center + horizon)[
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: andIntro,
    $Gamma tack A and B$,
    $Gamma tack A$,
    $Gamma tack B$,
  ),
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: hyp,
    $Gamma, A tack A$,
  ),
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: impElim,
    $Gamma tack B$,
    $Gamma tack A$,
    $Gamma tack A -> B$,
  ),
)
]

== Todistus päättelysääntöjä käyttäen

- Väite kirjotetaan viivan alapuolelle, valitaan sopiva päättelysääntö, jonka määrämänä viivan yläpuolelle muodostuu _maaleja_.
- Todistuksen välivaiheet ilmenevät päättelyviivoina, ja todistuksen "tila", eli oletukset ja väite muuttuvat välivaiheiden välillä

#grid(columns: (1fr,)*3, align: center + horizon)[
#proof-tree(prem-min-spacing: 1em,
  rule($A -> A$)
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: impIntro,
    $A -> A$
  )
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: impIntro,
    $A -> A$,
    rule(
      name: hyp,
      $A tack A$
    )
  )
)
]

== Luonnollinen päättely

- Eli _Gentzenin #footnote[#link("https://en.wikipedia.org/wiki/Gerhard_Gentzen")[Gerhard Gentzen] 1909-1945] päättelysääntöjärjestelmä_.
- *Puumainen* rakenne, jossa todistettava väite alimpana.
- Kirjaa täsmällisesti kaikki loogiset askeleet.
  - Viivan yläpuolella on oletukset ja alapuolella johtopäätös.
- "Kun oletukset on täytetty, niin johtopäätös seuraa."


#align(center, block(proof-tree(prem-min-spacing: 1em,
  rule(
    name: impIntro,
    $tack A -> (B -> (A and B))$,
    rule(
      name: impIntro,
      $A tack B -> (A and B)$,
      rule(
        name: andIntro,
        $A, B tack A and B$,
        rule(
          name: hyp,
          $A, B tack A$,
        ),
        rule(
          name: hyp,
          $A, B tack B$,
        ),
      ),
    ),
  ),
)))


== Konsistentti logiikka

- Logiikka on _konsistentti_, jos epätotuutta ei pysty johtamaan suoraan aksioomista ja päättelysäännöistä.
- Kaikki järkevät logiikat ovat konsistentteja.
- Kuitenkin, vaikka oletuksissa on ristiriita, niin se ei tee logiikasta epäkonsistenttia.

// == Todistus luonnollista päättelyä käyttäen

// $A -> A$ (identiteettifuntio)

// Identiteettifuntio on funktio, joka kuvaa jokaisen lähtöjoukkonsa alkion itseensä.

// Tarkastellaan identiteettifuntion todistusta luonnollista päättelyä käyttäen. Mitä aksioomia ja sääntöjä?

== Tyyppiteoria

- Tyyppiteoriassa päättely rakentuu _termien_ eli _todistusalkioiden_ ympärille.
- Todistusalkioille annetaan nimet, esimerkiksi sääntö $scripts(->)_"elim"$ eli Modus Ponens ilmaistaan seuraavasti

#align(center)[
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: impElim,
    $Gamma tack h " " a : B$,
    $Gamma tack a : A$,
    $Gamma tack h : A -> B$,
  ),
)
]

- Viivan yläpuoli luetaan "gammasta seuraa $a$ tyyppiä $A$", "gammasta seuraa $h$ tyyppiä $A -> B$".
- Viivan alapuoli luetaan "gammasta seuraa $h " " a$ tyyppiä $B$".

== Lause, eli _teoreema_

// - Lause on 

#todo[
  Esimerkkinä parilliset luvut (esitetään formaalisti 4 kappaleessa)
]

== Apulause, eli _lemma_


== Aksiooma

- Aksioomat ovat johdettavissa/todistettavissa *ilman päättelyä*.
  - Tautologia, joka ei tarvitse todistusta.
- Esimerkkejä aksioomista
  - Peano aksioomat
  - Joukko-opin aksioomat
  - Tyyppiteorian aksioomat

MAA11 s.85

#grid(columns: (1fr,)*3, align: center + horizon)[
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: $script(0_"intro")$,
    $tack 0 : NN$
  )
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: $script(S_"intro")$,
    $tack n : NN$,
    $tack S(n) : NN$,
  )
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: $script(NN_"elim")$,
    $n : NN tack "mot"(n)$,
    $tack "mot" : NN -> "Prop"$,
    $tack "mot"(0)$,
    $n : NN, i h : "mot"(n) tack "mot"(S(n))$,
  )
)
]


== Kontrapositio

MAA11 s.87

== Epäsuora todistus

- $A -> B$ on ekvivalentti $not B -> not A$ klassisessa logiikassa
  - Huom: ei päde konstruktiivisessa logiikassa (kaikilla A ja B)

== Epäsuora todistus esimerkki


== Esimerkki ristiriidasta todistuksessa

- Negaation *eliminointisääntö*

#align(center, block[
  // #proof-tree(prem-min-spacing: 1em,
  //   rule(
  //     name: notElim,
  //     $Gamma tack bot$,
  //     $Gamma tack A$,
  //     $Gamma tack not A$,
  //   ),
  // )

  #proof-tree(prem-min-spacing: 1em,
  rule(
    name: impElim,
    $A, (A -> not A) tack bot$,
    rule(
      name: hyp,
      $A, (A -> not A) tack A$,
    ),
    rule(
      name: impElim,
      $A, (A -> not A) tack not A$,
      rule(
        name: hyp,
        $A, (A -> not A) tack (A -> not A)$,
      ),
      rule(
        name: hyp,
        $A, (A -> not A) tack A$,
      ),
    ),
  ),
)])

== Universaalikvanttori

== Eksistenssikvanttori

== Lähteitä

- https://en.wikipedia.org/wiki/Natural_deduction
- https://fi.wikipedia.org/wiki/Luonnollinen_p%C3%A4%C3%A4ttely