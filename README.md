
# 📘 HRveo — Sistema de Gestão de Recursos Humanos

Sistema acadêmico desenvolvido para integrar conceitos de **Python**, **PostgreSQL**, **engenharia de dados**, **consultas SQL**, **modelagem de banco**, **automatização**, e **tratamento de dados**.
O projeto evolui em etapas (TP1, TP2 e TP3), cada uma adicionando funcionalidades essenciais de um sistema real de RH.

---

## 📌 Sumário

* [Sobre o Projeto](#sobre-o-projeto)
* [Funcionalidades](#funcionalidades)
* [Arquitetura por Etapas](#arquitetura-por-etapas)
* [Tecnologias Utilizadas](#tecnologias-utilizadas)
* [Estrutura do Banco de Dados](#estrutura-do-banco-de-dados)
* [Consultas SQL Desenvolvidas](#consultas-sql-desenvolvidas)
* [Código Python (TP3)](#código-python-tp3)
* [Como Executar](#como-executar)
* [Melhorias Futuras](#melhorias-futuras)

---

# 🚀 Sobre o Projeto

O **HRveo** é um sistema modular de RH que simula processos reais:

* Cadastro de funcionários
* Alocação de cargos e departamentos
* Benefícios
* Folha de pagamento
* Registro de ponto
* Histórico de cargos
* Consultas avançadas com *JOINs*
* Exibição estruturada de resultados
* Modelagem lógica detalhada do banco

Ele foi criado aplicando práticas reais de banco de dados e manipulação de dados com Python.

---

# 🧩 Funcionalidades

### ✔️ TP1 – Estruturas de dados em Python

* Dicionários para armazenar funcionários, salários, cargos etc.
* Simulação de folha de pagamento
* Operações CRUD simples em memória

### ✔️ TP2 – Entrada e saída de dados

* Exportação de dados estruturados
* Serialização para JSON
* Importação formatada
* Relatórios em terminal

### ✔️ TP3 – Banco de dados relacional + Python

* Diagrama lógico completo do banco
* Criação de todas as tabelas com constraints
* Inserção de dados completos
* Execução de **INNER JOIN**, **LEFT JOIN**, **RIGHT JOIN**
* Geração de tabelas formatadas com `tabulate`
* Conversão de resultados para dicionários e listas
* Automação de consultas

---

# 🛠 Tecnologias Utilizadas

| Tecnologia           | Utilidade                         |
| -------------------- | --------------------------------- |
| **Python 3**         | Lógica e integração com o banco   |
| **PostgreSQL 15+**   | Banco relacional                  |
| **SQLAlchemy**       | Conexão e execução de consultas   |
| **Tabulate**         | Formatação de tabelas no terminal |
| **psycopg2**         | Driver PostgreSQL                 |
| **Modelo lógico ER** | Representação das entidades       |

---

# 🧱 Estrutura do Banco de Dados

O projeto constrói **9 tabelas relacionais**:

* `Departamentos`
* `Cargos`
* `Funcionarios`
* `Beneficios`
* `FuncionarioBeneficio` (N:N)
* `FolhaPagamento`
* `Ferias`
* `Ponto`
* `HistoricoCargos`

---

# 🔍 Consultas SQL Desenvolvidas

### 1. **INNER JOIN**

Funcionários + Cargos + Departamentos

### 2. **LEFT JOIN**

Funcionários com ou sem benefícios

### 3. **RIGHT JOIN**

Benefícios considerando funcionários que recebem ou não

Todas as consultas estão automatizadas em Python usando dicionários e listas.

---

# 🐍 Código Python (TP3)

O script:

✔ Conecta ao PostgreSQL
✔ Executa múltiplas consultas SQL
✔ Converte dados para listas ou dicionários
✔ Imprime tabelas formatadas no terminal

Inclui:

```python
engine = create_engine("postgresql+psycopg2://postgres:senha@localhost:5432/hrveo")
conexao = engine.connect()

consultas_sql = {
    "INNER JOIN": text(""" ... """),
    "LEFT JOIN": text(""" ... """),
    "RIGHT JOIN": text(""" ... """)
}
```

E também uma segunda versão com **tabulate** para visualização profissional no terminal.

---

# ▶️ Como Executar

### 1. Instale os pacotes necessários

```bash
pip install sqlalchemy psycopg2 tabulate
```

### 2. Crie o banco PostgreSQL

```sql
CREATE DATABASE hrveo;
```

### 3. Execute o script SQL do TP3 para criar todas as tabelas

### 4. Rode o script Python

```bash
python hrveo_consultas.py
```



