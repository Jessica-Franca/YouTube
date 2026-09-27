# Aulas avulsas (SQL)

Scripts soltos das aulas de SQL no YouTube.

**Assistir** abre só aquele vídeo.

| # | Tema | Script | YouTube |
|---|------|--------|---------|
| 1 | SELECT, Alias e TOP 10 | [`SQL_SELECT_Alias_TOP.sql`](./SQL_SELECT_Alias_TOP.sql) | [Assistir](https://www.youtube.com/watch?v=iY63k8jpD_k) |
| 2 | WHERE (filtros) | [`SQL_WHERE.sql`](./SQL_WHERE.sql) | [Assistir](https://www.youtube.com/watch?v=2iOMpEOHQiY) |
| 3 | @Variáveis (DECLARE + SET) | [`SQL_Variaveis_DECLARE_SET.sql`](./SQL_Variaveis_DECLARE_SET.sql) | [Assistir](https://www.youtube.com/watch?v=Igm14_DaSVQ) |
| 4 | LOOP com data (ETL) | [`SQL_LOOP_Data.sql`](./SQL_LOOP_Data.sql) | [Assistir](https://www.youtube.com/watch?v=Z4tMiRvUgJY) |
| 5 | LEFT JOIN | [`SQL_LEFT_JOIN.sql`](./SQL_LEFT_JOIN.sql) | [Assistir](https://www.youtube.com/watch?v=GmL4jGSuOPU) |
| 6 | Média móvel | [`SQL_Media_Movel.sql`](./SQL_Media_Movel.sql) | [Assistir](https://www.youtube.com/watch?v=Vee5fI2On-Y) |
| 7 | BULK INSERT CSV + Stage (Base Studio) | [`SQL_BULK_INSERT_CSV_Stage_Studio.sql`](./SQL_BULK_INSERT_CSV_Stage_Studio.sql) | [Assistir](https://www.youtube.com/watch?v=5ISu6r8Cad0) |

## Aula 7 — CSV no SQL Server (Base Studio)

Arquivos desta aula:

- Vídeo: [Assistir no YouTube](https://www.youtube.com/watch?v=5ISu6r8Cad0)
- Playlist: [Mini curso SQL: Base Studio (Salão de beleza)](https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U)
- Script: [`SQL_BULK_INSERT_CSV_Stage_Studio.sql`](./SQL_BULK_INSERT_CSV_Stage_Studio.sql)
- CSV (base fake): [`../../BasesFakes/historico_studio.csv`](../../BasesFakes/historico_studio.csv)

Como praticar:

1. Baixe o CSV em [`BasesFakes/historico_studio.csv`](../../BasesFakes/historico_studio.csv) e salve no seu PC (exemplo: `C:\Dados\historico_studio.csv`)
2. Abra o script no SSMS
3. Ajuste o caminho do `BULK INSERT` para o lugar onde você salvou o arquivo
4. Execute por partes (criar temp → BULK INSERT → SELECT INTO na Stage → COUNT / TOP 5)

O `BULK INSERT` lê o arquivo do **disco da máquina**, não direto do GitHub. Por isso o CSV precisa ser baixado primeiro.

**Continuação:** essa aula é o passo 1 do [mini curso SQL: Base Studio](../Curso-Studio/) ([playlist](https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U)). Próximo vídeo: [criar o Histórico e inserir os dados](https://www.youtube.com/watch?v=oTvTQ4SgFqA). Depois: [dimensão de cliente e prévia da fato](https://www.youtube.com/watch?v=32RLwGQYSMs) (scripts 04, 05 e 06).
