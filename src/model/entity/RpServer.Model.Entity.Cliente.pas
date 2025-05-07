unit RpServer.Model.Entity.Cliente;

interface

uses
  SimpleAttributes;

type
  [Tabela('Cliente')]
  TCliente = class
  private
    Fid: Int64;
    FNome: string;
    FTipo_Pessoa: string;
    FId_Documento: string;
    FTelefone: string;
    FEmail: string;
    FSexo: string;
    FEndereco: string;
    FCEP: string;
    FComplemento: string;
    FId_Bairro: Int64;

    procedure Setid(const Value: Int64);
    procedure Setnome(const Value: string);
    procedure Settipo_pessoa(const Value: string);
    procedure Setid_documento(const Value: string);
    procedure Settelefone(const Value: string);
    procedure Setemail(const Value: string);
    procedure Setsexo(const Value: string);
    procedure Setendereco(const Value: string);
    procedure Setcep(const Value: string);
    procedure Setcomplemento(const Value: string);
    procedure Setid_bairro(const Value: Int64);

  public
    constructor Create;
    destructor Destroy; override;

  public
    [Campo('id'), PK, AutoInc]
    property Id: Int64 read FId write SetId;
    [Campo('nome')]
    property Nome: string read FNome write SetNome;
    [Campo('tipo_pessoa')]
    property Tipo_pessoa: string read FTipo_Pessoa write SetTipo_pessoa;
    [Campo('id_documento')]
    property Id_documento: string read FId_Documento write SetId_documento;
    [Campo('telefone')]
    property Telefone: string read FTelefone write SetTelefone;
    [Campo('email')]
    property Email: string read FEmail write SetEmail;
    [Campo('sexo')]
    property Sexo: string read FSexo write SetSexo;
    [Campo('endereco')]
    property Endereco: string read FEndereco write SetEndereco;
    [Campo('cep')]
    property Cep: string read FCEP write SetCep;
    [Campo('complemento')]
    property Complemento: string read FComplemento write SetComplemento;
    [Campo('id_bairro'), FK]
    property Id_bairro: Int64 read FId_Bairro write SetId_bairro;
  end;

implementation

procedure TCliente.Setid(const Value: Int64);
begin
  Fid := Value;
end;

procedure TCliente.Setnome(const Value: string);
begin
  FNome := Value;
end;

procedure TCliente.Settipo_pessoa(const Value: string);
begin
  FTipo_Pessoa := Value;
end;

procedure TCliente.Setid_documento(const Value: string);
begin
  FId_Documento := Value;
end;

procedure TCliente.Settelefone(const Value: string);
begin
  FTelefone := Value;
end;

procedure TCliente.Setemail(const Value: string);
begin
  FEmail := Value;
end;

procedure TCliente.Setsexo(const Value: string);
begin
  FSexo := Value;
end;

procedure TCliente.Setendereco(const Value: string);
begin
  FEndereco := Value;
end;

constructor TCliente.Create;
begin

end;

destructor TCliente.Destroy;
begin

  inherited;
end;

procedure TCliente.Setcep(const Value: string);
begin
  FCEP := Value;
end;

procedure TCliente.Setcomplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TCliente.Setid_bairro(const Value: Int64);
begin
  FId_Bairro := Value;
end;

end.
