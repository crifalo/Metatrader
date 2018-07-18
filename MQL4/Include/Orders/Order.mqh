//+------------------------------------------------------------------+
//|                                                        Order.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Common\ValidationResult.mqh>
#include <Common\Comparators.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class  Order
  {
public:
   string            symbol;        // symbol
   ENUM_ORDER_TYPE   orderType;     // operation
   double            volume;        // volume
   double            price;         // price
   int               slippage;      // slippage
   double            stoploss;      // stop loss
   double            takeprofit;    // take profit
   string            comment;       // comment
   int               magic;         // magic number
   datetime          expiration;    // pending order expiration
   color             arrow_color;   // color
   void              Order();
   bool              Validate(ValidationResult *validationResult);
   bool              Validate();
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
Order::Order()
  {
   this.comment=NULL;
   this.magic=0;
   this.expiration=0;
   this.arrow_color=clrNONE;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Order::Validate()
  {
   ValidationResult *v=new ValidationResult();
   bool out=this.Validate(v);
   delete v;
   return out;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool Order::Validate(ValidationResult *validationResult)
  {
   Comparators compare;
   validationResult.Result=true;

// check that lots are between the min and max allowed.
// order price must make sense
// is there a max to slippage
   if(compare.IsLessThan(this.slippage,0))
     {
      validationResult.Result=false;
      validationResult.AddMessage("Slippage must be zero or greater.");
     }
// check that stop loss is valid
// check that take profit is valid
// check that expiration time is a valid date in the future, and that the order type is one of the pending kind
// check that the arrow color is a valid color
//
//
//At opening of a market order (OP_SELL or OP_BUY), only the latest prices of Bid (for selling) or Ask
//(for buying) can be used as open price. If operation is performed with a security differing from the
//current one, the MarketInfo() function must be used with MODE_BID or MODE_ASK parameter for the latest
//quotes for this security to be obtained.
//
//Calculated or unnormalized price cannot be applied. If there has not been the requested open price in
//the price thread or it has not been normalized according to the amount of digits after decimal point,
//the error 129 (ERR_INVALID_PRICE) will be generated. If the requested open price is fully out of date,
//the error 138 (ERR_REQUOTE) will be generated independently on the slippage parameter. If the requested
//price is out of date, but present in the thread, the order will be opened at the current price and only
//if the current price lies within the range of price+-slippage.
//
//StopLoss and TakeProfit levels cannot be too close to the market. The minimal distance of stop levels in
//points can be obtained using the MarketInfo() function with MODE_STOPLEVEL parameter. In the case of
//erroneous or unnormalized stop levels, the error 130 (ERR_INVALID_STOPS) will be generated. A zero value
//of MODE_STOPLEVEL means either absence of any restrictions on the minimal distance for Stop Loss/Take Profit
//or the fact that a trade server utilizes some external mechanisms for dynamic level control, which cannot
//be translated in the client terminal. In the second case, GetLastError() can return error 130, because
//MODE_STOPLEVEL is actually "floating" here.
//
//At placing of a pending order, the open price cannot be too close to the market. The minimal distance of
//the pending price from the current market one in points can be obtained using the MarketInfo() function with
//the MODE_STOPLEVEL parameter. In case of false open price of a pending order, the error 130 (ERR_INVALID_STOPS)
//will be generated.
//
//Applying of pending order expiration time can be disabled in some trade servers. In this case, when a non-zero
//value is specified in the expiration parameter, the error 147 (ERR_TRADE_EXPIRATION_DENIED) will be generated.
//
//On some trade servers, the total amount of open and pending orders can be limited. If this limit has been
//exceeded, no new order will be opened (or no pending order will be placed) and trade server will return error
//148 (ERR_TRADE_TOO_MANY_ORDERS).


   return validationResult.Result;
  }
//+------------------------------------------------------------------+
