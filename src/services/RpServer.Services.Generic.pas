unit RpServer.Services.Generic;

interface

uses
  System.JSON;

type
  iServiceGeneric = interface
    ['{FE726239-9F8C-4A05-8DE8-E6C422C89BD6}']
    function Get : TJSONObject;
    function Put (const aValue : TJSONObject): TJSONObject;
    function Insert (const aValue : TJSONObject): TJSONObject;
    function Delete (const aValue : TJSONObject): TJSONObject;
  end;

  TServiceGeneric = class(TInterfacedObject, iServiceGeneric)
  public
    constructor Create;
    destructor Destroy; override;
  public
    function Get : TJSONObject;
    function Put (const aValue : TJSONObject): TJSONObject;
    function Insert (const aValue : TJSONObject): TJSONObject;
    function Delete (const aValue : TJSONObject): TJSONObject;
  end;

implementation

{ TServiceGeneric }

constructor TServiceGeneric.Create;
begin

end;

function TServiceGeneric.Delete(const aValue: TJSONObject): TJSONObject;
begin

end;

destructor TServiceGeneric.Destroy;
begin

  inherited;
end;

function TServiceGeneric.Get: TJSONObject;
begin

end;

function TServiceGeneric.Insert(const aValue: TJSONObject): TJSONObject;
begin

end;

function TServiceGeneric.Put(const aValue: TJSONObject): TJSONObject;
begin

end;

end.
