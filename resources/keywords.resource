*** Settings ***
Library     Browser                             # Playwright via robotframework-browser
Library     openpyxl                            # Leitura do Excel
Library     OperatingSystem
Library     Collections
Resource    locators.resource

*** Variables ***
# Caminho para a planilha baixada manualmente pelo usuario
${EXCEL_PATH}       ${CURDIR}/../data/challenge.xlsx
# Timeout padrao para elementos dinamicos (o formulario recarrega apos cada Submit)
${TIMEOUT}          10s

*** Keywords ***
Abrir Site RPA Challenge
    # Abre o Chromium em modo nao-headless para acompanhar visualmente a execucao
    New Browser    chromium    headless=False
    New Page       ${URL}
    # Aguarda o botao Start estar visivel para garantir que a pagina carregou
    Wait For Elements State    ${BTN_START}    visible    timeout=${TIMEOUT}
    Log    Pagina carregada: ${URL}

Ler Dados Da Planilha
    # Le o arquivo Excel usando openpyxl e retorna uma lista de dicionarios.
    # Cada dicionario representa uma pessoa com as chaves sendo os nomes das colunas.
    [Return]    ${data}
    ${workbook}=    Evaluate    __import__('openpyxl').load_workbook('${EXCEL_PATH}')    modules=openpyxl
    ${sheet}=       Evaluate    $workbook.active
    # Extrai os cabecalhos da primeira linha
    ${headers}=     Evaluate    [cell.value for cell in list($sheet.iter_rows())[0]]
    # Monta lista de dicionarios para cada linha de dados (pulando o cabecalho)
    ${data}=        Evaluate
    ...    [dict(zip(${headers}, [c.value for c in row])) for row in list($sheet.iter_rows(min_row=2)) if any(c.value for c in row)]

Iniciar Desafio
    # Clica no botao Start para comecar o desafio e aguarda o formulario aparecer
    Click    ${BTN_START}
    Wait For Elements State    ${INPUT_FIRST_NAME}    visible    timeout=${TIMEOUT}
    Log    Desafio iniciado — formulario visivel

Preencher Formulario
    # Recebe um dicionario com os dados de uma pessoa e preenche cada campo.
    # Os locators usam ng-reflect-name, entao funcionam independente do embaralhamento.
    [Arguments]    ${pessoa}
    Fill Text    ${INPUT_FIRST_NAME}     ${pessoa}[First Name]
    Fill Text    ${INPUT_LAST_NAME}      ${pessoa}[Last Name]
    Fill Text    ${INPUT_COMPANY_NAME}   ${pessoa}[Company Name]
    Fill Text    ${INPUT_ROLE}           ${pessoa}[Role in Company]
    Fill Text    ${INPUT_ADDRESS}        ${pessoa}[Address]
    Fill Text    ${INPUT_PHONE}          ${pessoa}[Phone Number]
    Fill Text    ${INPUT_EMAIL}          ${pessoa}[Email]
    Log    Formulario preenchido para: ${pessoa}[First Name] ${pessoa}[Last Name]

Submeter Formulario
    # Clica em Submit e aguarda o formulario recarregar para o proximo round.
    # O site recarrega os campos (embaralhados novamente) antes do proximo round.
    Click    ${BTN_SUBMIT}
    # Pequena pausa para o Angular processar e re-renderizar os campos
    Sleep    0.5s

Capturar Resultado Final
    # Aguarda o elemento de resultado aparecer e loga o score obtido
    Wait For Elements State    ${DIV_RESULT}    visible    timeout=${TIMEOUT}
    ${resultado}=    Get Text    ${DIV_RESULT}
    Log    RESULTADO FINAL: ${resultado}    console=True
    [Return]    ${resultado}
