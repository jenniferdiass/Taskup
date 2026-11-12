unit ServicoSubTarefa;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  FireDAC.Stan.Param,
  DMConexao,
  ModeloSubTarefa;

type
  TServicoSubTarefa = class
  public
    function Listar(AIDTarefa: Integer): TObjectList<TSubTarefa>;
    function Inserir(
      ASubTarefa: TSubTarefa;
      out AMensagem: string
    ): Boolean;

    function Editar(
      ASubTarefa: TSubTarefa;
      out AMensagem: string
    ): Boolean;

    function Excluir(AID, AIDTarefa: Integer): Boolean;
  end;

implementation

function TServicoSubTarefa.Listar(
  AIDTarefa: Integer): TObjectList<TSubTarefa>;
var
  SubTarefa: TSubTarefa;
begin
  Result := TObjectList<TSubTarefa>.Create(True);

  try
    DataModule1.qryTeste.Close;
    DataModule1.qryTeste.SQL.Text :=
      'SELECT id, id_tarefa, descricao, status ' +
      'FROM subtarefas ' +
      'WHERE id_tarefa = :id_tarefa ' +
      'ORDER BY id';

    DataModule1.qryTeste.ParamByName('id_tarefa').AsInteger :=
      AIDTarefa;

    DataModule1.qryTeste.Open;

    while not DataModule1.qryTeste.Eof do
    begin
      SubTarefa := TSubTarefa.Create;

      SubTarefa.ID :=
        DataModule1.qryTeste.FieldByName('id').AsInteger;

      SubTarefa.IDTarefa :=
        DataModule1.qryTeste.FieldByName('id_tarefa').AsInteger;

      SubTarefa.Descricao :=
        DataModule1.qryTeste.FieldByName('descricao').AsString;

      SubTarefa.Status :=
        DataModule1.qryTeste.FieldByName('status').AsString;

      Result.Add(SubTarefa);

      DataModule1.qryTeste.Next;
    end;

    DataModule1.qryTeste.Close;

  except
    Result.Free;
    raise;
  end;
end;

function TServicoSubTarefa.Inserir(
  ASubTarefa: TSubTarefa;
  out AMensagem: string): Boolean;
begin
  Result := False;

  if not Assigned(ASubTarefa) then
  begin
    AMensagem := 'Subtarefa não informada.';
    Exit;
  end;

  if ASubTarefa.IDTarefa <= 0 then
  begin
    AMensagem := 'Tarefa principal inválida.';
    Exit;
  end;

  if not ASubTarefa.Validar(AMensagem) then
    Exit;

  DataModule1.qryTeste.Close;
  DataModule1.qryTeste.SQL.Text :=
    'INSERT INTO subtarefas ' +
    '(id_tarefa, descricao, status) ' +
    'VALUES (:id_tarefa, :descricao, :status)';

  DataModule1.qryTeste.ParamByName('id_tarefa').AsInteger :=
    ASubTarefa.IDTarefa;

  DataModule1.qryTeste.ParamByName('descricao').AsString :=
    ASubTarefa.Descricao;

  DataModule1.qryTeste.ParamByName('status').AsString :=
    ASubTarefa.Status;

  DataModule1.qryTeste.ExecSQL;

  Result := DataModule1.qryTeste.RowsAffected > 0;

  if Result then
    AMensagem := 'Subtarefa cadastrada com sucesso!'
  else
    AMensagem := 'Não foi possível cadastrar a subtarefa.';
end;

function TServicoSubTarefa.Editar(
  ASubTarefa: TSubTarefa;
  out AMensagem: string): Boolean;
begin
  Result := False;

  if not Assigned(ASubTarefa) then
  begin
    AMensagem := 'Subtarefa não informada.';
    Exit;
  end;

  if (ASubTarefa.ID <= 0) or (ASubTarefa.IDTarefa <= 0) then
  begin
    AMensagem := 'Identificação da subtarefa inválida.';
    Exit;
  end;

  if not ASubTarefa.Validar(AMensagem) then
    Exit;

  DataModule1.qryTeste.Close;
  DataModule1.qryTeste.SQL.Text :=
    'UPDATE subtarefas SET ' +
    'descricao = :descricao, ' +
    'status = :status ' +
    'WHERE id = :id AND id_tarefa = :id_tarefa';

  DataModule1.qryTeste.ParamByName('descricao').AsString :=
    ASubTarefa.Descricao;

  DataModule1.qryTeste.ParamByName('status').AsString :=
    ASubTarefa.Status;

  DataModule1.qryTeste.ParamByName('id').AsInteger :=
    ASubTarefa.ID;

  DataModule1.qryTeste.ParamByName('id_tarefa').AsInteger :=
    ASubTarefa.IDTarefa;

  DataModule1.qryTeste.ExecSQL;

  Result := DataModule1.qryTeste.RowsAffected > 0;

  if Result then
    AMensagem := 'Subtarefa atualizada com sucesso!'
  else
    AMensagem := 'Subtarefa não encontrada no banco de dados.';
end;

function TServicoSubTarefa.Excluir(
  AID, AIDTarefa: Integer): Boolean;
begin
  Result := False;

  if (AID <= 0) or (AIDTarefa <= 0) then
    Exit;

  DataModule1.qryTeste.Close;
  DataModule1.qryTeste.SQL.Text :=
    'DELETE FROM subtarefas ' +
    'WHERE id = :id AND id_tarefa = :id_tarefa';

  DataModule1.qryTeste.ParamByName('id').AsInteger := AID;

  DataModule1.qryTeste.ParamByName('id_tarefa').AsInteger :=
    AIDTarefa;

  DataModule1.qryTeste.ExecSQL;

  Result := DataModule1.qryTeste.RowsAffected > 0;
end;

end.

