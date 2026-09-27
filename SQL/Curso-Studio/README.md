# Mini curso SQL: Base Studio (Salão de beleza)

Prática com a Base Studio, uma base fake de salão de beleza. A mesma lógica do ETL, numa base menor: CSV, Stage, Histórico e o começo do modelo estrela (dimensão de cliente e prévia da fato).

Playlist (índice): [Mini curso SQL: Base Studio (Salão de beleza)](https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U)

**Fluxo:** `historico_studio.csv` → `#TmpStgStudio` → `Stage.StgStudio` → `Historico.HistStudio` → `DataMart.DimCliente` → prévia da fato

CSV: [`../../BasesFakes/historico_studio.csv`](../../BasesFakes/historico_studio.csv)

Banco de estudo: `dbTestes` (ou outro banco de teste).

**Assistir** abre só aquele vídeo (não a playlist). Os scripts 2 e 3 estão no mesmo vídeo. Os scripts 4, 5 e 6 estão no vídeo seguinte (dimensão de cliente).

| # | Tema | Script | YouTube |
|---|------|--------|---------|
| 1 | BULK INSERT + criar a Stage | [`01_BULK_INSERT_CSV_Stage.sql`](./01_BULK_INSERT_CSV_Stage.sql) | [Assistir](https://www.youtube.com/watch?v=5ISu6r8Cad0) |
| 2 | Criar tabela Histórico (`HistStudio`) | [`02_Create_HistStudio.sql`](./02_Create_HistStudio.sql) | [Assistir](https://www.youtube.com/watch?v=oTvTQ4SgFqA) |
| 3 | CONVERT + INSERT no Histórico | [`03_Insert_HistStudio.sql`](./03_Insert_HistStudio.sql) | [Assistir](https://www.youtube.com/watch?v=oTvTQ4SgFqA) |
| 4 | Criar `DataMart.DimCliente` (registro -1) | [`04_Create_DimCliente.sql`](./04_Create_DimCliente.sql) | em publicação |
| 5 | Alimentar a DimCliente sem duplicar | [`05_Alimentar_DimCliente.sql`](./05_Alimentar_DimCliente.sql) | em publicação |
| 6 | Prévia da fato (data, cliente, quantidade) | [`06_Select_Fato.sql`](./06_Select_Fato.sql) | em publicação |

A aula 1 também aparece em [Aulas avulsas](../Aulas-Avulsas/) (mesmo vídeo). Aqui ela entra na sequência do mini curso.

## Como estudar

1. Baixe o CSV em [`BasesFakes/historico_studio.csv`](../../BasesFakes/historico_studio.csv) e salve no seu PC (exemplo: `C:\Dados\historico_studio.csv`)
2. Abra os scripts **nesta ordem** no SSMS
3. Na aula 1, ajuste o caminho do `BULK INSERT` para o lugar onde você salvou o arquivo
4. Execute por partes e compare com o vídeo

O `BULK INSERT` lê o arquivo do **disco da máquina**, não direto do GitHub.
