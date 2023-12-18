unit Painter;

interface

  uses
    Winapi.Windows,
    Winapi.Messages,
    System.SysUtils,
    System.Variants,
    System.Classes,
    System.IOUtils,
    System.Math,
    Vcl.Graphics,
    Vcl.Controls,
    Vcl.Forms,
    Vcl.Dialogs,
    Vcl.Menus,
    Vcl.ExtCtrls,
    Vcl.StdCtrls,
    Vcl.ExtDlgs,
    Vcl.Buttons,
    jpeg,
    pngimage,
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
    Panel1: TPanel;
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
    procedure New1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
      LeftBtnDown: Boolean;
      RightBtnDown: Boolean;
      DownPointX, DownPointY: Integer;
      UpPointX, UpPointY: Integer;
      FirstPointX, FirstPointY: Integer;
      PolPoints: Integer; // <---- count of Polygon points
      Radius: Integer; // <-- for RectCircle
      SprayX, SprayY: Integer; // <- for spray
      SprayRadius: Integer; // <- radius for spray
      function StrToHex(str: String): string;
  //    function ImageToHex(Image: TPicture): string;
      procedure FirstLineLastLine(const Image: TPicture; var FirstLine: string; var LastLine: string);
      procedure ResizePaintBoxPanel(const Width: Integer; const Height: Integer);
      procedure ChangeMode(const SpeedButton: TSpeedButton);
      procedure PaintPencil(const X, Y: Integer);
      //procedure PaintRectangle;
      procedure DrawLine(const X, Y: Integer);
    public
      { Public declarations }
      XT, YT: Integer;
      PaintMode: (pmNone, pmCustomSelection, pmRectangleSelection, pmRubber, pmInk, pmSampler, pmPencil, pmBrush, pmSpray, pmText, pmLine, pmCursive, pmRectangle, pmPolygon, pmEllipse, pmSquareCircle);
//      procedure setPointX(const X: Integer);
//      procedure setPointY(const Y: Integer);
      property DX: Integer read DownPointX write DownPointX;
      property DY: Integer read DownPointY write DownPointY;
      property UX: Integer read UpPointX write UpPointX;
      property UY: Integer read UpPointY write UpPointY;
    end;

  var
    WindowPainterForm: TWindowPainter;

implementation

{$R *.dfm}

  //Opens file and draws it on canvas -> PaintBox
  procedure TWindowPainter.Open1Click(Sender: TObject);
  var
    SelectedFile: String; //selects file
  //  FileExtension: String;   <---- DELETED
    OpenDlg: TOpenDialog; //opens dialog to select file
    Bitmap: TBitmap;
    Png: TPngImage;
    Jpeg: TJpegImage;
  //  sF: TextFile;    <---- DELETED
    Image: TPicture;
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

      try
      //DONE: loading first and last bytes of picture
        FirstLine := '';
        LastLine := '';
        Image := TPicture.Create();
        Image.LoadFromFile(SelectedFile);
        Png := TPngImage.Create();
        Jpeg := TJpegImage.Create();
        Bitmap := TBitmap.Create();
        {
          Loading picture as TextFile does not work
        }
        {
          AssignFile(sF, SelectedFile);
          Reset(sF);
          Readln(sF, FirstLine);

          while not EOF(sF) do
            Readln(sF, LastLine);
        }

        FirstLineLastLine(Image, FirstLine, LastLine);

        if ContainsText(FirstLine, '89504E470D0A1A0A') then //first line of PNG  '89 50 4E 47 0D 0A 1A 0A'
          begin
            Png.LoadFromFile(SelectedFile);
            ResizePaintBoxPanel(Png.Width, Png.Height);
            PaintBox.Canvas.Draw(0, 0, Png);
          end
        else if ContainsText(FirstLine.Substring(0, 4)	, 'FFD8') and  //first line 'FF D8' and last line 'FF D9' of JPEG
                ContainsText(LastLine, 'FFD9') then
          begin
            Jpeg.LoadFromFile(SelectedFile);
            ResizePaintBoxPanel(Jpeg.Width, Jpeg.Height);
            PaintBox.Canvas.Draw(0, 0, Jpeg);
          end
        else  //if not jpg or png then tries load as bitmap
          begin
            try
              Bitmap.LoadFromFile(SelectedFile);
              ResizePaintBoxPanel(Bitmap.Width, Bitmap.Height);
              PaintBox.Canvas.Draw(0, 0, Bitmap);
            except
              raise Exception.Create('File is not valid!');
            end;
          end;

      finally
        Bitmap.Free;
        Png.Free;
        Jpeg.Free;
        Image.Free;
      end;

    finally
      OpenDlg.Free;
    end;
  end;

  //procedure to paint when mouse down on PaintBox
  procedure TWindowPainter.PaintBoxMouseDown(Sender: TObject;
    Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  var
    BrushColor: TColor;
    RangeLowX, RangeHighX, RangeLowY, RangeHighY: Integer;
    i: Integer;
  begin

    PaintBox.Canvas.MoveTo(x,y); // <===== It must be, without it Canvas' Brush won't change it's position

    //to saving postion when mouse button is down -> important to drawing figures
    DX := X;
    DY := Y;
    XT := X;
    YT := Y;
    //

    if (Button = TMouseButton.mbLeft) or (Button = TMouseButton.mbRight) then
    begin
      PaintBox.Canvas.CopyMode := cmSrcCopy;
      if Button = TMouseButton.mbLeft then
        begin

          LeftBtnDown := true;
          RightBtnDown := false;
          PaintBox.Canvas.Pen.Color := DefaultColorPanel.Color;
          PaintBox.Canvas.Pen.Mode := pmNotXor;
          BrushColor := DefaultColorPanel.Color;
        end
      else if Button = TMouseButton.mbRight then
        begin
          LeftBtnDown := false;
          RightBtnDown := true;
          PaintBox.Canvas.Pen.Color := RightClickPanel.Color;
          PaintBox.Canvas.Pen.Mode := pmNotXor;
          BrushColor := RightClickPanel.Color
        end;

      //For polygon mode
      if PaintMode = pmPolygon then
        begin
          if FirstPointX = -1 then
          begin
            FirstPointX := XT;
            FirstPointY := YT;
            UX := XT;
            UY := YT;
            PolPoints := 1;
          end
          else
          begin //bez tego dorysowuje dodatkow¹ liniê!!!!!!!
            PaintBox.Canvas.MoveTo(UX, UY);
            PaintBox.Canvas.LineTo(XT, YT);
          end;
          //we set length of PolPoints araay and add first point to PolPoints array
//          if Length(PolPoints) = 0 then
//            begin
//              SetLength(PolPoints, 1);
//              PolPoints[0] := TPoint.Create(X, Y);
//            end
        end
      else if PaintMode = pmSampler then
        begin

          if Button = TMouseButton.mbLeft then
            DefaultColorPanel.Color := PaintBox.Canvas.Pixels[X, Y]
          else if Button = TMouseButton.mbRight then
            RightClickPanel.Color := PaintBox.Canvas.Pixels[X, Y];
        end
      else if PaintMode = pmInk then
        begin
  //        PaintBox.Canvas.CopyMode := cmSrcPaint;
          PaintBox.Canvas.Brush.Color := BrushColor;
          PaintBox.Canvas.Brush.Style := bsSolid;
          PaintBox.Canvas.FloodFill(X, Y, PaintBox.Canvas.Pixels[x,y], fsSurface);
          //PaintBox.Canvas.CopyMode := cmSrcCopy;
          PaintBox.Canvas.Brush.Style := bsClear;
        end
      else if PaintMode = pmSpray then
        begin
          if (X < PaintBox.Width) and (Y < PaintBox.Height) then
            begin
              if X - SprayRadius < 0 then
                RangeLowX := 0
              else
                RangeLowX := X - SprayRadius;

              if X + SprayRadius > PaintBox.Width then
                RangeHighX := PaintBox.Width
              else
                RangeHighX := X + SprayRadius;

              if Y - SprayRadius < 0 then
                RangeLowY := 0
              else
                RangeLowY := Y - SprayRadius;

              if Y + SprayRadius > PaintBox.Height then
                RangeHighY := PaintBox.Height
              else
                RangeHighY := Y + SprayRadius;

              for i := 0 to 15 do
              begin
                repeat
                  SprayX := RandomRange(RangeLowX, RangeHighX);
                  SprayY := RandomRange(RangeLowY, RangeHighY);
                until Power((SprayX - XT), 2) + Power((SprayY - YT), 2) < Power(SprayRadius, 2);

                PaintBox.Canvas.Pixels[SprayX, SprayY] := BrushColor;
              end;
            end;
        end;


    end;

  //  if PaintMode = pmPencil then
  //    if Button = TMouseButton.mbLeft then
  //      begin
  //        LeftBtnDown := true;
  //        RightBtnDown := false;
  //        PaintBox.Canvas.Pen.Color := DefaultColorPanel.Color;
  //      end
  //    else if Button = TMouseButton.mbRight then
  //      begin
  //        LeftBtnDown := false;
  //        RightBtnDown := true;
  //        PaintBox.Canvas.Pen.Color := RightClickPanel.Color;
  //      end
  //  else if PaintMode = pmRectangle then
  //    if True then



    //PaintBox1.Canvas.Pixels[x, y] := clBlue; //<-dzia³a
    //PaintBox1.Canvas.FloodFill(x,y,clBlue, TFillStyle.fsSurface);
    //PaintBox1.Canvas.Rectangle(0,0,20,20);
    //PaintBox1.Canvas.LineTo(x,y);
  end;

  //procedure to move mouse on PaintBox
  procedure TWindowPainter.PaintBoxMouseMove(Sender: TObject; Shift: TShiftState;
    X, Y: Integer);
  var
    Color: TColor;
    RangeLowX, RangeHighX, RangeLowY, RangeHighY: Integer;
    i: Integer;
  begin
    //Label1.Caption := IntToStr(x) + ' ' + IntToStr(y);
    //PaintBox1.Canvas.SetPixel(x,y,clRed);
    PaintBox.Canvas.Pen.Width := 1;
    //PaintBox.Canvas.MoveTo(x,y);
    //PaintBox1.Canvas.LineTo(x,y);
    with PaintBox.Canvas do
      begin
      if (LeftBtnDown = true) or (RightBtnDown = true) then
        begin
          if LeftBtnDown = true then
            Color := DefaultColorPanel.Color
          else
            Color := RightClickPanel.Color;


          //raise Exception.Create('Click right: ' + BoolToStr(LeftBtnDown));
          if PaintMode = pmPencil then
            //PaintBox1.Canvas.MoveTo(x,y);
            //PaintBox.Canvas.LineTo(x,y)
            PaintPencil(X, Y)
          else if PaintMode = pmLine then
              DrawLine(XT, YT)
          else if PaintMode = pmRectangle then
            begin
              //MoveTo(DX, DY);
              Rectangle(DX, DY, XT, YT);
            end
          else if PaintMode = pmEllipse then
              Ellipse(DX, DY, XT, YT)
          else if PaintMode = pmPolygon then
            begin
              //first we move to lastest point
//              MoveTo(PolPoints[Length(PolPoints)-1].X,
//                     PolPoints[Length(PolPoints)-1].Y);
//              //we draw the line to XT, YT points
//              LineTo(XT, YT);
                MoveTo(UX, UY);
                LineTo(XT, YT);
            end
          else if PaintMode = pmSquareCircle then
            begin
              RoundRect(DX, DY, XT, YT, Radius, Radius);
            end
          else if PaintMode = pmSpray then
            begin
              if (X < PaintBox.Width) and (Y < PaintBox.Height) and (X > 0) and (Y > 0) then
                begin
                if X - SprayRadius < 0 then
                  RangeLowX := 0
                else
                  RangeLowX := X - SprayRadius;

                if X + SprayRadius > PaintBox.Width then
                  RangeHighX := PaintBox.Width
                else
                  RangeHighX := X + SprayRadius;

                if Y - SprayRadius < 0 then
                  RangeLowY := 0
                else
                  RangeLowY := Y - SprayRadius;

                if Y + SprayRadius > PaintBox.Height then
                  RangeHighY := PaintBox.Height
                else
                  RangeHighY := Y + SprayRadius;

                for i := 0 to 15 do
                  begin
                    repeat
                      SprayX := RandomRange(RangeLowX, RangeHighX);
                      SprayY := RandomRange(RangeLowY, RangeHighY);
                    until Power((SprayX - X), 2) + Power((SprayY - Y), 2) < Power(SprayRadius, 2);

                    PaintBox.Canvas.Pixels[SprayX, SprayY] := Color;
                  end;
                end;
            end
          else
            MoveTo(x,y);
//        end;

//      if ((LeftBtnDown = true) or (RightBtnDown = true)) then
//      begin
         if PaintMode = pmLine then
           DrawLine(X, Y)
         else if PaintMode = pmRectangle then
           begin
             //MoveTo(DX, DY);
             Rectangle(DX, DY, X, Y);
           end
         else if PaintMode = pmEllipse then
           begin
             Ellipse(DX, DY, X, Y);
           end
         else if PaintMode = pmPolygon then
             //DrawLine(X, Y);
           begin
//             MoveTo(PolPoints[Length(PolPoints)-1].X,
//                    PolPoints[Length(PolPoints)-1].Y);
//             LineTo(X, Y);
               MoveTo(UX, UY);
               LineTo(X, Y);
           end
         else if PaintMode = pmSquareCircle then
           RoundRect(DX, DY, X, Y, Radius, Radius);

      end;

    end;

    XT := X;
    YT := Y;
  end;

  //if mouse up then stop painting
  procedure TWindowPainter.PaintBoxMouseUp(Sender: TObject; Button: TMouseButton;
    Shift: TShiftState; X, Y: Integer);
  begin
    //PaintMode := pmNone;
    if Button = mbLeft then
      LeftBtnDown := false
    else if Button = mbRight then
      RightBtnDown := false;
    with PaintBox.Canvas do
    begin

      if PaintMode = pmLine then
        begin
          MoveTo(DX, DY);
          LineTo(XT, YT);
        end
      else if PaintMode = pmPolygon then
        begin
//          SetLength(PolPoints, Length(PolPoints)+1);
//          PolPoints[Length(PolPoints)-1] := TPoint.Create(XT, YT);
//
//          Label1.Caption :=  IntToStr(Length(PolPoints)) + '; distance: ' + Double.ToString(PolPoints[Low(PolPoints)].Distance(PolPoints[High(PolPoints)]));
          UX := XT;
          UY := YT;
          PolPoints := PolPoints + 1;
          MoveTo(UX, UY);
          LineTo(XT, YT);

//            if (TPoint.Create(FirstPointX, FirstPointY)).Distance(TPoint.Create(UX, UY)) < 50 then
//            begin
////              //Draw line between these points
////              MoveTo(PolPoints[High(PolPoints)].X,
////                     PolPoints[High(PolPoints)].Y);
//              MoveTo(UX, UY);
//              LineTo(XT, YT);
////              LineTo(PolPoints[Low(PolPoints)].X,
////                     PolPoints[Low(PolPoints)].Y);
//            end;
        end;

//    NIE POTRZEBNE, DLACZEGO?????
//      else if PaintMode = pmRectangle then
//        begin
//
//        end
//      else if PaintMode = pmEllipse then
//        begin
//
//        end;

      if PaintMode = pmLine then
        begin
          MoveTo(DX, DY);
          LineTo(X, Y);
        end
      else if PaintMode = pmPolygon then
         begin
//          MoveTo(PolPoints[High(PolPoints)].X,
//                     PolPoints[High(PolPoints)].Y);
////          LineTo(PolPoints[Low(PolPoints)].X,
////                     PolPoints[Low(PolPoints)].Y);
//          LineTo(X, Y);
            MoveTo(UX, UY);
            LineTo(X, Y);

            //connects last line with the first one
            if PolPoints > 2 then
              begin
                Label1.Caption := 'Distance: ' +  Double.ToString((TPoint.Create(FirstPointX, FirstPointY)).Distance(TPoint.Create(UX, UY)));
                if (TPoint.Create(FirstPointX, FirstPointY)).Distance(TPoint.Create(UX, UY)) < 4 then
                  begin
      //              //Draw line between these points
      //              MoveTo(PolPoints[High(PolPoints)].X,
      //                     PolPoints[High(PolPoints)].Y);
                    MoveTo(X, Y);
                    LineTo(FirstPointX, FirstPointY);
                    PolPoints := 0;
                    FirstPointX := -1;
                    FirstPointY := -1;
      //              LineTo(PolPoints[Low(PolPoints)].X,
      //                     PolPoints[Low(PolPoints)].Y);
                  end;
              end;
         end;

    end;
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
    SpeedButton: TSpeedButton;
  begin
    for I := 0 to ToolPanel.ControlCount - 1 do
    begin
      try
        SpeedButton := (ToolPanel.Controls[i] as TSpeedButton);
      except
        continue;
      end;

      if Sender = SpeedButton then
        begin
          SpeedButton.Down := true;
          ChangeMode(SpeedButton);
        end
      else
        begin
          SpeedButton.Down := false;
        end;
    end;
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

  procedure TWindowPainter.FirstLineLastLine(const Image: TPicture; var FirstLine: string; var LastLine: string);
  {
    Loads first and last bytes of picture files
    By creating TMemoryStream it load first and last bytes of picture into
    BufferFirstBytes and BufferLastBytes
  }
  var
    Stream: TMemoryStream;
    BufferFirstBytes: TBytes;
    BufferLastBytes: TBytes;
    LastBytesPosition: LongInt;
    I: Integer;
  begin
    try
      Stream := TMemoryStream.Create();
      Image.Graphic.SaveToStream(Stream);

      SetLength(BufferFirstBytes, 8); //8 bytes cos max bytes to compare is 8 ( first eight bytes of png image)
      Stream.Position := 0; //setting position in the stream
      Stream.ReadBuffer(BufferFirstBytes, 8);

      SetLength(BufferLastBytes, 2); //2 bytes to compare to jpeg
      LastBytesPosition := Stream.Size-2; //calculate position to take 2 last bytes
      Stream.Seek(LastBytesPosition, soBeginning);  //we seek them in the stream without loading all of them into a variable or loop
      Stream.ReadBuffer(BufferLastBytes, 2); //we loads last 2 bytes into array

      //translation first and last bytes into HEX
      for I := Low(BufferFirstBytes) to High(BufferFirstBytes) do
        FirstLine := FirstLine + IntToHex(BufferFirstBytes[I]);

      for I := Low(BufferLastBytes) to High(BufferLastBytes) do
        LastLine := LastLine + IntToHex(BufferLastBytes[I]);

    finally
      BufferFirstBytes:=nil;
      BufferLastBytes:=nil;
      Stream.Free;
    end;
  end;

procedure TWindowPainter.FormCreate(Sender: TObject);
begin
  Screen.Cursors[1] := LoadCUrsorFromFile('./cursors/pencil.cur');
end;

procedure TWindowPainter.New1Click(Sender: TObject);
{
  Procedure clears PainBox' Canvas
}
begin
  ResizePaintBoxPanel(400, 400);
  PaintBox.Canvas.CopyMode := cmSrcPaint;
  PaintBox.Canvas.Pen.Color := clWhite;
  PaintBox.Canvas.Brush.Color := clWhite;
  //PaintBox.Canvas.Brush.Style := bsSolid;
  PaintBox.Canvas.Pen.Mode := pmCopy;
  PaintBox.Canvas.Rectangle(0,0,PaintBox.Height, PaintBox.Width);
end;

procedure TWindowPainter.ResizePaintBoxPanel(const Width: Integer; const Height: Integer);
  begin
    PanelPaintBox.Width := Width;
    PanelPaintBox.Height := Height;
    PaintBox.Width := Width;
    PaintBox.Height := Height;
  end;

  procedure TWindowPainter.ChangeMode(const SpeedButton: TSpeedButton);
  {
    Procedure changes current mode
  }
  begin
    if SpeedButton = BtnCustomSelect then
      PaintMode := pmCustomSelection
    else if SpeedButton = BtnRectangleSelect then
      PaintMode := pmRectangleSelection
    else if SpeedButton = BtnRubber then
      PaintMode := pmRubber
    else if SpeedButton = BtnInk then
      PaintMode := pmInk
    else if SpeedButton = BtnSampler then
      PaintMode := pmSampler
  //  else if SpeedButton = BtnZoom then
  //    PaintMode := pmZoom
    else if SpeedButton = BtnPencil then
      begin
        Cursor := 1;
        PaintMode := pmPencil
      end
    else if SpeedButton = BtnBrush then
      PaintMode := pmBrush
    else if SpeedButton = BtnSpray then
      begin
        PaintMode := pmSpray;
        SprayRadius := 15;
      end
    else if SpeedButton = BtnText then
      PaintMode := pmText
    else if SpeedButton = BtnLine then
      begin
        Screen.Cursor := crCross;
        PaintMode := pmLine
      end
    else if SpeedButton = BtnCursive then
      PaintMode := pmCursive
    else if SpeedButton = BtnRectangle then
      begin
        Screen.Cursor := crCross;
        PaintMode := pmRectangle
      end
    else if SpeedButton = BtnCustomFig then
      begin
        Screen.Cursor := crCross;
        PaintMode := pmPolygon;
        //SetLength(PolPoints, 0);
        FirstPointX := -1;
        FirstPointY := -1;
      end
    else if SpeedButton = BtnEllipse then
      begin
        Screen.Cursor := crCross;
        PaintMode := pmEllipse
      end
    else if SpeedButton = BtnSquareCircle then
      begin
        Radius := 20;
        Screen.Cursor := crCross;
        PaintMode := pmSquareCircle
      end;


  end;

  procedure TWindowPainter.PaintPencil(const X, Y: Integer);
  begin
    PaintBox.Canvas.LineTo(X, Y);
  end;

  procedure TWindowPainter.DrawLine(const X: Integer; const Y: Integer);
  begin
    PaintBox.Canvas.MoveTo(DX, DY);
    PaintBox.Canvas.LineTo(X, Y);
  end;
end.