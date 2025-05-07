unit RpServer.Model.Connection;

interface

uses
  FireDAC.Phys.MySQL,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  System.JSON,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  Data.DB,
  Firedac.DApt,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef;

var
  FDriver : TFDPhysMySQLDriverLink;
  FConnList : TObjectList<TFDConnection>;

  function VendorLib : String;

  procedure ConnDriver;

  function Connected : Integer;
  procedure Disconnected(Index : Integer);

implementation

uses
  System.SysUtils,
  System.IOUtils;

function VendorLib : String;
var
  lVendorLib: String;
begin
  Result := '';

  lVendorLib := Format('%s%s', [TPath.GetDirectoryName(ParamStr(0)),
                                  '\lib\LIBMYSQL.DLL']);
  if FileExists(lVendorLib) then
    Result := lVendorLib;
end;

procedure ConnDriver;
begin
  FDriver := TFDPhysMySQLDriverLink.Create(nil);
  FDriver.VendorLib := VendorLib;
end;

function Connected : Integer;
var
  lCountConn: Integer;
begin
  if not Assigned(FConnList) then
    FConnList := TObjectList<TFDConnection>.Create;

  FConnList.Add(TFDConnection.Create(nil));
  lCountConn := Pred(FConnList.Count);

  FConnList.Items[lCountConn].LoginPrompt := False;
  FConnList.Items[lCountConn].Close;
  FConnList.Items[lCountConn].Params.Clear;

  FConnList.Items[lCountConn].Params.Add('Pooled=True');
  FConnList.Items[lCountConn].ConnectionDefName := 'RpServer';

  if not Assigned(FDriver) then
    ConnDriver;

  FConnList.Items[lCountConn].Connected;

  Result := lCountConn;
end;

procedure Disconnected(Index : Integer);
begin
  FConnList.Items[Index].Connected := False;
  FConnList.Items[Index].Free;
  FConnList.TrimExcess;

  FreeAndNil(FDriver);
end;

end.
