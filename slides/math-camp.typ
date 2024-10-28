#import "@preview/touying:0.4.2": *
#import "slidetheme.typ"

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

#let s = slidetheme.register(aspect-ratio: "16-9")
#let s = (s.methods.info)(
  self: s,
  title: [Matematiikkaa tietokoneavusteisesti],
  subtitle: [Lean ja formaali todistaminen],
  author: [Niklas Halonen & Alma Nevalainen],
  date: datetime.today(),
  institution: [Aalto Math Camp 2024],
)
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show strong: alert

#let (slide, empty-slide, title-slide, new-section-slide, focus-slide) = utils.slides(s)
#show: slides

== Mikä on todistus?

- Mikä riittää matemaattisen ongelman ratkaisuksi?
- Milloin ollan perusteltu riittäväsi?
- Voiko perustelu olla *täydellinen*?

== Todistus?

Väite: Kaikkien kahden luonnollisen luvun $a, b$ summa on suurempaa, kuin kumpikaan luvuista.

Todistus: Tehdään induktiotodistus. Aloitetaan kantatapauksesta 1:

$a + 1 > a "ja" a + 1 > 1$, tämä on ilmiselvästi totta.

Seuraavaksi induktiivinen tapaus, jossa saadaan olettaa, että $a + b > a "ja" a + b > b$:

$a + b + 1 > a "ja" a + b + 1 > b + 1$ vasen puoli on selvästi totta, todistetaan oikea puoli:

$a + b + 1 > b + 1$, vähennetään molemmilta puolilta $1$ ja saadaan:

$a+b > b$, mikä saadaan suoraan induktio-oletuksista.

== Formalisointi

- Formaali kieli esitetään merkkijonona, eli tekstinä, jonka käsittelylle on tarkat säännöt.
  - Koodi on tekstiä ja koodin suorittamiselle on tarkat säännöt 
  $->$ Funktionaalinen ohjelmointi on formaalia.
- Matematiikkaa voidaan formalisoida ohjelmointikielillä, mikä mahdollistaa matematiikan tekemistä ja todistamista *tietokoneavusteisesti*.

== Todistusassistentit

- Tietokoneohjelma, joka ymmärtävät formaalia matematiikkaa ja pystyvät tarkistamaan sen korrektiutta.
- Seuraavat ovat yleisiä todistusassistentteja: *Lean*, Coq, Isabelle, Agda

== Lean

- Funktionaalinen, dependentisti tyypitetty ohjelmointikieli ja todistusassistentti.

- *Mathlib* -kirjasto

#image("nng-demo.png")

== Ensiaskeleet

#image("lean1.png")

== Ensiaskeleet

#image("lean2.png")

== Terminologiaa

- Maali: ```lean4 P```
- Konteksti
- Hypoteesi: ```lean4 todo_list```
- Alkio ja tyyppi: ```lean4 P : Prop```, ```lean4 todo_list : P```
- Taktiikka: ```lean4 exact```
- Lause

== Konjunktio

$ A and B $

- On sellainen tyyppi, joka sisältää todistuksen kahdesta tyypistä
- Sen alkiot voidaan muodostaa antamalla todistus molemmista tyypeistä
- Sen alkiot voidaan purkaa molempien tyypien todistuksiksi erikseen

== Konjunktio

Leanissä voidaan muodostaa konjunktio käyttämällä ```lean4 And.intro``` lausetta:

```lean4
example (a : A) (b : B) : A ∧ B := by
  exact And.intro a b
```

Tai rikkomalla maali kahteen tapaukseen `A` ja `B`:

```lean4
example (a : A) (b : B) : A ∧ B := by
  constructor
  -- Ensiksi pitää todistaa A
  · exact a
  -- Sitten pitää todistaa B
  · exact b
```

== Tehtäviä

=== lyli.fi/logiikka
- Suomeksi

=== adam.math.hhu.de
- In english
- Natural number game 
- A lean intro to logic