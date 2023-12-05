# Utilise l'image Ubuntu officielle
FROM python:latest

# Définit le répertoire de travail dans le conteneur
WORKDIR /app

# Copie les fichiers de dépendance dans le conteneur
COPY requirements.txt .

# Installe les dépendances
RUN pip3 install --no-cache-dir -r requirements.txt

# Copie le code source dans le conteneur
COPY azure-vote .

# Expose le port que votre application utilise (dans cet exemple, 80)
EXPOSE 80

# Ajoute un healthcheck
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 CMD curl -f http://localhost/ || exit 1

# Commande pour exécuter votre application
CMD ["python3", "main.py"]
