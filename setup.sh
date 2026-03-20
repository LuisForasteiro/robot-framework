#!/bin/bash
echo "Ativando ambiente virtual..."
source .venv/bin/activate

echo "Instalando dependencias Python..."
pip install --upgrade pip
pip install -r requirements.txt

echo "Inicializando Playwright para Robot Framework..."
rfbrowser init

echo ""
echo "Setup concluido! Para ativar o venv manualmente:"
echo "  source .venv/bin/activate"
echo ""
echo "Para rodar o robo:"
echo "  robot -d results tests/rpa_challenge.robot"
