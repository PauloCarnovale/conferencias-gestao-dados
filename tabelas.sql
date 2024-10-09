--PASSO 1

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

-- PASSO 2

-- Inserir algumas salas
INSERT INTO SALAS (sala_id, nome_sala, capacidade) VALUES (1, 'Sala de Reunião A', 10);
INSERT INTO SALAS (sala_id, nome_sala, capacidade) VALUES (2, 'Sala de Conferência B', 20);
INSERT INTO SALAS (sala_id, nome_sala, capacidade) VALUES (3, 'Auditório C', 50);

-- Inserir algumas reservas
INSERT INTO RESERVAS (reserva_id, sala_id, data_reserva, usuario_id) VALUES (1, 1, TO_TIMESTAMP('2024-10-23 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 101);
INSERT INTO RESERVAS (reserva_id, sala_id, data_reserva, usuario_id) VALUES (2, 2, TO_TIMESTAMP('2024-10-23 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 102);
INSERT INTO RESERVAS (reserva_id, sala_id, data_reserva, usuario_id) VALUES (3, 3, TO_TIMESTAMP('2024-10-24 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 103);

COMMIT;

---------------------------------------------------------------------------------------------------------------------------------

-- Transação 1 (T1) - Reserva de sala por um novo usuário:

-- Definir transação como READ WRITE (padrão)
SET TRANSACTION READ WRITE;

-- Inserir nova reserva (sala 1, data 23/10/2024 às 15:00, usuário 104)
INSERT INTO RESERVAS (reserva_id, sala_id, data_reserva, usuario_id)
VALUES (4, 1, TO_TIMESTAMP('2024-10-23 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 104);

COMMIT;

-- Resultado esperado: A reserva é inserida com sucesso.

---------------------------------------------------------------------------------------------------------------------------------

-- Transação 2 (T2) - Atualização de uma reserva existente:

-- Definir nível de isolamento como SERIALIZABLE
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

-- Atualizar a reserva do usuário 101 para uma nova data
UPDATE RESERVAS 
SET data_reserva = TO_TIMESTAMP('2024-10-25 10:00:00', 'YYYY-MM-DD HH24:MI:SS') 
WHERE reserva_id = 1;

COMMIT;

-- Resultado esperado: A data da reserva do usuário 101 é atualizada para 25/10/2024.

---------------------------------------------------------------------------------------------------------------------------------

-- Transação 3 (T3) - Simulação de leitura não repetível:

-- Definir transação como READ ONLY
SET TRANSACTION READ ONLY;

-- Ler a reserva atual da sala 1
SELECT * FROM RESERVAS WHERE sala_id = 1;

-- Esperar um tempo e tentar ler novamente após T2 alterar a mesma reserva
SELECT * FROM RESERVAS WHERE sala_id = 1;

-- Resultado esperado: A primeira leitura retorna a data original da reserva, mas após T2, a segunda leitura retorna a data modificada, ilustrando uma leitura não repetível.

---------------------------------------------------------------------------------------------------------------------------------

-- Definir nível de isolamento como READ COMMITTED
SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

-- Bloquear a tabela RESERVAS no modo EXCLUSIVE
LOCK TABLE RESERVAS IN EXCLUSIVE MODE;

-- Tentativa de atualizar a reserva na sala 1
UPDATE RESERVAS SET data_reserva = TO_TIMESTAMP('2024-10-26 16:00:00', 'YYYY-MM-DD HH24:MI:SS') WHERE reserva_id = 1;

COMMIT;

-- Resultado esperado: Essa transação irá entrar em deadlock com outra transação que tentar acessar a mesma reserva.






