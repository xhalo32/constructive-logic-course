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

#show raw: it => block(
  fill: rgb("#eff1f5"),
  inset: 8pt,
  radius: 12pt,
  text(fill: rgb("#4c4f69"), it)
)

#let s = slidetheme.register(aspect-ratio: "16-9")
#let s = (s.methods.info)(
  self: s,
  title: [Konstruktiivinen logiikka ja formaali todistaminen],
  subtitle: [1 – Lauselogiikka],
  author: [Niklas Halonen & Alma Nevalainen],
  date: datetime.today(),
  institution: [Otaniemen lukio],
)
#let (init, slides, touying-outline, alert, speaker-note) = utils.methods(s)
#show: init

#show strong: alert

#let (slide, empty-slide, title-slide, new-section-slide, focus-slide) = utils.slides(s)
#show: slides

== Tällä tunnilla

TODO tunnin oppimistavoitteet
- Ymmärtää logiikan perusteet
  - Filosofiaa: totuus, erilaiset logiikat, päättely, loogiset paradoksit
  - Lauseet, väitteet, aksioomat, syy ja seuraus, hypoteesit, totuusarvot, ristiriidat, tautologiat
- Tietää mitä ovat informaali ja formaali logiikka
- Ymmärtää lauselogiikan perusmääritelmät ja notaation
- Osaa lukea ja muodostaa totuusatauluja

== Yleisiä loogisia virheitä

- Korrelaatio on kausaatio (implikaatio vs. ekvivalenssi)
- Kehäpäätelmä
- Argumentointivirheet
- TODO

== Logiikka

TODO tarkemmin mitä logiikka on

== Formaali logiikka

#slide(composer: (1fr, auto))[
  - Miten eroaa epäformaalista logiikasta?
    - Mitä tarkoittaa formaali kieli?
  - Nollannen asteen logiikkaa kutsutaan nimellä lauselogiikka
][
  $ (p quad p -> q) / q $
]


== Lauselogiikka

#slide(composer: (1fr, auto))[
  - Totuusarvot
    - Tosi, $top$, $1$
    - Epätosi, $bot$, $0$
  - Atomisilla lauseilla on totuusarvot
    - Lauseita usein merkitään kirjaimilla $p, q, r, s, t$
  - Logiikkaan ei kuulu muuttujia (onko tarpeellista kertoa?)
    - Mutta lauseissa voi esiintyä _metamuuttujia_
][
  $ p -> (q or r -> (r -> not p)) $
]


== Lean

```lean4
import Mathlib

def divides (n m : Nat) : Prop := ∃ k, n * k = m

def prime (n : Nat) : Prop := ∀ m, m < n ∧ m ≠ 1 → divides m n ∧ n < 10

def primes : Set Nat := {n | prime n}

-- TODO implement prime number algorithm

#check ((((((1))))))

def nth_prime : Nat → primes := sorry

-- instance : Decidable (n ∈ primes) := by
--   rw [primes]

-- #eval 10 ∈ primes

def prime_id : primes → Nat := by
  rw [primes]
  intro x
  cases' x with n
  exact n

def countable_primes : Countable primes := by
  use prime_id
  intro a b h
  cases' a with a ah
  cases' b with b bh
  simp [prime_id] at h
  subst b
  rfl

```

== "Judgement"

- Filosofinen väite

== Implikaatio

== Ekvivalenssi

== "Hypothetical Judgement"

- Matematiikan vahvuus on siinä, että väitteiden totuus ei riipu puhujasta tai kuulijasta, vaan oletuksista
  - $arrow$ Tarvitaan judgement jossa esitetään myös oletukset