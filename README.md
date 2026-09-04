# Aulas SQL — Mundo MIS

Scripts das aulas do YouTube para você praticar no SSMS junto com o vídeo.

Canal: [youtube.com/@mundomis](https://www.youtube.com/@mundomis)

## Como estudar

1. Abra o vídeo no YouTube  
2. Abra o arquivo `.sql` correspondente aqui no GitHub (ou no SSMS)  
3. Execute por partes e teste — a ideia é praticar, não só assistir  

---

## Aulas avulsas

| # | Tema | Script | YouTube |
|---|------|--------|---------|
| 1 | SELECT, Alias e TOP 10 | [`SQL_SELECT_Alias_TOP.sql`](./Aulas_Avulsas/SQL_SELECT_Alias_TOP.sql) | [Assistir](https://www.youtube.com/watch?v=iY63k8jpD_k) |
| 2 | WHERE (filtros) | [`SQL_WHERE.sql`](./Aulas_Avulsas/SQL_WHERE.sql) | [Assistir](https://www.youtube.com/watch?v=2iOMpEOHQiY) |
| 3 | @Variáveis (DECLARE + SET) | [`SQL_Variaveis_DECLARE_SET.sql`](./Aulas_Avulsas/SQL_Variaveis_DECLARE_SET.sql) | [Assistir](https://www.youtube.com/watch?v=Igm14_DaSVQ) |
| 4 | LOOP com data (ETL) | [`SQL_LOOP_Data.sql`](./Aulas_Avulsas/SQL_LOOP_Data.sql) | [Assistir](https://www.youtube.com/watch?v=Z4tMiRvUgJY) |
| 5 | LEFT JOIN | [`SQL_LEFT_JOIN.sql`](./Aulas_Avulsas/SQL_LEFT_JOIN.sql) | [Assistir](https://www.youtube.com/watch?v=GmL4jGSuOPU) |
| 6 | Média móvel | [`SQL_Media_Movel.sql`](./Aulas_Avulsas/SQL_Media_Movel.sql) | [Assistir](https://www.youtube.com/watch?v=Vee5fI2On-Y) |

Pasta: [`Aulas_Avulsas/`](./Aulas_Avulsas/)

---

## Curso — ETL Completo (Histórico → Dimensões → Fato)

Playlist do curso (índice): [ETL com SQL Server do Zero à Prática](https://www.youtube.com/playlist?list=PLjC-yd8c5Jp3UqyAzv6d5b9oDZMfWVLEw)

Na tabela abaixo, **Assistir** abre só aquele vídeo (não a playlist).

Comece pelo [`00_Script_Inicial.sql`](./Curso%20-%20ETL%20Completo/00_Script_Inicial.sql) (schema + Stage).

| # | Tema | Script | YouTube |
|---|------|--------|---------|
| 1 | Criar tabela Histórico | [`01_Create_Hist.sql`](./Curso%20-%20ETL%20Completo/01_Create_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=v9UfGpuI0Gc) |
| 2 | CONVERT + tabela temporária | [`02_Convert_Temp.sql`](./Curso%20-%20ETL%20Completo/02_Convert_Temp.sql) | [Assistir](https://www.youtube.com/watch?v=N82GIjWbKy0) |
| 3 | INSERT INTO no Histórico | [`03_Insert_Hist.sql`](./Curso%20-%20ETL%20Completo/03_Insert_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=kKSHBAJujzU) |
| 4 | Procedure do Histórico | [`03_Insert_Hist.sql`](./Curso%20-%20ETL%20Completo/03_Insert_Hist.sql) · alt. [`04_Proc_Hist.sql`](./Curso%20-%20ETL%20Completo/04_Proc_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=W2gKG-eCh2k) |
| 5 | MERGE no Histórico | [`05_Merge_Hist.sql`](./Curso%20-%20ETL%20Completo/05_Merge_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=V8tWBXlMAtI) |
| 6 | Dimensões + MERGE | [`06_Create_Dim.sql`](./Curso%20-%20ETL%20Completo/06_Create_Dim.sql) + [`06_Proc_Dim.sql`](./Curso%20-%20ETL%20Completo/06_Proc_Dim.sql) | [Assistir](https://www.youtube.com/watch?v=4h6_TkjIKho) |
| 7 | Montar Tabela Fato (SELECT) | [`07_Select_Fato.sql`](./Curso%20-%20ETL%20Completo/07_Select_Fato.sql) | [Assistir](https://www.youtube.com/watch?v=YtdZfOOYTgI) |
| 8 | Fato com MERGE | [`08_Create_Fato.sql`](./Curso%20-%20ETL%20Completo/08_Create_Fato.sql) + [`08_Proc_Fato.sql`](./Curso%20-%20ETL%20Completo/08_Proc_Fato.sql) | [Assistir](https://www.youtube.com/watch?v=RzKSyF4YOII) |

Pasta: [`Curso - ETL Completo/`](./Curso%20-%20ETL%20Completo/)

Fonte dos scripts: modelo CSAT (`HistAtendimentoCSAT` → Dims → Fato) em `MundoMis/BaseDados/CSAT/SQL`.

---

## Curso — Chega de Consolidar CSV no Excel

| # | Tema | Script | YouTube |
|---|------|--------|---------|
| 006 | BULK INSERT | [`006-bulk-insert-explicado.sql`](./Curso%20-%20Chega%20de%20Consolidar%20CSV%20no%20Excel/006-bulk-insert-explicado.sql) | *(a publicar)* |
| 007 | Criar tabela Stage | [`007-criar-tabela-stage.sql`](./Curso%20-%20Chega%20de%20Consolidar%20CSV%20no%20Excel/007-criar-tabela-stage.sql) | *(a publicar)* |

Pasta: [`Curso - Chega de Consolidar CSV no Excel/`](./Curso%20-%20Chega%20de%20Consolidar%20CSV%20no%20Excel/)
