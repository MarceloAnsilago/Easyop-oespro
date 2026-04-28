//+------------------------------------------------------------------+
//|                                           ui/OptionGrid.mqh      |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#ifndef __UI_OPTION_GRID_MQH__
#define __UI_OPTION_GRID_MQH__

#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>

//+------------------------------------------------------------------+
//| Estrutura de dados da opção                                      |
//+------------------------------------------------------------------+
struct OptionRow
  {
   string            strike;
   string            callSymbol;
   double            callLast;
   double            callBid;
   double            callAsk;
   double            callIV;
   string            putSymbol;
   double            putLast;
   double            putBid;
   double            putAsk;
   double            putIV;
  };

//+------------------------------------------------------------------+
//| Grade de Opções (Call/Put) simplificada com Labels               |
//+------------------------------------------------------------------+
class COptionGrid
  {
private:
   bool              m_created;
   CAppDialog*       m_parent;
   CLabel            m_header;
   CLabel            m_colHeaders;
   int               m_rowCount;
   OptionRow         m_rows[];

   bool              CreateHeader(void);

public:
                     COptionGrid(void);
                    ~COptionGrid(void);

   //--- create/destroy
   bool              Create(CAppDialog* parent);
   void              Destroy(void);

   //--- dados
   void              Clear(void);
   bool              AddRow(const OptionRow &row);
   bool              UpdateRow(const int index, const OptionRow &row);
   void              UpdatePrices(void);
   void              Refresh(void);

   //--- layout
   void              SetPosition(const int x, const int y, const int width, const int height);

   //--- getters
   bool              IsCreated(void) const { return m_created; }
   int               RowCount(void) const { return m_rowCount; }
  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
COptionGrid::COptionGrid(void)
   : m_created(false),
     m_parent(NULL),
     m_rowCount(0)
  {
   ArrayResize(m_rows, 0);
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
COptionGrid::~COptionGrid(void)
  {
   Destroy();
  }

//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool COptionGrid::Create(CAppDialog* parent)
  {
   if(m_created || parent == NULL)
      return false;

   m_parent = parent;

   if(!CreateHeader())
      return false;

   m_created = true;
   Print("OptionGrid :: Criado com sucesso");
   return true;
  }

//+------------------------------------------------------------------+
//| Destroy                                                          |
//+------------------------------------------------------------------+
void COptionGrid::Destroy(void)
  {
   if(!m_created)
      return;

   m_header.Destroy();
   m_colHeaders.Destroy();
   m_parent = NULL;
   m_created = false;
   m_rowCount = 0;
   ArrayResize(m_rows, 0);
  }

//+------------------------------------------------------------------+
//| CreateHeader                                                     |
//+------------------------------------------------------------------+
bool COptionGrid::CreateHeader(void)
  {
   int x1 = 10;
   int y1 = 80;
   int x2 = x1 + 500;
   int y2 = y1 + 20;

   if(!m_header.Create(0, "GridHeader", 0, x1, y1, x2, y2))
      return false;

   m_header.Text("Chain de Opções (Strike | Call Last/Bid/Ask/IV | Put Last/Bid/Ask/IV)");
   m_header.Color(clrWhite);

   if(!m_parent.Add(m_header))
      return false;

   return true;
  }

//+------------------------------------------------------------------+
//| Clear                                                            |
//+------------------------------------------------------------------+
void COptionGrid::Clear(void)
  {
   if(!m_created)
      return;

   ArrayResize(m_rows, 0);
   m_rowCount = 0;
  }

//+------------------------------------------------------------------+
//| AddRow                                                           |
//+------------------------------------------------------------------+
bool COptionGrid::AddRow(const OptionRow &row)
  {
   if(!m_created)
      return false;

   int idx = m_rowCount;
   m_rowCount++;
   ArrayResize(m_rows, m_rowCount);
   m_rows[idx] = row;

   return true;
  }

//+------------------------------------------------------------------+
//| UpdateRow                                                        |
//+------------------------------------------------------------------+
bool COptionGrid::UpdateRow(const int index, const OptionRow &row)
  {
   if(!m_created || index < 0 || index >= m_rowCount)
      return false;

   m_rows[index] = row;
   return true;
  }

//+------------------------------------------------------------------+
//| UpdatePrices                                                     |
//+------------------------------------------------------------------+
void COptionGrid::UpdatePrices(void)
  {
   if(!m_created)
      return;

   //--- atualiza preços em tempo real (placeholder)
   for(int i = 0; i < m_rowCount; i++)
     {
      // simula atualização de preços
      m_rows[i].callLast += 0.01;
      m_rows[i].putLast  += 0.01;
     }
  }

//+------------------------------------------------------------------+
//| Refresh                                                          |
//+------------------------------------------------------------------+
void COptionGrid::Refresh(void)
  {
   if(!m_created)
      return;

   //--- refresh visual (placeholder)
  }

//+------------------------------------------------------------------+
//| SetPosition                                                      |
//+------------------------------------------------------------------+
void COptionGrid::SetPosition(const int x, const int y, const int width, const int height)
  {
   //--- placeholder
  }

#endif // __UI_OPTION_GRID_MQH__
