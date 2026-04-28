# EasyOpcoesPro

EasyOpcoesPro é um Expert Advisor (EA) modular desenvolvido em MQL5 para a plataforma MetaTrader 5 (MT5). O projeto foi estruturado com separação de responsabilidades em camadas, facilitando a manutenção, testes e evolução do código.

## 📁 Estrutura do Projeto

```
EasyOpcoesPro/
├── EasyOpcoesPro.mq5      # Ponto de entrada do EA
├── core/                   # Núcleo da aplicação
│   ├── AppController.mqh   # Controlador principal (orquestração)
│   └── StateManager.mqh    # Gerenciamento de estado global
├── domain/                 # Modelos de domínio
│   ├── OptionModels.mqh    # Modelos de opções
│   └── StrategyModels.mqh  # Modelos de estratégias
├── services/               # Serviços de negócio
│   ├── OptionService.mqh   # Serviço de opções
│   └── TradeService.mqh    # Serviço de execução de ordens
├── ui/                     # Interface do usuário
│   ├── UIApp.mqh           # Aplicação de UI principal
│   ├── MainWindow.mqh      # Janela principal
│   ├── OptionGrid.mqh      # Grid de opções
│   ├── RightPanel.mqh      # Painel lateral direito
│   └── TabManager.mqh      # Gerenciador de abas
└── utils/                  # Utilitários
    ├── FormatUtils.mqh     # Formatação de dados
    └── MathUtils.mqh       # Funções matemáticas
```

## 🚀 Funcionalidades

- **Arquitetura modular**: separação clara entre UI, serviços, domínio e core.
- **Gerenciamento de estado centralizado** via `StateManager`.
- **Serviços desacoplados** para opções e execução de trades.
- **Interface gráfica (GUI)** customizada com grids, painéis e abas.
- **Tratamento de eventos**: OnTick, OnTimer, OnChartEvent, OnTrade, OnBookEvent.

## 🛠️ Requisitos

- MetaTrader 5 (build 1930 ou superior)
- Compatível com contas Hedge e Netting

## ⚙️ Instalação

1. Copie a pasta `EasyOpcoesPro` para o diretório `MQL5/Experts/` do MetaTrader 5.
2. Abra o MetaEditor 5.
3. Compile o arquivo `EasyOpcoesPro.mq5`.
4. No MetaTrader 5, anexe o EA ao gráfico desejado.

## 📝 Licença

Copyright 2025. Todos os direitos reservados.

