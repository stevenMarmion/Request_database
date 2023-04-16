-- TP 2_04
-- Nom: Marmion, Prenom: Steven

-- +------------------+--
-- * Question 1 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des objets vendus par ght1ordi au mois de février 2023

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +----------+----------------------+
-- | pseudout | nomob                |
-- +----------+----------------------+
-- | etc...
-- = Reponse question 1.

select pseudoUt, nomob 
from UTILISATEUR natural join OBJET natural join VENTE natural join STATUT
where pseudoUt="ght1ordi" and MONTH(finVe)=2 and YEAR(finVe)=2023 and idSt=4;

-- +------------------+--
-- * Question 2 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des utilisateurs qui ont enchérit sur un objet qu’ils ont eux même mis en vente

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-----------+
-- | pseudout  |
-- +-----------+
-- | etc...
-- = Reponse question 2.

select distinct pseudoUt
from ENCHERIR e natural join UTILISATEUR
where idRole=2 and e.idut=e.idve;

-- +------------------+--
-- * Question 3 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des utilisateurs qui ont mis en vente des objets mais uniquement des meubles

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------------+
-- | pseudout    |
-- +-------------+
-- | etc...
-- = Reponse question 3.

select pseudoUt 
from UTILISATEUR natural join OBJET natural join CATEGORIE natural join VENTE 
where idut not in (select distinct idut from UTILISATEUR natural join OBJET natural join CATEGORIE where idCat!=3);

-- +------------------+--
-- * Question 4 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  La liste des objets qui ont généré plus de 15 enchères en 2022

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+----------------------+
-- | idob | nomob                |
-- +------+----------------------+
-- | etc...
-- = Reponse question 4.

create or replace view VenteEn2022(idVente, nbEnchere) as
select idve, count(idVe)
from ENCHERIR natural join VENTE
group by idve
order by idve;

select * from VenteEn2022 where nbEnchere>15;

-- +------------------+--
-- * Question 5 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
-- Ici NE CREEZ PAS la vue PRIXVENTE mais indiquer simplement la requête qui lui est associée. 
-- C'est à dire la requête permettant d'obtenir pour chaque vente validée, l'identifiant de la vente l'identiant de l'acheteur et le prix de la vente.

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+------------+----------+
-- | idve | idacheteur | montant  |
-- +------+------------+----------+
-- | etc...
-- = Reponse question 5.

select idve, idUT idacheteur, max(montant) montant
from ENCHERIR natural join VENTE
where idSt=4
group by idve;

-- +------------------+--
-- * Question 6 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Le chiffre d’affaire par mois de la plateforme (en utilisant la vue PRIXVENTE)

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+-------+-----------+
-- | mois | annee | ca        |
-- +------+-------+-----------+
-- | etc...
-- = Reponse question 6.

create or replace view PRIXVENTE(mois, annee, ca) as 
select MONTH(finVe) mois, YEAR(finVe) annee, max(montant)
from ENCHERIR natural join VENTE
group by idve
order by annee, mois;

select mois, annee, sum(ca) ca from PRIXVENTE group by mois, annee;

-- +------------------+--
-- * Question 7 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Les informations du ou des utilisateurs qui ont mis le plus d’objets en vente

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+----------+------+
-- | idut | pseudout | nbob |
-- +------+----------+------+
-- | etc...
-- = Reponse question 7.

create or replace view compteNbObjetParPersonne as
select idut, pseudoUt, count(idob) nbob
from UTILISATEUR natural join OBJET natural join VENTE
where idRole=2
group by idut;

select * from compteNbObjetParPersonne having nbob = (select max(nbob) from compteNbObjetParPersonne);

-- +------------------+--
-- * Question 8 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  le camembert

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +-------+-------------------+-----------+
-- | idcat | nomcat            | nb_objets |
-- +-------+-------------------+-----------+
-- | etc...
-- = Reponse question 8.

select idcat, nomcat, count(idob) nb_objets from CATEGORIE natural join OBJET natural join VENTE where YEAR(finVe)=2022 group by idcat;

-- +------------------+--
-- * Question 9 :     --
-- +------------------+--
-- Ecrire une requête qui renvoie les informations suivantes:
--  Le top des vendeurs

-- Voici le début de ce que vous devez obtenir.
-- ATTENTION à l'ordre des colonnes et leur nom!
-- +------+-------------+----------+
-- | idut | pseudout    | total    |
-- +------+-------------+----------+
-- | etc...
-- = Reponse question 9.

create or replace view VENTEUSER as 
select distinct idut, pseudoUt, max(montant) total
from VENTE natural join ENCHERIR natural join UTILISATEUR
where MONTH(finVe)=1 and YEAR(finVe)=2023
group by idut
order by total desc;

select * from VENTEUSER limit 10;