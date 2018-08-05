//+------------------------------------------------------------------+
//|                                        LastCloseFollowsPrice.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Signals\LastClosedBase.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class LastCloseFollowsPrice : public LastClosedBase
  {
private:
   bool              _invertedSignal;
public:
                     LastCloseFollowsPrice(int period,ENUM_TIMEFRAMES timeframe,double minimumSpreadsTpSl,bool invertSignal);
   SignalResult     *Analyzer(string symbol,int shift);
   void InvertedSignal(bool invertSignal) { this._invertedSignal=invertSignal; }
   bool InvertedSignal() { return this._invertedSignal; }
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
LastCloseFollowsPrice::LastCloseFollowsPrice(int period,ENUM_TIMEFRAMES timeframe,double minimumSpreadsTpSl,bool invertSignal):LastClosedBase(period,timeframe,0,minimumSpreadsTpSl)
  {
   this._invertedSignal=invertSignal;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
SignalResult *LastCloseFollowsPrice::Analyzer(string symbol,int shift)
  {
// if there are no orders open...
   if(0>=OrderManager::PairOpenPositionCount(symbol,TimeCurrent()))
     {
      MqlTick tick;
      bool gotTick=SymbolInfoTick(symbol,tick);
      // and there's a fresh tick on the symbol's chart
      if(gotTick)
        {
         int ticket=this.GetLastClosedTicketNumber(symbol);
         // if there is no order history, so no ticket to find
         if(ticket<=0)
           {
            PriceRange pr=this.CalculateRange(symbol,shift,tick.ask);
            this.Signal.isSet=true;
            this.Signal.orderType=OP_BUY;
            this.Signal.price=tick.ask;
            this.Signal.symbol=symbol;
            this.Signal.time=tick.time;
            this.Signal.stopLoss=pr.low;
            this.Signal.takeProfit=pr.high;
            if(!this.Signal.IsValid(this.MinimumSpreadsDistance()))
              {
               this.Signal.Reset();
              }
           }
         // if there is a closed order in the history
         if(ticket>0)
           {
            // and the closed order can be selected
            if(OrderSelect(ticket,SELECT_BY_TICKET,MODE_HISTORY)==true)
              {
               bool sellSignal=(OrderType()==OP_BUY && OrderProfit()<=0) || (OrderType()==OP_SELL && OrderProfit()>0);
               bool buySignal=(OrderType()==OP_SELL && OrderProfit()<=0) || (OrderType()==OP_BUY && OrderProfit()>0);
               // Sell when the last order was a buy order that lost, or a sell order that won
               if((sellSignal && !this._invertedSignal) || (buySignal && this._invertedSignal))
                 {
                  PriceRange pr=this.CalculateRange(symbol,shift,tick.bid);
                  this.Signal.isSet=true;
                  this.Signal.time=tick.time;
                  this.Signal.symbol=symbol;
                  this.Signal.orderType=OP_SELL;
                  this.Signal.price=tick.bid;
                  this.Signal.stopLoss=pr.high;
                  this.Signal.takeProfit=pr.low;
                  if(!this.Signal.IsValid(this.MinimumSpreadsDistance()))
                    {
                     this.Signal.Reset();
                    }
                 }
               // Buy when the last order was a sell order that lost, or a buy order that won
               else if((buySignal && !this._invertedSignal) || (sellSignal && this._invertedSignal))
                 {
                  PriceRange pr=this.CalculateRange(symbol,shift,tick.ask);
                  this.Signal.isSet=true;
                  this.Signal.orderType=OP_BUY;
                  this.Signal.price=tick.ask;
                  this.Signal.symbol=symbol;
                  this.Signal.time=tick.time;
                  this.Signal.stopLoss=pr.low;
                  this.Signal.takeProfit=pr.high;
                  if(!this.Signal.IsValid(this.MinimumSpreadsDistance()))
                    {
                     this.Signal.Reset();
                    }
                 }
              }
           }
        }
     }
   return this.Signal;
  }
//+------------------------------------------------------------------+
