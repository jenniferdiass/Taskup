unit ModeloSubTarefa;

interface

uses
  System.SysUtils;

type
  TSubTarefa = class
  private
    FID: Integer;
    FIDTarefa: Integer;
    FDescricao: string;
    FStatus: string;

  public
    constructor Create;

    function Validar(out Mensagem: string): Boolean;

    property ID: Integer read FID write FID;
    property IDTarefa: Integer read FIDTarefa write FIDTarefa;
    property Descricao: string read FDescricao write FDescricao;
    property Status: string read FStatus write FStatus;
  end;

implementation

constructor TSubTarefa.Create;
begin
  FID := 0;
  FIDTarefa := 0;
  FDescricao := '';
  FStatus := 'Pendente';
end;

function TSubTarefa.Validar(out Mensagem: string): Boolean;
begin
  Mensagem := '';
  Result := False;

  if FIDTarefa <= 0 then
  begin
    Mensagem := 'A subtarefa precisa estar vinculada a uma tarefa.';
    Exit;
  end;

  if Trim(FDescricao) = '' then
  begin
    Mensagem := 'Informe a descrição da subtarefa.';
    Exit;
  end;

  if Trim(FStatus) = '' then
  begin
    Mensagem := 'Informe o status da subtarefa.';
    Exit;
  end;

  Result := True;
end;

end.

