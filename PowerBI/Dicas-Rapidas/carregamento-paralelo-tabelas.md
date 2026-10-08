# Carregamento paralelo de tabelas no Power BI

Material complementar da aula sobre **Carregamento paralelo de tabelas** no Power BI.

YouTube: https://youtu.be/M4kT9QCaCJE

---

## O que essa configuração controla

A configuração fica em:

**Arquivo atual → Carregamento de Dados → Carregamento paralelo de tabelas**

Ela controla o **número máximo de trabalhos simultâneos** durante o carregamento dos dados no modelo.

A ideia do paralelismo é permitir que diferentes trabalhos sejam processados ao mesmo tempo, o que pode reduzir o tempo total de atualização.

Por outro lado, mais paralelismo pode aumentar o uso de recursos da máquina, principalmente **memória e CPU**.

---

## Opções

| Opção | Comportamento |
|---|---|
| **Padrão** | O Power BI define automaticamente o limite. A documentação atual informa **6 trabalhos simultâneos** como padrão. |
| **Uma** | Limita a **1 trabalho simultâneo**, desabilitando efetivamente o carregamento paralelo. |
| **Personalizar** | Permite definir manualmente o número de trabalhos simultâneos, de **1 a 30**. |

### Modelos semânticos Pro

Em modelos semânticos **Pro**, valores acima de **6** não são aplicados.

---

## Como escolher o valor?

Não existe um número que seja melhor para todos os modelos.

O valor ideal depende principalmente de:

- capacidade da máquina;
- quantidade de memória disponível;
- CPU;
- tamanho das tabelas;
- volume de dados;
- quantidade de processamento durante o refresh.

Uma forma prática de testar é comparar cenários.

Exemplo:

**Padrão → atualizar → observar**

Se a máquina estiver sofrendo muito durante o refresh:

**1 → atualizar novamente → comparar**

Também é possível testar valores intermediários pela opção **Personalizar**.

O objetivo não é simplesmente colocar o maior número possível. O objetivo é encontrar um equilíbrio entre **tempo de atualização e consumo de recursos**.

---

## ⚠️ Existe outra configuração parecida

Em:

**Global → Carregamento de Dados**

também existe uma configuração relacionada a paralelismo.

Apesar de terem nomes e conceitos parecidos, elas não controlam exatamente a mesma coisa.

- A configuração de **Arquivo atual → Carregamento paralelo de tabelas** controla o máximo de trabalhos simultâneos do mecanismo do Power BI durante o carregamento.
- A configuração **Global** está relacionada ao número máximo de avaliações simultâneas das consultas do **Power Query**.

Essas configurações podem interagir entre si.

Por isso, não é correto olhar apenas para um número isolado e assumir que ele representa tudo o que o Power BI está executando ao mesmo tempo.

---

## Observação sobre o exemplo extremo do vídeo

No vídeo eu menciono um cenário em que o computador pode “desligar”.

A intenção é representar uma situação **extrema** de falta de recursos, em que a máquina pode ficar completamente sem resposta e exigir uma reinicialização.

Isso **não é uma consequência direta ou obrigatória** do carregamento paralelo. Em situações de sobrecarga, o mais comum é observar aumento de consumo de memória/CPU, lentidão, travamentos ou falha do refresh.

---

## Documentação oficial

[Configurações de avaliação do Power BI Desktop — Microsoft Learn](https://learn.microsoft.com/pt-br/power-bi/transform-model/desktop-evaluation-configuration)
