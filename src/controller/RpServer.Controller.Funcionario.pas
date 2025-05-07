unit RpServer.Controller.Funcionario;

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
  RpServer.Model.Entity.Funcionario,
  RpServer.Model.Dao.Generic;

{ TControllerFuncionario }

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFuncionario>;
begin
  iDAO := TDAOGeneric<TFuncionario>.New;
  Res.Send(iDAO.Find);
end;

procedure GetID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFuncionario>;
  LRetorno : TJSONObject;
begin
  iDAO := TDAOGeneric<TFuncionario>.New;

  LRetorno := iDAO.Find(Req.Params.Items['id']);

  if Assigned(LRetorno) then
    Res.Send<TJSONObject>(LRetorno)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Funcionario não cadastrado');
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFuncionario>;
  LJson : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TFuncionario>.New;

  Res.Send<TJSONObject>(iDAO.Insert(LJson));
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFuncionario>;
begin
  iDAO := TDAOGeneric<TFuncionario>.New;
  if iDAO.Delete(Req.Params.Items['id']) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o funcionario');
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  iDAO : iDAOGeneric<TFuncionario>;
  LJson, LRetorno : TJSONObject;
begin
  LJson := Req.Body<TJSONObject>;

  iDAO := TDAOGeneric<TFuncionario>.New;

  if iDAO.Update(LJson) then
    Res.Status(THTTPStatus.NoContent)
  else
    raise EHorseException.New
                           .Status(THTTPStatus.NotFound)
                           .Error('Não foi possivel localizar o funcionario');
end;

procedure Registry;
begin
  THorse.Get('/funcionario', Get);
  THorse.Get('/funcionario/:id', GetID);
  THorse.Post('/funcionario', Insert);
  THorse.Delete('/funcionario/:id', Delete);
  THorse.Put('/funcionario', Update);
end;

end.

interface

implementation

end.
