object frmSubTarefas: TfrmSubTarefas
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Subtarefas - TaskUp'
  ClientHeight = 596
  ClientWidth = 898
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 898
    Height = 100
    Align = alTop
    BevelOuter = bvNone
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    object lblTitulo: TLabel
      Left = 24
      Top = 16
      Width = 146
      Height = 33
      Caption = 'Subtarefas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      Transparent = True
    end
  end
  object pnlConteudo: TPanel
    Left = 0
    Top = 100
    Width = 898
    Height = 496
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 1
    OnClick = pnlConteudoClick
    object lblTituloLista: TLabel
      Left = 24
      Top = 24
      Width = 181
      Height = 23
      Caption = 'Lista de subtarefas'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object sgSubTarefas: TStringGrid
      Left = 24
      Top = 64
      Width = 561
      Height = 257
      ColCount = 3
      FixedCols = 0
      RowCount = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'sgSubTarefas'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
      ParentFont = False
      TabOrder = 0
    end
    object btnEditarSubTarefa: TButton
      Left = 416
      Top = 327
      Width = 75
      Height = 25
      Caption = 'Editar'
      TabOrder = 1
      OnClick = btnEditarSubTarefaClick
    end
    object btnExcluirSubTarefa: TButton
      Left = 510
      Top = 327
      Width = 75
      Height = 25
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirSubTarefaClick
    end
  end
  object btnNovaSubTarefa: TButton
    Left = 435
    Top = 123
    Width = 150
    Height = 35
    Caption = '+ Nova Subtarefa'
    TabOrder = 2
    OnClick = btnNovaSubTarefaClick
  end
end
