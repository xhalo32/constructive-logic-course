= title: Konstruktiivinen logiikka ja formaali todistaminen – lukiokurssi

= Johdanto
Konstruktiivinen logiikka on logiikan haara, jossa todistukset matemaattisista väitteistä sisältävät rakennetta ja ovat algoritmillisesti varmistettavissa.

Klassisessa logiikassa väitteiden oletetaan saavan totuusarvoiksi /tosi/ tai /epätösi/ riippumatta siitä löytyykö väitteelle tai sen negaatiolle todistusta. Konstruktiivinen logiikka ei tee tätä oletusta, vaan väitteet voidaan osoittaa todeksi ainoastaan konstruoimalla todistus väitteestä.

Konstruktiivisessa lauselogiikassa konnektiivit →, ∧ ja ∨ ei ole määritetty totuustaulujen avulla, vaan muodostamalla kieli, jossa nämä konnektiivit konstruoidaan ja eliminoidaan käyttäen päättelysääntöjä. Lisäksi predikaattilogiikan kvanttorit ∃, ∀ esiintyvät /tyyppien/ abstraktiotasolla, kun konstruktiivisesta lauselogiikasta siirrytään /tyyppiteoriaan/.

Kurssilla on päätarkoituksena oppia todistustekniikoita, matematiikan formalisointia, ja miten todistuassistentti (ja ohjelmointikieli) Lean auttaa matemaatikkoja todistamaan väitteitä.

Kurssilla pelataan Lean-pohjaisia pelejä.

== Kuvaus
Konstruktiivisen logiikan ja formaalin todistamisen kurssilla opit miten matematiikkaa formalisoidaan tietokoneavusteisesti.

Kurssin pääoppimistavoitteet ovat ymmärtää:
- lause- ja predikaattilogiikan perusteet,
- miksi matematiikan aksiomaattinen perusta on rajoittunut ja minkälaisia ongelmia sen kanssa on ollut viime vuosisadalla,
- joukko-opin ja luonnollisten lukujen teorian perusteet,
- miten matemaattisia lauseita formalisoidaan Leanilla.
- klassisen ja konstruktiivisen logiikan sekä tyyppiteorian yhtäläisyydet ja erot,

= Muita huomioita
- MA11 on hyötyä kurssilla
- Ei pakollisia esitietovaatimuksia

= Sisältö
== Matematiikan filosofiaa
=== Mitä on logiikka
- Filosofinen näkökulma
  - Totuus ja tieto
  - Logiikka on perusta kaikelle tiedolle
  - Mitä tarkoittaa epätosi? Kaikki joka ei ole totta on epätotta?
  - principium tertii exclusi
- Formaali tiede, <https://en.wikipedia.org/wiki/Formal_science#Differences_from_other_sciences> lainaus
- Oletukset ja johtopäätökset
- Mitä tarkoittaa antaa merkeille ja sanoille formaali merkitys? <https://en.wikipedia.org/wiki/Interpretation_(logic)>
- Lauseen syntaksi ja semantiikka
- Informaali ja formaali logiikka
  - Informaalissa logiikassa kiinnitetään huomiota semantiikkaan, formaalissa ei?

=== Mitä on matematiikka
- Mikä on todistus?
  - Suora todistus
  - Epäsuora todistus
- Tarvitaanko todistuksia, sillä jos väite on totta niin sen todistaminen on vain tapa todeta että se oli totta.
  - Ovatko väitteet totta riippumatta siitä onko niitä todistettu?
  - Ovatko kaikki väitteet totta tai epätotta?
- Miten todistuksia tehdään?
  - Proof without evidence
- Looginen virhe
- Voiko matematiikkaan luottaa?

=== Matematiikan perusta
- Perustakriisi <https://en.wikipedia.org/wiki/Foundations_of_mathematics#Foundational_crisis>
- Konstruktivismi
  - Lainaus: "its laws are absolutely certain and indisputable"
  - Curry-Howard isomorfismi
    - Väitteet tyyppeinä -paradigma
    - Väitteet ovat avaruuksia ja todistukset pisteitä
  - Klassisen loogikon ja konstruktivistin syntymäpäiväkakku
- Todistusassistentti
- Määritelmä: formaali todistus

== Logiikan perusteet

== Luonnolliset luvut
- Peanon aksioomat
- Induktio luonnollisille luvuille

== Predikaattilogiikka

== Joukko-oppi
- Russelin paradoksi: <https://lean-lang.org/functional_programming_in_lean/functor-applicative-monad/universes.html>

== Tyyppiteoria

== Lean
- Esimerkki: kehäpäätelmä

= Teemat
== Funktio ja alkio
Motivaatio:
- Normaalisti ajatellaan sellaisesta filosofisesta näkökulmasta että funktiot eroavat jotenkin alkioista
- Avainidea: kaikki ovat funktioita, myös alkiot
- Myytti: Funktio joka ottaa funktioita sisään tai palauttaa funktioita on "monimutkaisempi" kuin sellainen joka toimii alkioilla
- Mikä on muuttujan rooli? On rajoittavaa olettaa että funktiot eivät voi olla muuttujia/muuttujissa eli "muuttua",
  - Mitä edes tarkoittaa "muuttuminen"
- Joukot sisältävät alkioita (jäseniä), eli joukot sisältävät funktioita?
- Funktio käsitteenä on alkeellisempi kuin käsite alkiosta, joka on ironista
- Funktio, jonka arvo riippuu jostain toisesta arvosta voidaan tulkita determinaatio-ongelmana (Lawvere s.45)
- Muita väärinkäytettyjä termejä:
  - Funktionaali
  - Kuvaus
  - Avaruus
  - Joukko
- Funktion nimi, funktion "olemus", funktion lauseke/keho, funktion arvo "kohdassa"
- Funktio vs proseduuri
  - Funktion identiteetin määrittää yksittäin ulospäin näkyvä "käytös"
  - Proseduurit voivat olla eri vaikka ne saavuttaisivat saman lopputuloksen eli ovat sama funktio

= TODO
- Kurssin alkupään opetusmateriaali
  - Logiikan perusteet
  - Kynä-paperi tehtäviä
  - Implikaation visualisointi
  - Todistaminen kynällä ja paperilla
    - Totuustauluja
    - `A -> B -> A`
  - Opitaan lukemaan ja tulkitsemaan loogisia väitteitä, jotka koostuvat symboleista
  - Välitesti 1
- Konstuktiivisen logiikan aksioomat
  - `|- <> : True`
  - `A, A -> B |- B`
- Predikaatit
  - Predikaatti `IsZero : Nat -> Prop`: `IsZero n` tarkoittaa että n = 0
- Predikaattilogiikka
  - Avoin lause
  - Kvanttorit
  - Äärellinen tyyppi
  - Kvanttoreita totuustaululla äärellisistä tyypeistä, esim `{A, B, C}`
  - Miksi totuustaulu ei enää riitä todistamaan predikaattia esim. kaikista luvuista
  - Predikaatti `Even : Nat -> Prop`: `Even n` tarkoittaa että luku n on parillinen
  - Kaksipaikkainen relaatio
  - Välitesti 2


= Vanhoja TODOja
== Proof systems and what consists a proof, what is formalism?
== Natural numbers starting from 0 or 1
== Entailment relation
== Mitä tarkoittaa "by definition"
== Gödelin täydellisyys ja epätäydellisyyslause
- Gödelin numerointi
- Metamatematiikka
== Dependentit tyypit
== Modaali logiikka?
=== Suht yksinkertainen Lean esimerkki <https://github.com/paulaneeley/modal>

== Asioiden formalisointi ei ole absoluuttista. Tulevaisuudessa tyyppiteoriakin saattaa olla liian epäformaalia
== Formaalissa matematiikassa kaikki sanat koostuvat määritelmistä, jotka ovat yksiselitteisiä
= Resursseja
== <https://en.wikipedia.org/wiki/Philosophy_of_mathematics>
== <https://iep.utm.edu/propositional-logic-sentential-logic/#H5>
== Joitain tehtäviä TPiListä: <https://lean-lang.org/theorem_proving_in_lean4/propositions_and_proofs.html#exercises>
== Laadukkaat lean luentodiat tyypeistä propositioista ja universumeista <https://math.berkeley.edu/~kmill/talks/2020-06-26-lean-seminar.pdf>
== <https://en.wikipedia.org/wiki/Brouwer%E2%80%93Hilbert_controversy>
== Muita kursseja jotka ovat käyttäneet Leania
<https://leanprover-community.github.io/teaching/courses.html>


= Nix käyttöohjeet
Seuraavilla komennoilla saat mkdocsin pyörimään

#+BEGIN_SRC sh
nix develop --impure
nix run .#serve
#+END_SRC

= Lean4game käyttöohjeetn

#+begin_src sh
cd lean4game
npm install
npm start
#+end_src

Toisessa terminaalissa aja

#+begin_src shell
cd ConstructiveLogicCourseGame
nix run .#autobuild
#+end_src

Huomaa, että autobuild buildaa vasta kun koodiin tulee muutos, joten lisää esim. rivinvaihto jonnekin

Sitten avaa <http://localhost:3000/#/g/local/ConstructiveLogicCourseGame/>

= Beamer käyttöohje
Lataa LaTeX workshop <https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop>

Ohjeet miten lisätä ja latoa kuvia: <https://latex-beamer.com/tutorials/beamer-figure/>
