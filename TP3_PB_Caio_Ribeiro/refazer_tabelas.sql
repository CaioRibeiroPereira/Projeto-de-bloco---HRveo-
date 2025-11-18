-- APAGUEI TUDO PARA REESTRUTURAR AS TABELAS
DROP TABLE IF EXISTS HistoricoCargos, Ponto, Ferias, FolhaPagamento, FuncionarioBeneficio, Beneficios, Funcionarios, Cargos, Departamentos CASCADE;


-- TABELA DEPARTAMENTOS
CREATE TABLE Departamentos (
    id_departamento SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

INSERT INTO Departamentos (nome, descricao) VALUES
('Jurídico', 'Gestão de processos e assuntos legais'),
('Financeiro', 'Controle financeiro e orçamentário'),
('TI', 'Tecnologia da Informação e suporte técnico'),
('Executivo', 'Gestão estratégica e diretoria');


-- TABELA CARGOS
CREATE TABLE Cargos (
    id_cargo SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    salario_base DECIMAL(10,2) NOT NULL,
    nivel VARCHAR(50)
);

INSERT INTO Cargos (nome, salario_base, nivel) VALUES
('Técnico', 3000.00, 'Júnior'),
('Analista', 5000.00, 'Pleno'),
('Coordenador', 6000.00, 'Pleno'),
('Gerente', 7500.00, 'Sênior'),
('Diretor', 8500.00, 'Executivo'),
('CFO', 15000.00, 'Executivo'),
('CEO', 30000.00, 'Executivo');


-- TABELA FUNCIONÁRIOS
CREATE TABLE Funcionarios (
    id_funcionario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    id_cargo INT NOT NULL,
    id_departamento INT NOT NULL,
    salario DECIMAL(10,2) NOT NULL,
    data_contratacao DATE NOT NULL,
    cargo_confianca BOOLEAN DEFAULT FALSE,
    CONSTRAINT fk_funcionario_cargo FOREIGN KEY (id_cargo)
        REFERENCES Cargos (id_cargo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    CONSTRAINT fk_funcionario_departamento FOREIGN KEY (id_departamento)
        REFERENCES Departamentos (id_departamento)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

-- INSERÇÃO DE FUNCIONÁRIOS
INSERT INTO Funcionarios (nome, id_cargo, id_departamento, salario, data_contratacao, cargo_confianca) VALUES
('João Silva', 1, 3, 3000.00, '2023-03-16', FALSE),
('Maria Oliveira', 2, 2, 5000.00, '2019-04-19', FALSE),
('Pedro Santos', 1, 3, 3000.00, '2022-01-01', FALSE),
('Ana Souza', 3, 1, 6000.00, '2020-01-01', TRUE),
('Lucas Lima', 4, 2, 7500.00, '2021-05-01', TRUE),
('Fernanda Costa', 5, 4, 8500.00, '2020-06-15', TRUE),
('Ricardo Alves', 6, 2, 15000.00, '2021-12-21', TRUE),
('Beatriz Martins', 7, 4, 30000.00, '2022-08-04', TRUE);


-- TABELA BENEFÍCIOS
CREATE TABLE Beneficios (
    id_beneficio SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT
);

INSERT INTO Beneficios (nome, descricao) VALUES
('Vale Transporte', 'Auxílio deslocamento casa-trabalho'),
('Vale Refeição', 'Auxílio alimentação diária'),
('Plano de Saúde', 'Assistência médica particular'),
('Auxílio Creche', 'Ajuda de custo para pais com filhos pequenos');


-- TABELA FUNCIONARIO_BENEFICIO (N:N)
CREATE TABLE FuncionarioBeneficio (
    id_funcionario INT NOT NULL,
    id_beneficio INT NOT NULL,
    PRIMARY KEY (id_funcionario, id_beneficio),
    CONSTRAINT fk_fb_funcionario FOREIGN KEY (id_funcionario)
        REFERENCES Funcionarios (id_funcionario)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_fb_beneficio FOREIGN KEY (id_beneficio)
        REFERENCES Beneficios (id_beneficio)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO FuncionarioBeneficio (id_funcionario, id_beneficio) VALUES
(1, 1), (1, 2), (2, 2), (2, 3),
(3, 1), (3, 3), (4, 2), (4, 4),
(5, 3), (6, 2), (7, 3), (8, 3);


-- TABELA FOLHA DE PAGAMENTO
CREATE TABLE FolhaPagamento (
    id_folha SERIAL PRIMARY KEY,
    id_funcionario INT REFERENCES Funcionarios(id_funcionario),
    mes INT CHECK (mes BETWEEN 1 AND 12),
    ano INT,
    salario_bruto DECIMAL(10,2),
    descontos DECIMAL(10,2),
    salario_liquido DECIMAL(10,2),
    data_pagamento DATE
);

INSERT INTO FolhaPagamento (id_funcionario, mes, ano, salario_bruto, descontos, salario_liquido, data_pagamento)
VALUES
(1, 10, 2025, 3000.00, 200.00, 2800.00, '2025-10-30'),
(2, 10, 2025, 5000.00, 400.00, 4600.00, '2025-10-30'),
(3, 10, 2025, 3000.00, 250.00, 2750.00, '2025-10-30'),
(4, 10, 2025, 6000.00, 500.00, 5500.00, '2025-10-30'),
(7, 10, 2025, 15000.00, 1500.00, 13500.00, '2025-10-30'),
(8, 10, 2025, 30000.00, 3000.00, 27000.00, '2025-10-30');


-- TABELA FÉRIAS
CREATE TABLE Ferias (
    id_ferias SERIAL PRIMARY KEY,
    id_funcionario INT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    status VARCHAR(20),
    CONSTRAINT fk_ferias_funcionario FOREIGN KEY (id_funcionario)
        REFERENCES Funcionarios (id_funcionario)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Ferias (id_funcionario, data_inicio, data_fim, status)
VALUES
(2, '2025-01-10', '2025-02-09', 'Concluídas'),
(4, '2025-02-01', '2025-02-28', 'Concluídas'),
(5, '2025-06-15', '2025-07-15', 'Agendada'),
(6, '2025-11-01', '2025-11-30', 'Em andamento');


-- TABELA PONTO
CREATE TABLE Ponto (
    id_ponto SERIAL PRIMARY KEY,
    id_funcionario INT NOT NULL,
    data DATE,
    hora_entrada TIME,
    hora_saida TIME,
    horas_trabalhadas DECIMAL(5,2),
    CONSTRAINT fk_ponto_funcionario FOREIGN KEY (id_funcionario)
        REFERENCES Funcionarios (id_funcionario)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

INSERT INTO Ponto (id_funcionario, data, hora_entrada, hora_saida, horas_trabalhadas)
VALUES
(1, '2025-10-30', '08:00', '17:00', 8.0),
(1, '2025-10-31', '08:10', '17:05', 7.9),
(2, '2025-10-30', '09:00', '18:00', 8.0),
(3, '2025-10-30', '08:30', '17:00', 7.5),
(4, '2025-10-31', '08:00', '17:00', 8.0),
(5, '2025-10-31', '07:45', '16:45', 8.0),
(6, '2025-10-31', '08:00', '17:00', 8.0),
(7, '2025-10-31', '08:00', '17:30', 8.5),
(8, '2025-10-31', '09:00', '18:00', 8.0);


-- TABELA HISTÓRICO DE CARGOS
CREATE TABLE HistoricoCargos (
    id_historico SERIAL PRIMARY KEY,
    id_funcionario INT NOT NULL,
    id_cargo INT NOT NULL,
    data_inicio DATE,
    data_fim DATE,
    CONSTRAINT fk_historico_funcionario FOREIGN KEY (id_funcionario)
        REFERENCES Funcionarios (id_funcionario)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_historico_cargo FOREIGN KEY (id_cargo)
        REFERENCES Cargos (id_cargo)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

INSERT INTO HistoricoCargos (id_funcionario, id_cargo, data_inicio, data_fim)
VALUES
(1, 1, '2023-03-16', NULL),
(2, 1, '2019-04-19', '2020-04-18'),
(2, 2, '2020-04-19', NULL),
(4, 3, '2022-01-01', NULL),
(5, 4, '2021-05-01', NULL),
(6, 5, '2021-12-21', NULL),
(7, 6, '2021-12-21', NULL),
(8, 7, '2022-08-04', NULL);


