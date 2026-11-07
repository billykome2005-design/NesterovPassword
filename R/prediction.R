# ==========================================
# PACKAGE : NesterovPassword
# FICHIER : prediction.R
# ROLE : Effectuer les prédictions
# ==========================================

#' Prédire la classe d'une observation
#'
#' Calcule les probabilités et prédit la classe
#' faible (0) ou forte (1).
#'
#' @param X Matrice des variables explicatives.
#' @param w Coefficients optimisés du modèle.
#' @param seuil Seuil de classification.
#' @return Liste contenant les probabilités et les classes prédites.
#' @export

prediction <- function(X, w, seuil = 0.5) {

  # Ajouter la colonne du biais
  Xb <- cbind(1, X)

  # Calculer les probabilités
  probabilites <- as.vector(
    sigmoide(Xb %*% w)
  )

  # Déterminer les classes prédites
  classes <- ifelse(probabilites >= seuil, 1, 0)

  # Retourner les résultats
  return(list(
    probabilites = probabilites,
    classes = classes
  ))
}
#' Calculer les probabilites des mots de passe
#'
#' @param X Matrice des variables explicatives normalisees.
#' @param w Coefficients optimises du modele.
#' @return Vecteur de probabilites.
#' @export
predire_prob <- function(X, w) {

  # Ajouter la colonne du biais
  Xb <- cbind(1, X)

  # Calculer les probabilites
  probabilites <- sigmoide(Xb %*% w)

  return(as.vector(probabilites))
}
