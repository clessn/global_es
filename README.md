---
author:
- CLESSN
title: Guide de nomenclature
---

::: center
:::

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

# Nomenclature pour Slack

Les chaines Slack suivent la structure de la chaire. Leurs noms peuvent ainsi varier en fonction des priorités du moment. Similairement aux noms de variables, les noms des chaines suivent une nomenclature standardisée qui a une signification symbolique, se référant à la structure de la chaire.

## Structure d'une chaine

-   **Premier mot :** Numéro se référant aux pôles et aux thèmes

    -   **00 :** Fonctions et coordination

    -   **01 :** Datagotchi

    -   **02 :** Vitrine

    -   **77 :** Utilitaires

    -   **99 :** Autres

-   **Underscore :** Représentation de l'arborescence. Voyez les chaines slack comme une arborescence d'ordinateur, allant du plus central au moins central. Les chaines principales d'un pôle ont 3 underscores. Quand on progresse dans l'arborescence, on retire un underscore. Les sous-projets en ont deux, et leurs sous-chaines en ont une.

    -   Exemples : `01___datagotchi`, `01__datagotchi_canada` et `01_datagotchi_canada_clustering`.

    -   Autres exemples : `00___général` et `00__enseignement`.

-   **Deuxième mot :** Nom du pôle ou de la fonction. Les choix de pôles sont datagotchi et vitrine.

-   **Uunderscore et mots subséquents :** Si les mots suivants définissent un avancement dans l'arborescence ou un concept différent, ils sont séparés d'un underscore. Si c'est plutôt un mot se référant au même contexte que le mot précédent, il est séparé d'un trait d'union. C'est réflexion est similaire à celle des variables, pour la distinction entre un underscore et une lettre majuscule. Puisque les majuscule ne sont pas acceptées dans les noms de chaines Slack, nous optons pour un trait d'union lorsque la différence conceptuelle est moindre.

    -   Exemples : `01_datagotchi_canada_shiny` et `01_datagotchi_marché-politique`

## Chaines de fonctions

Certaines chaines ne commencent pas par un numéro. Ce sont les chaines qui se réfèrent à des fonctions, sans être spécifiques à un pôle. C'est le cas des chaines utilisées pour discuter de l'avancement d'une publication, ou encore d'une demande de financement. Ces chaines commencent par l'abbréviation de la fonction.

-   **com\_ :** Communication

-   **don\_ :** Données et éthique

-   **ens\_ :** Enseignement

-   **fin\_ :** Financement

-   **par\_ :** Partenaires

-   **pub\_ :** Publications

La suite de la nomenclature est identique à celle des autres chaines, à une exception près. Dépendant de la fonction, le préfixe est suivi d'un chiffre ou d'une lettre.

-   Financement

    -   **x :** En rédaction

    -   **r :** Révisée par Yannick

    -   **s :** Soumise

    -   **f :** Financée

    -   **d :** Déclinée

-   Publications

    -   **01 à 05 :** Priorité

    -   **x :** En rédaction

    -   **r :** Révisée par Yannick

    -   **s :** Soumise

    -   **rnr :** R&R (Review and resubmit)

    -   **p :** Publiée

```{=html}
<!-- -->
```
-   Exemples : `fin_s_cecd-infra_2024` et `pub_p_gpt-party`

Note : Il est de bonne pratique d'indiquer dans le thème de la chaine des détails par rapport à la soumission de vos articles. Exemple : Soumis le 31 décembre 2024 à Environmental Politics.
