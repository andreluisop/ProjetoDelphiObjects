unit untConnection;

interface

uses
  System.Classes, SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.DApt, FireDAC.Phys.SQLite, FireDAC.Phys.SQLiteDef;

type
  IConnection = Interface
    function Connection: TCustomConnection;
  end;

  iQuery = interface
    function Open(const pStatement: String; const pParams: Array of Variant): TDataSet;

    procedure Exec(const pStatement: String; const pParams: Array of Variant);
    procedure StartTransaction;
    procedure Rollback;
    procedure Commit;
  end;

  TFireDacConnection = class(TInterfacedObject, IConnection)
  Strict private
    FConn: TFDConnection;
  private
    constructor Create;
    destructor destroy; override;
  public
    function Connection: TCustomConnection;
    class function New: IConnection;
  end;

  TOFDQuery = class(TInterfacedObject, iQuery)
  strict private
    FQuery: TFDQuery;
  private
    constructor Create(const pConn: IConnection);
    destructor destroy; override;
    procedure GetParams(const pValue: Array of Variant);
  public
    procedure Exec(const pStatement: String; const pParams: Array of Variant);
    function Open(const pStatement: String; const pParams: Array of Variant): TDataSet;
    procedure StartTransaction;
    procedure Rollback;
    procedure Commit;
    class function New(const pConn: IConnection): iQuery;
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
    FConn.Params.Add('Database=' + ExtractFilePath(ParamStr(0))+'\Banco.db');
    FConn.Params.Add('DriverID=SQLite');
    FConn.Open;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao conectar: ' + E.Message);
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

procedure TOFDQuery.Commit;
begin
  FQuery.Connection.Commit;
end;

constructor TOFDQuery.Create(const pConn: IConnection);
begin
  inherited Create;
  Self.FQuery := TFDQuery.Create(nil);
  Self.FQuery.Connection := TFDConnection(pConn.Connection);
end;

destructor TOFDQuery.destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TOFDQuery.Exec(const pStatement: String;
  const pParams: array of Variant);
begin
  FQuery.Close;
  FQuery.SQL.Text := pStatement;
  GetParams(pParams);
  FQuery.ExecSQL;
end;

class function TOFDQuery.New(const pConn: IConnection): iQuery;
begin
  Result := Self.Create(pConn);
end;

function TOFDQuery.Open(const pStatement: String;
  const pParams: array of Variant): TDataSet;
begin
  FQuery.Close;
  FQuery.SQL.Text := pStatement;
  GetParams(pParams);
  FQuery.Open;
  Result := FQuery;
end;

procedure TOFDQuery.Rollback;
begin
  FQuery.Connection.Rollback;
end;

procedure TOFDQuery.StartTransaction;
begin
  FQuery.Connection.StartTransaction;
end;

procedure TOFDQuery.GetParams(const pValue: array of Variant);
var
  lIdx: Integer;
begin
  for lIdx := Low(pValue) to High(pValue) do
  begin
    FQuery.Params.Add;
    FQuery.Params[lIdx].Value := pValue[lIdx];
  end;
end;

end.
