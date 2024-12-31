#!/bin/bash

# Définir les chemins
src="src/"
lib="lib/"
bin="bin"
temp_src="temp_src"

# Créer le répertoire temporaire
mkdir -p "$temp_src"

# Copier tous les fichiers .java dans le répertoire temporaire
find "$src" -name "*.java" -exec cp {} "$temp_src" \;

# Créer une liste des fichiers JAR dans lib/
lib_path=$(echo "$lib"*.jar | tr ' ' ':')

# Compiler les fichiers Java avec les bibliothèques et générer la sortie dans le répertoire bin
javac -cp ".:$lib_path" -g:vars -d "$bin" "$temp_src"/*.java


# Attente pour que l'utilisateur puisse voir les messages
read -p "Press any key to continue..." -n1 -s
