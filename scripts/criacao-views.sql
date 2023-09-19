use azure_company;

create view employeebymanager as select a.ssn, a.fname as Nome, count(*) as Empregados from employee as a, employee as b
where b.Super_ssn = a.Ssn group by 1, 2;

create view employee_extended as select e.Ssn, e.Fname as Nome, e.Lname as Sobrenome, concat(e.Fname, ' ', e.Lname) as 'Nome completo', 
e.Bdate as Nascimento, e.Address as Enderecp, e.Sex as Genero, e.Salary as Salario, e2.Fname as Gerente, d.Dname as Departamento
from employee e, employee e2, departament d
where e.Super_ssn = e2.Ssn and e.Dno = d.Dnumber 

select * from employee_extended;