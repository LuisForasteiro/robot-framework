*** Settings ***
Documentation       Suite principal para resolver o RPA Challenge em rpachallenge.com.
...                 O desafio consiste em preencher um formulario com campos embaralhados
...                 a cada round, usando dados de uma planilha Excel (10 rounds no total).

Library             Browser
Resource            ../resources/keywords.resource

Suite Setup         Abrir Site RPA Challenge
Suite Teardown      Close Browser

*** Test Cases ***
Resolver RPA Challenge
    [Documentation]    Le a planilha Excel, inicia o desafio e preenche o formulario
    ...                para cada pessoa nos 10 rounds, depois captura o score final.
    [Teardown]         Run Keyword If Test Failed    Take Screenshot

    # Passo 1: ler os dados da planilha antes de comecar
    ${pessoas}=    Ler Dados Da Planilha

    # Passo 2: clicar em Start para iniciar o cronometro do desafio
    Iniciar Desafio

    # Passo 3: para cada pessoa na planilha, preencher e submeter o formulario
    FOR    ${pessoa}    IN    @{pessoas}
        Preencher Formulario    ${pessoa}
        Submeter Formulario
    END

    # Passo 4: capturar e logar o resultado final exibido pelo site
    ${score}=    Capturar Resultado Final
    Log    Score obtido: ${score}    console=True
