unit ModeloTarefa;

interface

uses
  System.SysUtils;

type
  TTarefa = class
  private
    FID: Integer;
    FTitulo: string;
    FDescricao: string;
    FVencimento: TDateTime;
    FStatus: string;

  public
    constructor Create;

    function Validar(out Mensagem: string): Boolean;

    property ID: Integer read FID write FID;
    property Titulo: string read FTitulo write FTitulo;
    property Descricao: string read FDescricao write FDescricao;
    property Vencimento: TDateTime read FVencimento write FVencimento;
    property Status: string read FStatus write FStatus;
  end;

implementation

constructor TTarefa.Create;
begin
  FID := 0;
  FTitulo := '';
  FDescricao := '';
  FVencimento := Date;
  FStatus := 'Pendente';
end;

function TTarefa.Validar(out Mensagem: string): Boolean;
begin
  Mensagem := '';
  Result := False;

  if Trim(FTitulo) = '' then
  begin
    Mensagem := 'Informe o título da tarefa.';
    Exit;
  end;

  if Trim(FStatus) = '' then
  begin
    Mensagem := 'Informe o status da tarefa.';
    Exit;
  end;

  Result := True;
end;

end.

