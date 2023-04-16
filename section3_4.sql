-- Section 3 --

select idob, nomOb
from OBJET natural join VENTE
where DAY(debutVe)<15;

select idob, nomOb
from OBJET natural join VENTE
where prixBase<500;

select idob, nomOb
from OBJET natural join VENTE v natural join ENCHERIR e
where e.montant>=v.prixBase*10;

-- Section 4 -- 

insert into UTILISATEUR(idUt,pseudoUt,emailUT,mdpUt,activeUt,idRole) values
    (1002,'IUTO','iuto@info.univ-orleans.fr','IUTO','O',2);

insert into OBJET(idOb,nomOb,descriptionOb,idCat,idUt) values
    (515,'canapé clic-clac','très beau et ayant peu servi',3,1002);

insert into VENTE(idVe,prixBase,prixMin,debutVe,finVe,idSt,idOb) values
    (515,40,80,STR_TO_DATE('23/03/2023:10:00:00','%d/%m/%Y:%h:%i:%s'),DATE_ADD(STR_TO_DATE('23/03/2023:10:00:00','%d/%m/%Y:%h:%i:%s'),INTERVAL 371 DAY),2,515);

