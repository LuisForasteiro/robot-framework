*** Settings ***
Documentation       Suite para execucao paralela — 10 instancias simultaneas do RPA Challenge.
...                 Cada test case abre seu proprio browser de forma independente.

Library             Browser
Resource            ../resources/keywords.resource

Test Setup          Abrir Site RPA Challenge
Test Teardown       Close Browser

*** Test Cases ***
RPA Challenge Run 01
    [Template]    Executar Challenge Completo
    Run 01

RPA Challenge Run 02
    [Template]    Executar Challenge Completo
    Run 02

RPA Challenge Run 03
    [Template]    Executar Challenge Completo
    Run 03

RPA Challenge Run 04
    [Template]    Executar Challenge Completo
    Run 04

RPA Challenge Run 05
    [Template]    Executar Challenge Completo
    Run 05

RPA Challenge Run 06
    [Template]    Executar Challenge Completo
    Run 06

RPA Challenge Run 07
    [Template]    Executar Challenge Completo
    Run 07

RPA Challenge Run 08
    [Template]    Executar Challenge Completo
    Run 08

RPA Challenge Run 09
    [Template]    Executar Challenge Completo
    Run 09

RPA Challenge Run 10
    [Template]    Executar Challenge Completo
    Run 10

*** Keywords ***
Executar Challenge Completo
    [Arguments]    ${run_id}
    [Documentation]    Executa o ciclo completo do RPA Challenge para um run especifico.
    ${pessoas}=    Ler Dados Da Planilha
    Iniciar Desafio
    FOR    ${pessoa}    IN    @{pessoas}
        Preencher Formulario    ${pessoa}
        Submeter Formulario
    END
    ${score}=    Capturar Resultado Final
    Log    [${run_id}] Score: ${score}    console=True
