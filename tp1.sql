/* PROJECTIONS ET RESTRICTIONS */

/* NOM DE LA TABLE : ewen_expuesto_vins et pas tp_vins_ewen_expuesto */

SELECT nom FROM buveur;

SELECT ville FROM viticulteur
ORDER BY ville DESC;

SELECT n_commande, c_qte
FROM commande
WHERE c_qte>=6 AND c_qte<=15;

SELECT n_commande
FROM commande
WHERE c_date >= 2002-12-25;

SELECT n_vin, cru, region
FROM vin
WHERE region LIKE 'BO%' OR region LIKE '%NE';

/* JOINTURES ET REQUÊTES D'EXISTENCE OU DE COMPARAISON */

/* Questions préalables */

/* Les attributs sur lesquels portent la jointure sont tous sauf ceux qui sont en
comment, dans ce cas, on ne les affiche pas deux fois. Le schéma obtenu est un 
produit cartésien sans redondance. */

/* Les préfixes précisent dans quelle table (relation) il faut aller valeurs des
attributs. Remarque : vit est un alias. Le schéma du résultat est un produit cartésien
comme une jointure sur l'identifiant du numéro de viticulteur. */

/* La jointure naturelle est vide car les deux tables (relations) n'ont aucun attribut
en commun */

/* USING est une abbréviation de ON, ici on cherche les viticulteurs buveurs */

/* Questions principales */

SELECT viticulteur.n_viticulteur, nom /* ajouter le préfixe sinon ambigüité */
FROM viticulteur
JOIN vin ON viticulteur.n_viticulteur=vin.n_viticulteur
WHERE vin.region='LOIRE' AND vin.millesime='1993' /* un "" ne fonctionne pas */
GROUP BY viticulteur.n_viticulteur; /* sinon, plusieurs lignes apparaissent */

SELECT buveur.n_buveur, buveur.nom
FROM buveur
JOIN commande ON buveur.n_buveur=commande.n_buveur
JOIN vin ON commande.n_vin=vin.n_vin
WHERE vin.cru='POMMARD';
GROUP BY n_buveur; /* au cas où, même si ici ce n'est pas utile */

SELECT viticulteur.nom
FROM viticulteur
JOIN vin ON vin.n_viticulteur=viticulteur.n_viticulteur
JOIN commande ON vin.n_vin=commande.n_vin
JOIN buveur ON buveur.n_buveur=commande.n_buveur
WHERE buveur.nom='DUPOND'
GROUP BY viticulteur.nom;

/* QUESTION 4 */

SELECT viticulteur.nom, viticulteur.n_viticulteur
FROM viticulteur
JOIN vin ON vin.n_viticulteur=viticulteur.n_viticulteur
JOIN commande ON vin.n_vin=commande.n_vin
JOIN buveur ON buveur.n_buveur=commande.n_buveur
WHERE buveur.b_ville=viticulteur.v_ville
GROUP BY viticulteur.n_viticulteur;

/* QUESTION 5 */
/* a */
SELECT buveur.nom, buveur.n_buveur
FROM buveur
JOIN commande ON commande.n_buveur=buveur.n_buveur
GROUP BY buveur.n_buveur;
/* donne les buveurs qui ont déjà commandé */

/* il ne faut pas JOIN puis donner une condition comme suit */
SELECT buveur.nom, buveur.n_buveur
FROM buveur
JOIN commande ON commande.n_buveur=buveur.n_buveur
EXCEPT 
(
SELECT buveur.nom, buveur.n_buveur
FROM buveur
JOIN commande ON commande.n_buveur=buveur.n_buveur
WHERE commande.n_buveur=buveur.n_buveur
)
GROUP BY buveur.n_buveur;

/* mais plutôt en considérant le EXCEPT ou NOT IN comme un join */
SELECT buveur.nom, buveur.n_buveur
FROM buveur
EXCEPT
(
    SELECT buveur.nom, buveur.n_buveur
    FROM buveur
    JOIN commande ON commande.n_buveur=buveur.n_buveur /* ici on a tous les buveurs qui ont commande */
);

/* autre possibilité */
SELECT buveur.nom, buveur.n_buveur
FROM buveur
WHERE (buveur.nom, buveur.n_buveur) NOT IN /* ne pas ouublier les parenthèses */
(
    SELECT buveur.nom, buveur.n_buveur
    FROM buveur
    JOIN commande ON commande.n_buveur=buveur.n_buveur /* ici on a tous les buveurs qui ont commande */
);

/* b */
SELECT buveur.nom, buveur.n_buveur
FROM buveur
WHERE EXISTS
(
    SELECT buveur.nom, buveur.n_buveur
    FROM buveur
    EXCEPT
    (
        SELECT buveur.nom, buveur.n_buveur
        FROM buveur
        JOIN commande ON commande.n_buveur=buveur.n_buveur
    )
);
/* il faut déjà sélectionner les bons candidats dès le départ, quel est l'intérêt de cette commande ? */

/* c */

/* QUESTION 6 */
SELECT vin.cru
FROM vin
JOIN commande ON commande.n_vin=vin.n_vin /* ne pas oublier que les vins doivent être commandés, sinon des vins non commandés restent */
WHERE vin.cru NOT IN
(
    SELECT vin.cru
    FROM vin
    JOIN commande ON commande.n_vin=vin.n_vin
    WHERE commande.c_qte>=12
)
GROUP BY vin.cru;
/* ça marche mais c'est faux s'il faut sommer la quantité commandée */

/* QUESTION 7 */
/* a */
SELECT buveur.nom, buveur.n_buveur
FROM buveur
JOIN commande ON commande.n_buveur=buveur.n_buveur /* que les buveurs qui ont commandé */
EXCEPT
(
    SELECT buveur.nom, buveur.n_buveur
    FROM buveur
    JOIN commande ON commande.n_buveur=buveur.n_buveur
    JOIN vin ON vin.n_vin=commande.n_vin
    WHERE vin.region!='BOURGOGNE'
);

/* b */

/* QUESTION 8 */
SELECT buveur.nom, buveur.n_buveur
FROM buveur
JOIN commande ON commande.n_buveur=buveur.n_buveur /* que les buveurs qui ont commandé */
EXCEPT
(
    SELECT buveur.nom, buveur.n_buveur
    FROM buveur
    JOIN commande ON commande.n_buveur=buveur.n_buveur
    JOIN vin ON vin.n_vin=commande.n_vin
    WHERE vin.region!='BOURGOGNE' OR vin.region!='BORDEAUX'
);

/* QUESTION 9 */
SELECT buveur.b_ville
FROM buveur
GROUP BY buveur.b_ville;

SELECT viticulteur.v_ville
FROM viticulteur
JOIN vin ON viticulteur.n_viticulteur=vin.n_viticulteur
JOIN commande ON vin.n_vin=commande.n_vin
JOIN buveur ON buveur.n_buveur=commande.n_buveur;
EXCEPT
(
    SELECT buveur.b_ville
    FROM buveur
    GROUP BY buveur.b_ville;
)
GROUP BY viticulteur.v_ville;

/* donne un résultat mais une erreur apparait à la fin ??? */

/* FONCTIONS DE CALCUL ET AGREGATS */

/* Questions principales */

/* QUESTION 1 */

SELECT COUNT(vin.cru)
FROM vin
GROUP BY vin.cru;
/* ne fonctionne pas car on compte le nombre de fois que chaque vin apparait */

SELECT COUNT(vin.cru)
FROM vin;
/* donne le nombre de crus, mais il y a des répétitions */

SELECT SUM(vin.cru)
FROM vin
GROUP BY vin.cru;

/* QUESTION 2 */

SELECT vin.n_vin
FROM vin
JOIN commande ON commande.n_vin=vin.n_vin
WHERE commande.c_date>='2001-01-01' AND commande.c_date<='2001-12-31'; /* il faut comparer la date complète */

/* QUESTION 3 */
SELECT vin.region, COUNT(vin.n_vin) nombre_de_vins
FROM vin
GROUP BY vin.region;

/* sans mettre de COUNT, on obtient le message d'erreur suivant
ERREUR:  la colonne « vin.n_vin » doit apparaître dans la clause GROUP BY ou doit être utilisé dans une fonction d'agrégat
cela veut dire qu'il faut supprimer le GROUP BY, ou utiliser un autre attribut */

/* QUESTION 4 */
SELECT COUNT(vin.n_vin) nombre_de_vins, viticulteur.n_viticulteur

