# Sistema de Gestão de Tarefas HRveo - Sistema de gestão de Recursos Humanos
# Desenvolvido por: Caio Ribeiro

import datetime

# Lista para armazenar as tarefas
tarefas = []
contador_id = 1  # ID único para cada tarefa


def adicionar_tarefa(descricao, prazo_final, urgencia="Normal",
                     funcionario_responsavel="Não definido", 
                     para_chefe_gestor="Não"):
    """
    Adiciona nova tarefa à lista de tarefas.

    Parâmetros:
    descricao (str): Texto descritivo da tarefa.
    prazo_final (str): Prazo final da tarefa no formato DD/MM/AAAA.
    urgencia (str): Nível de urgência da tarefa (ex: "Baixa", "Normal", "Alta"). Padrão é "Normal".
    funcionario_responsavel (str): Nome do funcionário do RH responsável pela tarefa.
    para_chefe_gestor (str): Indica se a tarefa precisa ser passada ao chefe gestor ("Sim" ou "Não").

    Returns:
    dict: A tarefa adicionada com todos os metadados.
    """
    global contador_id
    tarefa = {
        "id": contador_id,
        "descricao": descricao,
        "data_criacao": datetime.datetime.now().strftime("%d/%m/%Y %H:%M"),
        "status": "Pendente",
        "prazo_final": prazo_final,
        "urgencia": urgencia,
        "funcionario_responsavel": funcionario_responsavel,
        "para_chefe_gestor": para_chefe_gestor
    }
    tarefas.append(tarefa)
    contador_id += 1
    return tarefa


def listar_tarefas():
    """
    Lista todas as tarefas cadastradas no sistema.

    Returns:
    None
    """
    if not tarefas:
        print("\n Nenhuma tarefa cadastrada!\n")
    else:
        print("\n===== LISTA DE TAREFAS =====")
        for tarefa in tarefas:
            print(f"""
ID: {tarefa['id']}
Descrição: {tarefa['descricao']}
Data de Criação: {tarefa['data_criacao']}
Status: {tarefa['status']}
Prazo Final: {tarefa['prazo_final']}
Urgência: {tarefa['urgencia']}
Funcionário Responsável: {tarefa['funcionario_responsavel']}
Passar ao Chefe Gestor: {tarefa['para_chefe_gestor']}
-----------------------------""")
        print("============================\n")


def concluir_tarefa(id_tarefa):
    """
    Marca uma tarefa como concluída.

    Parâmetros:
    id_tarefa (int): O ID da tarefa que será marcada como concluída.

    Returns:
    bool: True se a tarefa foi concluída, False caso contrário.
    """
    for tarefa in tarefas:
        if tarefa["id"] == id_tarefa:
            tarefa["status"] = "Concluída"
            return True
    return False


def remover_tarefa(id_tarefa):
    """
    Remove uma tarefa da lista.

    Parâmetros:
    id_tarefa (int): O ID da tarefa que será removida.

    Returns:
    bool: True se a tarefa foi removida, False caso contrário.
    """
    for tarefa in tarefas:
        if tarefa["id"] == id_tarefa:
            tarefas.remove(tarefa)
            return True
    return False


def menu():
    """
    Exibe o menu principal do sistema HRveo - Gestão de Tarefas e controla as operações do usuário.

    Returns:
    None
    """
    while True:
        print("\n====== HRveo - Gestão de Tarefas do RH ======")
        print("1 - Adicionar Tarefa")
        print("2 - Listar Tarefas")
        print("3 - Marcar Tarefa como Concluída")
        print("4 - Remover Tarefa")
        print("5 - Sair")
        opcao = input("Escolha uma opção: ")

        if opcao == "1":
            descricao = input("Descrição da tarefa: ")
            prazo_final = input("Prazo final (DD/MM/AAAA): ")
            urgencia = input("Urgência (Baixa, Normal, Alta): ") or "Normal"
            funcionario_responsavel = input("Funcionário responsável: ") or "Não definido"
            para_chefe_gestor = input("Passar ao chefe gestor? (Sim/Não): ") or "Não"

            adicionar_tarefa(descricao, prazo_final, urgencia,
                             funcionario_responsavel, para_chefe_gestor)
            print("Tarefa adicionada com sucesso!")
        elif opcao == "2":
            listar_tarefas()
        elif opcao == "3":
            try:
                id_tarefa = int(input("Digite o ID da tarefa a concluir: "))
                if concluir_tarefa(id_tarefa):
                    print("Tarefa concluída com sucesso!")
                else:
                    print("Tarefa não encontrada.")
            except ValueError:
                print("Digite um ID válido.")
        elif opcao == "4":
            try:
                id_tarefa = int(input("Digite o ID da tarefa a remover: "))
                if remover_tarefa(id_tarefa):
                    print("Tarefa removida com sucesso!")
                else:
                    print("Tarefa não encontrada.")
            except ValueError:
                print(" Digite um ID válido.")
        elif opcao == "5":
            print("Saindo do sistema HRveo...")
            break
        else:
            print("Opção inválida. Tente novamente!")


# Execução do programa
menu()
