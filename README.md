# RPA Challenge — Robot Framework + Playwright

Projeto de automacao RPA para resolver o desafio em [rpachallenge.com](https://rpachallenge.com/).

## O que e este projeto

O RPA Challenge apresenta um formulario com 7 campos que mudam de posicao a cada round (10 rounds no total). O robo deve preencher os campos corretos com dados de uma planilha Excel, independente do embaralhamento — totalizando 70 campos preenchidos automaticamente.

**Segredo tecnico:** os campos sao localizados pelo atributo `ng-reflect-name` gerado pelo Angular, que identifica cada campo semanticamente. Assim, mesmo que o campo "Email" apareca na primeira ou na ultima posicao, o robo sempre encontra o campo certo.

## Pre-requisitos

- **Python 3.8+** — [python.org](https://www.python.org/downloads/)
- **Node.js 16+** — necessario para o Playwright ([nodejs.org](https://nodejs.org/))
- **Git** — para clonar o repositorio

## Instalacao rapida

```bash
# 1. Clone o repositorio
git clone https://github.com/LuisForasteiro/robot-framework.git
cd robot-framework

# 2. Crie o ambiente virtual
python -m venv .venv

# 3. Execute o script de setup (instala dependencias + inicializa Playwright)
# Windows:
setup.bat

# Linux/Mac:
chmod +x setup.sh && ./setup.sh
```

## Baixar a planilha

O arquivo Excel com os dados **nao esta no repositorio** (dados pessoais). Voce precisa baixa-lo manualmente:

1. Acesse [rpachallenge.com](https://rpachallenge.com/)
2. Clique em **"Download Excel"**
3. Salve o arquivo em `data/challenge.xlsx`

A pasta `data/` ja existe no projeto — apenas coloque o arquivo com esse nome exato.

## Rodar o robo

```bash
# Ativar o ambiente virtual (se ainda nao estiver ativo)
# Windows:
.venv\Scripts\activate.bat
# Linux/Mac:
source .venv/bin/activate

# Executar o robo (resultados salvos em results/)
robot -d results tests/rpa_challenge.robot
```

O browser abrira automaticamente e voce podera acompanhar o robo preenchendo o formulario em tempo real.

## Ver os relatorios

Apos a execucao, os relatorios ficam na pasta `results/`:

| Arquivo | Descricao |
|---|---|
| `results/log.html` | Log detalhado passo a passo com screenshots |
| `results/report.html` | Sumario executivo do resultado |
| `results/output.xml` | Dados brutos (usado por CI/CD) |

Abra `report.html` no browser para ver o score obtido no desafio.

## Arquitetura do projeto

```
.
├── resources/
│   ├── locators.resource   # Todos os seletores CSS/atributos centralizados aqui
│   └── keywords.resource   # Keywords reutilizaveis de alto nivel
├── tests/
│   └── rpa_challenge.robot # Suite principal — orquestra o fluxo completo
├── data/
│   └── challenge.xlsx      # Planilha (baixar manualmente, nao commitada)
├── results/                # Gerada automaticamente ao rodar (ignorada pelo git)
├── requirements.txt        # Dependencias Python com versoes fixas
├── setup.sh / setup.bat    # Scripts de instalacao
└── README.md
```

**Por que separar keywords, locators e tests?**

- **`locators.resource`** — centraliza todos os seletores. Se o site mudar um atributo, voce altera em um so lugar.
- **`keywords.resource`** — contem a logica reutilizavel. Keywords de alto nivel tornam o `.robot` legivel como documentacao.
- **`tests/`** — contem apenas o fluxo do teste, sem detalhes de implementacao. Facil de entender e modificar.

## Git workflow

```bash
# Ver o que mudou
git status
git diff

# Adicionar alteracoes
git add resources/keywords.resource   # adicionar arquivo especifico
git add .                             # ou adicionar tudo

# Commitar com mensagem descritiva
git commit -m "fix: corrigir locator do campo Email"

# Subir para o GitHub
git push
```

**Convencao de commits usada neste projeto:**
- `feat:` nova funcionalidade
- `fix:` correcao de bug
- `chore:` tarefa de manutencao (deps, config)
- `docs:` alteracao de documentacao
