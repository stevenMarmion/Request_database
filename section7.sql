-- section 7 -- 

--  1) Extraire de la base le nombre de ventes effectuées en 2022 par mois -- 

select MONTH(finVe) mois, count(idve) nbVente
from VENTE
where idSt=4 and YEAR(finVe)=2022
group by mois;

-- 2) Extraire le nombre d’enchères de 2022 par mois

select MONTH(finVe) mois, count(finVe) nbEnchere
from ENCHERIR natural join VENTE
where YEAR(finVe)=2022
group by mois;
