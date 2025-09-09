unit RpServer.Model.Dao.Generic;

interface

uses
  System.JSON,
  Data.DB;

type
  iDAOGeneric<T : class> = interface
    ['{8A61E910-0112-41C4-839F-E4EC8F9CD6DB}']
    function Get : TJSONObject;
    function Put (const aValue : TJSONObject): TJSONObject;
    function Insert (const aValue : TJSONObject): TJSONObject;
    function Delete (const aValue : TJSONObject): TJSONObject;

    function DataSource : TDataSource;
  end;

  TDAOGeneric<T : class, constructor> = class(TInterfacedObject, iDAOGeneric<T>)
  private

  public
    constructor Create;
    destructor Destroy; override;
    class function New : iDAOGeneric<T>;

  public
    function Get : TJSONObject;
    function Put (const aValue : TJSONObject): TJSONObject;
    function Insert (const aValue : TJSONObject): TJSONObject;
    function Delete (const aValue : TJSONObject): TJSONObject;

    function DataSource : TDataSource;
  end;


implementation

{ TDAOGeneric<T> }

constructor TDAOGeneric<T>.Create;
begin

end;

function TDAOGeneric<T>.DataSource: TDataSource;
begin

end;

function TDAOGeneric<T>.Delete(const aValue: TJSONObject): TJSONObject;
begin

end;

destructor TDAOGeneric<T>.Destroy;
begin

  inherited;
end;

function TDAOGeneric<T>.Get: TJSONObject;
begin

end;

function TDAOGeneric<T>.Insert(const aValue: TJSONObject): TJSONObject;
begin

end;

class function TDAOGeneric<T>.New: iDAOGeneric<T>;
begin

end;

function TDAOGeneric<T>.Put(const aValue: TJSONObject): TJSONObject;
begin

end;

end.
