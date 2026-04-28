//+------------------------------------------------------------------+
//|                                                EasyOpcoesPro.mq5 |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2025, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

//--- includes da estrutura modular
#include "core/AppController.mqh"
#include "core/StateManager.mqh"
#include "ui/UIApp.mqh"
#include "services/OptionService.mqh"
#include "services/TradeService.mqh"

//--- instâncias globais
CAppController   g_appController;
CStateManager    g_stateManager;
CUIApp           g_uiApp;
COptionService   g_optionService;
CTradeService    g_tradeService;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
   Print(">>> EasyOpcoesPro :: OnInit iniciado");
  Alert("EasyOpcoesPro :: OnInit iniciado");

//--- [TAG: APP_INIT] Inicializa estado
   Print(">>> Inicializando StateManager...");
   if(!g_stateManager.Init())
     {
      Print(">>> Falha ao inicializar StateManager");
      return(INIT_FAILED);
     }
   Print(">>> StateManager OK");

//--- inicializa serviços
   Print(">>> Inicializando OptionService...");
   if(!g_optionService.Init())
     {
      Print(">>> Falha ao inicializar OptionService");
      return(INIT_FAILED);
     }
   Print(">>> OptionService OK");

   Print(">>> Inicializando TradeService...");
   if(!g_tradeService.Init())
     {
      Print(">>> Falha ao inicializar TradeService");
      return(INIT_FAILED);
     }
   Print(">>> TradeService OK");

//--- inicializa controller
   Print(">>> Inicializando AppController...");
   if(!g_appController.Init(&g_stateManager, &g_optionService, &g_tradeService))
     {
      Print(">>> Falha ao inicializar AppController");
      return(INIT_FAILED);
     }
   Print(">>> AppController OK");

//--- [TAG: UI_INIT] inicializa interface
   Print(">>> Inicializando UI...");
   if(!g_uiApp.Init(&g_appController))
     {
      Print(">>> Falha ao inicializar UI");
      return(INIT_FAILED);
     }
   Print(">>> UI OK");

   Print(">>> EasyOpcoesPro :: Inicializado com sucesso");
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
   Print(">>> EasyOpcoesPro :: OnDeinit iniciado");

   g_uiApp.Shutdown();
   g_appController.Shutdown();
   g_tradeService.Shutdown();
   g_optionService.Shutdown();
   g_stateManager.Shutdown();

   Print(">>> EasyOpcoesPro :: Finalizado");
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
   g_optionService.OnTick();
   g_tradeService.OnTick();
   g_appController.OnTick();
   g_uiApp.OnTick();
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
   g_optionService.OnTimer();
   g_tradeService.OnTimer();
   g_appController.Update();
   g_uiApp.OnTimer();
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
  {
//--- [TAG: EVENT_DISPATCH] repassa eventos do chart para a UI
   g_uiApp.HandleChartEvent(id, lparam, dparam, sparam);
  }
//+------------------------------------------------------------------+
//| Trade function                                                   |
//+------------------------------------------------------------------+
void OnTrade()
  {
   g_tradeService.OnTrade();
   g_appController.OnTrade();
  }
//+------------------------------------------------------------------+
//| BookEvent function                                               |
//+------------------------------------------------------------------+
void OnBookEvent(const string &symbol)
  {
   g_optionService.OnBookEvent(symbol);
   g_appController.OnBookEvent(symbol);
  }
//+------------------------------------------------------------------+
