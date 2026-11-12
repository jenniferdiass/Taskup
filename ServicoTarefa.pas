
unit ServicoTarefa;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  Data.DB,
  FireDAC.Stan.Param,
  DMConexao,
  ModeloTarefa;

type
  TServicoTarefa = class
  public
    function Listar: TObjectList<TTarefa>;
    function Inserir(ATarefa: TTarefa; out AMensagem: string): Boolean;
    function Editar(ATarefa: TTarefa; out AMensagem: string): Boolean;
    function Excluir(AID: Integer): Boolean;
  end;

implementation

function TServicoTarefa.Listar: TObjectList<TTarefa>;
var
  Tarefa: TTarefa;
begin
  Result := TObjectList<TTarefa>.Create(True);

  try
    DataModule1.qryTeste.Close;
    DataModule1.qryTeste.SQL.Text :=
      'SELECT id, titulo, descricao, vencimento, status ' +
      'FROM tarefas ORDER BY id';

    DataModule1.qryTeste.Open;

    while not DataModule1.qryTeste.Eof do
    begin
      Tarefa := TTarefa.Create;

      Tarefa.ID :=
        DataModule1.qryTeste.FieldByName('id').AsInteger;

      Tarefa.Titulo :=
        DataModule1.qryTeste.FieldByName('titulo').AsString;

      Tarefa.Descricao :=
        DataModule1.qryTeste.FieldByName('descricao').AsString;

      Tarefa.Vencimento :=
        DataModule1.qryTeste.FieldByName('vencimento').AsDateTime;

      Tarefa.Status :=
        DataModule1.qryTeste.FieldByName('status').AsString;

      Result.Add(Tarefa);

      DataModule1.qryTeste.Next;
    end;

    DataModule1.qryTeste.Close;

  except
    Result.Free;
    raise;
  end;
end;

function TServicoTarefa.Inserir(
  ATarefa: TTarefa; out AMensagem: string): Boolean;
begin
  Result := False;

  if not Assigned(ATarefa) then
  begin
    AMensagem := 'Tarefa não informada.';
    Exit;
  end;

  if not ATarefa.Validar(AMensagem) then
    Exit;

  DataModule1.qryTeste.Close;
  DataModule1.qryTeste.SQL.Text :=
    'INSERT INTO tarefas ' +
    '(titulo, descricao, vencimento, status) ' +
    'VALUES (:titulo, :descricao, :vencimento, :status)';

  DataModule1.qryTeste.ParamByName('titulo').AsString :=
    ATarefa.Titulo;

  DataModule1.qryTeste.ParamByName('descricao').AsString :=
    ATarefa.Descricao;

  DataModule1.qryTeste.ParamByName('vencimento').AsDate :=
    ATarefa.Vencimento;

  DataModule1.qryTeste.ParamByName('status').AsString :=
    ATarefa.Status;

  DataModule1.qryTeste.ExecSQL;

  Result := DataModule1.qryTeste.RowsAffected > 0;

  if Result then
    AMensagem := 'Tarefa cadastrada com sucesso!'
  else
    AMensagem := 'Não foi possível cadastrar a tarefa.';
end;

function TServicoTarefa.Editar(
  ATarefa: TTarefa; out AMensagem: string): Boolean;
begin
  Result := False;

  if not Assigned(ATarefa) then
  begin
    AMensagem := 'Tarefa não informada.';
    Exit;
  end;

  if ATarefa.ID <= 0 then
  begin
    AMensagem := 'ID da tarefa inválido.';
    Exit;
  end;

  if not ATarefa.Validar(AMensagem) then
    Exit;

  DataModule1.qryTeste.Close;
  DataModule1.qryTeste.SQL.Text :=
    'UPDATE tarefas SET ' +
    'titulo = :titulo, ' +
    'descricao = :descricao, ' +
    'vencimento = :vencimento, ' +
    'status = :status ' +
    'WHERE id = :id';

  DataModule1.qryTeste.ParamByName('titulo').AsString :=
    ATarefa.Titulo;

  DataModule1.qryTeste.ParamByName('descricao').AsString :=
    ATarefa.Descricao;

  DataModule1.qryTeste.ParamByName('vencimento').AsDate :=
    ATarefa.Vencimento;

  DataModule1.qryTeste.ParamByName('status').AsString :=
    ATarefa.Status;

  DataModule1.qryTeste.ParamByName('id').AsInteger :=
    ATarefa.ID;

  DataModule1.qryTeste.ExecSQL;

  Result := DataModule1.qryTeste.RowsAffected > 0;

  if Result then
    AMensagem := 'Tarefa atualizada com sucesso!'
  else
    AMensagem := 'Tarefa não encontrada no banco de dados.';
end;

function TServicoTarefa.Excluir(AID: Integer): Boolean;
begin
  Result := False;

  if AID <= 0 then
    Exit;

  DataModule1.qryTeste.Close;
  DataModule1.qryTeste.SQL.Text :=
    'DELETE FROM tarefas WHERE id = :id';

  DataModule1.qryTeste.ParamByName('id').AsInteger := AID;

  DataModule1.qryTeste.ExecSQL;

  Result := DataModule1.qryTeste.RowsAffected > 0;
end;

end.

