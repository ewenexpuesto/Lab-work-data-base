-- ###################################################################
-- # Author      : EXPUESTO Ewen Salle 131
-- # File        : tp_note.sql
-- # Date        : 25 janvier 2025 
-- ###################################################################

-- *******************************************************************
-- 1. Interrogation (LMD)
-- *******************************************************************

-- !!! N'oubliez pas de reporter le résultat  après chaque requête !!!   

------> V1. (3+2 tuples)
-- requête a)
CREATE VIEW v_Real(n_personne, nom, prenom) AS SELECT t_personne.n_personne, t_personne.nom, t_personne.prenom FROM t_personne JOIN t_film ON t_film.realisateur=t_personne.n_personne GROUP BY t_personne.n_personne;
-- résultat
 n_personne |    nom     |  prenom  
------------+------------+----------
         22 | Eastwood   | Clint
         19 | Soderbergh | Steven
         20 | Leone      | Sergio
         18 | Cohen's    | Brothers
         21 | Tarantino  | Quentin
(5 lignes)


-- requête b)
CREATE VIEW v_Real(n_personne, nom, prenom) AS SELECT t_personne.n_personne, t_personne.nom, t_personne.prenom FROM t_personne, t_film WHERE t_film.realisateur=t_personne.n_personne GROUP BY t_personne.n_personne;
-- résultat
 n_personne |    nom     |  prenom  
------------+------------+----------
         22 | Eastwood   | Clint
         19 | Soderbergh | Steven
         20 | Leone      | Sergio
         18 | Cohen's    | Brothers
         21 | Tarantino  | Quentin
(5 lignes)

------> V2. (17+2 tuples)
-- requête a)
CREATE VIEW v_Act(n_personne, nom, prenom) AS SELECT t_personne.n_personne, t_personne.nom, t_personne.prenom FROM t_personne JOIN t_role ON t_role.n_acteur=t_personne.n_personne GROUP BY t_personne.n_personne;
-- résultat
 n_personne |    nom     |   prenom   
------------+------------+------------
         22 | Eastwood   | Clint
         15 | Wallach    | Eli
          5 | Grier      | Pam
          4 | Jackson    | Samuel Lee
         10 | Clooney    | George
          6 | De Niro    | Robert
         14 | Volonte    | Gian-Maria
         13 | Van Cleef  | Lee
          2 | Carradine  | David
          7 | Travolta   | Jonh
          1 | Thurman    | Uma
          8 | Willis     | Bruce
         11 | Zeta-Jones | Catherine
          9 | Pitt       | Brad
         21 | Tarantino  | Quentin
          3 | Hannah     | Daryl
         17 | Fonda      | Henri
         16 | Cardinale  | Claudia
         12 | Damon      | Matt
(19 lignes)


-- requête b)
CREATE VIEW v_Act(n_personne, nom, prenom) AS SELECT t_personne.n_personne, t_personne.nom, t_personne.prenom FROM t_personne, t_role WHERE t_role.n_acteur=t_personne.n_personne GROUP BY t_personne.n_personne;
-- résultat
 n_personne |    nom     |   prenom   
------------+------------+------------
         22 | Eastwood   | Clint
         15 | Wallach    | Eli
          5 | Grier      | Pam
          4 | Jackson    | Samuel Lee
         10 | Clooney    | George
          6 | De Niro    | Robert
         14 | Volonte    | Gian-Maria
         13 | Van Cleef  | Lee
          2 | Carradine  | David
          7 | Travolta   | Jonh
          1 | Thurman    | Uma
          8 | Willis     | Bruce
         11 | Zeta-Jones | Catherine
          9 | Pitt       | Brad
         21 | Tarantino  | Quentin
          3 | Hannah     | Daryl
         17 | Fonda      | Henri
         16 | Cardinale  | Claudia
         12 | Damon      | Matt
(19 lignes)

------> 1.1. (4 tuples)
-- requête a)
SELECT t_film.titre
FROM t_film
JOIN t_personne ON t_film.realisateur=t_personne.n_personne
WHERE t_personne.nom='Tarantino'
GROUP BY t_film.titre;
-- résultat
    titre     
--------------
 Jackie Brown
 Kill Bill 1
 Kill Bill 2
 Pulp fiction
(4 lignes)

-- requête b)
SELECT t_film.titre
FROM t_film, t_personne
WHERE t_film.realisateur=t_personne.n_personne AND t_personne.nom='Tarantino'
GROUP BY t_film.titre;
-- résultat
    titre     
--------------
 Jackie Brown
 Kill Bill 1
 Kill Bill 2
 Pulp fiction
(4 lignes)

------> 1.2. (5 tuples)
-- requête a)
SELECT t_personne.nom, t_personne.prenom
FROM t_personne
JOIN t_role ON t_role.n_acteur=t_personne.n_personne
JOIN t_film ON t_role.n_film=t_film.n_film
WHERE t_film.titre='Pulp fiction';
-- résultat
    nom    |   prenom   
-----------+------------
 Thurman   | Uma
 Jackson   | Samuel Lee
 Travolta  | Jonh
 Willis    | Bruce
 Tarantino | Quentin
(5 lignes)

-- requête b)
SELECT t_personne.nom, t_personne.prenom
FROM t_personne, t_role, t_film
WHERE t_role.n_acteur=t_personne.n_personne AND t_role.n_film=t_film.n_film AND t_film.titre='Pulp fiction';
-- résultat
     nom    |   prenom   
-----------+------------
 Thurman   | Uma
 Jackson   | Samuel Lee
 Travolta  | Jonh
 Willis    | Bruce
 Tarantino | Quentin
(5 lignes)

------> 1.3. (5 tuples)
-- requête
SELECT t_film.titre, t_film.date_sortie
FROM t_film
JOIN t_role ON t_role.n_film=t_film.n_film
JOIN t_personne ON t_role.n_acteur=t_personne.n_personne
WHERE t_personne.nom='Clooney'
ORDER BY t_film.date_sortie DESC;
-- résultat
        titre        | date_sortie 
---------------------+-------------
 Burn after reading  |        2008
 Ocean's thirteen    |        2007
 Ocean's twelve      |        2004
 Intolerable cruelty |        2003
 Ocean's eleven      |        2001
(5 lignes)

------> 1.4. (cf. sujet)
-- requête
SELECT t_personne.nom, t_personne.prenom, COUNT(t_film.n_film) AS nb_film
FROM t_personne
JOIN t_role ON t_role.n_acteur=t_personne.n_personne
JOIN t_film ON t_role.n_film=t_film.n_film
GROUP BY t_personne.n_personne
ORDER BY nb_film DESC, t_personne.nom ASC;
-- résultat
    nom     |   prenom   | nb_film 
------------+------------+---------
 Clooney    | George     |       5
 Eastwood   | Clint      |       4
 Pitt       | Brad       |       4
 Damon      | Matt       |       3
 Jackson    | Samuel Lee |       3
 Thurman    | Uma        |       3
 Carradine  | David      |       2
 Hannah     | Daryl      |       2
 Tarantino  | Quentin    |       2
 Van Cleef  | Lee        |       2
 Volonte    | Gian-Maria |       2
 Zeta-Jones | Catherine  |       2
 Cardinale  | Claudia    |       1
 De Niro    | Robert     |       1
 Fonda      | Henri      |       1
 Grier      | Pam        |       1
 Travolta   | Jonh       |       1
 Wallach    | Eli        |       1
 Willis     | Bruce      |       1
(19 lignes)

------> 1.5. (2 tuples)
-- requête
SELECT t_personne.nom, t_personne.prenom, COUNT(t_film.n_film) as nb_film
FROM t_personne
JOIN t_film ON t_film.realisateur=t_personne.n_personne
GROUP BY t_personne.n_personne
HAVING COUNT(t_film.n_film)>=3;
-- résultat
    nom     | prenom  | nb_film 
------------+---------+---------
 Soderbergh | Steven  |       3
 Leone      | Sergio  |       4
 Tarantino  | Quentin |       4
(3 lignes)

------> 1.6. (3 tuples)
-- requête
SELECT t_film.titre, t_film.date_sortie
FROM t_film
JOIN t_role ON t_role.n_film=t_film.n_film
JOIN t_personne ON t_role.n_acteur=t_personne.n_personne
WHERE t_personne.nom='Clooney' EXCEPT (
SELECT t_film.titre, t_film.date_sortie
FROM t_film
JOIN t_role ON t_role.n_film=t_film.n_film
JOIN t_personne ON t_role.n_acteur=t_personne.n_personne
WHERE t_personne.nom='Zeta-Jones');
-- résultat
       titre        | date_sortie 
--------------------+-------------
 Ocean's eleven     |        2001
 Ocean's thirteen   |        2007
 Burn after reading |        2008
(3 lignes)

------> 1.7. (2 tuples)
-- requête
SELECT t_personne.nom, t_personne.prenom
FROM t_personne
JOIN t_film ON t_film.realisateur=t_personne.n_personne INTERSECT (
SELECT t_personne.nom, t_personne.prenom
FROM t_personne
JOIN t_role ON t_role.n_acteur=t_personne.n_personne);
-- résultat
    nom    | prenom  
-----------+---------
 Eastwood  | Clint
 Tarantino | Quentin
(2 lignes)

------> 1.8. (17 tuples)
-- requête
SELECT t_personne.n_personne, t_personne.nom, t_personne.prenom
FROM t_personne
JOIN t_role ON t_role.n_acteur=t_personne.n_personne 
WHERE t_personne.n_personne NOT IN (
SELECT t_personne.n_personne
FROM t_personne
JOIN t_film ON t_film.realisateur=t_personne.n_personne)
GROUP BY t_personne.n_personne;
-- résultat
 n_personne |    nom     |   prenom   
------------+------------+------------
         11 | Zeta-Jones | Catherine
          9 | Pitt       | Brad
         15 | Wallach    | Eli
          3 | Hannah     | Daryl
         17 | Fonda      | Henri
          5 | Grier      | Pam
          4 | Jackson    | Samuel Lee
         10 | Clooney    | George
          6 | De Niro    | Robert
         14 | Volonte    | Gian-Maria
         13 | Van Cleef  | Lee
          2 | Carradine  | David
         16 | Cardinale  | Claudia
          7 | Travolta   | Jonh
         12 | Damon      | Matt
          1 | Thurman    | Uma
          8 | Willis     | Bruce
(17 lignes)

------> 1.9. (3 tuples)
-- requête
SELECT t_personne.n_personne, t_personne.nom, t_personne.prenom
FROM t_personne
RIGHT JOIN t_film ON t_film.realisateur=t_personne.n_personne
JOIN t_role ON t_role.n_acteur<>t_personne.n_personne
GROUP BY t_personne.n_personne;
-- résultat
 n_personne |    nom     |  prenom  
------------+------------+----------
         18 | Cohen's    | Brothers
         19 | Soderbergh | Steven
         20 | Leone      | Sergio
         21 | Tarantino  | Quentin
         22 | Eastwood   | Clint
(5 lignes)

-- *******************************************************************
-- 2. Fonctions et triggers (LMD, LDD et PL/pgSQL)
-- *******************************************************************

------> 2.1.
ALTER TABLE t_personne
ADD CONSTRAINT type_personne=1
WHERE n_personne IN (
SELECT t_personne.n_personne
FROM t_personne
JOIN t_role ON t_personne.n_personne=t_role.n_acteur)

ALTER TABLE t_personne
ADD CONSTRAINT type_personne=1
WHERE n_personne IN (
SELECT t_personne.n_personne
FROM t_personne
JOIN t_role ON t_personne.n_personne=t_film.realisateur)

ALTER TABLE t_personne
ADD CONSTRAINT type_personne=1
WHERE n_personne IN (
SELECT t_personne.n_personne
FROM t_personne
JOIN t_film ON t_personne.n_personne=t_film.realisateur
JOIN t_role ON t_personne.n_personne=t_role.n_acteur)

------> 2.2.
-- a) UPDATE t_personne SET type_personne=1 WHERE n_personne=1;
-- b) UPDATE t_personne SET type_personne=4 WHERE n_personne=1; => la contrainte l'empêche
-- c)

-------> 2.3
CREATE OR REPLACE FUNCTION f_initialise_type(num_personne INTEGER,
num_type INTEGER) RETURNS void AS 
$$
-- a completer
$$ LANGUAGE plpgsql;

-- Test de la fonction
SELECT f_initialise_type(2, 1);

-------> 2.4
CREATE OR REPLACE FUNCTION f_initialise_type_all() RETURNS void AS
$$
-- a completer
$$ LANGUAGE plpgsql;

-- Test de la fonction
SELECT f_initialise_type_all();

-------> 2.5
CREATE OR REPLACE FUNCTION f_is_director() RETURNS TRIGGER AS
$$
-- a completer
$$ LANGUAGE plpgsql;

DROP TRIGGER d_is_director ON -- a completer
CREATE TRIGGER d_is_director -- a completer

-- a)
-- b)

-- *******************************************************************
-- 3. Modification du schema (LDD)
-- *******************************************************************

-- https://www.postgresql.org/docs/16/sql-altertable.html

------> 3.1
Chaque personne de la table t_personne doit être présente en tant que réalisateur dans t_film ou bien en tant qu'acteur dans t_role.
------> 3.2
-- a)
ALTER TABLE t_personne
ADD CONSTRAINT id UNIQUE (n_personne,nom,prenom,type_personne);
-- b)
ALTER TABLE t_personne
ADD CONSTRAINT CHECK ((n_personne,nom,prenom,type_personne) NOT NULL);

------> 3.3
Un tel couple représente une clé primaire de la relation t_personne.

------> 3.4
-- a)
ALTER TABLE t_film
ADD COLUMN nom_real TEXT;

ALTER TABLE t_film
ADD COLUMN prenom_real TEXT;
-- b)
ALTER TABLE t_film
ALTER COLUMN (nom_real, prenom_real) REFERENCES t_personne;
