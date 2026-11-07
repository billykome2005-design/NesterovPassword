# ==========================================
# PACKAGE : NesterovPassword
# FICHIER : nesterov.R
# ROLE : Algorithme d'optimisation de Nesterov
# ==========================================

#' Optimiser une fonction avec l'algorithme de Nesterov
#'
#' Applique une méthode de gradient avec anticipation
#' pour minimiser une fonction différentiable.
#'
#' @param f Fonction de coût.
#' @param grad Fonction calculant le gradient.
#' @param x0 Vecteur des coefficients initiaux.
#' @param alpha Taux d'apprentissage.
#' @param beta Paramètre de momentum.
#' @param tol Tolérance de convergence.
#' @param max_iter Nombre maximal d'itérations.
#' @return Liste contenant la solution, le coût,
#' le nombre d'itérations et l'historique.
#' @export

nesterov <- function(f, grad, x0, alpha,
                     beta = 0.9,
                     tol = 1e-6,
                     max_iter = 1000) {

  # Initialiser les coefficients
  x <- x0
  x_prec <- x0

  # Créer l'historique des coûts
  historique <- numeric(max_iter)

  # Boucle principale
  for (k in seq_len(max_iter)) {

    # Calculer le point anticipé
    y_anticipe <- x + beta * (x - x_prec)

    # Calculer le gradient au point anticipé
    g <- grad(y_anticipe)

    # Mettre à jour les coefficients
    x_nouveau <- y_anticipe - alpha * g

    # Enregistrer le coût
    historique[k] <- f(x_nouveau)

    # Vérifier la convergence
    if (sqrt(sum(g^2)) < tol) {
      x <- x_nouveau
      break
    }

    # Préparer l'itération suivante
    x_prec <- x
    x <- x_nouveau
  }

  # Retourner les résultats
  return(list(
    solution = x,
    cout = f(x),
    iterations = k,
    historique = historique[1:k]
  ))
}
