*** Variables ***
# URL do site alvo
${URL}                      https://rpachallenge.com/

# Botoes da pagina principal
${BTN_START}                button.uiColorButton
${BTN_SUBMIT}               input[type="submit"][value="Submit"]

# Link de download da planilha
${LINK_DOWNLOAD}            a.uiColorPrimary

# Campos do formulario localizados pelo atributo ng-reflect-name
# Este atributo e gerado pelo Angular e identifica cada campo semanticamente,
# independente da posicao visual — por isso o robo funciona mesmo com campos embaralhados
${INPUT_FIRST_NAME}         [ng-reflect-name="labelFirstName"]
${INPUT_LAST_NAME}          [ng-reflect-name="labelLastName"]
${INPUT_COMPANY_NAME}       [ng-reflect-name="labelCompanyName"]
${INPUT_ROLE}               [ng-reflect-name="labelRole"]
${INPUT_ADDRESS}            [ng-reflect-name="labelAddress"]
${INPUT_PHONE}              [ng-reflect-name="labelPhone"]
${INPUT_EMAIL}              [ng-reflect-name="labelEmail"]

# Elemento que exibe o resultado final apos completar os 10 rounds
${DIV_RESULT}               div.congratulations div.message2
