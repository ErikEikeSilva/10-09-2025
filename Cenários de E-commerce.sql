/* ==========================================================
    PROJETO: Transações SQL em E-commerce
    AUTOR: Erik Eike Silva
    DATA: 18/09/2025
    ========================================================== */

-- 1. CRIAÇÃO DO BANCO
DROP DATABASE IF EXISTS ecommerce_transacoes;
CREATE DATABASE ecommerce_transacoes;
USE ecommerce_transacoes;

-- 2. TABELAS
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100),
    preco DECIMAL(10,2),
    estoque INT
);

CREATE TABLE pedidos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    cliente_id INT,
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE itens_pedido (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT,
    produto_id INT,
    quantidade INT,
    preco_unitario DECIMAL(10,2),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id),
    FOREIGN KEY (produto_id) REFERENCES produtos(id)
);

CREATE TABLE auditoria_estoque (
    id INT PRIMARY KEY AUTO_INCREMENT,
    produto_id INT,
    alteracao INT,
    motivo VARCHAR(255),
    data_alteracao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. INSERÇÃO DE DADOS DE TESTE
INSERT INTO produtos (nome, preco, estoque) VALUES
('Notebook Gamer', 5000.00, 10),
('Smartphone Pro', 3000.00, 15),
('Mouse Gamer', 150.00, 50),
('Teclado Mecânico', 400.00, 20),
('Fone Bluetooth', 250.00, 30);

SELECT * FROM produtos;

-- ==========================================================
-- CENÁRIO 1: VENDA POR LOTE
-- ==========================================================
START TRANSACTION;

INSERT INTO pedidos (cliente_id) VALUES (1);
SET @pedido_id = LAST_INSERT_ID();

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES (@pedido_id, 1, 2, (SELECT preco FROM produtos WHERE id = 1));

INSERT INTO itens_pedido (pedido_id, produto_id, quantidade, preco_unitario)
VALUES (@pedido_id, 2, 1, (SELECT preco FROM produtos WHERE id = 2));

UPDATE produtos SET estoque = estoque - 2 WHERE id = 1 AND estoque >= 2;
UPDATE produtos SET estoque = estoque - 1 WHERE id = 2 AND estoque >= 1;

COMMIT;  -- Confirma a transação

SELECT * FROM pedidos;
SELECT * FROM itens_pedido;
SELECT * FROM produtos;

-- ==========================================================
-- CENÁRIO 2: AUDITORIA DE ESTOQUE
-- ==========================================================
START TRANSACTION;

UPDATE produtos
SET estoque = estoque + 50
WHERE id = 3;

INSERT INTO auditoria_estoque (produto_id, alteracao, motivo)
VALUES (3, 50, 'Reabastecimento fornecedor');

COMMIT;

SELECT * FROM produtos WHERE id = 3;
SELECT * FROM auditoria_estoque;

-- ==========================================================
-- CENÁRIO 3: PROMOÇÃO RELÂMPAGO
-- ==========================================================
START TRANSACTION;

UPDATE produtos
SET preco = preco * 0.8;

SELECT * FROM produtos;  -- Preços com desconto

ROLLBACK;  -- Desfaz promoção

SELECT * FROM produtos;  -- Preços originais restaurados