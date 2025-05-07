unit RpServer.Model.Entity.Venda;

interface

uses
  SimpleAttributes;

type
  [Tabela('venda')]
  TVenda = class
  private
    Fid: Int64;
    FId_Cliente: Int64;
    FVlr_desc: Currency;
    FVlr_subtotal: Currency;
    FVlr_total: Currency;
    FDoc_cliente: string;
    FVlr_ecres: Currency;
    FNome_cliente: string;
    FDta_emissao: TDate;
    FId_usuario: Int64;
    FFone_cliente: string;
    FVlr_acres: Currency;

  public
    [Campo('id'), PK, AutoInc]
    property Id: Int64 read Fid write Fid;
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
    property Dta_emissao: TDate read FDta_emissao write FDta_emissao;
    [Campo('vlr_subtotal')]
    property Vlr_subtotal: Currency read FVlr_subtotal write FVlr_subtotal;
    [Campo('vlr_desc')]
    property Vlr_desc: Currency read FVlr_desc write FVlr_desc;
    [Campo('vlr_acres')]
    property Vlr_acres: Currency read FVlr_acres write FVlr_acres;
    [Campo('vlr_total')]
    property Vlr_total: Currency read FVlr_total write FVlr_total;
  end;

implementation


end.
