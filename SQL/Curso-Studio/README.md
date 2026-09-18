# Mini curso — Estúdio (CSV → Stage → Histórico)

Prática com a base fake do estúdio. Mesma lógica do ETL, em três passos, numa base menor.

**Fluxo:** `historico_studio.csv` → `#TmpStgStudio` → `Stage.StgStudio` → `Historico.HistStudio`

CSV: [`../../BasesFakes/historico_studio.csv`](../../BasesFakes/historico_studio.csv)

Banco de estudo: `dbTestes` (ou outro banco de teste).

**Assistir** abre só aquele vídeo.

| # | Tema | Script | YouTube |
|---|------|--------|---------|
| 1 | BULK INSERT + criar a Stage | [`01_BULK_INSERT_CSV_Stage.sql`](./01_BULK_INSERT_CSV_Stage.sql) | [Assistir](https://www.youtube.com/watch?v=5ISu6r8Cad0) |
| 2 | Criar tabela Histórico (`HistStudio`) | [`02_Create_HistStudio.sql`](./02_Create_HistStudio.sql) | (link quando publicar) |
| 3 | CONVERT + INSERT no Histórico | [`03_Insert_HistStudio.sql`](./03_Insert_HistStudio.sql) | (link quando publicar) |

A aula 1 também aparece em [Aulas avulsas](../Aulas-Avulsas/) (mesmo vídeo). Aqui ela entra na sequência do mini curso.

## Como estudar

1. Baixe o CSV em [`BasesFakes/historico_studio.csv`](../../BasesFakes/historico_studio.csv) e salve no seu PC (exemplo: `C:\Dados\historico_studio.csv`)
2. Abra os scripts **nesta ordem** no SSMS
3. Na aula 1, ajuste o caminho do `BULK INSERT` para o lugar onde você salvou o arquivo
4. Execute por partes e compare com o vídeo

O `BULK INSERT` lê o arquivo do **disco da máquina**, não direto do GitHub.
