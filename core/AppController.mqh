//+------------------------------------------------------------------+
//|                                          core/AppController.mqh  |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#ifndef __CORE_APP_CONTROLLER_MQH__
#define __CORE_APP_CONTROLLER_MQH__

#include "StateManager.mqh"
#include "../services/OptionService.mqh"
#include "../services/TradeService.mqh"

//+------------------------------------------------------------------+
//| Controller Principal (cérebro do sistema)                        |
//+------------------------------------------------------------------+
class CAppController
  {
private:
   bool              m_initialized;
   CStateManager*    m_stateManager;
   COptionService*   m_optionService;
   CTradeService*    m_tradeService;

public:
                     CAppController(void);
                    ~CAppController(void);

   //--- lifecycle
   bool              Init(CStateManager* stateManager,
                          COptionService* optionService,
                          CTradeService* tradeService);
   void              Shutdown(void);

   //--- eventos
   void              OnTick(void);
   void              OnTimer(void);
   void              OnTrade(void);
   void              OnBookEvent(const string &symbol);

   //--- ações
   bool              EnableTrading(void);
   void              DisableTrading(void);
   void              RefreshData(void);

   //--- [TAG: CONTROLLER_EVENT] Recebe eventos da UI e decide ação
   void              HandleEvent(const string event_name);

   //--- [TAG: TIMER_UPDATE] Atualização periódica do controller
   void              Update(void);

   //--- getters
   bool              IsInitialized(void) const { return m_initialized; }
   CStateManager*    StateManager(void) const { return m_stateManager; }
   COptionService*   OptionService(void) const { return m_optionService; }
   CTradeService*    TradeService(void) const { return m_tradeService; }
  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CAppController::CAppController(void)
   : m_initialized(false),
     m_stateManager(NULL),
     m_optionService(NULL),
     m_tradeService(NULL)
  {
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CAppController::~CAppController(void)
  {
   Shutdown();
  }

//+------------------------------------------------------------------+
//| Init                                                             |
//+------------------------------------------------------------------+
bool CAppController::Init(CStateManager* stateManager,
                          COptionService* optionService,
                          CTradeService* tradeService)
  {
   if(m_initialized)
      return true;

   if(stateManager == NULL || optionService == NULL || tradeService == NULL)
     {
      Print("AppController :: Dependências nulas");
      return false;
     }

   m_stateManager = stateManager;
   m_optionService = optionService;
   m_tradeService = tradeService;
   m_initialized = true;

   Print("AppController :: Inicializado");
   return true;
  }

//+------------------------------------------------------------------+
//| Shutdown                                                         |
//+------------------------------------------------------------------+
void CAppController::Shutdown(void)
  {
   if(!m_initialized)
      return;

   DisableTrading();
   m_stateManager = NULL;
   m_optionService = NULL;
   m_tradeService = NULL;
   m_initialized = false;

   Print("AppController :: Finalizado");
  }

//+------------------------------------------------------------------+
//| OnTick                                                           |
//+------------------------------------------------------------------+
void CAppController::OnTick(void)
  {
   if(!m_initialized)
      return;

   m_stateManager.UpdateTimestamp();

   //--- lógica de decisão principal pode ser chamada aqui
  }

//+------------------------------------------------------------------+
//| OnTimer                                                          |
//+------------------------------------------------------------------+
void CAppController::OnTimer(void)
  {
   if(!m_initialized)
      return;

   RefreshData();
  }

//+------------------------------------------------------------------+
//| OnTrade                                                          |
//+------------------------------------------------------------------+
void CAppController::OnTrade(void)
  {
   if(!m_initialized)
      return;

   //--- processa eventos de trade
  }

//+------------------------------------------------------------------+
//| OnBookEvent                                                      |
//+------------------------------------------------------------------+
void CAppController::OnBookEvent(const string &symbol)
  {
   if(!m_initialized)
      return;

   //--- processa eventos de book de ofertas
  }

//+------------------------------------------------------------------+
//| EnableTrading                                                    |
//+------------------------------------------------------------------+
bool CAppController::EnableTrading(void)
  {
   if(!m_initialized)
      return false;

   m_stateManager.SetTradingEnabled(true);
   Print("AppController :: Trading habilitado");
   return true;
  }

//+------------------------------------------------------------------+
//| DisableTrading                                                   |
//+------------------------------------------------------------------+
void CAppController::DisableTrading(void)
  {
   if(m_stateManager != NULL)
      m_stateManager.SetTradingEnabled(false);

   Print("AppController :: Trading desabilitado");
  }

//+------------------------------------------------------------------+
//| RefreshData                                                      |
//+------------------------------------------------------------------+
void CAppController::RefreshData(void)
  {
   if(!m_initialized)
      return;

   //--- solicita refresh nos serviços
   m_optionService.Refresh();
   m_tradeService.Refresh();
  }

//+------------------------------------------------------------------+
//| [TAG: CONTROLLER_EVENT] HandleEvent                              |
//| Recebe eventos nomeados da UI e executa a lógica correspondente  |
//+------------------------------------------------------------------+
void CAppController::HandleEvent(const string event_name)
  {
   if(!m_initialized)
      return;

   Print("AppController :: Evento recebido = ", event_name);

   if(event_name == "TESTE")
     {
      Print("Evento recebido do UI");
     }
   else if(event_name == "TESTE2")
     {
      Print("Evento TESTE2 recebido do UI");
     }
  }

//+------------------------------------------------------------------+
//| [TAG: TIMER_UPDATE] Update                                       |
//| Atualização periódica chamada pelo OnTimer do EA                 |
//+------------------------------------------------------------------+
void CAppController::Update(void)
  {
   if(!m_initialized)
      return;

   //--- atualiza estado e serviços
   m_stateManager.UpdateTimestamp();
   RefreshData();

   Print("AppController :: Update executado");
  }

#endif // __CORE_APP_CONTROLLER_MQH__

