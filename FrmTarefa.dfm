object frmTarefa: TfrmTarefa
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Nova Tarefa'
  ClientHeight = 516
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblTituloTarefa: TLabel
    Left = 25
    Top = 105
    Width = 96
    Height = 17
    Caption = 'T'#237'tulo da tarefa'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDescricao: TLabel
    Left = 25
    Top = 175
    Width = 59
    Height = 17
    Caption = 'Descri'#231#227'o'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblVencimento: TLabel
    Left = 25
    Top = 315
    Width = 73
    Height = 17
    Caption = 'Vencimento'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblStatus: TLabel
    Left = 300
    Top = 315
    Width = 38
    Height = 17
    Caption = 'Status'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 617
    Height = 85
    Align = alTop
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 797
    object lblTitulo: TLabel
      Left = 96
      Top = 15
      Width = 137
      Height = 32
      Caption = 'Nova Tarefa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -24
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblDescricaoTopo: TLabel
      Left = 27
      Top = 48
      Width = 234
      Height = 17
      Caption = 'Preencha os dados da atividade abaixo.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
  end
  object edtTituloTarefa: TEdit
    Left = 25
    Top = 130
    Width = 530
    Height = 21
    TabOrder = 1
  end
  object memDescricao: TMemo
    Left = 25
    Top = 200
    Width = 530
    Height = 100
    Lines.Strings = (
      'memDescricao')
    TabOrder = 2
  end
  object dtpVencimento: TDateTimePicker
    Left = 25
    Top = 340
    Width = 240
    Height = 21
    Date = 46322.762245254630000000
    Time = 46322.762245254630000000
    TabOrder = 3
  end
  object cmbStatus: TComboBox
    Left = 300
    Top = 340
    Width = 240
    Height = 21
    Style = csDropDownList
    TabOrder = 4
    Items.Strings = (
      'Pendente'
      'Em andamento'
      'Conclu'#237'da')
  end
  object btnSalvar: TButton
    Left = 400
    Top = 420
    Width = 130
    Height = 35
    Caption = 'Salvar Tarefa'
    TabOrder = 6
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 290
    Top = 420
    Width = 100
    Height = 35
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 5
    OnClick = btnCancelarClick
  end
end
