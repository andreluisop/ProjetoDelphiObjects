program Projeto;

uses
  Vcl.Forms,
  untMain in 'untMain.pas' {frmMain},
  untEntityInterfaces in 'untEntityInterfaces.pas',
  untPedido in 'untPedido.pas' {frmVisualPedidos},
  untCtrlInterfaces in 'untCtrlInterfaces.pas',
  untDTOInterfaces in 'untDTOInterfaces.pas',
  untDAOInterfaces in 'untDAOInterfaces.pas',
  untAdapter in 'untAdapter.pas',
  untConnection in 'untConnection.pas',
  untConsts in 'untConsts.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmVisualPedidos, frmVisualPedidos);
  Application.Run;
end.
