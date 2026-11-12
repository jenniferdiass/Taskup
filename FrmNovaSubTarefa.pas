unit FrmNovaSubTarefa;

interface

  uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Unit2, ModeloSubTarefa, ServicoSubTarefa;

type
  TForm3 = class(TForm)
    pnlCabecalho: TPanel;
    lblTitulo: TLabel;
    lblStatus: TLabel;
    cmbStatus: TComboBox;
    btnSalvar: TButton;
    btnCancelar: TButton;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    procedure btnSalvarClick(Sender: TObject);
  private
  public
  IDSubTarefaEdicao: Integer;
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}




procedure TForm3.btnSalvarClick(Sender: TObject);
var
  NovaSubTarefa: TSubTarefa;
  Servico: TServicoSubTarefa;
  Mensagem: string;
  Sucesso: Boolean;
begin
  if frmSubTarefas.IDTarefa = 0 then
  begin
    ShowMessage('Nenhuma tarefa foi selecionada.');
    Exit;
  end;

  NovaSubTarefa := TSubTarefa.Create;
  Servico := TServicoSubTarefa.Create;

  try
    NovaSubTarefa.ID := IDSubTarefaEdicao;
    NovaSubTarefa.IDTarefa := frmSubTarefas.IDTarefa;
    NovaSubTarefa.Descricao := Trim(edtDescricao.Text);
    NovaSubTarefa.Status := cmbStatus.Text;

    if IDSubTarefaEdicao > 0 then
      Sucesso := Servico.Editar(NovaSubTarefa, Mensagem)
    else
      Sucesso := Servico.Inserir(NovaSubTarefa, Mensagem);

    if not Sucesso then
    begin
      ShowMessage(Mensagem);
      Exit;
    end;

    if IDSubTarefaEdicao > 0 then
      ShowMessage('Subtarefa atualizada com sucesso!')
    else
      ShowMessage('Subtarefa cadastrada com sucesso!');

    IDSubTarefaEdicao := 0;

    frmSubTarefas.AtualizarListaSubTarefas;

    edtDescricao.Clear;
    Close;

  finally
    Servico.Free;
    NovaSubTarefa.Free;
  end;
end;
end.

