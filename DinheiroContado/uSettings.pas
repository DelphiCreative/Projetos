unit uSettings;

interface

uses
  System.UITypes, System.Generics.Collections, FMX.Objects, FMX.Graphics, FMX.Layouts, FMX.Ani, FMX.Forms;



const
   PastaCategoria = 'Categorias';
   PastaSubCategoria = 'SubCategoria';

   ColorWhite = TAlphaColors.White;
   ColorPagar =  TAlphaColors.Crimson;
   ColorReceber = TAlphaColors.Seagreen;
   ColorPadrao = TAlphaColors.Steelblue;

  ColorsCount = 11;

  Colors: array[0..ColorsCount-1] of TAlphaColor = (
    TAlphaColorRec.White,
    TAlphaColorRec.Darkseagreen,
    TAlphaColorRec.Aquamarine,
    TAlphaColorRec.Coral,
    TAlphaColorRec.Deepskyblue,
    TAlphaColorRec.Darkturquoise,
    TAlphaColorRec.Gold,
    TAlphaColorRec.Hotpink,
    TAlphaColorRec.Purple,
    TAlphaColorRec.Gainsboro,
    TAlphaColorRec.Black
  );


  ColorsGraph: array[0..23] of TAlphaColor = (
    TAlphaColorRec.Steelblue,
    TAlphaColorRec.Forestgreen,
    TAlphaColorRec.Orangered,
    TAlphaColorRec.Gold,
    TAlphaColorRec.Dodgerblue,
    TAlphaColorRec.Red,
    TAlphaColorRec.Blue,
    TAlphaColorRec.Magenta,
    TAlphaColorRec.Brown,
    TAlphaColorRec.Grey,
    TAlphaColorRec.Lightgreen,
    TAlphaColorRec.Black,
    TAlphaColorRec.Pink,
    TAlphaColorRec.White,
    TAlphaColorRec.Darkseagreen,
    TAlphaColorRec.Aquamarine,
    TAlphaColorRec.Coral,
    TAlphaColorRec.Deepskyblue,
    TAlphaColorRec.Darkturquoise,
    TAlphaColorRec.Gold,
    TAlphaColorRec.Hotpink,
    TAlphaColorRec.Purple,
    TAlphaColorRec.Gainsboro,
    TAlphaColorRec.Black
  );



var

   JSONChart, IDCategoria :String;

   ListLayout,ListContas : TObjectList<TLayout>;
   ListCategorias, ListHCategorias : TObjectList<TRectangle>;
   ListaAnima,
   ListAnimaEntrada,
   ListAnimaSaida : TObjectList<TFloatAnimation>;
   FrameList :  TObjectList<TFrame>;
   ListIcones, ListCores : TObjectList<TCircle>;


implementation



initialization

   ListAnimaEntrada := TObjectList<TFloatAnimation>.Create;
   ListAnimaEntrada.OwnsObjects := True;

   ListAnimaSaida := TObjectList<TFloatAnimation>.Create;
   ListAnimaSaida.OwnsObjects := True;

   ListaAnima := TObjectList<TFloatAnimation>.Create;
   ListaAnima.OwnsObjects := True;

   ListLayout := TObjectList<TLayout>.Create;
   ListLayout.OwnsObjects := True;

   ListContas := TObjectList<TLayout>.Create;
   ListContas.OwnsObjects := True;

   ListCategorias := TObjectList<TRectangle>.Create;
   ListCategorias.OwnsObjects := True;

   ListHCategorias := TObjectList<TRectangle>.Create;
   ListHCategorias.OwnsObjects := True;

   ListIcones := TObjectList<TCircle>.Create;
   ListIcones.OwnsObjects := True;

   ListCores := TObjectList<TCircle>.Create;
   ListCores.OwnsObjects := True;

   FrameList :=  TObjectList<TFrame>.Create;
   FrameList.OwnsObjects := True;



end.
