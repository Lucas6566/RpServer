unit RpServer.Models.Connection;

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
  FireDAC.Phys.FBDef,
  Aurelius.Drivers.Interfaces,
  Aurelius.Drivers.FireDac,
  XData.Aurelius.ConnectionPool,
  Aurelius.Drivers.Base,
  Aurelius.Sql.MySQL,
  Aurelius.Schema.MySQL,
  Aurelius.Comp.Connection;

var
  FDriver : TFDPhysMySQLDriverLink;
  FConn: TFDConnection;
  FAurConn: TAureliusConnection;

  function VendorLib : String;

  procedure ConnDriver;

  function AureliusConnected : TAureliusConnection;
  function FDConnected : TFDConnection;
  procedure Disconnected(index : Integer);

implementation

uses
  System.SysUtils,
  System.IOUtils;

function VendorLib : String;
var
  Vendor: String;
begin
  Result := EmptyStr;

  Vendor := Format('%s%s', [tPath.GetDirectoryName(ParamStr(0)), '\lib\LIBMYSQL.DLL']);

  if FileExists(Vendor) then
    Result := Vendor;
end;

procedure ConnDriver;
begin
  FDriver := TFDPhysMySQLDriverLink.Create(nil);
  FDriver.VendorLib := VendorLib;
end;

function FDConnected : TFDConnection;
var
  CountConn: Integer;
begin
  FConn := TFDConnection.Create(nil);

  FConn.LoginPrompt := False;
  FConn.Close;
  FConn.Params.Add('Pooled=True');
  FConn.ConnectionDefName := 'RpServer';

  if not Assigned(FDriver) then
    ConnDriver;

  FConn.Connected;

  Result := FConn;
end;

function AureliusConnected : TAureliusConnection;
begin
  FAurConn := TAureliusConnection.Create(nil);
  FAurConn.SQLDialect := 'MySQL';
  FAurConn.AdaptedConnection := FDConnected;
  Result := FAurConn;
end;

procedure Disconnected(index : Integer);
begin
  FConn.Connected := False;
  FConn.Free;

  FreeAndNil(FDriver);
end;

end.
