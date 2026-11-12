object Form4: TForm4
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Todas as Tarefas'
  ClientHeight = 621
  ClientWidth = 1044
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 17
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 1044
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = 90
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentBackground = False
    ParentFont = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 30
      Top = 25
      Width = 170
      Height = 32
      Caption = 'Todas as Tarefas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lblvisualize: TLabel
      Left = 30
      Top = 63
      Width = 263
      Height = 21
      Caption = 'Visualize suas tarefas em um s'#243' lugar.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlConteudo: TPanel
    Left = 0
    Top = 100
    Width = 1044
    Height = 521
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 3
  end
  object sgTodasTarefas: TStringGrid
    Left = 30
    Top = 106
    Width = 970
    Height = 480
    Color = clWhite
    ColCount = 4
    DefaultRowHeight = 32
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goRowSelect, goThumbTracking]
    TabOrder = 4
  end
  object btnAtualizar: TButton
    Left = 774
    Top = 69
    Width = 75
    Height = 25
    Caption = 'Atualizar'
    TabOrder = 1
    OnClick = btnAtualizarClick
  end
  object cmbFiltroStatus: TComboBox
    Left = 855
    Top = 69
    Width = 145
    Height = 25
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 2
    Text = 'Todas as tarefas'
    OnChange = cmbFiltroStatusChange
    Items.Strings = (
      'Todas as tarefas'
      'Pendentes'
      'Conclu'#237'das')
  end
end
