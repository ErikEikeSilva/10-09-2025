-- 1. Criar e usar o banco de dados
DROP DATABASE IF EXISTS ecommerce;
CREATE DATABASE ecommerce;
USE ecommerce;

-- 2. Criar tabelas (na ordem correta)
CREATE TABLE usuarios (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255) UNIQUE,
    senha VARCHAR(255),
    celular VARCHAR(255),
    cpf VARCHAR(14) UNIQUE,
    criado_em TIMESTAMP
);

CREATE TABLE categorias (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    descricao TEXT
);

CREATE TABLE produtos (
    id INT PRIMARY KEY,
    nome VARCHAR(255),
    descricao TEXT,
    preco DECIMAL(10,2),
    estoque INT,
    categoria_id INT,
    CONSTRAINT fk_produtos_categoria_id FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY,
    cliente_id INT,
    data_pedido TIMESTAMP,
    status VARCHAR(50),
    total DECIMAL(10,2),
    CONSTRAINT fk_pedidos_cliente_id FOREIGN KEY (cliente_id) REFERENCES usuarios(id)
);

CREATE TABLE enderecos (
    id INT PRIMARY KEY,
    cliente_id INT,
    rua VARCHAR(255),
    numero VARCHAR(50),
    bairro VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    cep VARCHAR(10),
    CONSTRAINT fk_enderecos_cliente_id FOREIGN KEY (cliente_id) REFERENCES usuarios(id)
);

CREATE TABLE itens_pedido (
    id INT PRIMARY KEY,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    CONSTRAINT fk_itens_pedido_pedido_id FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    CONSTRAINT fk_itens_pedido_produto_id FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

-- 3. Criar índices
CREATE INDEX idx_enderecos_cliente_id ON enderecos(cliente_id);
CREATE INDEX idx_produtos_categoria_id ON produtos(categoria_id);
CREATE INDEX idx_pedidos_cliente_id ON pedidos(cliente_id);
CREATE INDEX idx_itens_pedido_pedido_id ON itens_pedido(pedido_id);
CREATE INDEX idx_itens_pedido_produto_id ON itens_pedido(produto_id);

-- 4. Inserir dados de exemplo
-- Usuários (30)
INSERT INTO usuarios (id, nome, email, senha, celular, cpf, criado_em) VALUES
(1,'Ana Clara Silva','anaclara.silva@example.com','senha123!','(11) 98765-4321','123.456.789-01',NOW()),
(2,'João Pedro Santos','joao.santos@example.net','joaopedro@2024','(21) 91234-5678','987.654.321-09',NOW()),
(3,'Maria Eduarda Oliveira','maria.eduarda@example.org','maria_ed_pwd#','(31) 95555-4444','456.789.012-34',NOW()),
(4,'Pedro Henrique Costa','pedro.henrique@example.com','p3dr0h3n','(41) 99888-7777','789.012.345-67',NOW()),
(5,'Juliana Almeida','juliana.almeida@example.net','jualm_pass_1','(51) 96666-3333','012.345.678-90',NOW()),
(6,'Carlos Roberto Souza','carlos.souza@example.org','carlos_souza#','(61) 92222-1111','345.678.901-23',NOW()),
(7,'Mariana Ferreira','mariana.ferreira@example.com','m4ri4n4_f3rr31r4','(71) 97777-0000','678.901.234-56',NOW()),
(8,'Gabriel Lima','gabriel.lima@example.net','gabriel_lima_senha','(81) 94444-9999','901.234.567-89',NOW()),
(9,'Larissa Mendes','larissa.mendes@example.org','larissa_mendes_01','(91) 93333-8888','234.567.890-12',NOW()),
(10,'Rafael Gomes','rafael.gomes@example.com','rafael_gomes_pwd!','(84) 91111-2222','567.890.123-45',NOW()),
(11,'Isabela Martins','isabela.martins@example.net','isabela_m@2024','(85) 90000-5555','890.123.456-78',NOW()),
(12,'Lucas Santos','lucas.santos@example.org','lucas_sant_pwd#','(86) 98888-0000','123.456.789-12',NOW()),
(13,'Beatriz Pires','beatriz.pires@example.com','beatriz_p_pass','(87) 97777-1111','456.789.012-45',NOW()),
(14,'Fernanda Costa','fernanda.costa@example.net','fernanda_c@2024','(88) 96666-2222','789.012.345-78',NOW()),
(15,'Gustavo Souza','gustavo.souza@example.org','gustavo_s_pwd#','(89) 95555-3333','012.345.678-01',NOW()),
(16,'Camila Rocha','camila.rocha@example.com','camila_r@2024','(92) 94444-4444','345.678.901-34',NOW()),
(17,'Felipe Oliveira','felipe.oliveira@example.net','felipe_o_pwd','(93) 93333-5555','678.901.234-67',NOW()),
(18,'Ana Paula Gomes','anapaula.gomes@example.org','anapaula_g@2024','(94) 92222-6666','901.234.567-90',NOW()),
(19,'Daniel Fernandes','daniel.fernandes@example.com','daniel_f_pass!','(95) 91111-7777','234.567.890-23',NOW()),
(20,'Luiza Ribeiro','luiza.ribeiro@example.net','luiza_r@2024','(96) 90000-8888','567.890.123-56',NOW()),
(21,'Guilherme Castro','guilherme.castro@example.org','guilherme_c_pwd#','(97) 98765-4321','890.123.456-89',NOW()),
(22,'Sofia Lima','sofia.lima@example.com','sofia_l_pass','(98) 91234-5678','123.456.789-23',NOW()),
(23,'Rodrigo Barbosa','rodrigo.barbosa@example.net','rodrigo_b@2024','(99) 95555-4444','456.789.012-56',NOW()),
(24,'Amanda Rocha','amanda.rocha@example.org','amanda_r_pwd#','(11) 99888-7777','789.012.345-89',NOW()),
(25,'Vitor Gomes','vitor.gomes@example.com','vitor_g_pass','(21) 96666-3333','012.345.678-12',NOW()),
(26,'Bruna Fernandes','bruna.fernandes@example.net','bruna_f@2024','(31) 92222-1111','345.678.901-45',NOW()),
(27,'Thiago Lima','thiago.lima@example.org','thiago_l_pwd#','(41) 97777-0000','678.901.234-78',NOW()),
(28,'Paula Ribeiro','paula.ribeiro@example.com','paula_r_pass','(51) 94444-9999','901.234.567-01',NOW()),
(29,'Eduardo Martins','eduardo.martins@example.net','eduardo_m@2024','(61) 93333-8888','234.567.890-34',NOW()),
(30,'Julia Dias','julia.dias@example.org','julia_d_pwd#','(71) 91111-2222','567.890.123-67',NOW());

-- Inserir categorias (30)
INSERT INTO categorias (id, nome, descricao) VALUES
(1,'Eletrônicos','Dispositivos eletrônicos e gadgets.'),
(2,'Livros','Livros de ficção, não ficção, e literatura.'),
(3,'Roupas','Vestuário masculino, feminino e infantil.'),
(4,'Casa & Decoração','Artigos para o lar e decoração.'),
(5,'Esportes','Equipamentos e acessórios para atividades físicas.'),
(6,'Beleza & Saúde','Produtos de cuidados pessoais e bem-estar.'),
(7,'Brinquedos','Brinquedos para crianças e jogos.'),
(8,'Ferramentas','Ferramentas manuais e elétricas.'),
(9,'Alimentos & Bebidas','Produtos alimentícios e bebidas.'),
(10,'Jardinagem','Equipamentos e acessórios para jardinagem.'),
(11,'Pet Shop','Produtos para animais de estimação.'),
(12,'Automotivo','Acessórios e peças para veículos.'),
(13,'Música','Instrumentos musicais e acessórios.'),
(14,'Filmes','DVDs, Blu-rays e filmes em geral.'),
(15,'Jogos de Tabuleiro','Jogos de tabuleiro e cartas.'),
(16,'Materiais de Escritório','Artigos de papelaria e escritório.'),
(17,'Computadores','Desktops, notebooks e componentes.'),
(18,'Celulares','Smartphones e acessórios.'),
(19,'TVs','Televisores e equipamentos de áudio/vídeo.'),
(20,'Câmeras','Câmeras digitais e acessórios.'),
(21,'Eletrodomésticos','Eletrodomésticos para cozinha e casa.'),
(22,'Cama, Mesa & Banho','Artigos têxteis para o lar.'),
(23,'Bijuterias','Acessórios de moda e bijuterias.'),
(24,'Bolsas & Malas','Bolsas, mochilas e malas.'),
(25,'Instrumentos de Corda','Violões, guitarras, etc.'),
(26,'Instrumentos de Sopro','Flautas, saxofones, etc.'),
(27,'Tênis','Tênis e calçados esportivos.'),
(28,'Bicicletas','Bicicletas e acessórios.'),
(29,'Suplementos','Suplementos alimentares e vitaminas.'),
(30,'Jogos de RPG','Jogos de interpretação de papéis.');