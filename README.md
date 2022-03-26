# Documentation
## Développeur: Charaf-Dine Junior A. AÏBOUKI, A. J. Prince Le Bon HOUNDJO

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
<details><summary>1</summary>
  
  ![](/musee_m1irt/assets/1.jpg)
  
</details>

<details><summary>2</summary>
  
![](/musee_m1irt/assets/2.jpg)

</details>

<details><summary>3</summary>

  ![](/musee_m1irt/assets/3.jpg)

</details>

<details><summary>4</summary>

  ![](/musee_m1irt/assets/4.jpg)

</details>

<details><summary>5</summary>

  ![](/musee_m1irt/assets/5.jpg)

</details>

<details><summary>6</summary>

  ![](/musee_m1irt/assets/6.jpg)

</details>

<details><summary>7</summary>

  ![](/musee_m1irt/assets/7.jpg)

</details>

<details><summary>8</summary>

  ![](/musee_m1irt/assets/8.jpg)

</details>

<details><summary>9</summary>

  ![](/musee_m1irt/assets/9.jpg)

</details>

<details><summary>10</summary>

  ![](/musee_m1irt/assets/10.jpg)

</details>

<details><summary>11</summary>

  ![](/musee_m1irt/assets/11.jpg)

</details>

<details><summary>12</summary>

  ![](/musee_m1irt/assets/12.jpg)

</details>

- Nous avons égalements une snackbar qui s'affiche lorsqu'on réalise une action:

<details><summary>13</summary>

  ![](/musee_m1irt/assets/13.jpg)

</details>

<details><summary>14</summary>

  ![](/musee_m1irt/assets/14.jpg)

</details>

<details><summary>15</summary>

  ![](/musee_m1irt/assets/15.jpg)

</details>

<details><summary>16</summary>

  ![](/musee_m1irt/assets/16.jpg)

</details>


- Nous pouvons remarquer que les différentes actions sont facilements accessibles.
Pour l'ajout il suffit de taper sur le boutton **+**, pour la modifiaction taper sur **l'icone verte** pour modifier l'élément et pour la suppression il suffit de taper sur **l'icone rouge** de suppression.

- La navigation entre les diiférentes vues se fait grace à la NavigationBottomBar (Barre de navigation inférieure)


## Eléments importants
- > Nous pouvons remarquer que certaines tables sont en relations avec d'autres, donc certains enregistrements sont liés entre eux. Par exemple un enregistrement de la table Musée est relié à un enregistrement de la table Pays. La table Pays est donc une table parent et la table musée est la table enfant. Il a été coonvenu au cours du développement que tout action sur la table parent affecterait celle enfant. Donc la modifiaction ou la suppression d'un élément de la table parent entrainera la meme action chez l'enregistrement de la table enfant auquel il est relié.
- > Tous les éléments de la base de données ne sont pas automatiquement chargés au début de l'application, c'est-à-dire que c'est uniquement lorsque vous venez sur une vue que les éléments appartement à cette vue sont chargés depuis la base la base de données (la liste des musées n'est chargée que si vous allez sur la vue correspondante et ainsi de suite). Il est bon de le savoir car si vous désirez ajouter un enregistrement qui est en relation avec une autre table, pour que les enregistrements de la table parent soient disponibles il faut au préalable aller sur la vue de la table parent pour charger les informations avant de venir sur la vue de la table enfant avant de faire l'action souhaité (lecture, ajout ou modification).


## Exemples:
- Dans l'exemple ci-dessous nous avons des exemples d'ajout, de modification et de suppression:

  > https://user-images.githubusercontent.com/102158487/159924829-bca078d6-a586-4600-a8ce-0149a1727e76.mp4

- Dans l'exemple ci-dessous nous avons l'enregistrement de la table Bibliothèque qui est relié à un enregistrement de la table Ouvrage qui à son tour est relié à un enregistrement de la table Pays. Lorsqu'on supprime l'enregistrement de la table Pays, celui de la table Ouvrage est supprimé à son tour et entraine aussi la suppression de celle de la table Bibliothèque:

  > https://user-images.githubusercontent.com/102158487/159924521-7bb5c09c-4b42-407c-a943-296196a9e71c.mp4

- Dans l'expemple ci-dessous nous voulons modifier un musée mais le champs CodePays ne fonctionnait pas, du coup on va recharger la liste des pays en allant sur la vue correspondante et nous revenons faire la modification. Meme chose pour l'ajout d'un nouvel enregistrement dans la table Bibliothèque, le champ ISBN correspondant à la table Ouvrage n'est pas disponible donc il faut la charger avant de faire l'enregistrement: voila

  > https://user-images.githubusercontent.com/102158487/159924114-ae50d992-dc39-409e-ac67-4acfd5ccfde9.mp4

