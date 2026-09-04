/*
  Script: SQL_LEFT_JOIN.sql
  Vídeo: [SQL] LEFT JOIN no SQL Server: Como Funciona e Quando Usar (com exemplo real para iniciantes)
  YouTube: https://www.youtube.com/watch?v=GmL4jGSuOPU
  Objetivo: Exemplo didático — todos os funcionários + ponto (inclui quem não bateu)
  Como estudar: abra no SSMS, execute por partes e compare com o vídeo
*/

-- Limpa quaisquer tabelas temporárias existentes
IF OBJECT_ID('tempdb..#Funcionario') IS NOT NULL DROP TABLE #Funcionario;
IF OBJECT_ID('tempdb..#Ponto')       IS NOT NULL DROP TABLE #Ponto;

-- Criação das tabelas temporárias
CREATE TABLE #Funcionario (
    IdFuncionario INT PRIMARY KEY,
    Nome          NVARCHAR(100) NOT NULL
);

CREATE TABLE #Ponto (
    IdPonto       INT PRIMARY KEY,
    IdFuncionario INT NOT NULL,
    Data          DATE    NOT NULL,
    HoraEntrada   TIME    NOT NULL
);

-- Inserts de exemplo em #Funcionario
INSERT INTO #Funcionario (IdFuncionario, Nome) VALUES
    (1, N'Ana Silva'),
    (2, N'Bruno Costa'),
    (3, N'Carla Pereira'),
    (4, N'Diego Souza'),
    (5, N'Elisa Rocha');

-- Inserts de exemplo em #Ponto
INSERT INTO #Ponto (IdPonto, IdFuncionario, Data, HoraEntrada) VALUES
    (1, 6, '2025-07-01', '08:02:00'),
    (2, 6, '2025-07-02', '08:10:00'),
    (3, 2, '2025-07-01', '07:55:00'),
    (4, 2, '2025-07-03', '08:00:00'),
    (5, 3, '2025-07-02', '08:05:00'),
    (6, 3, '2025-07-03', '08:15:00'),
    (7, 3, '2025-07-04', '07:58:00'),
    (8, 5, '2025-07-01', '08:20:00'),
    (9, 5, '2025-07-04', '08:03:00');


SELECT  * FROM #Funcionario

SELECT  * FROM #Ponto

-- SELECT usando LEFT JOIN para testar o relacionamento
SELECT
    F.Nome,
    P.Data,
    P.HoraEntrada
FROM #Funcionario AS F
LEFT JOIN #Ponto AS P
    ON F.IdFuncionario = P.IdFuncionario
ORDER BY
    F.IdFuncionario,
    P.Data;
