# Curso — ETL Completo (Histórico → Dimensões → Fato)

Playlist (índice): [ETL com SQL Server do Zero à Prática](https://www.youtube.com/playlist?list=PLjC-yd8c5Jp3UqyAzv6d5b9oDZMfWVLEw)

**Assistir** abre só aquele vídeo (não a playlist).

Comece pelo [`00_Script_Inicial.sql`](./00_Script_Inicial.sql) (schema + Stage).

| # | Tema | Script | YouTube |
|---|------|--------|---------|
| 1 | Criar tabela Histórico | [`01_Create_Hist.sql`](./01_Create_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=v9UfGpuI0Gc) |
| 2 | CONVERT + tabela temporária | [`02_Convert_Temp.sql`](./02_Convert_Temp.sql) | [Assistir](https://www.youtube.com/watch?v=N82GIjWbKy0) |
| 3 | INSERT INTO no Histórico | [`03_Insert_Hist.sql`](./03_Insert_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=kKSHBAJujzU) |
| 4 | Procedure do Histórico | [`04_Proc_Hist.sql`](./04_Proc_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=W2gKG-eCh2k) |
| 5 | MERGE no Histórico | [`05_Merge_Hist.sql`](./05_Merge_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=V8tWBXlMAtI) |
| 6 | Dimensões + MERGE | [`06_Create_Dim.sql`](./06_Create_Dim.sql) + [`06_Proc_Dim.sql`](./06_Proc_Dim.sql) | [Assistir](https://www.youtube.com/watch?v=4h6_TkjIKho) |
| 7 | Montar Tabela Fato (SELECT) | [`07_Select_Fato.sql`](./07_Select_Fato.sql) | [Assistir](https://www.youtube.com/watch?v=YtdZfOOYTgI) |
| 8 | Fato com MERGE | [`08_Create_Fato.sql`](./08_Create_Fato.sql) + [`08_Proc_Fato.sql`](./08_Proc_Fato.sql) | [Assistir](https://www.youtube.com/watch?v=RzKSyF4YOII) |

Alternativa da aula 8: [`08_Proc_Fato_v2.sql`](./08_Proc_Fato_v2.sql)
