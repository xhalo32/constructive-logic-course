import Mathlib

def divides (n m : Nat) : Prop := ∃ k, n * k = m

def prime (n : Nat) : Prop := ∀ m, m < n ∧ m ≠ 1 → divides m n ∧ n < 10

def primes : Set Nat := {n | prime n}

-- TODO implement prime number algorithm

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
