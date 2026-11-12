unit FrmTodasTarefas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Grids, Vcl.ExtCtrls;

type
  TForm4 = class(TForm)
    pnlCabecalho: TPanel;
    pnlConteudo: TPanel;
    sgTodasTarefas: TStringGrid;
    btnAtualizar: TButton;
    lblTitulo: TLabel;
    lblvisualize: TLabel;
    cmbFiltroStatus: TComboBox;
    procedure btnAtualizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbFiltroStatusChange(Sender: TObject);

  private
    { Declaracoes privadas }
  public
    procedure AtualizarLista;
    procedure sgTodasTarefasDrawCell(Sender: TObject;
    ACol, ARow: Longint; Rect: TRect; State: TGridDrawState);
  end;

var
  Form4: TForm4;

implementation

uses
  FrmPrincipal, DMConexao, FireDAC.Stan.Param;

{$R *.dfm}



procedure TForm4.AtualizarLista;
var
  I, Linha: Integer;
  IDAtual: Integer;
  StatusFiltro: string;
begin
  // Define o status selecionado no filtro
  case cmbFiltroStatus.ItemIndex of
    1: StatusFiltro := 'Pendente';
    2: StatusFiltro := 'Concluída';
  else
    StatusFiltro := '';
  end;

  // Configura a grade
  sgTodasTarefas.ColCount := 4;
  sgTodasTarefas.FixedRows := 1;
  sgTodasTarefas.OnDrawCell := sgTodasTarefasDrawCell;

  sgTodasTarefas.ColWidths[0] := 430;
  sgTodasTarefas.ColWidths[1] := 150;
  sgTodasTarefas.ColWidths[2] := 140;
  sgTodasTarefas.ColWidths[3] := 120;
  sgTodasTarefas.DefaultRowHeight := 36;

  // Cabeçalhos
  sgTodasTarefas.Cells[0, 0] := 'Tarefa / Subtarefa';
  sgTodasTarefas.Cells[1, 0] := 'Vencimento';
  sgTodasTarefas.Cells[2, 0] := 'Status';
  sgTodasTarefas.Cells[3, 0] := 'Tipo';

  // Limpa os dados anteriores
  sgTodasTarefas.RowCount := 2;
  Linha := 1;

  if not Assigned(Form1) then
    Exit;

  // Percorre as tarefas principais
  for I := 1 to Form1.sgTarefas.RowCount - 1 do
  begin
    if Trim(Form1.sgTarefas.Cells[1, I]) <> '' then
    begin
      if (StatusFiltro = '') or
         (Form1.sgTarefas.Cells[3, I] = StatusFiltro) then
      begin
        IDAtual := StrToIntDef(
          Form1.sgTarefas.Cells[0, I], 0
        );

        // Adiciona a tarefa principal
        if Linha >= sgTodasTarefas.RowCount then
          sgTodasTarefas.RowCount := Linha + 1;

        sgTodasTarefas.Cells[0, Linha] :=
          Form1.sgTarefas.Cells[1, I];

        sgTodasTarefas.Cells[1, Linha] :=
          Form1.sgTarefas.Cells[2, I];

        sgTodasTarefas.Cells[2, Linha] :=
          Form1.sgTarefas.Cells[3, I];

        sgTodasTarefas.Cells[3, Linha] := 'Tarefa';

        Inc(Linha);

        // Busca as subtarefas diretamente no PostgreSQL
        DataModule1.qryTeste.Close;

        DataModule1.qryTeste.SQL.Text :=
          'SELECT descricao, status ' +
          'FROM subtarefas ' +
          'WHERE id_tarefa = :id_tarefa ' +
          'ORDER BY id';

        DataModule1.qryTeste.ParamByName(
          'id_tarefa'
        ).AsInteger := IDAtual;

        DataModule1.qryTeste.Open;

        while not DataModule1.qryTeste.Eof do
        begin
          if (StatusFiltro = '') or
             (DataModule1.qryTeste.FieldByName('status').AsString =
              StatusFiltro) then
          begin
            if Linha >= sgTodasTarefas.RowCount then
              sgTodasTarefas.RowCount := Linha + 1;

            sgTodasTarefas.Cells[0, Linha] :=
              '    ↳ ' +
              DataModule1.qryTeste.FieldByName('descricao').AsString;

            sgTodasTarefas.Cells[1, Linha] := '';

            sgTodasTarefas.Cells[2, Linha] :=
              DataModule1.qryTeste.FieldByName('status').AsString;

            sgTodasTarefas.Cells[3, Linha] := 'Subtarefa';

            Inc(Linha);
          end;

          DataModule1.qryTeste.Next;
        end;
      end;
    end;
  end;

  // Ajusta a quantidade final de linhas
  if Linha < 2 then
    sgTodasTarefas.RowCount := 2
  else
    sgTodasTarefas.RowCount := Linha;

  DataModule1.qryTeste.Close;
end;



procedure TForm4.btnAtualizarClick(Sender: TObject);
begin
  AtualizarLista;
end;

procedure TForm4.cmbFiltroStatusChange(Sender: TObject);
begin
  AtualizarLista;
end;

procedure TForm4.FormCreate(Sender: TObject);
begin
  pnlCabecalho.ParentBackground := False;
  pnlCabecalho.ParentColor := False;
  pnlCabecalho.Color := RGB(23, 43, 77);

  pnlConteudo.ParentBackground := False;
  pnlConteudo.ParentColor := False;
  pnlConteudo.Color := RGB(243, 245, 248);
   cmbFiltroStatus.ItemIndex := 0;
end;
  procedure TForm4.sgTodasTarefasDrawCell(Sender: TObject;
  ACol, ARow: Longint; Rect: TRect; State: TGridDrawState);
var
  Texto: string;
  CorFundo: TColor;
  CorTexto: TColor;
begin
  Texto := sgTodasTarefas.Cells[ACol, ARow];

  // Cores padrão
  CorFundo := clWhite;
  CorTexto := RGB(60, 70, 85);

  // Cabeçalho da grade
  if ARow = 0 then
  begin
    CorFundo := RGB(230, 235, 242);
    CorTexto := RGB(23, 43, 77);
  end
  // Tarefas principais
  else if sgTodasTarefas.Cells[3, ARow] = 'Tarefa' then
  begin
    CorFundo := clWhite;
    CorTexto := RGB(23, 43, 77);
  end
  // Subtarefas
  else
  begin
    CorFundo := RGB(248, 249, 251);
    CorTexto := RGB(90, 100, 115);
  end;

  // Destaque da linha selecionada
  if gdSelected in State then
  begin
    CorFundo := RGB(215, 228, 245);
    CorTexto := RGB(23, 43, 77);
  end;

  // Desenha o fundo
  sgTodasTarefas.Canvas.Brush.Color := CorFundo;
  sgTodasTarefas.Canvas.FillRect(Rect);

  // Define a cor e o estilo da fonte
  sgTodasTarefas.Canvas.Font.Color := CorTexto;

  if (ARow = 0) or
     (sgTodasTarefas.Cells[3, ARow] = 'Tarefa') then
    sgTodasTarefas.Canvas.Font.Style := [fsBold]
  else
    sgTodasTarefas.Canvas.Font.Style := [];

  // Desenha o texto
  sgTodasTarefas.Canvas.TextRect(
    Rect,
    Rect.Left + 8,
    Rect.Top + 9,
    Texto
  );

end;
end.

