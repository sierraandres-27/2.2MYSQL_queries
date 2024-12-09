USE universidad;

select p.apellido1, p.apellido2, p.nombre from persona p where p.tipo='alumno' order by p.apellido1 asc, p.apellido2 asc, p.nombre asc;
 select p.nombre, p.apellido1, p.apellido2 from persona p where p.tipo ='Alumno' and telefono is null;
 select p.nombre from persona p where p.tipo ='alumno' and year(p.fecha_nacimiento)= 1999;
 select p.nombre from persona p where p.tipo ='profesor' and p.telefono is null and p.nif like '%k';
 select a.nombre from asignatura a where a.cuatrimestre=1 and a.curso=3 and a.id_grado=7;
 select p.nombre, p.apellido1, p.apellido2, d.nombre from persona p join profesor pr on p.id=pr.id_profesor join departamento d on pr.id_departamento =d.id order by p.apellido1 asc, p.apellido2 asc, p.nombre asc;
 select a.nombre, c.anyo_inicio, c.anyo_fin from persona p inner join alumno_se_matricula_asignatura asma on p.id=asma.id_alumno inner join curso_escolar c on asma.id_curso_escolar=c.id inner join asignatura a on asma.id_asignatura=a.id where p.tipo = 'alumno' and  p.nif='26902806M';
 select distinct d.nombre from departamento d inner join profesor p on d.id=p.id_departamento inner join asignatura a on p.id_profesor=a.id_profesor inner join grado g on a.id_grado = g.id where g.nombre ='Grado en Ingeniería Informática (Plan 2015)';
 select p.nombre from persona p inner join alumno_se_matricula_asignatura asma on p.id=asma.id_alumno inner join curso_escolar ce on asma.id_curso_escolar=ce.id where ce.anyo_inicio='2018' and ce.anyo_fin ='2019';

-- consultas left join y right join 
 select  p.nombre, p.apellido1, p.apellido2, d.nombre from persona p left join profesor pr on p.id=pr.id_profesor left join departamento d on pr.id_departamento=d.id WHERE p.tipo = 'profesor'  order by d.nombre asc, p.apellido1 asc, p.apellido2 asc, p.nombre asc;
 select  p.nombre from persona p left join profesor pr on p.id=pr.id_profesor  where p.tipo='profesor' and pr.id_departamento is null;
 select  d.nombre from departamento d left join profesor pr on d.id = pr.id_departamento where pr.id_departamento is null;
 select p.nombre from persona p left join profesor pr on p.id=pr.id_profesor left join asignatura a on pr.id_profesor=a.id_profesor where a.id_profesor is null and p.tipo ='profesor';
  select a.nombre from asignatura a left join persona p on a.id_profesor=p.id where a.id_profesor is null;
   select distinct (d.nombre) from departamento d left join profesor pr on d.id=pr.id_departamento left join asignatura a on  pr.id_profesor=a.id_profesor where a.id is null ; 

-- consultas resumen 
select count(nombre) from persona where tipo ='alumno';
select count(fecha_nacimiento) from persona where tipo = 'alumno' and fecha_nacimiento like '1999%';
 select d.nombre, count(pr.id_profesor) as total_profesores from departamento d inner join profesor pr on d.id= pr.id_departamento group by pr.id_departamento order by total_profesores desc;
 select d.nombre, count(pr.id_profesor) as total_profesores from departamento d left join profesor pr on d.id= pr.id_departamento group by d.id order by total_profesores desc;
 select g.nombre, count(a.id) as total_asignaturas from grado g left join asignatura a on g.id=a.id_grado group by g.id order by total_asignaturas desc; 
 select g.nombre, count(a.id) as total_asignaturas from grado g left join asignatura a on g.id=a.id_grado  group by g.id having total_asignaturas >40 order by total_asignaturas desc;
 select g.nombre, a.tipo, SUM(a.creditos) as total_creditos from grado g inner join asignatura a on g.id = a.id_grado group by g.nombre,  a.tipo;
select ce.anyo_inicio, count(asma.id_alumno ) as total_alumnos from curso_escolar ce inner join alumno_se_matricula_asignatura asma on ce.id=asma.id_curso_escolar group by ce.anyo_inicio;
select p.id, p.nombre, p.apellido1, p.apellido2, count(a.id)as total_asignaturas from persona p left join asignatura a on p.id=a.id_profesor group by p.id order by total_asignaturas desc;
select * from persona where tipo = 'alumno' order by fecha_nacimiento desc limit 1;

