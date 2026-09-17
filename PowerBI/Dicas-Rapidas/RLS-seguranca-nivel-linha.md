# RLS no Power BI: segurança em nível de linha

Material da aula de RLS (Row-Level Security) no relatório de vendas de videogame.

**RLS** = Row-Level Security = **segurança em nível de linha**.  
Cada pessoa abre o mesmo arquivo e vê só as linhas que ela pode ver.

YouTube: https://www.youtube.com/watch?v=zP4t413fshk  
Canal: [youtube.com/@mundomis](https://www.youtube.com/@mundomis)

Copie os blocos para o seu `.pbix`. Nomes sem espaço (PascalCase).

---

## O que você monta

| Peça | Nome | Papel |
|------|------|--------|
| Tabela em branco | `MedidasAcesso` | Onde ficam as medidas |
| Medida crua (didática) | `Usuario` | Texto da sessão, sem cortar |
| Medida da role | `UsuarioLogado` | Login tratado, bate com o cadastro |
| Cadastro | `Usuarios` | `Login` + `Genero` (sem relação com a fato) |
| Role | `AcessoPorUsuario` | Os três filtros abaixo |

A tabela `Usuarios` **não se relaciona** com as vendas. Ela só alimenta o DAX da role.

---

## 1. Tabela `MedidasAcesso` (Power Query)

Consulta em branco → Editor avançado:

```powerquery
let
    Fonte = ""
in
    Fonte
```

Renomeie a consulta para `MedidasAcesso`. Oculte a coluna de texto que o Power BI gerar.

---

## 2. Medida `Usuario` (texto cru)

Só para o card do vídeo. **Não entra na role.**

```dax
Usuario =
    // Texto cru da sessao, so em minusculo. Ainda traz MAQUINA\conta ou o e-mail inteiro.
    LOWER(USERNAME())
```

No Desktop costuma aparecer `nomedamaquina\conta`.  
No Serviço aparece o e-mail.  
Por isso esta medida não é “só o login”: o login tratado é a próxima.

---

## 3. Medida `UsuarioLogado` (a da role)

Esta sim a role usa. O resultado tem que ser igual à coluna `Login`.

```dax
UsuarioLogado =
    // Parte da mesma sessao, mas ja recortada para casar com Usuarios[Login].
    VAR userRaw = LOWER(USERNAME())

    // Email: fica a parte antes do @. Conta local: fica o que vem depois da barra.
    VAR base0 = IF(
            CONTAINSSTRING(userRaw, "@"),
            LEFT(userRaw, FIND("@", userRaw, 1) - 1),
            IF(
                CONTAINSSTRING( userRaw, "\"),
                RIGHT(userRaw, LEN(userRaw) - FIND("\", userRaw, 1)),
                userRaw
            )
        )

    // Convidado do Azure AD traz #ext# no meio do login; corta isso.
    VAR posExt = FIND("#ext#", base0, 1, 0 )
    VAR isGuest = posExt > 0
    VAR baseNoExt = IF(isGuest, LEFT(base0, posExt - 1), base0)

    // Caso especial de convidado com prefixo c_ e mais de um underline.
    VAR onlyUpToSecondUnderscoreWhenGuestC =
        VAR secondUS = FIND( "_", baseNoExt, 3, 0)
        RETURN IF( secondUS > 0, LEFT( baseNoExt, secondUS - 1), baseNoExt)

    // Login corporativo com underline: fica so o pedaco antes do primeiro _.
    VAR result =
        IF(
            LEFT(baseNoExt, 2) = "c_",
            IF( isGuest, onlyUpToSecondUnderscoreWhenGuestC, baseNoExt ),
            IF(
                CONTAINSSTRING(baseNoExt, "_"),
                LEFT(baseNoExt, FIND("_", baseNoExt, 1) - 1),
                baseNoExt
            )
        )

    // Este texto tem de bater com a coluna Login da tabela Usuarios.
    RETURN result
```

Coloque as duas medidas na tabela `MedidasAcesso`. Sem pasta.

---

## 4. Tabela `Usuarios` (cadastro)

Colunas: `Login`, `Genero`.  
Uma linha = um recorte. Dois gêneros = duas linhas com o mesmo login. `all` = vê tudo.

| Login | Genero | No Exibir como (Outro usuario) | Vê |
|-------|--------|--------------------------------|-----|
| ana.silva | Sports | ana.silva@empresa.com | só Sports |
| bruno.costa | Shooter | bruno.costa@empresa.com | só Shooter |
| jessica.franca | Action | jessica.franca@empresa.com | só Action |
| maria.santos | all | maria.santos@empresa.com | todos os gêneros |
| paulo.lima | Action | paulo.lima@empresa.com | Action e Simulation |
| paulo.lima | Simulation | (o mesmo login) | |

`all` não é gênero de jogo. É a chave de acesso total, em minúsculo.

Power Query (Inserir dados / `#table`):

```powerquery
let
    Fonte = #table(
        type table [Login = text, Genero = text],
        {
            {"ana.silva", "Sports"},
            {"bruno.costa", "Shooter"},
            {"jessica.franca", "Action"},
            {"maria.santos", "all"},
            {"paulo.lima", "Action"},
            {"paulo.lima", "Simulation"}
        }
    )
in
    Fonte
```

Renomeie a consulta para `Usuarios`. Não crie relacionamento com a fato.

---

## 5. Role `AcessoPorUsuario`

Modelagem → Gerenciar funções → criar `AcessoPorUsuario` (leitura).

### Filtro em `Usuarios`

```dax
[Login] == [UsuarioLogado]
```

Só as linhas da pessoa da sessão.

### Filtro na fato (`vgsales`)

Troque `vgsales[Genre]` pelo nome da sua coluna de gênero na fato.

```dax
// Esta linha da fato passa se o login logado tiver regra para este genero OU regra all.
VAR MatchGenero =
    // Tem na tabela Usuarios uma linha com este login E o genero desta venda?
    CONTAINS(
        Usuarios,
        Usuarios[Login], [UsuarioLogado],
        Usuarios[Genero], vgsales[Genre]
    )

VAR MatchAll =
    // Tem na tabela Usuarios uma linha com este login E genero = all? Se sim, ve tudo.
    CONTAINS(
        Usuarios,
        Usuarios[Login], [UsuarioLogado],
        Usuarios[Genero], "all"
    )

// True se bateu o genero (uma ou mais linhas) ou se o cadastro tem all.
RETURN MatchGenero || MatchAll
```

### Filtro na `dim_Genre`

O relacionamento é da dim para a fato. RLS só na fato recorta a venda e **não** limpa o slicer da dim. Por isso o mesmo teste vai na dimensão.

Troque `dim_Genre[Genre]` se o nome da sua dim for outro.

```dax
// Esta linha da dim passa se o login logado tiver regra para este genero OU regra all.
VAR MatchGenero =
    // Tem na tabela Usuarios uma linha com este login E este genero da dim?
    CONTAINS(
        Usuarios,
        Usuarios[Login], [UsuarioLogado],
        Usuarios[Genero], dim_Genre[Genre]
    )

VAR MatchAll =
    // Tem na tabela Usuarios uma linha com este login E genero = all? Se sim, ve todos os generos.
    CONTAINS(
        Usuarios,
        Usuarios[Login], [UsuarioLogado],
        Usuarios[Genero], "all"
    )

// True se bateu o genero (uma ou mais linhas) ou se o cadastro tem all.
RETURN MatchGenero || MatchAll
```

Não filtre `MedidasAcesso`.

---

## 6. Como testar no Desktop

1. Dois cards no relatório: `[Usuario]` e `[UsuarioLogado]`
2. Modelagem → **Exibir como**
3. Marque a função `AcessoPorUsuario`
4. Outro usuário: cole o e-mail da tabela (ex.: `ana.silva@empresa.com`)
5. `Usuario` mostra o e-mail; `UsuarioLogado` mostra `ana.silva`; as vendas ficam no recorte

Sem Exibir como, o Desktop usa a conta do Windows (`maquina\conta`), não o e-mail da bolinha do Power BI.

---

## 7. E a plataforma?

`Platform` não tem login. Login mora só em `Usuarios`.

Visual com medida já mostra só plataforma que ainda tem venda no recorte.  
Se criar `dim_Platform` e o slicer listar tudo, o filtro dela não é login. É:

```dax
// Esta plataforma fica se ainda existir venda visivel para este usuario.
NOT ISEMPTY(RELATEDTABLE(vgsales))
```

---

## Funções DAX usadas aqui

| Função | O que faz nesta aula |
|--------|----------------------|
| `USERNAME()` | Quem está na sessão (máquina\conta ou e-mail) |
| `LOWER()` | Minúsculo, para casar com o cadastro |
| `CONTAINSSTRING` | Tem `@`, `\` ou `_` no texto? |
| `LEFT` / `RIGHT` / `LEN` / `FIND` | Cortar e-mail, domínio e underline |
| `CONTAINS` | Existe na tabela `Usuarios` uma linha com este login e este valor? |
| `NOT ISEMPTY` + `RELATEDTABLE` | Dim sem login: ainda sobrou venda nesta chave? |

A role usa `USERNAME()` via `UsuarioLogado`. Não usa a coluna `Login` direto na sessão: a coluna é do **cadastro**, a medida é de **quem está logado agora**.
