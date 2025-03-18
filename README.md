# Modelo de Base de dados para E-Commerce

Este modelo é baseado no desafio proposto no bootcamp de Inteligência Artificial Aplicada a Dados com Copilot da DIO, o qual foi extruturado visado modelar um e-commerce:

 ### Este modelo possuem como entidades principais:
 - Cliente
 - Pedido
 - Produto
 - Fornecedor
 - Vendedor
 - Entrega
  

  ### Desafio
- SELECT Statement simples.
- Filtros com WHERE Statement.
- Expressão com atributo derivado.
- Expressão com ORDER BY.
- Expressão com Group By e HAVING Statement.
- Expressão com Select Statement mais complexo.
- Quantidade de pedidos feitos por clientes.
- Verifica se um vendedor é fornecedor.
- Listagem de todos os vendedore separando o cocumento pelo tipo.
- Relação de produtos fornecedores e estoques.
- Relação de nomes dos fornecedores e nomes dos produtos.
- Busca informações de entrega de pedido pela numero do documento de indentificação ou pelo codigo de rastreio.

### Refinamentos
- Cliente PJ e PF – Uma conta pode ser PJ ou PF, mas não pode ter as duas informações;
- Pagamento – Pode ter cadastrado mais de uma forma de pagamento;
- Entrega – Possui status e código de rastreio;