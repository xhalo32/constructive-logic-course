#set page(margin: 1cm)

#set text(font: "New Computer Modern")

#grid(columns: (1fr, auto), gutter: 0.65em, align: (left,right))[
  Otaniemen lukio
][
  *Tehtävämoniste 1*
][
  TEC09.1 Konstruktiivinen logiikka ja formaali todistaminen
][
  Niklas Halonen & Alma Nevalainen
]

== Tehtävä 1.

Olkoon $A$ "sataa" ja $B$ "paistaa".

a) Suomenna lauseet $not (A and B)$ sekä $not A or not B$.

#v(5em)

b) Muodosta a-kohdan lauseiden totuustaulut.

#v(5em)

c) Ovatko a-kohdan lauseet loogisesti yhtäpitävät eli ekvivalentit? Perustele.

#v(5em)

== Tehtävä 2.

Olkoo $A$ "olen ulkona" ja $B$ "aurinko paistaa", $C$ "minulla on takki päällä". Esitä seuraava lause formaalisti:

a) "Olen ulkona ja jos aurinko ei paista, niin minulla on takki päällä."

#v(2em)


b) "Olen ulkona jos ja vain jos monulla on takki päällä, tai jos olen ulkona, niin aurinko paistaa."

#v(2em)

// $(A <=> C) or (A => B)$

== Tehtävä 3.

Täytä totuustaulu lauseelle $(A and not B) <=> (not C => B)$

#grid(stroke: 1pt + gray, align: center, inset: 0.65em, columns: (auto, auto, auto, 1fr, 1fr, 3fr),
  $A$, $B$, $C$, $A and not B$, $not C => B$, "",
  ..(range(8).map(n => (str(calc.div-euclid(n, 4)), str(calc.rem(calc.div-euclid(n, 2), 2)), str(calc.rem(n, 2)), "", "", "")).flatten())
)
