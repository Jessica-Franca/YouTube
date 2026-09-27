# Aula 3 — texto para o YouTube

Dimensão de cliente (Base Studio). Scripts 04, 05 e 06.

Vídeo: https://www.youtube.com/watch?v=32RLwGQYSMs

Continuação de https://www.youtube.com/watch?v=oTvTQ4SgFqA

## Título

Como criar a Dimensão de Cliente no SQL Server | Base Studio

## Descrição

```
Continuação da Base Studio (salão de beleza). O histórico já está pronto. Agora a gente valida o cliente, cria a DimCliente e insere sem duplicar, no modelo estrela, para levar isso ao Power BI.

Nesta aula:
- por que não jogar o histórico inteiro no Power BI
- cliente x telefone (um cliente pode ter vários telefones)
- CREATE da DataMart.DimCliente, com o registro -1 (Não Mapeado)
- INSERT só do que ainda não existe
- prévia da fato: data, idCliente e quantidade de atendimentos

Pré-requisito: histórico da Base Studio
https://www.youtube.com/watch?v=oTvTQ4SgFqA

Aula 1 (CSV e Stage):
https://www.youtube.com/watch?v=5ISu6r8Cad0

Playlist:
https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U

Scripts (na ordem do vídeo):
https://github.com/Jessica-Franca/YouTube/blob/main/SQL/Curso-Studio/04_Create_DimCliente.sql
https://github.com/Jessica-Franca/YouTube/blob/main/SQL/Curso-Studio/05_Alimentar_DimCliente.sql
https://github.com/Jessica-Franca/YouTube/blob/main/SQL/Curso-Studio/06_Select_Fato.sql

Pasta do mini curso:
https://github.com/Jessica-Franca/YouTube/tree/main/SQL/Curso-Studio

Banco: dbTestes
CSV da base fake: BasesFakes/historico_studio.csv

Capítulos
0:00 Continuação: do histórico para o relatório
0:28 Modelo estrela (fato e dimensões)
2:48 Por que não levar o histórico inteiro pro Power BI
3:57 Cliente e telefone antes de criar a dimensão
8:16 Um cliente, vários telefones
9:56 DimCliente só com o nome do cliente
12:37 CREATE TABLE DataMart.DimCliente
14:52 Registro -1, Não Mapeado
21:31 Janela de data e INSERT sem duplicar
28:31 Prévia da fato (LEFT JOIN e quantidade)
33:55 Exercício: as próximas dimensões

#SQL #SQLServer #PowerBI #ModeloEstrela #ETL
```

## Comentário fixado

```
Scripts desta aula, na ordem:
04 criar a DimCliente
05 alimentar sem duplicar
06 prévia da fato

https://github.com/Jessica-Franca/YouTube/tree/main/SQL/Curso-Studio
```
