unit RpServer.Model.Entity.Servico;

interface

uses
  SimpleAttributes;

type
  [Tabela('servico')]
  TServico = class
  private
    FId: Int64;
    FDescricao: String;
    FVlr_Venda: Currency;
    FId_Tipo_Servico: Int64;
    procedure SetId(const aValue: Int64);
    procedure SetDescricao(const aValue: String);
    procedure SetId_Tipo_Servico(const Value: Int64);
    procedure SetVlr_Venda(const Value: Currency);

  public
    constructor Create;
    destructor Destroy; override;

  public
    [Campo('id'), PK, AutoInc]
    property Id: Int64 read FId write SetId;
    [Campo('descricao'), NotNull]
    property Descricao: String read FDescricao write SetDescricao;
    [campo('vlr_venda')]
    property Vlr_Venda: Currency read FVlr_Venda write SetVlr_Venda;
    [Campo('id_tipo_servico'), FK]
    property Id_Tipo_Servico: Int64 read FId_Tipo_Servico write SetId_Tipo_Servico;
  end;

implementation

{ TServico }

constructor TServico.Create;
begin

end;

destructor TServico.Destroy;
begin

  inherited;
end;

procedure TServico.SetId(const aValue: Int64);
begin
  FId := aValue;
end;

procedure TServico.SetId_Tipo_Servico(const Value: Int64);
begin
  FId_Tipo_Servico := Value;
end;

procedure TServico.SetVlr_Venda(const Value: Currency);
begin
  FVlr_Venda := Value;
end;

procedure TServico.SetDescricao(const aValue: String);
begin
  FDescricao := aValue;
end;

end.
