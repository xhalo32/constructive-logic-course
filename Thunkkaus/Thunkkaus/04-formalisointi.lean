import Mathlib
namespace Formalisointi

def Even (n : Nat) := 2 ∣ n

#check Even 4

theorem sum_even_even (n m : Nat) (hn : Even n) (hm : Even m) : Even (n + m) := by
  rw [Even] at *
  apply Nat.dvd_add
  exact hn
  exact hm

lemma mul_neg_left (a b : ℝ ) (hab : a * b < 0) (ha : a < 0) : b > 0 := by
  rw [neg_iff_pos_of_mul_neg hab] at ha
  exact ha

lemma mul_neg_right (a b : ℝ ) (hab : a * b < 0) (ha : a > 0) : b < 0 := by
  apply pos_iff_neg_of_mul_neg at hab
  rw [← hab]
  exact ha

lemma prod_lt_zero_iff (a b : ℝ)(hab : a * b < 0):(a ≠ 0) ∧ (b ≠ 0):= by
  constructor
  apply ne_of_lt at hab
  exact left_ne_zero_of_mul hab
  apply ne_of_lt at hab
  rw [mul_ne_zero_iff] at hab
  exact hab.2

lemma prod_neg_of_neg_of_pos (a b : ℝ) (ha : a < 0) (hb : b > 0) : a * b < 0 := by
  exact mul_neg_of_neg_of_pos ha hb

theorem mul_neg_iff (a b : ℝ) : a * b < 0 ↔ (a < 0 ∧ b > 0) ∨ (a > 0 ∧ b < 0) := by
  constructor
  intro h
  by_cases ha : a < 0
  left
  constructor
  exact ha
  apply mul_neg_left a
  exact h
  exact ha
  right
  constructor
  simp at ha
  apply prod_lt_zero_iff at h
  cases' h with hna hnb
  apply lt_of_le_of_ne
  exact ha
  exact hna.symm
  push_neg at ha
  have hnez:= prod_lt_zero_iff a b h
  have haltz := lt_of_le_of_ne ha (hnez.1.symm)
  apply mul_neg_right a
  exact h
  exact haltz
  intro h
  cases' h with h h
  exact prod_neg_of_neg_of_pos a b h.1 h.2
  rw [mul_comm]
  exact prod_neg_of_neg_of_pos b a h.2 h.1
