unit RpServer.Model.ParamSQL;

interface

uses
  System.SysUtils, System.Generics.Collections, Data.DB;

type
  iParamSQL = interface
    ['{FB03D3DA-8330-4ABC-907C-F9ADF4C78C2E}']
    function Fields: String; overload;
    function Join: String; overload;
    function Where: String; overload;
    function OrderBy: String; overload;
    function GroupBy: String; overload;

    function Fields(const aValue : String): iParamSQL; overload;
    function Join(const aValue : String): iParamSQL; overload;
    function Where(const aValue : String): iParamSQL; overload;
    function OrderBy(const aValue : String): iParamSQL; overload;
    function GroupBy(const aValue : String): iParamSQL; overload;


    function Where(const AParams: TDictionary<string, string>; aDataSet: TDataSet): iParamSQL; overload;

    function ClearFields: iParamSQL;
  end;

  TParamSQL = class(TInterfacedObject, iParamSQL)
  private
	  FFields : String;
    FJoin : String;
    FWhere : String;
    FOrderBy : String;
    FGroupBy : String;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iParamSQL;

    function Fields: String; overload;
    function Join: String; overload;
    function Where: String; overload;
    function OrderBy: String; overload;
    function GroupBy: String; overload;

    function Fields(const aValue : String): iParamSQL; overload;
    function Join(const aValue : String): iParamSQL; overload;
    function Where(const aValue : String): iParamSQL; overload;
    function OrderBy(const aValue : String): iParamSQL; overload;
    function GroupBy(const aValue : String): iParamSQL; overload;

    function Where(const AParams: TDictionary<string, string>; aDataSet: TDataSet): iParamSQL; overload;

    function ClearFields: iParamSQL;
  end;

implementation

{ TParamSQL }

function TParamSQL.Fields: String;
begin
  Result := FFields;
end;

function TParamSQL.ClearFields: iParamSQL;
begin
  FFields  := EmptyStr;
  FJoin    := EmptyStr;
  FWhere   := EmptyStr;
  FOrderBy := EmptyStr;
  FGroupBy := EmptyStr;
end;

constructor TParamSQL.Create;
begin
  ClearFields;
end;

destructor TParamSQL.Destroy;
begin

  inherited;
end;

function TParamSQL.Fields(const aValue: String): iParamSQL;
begin
  FFields := aValue;
end;

function TParamSQL.GroupBy(const aValue: String): iParamSQL;
begin
  FGroupBy := aValue;
end;

function TParamSQL.GroupBy: String;
begin
  Result := FGroupBy;
end;

function TParamSQL.Join: String;
begin
  Result := FJoin;
end;

function TParamSQL.Join(const aValue: String): iParamSQL;
begin
  FJoin := aValue;
end;

class function TParamSQL.New: iParamSQL;
begin
  Result := Self.Create;
end;

function TParamSQL.OrderBy: String;
begin
  Result := FOrderBy;
end;

function TParamSQL.OrderBy(const aValue: String): iParamSQL;
begin
  FOrderBy := aValue;
end;

function TParamSQL.Where(const AParams: TDictionary<string, string>; aDataSet: TDataSet): iParamSQL;
var
  lWhere : String;
begin
  lWhere := ' 1=1 ';

  for var Key in AParams.Keys do begin
    case aDataSet.FieldByName(Key).DataType of
      ftString  : lWhere := Format('%s and %s like ''%s%%''', [lWhere, Key, AParams.Items[Key]]);
      ftDateTime: lWhere := Format('%s and %s %s', [lWhere, Key, AParams.Items[Key]]);
      else
        lWhere := Format('%s and %s = %s', [lWhere, Key, AParams.Items[Key]]);
    end;
  end;

  FWhere := lWhere;
end;

function TParamSQL.Where: String;
begin
  Result := FWhere;
end;

function TParamSQL.Where(const aValue: String): iParamSQL;
begin
  FWhere := aValue;
end;

end.
