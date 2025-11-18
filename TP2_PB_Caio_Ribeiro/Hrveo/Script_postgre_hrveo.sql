CREATE DATABASE hrveo;

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100),
    cargo VARCHAR(50),
    departamento VARCHAR(50),
    salario DECIMAL(10,2),
    data_contratacao DATE,
    cargo_confianca BOOLEAN
);

INSERT INTO funcionarios (id_funcionario, nome, cargo, departamento, salario, data_contratacao, cargo_confianca) VALUES
(10, 'Alec do Nascimento', 'Técnico', 'Jurídico', 3000.00, '2023-03-16', FALSE),
(20, 'Arthur Assis', 'Analista', 'Jurídico', 5000.00, '2020-04-19', FALSE),
(30, 'Caio Cesar', 'Técnico', 'Financeiro', 3000.00, '2021-10-01', FALSE),
(40, 'Daniel da Silva', 'Analista', 'Financeiro', 5000.00, '2022-12-26', FALSE),
(50, 'Davi de Oliveira', 'Analista', 'TI', 5000.00, '2022-09-23', FALSE),
(60, 'Gabriel Maia', 'Técnico', 'Financeiro', 3000.00, '2023-12-19', FALSE),
(70, 'Gabriel Cavalcante', 'Analista', 'TI', 5000.00, '2020-05-09', FALSE),
(80, 'Igor Cruz', 'Técnico', 'Financeiro', 3000.00, '2024-01-14', FALSE),
(90, 'João David Castro', 'Coordenador', 'TI', 6000.00, '2024-01-07', TRUE),
(100, 'João Miguel da Silva', 'Gerente', 'Jurídico', 7500.00, '2021-05-19', TRUE),
(110, 'João Paulo de Abreu', 'CFO', 'Financeiro', 15000.00, '2021-12-21', TRUE),
(120, 'Jorge Henrique da Silva', 'Diretor', 'Financeiro', 8500.00, '2022-01-12', TRUE),
(130, 'Júlia Pereira Santos', 'Analista', 'Jurídico', 5000.00, '2020-10-03', FALSE),
(140, 'Karoline de Oliveira', 'Técnico', 'Jurídico', 3000.00, '2023-03-15', FALSE),
(150, 'Kauã Correia', 'Analista', 'Jurídico', 5000.00, '2020-09-09', FALSE),
(160, 'Kauan Torres', 'Técnico', 'TI', 3000.00, '2020-09-03', FALSE),
(170, 'Lara Pessanha', 'Analista', 'TI', 5000.00, '2021-11-01', FALSE),
(180, 'Laura Santos', 'Técnico', 'TI', 3000.00, '2022-09-01', FALSE),
(190, 'Lauro Andrade', 'CEO', 'Executivo', 30000.00, '2022-08-04', TRUE),
(200, 'Matheus da Silva', 'Analista', 'Financeiro', 5000.00, '2020-03-22', FALSE),
(210, 'Miguel Chaves', 'Técnico', 'Financeiro', 3000.00, '2022-04-06', FALSE),
(220, 'Nicollas Theodoro', 'Técnico', 'TI', 3000.00, '2022-04-11', FALSE),
(230, 'Pedro Henrique Santos', 'Técnico', 'TI', 3000.00, '2021-06-04', FALSE),
(240, 'Rayssa da Silva', 'Diretor', 'TI', 8500.00, '2021-04-07', TRUE),
(250, 'Rebeca Alves', 'Analista', 'TI', 5000.00, '2022-11-29', FALSE),
(260, 'Tábatha Tavares', 'Técnico', 'TI', 3000.00, '2021-03-21', FALSE),
(270, 'Vinicius Araujo', 'Analista', 'TI', 5000.00, '2023-08-07', FALSE),
(280, 'Yan Tavares', 'Técnico', 'TI', 3000.00, '2023-06-16', FALSE);

-- 1. Selecionar todos os funcionários que trabalham no TI.
SELECT * FROM funcionarios
WHERE departamento = 'TI';

--2. Selecionar os nomes dos funcionários que possuem um salário maior que 5000
SELECT nome, salario
FROM funcionarios
WHERE salario > 5000;

-- 3. Selecione o nome e a data de contratação dos funcionários que foram contratados após 01/01/2022.
SELECT nome, data_contratacao
FROM funcionarios
WHERE data_contratacao > '2022-01-01';

--4. Selecione o departamento e o salário médio de cada departamento.
SELECT 
    departamento, 
    ROUND(AVG(salario), 2) AS salario_medio
FROM funcionarios
GROUP BY departamento;

--5 Selecione o nome e o cargo dos funcionários que possuem "da Silva" no nome.
SELECT nome, cargo
FROM funcionarios
WHERE nome LIKE '%da Silva%';

--6. Selecione todos os funcionários que têm cargos de confiança.
SELECT *
FROM funcionarios
WHERE cargo_confianca = true;

-- 7. Selecione o nome e o departamento dos analistas.
SELECT nome, departamento
FROM funcionarios
WHERE cargo = 'Analista';

-- 8. Selecione o nome dos funcionários e seus salários ordenados de forma decrescente pelo salário.
SELECT nome, salario
FROM funcionarios
ORDER BY salario DESC;

--9. Selecione o nome e o ID dos funcionários que foram contratados no ano de 2023.
SELECT nome, id_funcionario
FROM funcionarios
WHERE EXTRACT(YEAR FROM data_contratacao) = 2023;

--10. Selecione o nome dos funcionários que trabalham no departamento Jurídico e possuem um salário menor ou igual a 3.000,00.
SELECT nome
FROM funcionarios
WHERE departamento = 'Jurídico'
  AND salario <= 3000;

-- 11.Selecione o nome dos funcionários que são Gerentes ou Diretores.
SELECT nome, cargo
FROM funcionarios
WHERE cargo IN ('Gerente', 'Diretor');

-- 12. Selecione o nome dos funcionários e os anos de experiência (considerando que estamos em 2025).
SELECT nome,
       (2025 - EXTRACT(YEAR FROM data_contratacao)) AS anos_experiencia
FROM funcionarios;

-- 13. Selecione o nome e o departamento dos funcionários, ordenados pelo nome em ordem alfabética.
SELECT nome, departamento
FROM funcionarios
ORDER BY nome ASC;

-- 14. Selecione o nome e o cargo dos funcionários cujo nome começa com 'João'.
SELECT nome, cargo
FROM funcionarios
WHERE nome LIKE 'João%';

--15. Selecione a quantidade de funcionários em cada departamento.
SELECT departamento, COUNT(*) AS quantidade_funcionarios
FROM funcionarios
GROUP BY departamento;



