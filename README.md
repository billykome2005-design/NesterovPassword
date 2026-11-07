NesterovPassword

1. Présentation du projet

NesterovPassword est un package R développé dans le cadre d'un projet pédagogique en sciences de données et intelligence artificielle.

Il permet de réaliser une classification binaire des mots de passe en deux catégories :

- 0 : mot de passe faible ;
- 1 : mot de passe fort.

Le modèle utilise la régression logistique et l'algorithme d'optimisation de Nesterov.

2. Objectif

L'objectif est d'étudier l'application de l'algorithme de Nesterov à l'optimisation d'un modèle de classification.

Les données utilisées sont synthétiques et servent uniquement à des fins pédagogiques.

3. Variables utilisées

Le modèle utilise quatre caractéristiques :

- "longueur" : longueur du mot de passe ;
- "majuscule" : présence de lettres majuscules ;
- "chiffre" : présence de chiffres ;
- "special" : présence de caractères spéciaux.

4. Fonctions principales

Le package contient cinq fonctions principales :

- "sigmoide()" : calcule la fonction sigmoïde ;
- "fonction_cout()" : calcule la fonction de coût logistique ;
- "gradient()" : calcule le gradient de la fonction de coût ;
- "nesterov()" : optimise les coefficients avec la méthode de Nesterov ;
- "prediction()" : réalise les prédictions.

5. Installation

Après avoir construit le package, il est possible de l'installer localement avec :

devtools::install()

Puis de le charger avec :

library(NesterovPassword)

6. Exemple d'utilisation

# Calculer la fonction sigmoïde
sigmoide(c(-2, 0, 2))

# Résultat attendu
# 0.1192029 0.5000000 0.8807971

7. Résultats obtenus

Les tests du package ont donné les résultats suivants :

- 8 tests réussis ;
- 0 échec ;
- 0 avertissement ;
- 0 test ignoré.

Sur le jeu de test de 40 observations, le classificateur a obtenu une précision globale de 87,5 %.

8. Conclusion

Le package NesterovPassword montre comment l'algorithme de Nesterov peut être intégré dans un modèle de régression logistique pour effectuer une classification binaire.

Ce projet constitue une application pédagogique de l'optimisation numérique et de la programmation sous R.
