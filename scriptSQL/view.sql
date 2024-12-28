select 
   m.id_medicament,
   m.nom,
   m.desciption
from 
medicament m 
join prix_medicament pm 
on m.id_medicament=pm.id_medicament
join unite u 
on pm.id_unite=u.id_unite
join type_unite  