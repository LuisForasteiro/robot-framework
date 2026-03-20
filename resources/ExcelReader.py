"""Biblioteca Python para leitura da planilha do RPA Challenge."""
import openpyxl


def read_challenge_data(excel_path: str) -> list[dict]:
    """
    Le a planilha challenge.xlsx e retorna lista de dicionarios.
    - Strip em espacos dos cabecalhos
    - Converte todos os valores para string
    - Ignora linhas completamente vazias
    - Retorna apenas as 10 primeiras linhas validas (os 10 rounds do desafio)
    """
    wb = openpyxl.load_workbook(excel_path)
    ws = wb.active

    rows = list(ws.iter_rows(values_only=True))
    # Limpa os cabecalhos (remove espacos e valores None)
    headers = [str(h).strip() for h in rows[0] if h is not None]

    data = []
    for row in rows[1:]:
        values = row[:len(headers)]
        # Pula linhas completamente vazias
        if not any(v is not None for v in values):
            continue
        # Monta o dicionario convertendo tudo para string
        person = {headers[i]: str(values[i]).strip() if values[i] is not None else ""
                  for i in range(len(headers))}
        data.append(person)
        if len(data) == 10:
            break

    return data
