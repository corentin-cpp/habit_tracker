<div align="center"> <h1><b>Habit Tracker</b></h1>

<p>Application IOS/Android qui permet de suivre ses habitudes !</p>

<p> <a href="https://github.com/corentin-cpp/habit_tracker/blob/main/LICENSE"> <img alt="Licence" src="https://img.shields.io/github/license/corentin-cpp/habit_tracker?style=for-the-badge&color=blue"> </a> <a href="https://github.com/corentin-cpp/habit_tracker/issues"> <img alt="Issues" src="https://img.shields.io/github/issues/corentin-cpp/habit_tracker?style=for-the-badge&color=yellow"> </a> <a href="https://github.com/corentin-cpp/habit_tracker/stargazers"> <img alt="Stars" src="https://img.shields.io/github/stars/corentin-cpp/habit_tracker?style=for-the-badge&color=orange"> </a> </p> </div>

📋 Table des Matières

- Aperçu
- Fonctionnalités
- Démarrage Rapide
- Structure du Projet
- Contribuer
- Licence
- Contact

## 🌟 Aperçu (Overview)

Habit Tracker est une application mobile multiplateforme (iOS & Android) développée en Flutter pour aider les utilisateurs à créer, suivre et maintenir leurs habitudes quotidiennes. Elle résout le problème du manque de régularité en offrant un suivi simple, des rappels push (via Firebase Messaging) et une synchronisation/sauvegarde des données avec Supabase. Habit Tracker s'adresse à toute personne souhaitant améliorer sa productivité, sa santé ou ses routines personnelles grâce à un suivi clair et motivant.

## ✨ Fonctionnalités

- Créer et organiser des habitudes : ajouter des habitudes récurrentes avec fréquence, heure cible et catégories.
- Suivi quotidien : marquer les habitudes comme réalisées, voir l'historique et la progression dans le temps.
- Rappels & notifications : notifications push et rappels locaux via Firebase Messaging et flutter_local_notifications pour ne rien oublier.
- Statistiques et tendances : visualisation simple des séries, taux de réussite et streaks pour rester motivé.
- Synchronisation cloud : authentification et stockage des données utilisateur avec Supabase (Postgres) pour garder les données sauvegardées et synchronisées entre appareils.

Fonctionnalité 1 : Gestion des habitudes

Permet de créer, éditer et supprimer des habitudes, définir la fréquence (quotidienne, hebdomadaire, personnalisée), l'heure de rappel, et ajouter des notes ou catégories pour mieux organiser son suivi.

Fonctionnalité 2 : Rappels et notifications

Envoi de notifications push via Firebase Messaging pour rappeler à l'utilisateur de compléter ses habitudes. Les rappels peuvent être configurés par habitude et pris en charge sur iOS et Android.

Fonctionnalité 3 : Statistiques & Historique

Affiche des graphiques simples et des métriques (streaks, taux de complétion) pour suivre la progression sur différentes périodes et encourager la constance.

## 🚀 Démarrage Rapide (Quick Start)

Voici comment installer et exécuter le projet localement.

### Prérequis
Assurez-vous d'avoir les outils suivants installés sur votre machine :

- Flutter (version stable recommandée, ex. >= 3.0)
- Git
- Android Studio (ou Visual Studio Code) + Android SDK pour Android
- Xcode (pour build/émulation iOS sur macOS)
- CocoaPods (pour iOS) : gem install cocoapods
- Un compte Supabase (pour la base et l'authentification)
- Un projet Firebase configuré pour utiliser Firebase Cloud Messaging (FCM)

### Installation
Clonez le dépôt :

```bash
git clone https://github.com/corentin-cpp/habit_tracker.git
cd habit_tracker
```

Installez les dépendances :

```bash
flutter pub get
```

(Optionnel) Configurations :

- Placez votre `google-services.json` (Android) et `GoogleService-Info.plist` (iOS) dans les dossiers natifs appropriés si vous utilisez Firebase.
- Créez un fichier de configuration (par ex. `.env` ou `lib/firebase_options.dart`) contenant les clés Supabase et d'autres secrets (ne pas committer ces secrets dans le dépôt public).

### Lancement
Pour démarrer l'application en mode développement :

```bash
flutter run
```

ou pour lancer sur un appareil spécifique :

```bash
flutter run -d <device_id>
```

### Tests
Pour exécuter la suite de tests unitaires :

```bash
flutter test
```

## 📁 Structure du Projet

Voici un aperçu rapide des dossiers et fichiers importants :

- `lib/` : code Dart principal (pages, widgets, services, models)
- `lib/main.dart` : point d'entrée de l'application
- `android/` : configuration et code natif Android
- `ios/` : configuration et code natif iOS
- `pubspec.yaml` : dépendances et métadonnées du projet
- `firebase_options.dart` : (généré / managé) options Firebase

## 🤝 Comment Contribuer

Nous accueillons les contributions avec plaisir ! Pour contribuer :

1. Forkez le projet.
2. Créez une nouvelle branche : `git checkout -b feature/ma-super-feature`.
3. Faites vos modifications et commitez : `git commit -m "Ajout de ma-super-feature"`.
4. Pushez votre branche : `git push origin feature/ma-super-feature`.
5. Ouvrez une Pull Request sur le dépôt principal.

Merci de lire les conventions de code (si présentes) et d'ajouter des tests pour les nouvelles fonctionnalités quand c'est possible.

## 📝 Licence

Ce projet est sous licence MIT. Voir le fichier `LICENSE` pour plus de détails.

## 📬 Contact

Corentin HOFFMANN - @corentin-cpp - corentinhoffmann@outlook.com

URL du dépôt : https://github.com/corentin-cpp/habit_tracker

---

Merci d'utiliser Habit Tracker ! Si tu souhaites des améliorations spécifiques (ex : intégration de thèmes sombres, widgets iOS, export CSV), dis‑le et je peux proposer une PR ou un plan d'implémentation.
