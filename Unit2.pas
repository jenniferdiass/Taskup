unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Grids,
  System.Generics.Collections, ModeloSubTarefa, ServicoSubTarefa;

type
  TfrmSubTarefas = class(TForm)
    pnlCabecalho: TPanel;
    lblTitulo: TLabel;
    pnlConteudo: TPanel;
    lblTituloLista: TLabel;
    sgSubTarefas: TStringGrid;
    btnNovaSubTarefa: TButton;
    btnEditarSubTarefa: TButton;
    btnExcluirSubTarefa: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnNovaSubTarefaClick(Sender: TObject);
    procedure btnEditarSubTarefaClick(Sender: TObject);
    procedure btnExcluirSubTarefaClick(Sender: TObject);
    procedure pnlConteudoClick(Sender: TObject);
  private
  public
    IDTarefa: Integer;
    NomeTarefa: string;
    procedure AtualizarListaSubTarefas;
  end;

var
  frmSubTarefas: TfrmSubTarefas;

implementation

uses
  FrmNovaSubTarefa;

{$R *.dfm}


procedure TfrmSubTarefas.AtualizarListaSubTarefas;
var
  Linha: Integer;
  Servico: TServicoSubTarefa;
  Lista: TObjectList<TSubTarefa>;
  SubTarefa: TSubTarefa;
begin
  if IDTarefa <= 0 then
    Exit;

  Servico := TServicoSubTarefa.Create;
  Lista := nil;

  try
    try
      Lista := Servico.Listar(IDTarefa);

    sgSubTarefas.RowCount := 2;
    sgSubTarefas.Rows[1].Clear;
    Linha := 1;

      for SubTarefa in Lista do
      begin
        if Linha >= sgSubTarefas.RowCount then
          sgSubTarefas.RowCount := Linha + 1;

        sgSubTarefas.Cells[0, Linha] :=
          IntToStr(SubTarefa.ID);

        sgSubTarefas.Cells[1, Linha] :=
          SubTarefa.Descricao;

        sgSubTarefas.Cells[2, Linha] :=
          SubTarefa.Status;

        sgSubTarefas.Cells[3, Linha] :=
          IntToStr(SubTarefa.IDTarefa);

        Inc(Linha);
      end;

      if Linha > 1 then
        sgSubTarefas.RowCount := Linha
      else
        sgSubTarefas.RowCount := 2;

    except
      on E: Exception do
        ShowMessage('Erro ao carregar subtarefas: ' + E.Message);
    end;

  finally
    Lista.Free;
    Servico.Free;
  end;
end;

procedure TfrmSubTarefas.btnEditarSubTarefaClick(Sender: TObject);
var
  IDSelecionado: Integer;
begin
  if sgSubTarefas.Row <= 0 then
  begin
    ShowMessage('Selecione uma subtarefa para editar.');
    Exit;
  end;

  IDSelecionado := StrToIntDef(
    sgSubTarefas.Cells[0, sgSubTarefas.Row], 0
  );

  if IDSelecionado = 0 then
  begin
    ShowMessage('Selecione uma subtarefa válida.');
    Exit;
  end;

  Form3.IDSubTarefaEdicao := IDSelecionado;

  Form3.edtDescricao.Text :=
    sgSubTarefas.Cells[1, sgSubTarefas.Row];

  Form3.cmbStatus.Text :=
    sgSubTarefas.Cells[2, sgSubTarefas.Row];

  Form3.ShowModal;

  AtualizarListaSubTarefas;
end;


procedure TfrmSubTarefas.btnExcluirSubTarefaClick(Sender: TObject);
var
  IDSelecionado: Integer;
  Servico: TServicoSubTarefa;
begin
  if sgSubTarefas.Row <= 0 then
  begin
    ShowMessage('Selecione uma subtarefa para excluir.');
    Exit;
  end;

  IDSelecionado := StrToIntDef(
    sgSubTarefas.Cells[0, sgSubTarefas.Row], 0
  );

  if IDSelecionado = 0 then
  begin
    ShowMessage('Selecione uma subtarefa válida.');
    Exit;
  end;

  if MessageDlg(
    'Deseja realmente excluir esta subtarefa?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  ) <> mrYes then
    Exit;

  Servico := TServicoSubTarefa.Create;

  try
    try
      if Servico.Excluir(IDSelecionado, IDTarefa) then
      begin
        AtualizarListaSubTarefas;
        ShowMessage('Subtarefa excluída com sucesso!');
      end
      else
        ShowMessage('Subtarefa não encontrada no banco.');

    except
      on E: Exception do
        ShowMessage('Erro ao excluir subtarefa: ' + E.Message);
    end;

  finally
    Servico.Free;
  end;
end;


procedure TfrmSubTarefas.btnNovaSubTarefaClick(Sender: TObject);
begin
  Form3.IDSubTarefaEdicao := 0;
  Form3.edtDescricao.Clear;
  Form3.cmbStatus.ItemIndex := 0;
  Form3.ShowModal;
end;

procedure TfrmSubTarefas.FormCreate(Sender: TObject);
begin

  sgSubTarefas.ColCount := 4;
  sgSubTarefas.RowCount := 2;
  sgSubTarefas.FixedRows := 1;
  sgSubTarefas.Options := sgSubTarefas.Options + [goRowSelect];
sgSubTarefas.DefaultRowHeight := 32;
  sgSubTarefas.Cells[0, 0] := 'ID';
  sgSubTarefas.Cells[1, 0] := 'Subtarefa';
  sgSubTarefas.Cells[2, 0] := 'Status';
  sgSubTarefas.Cells[3, 0] := 'ID Tarefa';

  sgSubTarefas.ColWidths[0] := 50;
  sgSubTarefas.ColWidths[1] := 250;
  sgSubTarefas.ColWidths[2] := 100;
  sgSubTarefas.ColWidths[3] := 100;
end;

procedure TfrmSubTarefas.pnlConteudoClick(Sender: TObject);
begin
  // Evento reservado para o painel de conteúdo.
end;

end.

