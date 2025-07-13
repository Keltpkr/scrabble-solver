#!/bin/bash

set -e

# ----------------------------------------
# CONFIGURATION
# ----------------------------------------
EXCLUDE_FILE="zip_exclude.txt"
PROJECT_DIR="$(pwd)"
PROJECT_NAME="$(basename "$PROJECT_DIR")"
ARCHIVE_NAME="${PROJECT_NAME}.zip"

# ----------------------------------------
# Vérifier l'existence du fichier d'exclusion
# ----------------------------------------
if [ ! -f "$EXCLUDE_FILE" ]; then
  echo "❌ Erreur : le fichier $EXCLUDE_FILE n'existe pas."
  exit 1
fi

echo "==============================="
echo "📦 Création de l'archive : $ARCHIVE_NAME"
echo "📂 Répertoire source     : $PROJECT_DIR"
echo "📝 Fichier d'exclusion    : $EXCLUDE_FILE"
echo "==============================="
echo

# ----------------------------------------
# Nettoyer éventuels fichiers temporaires
# ----------------------------------------
rm -f .tmp_exclude_clean.txt .tmp_included_list.txt

# ----------------------------------------
# Créer l'archive avec 7z
# -tzip : format zip
# -xr@  : exclusions depuis fichier
# -bb1  : verbosité montrant chaque fichier ajouté
7z a -tzip "$ARCHIVE_NAME" . -xr@"$EXCLUDE_FILE" -bb1

# ----------------------------------------
# Vérifier succès
# ----------------------------------------
if [ $? -eq 0 ]; then
  echo
  echo "✅ Archive créée avec succès : $ARCHIVE_NAME"
else
  echo
  echo "❌ Erreur lors de la création de l'archive."
  exit 1
fi
