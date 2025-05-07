unit RpServer.Model.Entity.Bairro;

interface

uses
  SimpleAttributes;

type
  [Tabela('Bairro')]
  TBairro = class
  private
    FId: Int64;
    FNome: String;
    FTaxa_entrega: Currency;
    FId_cidade: Int64;
    procedure SetId(const aValue: Int64);
    procedure SetNome(const aValue: String);
    procedure SetTaxa_entrega(const Value: Currency);
    procedure SetId_cidade(const aValue: Int64);

  public
    constructor Create;
    destructor Destroy; override;

  public
    [Campo('id'), PK, AutoInc]
    property id: Int64 read FId write SetId;
    [Campo('nome')]
    property nome: String read FNome write SetNome;
    [Campo('taxa_entrega')]
    property Taxa_entrega: Currency read FTaxa_entrega write SetTaxa_entrega;
    [Campo('id_cidade'), FK]
    property Id_cidade: Int64 read FId_cidade write SetId_cidade;
  end;

implementation

{ TBairro }

constructor TBairro.Create;
begin

end;

destructor TBairro.Destroy;
begin

  inherited;
end;

procedure TBairro.SetId(const aValue: Int64);
begin
  FId := aValue;
end;

procedure TBairro.SetId_cidade(const aValue: Int64);
begin
  FId_cidade := aValue;
end;

procedure TBairro.SetNome(const aValue: String);
begin
  FNome := aValue;
end;

procedure TBairro.SetTaxa_entrega(const Value: Currency);
begin
  FTaxa_entrega := Value;
end;

end.
