unit FrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids, FrmTarefa, System.DateUtils, Unit2, FrmTodasTarefas, DMConexao, System.Generics.Collections,
ModeloTarefa, ServicoTarefa, ServicoFrase;

type
  TForm1 = class(TForm)
    pnlTopo: TPanel;
    pnlMenu: TPanel;
    pnlConteudo: TPanel;
    lblLogo: TLabel;
    lblPainelGeral: TLabel;
    lblMinhasTarefas: TLabel;
    lblSubTarefas: TLabel;
    lblTituloPagina: TLabel;
    lblSubTitulo: TLabel;
    pnlTotalTarefas: TPanel;
    pnlPendentes: TPanel;
    pnlConcluidas: TPanel;
    lblListaTarefas: TLabel;
    sgTarefas: TStringGrid;
    btnNovaTarefa: TButton;
    btnEditarTarefa: TButton;
    lblTotalTitulo: TLabel;
    lblTotalValor: TLabel;
    lblPendentes: TLabel;
    lblPendentesValor: TLabel;
    lblConcluidas: TLabel;
    lblConcluidasValor: TLabel;
    btnExcluirTarefa: TButton;
    lblTodasTarefas: TLabel;
    pnlFrase: TPanel;
    lblFrase: TLabel;
    btnNovaFrase: TButton;
    lblTituloFrase: TLabel;
    Label1: TLabel;

    procedure FormCreate(Sender: TObject);
    procedure btnNovaTarefaClick(Sender: TObject);
    procedure btnEditarTarefaClick(Sender: TObject);
    procedure lblSubTarefasClick(Sender: TObject);
    procedure sgTarefasSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure lblMinhasTarefasClick(Sender: TObject);
    procedure lblPainelGeralClick(Sender: TObject);
    procedure sgTarefasDblClick(Sender: TObject);
    procedure btnExcluirTarefaClick(Sender: TObject);
    procedure lblTodasTarefasClick(Sender: TObject);
    procedure btnNovaFraseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    procedure CarregarTarefasDoBanco;
    procedure CarregarFrase;
  public
    FIDTarefaSelecionada: Integer;
    FProximoID: Integer;

    procedure AdicionarTarefa(
      const ATitulo, ADescricao, AStatus: string;
      AVencimento: TDateTime
    );

    procedure EditarTarefa(
      AID: Integer;
      const ATitulo, ADescricao, AStatus: string;
      AVencimento: TDateTime
    );

    procedure AtualizarIndicadores;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CarregarFrase;
var
  Servico: TServicoFrase;
  Frase, Autor: string;
begin
  Servico := TServicoFrase.Create;

  try
    try
      if Servico.BuscarFrase(Frase, Autor) then
      begin
        lblFrase.Caption := '"' + Frase + '"' +
          #13#10 + '— ' + Autor;
      end
      else
        lblFrase.Caption := 'Não foi possível carregar uma frase.';
    except
      on E: Exception do
        lblFrase.Caption := 'Erro ao consultar frase: ' + E.Message;
    end;
  finally
    Servico.Free;
  end;
end;

procedure TForm1.btnNovaFraseClick(Sender: TObject);
begin
CarregarFrase;
end;

procedure TForm1.btnNovaTarefaClick(Sender: TObject);
begin
  FormTarefa.PrepararNovaTarefa;
  FormTarefa.ShowModal;
end;

procedure TForm1.btnEditarTarefaClick(Sender: TObject);
var
  Linha: Integer;
  DataVencimento: TDateTime;

begin
  Linha := sgTarefas.Row;

  if Linha <= 0 then
    Exit;

  if Trim(sgTarefas.Cells[1, Linha]) = '' then
  begin
    ShowMessage('Selecione uma tarefa para editar.');
    Exit;
  end;

  FIDTarefaSelecionada := StrToIntDef(
    sgTarefas.Cells[0, Linha], 0
  );

  if FIDTarefaSelecionada = 0 then
  begin
    ShowMessage('Não foi possível identificar a tarefa.');
    Exit;
  end;

  if not TryStrToDate(
    sgTarefas.Cells[2, Linha], DataVencimento
  ) then
    DataVencimento := Date;

  FormTarefa.PrepararEdicaoTarefa(
  FIDTarefaSelecionada,
  sgTarefas.Cells[1, Linha],
  sgTarefas.Cells[4, Linha],
  sgTarefas.Cells[3, Linha],
  DataVencimento
);
  FormTarefa.ShowModal;
end;




procedure TForm1.btnExcluirTarefaClick(Sender: TObject);
var
  Linha: Integer;
  Resposta: Integer;
  IDTarefaExcluir: Integer;
  Servico: TServicoTarefa;
begin
  Linha := sgTarefas.Row;

  if (Linha <= 0) or (Trim(sgTarefas.Cells[1, Linha]) = '') then
  begin
    ShowMessage('Selecione uma tarefa para excluir.');
    Exit;
  end;

  IDTarefaExcluir := StrToIntDef(
    sgTarefas.Cells[0, Linha], 0
  );

  if IDTarefaExcluir = 0 then
  begin
    ShowMessage('Não foi possível identificar a tarefa.');
    Exit;
  end;

  Resposta := MessageDlg(
    'Deseja realmente excluir esta tarefa e suas subtarefas?',
    mtConfirmation,
    [mbYes, mbNo],
    0
  );

  if Resposta <> mrYes then
    Exit;

  Servico := TServicoTarefa.Create;

  try
    try
      if Servico.Excluir(IDTarefaExcluir) then
      begin
        CarregarTarefasDoBanco;

        ShowMessage(
          'Tarefa e suas subtarefas excluídas com sucesso!'
        );
      end
      else
        ShowMessage('Tarefa não encontrada no banco de dados.');

    except
      on E: Exception do
        ShowMessage('Erro ao excluir tarefa: ' + E.Message);
    end;

  finally
    Servico.Free;
  end;
end;

procedure TForm1.sgTarefasDblClick(Sender: TObject);
var
  Linha: Integer;
  DataVencimento: TDateTime;
begin
  Linha := sgTarefas.Row;

  if Linha <= 0 then
    Exit;

  if Trim(sgTarefas.Cells[1, Linha]) = '' then
    Exit;

  if not TryStrToDate(
    sgTarefas.Cells[2, Linha], DataVencimento
  ) then
    DataVencimento := Date;

  FormTarefa.VisualizarTarefa(
    sgTarefas.Cells[1, Linha],
    sgTarefas.Cells[4, Linha],
    sgTarefas.Cells[3, Linha],
    DataVencimento
  );

  FormTarefa.ShowModal;
end;

procedure TForm1.sgTarefasSelectCell(Sender: TObject;
  ACol, ARow: Integer; var CanSelect: Boolean);
begin
  if ARow > 0 then
    FIDTarefaSelecionada := StrToIntDef(
      sgTarefas.Cells[0, ARow], 0
    );
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  pnlMenu.Color := RGB(23, 43, 77);

  sgTarefas.ColCount := 5;

  sgTarefas.Cells[0, 0] := 'ID';
  sgTarefas.Cells[1, 0] := 'Tarefa';
  sgTarefas.Cells[2, 0] := 'Vencimento';
  sgTarefas.Cells[3, 0] := 'Status';
  sgTarefas.Cells[4, 0] := 'Descrição';

  sgTarefas.ColWidths[0] := 60;
  sgTarefas.ColWidths[1] := sgTarefas.ClientWidth div 2;
  sgTarefas.ColWidths[2] := 160;
  sgTarefas.ColWidths[3] := 140;
  sgTarefas.ColWidths[4] := 0;

  sgTarefas.DefaultRowHeight := 32;
  sgTarefas.RowCount := 2;
  sgTarefas.FixedRows := 1;

  FIDTarefaSelecionada := 0;
  FProximoID := 1;

  CarregarTarefasDoBanco;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
CarregarFrase;
end;

procedure TForm1.lblMinhasTarefasClick(Sender: TObject);
begin
  lblTituloPagina.Caption := 'Minhas Tarefas';
  lblSubTitulo.Caption :=
    'Gerencie suas tarefas e acompanhe seu progresso';

  Form4.AtualizarLista;
  Form4.Show;
end;
procedure TForm1.lblPainelGeralClick(Sender: TObject);
begin
  lblTituloPagina.Caption := 'Painel Geral';
  lblSubTitulo.Caption :=
    'Acompanhe o resumo das suas tarefas';

  AtualizarIndicadores;
end;

procedure TForm1.lblSubTarefasClick(Sender: TObject);
begin
  if FIDTarefaSelecionada = 0 then
  begin
    ShowMessage('Selecione uma tarefa primeiro.');
    Exit;
  end;

  frmSubTarefas.IDTarefa := FIDTarefaSelecionada;
  frmSubTarefas.NomeTarefa :=
    sgTarefas.Cells[1, sgTarefas.Row];

  frmSubTarefas.lblTituloLista.Caption :=
    'Subtarefas de: ' + frmSubTarefas.NomeTarefa;

  frmSubTarefas.AtualizarListaSubTarefas;
  frmSubTarefas.ShowModal;
end;

procedure TForm1.lblTodasTarefasClick(Sender: TObject);
begin
  Form4.AtualizarLista;
  Form4.ShowModal;
end;

procedure TForm1.AtualizarIndicadores;
var
  I: Integer;
  Total, Pendentes, Concluidas: Integer;
  Status: string;
begin
  Total := 0;
  Pendentes := 0;
  Concluidas := 0;

  for I := 1 to sgTarefas.RowCount - 1 do
  begin
    if Trim(sgTarefas.Cells[1, I]) <> '' then
    begin
      Inc(Total);

      Status := Trim(sgTarefas.Cells[3, I]);

      if SameText(Status, 'Pendente') then
        Inc(Pendentes)
      else if SameText(Status, 'Concluída') or
              SameText(Status, 'Concluida') then
        Inc(Concluidas);
    end;
  end;

  lblTotalValor.Caption := IntToStr(Total);
  lblPendentesValor.Caption := IntToStr(Pendentes);
  lblConcluidasValor.Caption := IntToStr(Concluidas);
end;


procedure TForm1.AdicionarTarefa(
  const ATitulo, ADescricao, AStatus: string;
  AVencimento: TDateTime
);
var
  Servico: TServicoTarefa;
  Tarefa: TTarefa;
  Mensagem: string;
begin
  Servico := TServicoTarefa.Create;
  Tarefa := TTarefa.Create;

  try
    Tarefa.Titulo := ATitulo;
    Tarefa.Descricao := ADescricao;
    Tarefa.Status := AStatus;
    Tarefa.Vencimento := AVencimento;

    try
      if Servico.Inserir(Tarefa, Mensagem) then
       begin
        CarregarTarefasDoBanco;
        ShowMessage('Tarefa adicionada com sucesso!');
    end
    else
       ShowMessage(Mensagem);

    except
      on E: Exception do
        ShowMessage('Erro ao cadastrar tarefa: ' + E.Message);
    end;

  finally
    Tarefa.Free;
    Servico.Free;
  end;
end;



procedure TForm1.EditarTarefa(
  AID: Integer;
  const ATitulo, ADescricao, AStatus: string;
  AVencimento: TDateTime
);
var
  Servico: TServicoTarefa;
  Tarefa: TTarefa;
  Mensagem: string;
begin
  Servico := TServicoTarefa.Create;
  Tarefa := TTarefa.Create;

  try
    Tarefa.ID := AID;
    Tarefa.Titulo := ATitulo;
    Tarefa.Descricao := ADescricao;
    Tarefa.Status := AStatus;
    Tarefa.Vencimento := AVencimento;

    try
      if Servico.Editar(Tarefa, Mensagem) then
      begin
        CarregarTarefasDoBanco;
        ShowMessage('Tarefa atualizada com sucesso!');
      end
      else
        ShowMessage(Mensagem);

    except
      on E: Exception do
        ShowMessage('Erro ao editar tarefa: ' + E.Message);
    end;

  finally
    Tarefa.Free;
    Servico.Free;
  end;
end;

procedure TForm1.CarregarTarefasDoBanco;
var
  Linha: Integer;
  Servico: TServicoTarefa;
  Lista: TObjectList<TTarefa>;
  Tarefa: TTarefa;
begin
  Servico := TServicoTarefa.Create;
  Lista := nil;

  try
    try
      Lista := Servico.Listar;

      sgTarefas.RowCount := 2;

      for Linha := 0 to sgTarefas.ColCount - 1 do
        sgTarefas.Cells[Linha, 1] := '';

      FProximoID := 1;
      Linha := 1;

      for Tarefa in Lista do
      begin
        if Linha >= sgTarefas.RowCount then
          sgTarefas.RowCount := Linha + 1;

        sgTarefas.Cells[0, Linha] :=
          IntToStr(Tarefa.ID);

        sgTarefas.Cells[1, Linha] :=
          Tarefa.Titulo;

        sgTarefas.Cells[2, Linha] :=
          DateToStr(Tarefa.Vencimento);

        sgTarefas.Cells[3, Linha] :=
          Tarefa.Status;

        sgTarefas.Cells[4, Linha] :=
          Tarefa.Descricao;

        if Tarefa.ID >= FProximoID then
          FProximoID := Tarefa.ID + 1;

        Inc(Linha);
      end;

      if Linha > 1 then
        sgTarefas.RowCount := Linha
      else
        sgTarefas.RowCount := 2;

      FIDTarefaSelecionada := 0;
      AtualizarIndicadores;

    except
      on E: Exception do
        ShowMessage('Erro ao carregar tarefas: ' + E.Message);
    end;

  finally
    Lista.Free;
    Servico.Free;
  end;
end;
end.
