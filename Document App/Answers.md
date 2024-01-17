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

# Ajout de la navigation
# Exercice 1:
Le rôle du NavigationController est de permet de gérer la navigation entre différentes interfaces utilisateur
La NavigationBar est un composant visuel spécifique qui fait partie de l'interface utilisateur d'une vue contrôlée par un UINavigationController. Le NavigationController, en revanche, est un contrôleur de vue qui gère la navigation entre différentes vues dans l'application, il peut être associé à une NavigationBar pour faciliter la navigation.

# Créer l’écran de détail
# Exercice 1:
Le segue définit une transition entre de vue controlleurs dans notre storyboard

# Exercice 2:
Les contraintes pousse les composants à rester dans un certain cadre de style. L'autolayout permet aux composants de s'adapter à son contenant.


# QLPreviewController
# Exercice 1:
Il est préférable d'utiliser un "disclosureIndicator" pour nos cellules car il plus intuitif pour l'utilisateur que d'appuyer sur la ligne. Cela améliore et surtout rend plus agréable l'expérience utilisateur lors de l'utilisation de l'application.

# Exercice 2:
Certain APIs en Objective-C, tels que target-action, acceptent des noms de méthodes ou de propriétés en tant que paramètres, puis utilisent ces noms pour appeler ou accéder dynamiquement aux méthodes ou propriétés. En Swift, vous utilisez les expressions #selector pour représenter ces noms de méthodes ou de propriétés en tant que sélecteurs ou chemins de clés, respectivement.
Le .add représente l'icon +, qui nous permettra d'ajouter un fichier.
XCode nous demande de mettre le mot clé "@objc" devant la fonction ciblée par le #selector car cela permet au selector de comprendre que cela fait appel à une ancienne fonction en Objectif-C.
