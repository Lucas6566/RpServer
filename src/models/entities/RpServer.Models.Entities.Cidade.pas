unit RpServer.Models.Entities.Cidade;

interface

uses
  SysUtils,
  Generics.Collections,
  Aurelius.Mapping.Attributes,
  Aurelius.Types.Blob,
  Aurelius.Types.DynamicProperties,
  Aurelius.Types.Nullable,
  Aurelius.Types.Proxy,
  Aurelius.Dictionary.Classes,
  Aurelius.Linq;

type
  [Entity]
  [Table('cidade')]
  [Id('Fid', TIdGenerator.IdentityOrSequence)]
  Tcidade = class
  private
    [Column('id', [TColumnProp.Required, TColumnProp.NoInsert, TColumnProp.NoUpdate])]
    Fid: Int64;
    [Column('nome', [TColumnProp.Required], 100)]
    Fnome: string;
    [Column('uf', [TColumnProp.Required], 2)]
    Fuf: string;
  public
    property id: Int64 read Fid write Fid;
    property nome: string read Fnome write Fnome;
    property uf: string read Fuf write Fuf;
  end;

implementation

initialization
  RegisterEntity(Tcidade);

end.
