# ==========================================
# PACKAGE : NesterovPassword
# FICHIER : fonction_cout.R
# ROLE : Calculer la fonction de coût logistique
# ==========================================

#' Calculer la fonction de coût logistique
#'
#' Mesure l'erreur du modèle de classification
#' avec une pénalisation des coefficients.
#'
#' @param X Matrice des variables explicatives.
#' @param y Vecteur des classes réelles (0 ou 1).
#' @param w Vecteur des coefficients du modèle.
#' @param lambda Paramètre de régularisation.
#' @return Valeur numérique du coût.
#' @export

fonction_cout <- function(X, y, w, lambda = 0.01) {

  # Ajouter une colonne de 1 pour le biais
  Xb <- cbind(1, X)

  # Calculer les probabilités prédites
  p <- sigmoide(Xb %*% w)

  # Eviter le logarithme de zéro
  p <- pmax(pmin(p, 1 - 1e-15), 1e-15)

  # Calculer la perte logistique
  perte <- -mean(y * log(p) + (1 - y) * log(1 - p))

  # Calculer la pénalité sans régulariser le biais
  penalite <- (lambda / 2) * sum(w[-1]^2)

  # Retourner le coût total
  return(perte + penalite)
}
