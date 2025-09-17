unit RpServer.Model.Entity.MovimentoServico;

interface

uses
  SimpleAttributes;

type
  [Tabela('movimento_servico')]
  TMovimentoServico = class
  private
    Fid: Int64;
    Fid_movimento: Int64; //1= Venda; 2= Ordem de Serviço
    Find_movimento: Int64;
    Fid_servico: Int64;
    Fqtd_servico: Integer;
    Fvlr_unitario: Currency;
    Fvlr_total: Currency;
    Find_status: Int64;   //1= Ativo; 2= Inativo
    Fvlr_acrescimo: Currency;
    Fvlr_desconto: Currency;

  public
    [Campo('id'), PK, AutoInc]
    property id: Int64 read Fid write Fid;
    [Campo('id_movimento'), FK]
    property id_movimento: Int64 read Fid_movimento write Fid_movimento;
    [Campo('ind_movimento'), FK]
    property ind_movimento: Int64 read Find_movimento write Find_movimento;
    [Campo('ind_status'), FK]
    property ind_status: Int64 read Find_status write Find_status;
    [Campo('id_servico'), FK]
    property id_servico: Int64 read Fid_servico write Fid_servico;
    [Campo('qtd_servico')]
    property qtd_servico: Integer read Fqtd_servico write Fqtd_servico;
    [Campo('vlr_unitario')]
    property vlr_unitario: Currency read Fvlr_unitario write Fvlr_unitario;
    [Campo('vlr_desconto')]
    property vlr_desconto: Currency read Fvlr_desconto write Fvlr_desconto;
    [Campo('vlr_acrescimo')]
    property vlr_acrescimo: Currency read Fvlr_acrescimo write Fvlr_acrescimo;
    [Campo('vlr_total')]
    property vlr_total: Currency read Fvlr_total write Fvlr_total;
  end;

implementation

end.
