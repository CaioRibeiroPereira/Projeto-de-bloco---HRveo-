import json
from sqlalchemy import create_engine, text

# Conexão com o PostgreSQL
engine = create_engine("postgresql+psycopg2://postgres:Estudo.24043@localhost:5432/hrveo")

# Caminho do JSON 
caminho_json = r"C:\Users\ribei\Desktop\Projeto de bloco_dados\TP4_PB_Caio_Ribeiro\delete_funcionarios.json"

# Leitura dos IDs para excluir
with open(caminho_json, "r", encoding="utf-8") as f:
    data = json.load(f)

ids_para_deletar = data.get("ids_funcionarios", [])

if not ids_para_deletar:
    print("Nenhum ID encontrado no arquivo JSON.")
    exit()

# SQL da deleção em duas etapas. Pq a tabela folha depende da tabela funcionários.E não quis colocar cascade na FK, fiz dessa forma para treinar.
sql_delete_folha = text("""
    DELETE FROM folhapagamento
    WHERE id_funcionario = ANY(:ids);
""")

sql_delete_funcionario = text("""
    DELETE FROM funcionarios
    WHERE id_funcionario = ANY(:ids);
""")

with engine.begin() as conn:
    print("1-Removendo registros dependentes da tabela folhapagamento...")
    conn.execute(sql_delete_folha, {"ids": ids_para_deletar})

    print("2-Removendo funcionários da tabela funcionarios...")
    conn.execute(sql_delete_funcionario, {"ids": ids_para_deletar})

print("Deleção massiva concluída com sucesso!")
