unit DMConexao;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Comp.Client,
  FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    FDConnection1: TFDConnection;
    FDPhysPgDriverLink1: TFDPhysPgDriverLink;
    qryTeste: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  FDConnection1.Connected := False;

  FDConnection1.Params.Clear;
  FDConnection1.Params.Add('DriverID=PG');
  FDConnection1.Params.Add('Server=localhost');
  FDConnection1.Params.Add('Port=5433');
  FDConnection1.Params.Add('Database=taskup');
  FDConnection1.Params.Add('User_Name=postgres');
  FDConnection1.Params.Add('Password=123456');

  FDConnection1.LoginPrompt := False;

  FDConnection1.Connected := True;

  qryTeste.Close;
end;

end.
