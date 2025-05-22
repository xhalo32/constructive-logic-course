#import "@preview/curryst:0.3.0": rule, proof-tree

#set page(margin: 1cm)

#let Prop = "Prop"
#let hyp = $script("hyp")$
#let have = $script("have")$
#let impIntro = $script(scripts(->)_"intro")$
#let impElim = $script(scripts(->)_"elim")$
#let andIntro = $script(scripts(and)_"intro")$
#let andElim1 = $script(scripts(and)_"elim 1")$
#let andElim2 = $script(scripts(and)_"elim 2")$
#let orElim = $script(scripts(or)_"elim")$
#let orIntro1 = $script(scripts(or)_"intro 1")$
#let orIntro2 = $script(scripts(or)_"intro 2")$
#let notElim = $script(scripts(not)_"elim")$
#let topIntro = $script(scripts(top)_"intro")$
#let botElim = $script(scripts(bot)_"elim")$
#let iffIntro = $script(scripts(<->)_"intro")$

#grid(columns: (1fr, auto), gutter: 0.65em, align: (left,right))[
  Otaniemen lukio
][
  *Huijauslehti: Päättelysäännöt*
][
  TEC09.1 Konstruktiivinen logiikka ja formaali todistaminen 2024
][
  Niklas Halonen & Alma Nevalainen
]

#set text(font: "New Computer Modern", size: 12pt)

#v(4em)

#show heading: it => {align(center, it); v(1em)}

#grid(columns: (1fr, 1fr), gutter: 1em)[
//   == Terminologia

//   - päättelysääntö
//   - päätelmä
//   - päättelyviiva
//   - konjunktio
//   - disjunktio
//   - metamuuttuja
//   - hypoteesi, oletus
// ][
  == Syntaksi

  - Päätelmä $Gamma, A tack Phi$
    - Konteksti, eli oletukset $Gamma, A$
    - Maali, eli oletuksista todistettava väite $Phi$
  - Metamuuttujat $Gamma, A, Phi, ...$ (voidaan korvata millä tahansa väitteillä)
][
  == Päätelmälliset säännöt

  #align(center, proof-tree(rule(
    name: hyp,
    $Gamma, A tack A$,
  )))

  #align(center, proof-tree(rule(
    name: have,
    $Gamma tack Phi$,
    $Gamma tack Psi$,
    $Gamma, Psi tack Phi$,
  )))
][
  == Konjunktio $and$

  #align(center)[
    #proof-tree(rule(
    name: andIntro,
    $Gamma tack A and B$,
    $Gamma tack A$,
    $Gamma tack B$,
  ))
  #grid(columns: (1fr,)*2)[
  #proof-tree(rule(
    name: andElim1,
    $Gamma tack A$,
    $Gamma tack A and B$,
  ))][
  #proof-tree(rule(
    name: andElim2,
    $Gamma tack B$,
    $Gamma tack A and B$,
  ))]
  ]
][
  == Disjunktio $or$

  #align(center)[
  #grid(columns: (1fr,)*2)[
  #proof-tree(rule(
    name: orIntro1,
    $Gamma tack A or B$,
    $Gamma tack A$,
  ))][
  #proof-tree(rule(
    name: orIntro2,
    $Gamma tack A or B$,
    $Gamma tack B$,
  ))]
  #proof-tree(rule(
    name: orElim,
    $Gamma, A or B tack Phi$,
    $Gamma, A tack Phi$,
    $Gamma, B tack Phi$,
  ))
  ]
][
  == Tosi $top$

  #align(center)[
  #proof-tree(rule(
    name: topIntro,
    $Gamma tack top$,
  ))
  ]
][
  == Epätosi $bot$

  #align(center)[
  #proof-tree(rule(
    name: botElim,
    $Gamma tack A$,
    $Gamma tack bot$,
  ))
  ]
][
  == Implikaatio $->$

  #align(center)[
  #grid(columns: (1fr,)*2)[
  #proof-tree(rule(
    name: impIntro,
    $Gamma tack A -> B$,
    $Gamma A, tack B$,
  ))][
  #proof-tree(rule(
    name: impElim,
    $Gamma tack B$,
    $Gamma tack A -> B$,
    $Gamma tack A$,
  ))]
  ]
][
  == Ekvivalenssi $<->$

  #align(center)[
  #proof-tree(rule(
    name: iffIntro,
    $Gamma tack A <-> B$,
    $Gamma tack A -> B$,
    $Gamma tack B -> A$,
  ))
  ]
]