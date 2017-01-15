program prjFilms;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {MainForm},
  uFilmInfo in 'uFilmInfo.pas' {r: TFrame},
  uListMainFrame in 'uListMainFrame.pas' {ListMainFrame: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
