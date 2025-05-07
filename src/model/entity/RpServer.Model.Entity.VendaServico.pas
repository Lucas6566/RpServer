unit RpServer.Model.Entity.VendaServico;

interface

uses
  SimpleAttributes;

type
  [Tabela('venda_servico')]
  TVendaServico = class
  private
    Fid: Int64;
    Fid_venda: Int64;
    Fid_servico: Int64;
    Fqtd_servico: Integer;
    Fvlr_unitario: Currency;
    Fvlr_total: Currency;

  public
    [Campo('id'), PK, AutoInc]
    property id: Int64 read Fid write Fid;
    [Campo('id_venda'), FK]
    property id_venda: Int64 read Fid_venda write Fid_venda;
    [Campo('id_servico'), FK]
    property id_servico: Int64 read Fid_servico write Fid_servico;
    [Campo('qtd_servico')]
    property qtd_servico: Integer read Fqtd_servico write Fqtd_servico;
    [Campo('vlr_unitario')]
    property vlr_unitario: Currency read Fvlr_unitario write Fvlr_unitario;
    [Campo('vlr_total')]
    property vlr_total: Currency read Fvlr_total write Fvlr_total;
  end;

implementation

end.
