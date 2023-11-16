program ProjectPainter;

uses
  Vcl.Forms,
  Painter in 'Painter.pas' {WindowPainter};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TWindowPainter, WindowPainterForm);
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
