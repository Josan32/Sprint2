# Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. 
# El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
select apellido1, apellido2, nombre from persona order by apellido1 desc, apellido2 desc, nombre desc;

# Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
select nombre, apellido1, apellido2 from persona where persona.tipo like 'alumno' and telefono is null;

# Retorna el llistat dels alumnes que van néixer en 1999.
select * from persona where persona.tipo like 'alumno' and year(fecha_nacimiento)=1999;

# Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
select * from persona where persona.tipo like 'profesor' and telefono is null and nif like '%K';

# Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
select nombre from asignatura where cuatrimestre =1 and curso =3 and id_grado = 7;

# Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. 
#	El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. 
#	El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
select persona.apellido1, persona.apellido2, persona. nombre, departamento.nombre as 'departamento' from persona
inner join profesor on persona.id = profesor.id_profesor inner join departamento on profesor.id_departamento = departamento.id
order by apellido1, nombre asc;

# Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
 select asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin from persona
 inner join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno
 inner join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id
 inner join asignatura on alumno_se_matricula_asignatura.id_asignatura = asignatura.id
 where nif = '26902806M' and persona.tipo = 'alumno'; 


# Retorna un llistat amb els professors/es que no estan associats a un departament.
select  persona.nombre, persona.apellido1, persona.apellido2 from persona
left join profesor on profesor.id_profesor = persona.id
left join departamento on departamento.id = profesor.id_departamento
where departamento.nombre is null;

# Retorna un llistat amb els departaments que no tenen professors/es associats.
select nombre from departamento
left join profesor on profesor.id_profesor = departamento.id
where profesor.id_departamento is null;

# Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
select distinct persona.nombre, asignatura.id, asignatura.nombre from persona, profesor
left join asignatura on profesor.id_profesor = asignatura.id_profesor
where asignatura.id_profesor is null;

# Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
select asignatura.nombre from asignatura
left join profesor on asignatura.id_profesor = profesor.id_profesor
where profesor.id_profesor is null;

# Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
select nombre from departamento
left join profesor on profesor.id_departamento = departamento.id
where profesor.id_departamento is null;

# Retorna el nombre total d'alumnes que hi ha.
select count(persona.id) from persona where persona.tipo = 'alumno'; 

# Calcula quants alumnes van néixer en 1999.
select count(persona.id) from persona where persona.tipo = 'alumno' and year(fecha_nacimiento) = 1999;

#Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
select departamento.nombre from departamento join profesor on profesor.id_departamento = departamento.id 
join asignatura on asignatura.id_profesor = profesor.id_profesor
join grado on grado.id = asignatura.id_grado
where grado.nombre like 'Grado en Ingeniería Informática (Plan 2015)';

# Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
select grado.nombre, count(asignatura.id_grado) as asignaturas from grado 
left join asignatura  on asignatura.id_grado = grado.id 
group by grado.id having asignaturas > 40;

# Retorna totes les dades de l'alumne/a més jove.
SELECT * FROM persona WHERE fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona) AND tipo IN ('alumno');

#Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
select persona.id, persona.nombre, persona.apellido1, persona.apellido2 from profesor 
join persona  on persona.id = profesor.id_profesor
left join asignatura  on profesor.id_profesor = asignatura.id_profesor
where asignatura.id_profesor is null order by persona.id;

#Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
select departamento.nombre from asignatura 
join grado  on asignatura.id_grado = (select grado.id from grado  where nombre in ('Grado en Ingeniería Informática (Plan 2015)'))
join profesor  on asignatura.id_profesor = profesor.id_profesor
join departamento  on profesor.id_departamento = departamento.id group by departamento.nombre;

#Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
select persona.id, persona.nif, persona.nombre, persona.apellido1, persona.apellido2 from persona 
join alumno_se_matricula_asignatura on persona.id = alumno_se_matricula_asignatura.id_alumno
join asignatura on alumno_se_matricula_asignatura.id_asignatura = asignatura.id
join curso_escolar on alumno_se_matricula_asignatura.id_curso_escolar = (select curso_escolar.id from curso_escolar ce where anyo_inicio in (2018)) group by persona.id;


