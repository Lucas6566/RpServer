unit RpServer.Model.Entity.TipoServico;

interface

uses
  SimpleAttributes;

type
  [Tabela('tipo_servico')]
  TTipoServico = class
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

{ TTipoServico }

constructor TTipoServico.Create;
begin

end;

destructor TTipoServico.Destroy;
begin

  inherited;
end;

procedure TTipoServico.SetId(const aValue: Int64);
begin
  FId := aValue;
end;

procedure TTipoServico.SetDescricao(const aValue: String);
begin
  FDescricao := aValue;
end;

end.
