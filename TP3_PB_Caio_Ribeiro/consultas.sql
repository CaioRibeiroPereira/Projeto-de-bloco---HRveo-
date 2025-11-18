-- a) INNER JOIN: Funcionários + Cargos + Departamentos
SELECT 
    f.nome AS funcionario,
    c.nome AS cargo,
    d.nome AS departamento
FROM Funcionarios f
INNER JOIN Cargos c ON f.id_cargo = c.id_cargo
INNER JOIN Departamentos d ON f.id_departamento = d.id_departamento
ORDER BY funcionario;

-- b) LEFT JOIN: Funcionários + Benefícios
SELECT 
    f.nome AS funcionario,
    b.nome AS beneficio
FROM Funcionarios f
LEFT JOIN FuncionarioBeneficio fb ON f.id_funcionario = fb.id_funcionario
LEFT JOIN Beneficios b ON fb.id_beneficio = b.id_beneficio
ORDER BY funcionario;

-- c) RIGHT JOIN: Funcionários + Benefícios
SELECT 
    f.nome AS funcionario,
    b.nome AS beneficio
FROM Funcionarios f
RIGHT JOIN FuncionarioBeneficio fb ON f.id_funcionario = fb.id_funcionario
RIGHT JOIN Beneficios b ON fb.id_beneficio = b.id_beneficio
ORDER BY beneficio;
