# Mini curso SQL: Base Studio (Salão de beleza)

Prática com a Base Studio, uma base fake de salão de beleza. A mesma lógica do ETL, numa base menor: CSV, Stage, Histórico e construção gradual do modelo estrela, com dimensões de cliente, contato e Cidade/UF.

Playlist (índice): [Mini curso SQL: Base Studio (Salão de beleza)](https://www.youtube.com/playlist?list=PLIAM5Wk1ho9U)

**Fluxo:** `historico_studio.csv` → `#TmpStgStudio` → `Stage.StgStudio` → `Historico.HistStudio` → dimensões `DataMart.DimCliente`, `DataMart.DimContato` e `DataMart.DimCidadeUF` → prévia da fato

CSV: `[../../BasesFakes/historico_studio.csv](../../BasesFakes/historico_studio.csv)`

Banco de estudo: `dbTestes` (ou outro banco de teste).

**Assistir** abre só aquele vídeo (não a playlist). Os scripts 2 e 3 estão no mesmo vídeo. Os scripts 4, 5 e 6 estão no vídeo seguinte (dimensão de cliente). Os scripts 10, 11 e 12 estão na aula de dimensão de Cidade/UF.


| #   | Tema                                                                   | Script                                                           | YouTube                                                 |
| --- | ---------------------------------------------------------------------- | ---------------------------------------------------------------- | ------------------------------------------------------- |
| 1   | BULK INSERT + criar a Stage                                            | `[01_BULK_INSERT_CSV_Stage.sql](./01_BULK_INSERT_CSV_Stage.sql)` | [Assistir](https://www.youtube.com/watch?v=5ISu6r8Cad0) |
| 2   | Criar tabela Histórico (`HistStudio`)                                  | `[02_Create_HistStudio.sql](./02_Create_HistStudio.sql)`         | [Assistir](https://www.youtube.com/watch?v=oTvTQ4SgFqA) |
| 3   | CONVERT + INSERT no Histórico                                          | `[03_Insert_HistStudio.sql](./03_Insert_HistStudio.sql)`         | [Assistir](https://www.youtube.com/watch?v=oTvTQ4SgFqA) |
| 4   | Criar `DataMart.DimCliente` (registro -1)                              | `[04_Create_DimCliente.sql](./04_Create_DimCliente.sql)`         | [Assistir](https://www.youtube.com/watch?v=32RLwGQYSMs) |
| 5   | Alimentar a DimCliente sem duplicar                                    | `[05_Alimentar_DimCliente.sql](./05_Alimentar_DimCliente.sql)`   | [Assistir](https://www.youtube.com/watch?v=32RLwGQYSMs) |
| 6   | Prévia da fato (data, cliente, quantidade)                             | `[06_Select_Fato.sql](./06_Select_Fato.sql)`                     | [Assistir](https://www.youtube.com/watch?v=32RLwGQYSMs) |
| 7   | Criar `DataMart.DimContato` (registro -1 + índice)                     | `[07_Create_DimContato.sql](./07_Create_DimContato_Studio.sql)`         | [Assistir](https://www.youtube.com/watch?v=jMhzQbc7vls)                                |
| 8   | Alimentar `DimContato` (`ROW_NUMBER`, `CHECKSUM`, `UPDATE` + `INSERT`) | `[08_Alimentar_DimContato.sql](./08_Alimentar_DimContato_Studio.sql)`   | [Assistir](https://www.youtube.com/watch?v=jMhzQbc7vls)                                |
| 9   | Atualizar a prévia da fato (quantidade + valor)                        | `[09_Select_Fato.sql](./09_Select_Fato_Studio.sql)`                     | [Assistir](https://www.youtube.com/watch?v=jMhzQbc7vls)                                |
| 10  | Criar `DataMart.DimCidadeUF` (registro -1 + índice único cidade/UF)    | `[10_Create_DimCidadeUF_Studio.sql](./10_Create_DimCidadeUF_Studio.sql)` | [Assistir](https://youtu.be/hELJQuNW204) |
| 11  | Alimentar `DimCidadeUF` com cidades e UFs sem duplicar                 | `[11_Alimentar_DimCidadeUF_Studio.sql](./11_Alimentar_DimCidadeUF_Studio.sql)` | [Assistir](https://youtu.be/hELJQuNW204) |
| 12  | Atualizar a prévia da fato com `idCidadeUF`                             | `[12_Select_Fato_Studio.sql](./12_Select_Fato_Studio.sql)` | [Assistir](https://youtu.be/hELJQuNW204) |

A aula 1 também aparece em [Aulas avulsas](../Aulas-Avulsas/) (mesmo vídeo). Aqui ela entra na sequência do mini curso.

Título, descrição e capítulos da aula 3: `[aula-03-youtube.md](./aula-03-youtube.md)`.  
Título, descrição e capítulos da aula de Cidade/UF: `[aula-04-youtube.md](./aula-04-youtube.md)`.  
Título, descrição e capítulos da aula de Cidade/UF: `[aula-04-youtube.md](./aula-04-youtube.md)`.

## Como estudar

1. Baixe o CSV em `[BasesFakes/historico_studio.csv](../../BasesFakes/historico_studio.csv)` e salve no seu PC (exemplo: `C:\Dados\historico_studio.csv`)
2. Abra os scripts **nesta ordem** no SSMS
3. Na aula 1, ajuste o caminho do `BULK INSERT` para o lugar onde você salvou o arquivo
4. Execute por partes e compare com o vídeo

O `BULK INSERT` lê o arquivo do **disco da máquina**, não direto do GitHub.