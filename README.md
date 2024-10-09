# conferencias-gestao-dados
# Sistema de Reservas de Salas de Conferência

Este repositório implementa um sistema de reservas de salas de conferência, com foco em gerenciar o controle de concorrência em um banco de dados relacional. O projeto utiliza SQL para demonstrar a criação e manipulação de tabelas, além de transações que garantem a integridade dos dados em um ambiente de acesso simultâneo.

## Recursos do Projeto

- **Modelagem do Banco de Dados:** Tabelas `SALAS` e `RESERVAS` que representam as entidades principais do sistema.
- **Transações Concorrentes:** Quatro transações que incluem operações de inserção, atualização e exclusão, com simulações de leitura não repetível e fantasmas.
- **Controle de Concorrência:** Implementação de bloqueios implícitos e explícitos, e utilização de diferentes níveis de isolamento para garantir a consistência dos dados.
- **Tratamento de Deadlock:** Cenários que demonstram como o Oracle detecta e resolve deadlocks.

## Conteúdo Incluído

- Scripts SQL para criação de tabelas e inserção de dados.
- Código para cada uma das transações.
- Tabela de escalonamento das execuções das transações, detalhando resultados e observações.

