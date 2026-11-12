object DataModule1: TDataModule1
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 569
  Width = 590
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=PG'
      'Server=localhost'
      'User_Name=postgres')
    LoginPrompt = False
    Left = 80
    Top = 48
  end
  object FDPhysPgDriverLink1: TFDPhysPgDriverLink
    VendorLib = 'C:\Program Files\PostgreSQL\17\bin\libpq.dll'
    Left = 376
    Top = 120
  end
  object qryTeste: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'SELECT'
      '    id,'
      '    titulo,'
      '    descricao,'
      '    vencimento,'
      '    status'
      'FROM tarefas'
      'ORDER BY id;')
    Left = 336
    Top = 328
  end
end
