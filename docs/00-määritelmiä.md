# 0 – Määritelmiä

> One reason why mathematics enjoys special esteem, above all other sciences, is that its laws are absolutely certain and indisputable, while those of other sciences are to some extent debatable and in constant danger of being overthrown by newly discovered facts. 
>
> <span style="float:right">—  Albert Einstein</span>

## Kurssiesittely

!!! todo

    - Päivät
    - Kurssin rakenne
    - Läpipääsyvaatimukset
    - Oppimistavoitteet
    - Oppilaat avaavat kurssimateriaalin
    - Classroom

## Mitä on konstruktiivinen logiikka?

Konstruktiivinen logiikka on logiikan haara, jossa todistukset matemaattisista väitteistä sisältävät rakennetta ja ovat algoritmillisesti varmistettavissa.

Klassisessa logiikassa väitteiden oletetaan saavan totuusarvoiksi _tosi_ tai _epätösi_ riippumatta siitä löytyykö väitteelle tai sen negaatiolle todistusta. Konstruktiivinen logiikka ei tee tätä oletusta, vaan väitteet voidaan osoittaa todeksi ainoastaan konstruoimalla todistus väitteestä.

Konstruktiivisessa lauselogiikassa konnektiiveja $\rightarrow$, $\land$ ja $\lor$ ei ole määritetty totuustaulujen avulla, vaan muodostamalla kieli, jossa nämä konnektiivit konstruoidaan ja eliminoidaan käyttäen päättelysääntöjä. Lisäksi predikaattilogiikan kvanttorit ∃, ∀ esiintyvät _tyyppien_ abstraktiotasolla, kun konstruktiivisesta lauselogiikasta siirrytään _tyyppiteoriaan_.

## Mitä on formaali todistaminen?

!!! todo

    - Perinpohjainen
    - Miten oletuksista muodostetaan käytetyn logiikan sääntöjen mukaisesti haluttu lause (maali)?
    - Formaalin todistuksen pätevyys on objektiivista <https://www.cl.cam.ac.uk/~jrh13/slides/upitt-22mar07/slides.pdf>
    - Todistaminen koneavusteisesti, minimoidaan inhimiliset tekijät, jotta päästään mahdollisimman lähelle ideaalia tarkistusprosessia

## Mitä tarkoittaa "määritelmän mukaan"


## Mitä on funktionaalinen ohjelmointi?

!!! todo

    - Mitä on ohjelmointi?
    - Joissain ohjelmointikielissä suositaan funktioita ja "puhtautta", ja ne ovat lähempänä matematiikan käsitystä funktiosta. Funktiot näissä kielissä esittävät algoritmiä/laskentaa sen sijaan, että esittävät muutoksia tietokoneen tilassa.

## Mitä ovat rationaaliluvut?

!!! todo

### Todistus siitä, että $\sqrt 2$ on irrationaalinen

!!! todo

    - Lemma 1: Kaikille rationaaliluvuille löytyy supistettu muoto
    - By_contra: oletetaan että $\sqrt 2 = \frac n m$
    - Lemma 1 nojalla: on olemassa supistettu muoto $\frac p q = \frac n m = \sqrt 2$
    - Supistetulle muodolle pätee, että joko m:n tai n:n on oltava pariton luku
    - $(\frac m n) ² = 2$, huom. (n $\ne$ 0)
    - $m² = 2n²$
    - m siis on parillinen
    - koska m on parillinen, vaidaan sanoa $m = 2k$
    - Tästä siis seuraa, että $(2\frac k n) ² = 2$
    - Elikkä $2k² = n²$
    - Myös n on siis parillinen. Kaksi siis jakaa molemmat luvut, mikä on ristiriidassa aiempien oletusten kanssa.
    - Voidaan siis sanoa, että $\sqrt 2$ on irrationaalinen $\square$

### Leanillä formalisoitu todistus

!!! warning 
    Pelottavaa Lean-koodia edessäpäin. Jatka lukemista omalla vastuulla.


``` lean
import Mathlib
open Rat

def is_even (n : Nat) : Prop := ∃ m, n = 2 * m
def is_odd (n : Nat) : Prop := ¬ (is_even n)
def is_prime (n : Nat) : Prop := ∃ m k, m * k = n → (m = 1 ∨ k = 1)

#check Nat.Coprime
#check Rat.mk'

lemma pow_even_imp_even (n : Int) : Even (n ^ 2) → Even n := by
  intro h
  rw [Int.even_pow] at h
  exact h.1

lemma two_mul_right_inj (m n : Int) : 2 * n = 2 * m → n = m := by
  norm_num

theorem sqrt2_irrat : (p : Nat) → (pnez : p ≠ 0) → (q : Int) → (cop : q.natAbs.Coprime p) → (Rat.mk' q p pnez cop) ^ 2 ≠ 2 := by
  intro p pnez q cop
  by_contra h
  simp [pow_def] at h
  rw [Nat.Coprime] at *
  have even_q : Even q := by
    rw [Even]
    apply pow_even_imp_even
    have num := congrArg Rat.num h
    simp at num
    have _den := congrArg Rat.den h
    simp at _den
    rw [num]
    simp
  have even_p : Even p := by
    rw [Even] at *
    cases' even_q with k hq
    rw [← two_mul] at *
    subst q
    have num := congrArg Rat.num h
    simp at num
    have den := congrArg Rat.den h
    simp at den
    rw [pow_eq_one_iff] at *
    rw [mul_pow] at num
    norm_num at num
    have gona : 2 * 2 = (4 : Int) := by ring
    rw [← gona] at num
    conv at num =>
      right
      rw [← mul_one 2]
    rw [mul_assoc] at num
    apply two_mul_right_inj at num
    have := congrArg Even num
    simp at this
    intro gona
    contradiction

  cases' even_p with p' hp
  cases' even_q with q' hq
  rw [← mul_two] at *
  have : 2 ∣ q.natAbs.gcd p := by
    apply Nat.dvd_gcd
    use q'.natAbs
    rw [hq]
    rw [Int.natAbs_mul]
    norm_num
    ring
    use p'
    rw [hp]
    ring
  rw [cop] at this
  contradiction
```

## Matematiikka

!!! todo

    - Matematiikka on filosofian haara
    - Matematiikka on kieli, jota käytetään mm. fysiikassa, tilastotieteessä ja ohjelmoinnissa. 
    - Numerot ja abstraktit rakenteet keskeisiä
    - Puhataan ja sovelletun matematiikan eroavaisuudet
    - Voiko matematiikkaan luottaa?
    - Merkittäviä matemaatikkoja : Euler, Gauss, Gödel, Turing, Church, von Neumann 

![](./static/map.png)

## Logiikka

!!! todo

    - <https://files.eric.ed.gov/fulltext/ED601039.pdf>
    - Aksioomat ja perusta
    - Joukko-oppi, tyyppiteoria
    - Päättelysäännöt
    - Todistaminen
    - Totuus ja tieto
    - Mitä tarkoittaa epätosi?
      - Ovatko kaikki mitkä eivät ole epätotta totta?
    - Merkittäviä loogikkoja
    - Informaali ja formaali logiikka
      - Formaali tiede, <https://en.wikipedia.org/wiki/Formal_science#Differences_from_other_sciences> lainaus
    - Oletukset $\vdash$ johtopäätökset 

## Matematiikan perusta ja kriisi

!!! todo 
    - Suhtautuminen matematiikan perustaan on muuttunut viime 
    - Laajalti käytössä olevan aksiomaattisen pohjan 
