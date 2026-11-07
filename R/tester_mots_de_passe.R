#' Tester un ou plusieurs mots de passe
#'
#' Classe les mots de passe en faibles ou forts
#' avec le modele de regression logistique optimise
#' par une methode de type Nesterov.
#'
#' @param mots_de_passe Vecteur de mots de passe a tester.
#' @param seuil Seuil de classification (0.5 par defaut).
#' @return Un tableau contenant les probabilites et classifications.
#' @export

tester_mots_de_passe <- function(mots_de_passe, seuil = 0.5) {

  # Parametres du modele entraines
  w <- c(
    1.0324267,
    1.6178177,
    0.6740966,
    0.7739071,
    1.1181882
  )

  moyennes <- c(
    12.28750,
    0.50625,
    0.50000,
    0.48750
  )

  ecarts_types <- c(
    4.5974938,
    0.5015307,
    0.5015699,
    0.5014131
  )

  # Verifier les entrees
  if (!is.character(mots_de_passe) ||
      length(mots_de_passe) == 0 ||
      anyNA(mots_de_passe) ||
      any(mots_de_passe == "")) {
    stop("Fournir des mots de passe non vides.")
  }

  # Verifier le seuil
  if (length(seuil) != 1 || is.na(seuil) ||
      seuil < 0 || seuil > 1) {
    stop("Le seuil doit etre compris entre 0 et 1.")
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

  # Normaliser les donnees
  X_norm <- scale(
    X,
    center = moyennes,
    scale = ecarts_types
  )

  # Calculer les probabilites
  probabilites <- predire_prob(X_norm, w)

  # Determiner les classifications
  classification <- ifelse(
    probabilites >= seuil,
    "FORT",
    "FAIBLE"
  )

  # Construire le resultat
  data.frame(
    mot_de_passe = mots_de_passe,
    probabilite = round(probabilites * 100, 2),
    classification = classification
  )
}
