//+------------------------------------------------------------------+
//|                                            EasyOpcoesPro         |
//|                                    Utilitários de Formatação     |
//|                                           (FUTURO / PLACEHOLDER) |
//+------------------------------------------------------------------+
#ifndef FORMAT_UTILS_MQH
#define FORMAT_UTILS_MQH

//+------------------------------------------------------------------+
//| Classe de utilitários para formatação de dados do sistema        |
//+------------------------------------------------------------------+
class CFormatUtils
  {
public:
   //--- Formata valor monetário no padrão brasileiro (R$)
   static string     FormatCurrency(const double value, const int decimals = 2);

   //--- Formata percentual
   static string     FormatPercent(const double value, const int decimals = 2);

   //--- Formata data no padrão brasileiro (DD/MM/YYYY)
   static string     FormatDate(const datetime dt);

   //--- Formata data e hora (DD/MM/YYYY HH:MM)
   static string     FormatDateTime(const datetime dt);

   //--- Formata strike de opção com casas decimais apropriadas
   static string     FormatStrike(const double strike);

   //--- Formata volume/lote
   static string     FormatVolume(const long volume);

   //--- Formatar gregas (delta, gamma, etc.) com sinal e casas decimais
   static string     FormatGreek(const double value, const int decimals = 4);

   //--- Converte string de vencimento para datetime (formato B3: "18/01/2025")
   static datetime   ParseExpirationDate(const string dateStr);

   //--- Formata PnL com cor indicativa (+ verde, - vermelho markup não aplicável em MQL5 puro)
   static string     FormatPnL(const double pnl);
  };

//--- Formata valor monetário
string CFormatUtils::FormatCurrency(const double value, const int decimals = 2)
  {
   return StringFormat("R$ %.*f", decimals, value);
  }

//--- Formata percentual
string CFormatUtils::FormatPercent(const double value, const int decimals = 2)
  {
   return StringFormat("%.*f%%", decimals, value * 100);
  }

//--- Formata data
string CFormatUtils::FormatDate(const datetime dt)
  {
   MqlDateTime t;
   TimeToStruct(dt, t);
   return StringFormat("%02d/%02d/%04d", t.day, t.mon, t.year);
  }

//--- Formata data e hora
string CFormatUtils::FormatDateTime(const datetime dt)
  {
   MqlDateTime t;
   TimeToStruct(dt, t);
   return StringFormat("%02d/%02d/%04d %02d:%02d", t.day, t.mon, t.year, t.hour, t.min);
  }

//--- Formata strike (até 2 casas para índices, 4 para ações)
string CFormatUtils::FormatStrike(const double strike)
  {
   return StringFormat("%.2f", strike);
  }

//--- Formata volume
string CFormatUtils::FormatVolume(const long volume)
  {
   if(volume >= 1000000)
      return StringFormat("%.1fM", volume / 1000000.0);
   if(volume >= 1000)
      return StringFormat("%.1fK", volume / 1000.0);
   return IntegerToString(volume);
  }

//--- Formata grega
string CFormatUtils::FormatGreek(const double value, const int decimals = 4)
  {
   return StringFormat("%+.*f", decimals, value);
  }

//--- Parse de data de vencimento (placeholder)
datetime CFormatUtils::ParseExpirationDate(const string dateStr)
  {
   // Implementação futura: parser de string "DD/MM/YYYY" para datetime
   return StringToTime(dateStr); // placeholder simples
  }

//--- Formata PnL
string CFormatUtils::FormatPnL(const double pnl)
  {
   if(pnl > 0)
      return StringFormat("+%.2f", pnl);
   return StringFormat("%.2f", pnl);
  }

#endif // FORMAT_UTILS_MQH
