#import "@preview/curryst:0.3.0": rule, proof-tree

#set page(margin: 1cm)

#set text(font: "New Computer Modern")

#let Prop = "Prop"

#grid(columns: (1fr, auto), gutter: 0.65em, align: (left,right))[
  Otaniemen lukio
][
  *Tehtävämoniste 2*
][
  TEC09.1 Konstruktiivinen logiikka ja formaali todistaminen 2024
][
  Niklas Halonen & Alma Nevalainen
]

== Tehtävä 0.

Formalisoi seuraavaa väite. Predikaatti $P(X, n)$ tarkoittaa, että "$X$ antaa $n$ puhelinnumeroa Viestintävirastolle."

a) "Henrik antaa vähintään 2 tai enintään 3 puhelinnumeroa Viestintävirastolle."

#v(2em)

// Vastaus:

// $
// (exists n, (n >= 2 or n <= 3) and P(X, n))
// $

// Huom. $(exists n, n >= 2 and n <= 3 and P(X, n))$ on mitä Viestintävirasto varmaan tarkoitti.

b) Voiko Henrik antaa vain yhden puhelinnumeron Viestintävirastolle? Perustele.

#v(2em)

_(Kiitos Henrik hyvästä tehtäväideasta.)_

// TODO tämä monisteeseen 3
// == Tehtävä 2.

// Formalisoi seuraavat lauseet. Tyyppi $H$ tarkoittaa, että $x : H$ on ihminen. Predikaatit $F : H -> Prop$ ja $M : H -> Prop$ ilmaisevat onko kyseinen ihminen filosofi tai kuolevainen vastaavasti.

// a) "Socrates on kuolevaisia."

// #v(2em)

// b) "Socrates on kuolematon filosofi."

// #v(2em)

// c) "Kaikki ihmiset ovat kuolevaisia."

// #v(2em)

// d) "Kaikki ihmiset jotka ovat filosofeja ovat kuolevaisia."

// #v(2em)

// e) "Kaikki ihmiset jotka ovat yhtäsuuria kuin Socrates, ovat filosofeja."

// #v(2em)

// f) "Kaikki ihmiset jotka eivät ole filosofeja eivät ole yhtäsuuria kuin Socrates."

// #v(2em)

== Tehtävä 1.

Päättele seuraavista lauseista kaikkien muuttujien tyypit. Predikaatti $"Kuolevainen"$ on tyyppiä $"Ihminen" -> "Prop"$.

#grid(columns : (1fr, 1fr), gutter: 0.65em)[
a) $x = 5 and y = 7$

#v(2em)
][
b) $"Kuolevainen"(S)$

#v(2em)
][
c) $f(5) = 3$

#v(2em)
][
d) $forall x : "Ihminen", P(x) and Q(x)$

#v(2em)
]
== Tehtävä 2.

Todista totuustaulun avulla, sekä luonnollisella päättelyllä seuraavat väitteet.

#grid(columns : (2fr, 1fr), gutter: 0.65em)[
a)
#v(12em)
#align(center, proof-tree(rule($ tack A <-> A and A $)))
][
#let n = 2
#grid(stroke: 1pt + gray, align: center, inset: 0.65em, columns: (auto, auto, 3fr),
  $A$, $B$, "",
  ..(range(calc.pow(2, n)).map(n => (str(calc.rem-euclid(n, 2)), str(calc.rem(calc.div-euclid(n, 2), 2)), "")).flatten())
)
][
b)
#v(18em)
#align(center, proof-tree(rule($ tack A -> B -> C -> A $)))
][
#let n = 3
#grid(stroke: 1pt + gray, align: center, inset: 0.65em, columns: (auto, auto, auto, 3fr),
  $A$, $B$, $C$, "",
  ..(range(calc.pow(2, n)).map(n => (str(calc.div-euclid(n, 4)), str(calc.rem(calc.div-euclid(n, 2), 2)), str(calc.rem(n, 2)), "")).flatten())
)
]

#pagebreak()

== Tehtävä 3.

Muodosta luonnollisella päättelyllä todistus seuraaville väitteille. Merkitse jokainen päättelysääntö jakoviivan viereen.

#grid(columns : (1fr, 1fr), gutter: 0.65em)[
a)
#v(10em)
#align(center, proof-tree(rule($ tack A -> A or not A $)))
][
b)
#v(10em)
#align(center, proof-tree(rule($ tack A and B -> A or B $)))
][
c)
#v(10em)
#align(center, proof-tree(rule($ A -> B tack A <-> A and B $)))
][
d)
#v(10em)
#align(center, proof-tree(rule($ Gamma, A tack not not A $)))
]
e)
#v(10em)
#align(center, proof-tree(rule($ Gamma, not A or not B tack not (A and B) $)))

f)
#v(10em)
#align(center, proof-tree(rule($ Gamma, not (A and B) tack not A or not B $)))


#align(center)[
Tässä tehtävässä tarvitaan klassista logiikka, eli käytä *kolmannen poissulkevan lakia*:
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: $script("KPL")$,
    $Gamma tack A or not A$,
  ),
)
]
