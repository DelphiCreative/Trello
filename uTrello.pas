unit uTrello;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.PlatForm, FMX.Objects, FMX.Layouts;

type
  TForm1 = class(TForm)
    Rectangle2: TRectangle;
    Rectangle3: TRectangle;
    Rectangle4: TRectangle;
    VertScrollBox1: TVertScrollBox;
    Rectangle5: TRectangle;
    Rectangle6: TRectangle;
    Rectangle7: TRectangle;
    VertScrollBox2: TVertScrollBox;
    Rectangle8: TRectangle;
    Rectangle10: TRectangle;
    Rectangle11: TRectangle;
    Text1: TText;
    Text3: TText;
    Rectangle1: TRectangle;
    Text2: TText;
    Rectangle9: TRectangle;
    Text4: TText;
    Rectangle12: TRectangle;
    Text5: TText;
    Rectangle13: TRectangle;
    Text6: TText;
    Rectangle14: TRectangle;
    Rectangle15: TRectangle;
    Rectangle16: TRectangle;
    VertScrollBox3: TVertScrollBox;
    Rectangle17: TRectangle;
    Text7: TText;
    Rectangle18: TRectangle;
    Text8: TText;
    Rectangle19: TRectangle;
    Rectangle20: TRectangle;
    Rectangle21: TRectangle;
    VertScrollBox4: TVertScrollBox;
    Rectangle22: TRectangle;
    Text9: TText;
    Rectangle23: TRectangle;
    Text10: TText;
    Rectangle24: TRectangle;
    Text11: TText;
    Rectangle25: TRectangle;
    Text12: TText;
    procedure Rectangle1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Single);
    procedure Rectangle1DragOver(Sender: TObject; const Data: TDragObject;
      const Point: TPointF; var Operation: TDragOperation);
    procedure Rectangle1DragDrop(Sender: TObject; const Data: TDragObject;
      const Point: TPointF);
  private
    { Private declarations }
  lastOver :TControl;
  posY :Single;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.Rectangle1DragDrop(Sender: TObject; const Data: TDragObject;
  const Point: TPointF);
begin
   if lastOver <> nil then begin
      lastOver.Margins.Top := 5;
      lastOver.Margins.Bottom := 0;
   end;

   if Sender is TVertScrollBox then
      TControl(Sender).AddObject(TControl(Data.Source))
   else TControl(Sender).Parent.AddObject(TControl(Data.Source));

   TControl(Data.Source).Position.Y := posY;

end;

procedure TForm1.Rectangle1DragOver(Sender: TObject; const Data: TDragObject;
  const Point: TPointF; var Operation: TDragOperation);
begin
   Operation := TDragOperation.Copy;

   if Sender is TVertScrollBox then begin
      posY := Point.Y - 20;
      Exit;
   end;

   if lastOver <> nil then begin
      lastOver.Margins.Top := 5;
      lastOver.Margins.Bottom := 0;
   end;

   if Point.Y < 20 then
      TControl(Sender).Margins.Top := 20
   else
      TControl(Sender).Margins.Top := 5;

   if Point.Y > TControl(Sender).Height -20 then
      TControl(Sender).Margins.Bottom := 20
   else
      TControl(Sender).Margins.Bottom := 0;

   if Point.Y < TControl(Sender).Height / 2 then
      posY := TControl(Sender).Position.Y -  TControl(Sender).Margins.top -1
   else
      posY := TControl(Sender).Position.Y + TControl(Sender).Margins.Bottom +  TControl(Sender).Height + 1;

   lastOver := TControl(Sender);
end;

procedure TForm1.Rectangle1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Single);
var
  dcService :IFMXDragDropService;
  dcDragObject :TDragObject;
  dcBitmap :TBitmap;
begin

  if TPlatformServices.Current.SupportsPlatformService(IFMXDragDropService, dcService) then begin
     dcBitmap := TControl(Sender).MakeScreenshot;
     dcDragObject.Source := Sender;
     dcDragObject.Data := dcBitmap;
     try
       dcService.BeginDragDrop(Application.MainForm,dcDragObject,dcBitmap);
     finally
       dcBitmap.Free;
     end;

  end;

end;

end.
