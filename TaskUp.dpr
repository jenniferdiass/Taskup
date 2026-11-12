program TaskUp;

uses
  Vcl.Forms,
  FrmPrincipal in 'FrmPrincipal.pas' {Form1},
  FrmTarefa in 'FrmTarefa.pas' {frmTarefa},
  Unit2 in 'Unit2.pas' {frmSubTarefas},
  FrmNovaSubTarefa in 'FrmNovaSubTarefa.pas' {Form3},
  ModeloSubTarefa in 'ModeloSubTarefa.pas',
  FrmTodasTarefas in 'FrmTodasTarefas.pas' {Form4},
  ModeloTarefa in 'ModeloTarefa.pas',
  DMConexao in 'DMConexao.pas' {DataModule1: TDataModule},
  ServicoTarefa in 'ServicoTarefa.pas',
  ServicoSubTarefa in 'ServicoSubTarefa.pas',
  ServicoFrase in 'ServicoFrase.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmTarefa, FormTarefa);
  Application.CreateForm(TfrmSubTarefas, frmSubTarefas);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.Run;
end.
