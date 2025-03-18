-- SELECT Statement simples
select * from product;

-- Filtros com WHERE Statement
select pName as Nome, pDescription as Descrição, pSize as Tamanho from product where classification_kid=1;

-- Expressão com atributo derivado
select concat(fName," ",minit," ",sName) as Nome,
TIMESTAMPDIFF(YEAR,birthday, NOW()) as idade,
concat(street," ",complement,", ",neighborhood,", ",city,"-",state,", ",zip_code) as Endereço from clients;

-- Expressão com ORDER BY
select concat(fName," ",minit," ",sName) as Nome,
TIMESTAMPDIFF(YEAR,birthday, NOW()) as idade,
concat(street," ",complement,", ",neighborhood,", ",city,"-",state,", ",zip_code) as Endereço from clients
order by nome, idade;

-- Expressão com Group By e HAVING Statement
select category as Categoria, pSize as Tamanho, count(category) as Qtd from product
group by psize having(count(*)>2);

-- Expressão com Select Statement mais complexo
select concat(c.fName," ",c.minit," ",sName) as CLIENTE, pr.pName, pr.pDescription, pr.category,  (
CASE
WHEN pr.classification_kid='0' tHEN 'não'
     ELSE 'sim'
    END) as 'Para crianças',
concat('R$',pr.pValue) as Valor from clients as c
inner join orders as o on o.id_order_client = c.id_client
inner join product_order as po on po.id_order = o.id_order
inner join product as pr on pr.id_product = po.id_product
 order by c.fName;
 
 
-- Quantidade de pedidos feitos por clientes
select concat(fName,' ',minit) as Cliente, count(c.id_client) as 'Qtd. de pedidos' from clients as c
inner join orders as O on o.id_order_client = c.id_client
group by (o.id_order_client);

-- Verifica se um vendedor é fornecedor
select * from supplier as s
inner join seller as se on s.CNPJ NOT LIKE se.doc;

-- Listagem de todos os vendedore separando o cocumento pelo tipo
select social_name as 'Nome social', CASE
        WHEN LENGTH(doc)=11 THEN 'CPF'
        WHEN LENGTH(doc)=14 THEN 'CNPJ'
END as tipo, doc from seller;

-- Relação de produtos fornecedores e estoques; CORRIGIR
select distinct pName as Produto,  social_name as Fornecedor, concat(st.street,', ',st.city,'-',st.state) as 'End. de Estoque', ps.quantity as 'Qtd.'  from product as p
inner join product_supplier as psu on psu.id_product = p.id_product
inner join supplier as s on s.id_supplier = psu.id_supplier
inner join product_storage as ps on ps.id_ps_product = p.id_product
inner join storage as st on ps.id_P_storage = st.id_storage
order by p.pName ;

-- Relação de nomes dos fornecedores e nomes dos produtos;
select s.social_name as Fornecedor, p.pName as Produto from supplier as s join product_seller as ps
	on ps.id_seller = s.id_supplier inner join product as p
    on ps.id_product = p.id_product;
    
-- Busca informações de entrega de pedido pela numero do documento de indentificação ou pelo codigo de rastreio
select  concat(c.fName,', ',minit,', ',c.sName) as clients , concat(d.street,', ',d.complement,', ',d.neighborhood,', ',d.city,', ',d.state,', ',d.zip_code) as 'Endereço de entrega', d.status as'Status', d.tracking_number as 'Codigo de rastreio' from delivery as d inner join orders as o on d.id_order = o.id_order inner join clients as c on o.Id_order_client = c.id_client
where c.doc = "" or d.tracking_number = '';
    