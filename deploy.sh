#!/bin/bash

# Définir les chemins
webapp="/opt/tomcat/webapps"
name="pharmacie"
web_dir="web"
bin_dir="bin"
war_file="$name.war"

# Copier les fichiers .class dans le répertoire approprié
cp -r "$bin_dir/"* "$web_dir/WEB-INF/classes/"

# Se déplacer dans le répertoire web
cd "$web_dir"

# Créer le fichier WAR
jar -cvf "$war_file" .

# Supprimer l'ancien fichier WAR et son fichier .deployed
rm -f "$webapp/$war_file"
rm -f "$webapp/$war_file.deployed"

# Copier le nouveau fichier WAR dans le répertoire webapps de Tomcat
cp "$war_file" "$webapp/"

# Supprimer le fichier WAR local après copie
rm -f "$war_file"

# Revenir au répertoire précédent
cd ..

# Pause pour laisser le temps de vérifier le script (optionnel)
read -p "Press any key to continue..." -n1 -s
