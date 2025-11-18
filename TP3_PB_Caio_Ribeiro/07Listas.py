from sqlalchemy import create_engine, text
from tabulate import tabulate

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

# Converte resultados em listas e executa
def popular_lista(nome_consulta, query):
    resultado = conexao.execute(query)
    colunas = resultado.keys()
    lista_dados = [list(linha) for linha in resultado]  # converte aqui cada linha em lista
    return (nome_consulta, colunas, lista_dados)

# Lista principal 
listas_resultado = []

# Faz cada consulta e coloca na lista principal
for nome, query in consultas_sql.items():
    nome_consulta, colunas, dados = popular_lista(nome, query)
    listas_resultado.append((nome_consulta, colunas, dados))

# Exibe o conteúdo das listas .OBS:O uso do tabulate foi só para melhorar a visualização,
for nome_consulta, colunas, dados in listas_resultado:
    print(f"RESULTADO: {nome_consulta}")
   
    
    if dados:
        print(tabulate(dados, headers=colunas, tablefmt="fancy_grid", showindex=True))
    else:
        print("Nenhum dado foi  encontrado para essa consulta.")
    

conexao.close()
