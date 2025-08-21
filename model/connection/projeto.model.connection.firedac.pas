unit projeto.model.connection.firedac;

interface

uses
  System.Classes, SysUtils,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDac.DApt,
  FireDac.Phys.SQLite, FireDac.Phys.SQLiteDef,
  projeto.model.connection.interfaces;


type

  TFireDacConnection = class(TInterfacedObject, IConnection)
  private
    FConn: TFDConnection;

    constructor Create;
    destructor destroy; override;
  public
    function Connection: TCustomConnection;

    class function New: IConnection;
  end;

implementation

function TFireDacConnection.Connection: TCustomConnection;
begin
  Result := Self.FConn;
end;

constructor TFireDacConnection.Create;
begin
  inherited Create;
  FConn := TFDConnection.Create(Nil);
  try
    FConn.Params.Clear;
    FConn.Params.DriverID := 'SQLite';
    FConn.LoginPrompt := False;
    FConn.Params.Add('Database=' + ExtractFilePath(ParamStr(0))+'\banco\Banco.db');
    FConn.Params.Add('DriverID=SQLite');
    FConn.Open;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro conectar banco de dados: ' + E.Message);
    end;
  end;
end;

destructor TFireDacConnection.destroy;
begin
  FreeAndNil(FConn);
  inherited;
end;

class function TFireDacConnection.New: IConnection;
begin
  Result := Self.Create;
end;

end.
