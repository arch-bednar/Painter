unit Painter;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.Menus,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.ExtDlgs,
  jpeg,
  pngimage,
  Vcl.Buttons;

type
  TWindowPainter = class(TForm)
    MainMenu: TMainMenu;
    Niewfile1: TMenuItem;
    New1: TMenuItem;
    Open1: TMenuItem;
    Open2: TMenuItem;
    SaveAs1: TMenuItem;
    Quit1: TMenuItem;
    Edi1: TMenuItem;
    Undo1: TMenuItem;
    Undo2: TMenuItem;
    Delete1: TMenuItem;
    Copy1: TMenuItem;
    Copy2: TMenuItem;
    Filters1: TMenuItem;
    ScrollBox1: TScrollBox;
    Options1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    ColorsPanel: TPanel;
    PanelDetails: TPanel;
    ToolPanel: TPanel;
    DefaultColorsPanel: TPanel;
    RightClickPanel: TPanel;
    DefaultColorPanel: TPanel;
    ColorPanelBlack: TPanel;
    ColorPanelWhite: TPanel;
    ColorPanelGray: TPanel;
    ColorPanelSilver: TPanel;
    ColorPanelMaroon: TPanel;
    ColorPanelRed: TPanel;
    ColorPanelOlive: TPanel;
    ColorPanelYellow: TPanel;
    ColorPanelGreen: TPanel;
    ColorPanelLime: TPanel;
    ColorTeal: TPanel;
    ColorAqua: TPanel;
    ColorNavy: TPanel;
    ColorBlue: TPanel;
    ColorPurple: TPanel;
    ColorFuchsia: TPanel;
    ColorOlive2: TPanel;
    ColorLightYellow: TPanel;
    ColorDarkGreen: TPanel;
    ColorSeaFoam: TPanel;
    ColorAzure: TPanel;
    ColorElectric: TPanel;
    ColorRoyal: TPanel;
    ColorIris: TPanel;
    ColorViolet: TPanel;
    ColorMagenta: TPanel;
    ColorBrown: TPanel;
    ColorOrange: TPanel;
    Panel2: TPanel;
    BtnCustomSelect: TSpeedButton;
    BtnRectangleSelect: TSpeedButton;
    BtnRubber: TSpeedButton;
    BtnInk: TSpeedButton;
    BtnSampler: TSpeedButton;
    BtnZoom: TSpeedButton;
    BtnPencil: TSpeedButton;
    BtnBrush: TSpeedButton;
    BtnSpray: TSpeedButton;
    BtnText: TSpeedButton;
    BtnLine: TSpeedButton;
    BtnCursive: TSpeedButton;
    BtnRectangle: TSpeedButton;
    BtnCustomFig: TSpeedButton;
    BtnEllipse: TSpeedButton;
    BtnSquareCircle: TSpeedButton;
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBox1MouseLeave(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Open1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseActivate(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y, HitTest: Integer;
      var MouseActivate: TMouseActivate);
    procedure PaintBox1DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure OnClickChangeColor(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnClickSwitchColor(Sender: TObject);
    procedure PressToolButton(Sender: TObject);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
    PointNW: TPoint;
    PointN: TPoint;
    PointNE: TPoint;
    PointE: TPoint;
    PointSE: TPoint;
    PointS: TPoint;
    PointSW: TPoint;
    PointW: TPoint;
  public
    { Public declarations }
    PaintMode: (pmNone, pmCustomSelection, pmSquareSelection, pmRubber, pmInk, pmSampler, pmPencil, pmSpray, pmText, pmLine, pmCursive, pmRectangle, pmPolygon, pmElipse, pmSquareCircle);
  end;

var
  WindowPainterForm: TWindowPainter;

implementation

{$R *.dfm}



procedure TWindowPainter.Open1Click(Sender: TObject);
var
  selectedFile: String; //selects file
  dlg: TOpenDialog; //opens dialog to select file
  Image: TBitmap;
begin
  selectedFile := '';
  dlg := TOpenDialog.Create(nil);
  try
    dlg.InitialDir := 'C:\';
    dlg.Filter := 'All files (*.*)|*.*|Bitmap (*.bmp)|*.bmp';
    if dlg.Execute(Handle) then
      selectedFile := dlg.FileName;

    Image := TBitMap.Create();
    Image.LoadFromFile(selectedFile);
    //PaintBox1.
    //Panel1.AutoSize := true;
    //Panel1.Width := Image.Width;
    //Panel1.Height := Image.Height;
    //PaintBox1.Width := Image.Width;
    //PaintBox1.Height := Image.Height;
    //PaintBox1.Align := alClient;
    PaintBox1.Canvas.Draw(0,0,Image);

  finally
    dlg.Free;
  end;
end;

procedure TWindowPainter.PaintBox1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  //PaintBox1.Canvas.Pixels[x,y] := clBlue;
end;

procedure TWindowPainter.PaintBox1MouseActivate(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y, HitTest: Integer;
  var MouseActivate: TMouseActivate);
begin
//    PaintBox1.Canvas.Pixels[x, y] := clBlue; //<-dzia³a
end;

procedure TWindowPainter.PaintBox1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //Canvas.MoveTo(x,y);
  PaintMode := pmPencil;
  PaintBox1.Canvas.Brush.Color := clBlue;
  //PaintBox1.Canvas.Pixels[x, y] := clBlue; //<-dzia³a
  //PaintBox1.Canvas.FloodFill(x,y,clBlue, TFillStyle.fsSurface);
  //PaintBox1.Canvas.Rectangle(0,0,20,20);
  PaintBox1.Canvas.LineTo(x,y);
end;

procedure TWindowPainter.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Label1.Caption := IntToStr(x) + ' ' + IntToStr(y);
  //PaintBox1.Canvas.SetPixel(x,y,clRed);
  PaintBox1.Canvas.Pen.Width := 2;
//  PaintBox1.Canvas.MoveTo(x,y);
  //PaintBox1.Canvas.LineTo(x,y);
  if PaintMode = pmPencil then
    //PaintBox1.Canvas.MoveTo(x,y);
    PaintBox1.Canvas.LineTo(x,y)
  else
    PaintBox1.Canvas.MoveTo(x,y);
end;

procedure TWindowPainter.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PaintMode := pmNone;
end;

procedure TWindowPainter.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  point: TPoint;
begin
  //point := CursorPos;
//  Label1.Caption := IntToStr(x) + ' ' + IntToStr(y);

  if IntToStr(point.X) = IntToStr(ScrollBox1.Width-1) then
  begin
    if IntToStr(point.Y) = IntToStr(ScrollBox1.Height-1) then
      Screen.Cursor := crSizeNESW;
  end;

end;

procedure TWindowPainter.SaveAs1Click(Sender: TObject);
var
  b: boolean;
  saveDlg: TSavePictureDialog;
  Bitmap: TBitmap;
  row, col: Integer;
  Canvas: TCanvas;
begin
  saveDlg := TSavePictureDialog.Create(nil);
  try
    //saveDlg.Filter := '
    b := saveDlg.Execute(Handle);
    try
      Bitmap := TBitmap.Create();
      Bitmap.Height := PaintBox1.Height;
      Bitmap.Width := PaintBox1.Width;
      for row := 0 to Bitmap.Height-1 do
        for col := 0 to Bitmap.Width-1 do
          Bitmap.Canvas.Pixels[row, col] := PaintBox1.Canvas.Pixels[row, col];

      //Bitmap.Canvas.Assign(PaintBox1.Canvas);
//      Canvas.Assign(PaintBox1.Canvas);
//      Bitmap.Canvas.Assign(Canvas);

      if FileExists(saveDlg.FileName) then
        raise Exception.Create('File Exists!')
      else
        Bitmap.SaveToFile(saveDlg.FileName);

    finally
      Bitmap.Free;
    end;
  finally
     saveDlg.Free;
  end;
end;

procedure TWindowPainter.ScrollBox1MouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TWindowPainter.ScrollBox1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Label2.Caption := IntToStr(x) + ' ' + IntToStr(y);
//    if X - ScrollBox1.Width <= 10 then
//      if Y - ScrollBox1.Height <= 10 then
//        Screen.Cursor := crSizeNESW;

end;

procedure TWindowPainter.OnClickChangeColor(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  for I := 0 to DefaultColorsPanel.ControlCount -1 do
    if Sender = DefaultColorsPanel.Controls[i] then
    begin
      if Button = mbLeft then
        DefaultColorPanel.Color := (Sender as TPanel).Color
      else if Button = mbRight then
        RightClickPanel.Color := (Sender as TPanel).Color;
    end;
end;

procedure TWindowPainter.OnClickSwitchColor(Sender: TObject);
var
  Color: TColor;
begin
    Color := RightClickPanel.Color;
    RightClickPanel.Color := DefaultColorPanel.Color;
    DefaultColorPanel.Color := Color;
end;

procedure TWindowPainter.PressToolButton(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ToolPanel.ControlCount - 1 do
    if Sender = (ToolPanel.Controls[i] as TSpeedButton) then
      (ToolPanel.Controls[i] as TSpeedButton).Down := true
    else
      (ToolPanel.Controls[i] as TSpeedButton).Down := false;

end;

end.