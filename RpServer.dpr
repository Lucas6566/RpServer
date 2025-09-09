program RpServer;

uses
  Vcl.Forms,
  RpServer.Views.Principal in 'src\views\RpServer.Views.Principal.pas' {frmPrincipal},
  RpServer.Models.Connection in 'src\models\RpServer.Models.Connection.pas',
  RpServer.Model.Dao.Generic in 'src\models\dao\RpServer.Model.Dao.Generic.pas',
  RpServer.Models.Entities.Cidade in 'src\models\entities\RpServer.Models.Entities.Cidade.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
