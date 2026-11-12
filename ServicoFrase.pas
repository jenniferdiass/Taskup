unit ServicoFrase;

interface

uses
  System.SysUtils,
  System.Classes,
  System.JSON,
  REST.Client,
  REST.Types,
  IPPeerCommon,
  IPPeerClient;

type
  TServicoFrase = class
  public
    function BuscarFrase(
      out Frase, Autor: string
    ): Boolean;
  end;

implementation

function TServicoFrase.BuscarFrase(
  out Frase, Autor: string
): Boolean;
var
  RESTClient: TRESTClient;
  RESTRequest: TRESTRequest;
  RESTResponse: TRESTResponse;
  JSON: TJSONObject;
begin
  Result := False;
  Frase := '';
  Autor := '';

  RESTClient := TRESTClient.Create(
    'https://ditado-api.fly.dev/ditados/random'
  );

  RESTRequest := TRESTRequest.Create(nil);
  RESTResponse := TRESTResponse.Create(nil);

  try
    RESTRequest.Client := RESTClient;
    RESTRequest.Response := RESTResponse;
    RESTRequest.Method := rmGET;
    RESTRequest.Execute;

    if RESTResponse.StatusCode <> 200 then
      Exit;

    JSON := TJSONObject.ParseJSONValue(
      RESTResponse.Content
    ) as TJSONObject;

    try
      if Assigned(JSON) then
      begin
        Frase := JSON.GetValue<string>('content');
        Autor := JSON.GetValue<string>('meaning');

        Result := (Frase <> '') and (Autor <> '');
      end;
    finally
      JSON.Free;
    end;

  finally
    RESTRequest.Free;
    RESTResponse.Free;
    RESTClient.Free;
  end;
end;

end.

