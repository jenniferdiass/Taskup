object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'TaskUp -  Gerenciador de Tarefas'
  ClientHeight = 880
  ClientWidth = 983
  Color = clWhite
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object lblTituloFrase: TLabel
    Left = 328
    Top = 13
    Width = 3
    Height = 15
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 320
    Top = 688
    Width = 125
    Height = 21
    Caption = #10022' FRASE DO DIA'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlTopo: TPanel
    Left = 0
    Top = 0
    Width = 983
    Height = 92
    Align = alTop
    BevelOuter = bvNone
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lblTituloPagina: TLabel
      Left = 8
      Top = 5
      Width = 192
      Height = 37
      Caption = 'Minhas Tarefas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -27
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSubTitulo: TLabel
      Left = 11
      Top = 48
      Width = 321
      Height = 17
      Caption = 'Organize suas atividades e acompanhe seu progresso.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object pnlMenu: TPanel
    Left = 0
    Top = 92
    Width = 200
    Height = 788
    Align = alLeft
    BevelOuter = bvNone
    Color = clNavy
    ParentBackground = False
    TabOrder = 1
    object lblLogo: TLabel
      Left = 20
      Top = 25
      Width = 81
      Height = 32
      Caption = 'TaskUp'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblPainelGeral: TLabel
      Left = 16
      Top = 96
      Width = 69
      Height = 17
      Caption = 'Painel Geral'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = lblPainelGeralClick
    end
    object lblMinhasTarefas: TLabel
      Left = 16
      Top = 134
      Width = 88
      Height = 17
      Caption = 'Minhas Tarefas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = lblMinhasTarefasClick
    end
    object lblSubTarefas: TLabel
      Left = 16
      Top = 177
      Width = 64
      Height = 17
      Caption = 'SubTarefas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = lblSubTarefasClick
    end
    object lblTodasTarefas: TLabel
      Left = 16
      Top = 217
      Width = 98
      Height = 17
      Cursor = crHandPoint
      Caption = 'Todas as Tarefas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      OnClick = lblTodasTarefasClick
    end
  end
  object pnlConteudo: TPanel
    Left = 232
    Top = 98
    Width = 801
    Height = 577
    BevelOuter = bvNone
    TabOrder = 2
    object lblListaTarefas: TLabel
      Left = 15
      Top = 152
      Width = 131
      Height = 25
      Caption = 'Minhas Tarefas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object pnlTotalTarefas: TPanel
      Left = 0
      Top = 11
      Width = 250
      Height = 115
      BevelOuter = bvNone
      Caption = 'pnlTotalTarefas'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lblTotalTitulo: TLabel
        Left = 15
        Top = 4
        Width = 93
        Height = 17
        Caption = 'Total de Tarefas'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblTotalValor: TLabel
        Left = 15
        Top = 29
        Width = 18
        Height = 45
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlPendentes: TPanel
      Left = 215
      Top = 11
      Width = 250
      Height = 115
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object lblPendentes: TLabel
        Left = 55
        Top = 4
        Width = 60
        Height = 17
        Caption = 'Pendentes'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblPendentesValor: TLabel
        Left = 97
        Top = 27
        Width = 18
        Height = 45
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlConcluidas: TPanel
      Left = 471
      Top = 11
      Width = 250
      Height = 115
      BevelOuter = bvNone
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object lblConcluidas: TLabel
        Left = 83
        Top = 7
        Width = 63
        Height = 17
        Caption = 'Conclu'#237'das'
        Font.Charset = ANSI_CHARSET
        Font.Color = clGray
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblConcluidasValor: TLabel
        Left = 128
        Top = 32
        Width = 18
        Height = 45
        Caption = '0'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -32
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object sgTarefas: TStringGrid
      Left = 15
      Top = 200
      Width = 714
      Height = 377
      ColCount = 4
      DefaultRowHeight = 32
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ScrollBars = ssVertical
      TabOrder = 6
      OnDblClick = sgTarefasDblClick
      OnSelectCell = sgTarefasSelectCell
    end
    object btnNovaTarefa: TButton
      Left = 312
      Top = 159
      Width = 130
      Height = 35
      Caption = '+ Nova Tarefa'
      TabOrder = 3
      OnClick = btnNovaTarefaClick
    end
    object btnEditarTarefa: TButton
      Left = 457
      Top = 159
      Width = 129
      Height = 35
      Caption = 'Editar tarefa'
      TabOrder = 4
      OnClick = btnEditarTarefaClick
    end
    object btnExcluirTarefa: TButton
      Left = 601
      Top = 159
      Width = 129
      Height = 35
      Caption = 'Excluir Tarefa'
      TabOrder = 5
      OnClick = btnExcluirTarefaClick
    end
  end
  object pnlFrase: TPanel
    Left = 456
    Top = 688
    Width = 505
    Height = 121
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Color = clWhite
    ParentBackground = False
    TabOrder = 3
    object lblFrase: TLabel
      Left = 38
      Top = 17
      Width = 453
      Height = 79
      Alignment = taCenter
      AutoSize = False
      Caption = 'Sua frase aparecer'#225' aqui'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      Layout = tlCenter
      WordWrap = True
    end
  end
  object btnNovaFrase: TButton
    Left = 330
    Top = 715
    Width = 120
    Height = 25
    Cursor = crHandPoint
    Caption = #8635' Nova frase'
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -12
    Font.Name = 'LblTituloFrase'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = btnNovaFraseClick
  end
end
