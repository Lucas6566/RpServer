unit RpServer.Model.Entity.Usuario;

interface

uses
  SimpleAttributes;

type
  [Tabela('Usuario')]
  TUsuario = class
  private
    FSenha: String;
    FLogin: String;
    FId: Int64;

  public
    [Campo('id'), PK]
    property id: Int64 read FId write FId;
    [Campo('login')]
    property login: String read FLogin write FLogin;
    [Campo('senha')]
    property senha: String read FSenha write FSenha;
  end;

implementation

end.
