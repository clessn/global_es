# Nomenclature pour coder

Avant de commencer, il est important de comprendre qu'une variable peut être comparée à une phrase. Chaque mot qui la compose joue un rôle précis et contribue à son sens global. Toutefois, tous les mots n'ont pas le même poids dans cette construction : certains définissent la catégorie générale de la variable, d'autres précisent son contenu, et d'autres encore indiquent le type de transformation appliquée lors du nettoyage (cleaning). Nous verrons comment ces éléments interagissent et pourquoi il est essentiel de bien structurer le nom des variables pour assurer une cohérence.

## Structure d'une variable

-   **Premier mot** : Catégorie principale de la variable, indiquant son domaine d'application.

    -   **ses\_** : Variables socio-économiques

    -   **dv\_** : Variables dépendantes (dependent variable)

    -   **lifestyle\_** : Habitudes de vie

    -   **issue\_** : Enjeux politiques et sociaux

    -   **values\_** : Valeurs et perceptions

-   **Deuxième mot** : Description de la variable, en minuscules avec un underscore pour séparer la catégorie principale de sa description.

    -   Exemples : `ses_gender` et `lifestyle_exercise`

-   **Troisième mot** : Distinction apportée par une majuscule sans underscore entre le deuxième et le troisième mot (*camel case*). Cette distinction permet de mettre l'emphase sur le fait que la différence entre « gender » et « Female » est plus petite qu'entre « ses » et « gender ».

    -   Exemples : `ses_genderFemale` et `lifestyle_goFishing`.

-   **Quatrième mot** : Finalement, le dernier mot est séparé du troisième par un underscore. Il indique le type de transformation appliqué à la variable lors du nettoyage.

    -   \_bin : Pour une variable binaire (0/1)

    -   \_factor : Pour une variable factorisée

    -   \_cat : Pour une variable catégorielle

    -   \_numeric : Pour une variable numérique

    -   Exemple : `ses_genderFemale_bin` et `lifestyle_goFishingFreq_numeric`

## Structure d'un dataframe

Il est important de nommer chaque dataframe en utilisant une lettre majuscule pour la première lettre. Cela permet d'identifier facilement la différence entre une variable et un dataframe.

-   Exemple : `Data_covid`

## Utilisation de \"pro\" et \"reduce\"

Dans certains cas, il est important d'ajouter un mot pour expliciter la direction d'une opinion ou d'une action représentée par la variable.

Par exemple :

**pro** : Indique une attitude favorable envers une question ou une mesure. Par exemple, `issue_proGunControl` désigne un soutien au contrôle des armes.

**reduce** : Désigne une préférence pour la réduction d'un phénomène ou d'un indicateur, comme `issue_reduceDeficit`, qui exprime le désir de diminuer le déficit économique.

Ainsi, l'utilisation de « pro » et « reduce » ici permet d'assurer une interprétation claire et uniforme du sens des variables.

## Procédure pour nettoyer

Pour illustrer la procédure de nettoyage, nous utiliserons l'exemple de la variable activity_1, qui représente la fréquence de la pêche.

1.  Vérification et conversion des données

    ``` r
    attributes(DataRaw$activity_1)
    table(DataRaw$activity_1)
    ```

    Ensuite, nous la convertissons en format numérique si nécessaire.

    ``` r
    DataRaw$activity_1 <- as.numeric(DataRaw$activity_1)
    ```

2.  Création de la variable principale

    ``` r
    DataClean$lifestyle_goFishingFreq <- NA
    DataClean$lifestyle_goFishingFreq[DataRaw$activity_1 == 1] <- 1
    DataClean$lifestyle_goFishingFreq[DataRaw$activity_1 == 2] <- 2
    DataClean$lifestyle_goFishingFreq[DataRaw$activity_1 == 3] <- 3
    DataClean$lifestyle_goFishingFreq[DataRaw$activity_1 == 4] <- 4
    DataClean$lifestyle_goFishingFreq[DataRaw$activity_1 == 5] <- 5
    table(DataClean$lifestyle_goFishingFreq)
    ```

3.  Transformer en facteur

    Les valeurs numériques peuvent être transformées en catégories ordonnées pour faciliter l'interprétation.

    ``` r
    DataClean$lifestyle_goFishingFreq_factor <- NA
    DataClean$lifestyle_goFishingFreq_factor[DataRaw$activity_1 == 1] <- "never"
    DataClean$lifestyle_goFishingFreq_factor[DataRaw$activity_1 == 2] <- "almost_never"
    DataClean$lifestyle_goFishingFreq_factor[DataRaw$activity_1 == 3] <- "sometimes"
    DataClean$lifestyle_goFishingFreq_factor[DataRaw$activity_1 == 4] <- "often"
    DataClean$lifestyle_goFishingFreq_factor[DataRaw$activity_1 == 5] <- "very_often"
    DataClean$lifestyle_goFishingFreq_factor <- factor(DataClean$lifestyle_goFishingFreq_factor,
                                                       levels = c("never", "almost_never", "sometimes", "often", "very_often"),
                                                       ordered = TRUE)
    table(DataClean$lifestyle_goFishingFreq_factor)
    ```

4.  Conversion en valeurs numériques

    Pour les analyses statistiques, on peut normaliser la variable sur une échelle de 0 à 1.

    ``` r
    DataClean$lifestyle_goFishingFreq_numeric <- (DataRaw$activity_1 - 1) / 4
    table(DataClean$lifestyle_goFishingFreq_numeric)
    ```

5.  Binarisation

    Enfin, on peut transformer la variable en indicateur binaire pour simplifier certaines analyses.

    ``` r
    DataClean$lifestyle_goFishingFreq_bin <- NA
    DataClean$lifestyle_goFishingFreq_bin[DataRaw$activity_1  == 1] <- 0
    DataClean$lifestyle_goFishingFreq_bin[DataRaw$activity_1 %in% c(2, 3, 4, 5)] <- 1
    table(DataClean$lifestyle_goFishingFreq_bin)
    ```
