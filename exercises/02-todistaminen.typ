#set page(margin: 1cm)

#set text(font: "New Computer Modern")

#let Prop = "Prop"

#grid(columns: (1fr, auto), gutter: 0.65em, align: (left,right))[
  Otaniemen lukio
][
  *Tehtävämoniste 2*
][
  TEC09.1 Konstruktiivinen logiikka ja formaali todistaminen
][
  Niklas Halonen & Alma Nevalainen
]

== Tehtävä 1.

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

== Tehtävä 2.

Formalisoi seuraavat lauseet. Tyyppi $H$ tarkoittaa, että $x : H$ on ihminen. Predikaatit $F : H -> Prop$ ja $M : H -> Prop$ ilmaisevat onko kyseinen ihminen filosofi tai kuolevainen vastaavasti.

a) "Socrates on kuolevaisia."

#v(2em)

b) "Socrates on kuolematon filosofi."

#v(2em)

c) "Kaikki ihmiset ovat kuolevaisia."

#v(2em)

d) "Kaikki ihmiset jotka ovat filosofeja ovat kuolevaisia."

#v(2em)

e) "Kaikki ihmiset jotka ovat yhtäsuuria kuin Socrates, ovat filosofeja."

#v(2em)

f) "Kaikki ihmiset jotka eivät ole filosofeja eivät ole yhtäsuuria kuin Socrates."

#v(2em)

== Tehtävä 3.


Päättele seuraavista lauseista kaikkien muuttujien tyypit.

- $$