//+------------------------------------------------------------------+
//|                                               ui/UIApp.mqh       |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#ifndef __UI_UI_APP_MQH__
#define __UI_UI_APP_MQH__

//+------------------------------------------------------------------+
//| Controlador da Interface Gráfica - Usando objetos gráficos nativos|
//+------------------------------------------------------------------+
class CUIApp
  {
private:
   bool              m_initialized;
   CAppController*   m_appController;
   bool              m_isWindowVisible;

   //--- Nomes dos objetos gráficos
   string            m_prefix;
   string            m_wndName;
   string            m_btnTesteName;
   string            m_btnTeste2Name;
   string            m_labelName;

public:
                     CUIApp(void);
                    ~CUIApp(void);

   //--- lifecycle
   bool              Init(CAppController* appController);
   void              Shutdown(void);

   //--- eventos
   void              OnTick(void);
   void              OnTimer(void);

   //--- [TAG: EVENT_DISPATCH] Recebe eventos do chart e repassa ao controller
   void              HandleChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam);

   //--- operações
   void              ShowWindow(void);
   void              HideWindow(void);
   void              UpdateData(void);
   void              RefreshGrid(void);

   //--- getters
   bool              IsInitialized(void) const { return m_initialized; }
   bool              IsWindowVisible(void) const { return m_isWindowVisible; }

private:
   bool              CreateWindow(void);
   bool              CreateTestButton(void);
   void              DestroyGUI(void);
  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CUIApp::CUIApp(void)
   : m_initialized(false),
     m_appController(NULL),
     m_isWindowVisible(false),
     m_prefix("EasyPro_")
  {
   m_wndName = m_prefix + "Window";
   m_btnTesteName = m_prefix + "BtnTeste";
   m_btnTeste2Name = m_prefix + "BtnTeste2";
   m_labelName = m_prefix + "LabelStatus";
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CUIApp::~CUIApp(void)
  {
   Shutdown();
  }

//+------------------------------------------------------------------+
//| [TAG: UI_INIT | v2 | DESC: criação correta da janela EasyGUI]    |
//+------------------------------------------------------------------+
bool CUIApp::Init(CAppController* appController)
  {
   if(m_initialized)
     {
      Print("UIApp :: Já inicializado");
      return true;
     }

   if(appController == NULL)
     {
      Print("UIApp :: AppController nulo");
      return false;
     }

   m_appController = appController;

   //--- cria janela e botão usando objetos gráficos nativos
   if(!CreateWindow())
     {
      Print("UIApp :: Falha ao criar janela");
      return false;
     }

   if(!CreateTestButton())
     {
      Print("UIApp :: Falha ao criar botão");
      DestroyGUI();
      return false;
     }

   //--- [TAG: UI_INIT] Extensão: cria painéis tab1/tab2, label e botão de troca
   //--- valores da janela (mesma área do CreateWindow)
   int win_x = 50;
   int win_y = 50;
   int win_w = 400;
   int win_h = 300;

   //--- Panel 1 (panel_tab1) - ocupa mesma área da janela e inicialmente visível
   string panel1 = "panel_tab1";
   if(!ObjectCreate(0, panel1, OBJ_RECTANGLE_LABEL, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar panel_tab1: ", GetLastError());
     }
   else
     {
      ObjectSetInteger(0, panel1, OBJPROP_CORNER, CORNER_LEFT_UPPER);
      ObjectSetInteger(0, panel1, OBJPROP_XDISTANCE, win_x);
      ObjectSetInteger(0, panel1, OBJPROP_YDISTANCE, win_y);
      ObjectSetInteger(0, panel1, OBJPROP_XSIZE, win_w);
      ObjectSetInteger(0, panel1, OBJPROP_YSIZE, win_h);
      ObjectSetInteger(0, panel1, OBJPROP_BGCOLOR, C'10,18,32');
      ObjectSetInteger(0, panel1, OBJPROP_BORDER_TYPE, BORDER_FLAT);
      ObjectSetInteger(0, panel1, OBJPROP_HIDDEN, false);
      ObjectSetInteger(0, panel1, OBJPROP_ZORDER, 105);
     }

   //--- Panel 2 (panel_tab2) - mesma área, inicialmente invisível
   string panel2 = "panel_tab2";
   if(!ObjectCreate(0, panel2, OBJ_RECTANGLE_LABEL, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar panel_tab2: ", GetLastError());
     }
   else
     {
      ObjectSetInteger(0, panel2, OBJPROP_CORNER, CORNER_LEFT_UPPER);
      ObjectSetInteger(0, panel2, OBJPROP_XDISTANCE, win_x);
      ObjectSetInteger(0, panel2, OBJPROP_YDISTANCE, win_y);
      ObjectSetInteger(0, panel2, OBJPROP_XSIZE, win_w);
      ObjectSetInteger(0, panel2, OBJPROP_YSIZE, win_h);
      ObjectSetInteger(0, panel2, OBJPROP_BGCOLOR, C'8,14,24');
      ObjectSetInteger(0, panel2, OBJPROP_BORDER_TYPE, BORDER_FLAT);
      ObjectSetInteger(0, panel2, OBJPROP_HIDDEN, true); // inicialmente invisível
      ObjectSetInteger(0, panel2, OBJPROP_ZORDER, 106);
     }

   //--- Label dentro de panel_tab2: "TAB 2 ATIVA" na posição (20,20) relativa à janela
   string tab2Label = "panel_tab2_label";
   if(!ObjectCreate(0, tab2Label, OBJ_LABEL, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar label TAB 2: ", GetLastError());
     }
   else
     {
      ObjectSetInteger(0, tab2Label, OBJPROP_CORNER, CORNER_LEFT_UPPER);
      ObjectSetInteger(0, tab2Label, OBJPROP_XDISTANCE, win_x + 20);
      ObjectSetInteger(0, tab2Label, OBJPROP_YDISTANCE, win_y + 20);
      ObjectSetString(0, tab2Label, OBJPROP_TEXT, "TAB 2 ATIVA");
      ObjectSetInteger(0, tab2Label, OBJPROP_COLOR, clrWhite);
      ObjectSetInteger(0, tab2Label, OBJPROP_FONTSIZE, 12);
      ObjectSetInteger(0, tab2Label, OBJPROP_HIDDEN, true);
      ObjectSetInteger(0, tab2Label, OBJPROP_ZORDER, 107);
     }

   //--- Botão adicional BtnTrocar na posição (20,150) relativa à janela
   string btnTrocar = "BtnTrocar"; // nome conforme solicitado
   if(!ObjectCreate(0, btnTrocar, OBJ_EDIT, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar BtnTrocar: ", GetLastError());
     }
   else
     {
      ObjectSetInteger(0, btnTrocar, OBJPROP_CORNER, CORNER_LEFT_UPPER);
      ObjectSetInteger(0, btnTrocar, OBJPROP_XDISTANCE, win_x + 20);
      ObjectSetInteger(0, btnTrocar, OBJPROP_YDISTANCE, win_y + 150);
      ObjectSetInteger(0, btnTrocar, OBJPROP_XSIZE, 120);
      ObjectSetInteger(0, btnTrocar, OBJPROP_YSIZE, 30);
      ObjectSetString(0, btnTrocar, OBJPROP_TEXT, "TROCAR TAB");
      ObjectSetInteger(0, btnTrocar, OBJPROP_COLOR, clrWhite);
      ObjectSetInteger(0, btnTrocar, OBJPROP_BGCOLOR, clrOrange);
      ObjectSetInteger(0, btnTrocar, OBJPROP_ALIGN, ALIGN_CENTER);
      ObjectSetInteger(0, btnTrocar, OBJPROP_READONLY, true);
      ObjectSetInteger(0, btnTrocar, OBJPROP_SELECTABLE, false);
      ObjectSetInteger(0, btnTrocar, OBJPROP_HIDDEN, false);
      ObjectSetInteger(0, btnTrocar, OBJPROP_ZORDER, 108);
     }

   //--- OBS: A lógica de resposta ao clique deverá ser tratada no dispatcher de eventos
   //--- (não alterado aqui conforme regra). Os objetos existem e têm nomes fixos.

   // [END TAG: UI_INIT]

   m_initialized = true;
   ShowWindow();

   Print("UIApp :: Interface inicializada com sucesso");
   return true;
  }

//+------------------------------------------------------------------+
//| CreateWindow - Cria janela com retângulo gráfico                 |
//+------------------------------------------------------------------+
bool CUIApp::CreateWindow(void)
  {
   int x = 50;
   int y = 50;
   int width = 400;
   int height = 300;

   //--- Fundo da janela (retângulo label)
   if(!ObjectCreate(0, m_wndName, OBJ_RECTANGLE_LABEL, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar retângulo: ", GetLastError());
      return false;
     }

   ObjectSetInteger(0, m_wndName, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, m_wndName, OBJPROP_XDISTANCE, x);
   ObjectSetInteger(0, m_wndName, OBJPROP_YDISTANCE, y);
   ObjectSetInteger(0, m_wndName, OBJPROP_XSIZE, width);
   ObjectSetInteger(0, m_wndName, OBJPROP_YSIZE, height);
   ObjectSetInteger(0, m_wndName, OBJPROP_BGCOLOR, C'15,23,42');
   ObjectSetInteger(0, m_wndName, OBJPROP_BORDER_TYPE, BORDER_FLAT);
   ObjectSetInteger(0, m_wndName, OBJPROP_COLOR, clrDarkGray);
   ObjectSetInteger(0, m_wndName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, m_wndName, OBJPROP_HIDDEN, false);
   ObjectSetInteger(0, m_wndName, OBJPROP_ZORDER, 100);

   //--- Título da janela
   string titleName = m_prefix + "Title";
   if(!ObjectCreate(0, titleName, OBJ_LABEL, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar título: ", GetLastError());
      return false;
     }

   ObjectSetInteger(0, titleName, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, titleName, OBJPROP_XDISTANCE, x + 10);
   ObjectSetInteger(0, titleName, OBJPROP_YDISTANCE, y + 10);
   ObjectSetString(0, titleName, OBJPROP_TEXT, "EasyOpcoesPro v1.0");
   ObjectSetInteger(0, titleName, OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, titleName, OBJPROP_FONTSIZE, 12);
   ObjectSetInteger(0, titleName, OBJPROP_HIDDEN, false);
   ObjectSetInteger(0, titleName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, titleName, OBJPROP_ZORDER, 101);

   return true;
  }

//+------------------------------------------------------------------+
//| CreateTestButton - Cria botões TESTE, TESTE 2 e label UI OK      |
//+------------------------------------------------------------------+
bool CUIApp::CreateTestButton(void)
  {
   int baseX = 70;   // 50 + 20
   int baseY = 90;   // 50 + 40

   //--- Botão TESTE 1
   if(!ObjectCreate(0, m_btnTesteName, OBJ_EDIT, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar botão TESTE: ", GetLastError());
      return false;
     }

   ObjectSetInteger(0, m_btnTesteName, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_XDISTANCE, baseX);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_YDISTANCE, baseY);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_XSIZE, 120);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_YSIZE, 30);
   ObjectSetString(0, m_btnTesteName, OBJPROP_TEXT, "TESTE");
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_BGCOLOR, clrDarkBlue);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_ALIGN, ALIGN_CENTER);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_READONLY, true);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_HIDDEN, false);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_ZORDER, 102);

   //--- Botão TESTE 2 (abaixo do primeiro)
   if(!ObjectCreate(0, m_btnTeste2Name, OBJ_EDIT, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar botão TESTE 2: ", GetLastError());
      return false;
     }

   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_XDISTANCE, baseX);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_YDISTANCE, baseY + 40); // 90 + 40 = 130
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_XSIZE, 120);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_YSIZE, 30);
   ObjectSetString(0, m_btnTeste2Name, OBJPROP_TEXT, "TESTE 2");
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_COLOR, clrWhite);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_BGCOLOR, clrDarkGreen);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_ALIGN, ALIGN_CENTER);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_READONLY, true);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_HIDDEN, false);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_ZORDER, 103);

   //--- Label UI OK (abaixo dos botões)
   if(!ObjectCreate(0, m_labelName, OBJ_LABEL, 0, 0, 0))
     {
      Print("UIApp :: Erro ao criar label: ", GetLastError());
      return false;
     }

   ObjectSetInteger(0, m_labelName, OBJPROP_CORNER, CORNER_LEFT_UPPER);
   ObjectSetInteger(0, m_labelName, OBJPROP_XDISTANCE, baseX);
   ObjectSetInteger(0, m_labelName, OBJPROP_YDISTANCE, baseY + 80); // 90 + 80 = 170
   ObjectSetString(0, m_labelName, OBJPROP_TEXT, "UI OK");
   ObjectSetInteger(0, m_labelName, OBJPROP_COLOR, clrLime);
   ObjectSetInteger(0, m_labelName, OBJPROP_FONTSIZE, 10);
   ObjectSetInteger(0, m_labelName, OBJPROP_HIDDEN, false);
   ObjectSetInteger(0, m_labelName, OBJPROP_SELECTABLE, false);
   ObjectSetInteger(0, m_labelName, OBJPROP_ZORDER, 104);

   return true;
  }

//+------------------------------------------------------------------+
//| DestroyGUI - Remove todos os objetos gráficos                    |
//+------------------------------------------------------------------+
void CUIApp::DestroyGUI(void)
  {
   ObjectDelete(0, m_wndName);
   ObjectDelete(0, m_prefix + "Title");
   ObjectDelete(0, m_btnTesteName);
   ObjectDelete(0, m_btnTeste2Name);
   ObjectDelete(0, m_labelName);
  }

//+------------------------------------------------------------------+
//| Shutdown                                                         |
//+------------------------------------------------------------------+
void CUIApp::Shutdown(void)
  {
   if(!m_initialized)
      return;

   HideWindow();
   DestroyGUI();

   m_appController = NULL;
   m_initialized = false;

   Print("UIApp :: Interface finalizada");
  }

//+------------------------------------------------------------------+
//| OnTick                                                           |
//+------------------------------------------------------------------+
void CUIApp::OnTick(void)
  {
   if(!m_initialized)
      return;

   UpdateData();
  }

//+------------------------------------------------------------------+
//| OnTimer                                                          |
//+------------------------------------------------------------------+
void CUIApp::OnTimer(void)
  {
   if(!m_initialized)
      return;

   RefreshGrid();
  }

//+------------------------------------------------------------------+
//| [TAG: EVENT_DISPATCH] HandleChartEvent                           |
//| Recebe eventos do chart, identifica cliques na UI e repassa      |
//| eventos de negócio ao AppController                                |
//+------------------------------------------------------------------+
void CUIApp::HandleChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam)
  {
   if(!m_initialized)
      return;

   //--- Detecta clique no botão TESTE (OBJ_EDIT detecta clique via CHARTEVENT_OBJECT_CLICK)
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == m_btnTesteName)
     {
      Print("UIApp :: Botão TESTE clicado");

      //--- UI NÃO executa lógica; repassa ao controller
      if(m_appController != NULL)
         m_appController.HandleEvent("TESTE");
     }

   //--- Detecta clique no botão TESTE 2
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == m_btnTeste2Name)
     {
      Print("UIApp :: Botão TESTE 2 clicado");

      //--- UI NÃO executa lógica; repassa ao controller
      if(m_appController != NULL)
         m_appController.HandleEvent("TESTE2");
     }

   //--- Detecta clique no botão TROCAR (alternar entre panel_tab1 e panel_tab2)
   if(id == CHARTEVENT_OBJECT_CLICK && sparam == "BtnTrocar")
     {
      Print("UIApp :: Botão TROCAR clicado");

      //--- lê estado atual dos painéis (OBJPROP_HIDDEN == 0 significa visível)
      long hidden1 = ObjectGetInteger(0, "panel_tab1", OBJPROP_HIDDEN);

      if(hidden1 == 0) // panel_tab1 visível -> esconder e mostrar panel_tab2
        {
         ObjectSetInteger(0, "panel_tab1", OBJPROP_HIDDEN, true);
         ObjectSetInteger(0, "panel_tab2", OBJPROP_HIDDEN, false);
         // mostra label de panel_tab2 se existir
         ObjectSetInteger(0, "panel_tab2_label", OBJPROP_HIDDEN, false);
        }
      else // panel_tab1 escondido -> mostrar panel_tab1 e esconder panel_tab2
        {
         ObjectSetInteger(0, "panel_tab2", OBJPROP_HIDDEN, true);
         ObjectSetInteger(0, "panel_tab1", OBJPROP_HIDDEN, false);
         ObjectSetInteger(0, "panel_tab2_label", OBJPROP_HIDDEN, true);
        }
     }
  }

//+------------------------------------------------------------------+
//| ShowWindow                                                       |
//+------------------------------------------------------------------+
void CUIApp::ShowWindow(void)
  {
   if(!m_initialized)
      return;

   ObjectSetInteger(0, m_wndName, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
   ObjectSetInteger(0, m_prefix + "Title", OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);
   ObjectSetInteger(0, m_labelName, OBJPROP_TIMEFRAMES, OBJ_ALL_PERIODS);

   m_isWindowVisible = true;

   CStateManager* sm = NULL;
   if(m_appController != NULL)
      sm = m_appController.StateManager();

   if(sm != NULL)
      sm.SetUIRunning(true);

   ChartRedraw();
  }

//+------------------------------------------------------------------+
//| HideWindow                                                       |
//+------------------------------------------------------------------+
void CUIApp::HideWindow(void)
  {
   if(!m_initialized)
      return;

   ObjectSetInteger(0, m_wndName, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
   ObjectSetInteger(0, m_prefix + "Title", OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
   ObjectSetInteger(0, m_btnTesteName, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
   ObjectSetInteger(0, m_btnTeste2Name, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);
   ObjectSetInteger(0, m_labelName, OBJPROP_TIMEFRAMES, OBJ_NO_PERIODS);

   m_isWindowVisible = false;

   CStateManager* sm = NULL;
   if(m_appController != NULL)
      sm = m_appController.StateManager();

   if(sm != NULL)
      sm.SetUIRunning(false);

   ChartRedraw();
  }

//+------------------------------------------------------------------+
//| UpdateData                                                       |
//+------------------------------------------------------------------+
void CUIApp::UpdateData(void)
  {
   if(!m_initialized)
      return;

   //--- placeholder: atualiza dados em tempo real na UI
  }

//+------------------------------------------------------------------+
//| RefreshGrid                                                      |
//+------------------------------------------------------------------+
void CUIApp::RefreshGrid(void)
  {
   if(!m_initialized)
      return;

   //--- placeholder: refresh visual
  }

#endif // __UI_UI_APP_MQH__
