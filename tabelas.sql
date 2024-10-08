-- Criação da tabela SALAS
CREATE TABLE SALAS (
    sala_id INT PRIMARY KEY,
    nome_sala VARCHAR(100) NOT NULL,
    capacidade INT NOT NULL
);

-- Criação da tabela RESERVAS
CREATE TABLE RESERVAS (
    reserva_id INT PRIMARY KEY,
    sala_id INT NOT NULL,
    data_reserva TIMESTAMP NOT NULL,
    usuario_id INT NOT NULL,
    FOREIGN KEY (sala_id) REFERENCES SALAS(sala_id)
);


