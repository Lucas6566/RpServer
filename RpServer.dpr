program RpServer;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.Jhonson,
  Horse.HandleException,
  Horse.OctetStream,
  System.SysUtils,
  RpServer.Model.Entity.Cidade in 'src\model\entity\RpServer.Model.Entity.Cidade.pas',
  RpServer.Model.Dao.Generic in 'src\model\dao\RpServer.Model.Dao.Generic.pas',
  RpServer.Model.Connection in 'src\model\RpServer.Model.Connection.pas',
  RpServer.Controller.Cidade in 'src\controller\RpServer.Controller.Cidade.pas',
  RpServer.Controller.Usuario in 'src\controller\RpServer.Controller.Usuario.pas',
  RpServer.Model.Entity.Usuario in 'src\model\entity\RpServer.Model.Entity.Usuario.pas',
  RpServer.Model.Entity.Funcionario in 'src\model\entity\RpServer.Model.Entity.Funcionario.pas',
  RpServer.Controller.Funcionario in 'src\controller\RpServer.Controller.Funcionario.pas',
  RpServer.Model.Entity.Bairro in 'src\model\entity\RpServer.Model.Entity.Bairro.pas',
  RpServer.Controller.Bairro in 'src\controller\RpServer.Controller.Bairro.pas',
  RpServer.Model.Entity.Cliente in 'src\model\entity\RpServer.Model.Entity.Cliente.pas',
  RpServer.Controller.Cliente in 'src\controller\RpServer.Controller.Cliente.pas',
  RpServer.Model.Entity.TipoServico in 'src\model\entity\RpServer.Model.Entity.TipoServico.pas',
  RpServer.Controller.TipoServico in 'src\controller\RpServer.Controller.TipoServico.pas',
  RpServer.Controller.Servico in 'src\controller\RpServer.Controller.Servico.pas',
  RpServer.Model.Entity.Servico in 'src\model\entity\RpServer.Model.Entity.Servico.pas',
  RpServer.Model.Entity.FormaPagamento in 'src\model\entity\RpServer.Model.Entity.FormaPagamento.pas',
  RpServer.Controller.FormaPagamento in 'src\controller\RpServer.Controller.FormaPagamento.pas',
  RpServer.Model.Entity.Venda in 'src\model\entity\RpServer.Model.Entity.Venda.pas',
  RpServer.Controller.Venda in 'src\controller\RpServer.Controller.Venda.pas',
  RpServer.Model.Entity.VendaParcela in 'src\model\entity\RpServer.Model.Entity.VendaParcela.pas',
  RpServer.Model.Entity.VendaServico in 'src\model\entity\RpServer.Model.Entity.VendaServico.pas',
  RpServer.Controller.VendaParcela in 'src\controller\RpServer.Controller.VendaParcela.pas',
  RpServer.Controller.VendaServico in 'src\controller\RpServer.Controller.VendaServico.pas';

begin
  THorse
    .Use(Jhonson())
    .Use(HandleException)
    .Use(OctetStream);

  RpServer.Controller.Cidade.Registry;
  RpServer.Controller.Usuario.Registry;
  RpServer.Controller.Funcionario.Registry;
  RpServer.Controller.Bairro.Registry;
  RpServer.Controller.Cliente.Registry;
  RpServer.Controller.TipoServico.Registry;
  RpServer.Controller.Servico.Registry;
  RpServer.Controller.FormaPagamento.Registry;
  RpServer.Controller.Venda.Registry;
  RpServer.Controller.VendaParcela.Registry;
  RpServer.Controller.VendaServico.Registry;

  THorse.Listen(9000);
end.
