//+------------------------------------------------------------------+
//|                                               LastClosedBase.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict

#include <Common\OrderManager.mqh>
#include <Signals\AbstractSignal.mqh>
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class LastClosedBase : public AbstractSignal
  {
protected:
   virtual PriceRange CalculateRange(string symbol,int shift,double midPrice);
   int LastClosedBase::GetLastClosedTicketNumber(string symbol);

public:
                     LastClosedBase(int period,ENUM_TIMEFRAMES timeframe,int shift=0,double minimumSpreadsTpSl=1);
   virtual bool      DoesSignalMeetRequirements();
   virtual bool      Validate(ValidationResult *v);
  };
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
LastClosedBase::LastClosedBase(int period,ENUM_TIMEFRAMES timeframe,int shift=0,double minimumSpreadsTpSl=1):AbstractSignal(period,timeframe,shift,clrNONE,minimumSpreadsTpSl)
  {
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool LastClosedBase::Validate(ValidationResult *v)
  {
   AbstractSignal::Validate(v);

   return v.Result;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool LastClosedBase::DoesSignalMeetRequirements()
  {
   if(!(AbstractSignal::DoesSignalMeetRequirements()))
     {
      return false;
     }

   return true;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
PriceRange LastClosedBase::CalculateRange(string symbol,int shift,double midPrice)
  {
   PriceRange pr;
   pr.mid=midPrice;
   double atr=(this.GetAtr(symbol,shift)/2);
   pr.low=(pr.mid-atr);
   pr.high=(pr.mid+atr);
   return pr;
  }
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int LastClosedBase::GetLastClosedTicketNumber(string symbol)
  {
   return OrderManager::GetLastClosedOrderTicket(symbol);
  }
//+------------------------------------------------------------------+
