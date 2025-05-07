unit RpServer.Model.Entity.Usuario;

interface

uses
  SimpleAttributes;

type
  [Tabela('Usuario')]
  TUsuario = class
  private
    FId: Int64;
    FNome: String;
    FSenha: String;
    FLogin: String;
    procedure SetId(const aValue: Int64);
    procedure SetNome(const aValue: String);
    procedure SetLogin(const Value: String);
    procedure SetSenha(const Value: String);

  public
    constructor Create;
    destructor Destroy; override;

  published
    [Campo('id'), PK, AutoInc]
    property id: Int64 read FId write SetId;
    [Campo('nome')]
    property nome: String read FNome write SetNome;
    [Campo('login')]
    property login: String read FLogin write SetLogin;
    [Campo('senha')]
    property senha: String read FSenha write SetSenha;
  end;

implementation

{ TUsuario }

constructor TUsuario.Create;
begin

end;

destructor TUsuario.Destroy;
begin

  inherited;
end;

procedure TUsuario.SetId(const aValue: Int64);
begin
  FId := aValue;
end;

procedure TUsuario.SetLogin(const Value: String);
begin
  FLogin := Value;
end;

procedure TUsuario.SetNome(const aValue: String);
begin
  FNome := aValue;
end;

procedure TUsuario.SetSenha(const Value: String);
begin
  FSenha := Value;
end;

end.
