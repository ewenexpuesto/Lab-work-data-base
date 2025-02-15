/* les fichiers mentionnés en fin de préambule sont dans le dossier du tp.pdf */

/* NOM DE LA TABLE : ewen_expuesto_vins et pas tp_vins_ewen_expuesto */
/* POur se connecter, juste entrer dans le bash : psql -h pgsql -d ewen_expuesto_vins */

/* First file stocks.sql---------------------------------------------------------------*/

-- ###################################################################
-- # Application : PL/pgSQL script
-- # Fichier     : stock.sql
-- # Auteur      : yourself (dec 2018)
-- ###################################################################

-- ###################################################################
-- # Q1 : modification de la table vin
-- ###################################################################

ALTER TABLE vin
ADD COLUMN stock INTEGER;

ALTER TABLE vin
ADD CONSTRAINT CHECK (stock > 0);

/* OR */

ALTER TABLE vin
ADD COLUMN stock INTEGER
CHECK (stock > 0);

-- ###################################################################
-- # Q2 et Q3 : fonctions pour initialiser les stocks
-- ###################################################################

-- ***
-- *** f_initialise_stock_vin(num_vin, qte)
-- *** --> Donner une description de la fonction
-- ***

/* on suppose que le num_vin existe */
CREATE OR REPLACE FUNCTION 
f_initialise_stock_vin(num_vin INTEGER, qte INTEGER) 
RETURNS void AS $fisv$
   BEGIN
   IF qte>=0 THEN
        UPDATE vin.num_vin
        SET stock=qte
        WHERE n_vin=num_vin;
   ELSE 
        RAISE NOTICE 'Quantité négative';
    END IF;
   END;
$fisv$ LANGUAGE plpgsql;

-- ***
-- *** tests de la fonction f_initialise_stock_vin()
-- ***
SELECT f_initialise_stock_vin(170, 12);
SELECT f_initialise_stock_vin(170, -666);

-- ***
-- *** f_initialise_stock()
-- *** --> Donner une description de la fonction
-- ***
CREATE OR REPLACE FUNCTION f_initialise_stock() 
RETURNS void AS $fis$
   DECLARE 
      -- un curseur pour parcourir la table vin
      cursor_stock SELECT * FROM vin;
   BEGIN
      -- Un appel à la fonction f initialise stock vin serait bienvenu 
      FOR ligne IN cursor_stock LOOP
        f_initialise_stock_vin(ligne,24);
      END LOOP;
      -- EXECUTE f initialise stock vin(...)
   END;
$fis$ LANGUAGE plpgsql;

-- ***
-- *** tests de la fonction f_initialise_stock_vin()
-- ***
SELECT f_initialise_stock();

-- ###################################################################
-- # Q4 et Q5 : triggers 
-- ###################################################################

-- ***
-- *** f_verifie_stock() 
-- *** --> Donner une description de la fonction
-- ***
CREATE OR REPLACE FUNCTION f_verifie_stock () RETURNS TRIGGER AS
$fvs$
   DECLARE
      -- une variable pour mettre le stock disponible
   BEGIN
     /* ... */
   END;
$fvs$ LANGUAGE plpgsql;

-- ***
-- *** d_verifie_stock() 
-- *** --> Donner une description du trigger
-- ***
DROP TRIGGER d_verifie_stock ON /* ... */;
CREATE TRIGGER d_verifie_stock 
/* ... */
EXECUTE PROCEDURE f_verifie_stock();

-- ***
-- tests du trigger d_verifie_stock
-- ***
-- INSERT INTO commande

-- ***
-- *** f_diminue_stock()
-- *** --> Donner une description de la fonction
-- ***
CREATE OR REPLACE FUNCTION f_diminue_stock () RETURNS TRIGGER AS
$fds$
   DECLARE
      -- ...
   BEGIN
      -- ...
   END;
$fds$ LANGUAGE plpgsql;

-- ***
-- *** d_verifie_stock()
-- *** --> Donner une description du déclencheur
-- ***
DROP TRIGGER d_diminue_stock ON /* ... */;
DROP TRIGGER d_verifie_stock ON /* ... */;
CREATE TRIGGER d_diminue_stock 
/* ... */
EXECUTE PROCEDURE f_diminue_stock();

-- ***
-- tests du trigger d_diminue_stock
-- ***
-- 



/* Second file millesime.SQL--------------------------------------------------------- */

-- ###################################################################
-- # Application : PL/pgSQL script
-- # Fichier     : millesime.sql
-- # Auteur      : yourself (dec 2018)
-- ###################################################################

-- ###################################################################
-- # Q1 : table miroir
-- ###################################################################

-- ***
-- *** création de vin_m, une table miroir de vin
-- ***  
DROP TABLE vin_m;
CREATE TABLE vin_m( 
   n_vin TEXT,
   /* ... */
   );  


-- ###################################################################
-- # Q2 : fonction
-- ###################################################################

-- ***
-- *** f_initialise_vin_m() 
-- *** --> Donner une description de la fonction
-- ***
CREATE OR REPLACE FUNCTION f_initialise_vin_m () RETURNS void AS $fun$
   DECLARE
      -- un curseur pour parcourir la table vin
      
      -- autres variables
      
   BEGIN
      RAISE NOTICE '*** Insertion dans vin_m ***';
      
      -- boucle sur le curseur
      FOR /* ... */ LOOP
      	 -- affectation des valeurs courantes (si besoin)
	 
	 -- création de la clé de vin_m
      	 
	 -- affichage du tuple inséré (ça ne peut pas faire de mal)
	    
      	 -- insertion du tuple dans vin_m
      END LOOP;
 
   EXCEPTION
      WHEN -- ...
   END;    
$fun$ LANGUAGE plpgsql;

-- ***
-- *** tests de la fonction f_initialise_vin_m()
-- ***
DELETE FROM vin_m;
SELECT f_initialise_vin_m();
SELECT f_initialise_vin_m(); -- pour tester l'exception


-- ###################################################################
-- # Q3 : déclencheur
-- ###################################################################

-- ***
-- *** f_calcule_millesime() 
-- *** --> Donner une description de la fonction
-- ***
CREATE OR REPLACE FUNCTION f_calcule_millesime () RETURNS TRIGGER AS
$fun$
   DECLARE
      -- ...
   BEGIN
      -- ...
   END;
$fun$ LANGUAGE plpgsql;

-- ***
-- *** d_calcule_millesime() 
-- *** --> Donner une description du trigger
-- ***
DROP TRIGGER d_calcule_millesime ON /* ... */;
CREATE TRIGGER d_calcule_millesime /* ... */
EXECUTE PROCEDURE f_calcule_millesime();

-- ***
-- tests du trigger d_calcule_millesime
-- ***
INSERT INTO vin_m
VALUES ('1988278', 'POMMARD', 1986, 'BOURGOGNE', 10);

INSERT INTO vin_m
VALUES ('1988278', 'POMMARD', NULL, 'BOURGOGNE', 10);

DELETE FROM vin_m;
SELECT f_initialise_vin_m();