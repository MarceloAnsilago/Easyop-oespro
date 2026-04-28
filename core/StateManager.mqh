//+------------------------------------------------------------------+
//|                                           core/StateManager.mqh  |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#ifndef __CORE_STATE_MANAGER_MQH__
#define __CORE_STATE_MANAGER_MQH__

//+------------------------------------------------------------------+
//| Gerenciador de Estado Global                                     |
//+------------------------------------------------------------------+
class CStateManager
  {
private:
   bool              m_initialized;
   bool              m_isTradingEnabled;
   bool              m_isUIRunning;
   string            m_currentSymbol;
   datetime          m_lastUpdate;

public:
                     CStateManager(void);
                    ~CStateManager(void);

   //--- lifecycle
   bool              Init(void);
   void              Shutdown(void);

   //--- getters/setters
   bool              IsTradingEnabled(void) const { return m_isTradingEnabled; }
   void              SetTradingEnabled(const bool value) { m_isTradingEnabled = value; }

   bool              IsUIRunning(void) const { return m_isUIRunning; }
   void              SetUIRunning(const bool value) { m_isUIRunning = value; }

   string            CurrentSymbol(void) const { return m_currentSymbol; }
   void              SetCurrentSymbol(const string symbol) { m_currentSymbol = symbol; }

   datetime          LastUpdate(void) const { return m_lastUpdate; }
   void              UpdateTimestamp(void) { m_lastUpdate = TimeCurrent(); }

   //--- estado geral
   bool              IsInitialized(void) const { return m_initialized; }
  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CStateManager::CStateManager(void)
   : m_initialized(false),
     m_isTradingEnabled(false),
     m_isUIRunning(false),
     m_currentSymbol(""),
     m_lastUpdate(0)
  {
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CStateManager::~CStateManager(void)
  {
   Shutdown();
  }

//+------------------------------------------------------------------+
//| Init                                                             |
//+------------------------------------------------------------------+
bool CStateManager::Init(void)
  {
   if(m_initialized)
      return true;

   m_currentSymbol = Symbol();
   m_isTradingEnabled = false;
   m_isUIRunning = false;
   m_lastUpdate = TimeCurrent();
   m_initialized = true;

   Print("StateManager :: Inicializado");
   return true;
  }

//+------------------------------------------------------------------+
//| Shutdown                                                         |
//+------------------------------------------------------------------+
void CStateManager::Shutdown(void)
  {
   if(!m_initialized)
      return;

   m_isTradingEnabled = false;
   m_isUIRunning = false;
   m_initialized = false;

   Print("StateManager :: Finalizado");
  }

#endif // __CORE_STATE_MANAGER_MQH__

