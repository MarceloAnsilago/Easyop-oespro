//+------------------------------------------------------------------+
//|                                            EasyOpcoesPro         |
//|                                      Painel Lateral Direito      |
//+------------------------------------------------------------------+
#ifndef RIGHT_PANEL_MQH
#define RIGHT_PANEL_MQH

#include <Controls\Dialog.mqh>
#include <Controls\Label.mqh>

//--- Classe que representa o painel lateral direito da interface
class CRightPanel
  {
private:
   CAppDialog*       m_parent;
   CLabel            m_infoLabel;
   int               m_width;
   int               m_height;
   bool              m_created;

public:
                     CRightPanel(void);
                    ~CRightPanel(void);

   //--- Criação e destruição
   bool              Create(CAppDialog* parent);
   void              Destroy(void);

   //--- Atualização
   void              UpdateInfo(void);

   //--- Propriedades
   void              Size(const int width, const int height);
   bool              IsCreated(void) const { return m_created; }
  };

//--- Construtor
CRightPanel::CRightPanel(void)
   : m_parent(NULL),
     m_width(200),
     m_height(400),
     m_created(false)
  {
  }

//--- Destrutor
CRightPanel::~CRightPanel(void)
  {
   Destroy();
  }

//--- Cria o painel lateral direito
bool CRightPanel::Create(CAppDialog* parent)
  {
   if(m_created || parent == NULL)
      return false;

   m_parent = parent;

   int x1 = 600;
   int y1 = 80;
   int x2 = x1 + m_width;
   int y2 = y1 + 30;

   if(!m_infoLabel.Create(0, "RightPanelInfo", 0, x1, y1, x2, y2))
      return false;

   m_infoLabel.Text("Painel de Info");
   m_infoLabel.Color(clrWhite);

   if(!m_parent.Add(m_infoLabel))
      return false;

   m_created = true;
   return true;
  }

//--- Destrói o painel
void CRightPanel::Destroy(void)
  {
   if(!m_created)
      return;

   m_infoLabel.Destroy();
   m_parent = NULL;
   m_created = false;
  }

//--- Atualiza informações do painel
void CRightPanel::UpdateInfo(void)
  {
   if(!m_created)
      return;

   //--- atualiza dados do painel direito (placeholder)
   static int counter = 0;
   counter++;
   if(counter % 100 == 0)
     {
      m_infoLabel.Text("Atualizado: " + IntegerToString(counter));
     }
  }

//--- Define o tamanho do painel
void CRightPanel::Size(const int width, const int height)
  {
   m_width = width;
   m_height = height;
  }

#endif // RIGHT_PANEL_MQH
