# ==========================================
# TESTS DU PACKAGE : NesterovPassword
# FICHIER : test-fonctions.R
# ROLE : Vérifier le bon fonctionnement des fonctions
# ==========================================

# Test 1 : Vérifier la fonction sigmoïde
test_that("La fonction sigmoide fonctionne correctement", {

  # Vérifier que sigmoide(0) donne 0.5
  expect_equal(sigmoide(0), 0.5)

  # Vérifier que les résultats sont entre 0 et 1
  expect_true(all(sigmoide(c(-2, 0, 2)) >= 0))
  expect_true(all(sigmoide(c(-2, 0, 2)) <= 1))
})


# Test 2 : Vérifier la fonction de coût
test_that("La fonction de coût fonctionne correctement", {

  # Créer une petite matrice de test
  X <- matrix(c(1, 2, 3, 4), ncol = 2)

  # Définir les classes réelles
  y <- c(0, 1)

  # Définir les coefficients
  w <- c(0, 0, 0)

  # Vérifier que le coût initial vaut environ 0.6931
  expect_equal(fonction_cout(X, y, w), 0.6931472,
               tolerance = 1e-6)
})


# Test 3 : Vérifier le gradient
test_that("La fonction gradient fonctionne correctement", {

  # Créer les données de test
  X <- matrix(c(1, 2, 3, 4), ncol = 2)
  y <- c(0, 1)
  w <- c(0, 0, 0)

  # Calculer le gradient
  resultat <- gradient(X, y, w)

  # Vérifier que le gradient contient trois valeurs
  expect_length(resultat, 3)

  # Vérifier les valeurs attendues
  expect_equal(resultat, c(0, -0.25, -0.25))
})


# Test 4 : Vérifier l'algorithme de Nesterov
test_that("L'algorithme de Nesterov converge correctement", {

  # Définir une fonction quadratique
  f <- function(x) sum(x^2)

  # Définir son gradient
  grad <- function(x) 2 * x

  # Définir le point de départ
  x0 <- c(5, -3)

  # Appliquer l'algorithme
  resultat <- nesterov(f, grad, x0, alpha = 0.1)

  # Vérifier que la solution est proche de zéro
  expect_equal(resultat$solution, c(0, 0),
               tolerance = 1e-5)

  # Vérifier que le coût est proche de zéro
  expect_lt(resultat$cout, 1e-8)
})
