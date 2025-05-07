unit RpServer.Model.Entity.Cidade;

interface

uses
  SimpleAttributes;

type
  [Tabela('Cidade')]
  TCidade = class
  private
    FId: Int64;
    FUf: String;
    FNome: String;
    procedure SetId(const aValue: Int64);
    procedure SetNome(const aValue: String);
    procedure SetUf(const aValue: String);

  public
    constructor Create;
    destructor Destroy; override;

  published
    [Campo('id'), PK, AutoInc]
    property id: Int64 read FId write SetId;
    [Campo('nome')]
    property nome: String read FNome write SetNome;
    [Campo('uf')]
    property uf: String read FUf write SetUf;
  end;

implementation

{ TCidade }

constructor TCidade.Create;
begin

end;

destructor TCidade.Destroy;
begin

  inherited;
end;

procedure TCidade.SetId(const aValue: Int64);
begin
  FId := aValue;
end;

procedure TCidade.SetNome(const aValue: String);
begin
  FNome := aValue;
end;

procedure TCidade.SetUf(const aValue: String);
begin
  FUf := aValue;
end;

end.
