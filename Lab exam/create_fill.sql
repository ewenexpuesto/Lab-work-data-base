-- ###################################################################
-- # Application : SQL script
-- # File        : create_fill.sql
-- # Revision    : janvier 2025 
-- # Author      : Marie Szafranski
-- # Function    : structure de la BD films et remplissage
-- ###################################################################

DROP TABLE t_Role;
DROP TABLE t_Film;
DROP TABLE t_Personne;

CREATE TABLE t_Personne(
   n_personne INTEGER,
   nom VARCHAR(50) NOT NULL,
   prenom VARCHAR(50),
   type_personne INTEGER,
   CONSTRAINT pk_t_Personne PRIMARY KEY (n_personne));

CREATE TABLE t_Film(
   n_film INTEGER,
   titre VARCHAR(50) NOT NULL,
   genre VARCHAR(50) NOT NULL,
   realisateur INTEGER,
   date_sortie INTEGER, -- contrainte sur l'année > 1980
   CONSTRAINT pk_t_Film PRIMARY KEY(n_film),
   CONSTRAINT fk_t_Film_real FOREIGN KEY (realisateur) 
      REFERENCES t_Personne(n_personne)
);
   
CREATE TABLE t_Role(
   n_acteur INTEGER,
   n_film INTEGER,
   CONSTRAINT pk_t_Role PRIMARY KEY (n_acteur, n_film),
   CONSTRAINT fk_t_Role_acteur FOREIGN KEY (n_acteur)
      REFERENCES t_Personne(n_personne),
   CONSTRAINT fk_t_Role_film FOREIGN KEY (n_film)
      REFERENCES t_Film(n_film)
);

DELETE FROM t_Role;
DELETE FROM t_Film;
DELETE FROM t_Personne;

-- table t_Personne

-- d'abord les acteurs
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(1, 'Thurman', 'Uma');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(2, 'Carradine', 'David');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(3, 'Hannah', 'Daryl');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(4, 'Jackson', 'Samuel Lee');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(5, 'Grier', 'Pam');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(6, 'De Niro', 'Robert');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(7, 'Travolta', 'Jonh');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(8, 'Willis', 'Bruce');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(9, 'Pitt', 'Brad');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(10, 'Clooney', 'George');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(11, 'Zeta-Jones', 'Catherine');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(12, 'Damon', 'Matt');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(13, 'Van Cleef', 'Lee');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(14, 'Volonte', 'Gian-Maria');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(15, 'Wallach', 'Eli');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(16, 'Cardinale', 'Claudia');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(17, 'Fonda', 'Henri');
-- ensuite les réalisateurs
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(18, 'Cohen''s', 'Brothers');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(19, 'Soderbergh', 'Steven');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(20, 'Leone', 'Sergio');
-- puis les réalisateurs-acteurs
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(21, 'Tarantino', 'Quentin');
INSERT INTO t_Personne(n_personne, nom, prenom)
VALUES(22, 'Eastwood', 'Clint');

-- table t_Film

--> Tarantino
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(1, 'Kill Bill 1', 'action', 21, 2003);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(2, 'Kill Bill 2', 'action', 21, 2004);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(3, 'Pulp fiction', 'gangster', 21, 1994);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(4, 'Jackie Brown', 'gangster', 21, 1994);
--> Cohen's brothers
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(5, 'Burn after reading', 'comedie', 18, 2008);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(6, 'Intolerable cruelty', 'comedie', 18, 2003);
--> Steven Soderbergh
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(7, 'Ocean''s eleven', 'comedie / action / gangster', 19, 2001);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(8, 'Ocean''s twelve', 'comedie / action / gangster', 19, 2004);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(9, 'Ocean''s thirteen', 'comedie / action / gangster', 19, 2007);
-- > Sergio Leone
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(10, 'Per un pugno di dollari', 'western spaghetti', 20, 1964);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(11, 'Per qualche dollaro in piu', 'western spaghetti', 20, 1965);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(12, 'Il buono, il brutto, il cattivo', 'western spaghetti', 20,
1966);
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(13, 'C''era una volta il West', 'western spaghetti', 20, 1968); 
--> Clint Eastwood
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(14, 'Pale rider', 'western', 22, 1985); 
INSERT INTO t_Film(n_film, titre, genre, realisateur, date_sortie)
VALUES(15, 'Mystic river', 'drame', 22, 2003); 

-- table t_Role

--> Kill Bill 1
INSERT INTO t_Role(n_film, n_acteur)
VALUES(1, 1); -- Thurman
INSERT INTO t_Role(n_film, n_acteur)
VALUES(1, 2); -- Carradine
INSERT INTO t_Role(n_film, n_acteur)
VALUES(1, 3); -- Hannah
INSERT INTO t_Role(n_film, n_acteur)
VALUES(1, 21); -- Tarantino
--> Kill Bill 2
INSERT INTO t_Role(n_film, n_acteur)
VALUES(2, 1); -- Thurman
INSERT INTO t_Role(n_film, n_acteur)
VALUES(2, 2); -- Carradine
INSERT INTO t_Role(n_film, n_acteur)
VALUES(2, 3); -- Hannah
INSERT INTO t_Role(n_film, n_acteur)
VALUES(2, 4); -- Jackson
--> Pulp Fiction
INSERT INTO t_Role(n_film, n_acteur)
VALUES(3, 1); -- Thurman
INSERT INTO t_Role(n_film, n_acteur)
VALUES(3, 4); -- Jackson
INSERT INTO t_Role(n_film, n_acteur)
VALUES(3, 7); -- Travolta
INSERT INTO t_Role(n_film, n_acteur)
VALUES(3, 8); -- Willis
INSERT INTO t_Role(n_film, n_acteur)
VALUES(3, 21); -- Tarantino
--> Jackie Brown
INSERT INTO t_Role(n_film, n_acteur)
VALUES(4, 5); -- Grier
INSERT INTO t_Role(n_film, n_acteur)
VALUES(4, 6); -- De Niro
INSERT INTO t_Role(n_film, n_acteur)
VALUES(4, 4); -- Jackson
--> Burn after reading
INSERT INTO t_Role(n_film, n_acteur)
VALUES(5, 9); -- Pitt
INSERT INTO t_Role(n_film, n_acteur)
VALUES(5, 10); -- Clooney
--> Intolerable cruelty 
INSERT INTO t_Role(n_film, n_acteur)
VALUES(6, 10); -- Clooney
INSERT INTO t_Role(n_film, n_acteur)
VALUES(6, 11); -- Zeta-Jones
--> Oceans'11
INSERT INTO t_Role(n_film, n_acteur)
VALUES(7, 10); -- Clooney
INSERT INTO t_Role(n_film, n_acteur)
VALUES(7, 9); -- Pitt
INSERT INTO t_Role(n_film, n_acteur)
VALUES(7, 12); -- Damon
--> Oceans'12
INSERT INTO t_Role(n_film, n_acteur)
VALUES(8, 10); -- Clooney
INSERT INTO t_Role(n_film, n_acteur)
VALUES(8, 9); -- Pitt
INSERT INTO t_Role(n_film, n_acteur)
VALUES(8, 12); -- Damon
INSERT INTO t_Role(n_film, n_acteur)
VALUES(8, 11); -- Zeta-Jones
--> Oceans'13
INSERT INTO t_Role(n_film, n_acteur)
VALUES(9, 10); -- Clooney
INSERT INTO t_Role(n_film, n_acteur)
VALUES(9, 9); -- Pitt
INSERT INTO t_Role(n_film, n_acteur)
VALUES(9, 12); -- Damon
--> Per un pugno di dollari  
INSERT INTO t_Role(n_film, n_acteur)
VALUES(10, 22); -- Eastwood
INSERT INTO t_Role(n_film, n_acteur)
VALUES(10, 14); -- Volonte
--> Per qualche dollaro in piu  
INSERT INTO t_Role(n_film, n_acteur)
VALUES(11, 22); -- Eastwood
INSERT INTO t_Role(n_film, n_acteur)
VALUES(11, 14); -- Volonte
INSERT INTO t_Role(n_film, n_acteur)
VALUES(11, 13); -- Van Cleef
--> Il buono, il brutto, il cattivo
INSERT INTO t_Role(n_film, n_acteur)
VALUES(12, 22); -- Eastwood
INSERT INTO t_Role(n_film, n_acteur)
VALUES(12, 15); -- Wallache
INSERT INTO t_Role(n_film, n_acteur)
VALUES(12, 13); -- Van Cleef
--> C'era una volta il West    
INSERT INTO t_Role(n_film, n_acteur)
VALUES(13, 16); -- Cardinale
INSERT INTO t_Role(n_film, n_acteur)
VALUES(13, 17); -- Fonda
--> Pale Rider
INSERT INTO t_Role(n_film, n_acteur)
VALUES(14, 22); -- Eastwood