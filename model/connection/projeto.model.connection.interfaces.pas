unit projeto.model.connection.interfaces;

interface

uses
  Data.DB;

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

implementation

end.
