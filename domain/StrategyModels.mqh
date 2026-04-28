//+------------------------------------------------------------------+
//|                                            EasyOpcoesPro         |
//|                                  Modelos de Dados - Estratégias  |
//+------------------------------------------------------------------+
#ifndef STRATEGY_MODELS_MQH
#define STRATEGY_MODELS_MQH

#include "OptionModels.mqh"

//--- Enumeração de tipos de estratégia em opções
enum ENUM_OPTION_STRATEGY
  {
   STRATEGY_SINGLE_LEG    = 0,  // Operação simples (compra/venda de 1 perna)
   STRATEGY_SPREAD        = 1,  // Spread (vertical, horizontal, diagonal)
   STRATEGY_STRADDLE      = 2,  // Straddle (compra/venda de call e put mesmo strike)
   STRATEGY_STRANGLE      = 3,  // Strangle (compra/venda de call e put strikes diferentes)
   STRATEGY_BUTTERFLY     = 4,  // Butterfly spread
   STRATEGY_CONDOR        = 5,  // Iron Condor
   STRATEGY_COLLAR        = 6,  // Collar (protective put + covered call)
   STRATEGY_CUSTOM        = 7   // Estratégia customizada
  };

//--- Enumeração de direção da estratégia
enum ENUM_STRATEGY_DIRECTION
  {
   DIRECTION_BULLISH   = 0,     // Alta
   DIRECTION_BEARISH   = 1,     // Baixa
   DIRECTION_NEUTRAL   = 2,     // Neutro (range)
   DIRECTION_VOLATILE  = 3      // Volatilidade (movimento forte sem direção)
  };

//--- Estrutura de perna (leg) de uma estratégia
struct StrategyLeg
  {
   int               legId;            // Identificador da perna
   ENUM_OPTION_TYPE  optionType;       // CALL ou PUT
   double            strike;           // Strike
   datetime          expiration;       // Vencimento
   double            quantity;         // Quantidade (positivo = compra, negativo = venda)
   double            entryPremium;     // Prêmio de entrada
   string            optionSymbol;     // Símbolo da opção
  };

//--- Estrutura de uma estratégia completa
struct Strategy
  {
   int               id;               // ID da estratégia
   string            name;             // Nome descritivo
   string            underlying;       // Ativo-objeto
   ENUM_OPTION_STRATEGY type;          // Tipo da estratégia
   ENUM_STRATEGY_DIRECTION direction;  // Direção esperada
   StrategyLeg       legs[];           // Pernas da estratégia
   double            maxProfit;        // Lucro máximo teórico
   double            maxLoss;          // Perda máxima teórica
   double            breakeven[];      // Pontos de break-even
   double            netPremium;       // Prêmio líquido pago/recebido
   datetime          createdAt;        // Data de criação
   bool              isActive;         // Se está ativa no mercado
  };

//--- Estrutura de resultado de backtest/simulação
struct StrategyBacktestResult
  {
   int               strategyId;
   double            totalReturn;      // Retorno total (%)
   double            maxDrawdown;      // Máximo drawdown
   double            sharpeRatio;      // Índice de Sharpe
   double            winRate;          // Taxa de acerto
   int               totalTrades;      // Total de operações
   double            avgProfit;        // Lucro médio por operação
   double            avgLoss;          // Perda média por operação
   datetime          startDate;
   datetime          endDate;
  };

#endif // STRATEGY_MODELS_MQH

