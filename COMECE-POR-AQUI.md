# Comece por aqui — trilha recomendada

Ordem de estudo **pensada para quem está começando**, misturando vídeos de negócio e scripts SQL.  
Não segue a ordem das playlists do YouTube — segue o fluxo real do trabalho:

**entender o problema → instalar o ambiente → SQL básico → trazer o CSV pro banco → transformar (histórico, dimensão, fato).**

Cada passo: **por quê** → **o que assistir** → **o que praticar** (quando houver script).

**Assistir** sempre abre só aquele vídeo (`watch?v=...`).

---

## Mapa rápido

| Etapa | Objetivo | Onde está o material |
|------|----------|----------------------|
| 0 | Entender o porquê (SQL + ETL, não só Power BI) | Negócio |
| 1 | Instalar SQL Server + SSMS | [Importar CSV](./SQL/Curso-Importar-CSV-SQL/) |
| 2 | SQL do dia a dia (SELECT, filtro, variável) | [Aulas avulsas](./SQL/Aulas-Avulsas/) |
| 3 | Importar CSV → Stage → procedure | [Importar CSV](./SQL/Curso-Importar-CSV-SQL/) |
| 4 | Por que automatizar e como organizar o projeto | Negócio |
| 5 | Stage → Histórico → Dimensão → Fato | [ETL Completo](./SQL/Curso-ETL-Completo/) |
| 6 | Reforço (JOIN, LOOP, média móvel) + carreira | Avulsas + Negócio |

---

## Etapa 0 — Comece pelo negócio (mentalidade)

Antes de digitar SQL: entender **por que** banco, ETL e automação importam.

| Ordem | Faça isto | Link |
|------|-----------|------|
| 0.1 | Power BI sozinho não basta — SQL e ETL | [Assistir](https://www.youtube.com/watch?v=uZnpdC01Pns) |
| 0.2 | O que todo analista precisa saber sobre ETL e SQL | [Assistir](https://www.youtube.com/watch?v=YwtpinfAM5U) |
| 0.3 | ETL para iniciantes: depois de entender a origem dos dados | [Assistir](https://www.youtube.com/watch?v=1BjIneRkn4Q) |
| 0.4 | (Opcional) Quer entrar na área? Método que funciona | [Assistir](https://www.youtube.com/watch?v=qJs3kBHdJuI) |

**Próximo passo:** instalar o ambiente.

---

## Etapa 1 — Ambiente (banco na máquina)

Sem SQL Server não dá para importar nem fazer ETL.

| Ordem | Faça isto | Script | Link |
|------|-----------|--------|------|
| 1.1 | Instalar SQL Server Express | — | [Assistir](https://www.youtube.com/watch?v=OAqj7BacfKY) |
| 1.2 | Instalar SSMS 22 | — | [Assistir](https://www.youtube.com/watch?v=6phyYGC1-Ao) |
| 1.3 | Validar a instalação | — | [Assistir](https://www.youtube.com/watch?v=_41uJtjnJfI) |
| 1.4 | (Opcional) Git + GitHub para guardar o projeto | — | [004](https://www.youtube.com/watch?v=LDqKZ6YLdXY) · [005](https://www.youtube.com/watch?v=ZnRpzbZoZJU) |

Pasta: [`SQL/Curso-Importar-CSV-SQL`](./SQL/Curso-Importar-CSV-SQL/)

**Próximo passo:** SQL básico — senão BULK INSERT e procedure ficam “mágica”.

---

## Etapa 2 — SQL mínimo para o que vem a seguir

O suficiente para ler dado, filtrar e usar variável (base da importação e das procedures).

| Ordem | Faça isto | Script | Link |
|------|-----------|--------|------|
| 2.1 | SELECT, Alias e TOP | [`SQL_SELECT_Alias_TOP.sql`](./SQL/Aulas-Avulsas/SQL_SELECT_Alias_TOP.sql) | [Assistir](https://www.youtube.com/watch?v=iY63k8jpD_k) |
| 2.2 | WHERE (filtros) | [`SQL_WHERE.sql`](./SQL/Aulas-Avulsas/SQL_WHERE.sql) | [Assistir](https://www.youtube.com/watch?v=2iOMpEOHQiY) |
| 2.3 | Variáveis (DECLARE + SET) | [`SQL_Variaveis_DECLARE_SET.sql`](./SQL/Aulas-Avulsas/SQL_Variaveis_DECLARE_SET.sql) | [Assistir](https://www.youtube.com/watch?v=Igm14_DaSVQ) |

**Próximo passo:** trazer o CSV pro banco.

---

## Etapa 3 — Importar CSV para o banco (Stage)

Objetivo: arquivo na pasta → dado no SQL Server, de forma repetível.

| Ordem | Faça isto | Script | Link |
|------|-----------|--------|------|
| 3.1 | BULK INSERT | [`006-bulk-insert-explicado.sql`](./SQL/Curso-Importar-CSV-SQL/006-bulk-insert-explicado.sql) | [Assistir](https://www.youtube.com/watch?v=kw2IyCl06xI) |
| 3.2 | Criar tabela Stage | [`007-criar-tabela-stage.sql`](./SQL/Curso-Importar-CSV-SQL/007-criar-tabela-stage.sql) | [Assistir](https://www.youtube.com/watch?v=m_A1oKcE6PY) |
| 3.3 | INSERT INTO na Stage | [`008-insert-into-stage.sql`](./SQL/Curso-Importar-CSV-SQL/008-insert-into-stage.sql) | [Assistir](https://www.youtube.com/watch?v=Qk52PNxX_24) |
| 3.4 | Variáveis na importação | [`009-variaveis-importacao-csv.sql`](./SQL/Curso-Importar-CSV-SQL/009-variaveis-importacao-csv.sql) | [Assistir](https://www.youtube.com/watch?v=b6j5hwZ7NW4) |
| 3.5 | Script → procedure de carga | [`010-criar-proc-stg-vendas-roupas.sql`](./SQL/Curso-Importar-CSV-SQL/010-criar-proc-stg-vendas-roupas.sql) | [Assistir](https://www.youtube.com/watch?v=wN--o_yIgsw) |

**Próximo passo:** entender automação e organização — depois montar o modelo (histórico / dim / fato).

---

## Etapa 4 — Ponte: automação + organização do projeto

| Ordem | Faça isto | Link |
|------|-----------|------|
| 4.1 | Trabalhe menos, analise mais — automação (SQL, procedure, Python) | [Assistir](https://www.youtube.com/watch?v=6nFgo-mECgY) |
| 4.2 | Organizar projeto de BI: SQL Server, schemas, ETL e Power BI | [Assistir](https://www.youtube.com/watch?v=vyxRNUipPVU) |

**Próximo passo:** transformar a Stage no modelo analítico.

---

## Etapa 5 — ETL: Stage → Histórico → Dimensão → Fato

Comece pelo [`00_Script_Inicial.sql`](./SQL/Curso-ETL-Completo/00_Script_Inicial.sql) (schema + Stage do projeto).

| Ordem | Faça isto | Script | Link |
|------|-----------|--------|------|
| 5.1 | Criar Histórico | [`01_Create_Hist.sql`](./SQL/Curso-ETL-Completo/01_Create_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=v9UfGpuI0Gc) |
| 5.2 | CONVERT + temporária | [`02_Convert_Temp.sql`](./SQL/Curso-ETL-Completo/02_Convert_Temp.sql) | [Assistir](https://www.youtube.com/watch?v=N82GIjWbKy0) |
| 5.3 | INSERT no Histórico | [`03_Insert_Hist.sql`](./SQL/Curso-ETL-Completo/03_Insert_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=kKSHBAJujzU) |
| 5.4 | Procedure do Histórico | [`04_Proc_Hist.sql`](./SQL/Curso-ETL-Completo/04_Proc_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=W2gKG-eCh2k) |
| 5.5 | MERGE no Histórico | [`05_Merge_Hist.sql`](./SQL/Curso-ETL-Completo/05_Merge_Hist.sql) | [Assistir](https://www.youtube.com/watch?v=V8tWBXlMAtI) |
| 5.6 | Dimensões + MERGE | [`06_Create_Dim.sql`](./SQL/Curso-ETL-Completo/06_Create_Dim.sql) · [`06_Proc_Dim.sql`](./SQL/Curso-ETL-Completo/06_Proc_Dim.sql) | [Assistir](https://www.youtube.com/watch?v=4h6_TkjIKho) |
| 5.7 | Montar Fato (SELECT) | [`07_Select_Fato.sql`](./SQL/Curso-ETL-Completo/07_Select_Fato.sql) | [Assistir](https://www.youtube.com/watch?v=YtdZfOOYTgI) |
| 5.8 | Fato com MERGE | [`08_Create_Fato.sql`](./SQL/Curso-ETL-Completo/08_Create_Fato.sql) · [`08_Proc_Fato.sql`](./SQL/Curso-ETL-Completo/08_Proc_Fato.sql) | [Assistir](https://www.youtube.com/watch?v=RzKSyF4YOII) |

Pasta: [`SQL/Curso-ETL-Completo`](./SQL/Curso-ETL-Completo/)

**Dica:** o vídeo de LOOP com data encaixa bem junto da procedure do histórico:

| Reforço | Script | Link |
|---------|--------|------|
| LOOP com data (ETL) | [`SQL_LOOP_Data.sql`](./SQL/Aulas-Avulsas/SQL_LOOP_Data.sql) | [Assistir](https://www.youtube.com/watch?v=Z4tMiRvUgJY) |

---

## Etapa 6 — Depois do ETL (opcional, mas vale)

| Ordem | Faça isto | Script | Link |
|------|-----------|--------|------|
| 6.1 | LEFT JOIN (liga dim/fato no dia a dia) | [`SQL_LEFT_JOIN.sql`](./SQL/Aulas-Avulsas/SQL_LEFT_JOIN.sql) | [Assistir](https://www.youtube.com/watch?v=GmL4jGSuOPU) |
| 6.2 | Média móvel | [`SQL_Media_Movel.sql`](./SQL/Aulas-Avulsas/SQL_Media_Movel.sql) | [Assistir](https://www.youtube.com/watch?v=Vee5fI2On-Y) |
| 6.3 | Dia a dia do analista (demanda real) | — | [Assistir](https://www.youtube.com/watch?v=vCNIeKiGKGo) |
| 6.4 | Relatórios que geram ação (Power BI) | — | [Assistir](https://www.youtube.com/watch?v=qWCzOl9pLrM) |
| 6.5 | Nunca fez um relatório? Comece assim | — | [Assistir](https://www.youtube.com/watch?v=OpOi39YaI1s) |
| 6.6 | Dicas rápidas de Power BI (performance, parâmetros, DAX…) | — | [Lista completa](./PowerBI/Dicas-Rapidas/) |

Outros vídeos de carreira ficam em [`Negocio/Carreira-Dados`](./Negocio/Carreira-Dados/); dicas de Power BI em [`PowerBI/`](./PowerBI/) — use quando quiser, **fora** da sequência SQL/ETL.

---

## Em uma frase

> Instale o banco → aprenda SELECT/WHERE/variável → **importe o CSV** → **automatize a Stage** → **monte histórico, dimensão e fato** → use o tempo liberado para analisar (e refine o relatório no Power BI).

As pastas por tema (`SQL/`, `PowerBI/`, `Negocio/`) continuam; **esta página é a playlist mental** (e o roteiro para montar uma playlist no YouTube com a mesma ordem, se quiser).
