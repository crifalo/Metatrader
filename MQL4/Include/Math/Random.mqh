//+------------------------------------------------------------------+
//|                                                       Random.mqh |
//|                                 Copyright © 2017, Matthew Kastor |
//|                                 https://github.com/matthewkastor |
//+------------------------------------------------------------------+
#property copyright "Matthew Kastor"
#property link      "https://github.com/matthewkastor"
#property strict
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class Random
  {
public:
   //+------------------------------------------------------------------+
   //|                                                                  |
   //+------------------------------------------------------------------+
   static double Number()
     {
      return (double)MathRand()/(double)32767;
     }
   //+------------------------------------------------------------------+
   //|                                                                  |
   //+------------------------------------------------------------------+
   static double Number(double min,double max)
     {
      double range=max-min;
      return min+(Random::Number()*range);
     }
   //+------------------------------------------------------------------+
   //|                                                                  |
   //+------------------------------------------------------------------+
   static int Number(int min,int max)
     {
      return (int)MathFloor(Random::Number((double)min,(double)max));
     }
   //+------------------------------------------------------------------+
   //|                                                                  |
   //+------------------------------------------------------------------+
   static uint Number(uint min,uint max)
     {
      return (uint)MathFloor(Random::Number((double)min,(double)max));
     }
   //+------------------------------------------------------------------+
   //|                                                                  |
   //+------------------------------------------------------------------+
   static uchar Number(uchar min,uchar max)
     {
      return (uchar)MathFloor(Random::Number((double)min,(double)max));
     }
  };
//+------------------------------------------------------------------+
