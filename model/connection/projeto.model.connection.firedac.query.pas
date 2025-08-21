unit projeto.model.connection.firedac.query;

interface

uses
  System.SysUtils, Data.DB,
  FireDAC.Comp.Client,
  projeto.model.connection.interfaces;

type

  TOFDQuery = class(TInterfacedObject, iQuery)
  private
    FQuery: TFDQuery;

    constructor Create(const pConn: IConnection);
    destructor destroy; override;

    procedure GetParams(const pValue: Array of Variant);
  public
    function Open(const pStatement: String; const pParams: Array of Variant): TDataSet;

    procedure Exec(const pStatement: String; const pParams: Array of Variant);
    procedure StartTransaction;
    procedure Rollback;
    procedure Commit;

    class function New(const pConn: IConnection): iQuery;
  end;

implementation

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

function TOFDQuery.Open(const pStatement: String; const pParams: array of Variant): TDataSet;
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
