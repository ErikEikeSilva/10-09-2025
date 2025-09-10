-- (opcional) recria o banco do zero
drop database if exists ecommerce;
create database ecommerce
  default character set utf8mb4
  default collate utf8mb4_general_ci;

use ecommerce;

-- ===== Tabela Usuarios (resultado final das suas alterações) =====
create table usuarios (
  id int auto_increment primary key,
  nome varchar(100) not null,
  email varchar(100) not null,
  senha varchar(100) not null,
  celular varchar(15),
  telefone varchar(12),
  criado_em datetime default current_timestamp,
  unique key uk_usuarios_email (email) -- já cria índice no email
) engine=InnoDB;

-- ===== Tabela Enderecos =====
create table enderecos (
  id int auto_increment primary key,
  cliente_id int not null,
  rua varchar(100),
  numero varchar(10),
  complemento varchar(100),
  bairro varchar(50),
  cidade varchar(50),
  estado char(2),
  cep varchar(10),
  constraint fk_enderecos_cliente
    foreign key (cliente_id) references usuarios(id)
    on delete cascade on update cascade
) engine=InnoDB;

-- ===== Tabela Categorias =====
create table categorias (
  id int auto_increment primary key,
  nome varchar(100) not null,
  descricao text
) engine=InnoDB;

-- ===== Tabela Produtos =====
create table produtos (
  id int auto_increment primary key,
  nome varchar(120) not null,
  descricao text,
  preco decimal(10,2) not null,
  estoque int default 0,
  categoria_id int,
  constraint fk_produtos_categoria
    foreign key (categoria_id) references categorias(id)
    on delete set null on update cascade
) engine=InnoDB;

-- ===== Tabela Pedidos =====
create table pedidos (
  id int auto_increment primary key,
  cliente_id int not null,
  data_pedido datetime default current_timestamp,
  situacao varchar(50) default 'Pendente',
  total decimal(10,2) default 0,
  constraint fk_pedidos_cliente
    foreign key (cliente_id) references usuarios(id)
    on delete cascade on update cascade
) engine=InnoDB;

-- ===== Tabela Itens do Pedido =====
create table itens_pedido (
  id int auto_increment primary key,
  pedido_id int not null,s
  produto_id int not null,
  quantidade int not null,
  preco_unitario decimal(10,2) not null,
  constraint fk_itens_pedido_pedido
    foreign key (pedido_id) references pedidos(id)
    on delete cascade on update cascade,
  constraint fk_itens_pedido_produto
    foreign key (produto_id) references produtos(id)
    on delete restrict on update cascade
) engine=InnoDB;


-- Conferência
show tables;
describe usuarios;