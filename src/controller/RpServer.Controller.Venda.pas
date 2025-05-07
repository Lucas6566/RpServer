unit RpServer.Controller.Venda;

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
  RpServer.Model.Entity.Venda,
  RpServer.Model.Dao.Generic;

{ TControllerVenda }

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVenda>;
begin
  iDAO := TDAOGeneric<TVenda>.New;
  Res.Send(iDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVenda>;
  LRetorno : TJSONObject;
begin
  iDAO := TDAOGeneric<TVenda>.New;

  LRetorno := iDAO.Find(Req.Params.Items['id']);

  if Assigned(LRetorno) then
    Res.Send<TJSONObject>(LRetorno)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Venda não cadastrada');
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVenda>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TVenda>.New;

  Res.Send<TJSONObject>(iDAO.Insert(LJson));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVenda>;
begin
  iDAO := TDAOGeneric<TVenda>.New;
  if iDAO.Delete(Req.Params.Items['id']) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar a venda');
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVenda>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TVenda>.New;

  if iDAO.Update(LJson) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar a venda');
end;

procedure Registry;
begin
  THorse.Get('/venda', Get);
  THorse.Get('/venda/:id', GetID);
  THorse.Post('/venda', Insert);
  THorse.Delete('/venda/:id', Delete);
  THorse.Put('/venda', Update);
end;

end.

