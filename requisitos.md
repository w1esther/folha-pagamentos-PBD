# 💼 Sistema de Folha de Pagamentos — NovaTech

Sistema de banco de dados desenvolvido para **gerenciar, registrar e consultar informações relacionadas à folha de pagamentos da NovaTech**, considerando as diferentes situações que podem ocorrer com os funcionários ao longo dos períodos.

O sistema busca manter um **histórico confiável das informações funcionais e salariais**, permitindo calcular e consultar folhas de pagamento sem a necessidade de reconstruir manualmente os acontecimentos de cada mês.

---

## 🎯 Objetivo do Sistema

O sistema tem como objetivo organizar as informações dos funcionários e controlar os acontecimentos que podem interferir na remuneração, permitindo a geração, consulta e conferência das folhas de pagamento de diferentes períodos.

Entre suas principais finalidades estão:

* Manter os dados dos funcionários organizados, incluindo suas informações funcionais e salariais.
* Relacionar funcionários aos seus respectivos **setores e cargos**, permitindo conhecer a composição da empresa.
* Registrar acontecimentos que interferem na remuneração durante cada período.
* Manter o **histórico das alterações**, evitando que informações anteriores sejam simplesmente substituídas.
* Obter os valores da folha de determinado período sem precisar reconstruir manualmente os acontecimentos.
* Identificar **proventos e descontos** associados aos funcionários.
* Consultar informações de períodos anteriores, inclusive de um funcionário específico.
* Conferir os resultados e identificar possíveis inconsistências antes que elas gerem problemas.
* Obter informações consolidadas da empresa, como os valores relacionados à folha em determinado período.
* Diferenciar situações e períodos, garantindo que acontecimentos de um mês não sejam indevidamente atribuídos a outro.

---

## 👨‍💼 Situações que o sistema deve considerar

Durante um período de trabalho, um funcionário pode passar por diferentes situações que alteram sua remuneração ou seu vínculo com a empresa.

O sistema deve ser capaz de registrar situações como:

* 📅 **Admissão durante o mês**
* 💰 **Aumento salarial**
* ⏱️ **Horas extras**
* ⚠️ **Faltas e atrasos**
* 🏖️ **Férias**
* ➕ **Adicionais**
* 🎁 **Benefícios**
* ➖ **Descontos**
* 🏥 **Afastamentos**
* 🚪 **Desligamentos**
* 📈 **Promoções**

Esses acontecimentos devem ser associados ao período correto, preservando seu histórico quando necessário.

---

## 🧾 Controle da Folha de Pagamento

Antes de gerar uma folha de pagamento, o sistema deve permitir a conferência dos dados para garantir que os valores calculados estejam consistentes.

### Checklist de conferência

* [ ] Todos os funcionários foram considerados.
* [ ] Nenhum funcionário foi considerado indevidamente.
* [ ] Os salários estão corretos.
* [ ] As alterações ocorridas no mês foram consideradas.
* [ ] Os proventos estão corretos.
* [ ] Os descontos estão corretos.
* [ ] Os valores finais fazem sentido.
* [ ] Os encargos estão consistentes.
* [ ] Os demais valores relacionados à folha estão consistentes.
* [ ] Os acontecimentos foram associados ao período correto.

---

## 📊 Informações que o sistema deve permitir consultar

O banco de dados deve possibilitar consultas relacionadas a diferentes aspectos da folha de pagamento, como:

### Funcionários

* Dados cadastrais;
* Cargo;
* Setor;
* Salário;
* Situação funcional;
* Histórico de alterações.

### Remuneração

* Salário-base;
* Horas extras;
* Adicionais;
* Benefícios;
* Outros proventos;
* Descontos;
* Encargos;
* Valor final da folha.

### Histórico

* Alterações salariais;
* Promoções;
* Admissões;
* Férias;
* Afastamentos;
* Desligamentos;
* Faltas e atrasos;
* Outros acontecimentos que afetem a remuneração.

### Folhas de pagamento

* Folha de determinado período;
* Folha de um funcionário específico;
* Total de proventos;
* Total de descontos;
* Total de encargos;
* Valor líquido;
* Valores consolidados da empresa.

---

## 🗓️ Controle por período

Um dos princípios fundamentais do sistema é garantir que **cada acontecimento esteja relacionado ao período em que realmente ocorreu**.

Por exemplo:

> Um aumento salarial ocorrido em setembro não deve alterar indevidamente o salário registrado para agosto.

Da mesma forma, horas extras, faltas, férias, descontos e outros acontecimentos devem ser registrados no período correspondente.

Isso permite manter um histórico confiável e consultar corretamente as folhas de períodos anteriores.

---

## 🗃️ Histórico

As informações que representam mudanças ao longo do tempo não devem simplesmente substituir os registros anteriores.

O sistema deve preservar o histórico para possibilitar consultas como:

* Qual era o salário do funcionário em determinado período?
* Quando ocorreu uma promoção?
* Quando o funcionário recebeu um aumento?
* Em qual período ocorreram horas extras?
* Quando o funcionário entrou de férias?
* Quando ocorreu um afastamento?
* Qual era o setor ou cargo do funcionário em determinado período?

Dessa forma, o banco de dados representa não apenas a **situação atual**, mas também a evolução dos funcionários dentro da empresa.

---

## 🔎 Consistência dos dados

O sistema deve possuir mecanismos que auxiliem na identificação de possíveis inconsistências antes da geração ou fechamento da folha.

Alguns exemplos:

* Funcionário desligado sendo incluído indevidamente em uma folha posterior;
* Funcionário ativo não sendo considerado;
* Salário incompatível com o histórico;
* Alteração salarial não considerada;
* Desconto registrado no período incorreto;
* Provento duplicado;
* Horas extras associadas ao funcionário ou período errado;
* Férias registradas em período diferente daquele em que ocorreram;
* Valores finais incompatíveis com os proventos e descontos registrados.

---

## 🏢 Visão geral

O sistema pode ser entendido a partir de quatro grandes grupos de informações:

```text
                 ┌─────────────────────┐
                 │     FUNCIONÁRIOS    │
                 └──────────┬──────────┘
                            │
             ┌──────────────┼──────────────┐
             │              │              │
             ▼              ▼              ▼
        ┌─────────┐    ┌─────────┐   ┌─────────────┐
        │  CARGOS │    │ SETORES │   │  HISTÓRICO  │
        └─────────┘    └─────────┘   └──────┬──────┘
                                             │
                                             ▼
                                    ┌─────────────────┐
                                    │   OCORRÊNCIAS   │
                                    │  DO FUNCIONÁRIO │
                                    └────────┬────────┘
                                             │
                                             ▼
                                    ┌─────────────────┐
                                    │     FOLHA DE    │
                                    │    PAGAMENTO    │
                                    └────────┬────────┘
                                             │
                              ┌──────────────┼──────────────┐
                              ▼              ▼              ▼
                         ┌─────────┐   ┌──────────┐   ┌──────────┐
                         │PROVENTOS│   │ DESCONTOS│   │ ENCARGOS │
                         └─────────┘   └──────────┘   └──────────┘
```

---

## 📌 Princípios do sistema

O banco de dados deve priorizar:

1. **Organização** — informações estruturadas e relacionadas corretamente.
2. **Histórico** — alterações importantes devem ser preservadas.
3. **Rastreabilidade** — deve ser possível identificar a origem dos valores da folha.
4. **Consistência** — os dados devem respeitar as regras definidas pelo sistema.
5. **Controle temporal** — acontecimentos devem estar associados ao período correto.
6. **Conferência** — os resultados devem poder ser verificados antes do fechamento da folha.
7. **Consulta** — informações atuais e históricas devem ser facilmente recuperáveis.
8. **Integridade** — funcionários, ocorrências, proventos, descontos e folhas devem permanecer corretamente relacionados.

---

## 🚀 Resultado esperado

Ao final, o banco de dados deverá permitir que a NovaTech mantenha um **histórico organizado da vida funcional e salarial de seus funcionários** e consiga obter as informações necessárias para a elaboração e conferência das folhas de pagamento de cada período.

O sistema deve representar não apenas **quanto um funcionário recebe**, mas também **por que ele recebeu aquele valor e quais acontecimentos contribuíram para o resultado da folha**.
