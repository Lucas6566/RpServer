unit RpServer.Controller.TipoServico;

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
  RpServer.Model.Entity.TipoServico,
  RpServer.Model.Dao.Generic;

{ TControllerTipoServico }

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TTipoServico>;
begin
  iDAO := TDAOGeneric<TTipoServico>.New;
  Res.Send(iDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TTipoServico>;
  LRetorno : TJSONObject;
begin
  iDAO := TDAOGeneric<TTipoServico>.New;

  LRetorno := iDAO.Find(Req.Params.Items['id']);

  if Assigned(LRetorno) then
    Res.Send<TJSONObject>(LRetorno)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Tipo de servico não cadastrado');
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TTipoServico>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TTipoServico>.New;

  Res.Send<TJSONObject>(iDAO.Insert(LJson));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TTipoServico>;
begin
  iDAO := TDAOGeneric<TTipoServico>.New;
  if iDAO.Delete(Req.Params.Items['id']) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o tipo de servico');
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TTipoServico>;
  LJson, LRetorno : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TTipoServico>.New;

  if iDAO.Update(LJson) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o tipo de servico');
end;

procedure Registry;
begin
  THorse.Get('/tiposervico', Get);
  THorse.Get('/tiposervico/:id', GetID);
  THorse.Post('/tiposervico', Insert);
  THorse.Delete('/tiposervico/:id', Delete);
  THorse.Put('/tiposervico', Update);
end;

end.

