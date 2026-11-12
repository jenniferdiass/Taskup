unit FrmTarefa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

type
    TfrmTarefa = class(TForm)
    pnlCabecalho: TPanel;
    lblTitulo: TLabel;
    lblDescricaoTopo: TLabel;
    lblTituloTarefa: TLabel;
    edtTituloTarefa: TEdit;
    lblDescricao: TLabel;
    memDescricao: TMemo;
    lblVencimento: TLabel;
    dtpVencimento: TDateTimePicker;
    lblStatus: TLabel;
    cmbStatus: TComboBox;
    btnSalvar: TButton;
    btnCancelar: TButton;

    procedure btnSalvarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);

  private
    FModoVisualizacao: Boolean;
    FIDTarefaEdicao: Integer;

   public
   procedure VisualizarTarefa(
    const ATitulo, ADescricao, AStatus: string;
    AVencimento: TDateTime
  );

  procedure PrepararNovaTarefa;

  procedure PrepararEdicaoTarefa(
    AID: Integer;
    const ATitulo, ADescricao, AStatus: string;
    AVencimento: TDateTime
  );
  end;
var
  FormTarefa: TfrmTarefa;

implementation

uses
  FrmPrincipal, ModeloTarefa;

{$R *.dfm}

procedure TfrmTarefa.VisualizarTarefa(
  const ATitulo, ADescricao, AStatus: string;
  AVencimento: TDateTime
);
begin
  FModoVisualizacao := True;
  FIDTarefaEdicao := 0;

  edtTituloTarefa.Text := ATitulo;
  memDescricao.Text := ADescricao;
  cmbStatus.Text := AStatus;
  dtpVencimento.Date := AVencimento;

  edtTituloTarefa.ReadOnly := True;
  memDescricao.ReadOnly := True;
  cmbStatus.Enabled := False;
  dtpVencimento.Enabled := False;

  btnSalvar.Visible := False;
  btnCancelar.Caption := 'Fechar';

  lblTitulo.Caption := 'Detalhes da Tarefa';
end;

procedure TfrmTarefa.PrepararNovaTarefa;
begin
  FModoVisualizacao := False;
  FIDTarefaEdicao := 0;

  edtTituloTarefa.Clear;
  memDescricao.Clear;

  edtTituloTarefa.ReadOnly := False;
  memDescricao.ReadOnly := False;
  cmbStatus.Enabled := True;
  dtpVencimento.Enabled := True;

  btnSalvar.Visible := True;
  btnCancelar.Caption := 'Cancelar';

  if cmbStatus.Items.Count > 0 then
    cmbStatus.ItemIndex := 0;

  dtpVencimento.Date := Date;

  lblTitulo.Caption := 'Nova Tarefa';
end;

procedure TfrmTarefa.PrepararEdicaoTarefa(
  AID: Integer;
  const ATitulo, ADescricao, AStatus: string;
  AVencimento: TDateTime
);
begin
  FModoVisualizacao := False;
  FIDTarefaEdicao := AID;

  edtTituloTarefa.Text := ATitulo;
  memDescricao.Text := ADescricao;
  cmbStatus.Text := AStatus;
  dtpVencimento.Date := AVencimento;

  edtTituloTarefa.ReadOnly := False;
  memDescricao.ReadOnly := False;
  cmbStatus.Enabled := True;
  dtpVencimento.Enabled := True;

  btnSalvar.Visible := True;
  btnCancelar.Caption := 'Cancelar';

  lblTitulo.Caption := 'Editar Tarefa';
end;


procedure TfrmTarefa.btnSalvarClick(Sender: TObject);
var
  Tarefa: TTarefa;
  Mensagem: string;
begin
  if FModoVisualizacao then
  begin
    Close;
    Exit;
  end;

  // Cria um objeto da classe TTarefa
  Tarefa := TTarefa.Create;
  try
    // Preenche as propriedades do objeto
    Tarefa.ID := FIDTarefaEdicao;
    Tarefa.Titulo := Trim(edtTituloTarefa.Text);
    Tarefa.Descricao := memDescricao.Text;
    Tarefa.Status := cmbStatus.Text;
    Tarefa.Vencimento := dtpVencimento.Date;

    // Valida os dados antes de salvar
    if not Tarefa.Validar(Mensagem) then
    begin
      ShowMessage(Mensagem);
      edtTituloTarefa.SetFocus;
      Exit;
    end;

    // Se já existe, atualiza. Caso contrário, cadastra.
    if FIDTarefaEdicao > 0 then
    begin
      Form1.EditarTarefa(
        Tarefa.ID,
        Tarefa.Titulo,
        Tarefa.Descricao,
        Tarefa.Status,
        Tarefa.Vencimento
      );

    end
    else
    begin
      Form1.AdicionarTarefa(
        Tarefa.Titulo,
        Tarefa.Descricao,
        Tarefa.Status,
        Tarefa.Vencimento
      );

    end;

    FIDTarefaEdicao := 0;
    Close;

  finally
    Tarefa.Free;
  end;
end;


procedure TfrmTarefa.btnCancelarClick(Sender: TObject);
begin
  FIDTarefaEdicao := 0;
  Close;
end;

end.

