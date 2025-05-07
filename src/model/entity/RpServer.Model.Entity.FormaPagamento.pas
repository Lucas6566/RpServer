unit RpServer.Model.Entity.FormaPagamento;

interface

uses
  SimpleAttributes;

type
  [Tabela('forma_pagamento')]
  TFormaPagamento = class
  private
    FId: Int64;
    FDescricao: String;
    procedure SetId(const aValue: Int64);
    procedure SetDescricao(const aValue: String);

  public
    constructor Create;
    destructor Destroy; override;

  public
    [Campo('id'), PK, AutoInc]
    property Id: Int64 read FId write SetId;
    [Campo('descricao'), NotNull]
    property Descricao: String read FDescricao write SetDescricao;
  end;

implementation

{ TFormaPagamento }

constructor TFormaPagamento.Create;
begin

end;

destructor TFormaPagamento.Destroy;
begin

  inherited;
end;

procedure TFormaPagamento.SetId(const aValue: Int64);
begin
  FId := aValue;
end;

procedure TFormaPagamento.SetDescricao(const aValue: String);
begin
  FDescricao := aValue;
end;

end.
