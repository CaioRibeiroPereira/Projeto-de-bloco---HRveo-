import json
from sqlalchemy import create_engine, text
from dotenv import load_dotenv
import os

# Carrega variáveis de ambiente do arquivo .env
load_dotenv()

DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")

# Conexão com o banco PostgreSQL usando variáveis de ambiente
engine = create_engine(f"postgresql+psycopg2://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}")
conexao = engine.connect()

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
