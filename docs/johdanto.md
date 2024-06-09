# Johdanto

Tervetuloa konstruktiivisen logiikan ja formaalin todistamisen kurssille!

Kurssilla on päätarkoituksena oppia logiikkaa, matematiikan formalisointia ja miten todistuassistentti (ja ohjelmointikieli) Lean auttaa matemaatikkoja todistamaan väitteitä.

Kurssilla pelataan Lean-pohjaista peliä.

## Tietoa kurssista

Tältä verkkosivulta löydät kaiken kurssiin littyvän, kuten oppituntien luentomuistiinpanot sekä lisämateriaalia käsitellyistä aiheista.

## Tehtävät

## Oppimistavoitteet

- Ymmärtää lause- ja predikaattilogiikan perusteet
  - Logiikan kieli, konnektiivit, kvanttorit
- Tietää mistä kielet rakentuvat ja miten kielioppeja luodaan
- Osata todistaa lauseita formaalisti
  - Suora ja epäsuora todistus
- Ymmärtää todistusjärjestelmien rajoitteet
  - Gödelin epätäydellisyyslause
  - Aksioomiin liittyvät rajoitteet
  - Päättelysääntöjen rajoitteet
- Tietää Frege:n lauselogiikan
- Ymmärtää klassisen ja konstruktiivisen logiikan erot
  - Mitä on totuusarvot
  - Mitä on todistustermit
- Tietää konstruktivismin historiaa ja filosofiaa
  - Kuuluisia konstruktivisteja ja konstruktivsmia vastaan olevia matemaatikkoja
  - Brouwerin kiintopistelause
- Ymmärtää intuitionistisen lauselogiikan konstruktion
  - Totuus ja epätotuus
  - Konjunktio, disjunktio
  - Gentzenin inversioperiaate
  - Negaatio
  - Miten konstruktiivinen logiikka on vahvempi perusta matematiikalle kuin klassinen logiikka
- Tietää 1900-luvun vaihteessa joukko-oppia piinaavia paradokseja
- Tietää tyyppiteorian perusteet
  - Funktio
  - Summatyyppi, tulotyyppi
  - Korkeamman asteen logiikka
- Ymmärtää luonnollisten lukujen konstruktion ja induktioperiaatteen
- Osaa tehdä induktiotodistuksia luonnollisilla luvuilla
- Tietää miten matematiikkaa formalisoidaan tietokoneavusteisesti
  - Tietää Curry-Howard isomorfismin merkityksen
  - Osaa käyttää Leania todistamaan lause- ja predikaattilogiikan lauseita

## Kappalejako

0. Kappale 0: Määritelmiä
0. Kappale 1: Lauselogiikka
  - Konnektiivit
0. Kappale 2: Todistaminen
0. Kappale 3: Aritmetiikka
  - Induktio
0. Kappale 4: Formalisaatio
0. Kappale 5: Joukot, tyypit ja universumit
  - Kvanttorit $\forall, \exists$
0. Kappale 6: Funktiot
  - Curry-Howard isomorfismi

## Maukasta Lean-koodia

```lean
structure NonEmptyList (α : Type) : Type where
  head : α
  tail : List α

def idahoSpiders : NonEmptyList String := {
  head := "Banded Garden Spider",
  tail := [
    "Long-legged Sac Spider",
    "Wolf Spider",
    "Hobo Spider",
    "Cat-faced Spider"
  ]
}

def NonEmptyList.get? : NonEmptyList α → Nat → Option α
  | xs, 0 => some xs.head
  | xs, n + 1 => xs.tail.get? n

abbrev NonEmptyList.inBounds (xs : NonEmptyList α) (i : Nat) : Prop :=
  i ≤ xs.tail.length

theorem atLeastThreeSpiders : idahoSpiders.inBounds 2 := by simp

theorem notSixSpiders : ¬idahoSpiders.inBounds 5 := by simp
```
