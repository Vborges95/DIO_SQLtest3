-- Criando o banco de dados
DROP DATABASE Ecommerce;
CREATE DATABASE Ecommerce;
USE ecommerce;

-- TABELA CLIENTE

CREATE TABLE Cliente (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Tipo ENUM('PF','PJ') NOT NULL,
    CPF CHAR(11) NULL,
    CNPJ CHAR(14) NULL,
    Email VARCHAR(100) NOT NULL,
    Telefone VARCHAR(20) NOT NULL,
    CHECK (
        (Tipo = 'PF' AND CPF IS NOT NULL AND CNPJ IS NULL)
        OR
        (Tipo = 'PJ' AND CNPJ IS NOT NULL AND CPF IS NULL)
    )
);

-- TABELA ENDEREÇO

CREATE TABLE Endereco (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    Cliente_id INT NOT NULL,
    Logradouro VARCHAR(100) NOT NULL,
    Numero VARCHAR(10),
    Bairro VARCHAR(50),
    Cidade VARCHAR(50),
    Estado CHAR(2),
    CEP CHAR(8),
    FOREIGN KEY (Cliente_id) REFERENCES Cliente(idCliente)
);

-- TABELA FORNECEDOR

CREATE TABLE Fornecedor (
    idFornecedor INT AUTO_INCREMENT PRIMARY KEY,
    RazaoSocial VARCHAR(100) NOT NULL,
    CNPJ CHAR(14) NOT NULL,
    Email VARCHAR(50) NOT NULL,  
    Telefone VARCHAR(10) NOT NULL
);

-- TABELA CATEGORIA

CREATE TABLE Categoria (
    idCategoria INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) NOT NULL
);


-- TABELA PRODUTO

CREATE TABLE Produto (
    idProduto INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255),
    Valor DECIMAL(10,2) NOT NULL,
    Fornecedor_id INT NOT NULL,
    Categoria_id INT NOT NULL,
    Tamanho VARCHAR(10),
    FOREIGN KEY (Fornecedor_id) REFERENCES Fornecedor(idFornecedor),
    FOREIGN KEY (Categoria_id) REFERENCES Categoria(idCategoria)
);


-- TABELA ESTOQUE

CREATE TABLE Estoque (
    idEstoque INT AUTO_INCREMENT PRIMARY KEY,
    Produto_id INT NOT NULL,
    Quantidade INT NOT NULL default 0, 
    Local VARCHAR(100),
    FOREIGN KEY (Produto_id) REFERENCES Produto(idProduto)
);

-- TABELA VENDEDOR
CREATE TABLE Vendedor (
    idVendedor INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Email VARCHAR(100),
    Telefone VARCHAR(20)
);
-- TABELA PEDIDO

CREATE TABLE Pedido (
    idPedido INT AUTO_INCREMENT PRIMARY KEY,
    Cliente_id INT NOT NULL,
    Vendedor_id INT,
    DataPedido DATE NOT NULL,
    Status ENUM('Pendente','Pago','Enviado','Entregue','Cancelado') DEFAULT 'Pendente',
    Frete DECIMAL(10,2) NOT NULL,
    DataEntrega DATE,
    FOREIGN KEY (Cliente_id) REFERENCES Cliente(idCliente),
    FOREIGN KEY (Vendedor_id) REFERENCES Vendedor(idVendedor)
);


-- TABELA ITEM E PEDIDO

CREATE TABLE ItemPedido (
    idItem INT AUTO_INCREMENT PRIMARY KEY,
    Pedido_id INT NOT NULL,
    Produto_id INT NOT NULL,
    Quantidade INT NOT NULL,
    PrecoUnitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Pedido_id) REFERENCES Pedido(idPedido),
    FOREIGN KEY (Produto_id) REFERENCES Produto(idProduto)
);


-- TABELA PAGAMENTO

CREATE TABLE Pagamento (
    idPagamento INT AUTO_INCREMENT PRIMARY KEY,
    Pedido_id INT NOT NULL,
    Tipo ENUM('Cartão','Pix','Boleto','Dinheiro') NOT NULL,
    Valor DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (Pedido_id) REFERENCES Pedido(idPedido)
);


-- TABELA ENTREGA

CREATE TABLE Entrega (
    idEntrega INT AUTO_INCREMENT PRIMARY KEY,
    Pedido_id INT NOT NULL,
    StatusEntrega ENUM('Aguardando','Em Transporte','Entregue') DEFAULT 'Aguardando',
    CodigoRastreio VARCHAR(50),
    FOREIGN KEY (Pedido_id) REFERENCES Pedido(idPedido)
);

-- DADOS FICTICIOS GERADOS PELO PEDIDO FEITO AO CHATGPT

-- CLIENTE
INSERT INTO Cliente (Nome, Tipo, CPF, CNPJ, Email, Telefone) VALUES
('João da Silva', 'PF', '12345678901', NULL, 'joao@email.com', '21999999999'),
('Empresa XYZ', 'PJ', NULL, '12345678000199', 'contato@xyz.com', '2133333333'),
('Maria Oliveira', 'PF', '98765432100', NULL, 'maria@email.com', '21988888888');

-- ENDEREÇO
INSERT INTO Endereco (Cliente_id, Logradouro, Numero, Bairro, Cidade, Estado, CEP) VALUES
(1, 'Rua A', '100', 'Centro', 'Rio de Janeiro', 'RJ', '20000000'),
(2, 'Av. Paulista', '1500', 'Bela Vista', 'São Paulo', 'SP', '01310000'),
(3, 'Rua B', '45', 'Copacabana', 'Rio de Janeiro', 'RJ', '22000000');

-- FORNECEDOR
INSERT INTO Fornecedor (RazaoSocial, CNPJ, Email, Telefone) VALUES
('Fornecedor 1 Ltda', '11111111000111', 'forn1@empresa.com', '2122222222'),
('Fornecedor 2 Ltda', '22222222000122', 'forn2@empresa.com', '2133333333'),
('Fornecedor 3 Ltda', '33333333000133', 'forn3@empresa.com', '2144444444');

-- CATEGORIA
INSERT INTO Categoria (Nome) VALUES
('Roupas'),
('Eletrônicos'),
('Calçados');

-- PRODUTO
INSERT INTO Produto (Nome, Descricao, Valor, Fornecedor_id, Categoria_id, Tamanho) VALUES
('Camiseta Polo', 'Camiseta masculina tamanho M', 59.90, 1, 1, 'M'),
('Tênis Esportivo', 'Tênis para corrida', 199.90, 2, 3, '42'),
('Fone de Ouvido', 'Bluetooth com cancelamento de ruído', 299.00, 3, 2, NULL);

-- ESTOQUE
INSERT INTO Estoque (Produto_id, Quantidade, Local) VALUES
(1, 100, 'RJ-Centro'),
(2, 50, 'SP-Moema'),
(3, 75, 'RJ-Barra');

-- VENDEDOR
INSERT INTO Vendedor (Nome, Email, Telefone) VALUES
('Carlos Vendedor', 'carlos@loja.com', '21977777777'),
('Ana Vendedora', 'ana@loja.com', '21966666666'),
('Pedro Vendedor', 'pedro@loja.com', '21955555555');

-- PEDIDO
INSERT INTO Pedido (Cliente_id, Vendedor_id, DataPedido, Status, Frete, DataEntrega) VALUES
(1, 1, '2025-08-01', 'Pago', 15.00, '2025-08-05'),
(2, 2, '2025-08-02', 'Enviado', 20.00, '2025-08-06'),
(3, 3, '2025-08-03', 'Pendente', 12.00, NULL);

-- ITEM PEDIDO
INSERT INTO ItemPedido (Pedido_id, Produto_id, Quantidade, PrecoUnitario) VALUES
(1, 1, 2, 59.90),
(2, 2, 1, 199.90),
(3, 3, 1, 299.00);

-- PAGAMENTO
INSERT INTO Pagamento (Pedido_id, Tipo, Valor) VALUES
(1, 'Cartão', 134.80),
(2, 'Pix', 219.90),
(3, 'Boleto', 311.00);

-- ENTREGA
INSERT INTO Entrega (Pedido_id, StatusEntrega, CodigoRastreio) VALUES
(1, 'Entregue', 'BR1234567890'),
(2, 'Em Transporte', 'BR0987654321'),
(3, 'Aguardando', NULL);


-- 1. SELECTS SIMPLES
SELECT * FROM Cliente;
SELECT Nome, Tipo FROM Cliente;

SELECT * FROM Produto;
SELECT Nome, Valor FROM Produto;

-- 2. FILTROS USANDO O  WHERE 
SELECT * FROM Pedido WHERE Status = 'Pago';
SELECT * FROM Cliente WHERE Tipo = 'PJ';
SELECT * FROM Produto WHERE Valor > 100;

-- 3. CALCULOS
-- EXEMPLO: VALOR TOTAL DO ITEM (Quantidade * Preço)
SELECT 
    Pedido_id,
    Produto_id,
    Quantidade,
    PrecoUnitario,
    Quantidade * PrecoUnitario AS ValorTotal
FROM ItemPedido;

-- 4. ORDENANDO COM ORDER BY
SELECT * FROM Produto ORDER BY Valor DESC;
SELECT * FROM Pedido ORDER BY DataPedido ASC;

-- 5. FILTROS COM HAVING
-- Quantidade de pedidos por cliente com mais de 1 pedido
SELECT 
    Cliente_id,
    COUNT(*) AS TotalPedidos
FROM Pedido
GROUP BY Cliente_id
HAVING COUNT(*) > 1;

-- VALOR MEDIO DE PEDIDO DE CADA VENDENDOR
SELECT 
    Vendedor_id,
    AVG(Frete) AS MediaFrete
FROM Pedido
GROUP BY Vendedor_id
HAVING AVG(Frete) > 10;

-- 6. JOINs

-- PEDIDO DOS CLIENTES E STATUS DA ENTREGA
SELECT 
    p.idPedido,
    c.Nome AS Cliente,
    p.Status AS StatusPedido,
    e.StatusEntrega,
    e.CodigoRastreio
FROM Pedido p
JOIN Cliente c ON p.Cliente_id = c.idCliente
LEFT JOIN Entrega e ON e.Pedido_id = p.idPedido;

-- PRODUTO DOS FORNECEDORES E SUAS CATEGORIAS RESPECTIVAS
SELECT 
    pr.Nome AS Produto,
    f.RazaoSocial AS Fornecedor,
    c.Nome AS Categoria
FROM Produto pr
JOIN Fornecedor f ON pr.Fornecedor_id = f.idFornecedor
JOIN Categoria c ON pr.Categoria_id = c.idCategoria;

-- ESTOQUE DOS PRODUTOS
SELECT 
    e.idEstoque,
    p.Nome AS Produto,
    e.Quantidade,
    e.Local
FROM Estoque e
JOIN Produto p ON e.Produto_id = p.idProduto;

-- QUANTIDADE DE PRODUTOS DE CADA FORNECEDOR
SELECT 
    Fornecedor_id,
    COUNT(*) AS TotalProdutos
FROM Produto
GROUP BY Fornecedor_id;
