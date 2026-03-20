@echo off
echo Ativando ambiente virtual...
call .venv\Scripts\activate.bat

echo Instalando dependencias Python...
pip install --upgrade pip
pip install -r requirements.txt

echo Inicializando Playwright para Robot Framework...
rfbrowser init

echo.
echo Setup concluido! Para ativar o venv manualmente:
echo   .venv\Scripts\activate.bat
echo.
echo Para rodar o robo:
echo   robot -d results tests\rpa_challenge.robot
