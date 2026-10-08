# Carregamento paralelo de tabelas — texto para o YouTube

Vídeo sobre a configuração de **Carregamento paralelo de tabelas** no Power BI, com foco em atualização, consumo de memória/CPU e ajuste do paralelismo.

## Título

Carregamento Paralelo de Tabelas no Power BI | Performance no Refresh

## Descrição

```
Você sabe o que acontece quando o Power BI atualiza várias tabelas ao mesmo tempo?

A configuração de **Carregamento paralelo de tabelas** controla quantos trabalhos podem ser executados de forma simultânea durante o carregamento dos dados no arquivo atual.

Isso pode ajudar a reduzir o tempo de atualização, mas também pode aumentar o consumo de memória e CPU. Por isso, dependendo da sua máquina e do tamanho do modelo, pode fazer sentido manter o padrão, reduzir o paralelismo ou configurar um valor personalizado.

Neste vídeo:
- onde encontrar a configuração de Carregamento paralelo de tabelas
- o que significa o carregamento paralelo
- por que o paralelismo pode deixar o refresh mais rápido
- como o paralelismo pode aumentar o uso de memória e CPU
- o que significa a opção **Padrão**
- o que acontece quando você seleciona **Uma**
- como usar a opção **Personalizar**
- por que não existe um número mágico que seja melhor para todo modelo
- como testar diferentes valores e comparar o resultado
- diferença entre a configuração do **Arquivo atual** e a configuração **Global** do Power Query

### Observações técnicas importantes

Quando eu falo no vídeo em “6 atualizações simultâneas”, o termo mais preciso é **até 6 trabalhos simultâneos**. Isso não significa necessariamente que o Power BI esteja atualizando exatamente seis tabelas ao mesmo tempo, porque o processamento também depende de outras condições e configurações do modelo.

Na opção **Padrão**, o limite máximo documentado é de 6 trabalhos simultâneos.

Na opção **Uma**, o limite fica em 1, desabilitando efetivamente o carregamento paralelo.

Na opção **Personalizar**, é possível configurar de 1 a 30 trabalhos simultâneos. Em modelos semânticos Pro, valores acima de 6 não são aplicados.

E uma observação sobre um exemplo extremo que eu mencionei no vídeo: quando digo que o computador pode “desligar”, estou me referindo a uma situação muito extrema de consumo de recursos, em que a máquina pode ficar completamente sem resposta e exigir uma reinicialização. Isso não acontece necessariamente e não é uma consequência direta da configuração.

A recomendação é sempre testar. Mais paralelismo não significa automaticamente um refresh melhor: o objetivo é encontrar um equilíbrio entre **tempo de atualização e uso de recursos**.

Documentação oficial da Microsoft:
https://learn.microsoft.com/pt-br/power-bi/transform-model/desktop-evaluation-configuration

### Capítulos

0:00 Introdução: carregamento paralelo de tabelas
0:31 Onde encontrar a configuração
1:20 O que é carregamento paralelo
2:04 Por que pode reduzir o tempo de atualização
2:48 O custo do paralelismo: memória e CPU
3:28 Padrão: até 6 trabalhos simultâneos
4:10 Mais paralelismo nem sempre é melhor
4:57 Quando faz sentido reduzir
5:47 Opção “Uma”
6:29 Opção “Personalizar”
7:00 Limite no modelo semântico Pro
7:14 Como escolher e testar o valor
8:29 Global x Arquivo atual
9:00 As duas configurações podem interagir

#PowerBI #PowerQuery #Performance #Refresh #BusinessIntelligence #BI
```

## Comentário fixado

```
📌 Só uma observação técnica importante:

Quando eu falo em “6 atualizações simultâneas” no vídeo, o termo mais preciso é **até 6 trabalhos simultâneos**. Isso não significa necessariamente seis tabelas sendo atualizadas exatamente ao mesmo tempo.

Também vale lembrar:

• **Padrão:** até 6 trabalhos simultâneos  
• **Uma:** 1 trabalho simultâneo, desabilitando efetivamente o carregamento paralelo  
• **Personalizar:** de 1 a 30  
• Em modelos semânticos Pro, valores acima de 6 não são aplicados.

E sobre o exemplo extremo em que mencionei que o computador pode “desligar”: estou falando de uma situação extrema de falta de recursos, em que a máquina pode ficar completamente sem resposta e exigir uma reinicialização. Não é algo que necessariamente acontece.

A ideia principal é: **mais paralelismo não significa automaticamente mais performance**. Teste o seu cenário e procure o melhor equilíbrio entre tempo de refresh e consumo de recursos.

📚 Documentação oficial:
https://learn.microsoft.com/pt-br/power-bi/transform-model/desktop-evaluation-configuration
```
