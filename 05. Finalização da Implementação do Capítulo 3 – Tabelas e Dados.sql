-- Criar banco de dados (se não existir)
CREATE DATABASE IF NOT EXISTS livraria;
USE livraria;

-- =============================
-- 3.1 CRIANDO AS TABELAS DO PROJETO
-- =============================

-- Exclui tabelas antigas para evitar conflito
DROP TABLE IF EXISTS itens_pedido;
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS livros;
DROP TABLE IF EXISTS clientes;

-- Tabela de clientes
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefone VARCHAR(20)
);

-- Tabela de livros
CREATE TABLE livros (
    id_livro INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(150) NOT NULL,
    autor VARCHAR(100),
    preco DECIMAL(10,2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Tabela de pedidos
CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE NOT NULL,
    status ENUM('Aberto', 'Pago', 'Enviado', 'Cancelado') DEFAULT 'Aberto',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

-- Tabela itens do pedido
CREATE TABLE itens_pedido (
    id_item INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_livro INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_livro) REFERENCES livros(id_livro)
);

-- =============================
-- 3.3 ALTERANDO AS TABELAS
-- Exemplo: adicionando nova coluna "cpf" na tabela clientes
-- =============================
ALTER TABLE clientes ADD COLUMN cpf CHAR(11) UNIQUE AFTER nome;

-- Exemplo: alterando o tipo do campo telefone para aceitar até 30 caracteres
ALTER TABLE clientes MODIFY telefone VARCHAR(30);