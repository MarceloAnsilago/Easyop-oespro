//+------------------------------------------------------------------+
//|                                           ui/TabManager.mqh      |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#ifndef __UI_TAB_MANAGER_MQH__
#define __UI_TAB_MANAGER_MQH__

#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>

//+------------------------------------------------------------------+
//| Gerenciador de Abas (simplificado com botões)                    |
//+------------------------------------------------------------------+
class CTabManager
  {
private:
   bool              m_created;
   CAppDialog*       m_parent;
   CButton           m_btnTab1;
   CButton           m_btnTab2;
   CButton           m_btnTab3;
   int               m_activeTab;
   int               m_tabCount;

public:
                     CTabManager(void);
                    ~CTabManager(void);

   //--- create/destroy
   bool              Create(CAppDialog* parent);
   void              Destroy(void);

   //--- abas
   bool              AddTab(const string title);
   bool              RemoveTab(const int index);
   void              SelectTab(const int index);
   int               SelectedTab(void) const;
   int               TabCount(void) const { return m_tabCount; }

   //--- posicionamento
   void              SetPosition(const int x, const int y, const int width, const int height);

   //--- visibility
   bool              IsCreated(void) const { return m_created; }
  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CTabManager::CTabManager(void)
   : m_created(false),
     m_parent(NULL),
     m_activeTab(0),
     m_tabCount(0)
  {
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CTabManager::~CTabManager(void)
  {
   Destroy();
  }

//+------------------------------------------------------------------+
//| Create                                                           |
//+------------------------------------------------------------------+
bool CTabManager::Create(CAppDialog* parent)
  {
   if(m_created || parent == NULL)
      return false;

   m_parent = parent;

   int x1 = 10;
   int y1 = 40;
   int w = 80;
   int h = 25;

   if(!m_btnTab1.Create(0, "Tab1", 0, x1, y1, x1 + w, y1 + h))
      return false;
   m_btnTab1.Text("Opções");
   m_btnTab1.ColorBackground(clrDarkGreen);
   if(!m_parent.Add(m_btnTab1))
      return false;

   x1 += w + 5;
   if(!m_btnTab2.Create(0, "Tab2", 0, x1, y1, x1 + w, y1 + h))
      return false;
   m_btnTab2.Text("Posições");
   if(!m_parent.Add(m_btnTab2))
      return false;

   x1 += w + 5;
   if(!m_btnTab3.Create(0, "Tab3", 0, x1, y1, x1 + w, y1 + h))
      return false;
   m_btnTab3.Text("Histórico");
   if(!m_parent.Add(m_btnTab3))
      return false;

   m_tabCount = 3;
   m_created = true;
   Print("TabManager :: Criado com sucesso");
   return true;
  }

//+------------------------------------------------------------------+
//| Destroy                                                          |
//+------------------------------------------------------------------+
void CTabManager::Destroy(void)
  {
   if(!m_created)
      return;

   m_btnTab1.Destroy();
   m_btnTab2.Destroy();
   m_btnTab3.Destroy();
   m_parent = NULL;
   m_created = false;
   m_tabCount = 0;
  }

//+------------------------------------------------------------------+
//| AddTab                                                           |
//+------------------------------------------------------------------+
bool CTabManager::AddTab(const string title)
  {
   //--- simplificado: máximo 3 abas fixas
   return m_created;
  }

//+------------------------------------------------------------------+
//| RemoveTab                                                        |
//+------------------------------------------------------------------+
bool CTabManager::RemoveTab(const int index)
  {
   return false;
  }

//+------------------------------------------------------------------+
//| SelectTab                                                        |
//+------------------------------------------------------------------+
void CTabManager::SelectTab(const int index)
  {
   if(!m_created || index < 0 || index >= m_tabCount)
      return;

   m_activeTab = index;

   //--- atualiza cores para mostrar aba ativa
   m_btnTab1.ColorBackground(index == 0 ? clrDarkGreen : clrGray);
   m_btnTab2.ColorBackground(index == 1 ? clrDarkGreen : clrGray);
   m_btnTab3.ColorBackground(index == 2 ? clrDarkGreen : clrGray);
  }

//+------------------------------------------------------------------+
//| SelectedTab                                                      |
//+------------------------------------------------------------------+
int CTabManager::SelectedTab(void) const
  {
   if(!m_created)
      return -1;

   return m_activeTab;
  }

//+------------------------------------------------------------------+
//| SetPosition                                                      |
//+------------------------------------------------------------------+
void CTabManager::SetPosition(const int x, const int y, const int width, const int height)
  {
   //--- simplificado
  }

#endif // __UI_TAB_MANAGER_MQH__
