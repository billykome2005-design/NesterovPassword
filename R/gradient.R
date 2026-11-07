# ==========================================
# PACKAGE : NesterovPassword
# FICHIER : gradient.R
# ROLE : Calculer le gradient de la fonction de coût
# ==========================================

#' Calculer le gradient de la fonction de coût
#'
#' Calcule les dérivées partielles de la fonction
#' de coût logistique par rapport aux coefficients.
#'
#' @param X Matrice des variables explicatives.
#' @param y Vecteur des classes réelles (0 ou 1).
#' @param w Vecteur des coefficients du modèle.
#' @param lambda Paramètre de régularisation.
#' @return Vecteur contenant les valeurs du gradient.
#' @export

gradient <- function(X, y, w, lambda = 0.01) {

  # Ajouter une colonne de 1 pour le biais
  Xb <- cbind(1, X)

  # Calculer les probabilités prédites
  p <- sigmoide(Xb %*% w)

  # Calculer le gradient de la perte logistique
  g <- as.vector(
    t(Xb) %*% (p - y) / length(y)
  )

  # Ajouter la régularisation sauf au biais
  g[-1] <- g[-1] + lambda * w[-1]

  # Retourner le gradient
  return(g)
}
