//+------------------------------------------------------------------+
//|                                           ui/MainWindow.mqh      |
//|                                  Copyright 2025, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#ifndef __UI_MAIN_WINDOW_MQH__
#define __UI_MAIN_WINDOW_MQH__

#include <Controls\Dialog.mqh>
#include <Controls\Button.mqh>
#include <Controls\Label.mqh>

//+------------------------------------------------------------------+
//| Janela Principal                                                 |
//+------------------------------------------------------------------+
class CMainWindow : public CAppDialog
  {
private:
   CLabel            m_titleLabel;
   CButton           m_btnClose;
   CButton           m_btnMinimize;
   int               m_width;
   int               m_height;
   int               m_clientOffsetX;
   int               m_clientOffsetY;
   bool              m_isWindowVisible;

   bool              CreateTitle(void);
   bool              CreateButtons(void);

public:
                     CMainWindow(void);
                    ~CMainWindow(void);

   //--- create/destroy
   bool              CreateMainWindow(void);
   void              DestroyMainWindow(void);

   //--- propriedades
   void              SetWindowSize(const int width, const int height);
   int               WindowWidth(void) const { return m_width; }
   int               WindowHeight(void) const { return m_height; }

   //--- client area
   int               ClientLeft(void) const;
   int               ClientTop(void) const;
   int               ClientWidth(void) const;
   int               ClientHeight(void) const;

   //--- visibility (flag interna para evitar conflito com CWnd)
   bool              CheckVisible(void) const { return m_isWindowVisible; }
   void              OpenWindow(void);
   void              CloseWindow(void);
  };

//+------------------------------------------------------------------+
//| Constructor                                                      |
//+------------------------------------------------------------------+
CMainWindow::CMainWindow(void)
   : m_width(800),
     m_height(600),
     m_clientOffsetX(10),
     m_clientOffsetY(40),
     m_isWindowVisible(false)
  {
  }

//+------------------------------------------------------------------+
//| Destructor                                                       |
//+------------------------------------------------------------------+
CMainWindow::~CMainWindow(void)
  {
   DestroyMainWindow();
  }

//+------------------------------------------------------------------+
//| CreateMainWindow                                                 |
//+------------------------------------------------------------------+
bool CMainWindow::CreateMainWindow(void)
  {
   long chartWidth = ChartGetInteger(0, CHART_WIDTH_IN_PIXELS);
   long chartHeight = ChartGetInteger(0, CHART_HEIGHT_IN_PIXELS);
   int x1 = (int)((chartWidth - m_width) / 2);
   int y1 = (int)((chartHeight - m_height) / 2);

   if(!CAppDialog::Create(0, "EasyOpcoesPro", 0, x1, y1, x1 + m_width, y1 + m_height))
     {
      Print("MainWindow :: Falha ao criar diálogo");
      return false;
     }

   if(!CreateTitle())
      return false;

   if(!CreateButtons())
      return false;

   return true;
  }

//+------------------------------------------------------------------+
//| DestroyMainWindow                                                |
//+------------------------------------------------------------------+
void CMainWindow::DestroyMainWindow(void)
  {
   CAppDialog::Destroy();
   m_isWindowVisible = false;
  }

//+------------------------------------------------------------------+
//| CreateTitle                                                      |
//+------------------------------------------------------------------+
bool CMainWindow::CreateTitle(void)
  {
   int x1 = 10;
   int y1 = 5;
   int x2 = x1 + 200;
   int y2 = y1 + 20;

   if(!m_titleLabel.Create(0, "TitleLabel", 0, x1, y1, x2, y2))
      return false;

   m_titleLabel.Text("EasyOpcoesPro v1.0");
   m_titleLabel.Color(clrWhite);
   if(!Add(m_titleLabel))
      return false;

   return true;
  }

//+------------------------------------------------------------------+
//| CreateButtons                                                    |
//+------------------------------------------------------------------+
bool CMainWindow::CreateButtons(void)
  {
   int x1 = m_width - 80;
   int y1 = 5;
   int x2 = x1 + 30;
   int y2 = y1 + 20;

   if(!m_btnMinimize.Create(0, "BtnMinimize", 0, x1, y1, x2, y2))
      return false;
   m_btnMinimize.Text("-");
   if(!Add(m_btnMinimize))
      return false;

   x1 = x2 + 5;
   x2 = x1 + 30;

   if(!m_btnClose.Create(0, "BtnClose", 0, x1, y1, x2, y2))
      return false;
   m_btnClose.Text("X");
   if(!Add(m_btnClose))
      return false;

   return true;
  }

//+------------------------------------------------------------------+
//| SetWindowSize                                                    |
//+------------------------------------------------------------------+
void CMainWindow::SetWindowSize(const int width, const int height)
  {
   m_width = width;
   m_height = height;
  }

//+------------------------------------------------------------------+
//| ClientLeft                                                       |
//+------------------------------------------------------------------+
int CMainWindow::ClientLeft(void) const
  {
   return Left() + m_clientOffsetX;
  }

//+------------------------------------------------------------------+
//| ClientTop                                                        |
//+------------------------------------------------------------------+
int CMainWindow::ClientTop(void) const
  {
   return Top() + m_clientOffsetY;
  }

//+------------------------------------------------------------------+
//| ClientWidth                                                      |
//+------------------------------------------------------------------+
int CMainWindow::ClientWidth(void) const
  {
   return m_width - (m_clientOffsetX * 2);
  }

//+------------------------------------------------------------------+
//| ClientHeight                                                     |
//+------------------------------------------------------------------+
int CMainWindow::ClientHeight(void) const
  {
   return m_height - m_clientOffsetY - m_clientOffsetX;
  }

//+------------------------------------------------------------------+
//| OpenWindow                                                       |
//+------------------------------------------------------------------+
void CMainWindow::OpenWindow(void)
  {
   CAppDialog::Show();
   m_isWindowVisible = true;
  }

//+------------------------------------------------------------------+
//| CloseWindow                                                      |
//+------------------------------------------------------------------+
void CMainWindow::CloseWindow(void)
  {
   CAppDialog::Hide();
   m_isWindowVisible = false;
  }

#endif // __UI_MAIN_WINDOW_MQH__
