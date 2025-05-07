unit RpServer.Controller.FormaPagamento;

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
  RpServer.Model.Entity.FormaPagamento,
  RpServer.Model.Dao.Generic;

{ TControllerFormaPagamento }

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFormaPagamento>;
begin
  iDAO := TDAOGeneric<TFormaPagamento>.New;
  Res.Send(iDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFormaPagamento>;
  LRetorno : TJSONObject;
begin
  iDAO := TDAOGeneric<TFormaPagamento>.New;

  LRetorno := iDAO.Find(Req.Params.Items['id']);

  if Assigned(LRetorno) then
    Res.Send<TJSONObject>(LRetorno)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('FormaPagamento n�o cadastrado');
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFormaPagamento>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TFormaPagamento>.New;

  Res.Send<TJSONObject>(iDAO.Insert(LJson));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFormaPagamento>;
begin
  iDAO := TDAOGeneric<TFormaPagamento>.New;
  if iDAO.Delete(Req.Params.Items['id']) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('N�o foi possivel localizar o FormaPagamento');
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFormaPagamento>;
  lJson: TJSONObject;
begin
  lJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TFormaPagamento>.New;

  if iDAO.Update(lJson) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('N�o foi possivel localizar o FormaPagamento');
end;

procedure Registry;
begin
  THorse.Get('/formapagamento', Get);
  THorse.Get('/formapagamento/:id', GetID);
  THorse.Post('/formapagamento', Insert);
  THorse.Delete('/formapagamento/:id', Delete);
  THorse.Put('/formapagamento', Update);
end;

end.

