program TRELLO;

uses
  System.StartUpCopy,
  FMX.Forms,
  uTrello in 'uTrello.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
