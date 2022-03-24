# Documentation

## Description

Cette application est une application de gestion de musée à travers six tables prédéfinies qui sont:
- Pays(codePays, nbhabitant)
- Musee (numMus, nomMus, nblivres, codePays#)
- Visiter (numMus#, jour#, nbvisiteurs)
- Moment (jour)
- Ouvrage (ISBN, nbPage, titre, codePays#)
- Bibliotheque (numMus#, ISBN#, dateAchat)
et grace à une base de donnée locale SQLite.

La gestion se fait grace aux actions qui sont: **l'ajout, la modification, la lecture et la suppression des différents enregistrements**.

## Interfaces

- Les différents interfaces sont les suivantes:

![](/musee_m1irt/assets/1.jpg) ![](/musee_m1irt/assets/2.jpg) ![](/musee_m1irt/assets/3.jpg) ![](/musee_m1irt/assets/4.jpg) ![](/musee_m1irt/assets/5.jpg) ![](/musee_m1irt/assets/6.jpg) ![](/musee_m1irt/assets/7.jpg) ![](/musee_m1irt/assets/8.jpg) ![](/musee_m1irt/assets/9.jpg) ![](/musee_m1irt/assets/10.jpg) ![](/musee_m1irt/assets/11.jpg) ![](/musee_m1irt/assets/12.jpg)



- Nous avons égalements des pop-up qui s'affichent lorsqu'on réalise une action:

![](/musee_m1irt/assets/13.jpg)
![](/musee_m1irt/assets/14.jpg)
![](/musee_m1irt/assets/15.jpg)
![](/musee_m1irt/assets/16.jpg)


- Nous pouvons remarquer que les différentes actions sont facilements accessibles.
Pour l'ajout il suffit de taper sur le boutton **+**, pour la modifiaction taper sur **l'icone verte** pour modifier l'élément et pour la suppression il suffit de taper sur **l'icone rouge** de suppression.

- La navigation entre les diiférentes vues se fait grace à la NavigationBottomBar (Barre de navigation inférieure)


## Eléments importants
- > Nous pouvons remarquer que certaines tables sont en relations avec d'autres, donc certains enregistrements sont liés entre eux. Par exemple un enregistrement de la table Musée est relié à un enregistrement de la table Pays. La table Pays est donc une table parent et la table musée est la table enfant. Il a été coonvenu au cours du développement que tout action sur la table parent affecterait celle enfant. Donc la modifiaction ou la suppression d'un élément de la table parent entrainera la meme action chez l'enregistrement de la table enfant auquel il est relié.
- > Tous les éléments de la base de données ne sont pas automatiquement chargés au début de l'application, c'est-à-dire que c'est uniquement lorsque vous venez sur une vue que les éléments appartement à cette vue sont chargés depuis la base la base de données (la liste des musées n'est chargée que si vous allez sur la vue correspondante et ainsi de suite). Il est bon de le savoir car si vous désirez ajouter un enregistrement qui est en relation avec une autre table, pour que l![3](https://user-images.githubusercontent.com/102158487/159920314-74e76e60-fee9-4935-bcf2-970cb2241dbe.jpg)
es enregistrements de la table parent soient disponibles il faut au préalable aller sur la vue de la table parent pour charger les informations avant de venir sur la vue de la table enfant avant de faire l'action souhaité (lecture, ajout ou modification).

