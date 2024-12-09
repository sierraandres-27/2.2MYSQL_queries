USE universidad;


# 1.Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.

select p.apellido1, p.apellido2, p.nombre from persona p where p.tipo='alumno' order by p.apellido1 asc, p.apellido2 asc, p.nombre asc;
# 2.Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.

 select p.nombre, p.apellido1, p.apellido2 from persona p where p.tipo ='Alumno' and telefono is null;
# 3.Retorna el llistat dels alumnes que van néixer en 1999.

 select p.nombre from persona p where p.tipo ='alumno' and year(p.fecha_nacimiento)= 1999;
# 4.Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.

 select p.nombre from persona p where p.tipo ='profesor' and p.telefono is null and p.nif like '%k';
# 5.Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.

 select a.nombre from asignatura a where a.cuatrimestre=1 and a.curso=3 and a.id_grado=7;
 
# 6.Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom,

 select p.nombre, p.apellido1, p.apellido2, d.nombre from persona p join profesor pr on p.id=pr.id_profesor join departamento d on pr.id_departamento =d.id order by p.apellido1 asc, p.apellido2 asc, p.nombre asc;
# 7.Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.

 select a.nombre, c.anyo_inicio, c.anyo_fin from persona p inner join alumno_se_matricula_asignatura asma on p.id=asma.id_alumno inner join curso_escolar c on asma.id_curso_escolar=c.id inner join asignatura a on asma.id_asignatura=a.id where p.tipo = 'alumno' and  p.nif='26902806M';
# 8.Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

 select distinct d.nombre from departamento d inner join profesor p on d.id=p.id_departamento inner join asignatura a on p.id_profesor=a.id_profesor inner join grado g on a.id_grado = g.id where g.nombre ='Grado en Ingeniería Informática (Plan 2015)';
# 9.Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.

 select p.nombre from persona p inner join alumno_se_matricula_asignatura asma on p.id=asma.id_alumno inner join curso_escolar ce on asma.id_curso_escolar=ce.id where ce.anyo_inicio='2018' and ce.anyo_fin ='2019';

-- consultas left join y right join 

# 1.Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat.

 select  p.nombre, p.apellido1, p.apellido2, d.nombre from persona p left join profesor pr on p.id=pr.id_profesor left join departamento d on pr.id_departamento=d.id WHERE p.tipo = 'profesor'  order by d.nombre asc, p.apellido1 asc, p.apellido2 asc, p.nombre asc;
# 2.Retorna un llistat amb els professors/es que no estan associats a un departament.

 select  p.nombre from persona p left join profesor pr on p.id=pr.id_profesor  where p.tipo='profesor' and pr.id_departamento is null;
# 3.Retorna un llistat amb els departaments que no tenen professors/es associats.

 select  d.nombre from departamento d left join profesor pr on d.id = pr.id_departamento where pr.id_departamento is null;
# 4.Retorna un llistat amb els professors/es que no imparteixen cap assignatura.

 select p.nombre from persona p left join profesor pr on p.id=pr.id_profesor left join asignatura a on pr.id_profesor=a.id_profesor where a.id_profesor is null and p.tipo ='profesor';
# 5.Retorna un llistat amb les assignatures que no tenen un professor/a assignat.

  select a.nombre from asignatura a left join persona p on a.id_profesor=p.id where a.id_profesor is null;
# 6.Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

   select distinct (d.nombre) from departamento d left join profesor pr on d.id=pr.id_departamento left join asignatura a on  pr.id_profesor=a.id_profesor where a.id is null ; 

-- consultas resumen 
# 1.Retorna el nombre total d'alumnes que hi ha.
select count(nombre) from persona where tipo ='alumno';
# 2.Calcula quants alumnes van néixer en 1999.

select count(fecha_nacimiento) from persona where tipo = 'alumno' and fecha_nacimiento like '1999%';
# 3.Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que

 select d.nombre, count(pr.id_profesor) as total_profesores from departamento d inner join profesor pr on d.id= pr.id_departamento group by pr.id_departamento order by total_profesores desc;
# 4.Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats.

 select d.nombre, count(pr.id_profesor) as total_profesores from departamento d left join profesor pr on d.id= pr.id_departamento group by d.id order by total_profesores desc;
# 5.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen

 select g.nombre, count(a.id) as total_asignaturas from grado g left join asignatura a on g.id=a.id_grado group by g.id order by total_asignaturas desc; 
# 6.Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.

 select g.nombre, count(a.id) as total_asignaturas from grado g left join asignatura a on g.id=a.id_grado  group by g.id having total_asignaturas >40 order by total_asignaturas desc;
# 7.Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau,

 select g.nombre, a.tipo, SUM(a.creditos) as total_creditos from grado g inner join asignatura a on g.id = a.id_grado group by g.nombre,  a.tipo;
# 8.Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb

select ce.anyo_inicio, count(asma.id_alumno ) as total_alumnos from curso_escolar ce inner join alumno_se_matricula_asignatura asma on ce.id=asma.id_curso_escolar group by ce.anyo_inicio;
# 9.Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura.

select p.id, p.nombre, p.apellido1, p.apellido2, count(a.id)as total_asignaturas from persona p left join asignatura a on p.id=a.id_profesor group by p.id order by total_asignaturas desc;
# 10.Retorna totes les dades de l'alumne/a més jove.

select * from persona where tipo = 'alumno' order by fecha_nacimiento desc limit 1;

# 11.Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.

    SELECT p.*, pr.id_departamento, pr.id_profesor, a.id_profesor FROM persona p INNER JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = 'profesor' AND a.id_profesor IS NULL;
