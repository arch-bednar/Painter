unit Painter;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.IOUtils,
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
  Vcl.Buttons,
  StrUtils;

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
    ScrollBox: TScrollBox;
    Options1: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    PanelPaintBox: TPanel;
    PaintBox: TPaintBox;
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
    procedure ScrollBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ScrollBoxMouseLeave(Sender: TObject);
    procedure PaintBoxMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Open1Click(Sender: TObject);
    procedure SaveAs1Click(Sender: TObject);
    procedure PaintBoxMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OnClickChangeColor(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure OnClickSwitchColor(Sender: TObject);
    procedure PressToolButton(Sender: TObject);
    procedure PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
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
    function StrToHex(str: String): string;
  public
    { Public declarations }
    PaintMode: (pmNone, pmCustomSelection, pmSquareSelection, pmRubber, pmInk, pmSampler, pmPencil, pmSpray, pmText, pmLine, pmCursive, pmRectangle, pmPolygon, pmElipse, pmSquareCircle);
  end;

var
  WindowPainterForm: TWindowPainter;

implementation

{$R *.dfm}


//Opens file and draws it on canvas -> PaintBox
procedure TWindowPainter.Open1Click(Sender: TObject);
var
  SelectedFile: String; //selects file
  FileExtension: String;
  OpenDlg: TOpenDialog; //opens dialog to select file
  Bitmap: TBitmap;
  Png: TPngImage;
  Jpeg: TJpegImage;
  sF: TextFile;
  FirstLine: String;
  LastLine: String;
begin
  SelectedFile := '';
  OpenDlg := TOpenDialog.Create(nil);
  try
    OpenDlg.InitialDir := 'C:\';
    OpenDlg.Filter := 'All files (*.png;*.jpg;*.jpeg;*.bmp;*.ico)|*.png;*.jpg;*.jpeg;*.bmp;*.ico|Bitmap (*.bmp)|*.bmp|Portable Network Graphics (*.png)|*.png|JPEG Image File (*.jpg;*.jpeg)*|*.jpg;*.jpeg|Icons (*.ico)|*.ico';
    if OpenDlg.Execute(Handle) then
      SelectedFile := OpenDlg.FileName;

//    FileExtension := ExtractFileExt(SelectedFile);

    try
    //TODO: zaczytywanie linii
      try
        FirstLine := '';
        LastLine := '';
        AssignFile(sF, SelectedFile);
        Reset(sF);
        Readln(sF, FirstLine);

        while not EOF(sF) do
          Readln(sF, LastLine);

      except
        raise Exception.Create('Error Message');
      end;

      //first line of PNG
      if ContainsText(StrToHex(FirstLine), '89 50 4E 47 0D 0A 1A 0A') then
        begin
          Png := TPngImage.Create();
          Png.LoadFromFile(SelectedFile);
          PaintBox.Canvas.Draw(0, 0, Png);
        end
      //first line and last line of JPEG
      else if ContainsText(StrToHex(FirstLine), 'FF D8') and ContainsText(StrToHex(LastLine), 'FF D9') then
        begin
          Jpeg := TJpegImage.Create();
          Jpeg.LoadFromFile(SelectedFile);
          PaintBox.Canvas.Draw(0, 0, Jpeg);
        end
      //bitmap
      else
        begin
          Bitmap := TBitmap.Create();
          Bitmap.LoadFromFile(SelectedFile);
          PaintBox.Canvas.Draw(0, 0, Bitmap);
        end;

    finally
      Png.Free;
      Bitmap.Free;
      Jpeg.Free;
      CloseFile(sF);
    end;


//    Bitmap := TBitMap.Create();
//    Bitmap.LoadFromFile(SelectedFile);
//    PaintBox.Canvas.Draw(0,0,Bitmap);

  finally
    OpenDlg.Free;
  end;
end;

//procedure to paint when mouse down on PaintBox
procedure TWindowPainter.PaintBoxMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //Canvas.MoveTo(x,y);
  PaintMode := pmPencil;
  if Button = TMouseButton.mbLeft then
    PaintBox.Canvas.Pen.Color := DefaultColorPanel.Color
  else if Button = TMouseButton.mbRight then
    PaintBox.Canvas.Pen.Color := RightClickPanel.Color;

  //PaintBox1.Canvas.Pixels[x, y] := clBlue; //<-dzia³a
  //PaintBox1.Canvas.FloodFill(x,y,clBlue, TFillStyle.fsSurface);
  //PaintBox1.Canvas.Rectangle(0,0,20,20);
  //PaintBox1.Canvas.LineTo(x,y);
end;

//procedure to move mouse on PaintBox
procedure TWindowPainter.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  Label1.Caption := IntToStr(x) + ' ' + IntToStr(y);
  //PaintBox1.Canvas.SetPixel(x,y,clRed);
  PaintBox.Canvas.Pen.Width := 2;
//  PaintBox1.Canvas.MoveTo(x,y);
  //PaintBox1.Canvas.LineTo(x,y);
  if PaintMode = pmPencil then
    //PaintBox1.Canvas.MoveTo(x,y);

    PaintBox.Canvas.LineTo(x,y)
  else
    PaintBox.Canvas.MoveTo(x,y);
end;

//if mouse up then stop painting
procedure TWindowPainter.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
      PaintMode := pmNone;
end;

procedure TWindowPainter.Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  point: TPoint;
begin
  if IntToStr(point.X) = IntToStr(ScrollBox.Width-1) then
  begin
    if IntToStr(point.Y) = IntToStr(ScrollBox.Height-1) then
      Screen.Cursor := crSizeNESW;
  end;

end;

//procedure to save canvas as bitmap, jpeg or png and saving it into a file
procedure TWindowPainter.SaveAs1Click(Sender: TObject);
var
  b: boolean;
  saveDlg: TSavePictureDialog;
  Bitmap: TBitmap;
  Jpeg: TJpegImage;
  Png: TPngImage;
  SelectedExtension: string;
begin
  saveDlg := TSavePictureDialog.Create(nil);
  try
    //Filter for TSavePictureDialog
    saveDlg.Filter := 'Bitmap (*.bmp)|*.bmp|JPEG Image File (*.jpg;*.jpeg)|*.jpg;*.jpeg|Portable Network Graphics (*.png)|*.png';
     b := saveDlg.Execute(Handle);
    try
      SelectedExtension := ExtractFileExt(saveDlg.FileName);
      Bitmap := TBitmap.Create();
      Bitmap.Height := PaintBox.Height;
      Bitmap.Width := PaintBox.Width;
      BitBlt(Bitmap.Canvas.Handle, 0, 0, PaintBox.Width, PaintBox.Height, PaintBox.Canvas.Handle, 0, 0, SRCCOPY);

      if saveDlg.FilterIndex = 1 then
        begin
          if SelectedExtension = '.bmp' then
            SelectedExtension := ''
          else
            SelectedExtension := '.bmp';

          if FileExists(saveDlg.FileName + SelectedExtension) then
            raise Exception.Create('File Exists!')
          else
            Bitmap.SaveToFile(saveDlg.FileName + SelectedExtension);
          end
      else if saveDlg.FilterIndex = 2 then
        begin
          if (SelectedExtension = '.jpg') or (SelectedExtension = '.jpeg') then
            SelectedExtension := ''
          else
            SelectedExtension := '.jpg';

          Jpeg := TJpegImage.Create();
          Jpeg.Assign(Bitmap);

          if FileExists(saveDlg.FileName + SelectedExtension) then
            raise Exception.Create('File Exists!')
          else
            Jpeg.SaveToFile(saveDlg.FileName + SelectedExtension);
        end
      else
        begin
          if SelectedExtension = '.png' then
            SelectedExtension := ''
          else
            SelectedExtension := '.png';

          Png := TPngImage.Create();
          Png.Assign(Bitmap);

          if FileExists(saveDlg.FileName + SelectedExtension) then
            raise Exception.Create('File Exists')
          else
            Png.SaveToFile(saveDlg.FileName + SelectedExtension);
        end;

    finally
      Bitmap.Free;
      Jpeg.Free;
      Png.Free;
    end;
  finally
     saveDlg.Free;
  end;
end;

//changes cursor to default when leaves scrollbox
procedure TWindowPainter.ScrollBoxMouseLeave(Sender: TObject);
begin
  Screen.Cursor := crDefault;
end;

procedure TWindowPainter.ScrollBoxMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  Label2.Caption := IntToStr(x) + ' ' + IntToStr(y);
//    if X - ScrollBox1.Width <= 10 then
//      if Y - ScrollBox1.Height <= 10 then
//        Screen.Cursor := crSizeNESW;

end;

//procedure to change one of two default colors
procedure TWindowPainter.OnClickChangeColor(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
begin
  for I := 0 to DefaultColorsPanel.ControlCount -1 do
    if Sender = DefaultColorsPanel.Controls[i] then
    begin
      //if left click then default color changed
      if Button = mbLeft then
        DefaultColorPanel.Color := (Sender as TPanel).Color
      //if right click then right click color changed
      else if Button = mbRight then
        RightClickPanel.Color := (Sender as TPanel).Color;
    end;
end;

//Switching color in DefaultColorPanel and RightClickPanel
procedure TWindowPainter.OnClickSwitchColor(Sender: TObject);
var
  Color: TColor;
begin
    Color := RightClickPanel.Color;
    RightClickPanel.Color := DefaultColorPanel.Color;
    DefaultColorPanel.Color := Color;
end;

//procedure to choosing tool in TollPanel
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

//function to change string into hex value
function TWindowPainter.StrToHex(str: string): string;
var
  I: Integer;
begin
  result := '';
  for I := Low(str) to High(str)-1 do
    result := result + ' ' + IntToHex(Ord(str[I]));
end;

end.