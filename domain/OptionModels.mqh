//+------------------------------------------------------------------+
//|                                            EasyOpcoesPro         |
//|                                    Modelos de Dados - Opções     |
//+------------------------------------------------------------------+
#ifndef OPTION_MODELS_MQH
#define OPTION_MODELS_MQH

//--- Estrutura que representa uma opção (call/put)
struct Option
  {
   string            symbol;           // Símbolo do ativo
   string            optionSymbol;     // Símbolo da opção
   ENUM_OPTION_TYPE  type;             // CALL ou PUT
   double            strike;           // Preço de exercício
   datetime          expiration;       // Data de vencimento
   double            premium;          // Prêmio atual
   double            delta;            // Grega Delta
   double            gamma;            // Grega Gamma
   double            theta;            // Grega Theta
   double            vega;             // Grega Vega
   double            rho;              // Grega Rho
   double            iv;               // Volatilidade implícita
   long              volume;           // Volume negociado
   long              openInterest;     // Interesse aberto
  };

//--- Enumeração do tipo de opção
enum ENUM_OPTION_TYPE
  {
   OPTION_CALL = 0,                    // Opção de compra
   OPTION_PUT  = 1                     // Opção de venda
  };

//--- Estrutura de cadeia de opções (option chain) para um ativo
struct OptionChain
  {
   string            underlying;       // Ativo-objeto
   datetime          expirationDate;   // Vencimento da série
   Option            calls[];          // Array de calls
   Option            puts[];           // Array de puts
   double            spotPrice;        // Preço spot do ativo
   double            historicalVol;    // Volatilidade histórica
  };

//--- Estrutura de posição em opções
struct OptionPosition
  {
   ulong             ticket;           // Ticket da ordem/posição
   string            optionSymbol;     // Símbolo da opção
   ENUM_OPTION_TYPE  type;             // CALL ou PUT
   double            strike;           // Strike
   datetime          expiration;       // Vencimento
   double            entryPrice;       // Preço de entrada
   double            quantity;         // Quantidade (lotes)
   double            currentPremium;   // Prêmio atual
   double            unrealizedPnL;    // Lucro/prejuízo não realizado
   datetime          openTime;         // Horário de abertura
  };

#endif // OPTION_MODELS_MQH

