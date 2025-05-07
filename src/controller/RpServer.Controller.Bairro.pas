unit RpServer.Controller.Bairro;

interface

uses
  Horse,
  System.JSON,
  IdHashMessageDigest,
  REST.Json;

  procedure Registry;

  procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation


uses
  RpServer.Model.Entity.Bairro,
  RpServer.Model.Dao.Generic;

{ TControllerBairro }

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TBairro>;
begin
  iDAO := TDAOGeneric<TBairro>.New;
  Res.Send(iDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TBairro>;
  LRetorno : TJSONObject;
begin
  iDAO := TDAOGeneric<TBairro>.New;

  LRetorno := iDAO.Find(Req.Params.Items['id']);

  if Assigned(LRetorno) then
    Res.Send<TJSONObject>(LRetorno)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Bairro não cadastrado');
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TBairro>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TBairro>.New;

  Res.Send<TJSONObject>(iDAO.Insert(LJson));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TBairro>;
begin
  iDAO := TDAOGeneric<TBairro>.New;
  if iDAO.Delete(Req.Params.Items['id']) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o Bairro');
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TBairro>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TBairro>.New;

  if iDAO.Update(LJson) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o Bairro');
end;

procedure Registry;
begin
  THorse.Get('/bairro', Get);
  THorse.Get('/bairro/:id', GetID);
  THorse.Post('/bairro', Insert);
  THorse.Delete('/bairro/:id', Delete);
  THorse.Put('/bairro', Update);
end;

end.

