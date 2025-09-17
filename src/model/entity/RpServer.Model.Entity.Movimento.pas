unit RpServer.Model.Entity.Movimento;

interface

uses
  SimpleAttributes;

type
  [Tabela('movimento')]
  TMovimento = class
  private
    Fid: Int64;
    Find_movimento: Int64;
    Fid_cliente: Int64;
    FVlr_desconto: Currency;
    Fvlr_subtotal: Currency;
    Fvlr_total: Currency;
    Fdoc_cliente: string;
    FVlr_acrescimo: Currency;
    Fnome_cliente: string;
    Fdta_emissao: TDateTime;
    Fid_usuario: Int64;
    Ffone_cliente: string;
    Find_status: Int64;

  public
    [Campo('id'), PK, AutoInc]
    property Id: Int64 read Fid write Fid;
    [Campo('ind_movimento'), PK]
    property ind_movimento: Int64 read Find_movimento write Find_movimento;
    [Campo('ind_status'), FK]
    property ind_status: Int64 read Find_status write Find_status;
    [Campo('id_cliente'), FK]
    property Id_cliente: Int64 read FId_cliente write FId_cliente;
    [Campo('nome_cliente')]
    property Nome_cliente: string read FNome_cliente write FNome_cliente;
    [Campo('doc_cliente')]
    property Doc_cliente: string read FDoc_cliente write FDoc_cliente;
    [Campo('fone_cliente')]
    property Fone_cliente: string read FFone_cliente write FFone_cliente;
    [Campo('id_usuario')]
    property Id_usuario: Int64 read FId_usuario write FId_usuario;
    [Campo('dta_emissao')]
    property Dta_emissao: TDateTime read FDta_emissao write Fdta_emissao;
    [Campo('vlr_subtotal')]
    property Vlr_subtotal: Currency read FVlr_subtotal write FVlr_subtotal;
    [Campo('vlr_desconto')]
    property Vlr_desconto: Currency read FVlr_desconto write FVlr_desconto;
    [Campo('vlr_acrescimo')]
    property Vlr_acrescimo: Currency read FVlr_acrescimo write FVlr_acrescimo;
    [Campo('vlr_total')]
    property Vlr_total: Currency read FVlr_total write FVlr_total;
  end;

implementation

end.
