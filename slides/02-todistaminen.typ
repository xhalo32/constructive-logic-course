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

// == TODO

// #todo[
//   - todistus siitä, että $A -> A$
//   - implikaation sulutus, mitä eroa on $A -> (A -> B) -> B$ ja $A -> A -> B -> B$ välillä?
// ]

== Tällä tunnilla käydään...

- Mitä vaaditaan osoittamaan looginen väite korrektiksi
- Päättelysääntöjä
- Milloin looginen väite on tautologia tai todistettavissa vääräksi
- Konstruktiivisen logiikan kieli
  - Konstruktiivisen logiika päättelysääntöjä
  - Todistus luonnollisella päättelyllä
- Klassisen logiikan ominaispiirteet
  - Ristiriitatodistus
// - Kvanttorit ja todistaminen predikaattilogiikassa

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

== Konteksti

- $Gamma tack A$ sanoo, että oletuksista $Gamma$ seuraa *johtopäätös* $A$.
  - $tack$ merkin vasemmalla puolella on niin kutsuttu *konteksti*, eli paikalliset oletukset.
- Konteksti koostuu pilkulla erotetuista oletuksista, esim $A, B, not C$.
  - Oletukset ovat voimassa $tack$ merkin oikealla puolella.
- Konteksti on loogisesti ekvivalentti kaikkien oletuksien konjunktiosta.
- Muita esimerkkejä kontekstista:
  - Oletukset $A, B, C$ ovat ekvivalentti $A and B and C$ kanssa.
- Konteksti muuttuu todistuksen eri vaiheissa.

== Logiikan päättelysäännöt

#let hyp = $script("hyp")$
#let impIntro = $script(scripts(->)_"intro")$
#let impElim = $script(scripts(->)_"elim")$
#let andIntro = $script(scripts(and)_"intro")$
#let botElim = $script(scripts(bot)_"elim")$

- Koostuvat _tuonti_- ja _eliminointisäännöistä_.
  - Tuonti on verrattavissa rakenteen muodostumiseen
  - Eliminointi rakenteen purkamiseen
- Päättelysääntö vastaa yhtä jakoviivaa.
- Päättelysäännöillä muovataan oletuksia ja johtopäätöstä.
- Jotkin päättelysäännöt ovat molempisuuntaisia, mutta joillakin päättely menee vain yhteen suuntaan.
- Päättelysäännöt yleensä kirjoitetaan lyhennettynä ilman kontekstia tai $tack$ merkkiä.

== Todistus päättelysääntöjä käyttäen

- Väite kirjotetaan viivan alapuolelle, valitaan sopiva päättelysääntö, jonka määrämänä viivan yläpuolelle muodostuu _maaleja_ ($0-n$ kpl).
- Todistuksen välivaiheet ilmenevät päättelyviivoina, ja todistuksen "tila", eli oletukset ja väite muuttuvat välivaiheiden välillä.
- Todistus on *valmis* kun jokaisen viivan yläpuolella on tyhjää.
- "hyp"-päättelysääntö sanoo, että jos väite löytyy oletuksista, niin todistus on valmis.

#grid(columns: (1fr,)*3, align: center + horizon)[
#proof-tree(prem-min-spacing: 1em,
  rule($tack A -> A$)
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: impIntro,
    $tack A -> A$
  )
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: impIntro,
    $tack A -> A$,
    rule(
      name: hyp,
      $A tack A$
    )
  )
)
]

== Logiikan päättelysäännöt (vain osa)

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
  - Jos $Gamma tack bot$, niin sanotaan, että oletuksissa $Gamma$ on ristiriita (tai ristiriitaisi oletuksia).

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

- Lause on todistettu matemaattinen väite.
- Usein lauseet ovat "matemaattisesti merkittäviä", mutta tämä on vain konventio
- Lauseet ovat myös usein kohtuullisen yleisessä muodossa, esim $a + b = b + a$ on yleisempi kuin $a + 0 = 0 + a$, koska jälkimmäinen seuraa ensimmäisestä.
- Esimerkkejä lauseista:
  - #link("")[Banachin#footnote[Stefan Banach, 1892-1945]-Tarskin#footnote[Alfred Tarski, 1901-1983] lause]
  - #link("https://en.wikipedia.org/wiki/Brouwer_fixed-point_theorem")[Brouwerin#footnote[Luitzen Egbertus Jan Brouwer, 1881-1966] kiintopistelause]
  - #link("https://en.wikipedia.org/wiki/Cantor%27s_theorem")[Cantorin#footnote[Georg Cantor, 1845-1918] lause]

== Apulause, eli _lemma_

- Todistaessa on usein helpompaa rikkoa todistuksen välivaiheet omiksi todistuksiksi.
- Esimerkkejä
  - #link("https://en.wikipedia.org/wiki/Fermat%27s_Last_Theorem")[Fermat#footnote[Pierre de Fermat, \~1607-1665]:n viimeinen lause] $a^(n + 2) != b^(n + 2) + c^(n + 2)$ kaikille $a, b, c, n > 0$, kannattaa todistaa #link("https://en.wikipedia.org/wiki/Modularity_theorem")[Taniyama#footnote[Yutaka Taniyama, 1927-1958]-Shimura#footnote[Goro Shimura, 1930-2019] lause] ensiksi
  - Todistaessa $1/(a + 1) > 1/(a + 2)$ kaikilla $a > 0$, kannattaa tehdä välitodistus siitä että $a + 1 != 0$.

== Aksiooma

- Aksioomat ovat johdettavissa/todistettavissa *ilman päättelyä*.
  - Tautologia, joka ei tarvitse todistusta.
- Esimerkkejä aksioomista
  - Peano aksioomat
  - Joukko-opin aksioomat
  - Tyyppiteorian aksioomat
- Luonnolliset luvut voidaan muodostaa tyyppiteoriassa seuraavilla säännöillä: 

#grid(columns: (1fr, 1fr, 2fr), align: center + horizon)[
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
    $tack S(n) : NN$,
    $tack n : NN$,
  )
)
][
#proof-tree(prem-min-spacing: 1em,
  rule(
    name: $script(NN_"elim")$,
    $n : NN tack "mot"(n)$,
    $tack "mot" : NN -> "Prop"$,
    $tack "mot"(0)$,
    $n : NN, "ih" : "mot"(n) tack "mot"(S(n))$,
  )
)
]

== Negaatio ja $bot$

- Konstruktiivisessa logiikassa ja tyyppiteoriassa väitteen negaatio usein määritetään implikaationa $not A :eq.triple A -> bot$.
- $bot$:illa *ei ole* tuontisääntöä.
- $bot$:in *eliminointisääntö*:
  - Jos kontekstista $Gamma$ voidaan johtaa $bot$, niin voidaan johtaa mikä tahansa väite $A$.

#v(2em)

#align(center, proof-tree(prem-min-spacing: 1em,
  rule(
    name: botElim,
    $Gamma tack A$,
    $Gamma tack bot$
  ),
))

== Epäsuora, eli ristiriitatodistus

- *Kontraposition laki* on klassisessa logiikassa oleva lause, joka sanoo, että $A -> B$ jos ja vain jos $not B -> not A$.
  - Jos-suunta$<-$ ei päde konstruktiivisessa logiikassa yleisesti.
- *Ristiriitatodistuksessa* todistetaan $A -> B$ osoittamalla kontrapositiivinen väite $not B tack not A$, joka on sama kuin $not B, A tack bot$.
  - "Olettaen että $B$ ei päde, mutta $A$ pätee, niin seuraa ristiriita."
- Toisin kuin epäsuora todistus, negaatiotodistus on suora todistus

== Kolmannen poissulkevan laki

- Klassisen logiikan aksiooma.
- Sanoo, että kaikki väitteet ovat joko tosia, tai epätosia.
- Ei päde konstruktiivisessa logiikassa yleisesti.

#v(2em)

#align(center, proof-tree(prem-min-spacing: 1em,
  rule(
    name: $script("KPL")$,
    $Gamma tack A or not A$,
  ),
))

== Esimerkki ristiriidasta todistuksessa

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
      $A, (A -> not A) tack A -> bot quad "(huom." eq.triple not A$,
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

== Lähteitä

- https://en.wikipedia.org/wiki/Natural_deduction
- https://fi.wikipedia.org/wiki/Luonnollinen_p%C3%A4%C3%A4ttely