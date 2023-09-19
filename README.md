# Desafio coleta e transformacao

## Introdução

Projeto para fazer coleta e transformação utilizando SQL e Power BI. O banco de dados está hospedado na Azure.

## Diretrizes para transformação

1. Verifique os cabeçalhos e tipos de dados

2. Modifique os valores monetários para o tipo double preciso

3. Verifique a existência dos nulos e analise a remoção

4. Os employees com nulos em Super_ssn podem ser os gerentes. Verifique se há algum colaborador sem gerente

5. Verifique se há algum departamento sem gerente

6. Se houver departamento sem gerente, suponha que você possui os dados e preencha as lacunas

7. Verifique o número de horas dos projetos

8. Separar colunas complexas

9. Mesclar consultas employee e departament para criar uma tabela employee com o nome dos departamentos associados aos colaboradores. A mescla terá como base a tabela employee. Fique atento, essa informação influencia no tipo de junção

10. Neste processo elimine as colunas desnecessárias.

11. Realize a junção dos colaboradores e respectivos nomes dos gerentes . Isso pode ser feito com consulta SQL ou pela mescla de tabelas com Power BI. Caso utilize SQL, especifique no README a query utilizada no processo.

12. Mescle as colunas de Nome e Sobrenome para ter apenas uma coluna definindo os nomes dos colaboradores

13. Mescle os nomes de departamentos e localização. Isso fará que cada combinação departamento-local seja único. Isso irá auxiliar na criação do modelo estrela em um módulo futuro.

14. Explique por que, neste caso supracitado, podemos apenas utilizar o mesclar e não o atribuir.

15. Agrupe os dados a fim de saber quantos colaboradores existem por gerente

16. Elimine as colunas desnecessárias, que não serão usadas no relatório, de cada tabela

A maior parte dessas diretrizes (9, 11, 12) foram implementadas em SQL utilizando *views*.
A *view* a seguir muda as denominações das colunas, mescla *employee* com *gerente* e *departamento*:
~~~sql
create view employee_extended as select e.Ssn, e.Fname as Nome, e.Lname as Sobrenome, concat(e.Fname, ' ', e.Lname) as 'Nome completo', 
e.Bdate as Nascimento, e.Address as Enderecp, e.Sex as Genero, e.Salary as Salario, e2.Fname as Gerente, d.Dname as Departamento
from employee e, employee e2, departament d
where e.Super_ssn = e2.Ssn and e.Dno = d.Dnumber
~~~

Esta outra realiza uma agregação totalizando a quantidade de colaboradores por cada gerente:
~~~sql
create view employeebymanager as select a.ssn, a.fname as Nome, count(*) as Empregados from employee as a, employee as b
where b.Super_ssn = a.Ssn group by 1, 2;
~~~

As demais transformações foram realizadas no Power BI conforme arquivo no diretório *arquivo pbix*