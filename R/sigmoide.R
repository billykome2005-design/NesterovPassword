# ==========================================
# PACKAGE : NesterovPassword
# FICHIER : sigmoide.R
# ROLE : Calculer la fonction sigmoïde
# ==========================================

#' Calculer la fonction sigmoïde
#'
#' Transforme une valeur en une probabilité
#' comprise entre 0 et 1.
#'
#' @param z Valeur numérique ou vecteur de valeurs.
#' @return Une probabilité comprise entre 0 et 1.
#' @export

sigmoide <- function(z) {

  # Limiter les valeurs pour éviter les débordements
  z <- pmax(pmin(z, 35), -35)

  # Calculer la fonction sigmoïde
  return(1 / (1 + exp(-z)))
}
