unit RpServer.Controller.Auth;

interface

uses
  RpServer.Model.Entity.Usuario,
  REST.Json,
  RpServer.Model.Dao.Generic;

procedure Registry;

implementation

uses
  Horse,
  System.JSON,
  JOSE.Core.JWT,
  JOSE.Core.Builder,
  System.SysUtils,
  System.DateUtils,
  Horse.JWT,
  BCrypt,
  System.Generics.Collections;

const
  CHAVE = 'SystemRP';

function GetToken(const aID: String; const aExpiration: TDateTime): String;
var
  lJWT : TJWT;
begin
  lJWT := TJWT.Create;
  try
    lJWT.Claims.IssuedAt   := Now;
    lJWT.Claims.Expiration := aExpiration;
    lJWT.Claims.Subject    := aID;
    Result := TJOSE.SHA256CompactToken(CHAVE, lJWT);
  finally
    lJWT.Free;
  end;
end;

function SetJsonToken(aID: String) : TJSONObject;
var
  lToken : TJSONObject;
begin
  lToken := TJSONObject.Create;
  lToken.AddPair('access', GetToken(aID, IncHour(Now)));
  lToken.AddPair('refresh', GetToken(aID, IncMonth(Now)));
  Result := lToken;
end;

function GetJsonToken(aLogin: string; aSenha: string) : TJSONObject;
var
  iDAO: iDAOGeneric<TUsuario>;
  lJson: TJSONObject;
  lSenha: String;
begin
  Result := nil;
  iDAO := TDAOGeneric<TUsuario>.New;
  lJson := iDAO.Find('login', aLogin);
  if  lJson.GetValue<Integer>('records') > 0 then begin
    lJson  := TJSONArray(lJson.GetValue('data')).Items[0] as TJSONObject;
    lJson.TryGetValue<String>('senha',lSenha);
    if lSenha.Equals(aSenha) then
      Result := SetJsonToken(lJson.GetValue<String>('id'));
  end;
end;


procedure EfetuarLogin(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lLogin, lSenha: String;
  lBody, lSend: TJSONObject;
begin
  lBody := Req.Body<TJSONObject>;

  if not lBody.TryGetValue<String>('login', lLogin) then
    raise EHorseException.New.Status(THTTPStatus.NotFound)
      .Error('Login não encontrado');

  if not lBody.TryGetValue<String>('senha', lSenha) then
    raise EHorseException.New.Status(THTTPStatus.NotFound)
      .Error('Senha não encontrado');

  lSend := GetJsonToken(lLogin, lSenha);

  if lSend = nil then
    raise EHorseException.New.Status(THTTPStatus.NotFound)
      .Error('Usuário não altorizado')
  else
    Res.Send(lSend);
end;

procedure RenovarToken(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  lSub, lToken: String;
begin
  lSub := Req.Session<TJSONObject>.Format();
  lSub := Req.Session<TJSONObject>.GetValue('sub').Value;
  lToken := GetToken(lSub, IncHour(now));
  Res.Send(TJSONObject.Create(TJSONPair.Create('access', lToken)));
end;

procedure Registry;
begin
  THorse.Post('/login', EfetuarLogin);
  THorse.Get('/refresh', RenovarToken);
end;

end.
