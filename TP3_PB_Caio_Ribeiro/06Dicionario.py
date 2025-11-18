from sqlalchemy import create_engine, text

# Conexão com o banco PostgreSQL
engine = create_engine("postgresql+psycopg2://postgres:Estudo.24043@localhost:5432/hrveo")
conexao = engine.connect()

consultas_sql = {
    "INNER JOIN": text("""
        SELECT f.id_folha, func.nome AS funcionario, c.nome AS cargo, d.nome AS departamento, f.salario_liquido
        FROM FolhaPagamento f
        INNER JOIN Funcionarios func ON f.id_funcionario = func.id_funcionario
        INNER JOIN Cargos c ON func.id_cargo = c.id_cargo
        INNER JOIN Departamentos d ON func.id_departamento = d.id_departamento;
    """),

    "LEFT JOIN": text("""
        SELECT func.nome AS funcionario, b.nome AS beneficio
        FROM Funcionarios func
        LEFT JOIN FuncionarioBeneficio fb ON func.id_funcionario = fb.id_funcionario
        LEFT JOIN Beneficios b ON fb.id_beneficio = b.id_beneficio;
    """),

    "RIGHT JOIN": text("""
        SELECT b.nome AS beneficio, func.nome AS funcionario
        FROM Funcionarios func
        RIGHT JOIN FuncionarioBeneficio fb ON func.id_funcionario = fb.id_funcionario
        RIGHT JOIN Beneficios b ON fb.id_beneficio = b.id_beneficio;
    """)
}

# Converte resultados em dicionários
def popular_dicionario(nome_consulta, query):
    resultado = conexao.execute(query)
    colunas = resultado.keys()
    lista_dados = [dict(zip(colunas, linha)) for linha in resultado]
    return {nome_consulta: lista_dados}

# Dicionário que armazenar tudo
dicionarios_resultado = {}

# Executa cada consulta e armazena
for nome, query in consultas_sql.items():
    dicionario = popular_dicionario(nome, query)
    dicionarios_resultado.update(dicionario)

# Exibe o conteúdo 
for nome, dados in dicionarios_resultado.items():
    print(f"\nRESULTADO {nome}")
    for linha in dados:
        print(linha)

conexao.close()
