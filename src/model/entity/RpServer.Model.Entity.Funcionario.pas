unit RpServer.Model.Entity.Funcionario;

interface

uses
  SimpleAttributes;

type
  [Tabela('Funcionario')]
  TFuncionario = class
  private
    FId: Int64;
    FNome: String;
    FFuncao: String;
    procedure SetId(const aValue: Int64);
    procedure SetNome(const aValue: String);
    procedure SetFuncao(const Value: String);

  public
    constructor Create;
    destructor Destroy; override;

  published
    [Campo('id'), PK, AutoInc]
    property id: Int64 read FId write SetId;
    [Campo('nome')]
    property nome: String read FNome write SetNome;
    [Campo('funcao')]
    property Funcao: String read FFuncao write SetFuncao;
  end;

implementation

{ TFuncionario }

constructor TFuncionario.Create;
begin

end;

destructor TFuncionario.Destroy;
begin

  inherited;
end;

procedure TFuncionario.SetFuncao(const Value: String);
begin
  FFuncao := Value;
end;

procedure TFuncionario.SetId(const aValue: Int64);
begin
  FId := aValue;
end;

procedure TFuncionario.SetNome(const aValue: String);
begin
  FNome := aValue;
end;

end.
