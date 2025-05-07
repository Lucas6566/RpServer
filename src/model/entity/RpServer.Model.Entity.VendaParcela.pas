unit RpServer.Model.Entity.VendaParcela;

interface

uses
  SimpleAttributes;

type
  [Tabela('venda_parcela')]
  TVendaParcela = class
  private
    Fid_venda: Int64;
    Fid: Int64;
    Fid_forma_pagamento: Int64;
    Fvlr_apagar: Currency;
    Fvlr_pago: Currency;

  public
    [Campo('id'), PK, AutoInc]
    property id: Int64 read Fid write Fid;
    [Campo('Id_venda'), FK]
    property id_venda: Int64 read Fid_venda write Fid_venda;
    [Campo('Id_forma_pagamento'), FK]
    property id_forma_pagamento: Int64 read Fid_forma_pagamento write Fid_forma_pagamento;
    [Campo('vlr_pago')]
    property vlr_pago: Currency read Fvlr_pago write Fvlr_pago;
    [Campo('vlr_apagar')]
    property vlr_apagar: Currency read Fvlr_apagar write Fvlr_apagar;
  end;

implementation

end.
