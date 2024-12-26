#!/bin/bash

afficher_aide() {
    echo "Utilisation : $0 [chemin_fichier] [type_station] [type_consommateur] [identifiant_centrale] [-h]"
    echo
    echo "Description :"
    echo "  Script pour traiter les données des stations électriques à partir d'un fichier CSV."
    echo
    echo "Paramètres :"
    echo "  chemin_fichier         Chemin vers le fichier CSV contenant les données. (obligatoire)"
    echo "  type_station           Type de station à traiter :"
    echo "                         - hvb : high-voltage B"
    echo "                         - hva : high-voltage A"
    echo "                         - lv  : low-voltage"
    echo "                         (obligatoire)"
    echo "  type_consommateur      Type de consommateur à traiter :"
    echo "                         - comp  : entreprises"
    echo "                         - indiv : particuliers"
    echo "                         - all   : tous"
    echo "                         (obligatoire)"
    echo "                         ATTENTION : Les combinaisons suivantes sont interdites :"
    echo "                         hvb all, hvb indiv, hva all, hva indiv"
    echo "  identifiant_centrale   Identifiant de la centrale spécifique (optionnel)."
    echo "                         Si non spécifié, les traitements s'appliqueront à toutes les centrales."
    echo "  -h                     Affiche cette aide et ignore tous les autres paramètres. (optionnel)"
    echo
    echo "Exemple :"
    echo "  $0 data.csv hvb comp 12345"
    echo
    echo "Fonctionnalités supplémentaires :"
    echo "  - Vérifie la présence du programme C et le compile si nécessaire."
    echo "  - Création automatique des dossiers 'tmp' et 'graphs' si absents."
    echo "  - Nettoyage du dossier 'tmp' avant chaque traitement."
    echo "  - Affiche la durée du traitement des données à la fin de l'exécution."
    echo
    
}

#VERIF ARGUMENTS

if [ $# -eq 0 ]; then
    echo "Veuillez entrer des arguments"
    afficher_aide
    exit 1
fi

#option aide si demandé
for agr in $@; do
if [ $arg -eq "-h" ]; then
    afficher_aide
    exit 0
fi
done

#verif fichier csv 



if[ !-z $1 ]; then 
    echo "Veuillez entrer le fichier csv"
    afficher_aide
    exit 1
fi

csv=$1

if [ !-f $csv ]; then 
    echo "Veuillez entrer un fichier"
    afficher_aide
    exit 1
fi

if [ !-r $csv ]; then 
    echo "Le fichier doit pouvoir être lu"
    afficher_aide
    exit 1
fi

#verif type de station

if [ !-z $2 ]; then 
    echo "Veuillez entrer le type de station"
    afficher_aide
    exit 1
fi

station=$2

if [ $station -ne "hva" ] && [ $station -ne "hvb" ] && [ $station -ne "lv" ]; then 
    echo "Veuillez entrer un type de station valide"
    afficher_aide
    exit 1
fi

#verif type de consommateur

if [ !-z $3 ]; then 
    echo "Veuillez entrer le type de consommateur"
    afficher_aide
    exit 1
fi

conso=$3

if [ $conso != "comp" ] && [ $conso != "indiv" ] && [ $conso != "all" ]; then 
    echo "Veuillez entrer un type de consommateur valide"
    afficher_aide
    exit 1
elif [ [ $station == "hva" ] || [ $station == "hvb" ] ] && [ [ $conso == "all" ] || [ $conso == "indiv"] ]; then
    echo "Type de consommateur invalide pour ce type de station"
    afficher_aide
    exit 1
fi







 
 


fichier=$1
station=$2
conso=$3




