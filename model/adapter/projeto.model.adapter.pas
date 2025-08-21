unit projeto.model.adapter;

interface

uses
  projeto.model.dto.interfaces,
  projeto.model.entity.interfaces;

type

  TAdapterProduto = class
  public
    class function EntityToDto(const pEntity: IEntityProduto): IProdutoDTO;
    class function LstEntityToLstDto(const pEntity: IEntityLstProduto): ILstProdutoDTO;
  end;

  TAdapterCliente = class
  public
    class function EntityToDto(const pEntity: IEntityCliente): IClienteDTO;
    class function LstEntityToLstDto(const pEntity: IEntityLstCliente): ILstClienteDTO;
  end;

  TAdapterPedido = class
  public
    class function DtoToEntity(const pDto: IPedidoDTO): IEntityPedido;
    class function ItemEntityToItemDto(const pEntity: IEntityPedidoItem): IPedidoItemDTO;
    class function LstEntityToLstDto(const pEntity: IEntityLstPedido): ILstPedidoDTO;
    class function LstItensEntityToLstItensDto(const pEntity: IEntityLstPedidoItens): ILstPedidoItensDTO;
    class function EntityToDto(const pEntity: IEntityPedido): IPedidoDTO;
    class function EntityItemToDtoItem(const pEntity: IEntityPedidoItem): IPedidoItemDTO;
  end;

implementation

uses
  projeto.model.entity,
  projeto.model.dto;

class function TAdapterProduto.EntityToDto(const pEntity: IEntityProduto): IProdutoDTO;
begin
  Result := TProdutoDTO.New;
  Result.codigo := pEntity.codigo;
  Result.descricao := pEntity.descricao;
  Result.precoVenda := pEntity.precoVenda;
end;

class function TAdapterProduto.LstEntityToLstDto(const pEntity: IEntityLstProduto): ILstProdutoDTO;
begin
  Result := TLstProdutoDTO.New;
  for var lItem in pEntity.Itens do
  begin
    Result.AddItem(EntityToDto(lItem));
  end;
end;

class function TAdapterCliente.EntityToDto(const pEntity: IEntityCliente): IClienteDTO;
begin
  Result := TClienteDTO.New;
  Result.codigo := pEntity.codigo;
  Result.nome := pEntity.nome;
  Result.cidade := pEntity.cidade;
  Result.uf := pEntity.uf;
end;

class function TAdapterCliente.LstEntityToLstDto(const pEntity: IEntityLstCliente): ILstClienteDTO;
begin
  Result := TLstClienteDTO.New;
  for var lItem in pEntity.Itens do
  begin
    Result.AddItem(EntityToDto(lItem));
  end;
end;

class function TAdapterPedido.DtoToEntity(const pDto: IPedidoDTO): IEntityPedido;
begin
  Result := TEntityPedido.New;
  Result.numeroPedido := pDto.numeroPedido;
  Result.dataEmissao := pDto.dataEmissao;
  Result.codigoCliente := pDto.codigoCliente;
  Result.valorTotal := pDto.valorTotal;
  Result.nomeCliente := pDto.nomeCliente;
end;

class function TAdapterPedido.EntityItemToDtoItem(const pEntity: IEntityPedidoItem): IPedidoItemDTO;
begin
  Result := TPedidoItemDTO.New;
  Result.id := pEntity.id;
  Result.numeroPedido := pEntity.numeroPedido;
  Result.codigoProduto := pEntity.codigoProduto;
  Result.quantidade := pEntity.quantidade;
  Result.valorUnitario := pEntity.valorUnitario;
  Result.valorTotal := pEntity.quantidade * pEntity.valorUnitario;
end;

class function TAdapterPedido.EntityToDto(const pEntity: IEntityPedido): IPedidoDTO;
begin
  Result := TPedidoDTO.New;
  Result.numeroPedido := pEntity.numeroPedido;
  Result.dataEmissao := pEntity.dataEmissao;
  Result.codigoCliente := pEntity.codigoCliente;
  Result.valorTotal := pEntity.valorTotal;
  Result.nomeCliente := pEntity.nomeCliente;
end;

class function TAdapterPedido.ItemEntityToItemDto(const pEntity: IEntityPedidoItem): IPedidoItemDTO;
begin
  Result := TPedidoItemDTO.New;
  Result.id := pEntity.id;
  Result.numeroPedido := pEntity.numeroPedido;
  Result.codigoProduto := pEntity.codigoProduto;
  Result.quantidade := pEntity.quantidade;
  Result.valorUnitario := pEntity.valorUnitario;
  Result.valorTotal := pEntity.valorTotal;
end;

class function TAdapterPedido.LstEntityToLstDto(const pEntity: IEntityLstPedido): ILstPedidoDTO;
begin
  Result := TLstPedidoDTO.New;
  for var lItem in pEntity.Itens do
  begin
    Result.AddItem(EntityToDto(lItem));
  end;
end;

class function TAdapterPedido.LstItensEntityToLstItensDto(const pEntity: IEntityLstPedidoItens): ILstPedidoItensDTO;
begin
  Result := TLstPedidoItensDTO.New;
  for var lItem in pEntity.Itens do
  begin
    Result.AddItem(ItemEntityToItemDto(lItem));
  end;
end;

end.
