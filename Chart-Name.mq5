//+------------------------------------------------------------------+
//|                                                   Chart-Name.mq5 |
//|                                        Copyright 2019, N.Martin. |
//|                                  http://nigel-forex.blogspot.com |
//+------------------------------------------------------------------+

#property copyright "Copyright 2019, N.Martin"
#property link      "http://nigel-forex.blogspot.com/"
#property version   "1.00"
#property indicator_chart_window

input color LabelColor = clrBlack; // Label Color
string strPeriod = "";

bool OneClick = false; 
int xCol = 0; 
int yRow = 0; 

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
{
   renderLabels();
   return(INIT_SUCCEEDED);
}
  
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
{
   ObjectDelete(0, "Symbol-Name");
   ObjectDelete(0, "Symbol-Desc");
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,     // price[] array size  
                const int prev_calculated, // number of previously handled bars 
                const int begin,           // where significant data start from  
                const double &price[])     // value array for handling 
{ 
//---
   
//--- return value of prev_calculated for next call
   return(rates_total);
}

//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
{

   if (id == CHARTEVENT_CHART_CHANGE) 
   { 
      renderLabels();
      ChartRedraw();
   }  
}
  
//+------------------------------------------------------------------+
//|  Functions                                                       |
//+------------------------------------------------------------------+
void renderLabels()
{
   // Trade Panel visible? 
   OneClick = ChartGetInteger(0, CHART_SHOW_ONE_CLICK, 0);   
   if(OneClick == true) { yRow = 90; }
   else { yRow = 24; }
   
   // Get the timeframe / period
   strPeriod = EnumToString(_Period); 
   StringReplace(strPeriod, "PERIOD_", "");   
   
   // Plot Label
   Label("Symbol-Name", _Symbol + " - " + strPeriod, 12, yRow, LabelColor, "Tahoma", 20);
   Label("Symbol-Desc", SymbolInfoString(_Symbol,SYMBOL_DESCRIPTION), 14, yRow+36, LabelColor, "Tahoma", 12);
}
//+------------------------------------------------------------------+

void Label(string objName, string text, int xPos, int yPos, color labelColor, string fontFace, int fontSize)
{
      ObjectDelete(0,    objName); 
      ObjectCreate(0,    objName,OBJ_LABEL,0,0,0);           
      ObjectSetInteger(0,objName,OBJPROP_XDISTANCE, xPos);
      ObjectSetInteger(0,objName,OBJPROP_YDISTANCE, yPos);
      ObjectSetInteger(0,objName,OBJPROP_COLOR, labelColor);
      ObjectSetInteger(0,objName,OBJPROP_FONTSIZE, fontSize);
      ObjectSetInteger(0,objName,OBJPROP_SELECTABLE,false);
      ObjectSetString(0, objName,OBJPROP_FONT, fontFace);
      ObjectSetString(0, objName,OBJPROP_TEXT, text);      
}
//+------------------------------------------------------------------+