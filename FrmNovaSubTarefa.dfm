object Form3: TForm3
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'Form3'
  ClientHeight = 538
  ClientWidth = 520
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object lblStatus: TLabel
    Left = 64
    Top = 208
    Width = 36
    Height = 16
    Caption = 'Status'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lblDescricao: TLabel
    Left = 64
    Top = 136
    Width = 55
    Height = 16
    Caption = 'Descri'#231#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pnlCabecalho: TPanel
    Left = 0
    Top = 0
    Width = 520
    Height = 80
    Align = alTop
    Color = clNavy
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1484
    object lblTitulo: TLabel
      Left = 48
      Top = 23
      Width = 144
      Height = 25
      Caption = 'Nova Subtarefa'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
  end
  object cmbStatus: TComboBox
    Left = 64
    Top = 230
    Width = 400
    Height = 22
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'cmbStatus'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 2
    Text = 'Pendente'
    Items.Strings = (
      'Pendente'
      'Conclu'#237'da')
  end
  object btnSalvar: TButton
    Left = 364
    Top = 272
    Width = 100
    Height = 35
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btnSalvarClick
  end
  object btnCancelar: TButton
    Left = 258
    Top = 272
    Width = 100
    Height = 35
    Caption = 'Cancelar'
    ModalResult = 2
    TabOrder = 3
  end
  object edtDescricao: TEdit
    Left = 64
    Top = 158
    Width = 400
    Height = 21
    TabOrder = 1
  end
end
