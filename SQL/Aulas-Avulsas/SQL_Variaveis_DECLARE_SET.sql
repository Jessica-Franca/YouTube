/*
  Script: SQL_Variaveis_DECLARE_SET.sql
  Vídeo: [SQL] Como criar e usar @Variáveis no SQL Server na prática (DECLARE + SET explicado)
  YouTube: https://www.youtube.com/watch?v=Igm14_DaSVQ
  Objetivo: Criar variáveis com DECLARE, atribuir com SET, exibir com PRINT e usar CASE WHEN
  Como estudar: abra no SSMS, execute por partes e compare com o vídeo (aba Mensagens para o PRINT)
*/

-- 1) DECLARE (por volta de 0:29) — cria as variáveis e define o tipo
DECLARE @Nome VARCHAR(160)
,@Idade INT

-- 2) SET (por volta de 0:47) — atribui / altera o valor
SET @Nome = 'Je'
SET @Idade = 30

-- 3) CASE WHEN com variável (por volta de 2:30)
PRINT(CASE WHEN @Nome = 'x' THEN '1' ELSE @Nome END)

-- 4) Alterar o valor e montar uma mensagem com PRINT + CAST (por volta de 1:17)
SET @Nome = 'Jessica Franca'
SET @Idade = 30

PRINT('O nome do meu cliente e: ' + CAST(@Nome AS VARCHAR) + ' e sua idade e: ' + CAST(@Idade AS VARCHAR) + ' Anos')
