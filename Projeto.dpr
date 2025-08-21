program Projeto;

uses
  Vcl.Forms,
  projeto.view.principal in 'view\projeto.view.principal.pas' {frmMain},
  projeto.view.pedido in 'view\projeto.view.pedido.pas' {frmVisualPedidos},
  projeto.model.dao.consts in 'model\dao\projeto.model.dao.consts.pas',
  projeto.controller.cliente in 'controller\projeto.controller.cliente.pas',
  projeto.controller.interfaces in 'controller\projeto.controller.interfaces.pas',
  projeto.controller.pedido in 'controller\projeto.controller.pedido.pas',
  projeto.controller.produto in 'controller\projeto.controller.produto.pas',
  projeto.model.adapter in 'model\adapter\projeto.model.adapter.pas',
  projeto.model.connection.firedac in 'model\connection\projeto.model.connection.firedac.pas',
  projeto.model.connection.firedac.query in 'model\connection\projeto.model.connection.firedac.query.pas',
  projeto.model.connection.interfaces in 'model\connection\projeto.model.connection.interfaces.pas',
  projeto.model.dao.cliente in 'model\dao\projeto.model.dao.cliente.pas',
  projeto.model.dao.interfaces in 'model\dao\projeto.model.dao.interfaces.pas',
  projeto.model.dao.pedido in 'model\dao\projeto.model.dao.pedido.pas',
  projeto.model.dao.produto in 'model\dao\projeto.model.dao.produto.pas',
  projeto.model.dto.interfaces in 'model\dto\projeto.model.dto.interfaces.pas',
  projeto.model.dto in 'model\dto\projeto.model.dto.pas',
  projeto.model.entity.interfaces in 'model\entity\projeto.model.entity.interfaces.pas',
  projeto.model.entity in 'model\entity\projeto.model.entity.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmVisualPedidos, frmVisualPedidos);
  Application.Run;
end.
