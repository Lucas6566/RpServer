unit RpServer.Model.Dao.Generic;

interface

uses
  System.JSON,
  REST.Json,
  SimpleInterface,
  SimpleDAO,
  SimpleAttributes,
  SimpleQueryFiredac,
  Data.DB,
  DataSetConverter4D,
  DataSetConverter4D.Impl,
  DataSetConverter4D.Helper,
  DataSetConverter4D.Util,
  RpServer.Model.Connection,
  System.Generics.Collections,
  RpServer.Model.ParamSQL;

type
  iDAOGeneric<T : Class> = interface
    ['{B4D48166-7EAA-47F8-849F-7430FF65F364}']
    function Find : TJSONObject; overload;
    function Find (const aID : String ) : TJsonObject; overload;
    function Find (aKey: String; aValue: Variant) : TJsonObject; overload;
    function Find (const AParams: TDictionary<string, string>) : TJSONObject; overload;
    function Insert (const aJsonObject : TJsonObject) : TJsonObject;
    function Update (const aJsonObject : TJsonObject) : Boolean;
    function Delete (const aID : String) : Boolean; overload;
    function Delete (const AParams: TDictionary<string, string>) : Boolean; overload;

    function DataSource : TDataSource;
    function RecordCount : Integer;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function DAO : ISimpleDAO<T>;
  end;

  TDAOGeneric<T : class, constructor> = class(TInterfacedObject, iDAOGeneric<T>)
  private
    FIndexConn : Integer;
    FConn : iSimpleQuery;
    FDAO : iSimpleDAO<T>;
    FDataSource : TDataSource;

    FParamSQL : iParamSQL;

    function GetJsonFind: TJSONObject;
    procedure FindNil;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iDAOGeneric<T>;

    function Find : TJSONObject; overload;
    function Find (const aID : String ) : TJsonObject; overload;
    function Find (aKey: String; aValue: Variant) : TJsonObject; overload;
    function Find (const AParams: TDictionary<string, string>) : TJSONObject; overload;
    function Insert (const aJsonObject : TJsonObject) : TJsonObject;
    function Update (const aJsonObject : TJsonObject) : Boolean;
    function Delete (const aID : String) : Boolean; overload;
    function Delete (const AParams: TDictionary<string, string>) : Boolean; overload;

    function DataSource : TDataSource; virtual;
    function RecordCount : Integer; virtual;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function DAO : ISimpleDAO<T>;
  end;

implementation

uses
  System.SysUtils, DataSet.Serialize;

{ TDAOGeneric<T> }

constructor TDAOGeneric<T>.Create;
begin
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndNone;

  FDataSource := TDataSource.Create(nil);
  FIndexConn := RpServer.Model.Connection.Connected;
  FConn := TSimpleQueryFiredac.New(RpServer.Model.Connection.FConnList.Items[FIndexConn]);
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);

  FParamSQL := TParamSQL.New;
end;

function TDAOGeneric<T>.DAO: ISimpleDAO<T>;
begin
  Result := FDAO;
end;

function TDAOGeneric<T>.DataSetAsJsonArray: TJsonArray;
begin
  Result := FDataSource.DataSet.ToJSONArray;
end;

function TDAOGeneric<T>.DataSetAsJsonObject: TJsonObject;
begin
  Result := FDataSource.DataSet.ToJSONObject;
end;

function TDAOGeneric<T>.DataSource: TDataSource;
begin
  Result := FDataSource;
end;

function TDAOGeneric<T>.Delete(const aID: String): Boolean;
var
  LJson : TJSONObject;
  zT : T;
begin
  Result := False;
  zT := FDAO.Find(StrToInt(aID));

  if FDataSource.DataSet.RecordCount > 0 then begin
    FDAO.Delete(zT);
    Result := True;
  end;
end;

function TDAOGeneric<T>.Delete(const AParams: TDictionary<string, string>) : Boolean;
var
  LJson : TJSONObject;
begin
  FindNil;
  FParamSQL.Where(aParams, DataSource.DataSet);
  Find;

  Result := RecordCount > 0;

  if RecordCount > 0 then begin
    LJson := TJSONObject.Create;
    try
      LJson := FDataSource.DataSet.ToJSONObject;
      FDAO.Delete(TJson.JsonToObject<T>(lJson, [joDateFormatUnix]));
    finally
      FreeAndNil(LJson);
    end;
  end;
end;

destructor TDAOGeneric<T>.Destroy;
begin
  FDataSource.Free;
  RpServer.Model.Connection.Disconnected(FIndexConn);
  inherited;
end;

function TDAOGeneric<T>.Find(
  const AParams: TDictionary<string, string>): TJSONObject;
begin
  FindNil;
  FParamSQL.Where(aParams, DataSource.DataSet);
  Result := Find;
end;

function TDAOGeneric<T>.Find(aKey: String; aValue: Variant): TJsonObject;
var
  LJson : TJSONObject;
begin
  FDAO.Find(aKey, aValue);

  Result := GetJsonFind;
end;

function TDAOGeneric<T>.GetJsonFind: TJSONObject;
var
  LJson : TJSONObject;
begin
  LJson := TJSONObject.Create;
  LJson.AddPair('data', FDataSource.DataSet.ToJSONArray);
  LJson.AddPair('records', TJSONNumber.Create(RecordCount));
  Result := LJson;
end;

function TDAOGeneric<T>.Find: TJSONObject;
begin
  FDAO
    .SQL
      .Fields(FParamSQL.Fields)
      .Join(FParamSQL.Join)
      .Where(FParamSQL.Where)
      .OrderBy(FParamSQL.OrderBy)
      .GroupBy(FParamSQL.GroupBy)
    .&End
  .Find;

  FParamSQL.ClearFields;

  Result := GetJsonFind;
end;

function TDAOGeneric<T>.Find(const aID: String): TJsonObject;
begin
  FDAO.Find(StrToInt(aID));
  Result := GetJsonFind;
end;

function TDAOGeneric<T>.Insert(const aJsonObject: TJsonObject): TJsonObject;
begin
  FDAO.Insert(TJson.JsonToObject<T>(aJsonObject));
  FDAO
    .SQL
      .OrderBy('id desc limit 1')
    .&End
  .Find;

  Result := GetJsonFind;
end;

class function TDAOGeneric<T>.New: iDAOGeneric<T>;
begin
  Result := Self.Create;
end;

function TDAOGeneric<T>.RecordCount: Integer;
begin
  Result := FDataSource.DataSet.RecordCount;
end;

procedure TDAOGeneric<T>.FindNil;
begin
  if DataSource.DataSet.FieldCount = 0 then begin
    FParamSQL.Where('1<>1');
    Find;
  end;
end;

function TDAOGeneric<T>.Update(const aJsonObject: TJsonObject): Boolean;
begin
  var zId := 0;

  Result := False;

  aJsonObject.TryGetValue<Integer>('id', zId);
  FDAO.Find(zId);

  if RecordCount > 0 then begin
    FDAO.Update(TJson.JsonToObject<T>(aJsonObject));
    Result := True;
  end;
end;

end.
