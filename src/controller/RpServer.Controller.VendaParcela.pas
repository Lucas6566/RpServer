unit RpServer.Controller.VendaParcela;

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
  RpServer.Model.Entity.VendaParcela,
  RpServer.Model.Dao.Generic;

{ TControllerVendaParcela }

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVendaParcela>;
begin
  iDAO := TDAOGeneric<TVendaParcela>.New;
  Res.Send(iDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVendaParcela>;
  LRetorno : TJSONObject;
begin
  iDAO := TDAOGeneric<TVendaParcela>.New;

  //LRetorno := iDAO.Find(Req.Params.Items['id']);
  LRetorno := iDAO.Find('id_venda', Req.Params.Items['id']);

  if Assigned(LRetorno) then
    Res.Send<TJSONObject>(LRetorno)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Parcela não cadastrado');
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVendaParcela>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TVendaParcela>.New;

  Res.Send<TJSONObject>(iDAO.Insert(LJson));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVendaParcela>;
begin
  iDAO := TDAOGeneric<TVendaParcela>.New;
  if iDAO.Delete(Req.Params.Items['id']) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar a parcela da venda');
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TVendaParcela>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TVendaParcela>.New;

  if iDAO.Update(LJson) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar a parcela da venda');
end;

procedure Registry;
begin
  THorse.Get('/vendaparcela', Get);
  THorse.Get('/vendaparcela/:id', GetID);
  THorse.Post('/vendaparcela', Insert);
  THorse.Delete('/vendaparcela/:id', Delete);
  THorse.Put('/vendaparcela', Update);
end;

end.

