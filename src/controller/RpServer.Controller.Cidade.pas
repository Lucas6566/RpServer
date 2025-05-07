unit RpServer.Controller.Cidade;

interface

uses
  Horse,
  System.JSON,
  IdHashMessageDigest;

  procedure Registry;

  procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation


uses
  RpServer.Model.Entity.Cidade,
  RpServer.Model.Dao.Generic;

{ TControllerCidade }

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TCidade>;
begin
  iDAO := TDAOGeneric<TCidade>.New;
  Res.Send(iDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TCidade>;       
  LRetorno : TJSONObject;
begin
  iDAO := TDAOGeneric<TCidade>.New;

  LRetorno := iDAO.Find(Req.Params.Items['id']);

  if Assigned(LRetorno) then
    Res.Send<TJSONObject>(iDAO.Find(Req.Params.Items['id']))
  else 
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Item não cadastrado');  
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TCidade>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TCidade>.New;
  Res.Send<TJSONObject>(iDAO.Insert(LJson));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TCidade>;
  LJson : TJSONObject;
begin
  iDAO := TDAOGeneric<TCidade>.New;
  if iDAO.Delete(Req.Params.Items['id']) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o Cliente');
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TCidade>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TCidade>.New;
  if iDAO.Update(LJson) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o Cliente');
end;

procedure Registry;
begin
  THorse.Get('/cidade', Get);
  THorse.Get('/cidade/:id', GetID);
  THorse.Post('/cidade', Insert);
  THorse.Delete('/cidade/:id', Delete);
  THorse.Put('/cidade', Update);
end;

end.
