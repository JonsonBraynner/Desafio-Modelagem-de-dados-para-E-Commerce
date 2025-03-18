drop database if exists ecommerce;
create database if not exists ecommerce ;
use ecommerce;

-- tabela Cliente
create table CLIENTS(
	id_client int not null auto_increment,
    fName varchar(10),
    minit varchar(10),
    sName varchar(20),
    doc char(11) not null,
    birthday date,
    street  varchar(45),
    complement  varchar(45),
    neighborhood  varchar(45),
    city  varchar(15),
    state  varchar(15),
    zip_code  char(7),
    primary key (id_client),
    constraint unique_doc_client unique(doc)
);

-- tabela Produto
create table PRODUCT(
	id_product int not null auto_increment,
    pName varchar(20),
    pDescription varchar(45),
    category enum('Eletrônico','Vestimenta','Brinquedos','Alimento') not null,
    classification_kid bool default false,
    pValue DECIMAL(10, 2) not null,
    avaliation float,
    pSize varchar(10),
    primary key (id_product)
	);

-- tabela Pedido  
create table ORDERS(
	id_order int not null auto_increment primary key,
	id_order_client int,
	o_Description varchar(45),
	o_Status ENUM('Em andamento', 'Em processamento', 'Enviado', 'Entregue') not null default 'Em processamento',
	delivery DECIMAL(10, 2) default 0,
	payment_cash boolean default false,
	constraint fk_orders_client foreign key (id_order_client) references clients(id_client) ON DELETE CASCADE
	);

-- tabela Pagamento
create table PAYMENT(
	id_payment int auto_increment not null unique,
    id_order int,
    id_client int,
    method enum('Boleto','Pix','Cartão de Credito') not null default 'Pix',
	payment_value DECIMAL(10, 2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
-- primary key (id_payment, id_order, id_client),
   constraint fk_id_client_payment foreign key(id_client) references clients(id_client) ON DELETE CASCADE,
   constraint fk_id_payment_order foreign key(id_payment) references orders(id_order) ON DELETE CASCADE
);

-- tabela Fornecedor
create table SUPPLIER(
	id_supplier int not null auto_increment,
	social_name varchar(255) not null,
	CNPJ char(15) not null,
	contact char(11)  not null,
	anddress varchar(255),
	primary key (id_supplier),
	constraint unique_supplier unique(CNPJ)
	);

-- tabela Vendedor
create table SELLER(
	id_seller int not null auto_increment,
	social_name varchar(255) not null,
	abst_name varchar(255) not null,
	CNPJ char(15),
	CPF char(11),
	location char(11)  not null,
	primary key (id_seller),
	constraint unique_seller_CNPJ unique(CNPJ), constraint unique_seller_CPF unique(CPF)
	);
    
-- tabela Estoque
create table STORAGE(
	id_storage int not null auto_increment,
	street  varchar(45),
    complement  varchar(45),
    neighborhood  varchar(45),
    city  varchar(15),
    state  varchar(15),
    zip_code  char(7),
    primary key (id_storage)
    );
    
-- tabela Produto-Pedido
create table PRODUCT_ORDER(
	id_product int,
	id_order int,
	pPquantity int default 1,
	p_status enum('disponível','sem estoque') not null default 'disponível',
	primary key(id_product, id_order),
	constraint fk_product_po foreign key (id_product) references PRODUCT(id_product) ON DELETE CASCADE,
	constraint fk_order_po foreign key (id_order) references ORDERS(id_order) ON DELETE CASCADE
	);
    
-- tabela Produto-Vendedor
create table PRODUCT_SELLER(
	id_seller int,
    id_product int,
    product_quantity int default 1,
    constraint fk_id_seller_product_seller foreign key (id_seller) references seller(id_seller)ON DELETE CASCADE,
    constraint fk_id_product_product_seller foreign key (id_product) references product(id_product) ON DELETE CASCADE
    );
 
 -- tabela Produto-Fornecedor
create table PRODUCT_SUPPLIER(
    id_supplier int,
    id_product int,
    product_quantity int default 1,
    primary key(id_supplier, id_product),
    constraint fk_id_supplier_product_supplier foreign key (id_supplier) references supplier(id_supplier) ON DELETE CASCADE,
    constraint fk_id_product_product_supplier foreign key (id_product) references product(id_product) ON DELETE CASCADE
    );

-- Tabela entrega
create table delivery(
	id_order int not null auto_increment,
    street  varchar(45),
    complement  varchar(45),
    neighborhood  varchar(45),
    city  varchar(15),
    state  varchar(15),
    zip_code  char(7),
    tracking_number varchar(11),
    status enum('em separação','em transporte','saiu para entrega','entregue'),
    constraint fk_id_order_delivery foreign key(id_order) references orders(id_order)ON DELETE CASCADE
);

-- tabela Estoque
create table PRODUCT_STORAGE(
	id_p_storage int not null  auto_increment,
    id_ps_storage int,
    id_ps_product int,
    quantity int not null default 0,
    primary key(id_p_storage),
    constraint fk_id_ps_storage foreign key (id_ps_storage) references storage(id_storage),
    constraint fk_id_ps_produto foreign key (id_ps_product) references product(id_product)
    );

-- tabela Estoque-Produto
create table STORAGE_LOCATION(
	id_storage int,
	id_product int,
	primary key(id_storage, id_product),
	constraint fk_storage_sl foreign key (id_storage) references PRODUCT_STORAGE(id_p_storage) ON DELETE CASCADE,
	constraint fk_product_sl foreign key (id_product) references PRODUCT(id_product) ON DELETE CASCADE
);