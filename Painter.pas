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
      DrawingOptionPanel: TPanel;
      LineMode1Image: TImage;
      LineMode2Image: TImage;
      LineMode3Image: TImage;
      LineMode4Image: TImage;
      LineMode5Image: TImage;
      SprayMode1Image: TImage;
      SprayMode2Image: TImage;
      SprayMode3Image: TImage;
      ShapeMode1Image: TImage;
      ShapeMode2Image: TImage;
      ShapeMode3Image: TImage;
      SelectionMode1Image: TImage;
      SelectionMode2Image: TImage;
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
      procedure FormShow(Sender: TObject);
      procedure LineMode1ImageClick(Sender: TObject);
      procedure LineMode5ImageClick(Sender: TObject);
      procedure SprayMode3ImageClick(Sender: TObject);
      procedure LineMode2ImageClick(Sender: TObject);
      procedure LineMode3ImageClick(Sender: TObject);
      procedure LineMode4ImageClick(Sender: TObject);
      procedure SprayMode1ImageClick(Sender: TObject);
      procedure SprayMode2ImageClick(Sender: TObject);
      procedure ShapeMode1ImageClick(Sender: TObject);
      procedure ShapeMode2ImageClick(Sender: TObject);
      procedure ShapeMode3ImageClick(Sender: TObject);
      procedure SelectionMode1ImageClick(Sender: TObject);
      procedure SelectionMode2ImageClick(Sender: TObject);
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
      //SprayRadius: Integer; // <- radius for spray
      const Sprays: array[1..3] of Integer = (5, 10, 15);
      function StrToHex(str: String): string;
  //    function ImageToHex(Image: TPicture): string;
      procedure FirstLineLastLine(const Image: TPicture; var FirstLine: string; var LastLine: string);
      procedure ResizePaintBoxPanel(const Width: Integer; const Height: Integer);
      procedure ChangeMode(const SpeedButton: TSpeedButton);
      procedure ChangeDrawingOption(const SpeedButton: TSpeedButton);
      procedure PaintPencil(const X, Y: Integer);
      //procedure PaintRectangle;
      procedure DrawLine(const X, Y: Integer);
      procedure LoadPictures;
      function getSprayRadius: Integer;
      function getPenSize: Integer;
      function getSelectMode: Integer;
      function getShapeMode: Integer;
    public
      { Public declarations }
      XT, YT: Integer;
      PaintMode: (pmNone = 1, pmCustomSelection = 2, pmRectangleSelection = 3,
                  pmRubber = 4, pmInk = 5, pmSampler = 6, pmPencil = 7,
                  pmBrush = 8, pmSpray = 9, pmText = 10, pmLine = 11,
                  pmCursive = 12, pmRectangle = 13, pmPolygon = 14,
                  pmEllipse = 15, pmSquareCircle = 16);
      LineMode: (lmUltraThin = 1, lmThin = 2, lmMedium = 3, lmBold = 4, lmUltraBold = 5);
      SprayMode: (smSmall = 1, smNormal = 2, smBig = 3);
      ShapeMode: (hmCircuit = 1, hmFilledOtherColor = 2, hmFilledMainColor = 3);
      SelectionMode: (emNotFilled = 1, emFilled = 2);
//      procedure setPointX(const X: Integer);
//      procedure setPointY(const Y: Integer);
      property DX: Integer read DownPointX write DownPointX;
      property DY: Integer read DownPointY write DownPointY;
      property UX: Integer read UpPointX write UpPointX;
      property UY: Integer read UpPointY write UpPointY;
      property SprayRadius: Integer read getSprayRadius;
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
      //PaintBox.Canvas.CopyMode := cmSrcCopy;
      //raise Exception.Create(IntToStr(getPenSize));
      //PaintBox.Canvas.Pen.Width := getPenSize;
      //PaintBox.Invalidate;
      if Button = TMouseButton.mbLeft then
        begin

          LeftBtnDown := true;
          RightBtnDown := false;
          PaintBox.Canvas.Pen.Color := DefaultColorPanel.Color;
          PaintBox.Canvas.Pen.Mode := pmNotXor;
          PaintBox.Canvas.Pen.Style := psSolid;
          BrushColor := DefaultColorPanel.Color;
//          PaintBox.Canvas.Pen.Width := getPenSize;
          //raise Exception.Create(IntToStr(getPenSize));
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

  procedure TWindowPainter.LineMode1ImageClick(Sender: TObject);
  begin
    LineMode := lmUltraThin;
  end;

  procedure TWindowPainter.LineMode2ImageClick(Sender: TObject);
  begin
    LineMode := lmThin;
  end;

  procedure TWindowPainter.LineMode3ImageClick(Sender: TObject);
  begin
    LineMode := lmMedium;
  end;

  procedure TWindowPainter.LineMode4ImageClick(Sender: TObject);
  begin
    LineMode := lmBold;
  end;

  procedure TWindowPainter.LineMode5ImageClick(Sender: TObject);
  begin
    LineMode := lmUltraBold;
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

  procedure TWindowPainter.SelectionMode1ImageClick(Sender: TObject);
  begin
    SelectionMode := emFilled;
  end;

  procedure TWindowPainter.SelectionMode2ImageClick(Sender: TObject);
  begin
    SelectionMode := emNotFilled;
  end;

  procedure TWindowPainter.ShapeMode1ImageClick(Sender: TObject);
  begin
    ShapeMode := hmCircuit;
  end;

  procedure TWindowPainter.ShapeMode2ImageClick(Sender: TObject);
  begin
    ShapeMode := hmFilledOtherColor;
  end;

  procedure TWindowPainter.ShapeMode3ImageClick(Sender: TObject);
  begin
    ShapeMode := hmFilledMainColor;
  end;

  procedure TWindowPainter.SprayMode1ImageClick(Sender: TObject);
  begin
    SprayMode := smSmall;
  end;

  procedure TWindowPainter.SprayMode2ImageClick(Sender: TObject);
  begin
    SprayMode := smNormal;
  end;

  procedure TWindowPainter.SprayMode3ImageClick(Sender: TObject);
  begin
    SprayMode := smBig;
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
    Screen.Cursors[1] := LoadCursorFromFile('./cursors/pencil.cur');
    //PressToolButton(BtnPencil);
    //Sprays := [5, 10, 15];
  end;

  procedure TWindowPainter.FormShow(Sender: TObject);
  begin
      LoadPictures;
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
        //SprayRadius := 15;
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

    ChangeDrawingOption(SpeedButton);
  end;

  procedure TWindowPainter.ChangeDrawingOption(const SpeedButton: TSpeedButton);
  var
    IsLine: Boolean;
    IsShape: Boolean;
    IsSpray: Boolean;
    IsSelection: Boolean;
  begin

    IsLine := false;
    IsShape := false;
    IsSpray := false;
    IsSelection := false;

    if (SpeedButton = BtnRectangle) or
       (SpeedButton = BtnEllipse)   or
       (SpeedButton = BtnCustomFig)   or
       (SpeedButton = BtnSquareCircle)
    then
      begin
        IsShape := true;
      end
    else if (SpeedButton = BtnLine) or
            (SpeedButton = BtnCursive)
    then
      begin
        IsLine := true;
      end
    else if (SpeedButton = BtnSpray) then
      begin
        IsSpray := true;
      end
    else if (SpeedButton = BtnRectangleSelect) or
            (SpeedButton = BtnCustomSelect) or
            (SpeedButton = BtnText)
    then
      begin
        IsSelection := true;
      end;


    LineMode1Image.Visible := IsLine;
    LineMode2Image.Visible := IsLine;
    LineMode3Image.Visible := IsLine;
    LineMode4Image.Visible := IsLine;
    LineMode5Image.Visible := IsLine;

    SprayMode1Image.Visible := IsSpray;
    SprayMode2Image.Visible := IsSpray;
    SprayMode3Image.Visible := IsSpray;

    ShapeMode1Image.Visible := IsShape;
    ShapeMode2Image.Visible := IsShape;
    ShapeMode3Image.Visible := IsShape;

    SelectionMode1Image.Visible := IsSelection;
    SelectionMode2Image.Visible := IsSelection;
  end;

  procedure TWindowPainter.PaintPencil(const X, Y: Integer);
  begin
    PaintBox.Canvas.LineTo(X, Y);
  end;

  procedure TWindowPainter.DrawLine(const X: Integer; const Y: Integer);
  begin
    PaintBox.Canvas.Pen.Width := getPenSize;
    PaintBox.Canvas.MoveTo(DX, DY);
    PaintBox.Canvas.LineTo(X, Y);
  end;

  procedure TWindowPainter.LoadPictures;
  begin

    //Changes position of drawing modes
    LineMode1Image.Width := DrawingOptionPanel.Width-5;
    LineMode2Image.Width := DrawingOptionPanel.Width-5;
    LineMode3Image.Width := DrawingOptionPanel.Width-5;
    LineMode4Image.Width := DrawingOptionPanel.Width-5;
    LineMode5Image.Width := DrawingOptionPanel.Width-5;

    SprayMode1Image.Top := 5;
    SprayMode1Image.Left := 3;
    SprayMode2Image.Top := 5;
    SprayMode2Image.Left := 32;
    SprayMode3Image.Top := 40;
    SprayMode3Image.Left := 12;

    ShapeMode1Image.Top := 0;
    ShapeMode1Image.Left := 0;
    ShapeMode2Image.Top := 25;
    ShapeMode2Image.Left := 0;
    ShapeMode3Image.Top := 50;
    ShapeMode3Image.Left := 0;

    SelectionMode1Image.Top := 5;
    SelectionMode1Image.Left := 7;
    SelectionMode2Image.Top := 42;
    SelectionMode2Image.Left := 7;

    //hides everything
    LineMode1Image.Visible := false;
    LineMode2Image.Visible := false;
    LineMode3Image.Visible := false;
    LineMode4Image.Visible := false;
    LineMode5Image.Visible := false;

    SprayMode1Image.Visible := false;
    SprayMode2Image.Visible := false;
    SprayMode3Image.Visible := false;

    ShapeMode1Image.Visible := false;
    ShapeMode2Image.Visible := false;
    ShapeMode3Image.Visible := false;

    SelectionMode1Image.Visible := false;
    SelectionMode2Image.Visible := false;

    //sets default mode
    LineMode := lmUltraThin;
    SprayMode := smSmall;
    ShapeMode := hmCircuit;
    SelectionMode := emNotFilled;

  end;

  function TWindowPainter.getSprayRadius: Integer;
  var
    i: Integer;
  begin
    if SprayMode = smSmall then
      i:=1
    else if SprayMode = smNormal then
      i:=2
    else if SprayMode = smBig then
      i:=3;

    result := Sprays[i];
  end;

  function TWindowPainter.getPenSize: Integer;
  var
    i: Integer;
  begin
    if LineMode = lmUltraThin then
      Result := 1
    else if LineMode = lmThin then
      Result := 2
    else if LineMode = lmMedium then
      Result := 3
    else if LineMode = lmBold then
      Result := 4
    else if LineMode = lmUltraBold then
      Result := 5;
  end;


  function TWindowPainter.getSelectMode: Integer;
  begin
    if SelectionMode = emNotFilled then
      Result := 1
    else if SelectionMode = emFilled then
      Result := 2;
  end;

  function TWindowPainter.getShapeMode: Integer;
  begin
    if ShapeMode = hmCircuit then
      Result := 1
    else if ShapeMode = hmFilledOtherColor then
      Result := 2
    else if ShapeMode = hmFilledMainColor then
      Result := 3;
  end;

end.