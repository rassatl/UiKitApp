# Environnement de développement
# Exercice 1:

## Targets:
Dans Xcode, un "target" représente un ensemble d'instructions sur la manière de compiler un ensemble spécifique de fichiers source pour créer un produit exécutable ou une bibliothèque. Chaque application iOS a au moins un target, qui correspond généralement à l'application elle-même, mais il est également possible d'avoir plusieurs targets pour générer des versions différentes de l'application.

## Fichiers de base :
Les fichiers de base inclus par défaut lors de la création d'un projet iOS comprennent des fichiers tels que AppDelegate.swift, SceneDelegate.swift, et le fichier ViewController.swift. Ces fichiers sont essentiels à la structure de base de l'application. AppDelegate gère le cycle de vie de l'application, SceneDelegate est responsable de la gestion des fenêtres et des scènes, tandis que ViewController est associé à l'interface utilisateur principale de l'application.

## Dossier Assets.xcassets :
Le dossier Assets.xcassets est un répertoire centralisé pour gérer les ressources graphiques de l'application, telles que les images et les icônes. Il permet d'organiser visuellement les ressources par catégories et de fournir des adaptations automatiques pour différentes tailles et résolutions d'écrans.

## Storyboard :
Le storyboard est un fichier visuel dans Xcode qui permet de concevoir l'interface utilisateur d'une application iOS en utilisant une interface graphique plutôt qu'un code. On peut y ajouter des vues, des contrôleurs de vue et établir des connexions entre eux pour définir la navigation et le flux de l'application. Le storyboard facilite la conception et la visualisation de l'interface utilisateur sans avoir à écrire beaucoup de code.

## Simulateur :
Le simulateur iOS dans Xcode est un environnement virtuel qui permet de tester et d'exécuter des applications iOS directement sur l'ordinateur, sans nécessiter un appareil physique. Il offre différentes configurations d'appareils (iPhone, iPad) et de versions iOS pour tester l'application dans divers scénarios.

# Exercice 2:

## Cmd + R :
Le raccourci Cmd + R est utilisé pour exécuter le projet en cours dans le simulateur iOS. Cela compile le code, construit l'application et la lance sur le simulateur, permettant ainsi aux développeurs de voir et de tester leur application en action.

## Cmd + Shift + O :
Le raccourci Cmd + Shift + O ouvre la fonction de recherche rapide dans Xcode. Il permet de rechercher rapidement des fichiers dans le projet, facilitant ainsi la navigation et l'accès aux différents éléments du code.

## Raccourci pour indenter le code automatiquement :
Le raccourci pour indenter le code automatiquement dans Xcode est Cmd + A (sélection de tout le code) suivi de Ctrl + I. Cela aligne correctement le code en fonction de la structure logique, améliorant la lisibilité.

## Raccourci pour commenter la sélection :
Le raccourci pour commenter la sélection dans Xcode est Cmd + /. En sélectionnant une partie du code et en utilisant ce raccourci, on peut ajouter ou supprimer rapidement les commentaires, facilitant ainsi la documentation du code.

# Délégation
# Exercice 1:
L'intérêt d'une propriété statique en programmation est qu'elle est unique à la classe. S'il y à modification de cette propriété dans le programme, elle sera répercuté dans toute l'application.

# Exercice 2:
La méthode dequeueReusableCell est importante pour les performances des applications parce qu'elle permet de réutiliser les cellules d'une table view ou d'une collection view au lieu de créer une nouvelle cellule chaque fois qu'une nouvelle ligne doit être affichée.
