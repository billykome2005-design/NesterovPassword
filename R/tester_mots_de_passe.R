#' Tester plusieurs mots de passe
#'
#' Classe plusieurs mots de passe en faibles ou forts
#' a partir d'un modele de regression logistique optimise
#' par une methode de type Nesterov.
#'
#' @param mots_de_passe Vecteur de mots de passe a tester.
#' @param w Coefficients appris par le modele.
#' @param moyennes Moyennes utilisees pour la normalisation.
#' @param ecarts_types Ecarts-types utilises pour la normalisation.
#' @param seuil Seuil de classification (0.5 par defaut).
#'
#' @return Un tableau contenant les mots de passe,
#' leurs probabilites et leur classification.
#' @export
tester_mots_de_passe <- function(
    mots_de_passe,
    w,
    moyennes,
    ecarts_types,
    seuil = 0.5
) {

  # Verifier les entrees
  if (!is.character(mots_de_passe) ||
      length(mots_de_passe) == 0 ||
      anyNA(mots_de_passe) ||
      any(mots_de_passe == "")) {
    stop("Fournir des mots de passe non vides.")
  }

  if (length(w) != 5 ||
      length(moyennes) != 4 ||
      length(ecarts_types) != 4 ||
      any(ecarts_types <= 0)) {
    stop("Les parametres du modele sont invalides.")
  }

  # Extraire les caracteristiques
  extraire <- function(mdp) {
    c(
      longueur = nchar(mdp),
      majuscule = as.integer(grepl("[A-Z]", mdp)),
      chiffre = as.integer(grepl("[0-9]", mdp)),
      special = as.integer(grepl("[^A-Za-z0-9]", mdp))
    )
  }

  X <- t(vapply(
    mots_de_passe,
    extraire,
    numeric(4)
  ))

  # Normaliser avec les parametres d'entrainement
  X_norm <- scale(
    X,
    center = moyennes,
    scale = ecarts_types
  )

  # Calculer les probabilites
  probabilites <- NesterovPassword::predire_prob(X_norm, w)

  # Determiner les classes
  classification <- ifelse(
    probabilites >= seuil,
    "FORT",
    "FAIBLE"
  )

  # Construire le tableau final
  data.frame(
    mot_de_passe = mots_de_passe,
    probabilite = round(probabilites * 100, 2),
    classification = classification
  )
}
