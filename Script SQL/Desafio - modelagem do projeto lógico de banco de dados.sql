-- Recuperações simples com SELECT Statement
select * from product;

-- Filtros com WHERE Statement
select pName as Nome, pDescription as Descrição, pSize as Tamanho from product where classification_kid=1;

-- Crie expressões para gerar atributos derivados
select concat(fName," ",minit," ",sName) as Nome, doc, CASE
        WHEN LENGTH(doc)=11 THEN 'PF'
        WHEN LENGTH(doc)=14 THEN 'PJ'
END as Tipo, TIMESTAMPDIFF(YEAR,birthday, NOW()) as idade,
concat(street," ",complement,", ",neighborhood,", ",city,"-",state,", ",zip_code) as Endereço from clients;

-- Defina ordenações dos dados com ORDER BY
select concat(fName," ",minit," ",sName) as Nome,
TIMESTAMPDIFF(YEAR,birthday, NOW()) as idade,
concat(street," ",complement,", ",neighborhood,", ",city,"-",state,", ",zip_code) as Endereço from clients
order by nome, idade;

-- Condições de filtros aos grupos – HAVING Statement
select category as Categoria, pSize as Tamanho, count(category) as Qtd from product
group by psize having(count(*)>2);

-- Crie junções entre tabelas para fornecer uma perspectiva mais complexa dos dados
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
 
-- Quantos pedidos foram feitos por cada cliente?
select concat(fName,' ',minit) as Cliente, count(c.id_client) as 'Qtd. de pedidos' from clients as c
inner join orders as O on o.id_order_client = c.id_client
group by (o.id_order_client);

-- Algum vendedor também é fornecedor?
select * from supplier as s
inner join seller as se on s.CNPJ NOT LIKE se.doc;

-- Listagem de todos os vendedore organizado pelo tipo de documento e pelo nome.
select social_name as 'Nome social', doc, CASE
        WHEN LENGTH(doc)=11 THEN 'PF'
        WHEN LENGTH(doc)=14 THEN 'PJ'
END as Tipo from seller order by Tipo desc, social_name;

-- Relação de produtos fornecedores e estoques;
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
    
