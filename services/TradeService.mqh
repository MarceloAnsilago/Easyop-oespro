//+------------------------------------------------------------------+
//|                                          services/TradeService.mqh |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#ifndef __SERVICES_TRADE_SERVICE_MQH__
#define __SERVICES_TRADE_SERVICE_MQH__

#include <Trade\Trade.mqh>

//+------------------------------------------------------------------+
//| Serviço de Execução de Ordens                                    |
//+------------------------------------------------------------------+
class CTradeService
  {
private:
   bool              m_initialized;
   CTrade            m_trade;
   ulong             m_magicNumber;
   double            m_lotSize;
   double            m_stopLoss;
   double            m_takeProfit;
   int               m_deviation;

public:
                     CTradeService(void);
                    ~CTradeService(void);

   //--- lifecycle
   bool              Init(void);
   void              Shutdown(void);

   //--- eventos
   void              OnTick(void);
   void              OnTimer(void);
   void              OnTrade(void);

   //--- operações
   void              Refresh(void);
   bool              Buy(const string symbol, const double volume,
                         const double sl=0, const double tp=0);
   bool              Sell(const string symbol, const double volume,
                          const double sl=0, const double tp=0);
   bool              BuyOption(const string optionSymbol, const double volume);
   bool              SellOption(const string optionSymbol, const double volume);
   bool              ClosePosition(const ulong ticket);
   bool              CloseAllPositions(const string symbol="");

   //--- getters/setters
   bool              IsInitialized(void) const { return m_initialized; }
   void              SetMagicNumber(const ulong magic) { m_magicNumber = magic; m_trade.SetExpertMagicNumber(magic); }
   void              SetDeviation(const int deviation) { m_deviation = deviation; m_trade.SetDeviationInPoints(deviation); }
   void              SetLotSize(const double lots) { m_lotSize = lots; }
   double            LotSize(void) const { return m_lotSize; }
  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTradeService::CTradeService(void)
   : m_initialized(false),
     m_magicNumber(123456),
     m_lotSize(0.01),
     m_stopLoss(0.0),
     m_takeProfit(0.0),
     m_deviation(10)
  {
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTradeService::~CTradeService(void)
  {
   Shutdown();
  }

//+------------------------------------------------------------------+
//| Init                                                             |
//+------------------------------------------------------------------+
bool CTradeService::Init(void)
  {
   if(m_initialized)
      return true;

   m_trade.SetExpertMagicNumber(m_magicNumber);
   m_trade.SetDeviationInPoints(m_deviation);
   m_trade.SetTypeFilling(ORDER_FILLING_IOC);
   m_trade.SetAsyncMode(false);

   m_initialized = true;

   Print("TradeService :: Inicializado (Magic: ", m_magicNumber, ")");
   return true;
  }

//+------------------------------------------------------------------+
//| Shutdown                                                         |
//+------------------------------------------------------------------+
void CTradeService::Shutdown(void)
  {
   if(!m_initialized)
      return;

   m_initialized = false;
   Print("TradeService :: Finalizado");
  }

//+------------------------------------------------------------------+
//| OnTick                                                           |
//+------------------------------------------------------------------+
void CTradeService::OnTick(void)
  {
   if(!m_initialized)
      return;

   //--- lógica de monitoramento de posições abertas
  }

//+------------------------------------------------------------------+
//| OnTimer                                                          |
//+------------------------------------------------------------------+
void CTradeService::OnTimer(void)
  {
   if(!m_initialized)
      return;

   //--- verifica ordens pendentes, ajusta stops, etc.
  }

//+------------------------------------------------------------------+
//| OnTrade                                                          |
//+------------------------------------------------------------------+
void CTradeService::OnTrade(void)
  {
   if(!m_initialized)
      return;

   //--- reage a mudanças no estado de trades
  }

//+------------------------------------------------------------------+
//| Refresh                                                          |
//+------------------------------------------------------------------+
void CTradeService::Refresh(void)
  {
   if(!m_initialized)
      return;

   //--- atualiza dados de posições e ordens
  }

//+------------------------------------------------------------------+
//| Buy                                                              |
//+------------------------------------------------------------------+
bool CTradeService::Buy(const string symbol, const double volume,
                         const double sl=0, const double tp=0)
  {
   if(!m_initialized)
      return false;

   if(!m_trade.Buy(volume, symbol, 0, sl, tp))
     {
      Print("TradeService :: Erro ao comprar: ", GetLastError());
      return false;
     }

   Print("TradeService :: Ordem de compra enviada em ", symbol);
   return true;
  }

//+------------------------------------------------------------------+
//| Sell                                                             |
//+------------------------------------------------------------------+
bool CTradeService::Sell(const string symbol, const double volume,
                          const double sl=0, const double tp=0)
  {
   if(!m_initialized)
      return false;

   if(!m_trade.Sell(volume, symbol, 0, sl, tp))
     {
      Print("TradeService :: Erro ao vender: ", GetLastError());
      return false;
     }

   Print("TradeService :: Ordem de venda enviada em ", symbol);
   return true;
  }

//+------------------------------------------------------------------+
//| BuyOption                                                        |
//+------------------------------------------------------------------+
bool CTradeService::BuyOption(const string optionSymbol, const double volume)
  {
   return Buy(optionSymbol, volume);
  }

//+------------------------------------------------------------------+
//| SellOption                                                       |
//+------------------------------------------------------------------+
bool CTradeService::SellOption(const string optionSymbol, const double volume)
  {
   return Sell(optionSymbol, volume);
  }

//+------------------------------------------------------------------+
//| ClosePosition                                                    |
//+------------------------------------------------------------------+
bool CTradeService::ClosePosition(const ulong ticket)
  {
   if(!m_initialized)
      return false;

   if(!m_trade.PositionClose(ticket))
     {
      Print("TradeService :: Erro ao fechar posição: ", GetLastError());
      return false;
     }

   Print("TradeService :: Posição fechada: ", ticket);
   return true;
  }

//+------------------------------------------------------------------+
//| CloseAllPositions                                                |
//+------------------------------------------------------------------+
bool CTradeService::CloseAllPositions(const string symbol="")
  {
   if(!m_initialized)
      return false;

   bool result = true;
   for(int i = PositionsTotal() - 1; i >= 0; i--)
     {
      ulong ticket = PositionGetTicket(i);
      if(ticket == 0)
         continue;

      if(symbol != "" && PositionGetString(POSITION_SYMBOL) != symbol)
         continue;

      if(!m_trade.PositionClose(ticket))
        {
         Print("TradeService :: Erro ao fechar posição ", ticket, ": ", GetLastError());
         result = false;
        }
     }

   Print("TradeService :: Todas as posições fechadas");
   return result;
  }

#endif // __SERVICES_TRADE_SERVICE_MQH__

