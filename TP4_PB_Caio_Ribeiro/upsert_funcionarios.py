import pandas as pd
from sqlalchemy import create_engine, text

# Conexão com o PostgreSQL
engine = create_engine("postgresql+psycopg2://postgres:Estudo.24043@localhost:5432/hrveo")

# Caminho do JSON
caminho_json = r"C:\Users\ribei\Desktop\Projeto de bloco_dados\TP4_PB_Caio_Ribeiro\upsert_funcionarios.json"

# Leitura do JSON
df = pd.read_json(caminho_json)


# UPSERT (INSERT + UPDATE)
tabela = "funcionarios"
pk = "id_funcionario"

colunas = list(df.columns)
cols_str = ", ".join(colunas)
vals_str = ", ".join([f":{c}" for c in colunas])
set_str = ", ".join([f"{c}=EXCLUDED.{c}" for c in colunas if c != pk])

sql_upsert = text(f"""
    INSERT INTO {tabela} ({cols_str})
    VALUES ({vals_str})
    ON CONFLICT ({pk})
    DO UPDATE SET
        {set_str};
""")

with engine.begin() as conn:
    conn.execute(sql_upsert, df.to_dict(orient="records"))

print("UPSERT realizado com sucesso!")
