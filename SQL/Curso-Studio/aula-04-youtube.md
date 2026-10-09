# Aula — Dimensão de Cidade/UF (Base Studio)

Vídeo: https://youtu.be/hELJQuNW204

Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U

## Título

SQL Server na prática: criando a Dimensão Cidade/UF e atualizando a Fato | Base Studio

## Descrição

Nesta continuação do mini curso SQL com a Base Studio, vamos construir a dimensão de Cidade/UF e atualizar a consulta da fato para incluir o novo identificador no modelo estrela.

Você vai acompanhar o processo na prática, reaproveitando consultas anteriores como ponto de partida e entendendo como adaptar a estrutura para uma nova dimensão.

**Nesta aula você vai aprender:**
- Como identificar a próxima dimensão a partir da consulta da fato
- Criar a tabela `DataMart.DimCidadeUF`
- Inserir o registro padrão `-1` para valores “Não Mapeado”
- Criar um índice único considerando cidade + UF
- Carregar cidades e UFs sem inserir combinações duplicadas
- Entender por que cidade e UF devem ser usadas juntas para identificar uma localidade
- Incluir `idCidadeUF` na prévia da fato com `LEFT JOIN`
- Atualizar o `GROUP BY` após incluir a nova dimensão

📌 **Scripts SQL desta aula (10, 11 e 12):**  
https://github.com/Jessica-Franca/YouTube/tree/main/SQL/Curso-Studio

▶️ **Playlist — Mini curso SQL: Base Studio (Salão de beleza):**  
https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U

Pratique junto com o vídeo: abra os scripts no SQL Server Management Studio (SSMS), execute cada etapa e compare os resultados.

Se este conteúdo te ajudou, deixe seu like, comente sua dúvida e compartilhe com alguém que esteja estudando SQL e modelagem de dados!

---

### Precisa de ajuda com dados?

Precisa de ajuda com **SQL, Power BI ou análise de dados**? Trabalho com serviços freelance e apoio personalizado em consultas, relatórios, dashboards e soluções de dados.

🎯 **Condição especial para inscritos do canal:** valores reduzidos para quem acompanha o Mundo MIS.

📩 LinkedIn: https://www.linkedin.com/in/jessicafranca/  
🔗 Meus links e canais: https://linktr.ee/JessicaFrancaDados

#SQLServer #SQL #PowerBI #ModelagemDeDados #ETL #ModeloEstrela #MundoMIS

## Capítulos

00:00 Introdução e revisão da dimensão de contato
00:37 Como identificar a próxima dimensão
01:19 Usando a consulta da fato como guia
01:49 Identificando a dimensão Cidade/UF
02:46 Adaptando a consulta para Cidade/UF
04:25 Montando a consulta de carga incremental
05:25 Relacionando cidade e UF corretamente
07:00 Criando a tabela DimCidadeUF
10:07 Criando o registro padrão Não Mapeado
12:08 Criando índice único para cidade e UF
13:00 Ajustando o tamanho dos campos
14:26 Testando a criação e a carga da dimensão
14:55 Atualizando a prévia da fato
16:12 Organizando as colunas e incluindo idCidadeUF
16:49 Recapitulando o que foi feito
17:28 Encerramento e próximos passos

## Comentário fixado

Scripts desta aula, na ordem:
10 — criar a DimCidadeUF
11 — alimentar a dimensão sem duplicar
12 — atualizar a prévia da fato com idCidadeUF

📂 Material completo: https://github.com/Jessica-Franca/YouTube/tree/main/SQL/Curso-Studio
▶️ Playlist: https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U