//+------------------------------------------------------------------+
//|                                                       Colors.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Colors
  {
public:

   static uint Argb(uchar a,uchar r,uchar g,uchar b)
     {
      return ((uint)((uchar(a)<<24)|(uchar(r)<<16)|(uchar(g)<<8)|uchar(b)));
     }
   static uint ArgbFromColor(color clr,uchar alpha=255)
     {
      return ColorToARGB(clr,alpha);
     }
  };
//+------------------------------------------------------------------+
