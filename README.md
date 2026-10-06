# 🍞 Pão da Roça: Sistema Inteligente de Controle e Gestão (ERP & CRM)

## 📌 Sobre o Projeto
Projeto desenvolvido como Estudo de Caso (PBL) para a disciplina de Banco de Dados. O objetivo é criar um sistema integrado de gestão de estoque, vendas e relacionamento com clientes para a padaria "Pão da Roça", de pequeno porte. 

O banco de dados foi projetado não apenas para registrar o fluxo de caixa, mas para transformar dados brutos em conhecimento estratégico. A arquitetura suporta um ERP simplificado (controle de produção artesanal e industrializada) e um módulo de CRM focado em fidelização, acompanhado pela implementação de 30 consultas SQL fundamentadas na pirâmide organizacional de níveis de gestão (Operacional, Tático e Estratégico).

## 👥 Equipe
* **Líder:** Guilherme Andrade
* **Coordenador:** Felipe Tinel
* **Secretário:** Enzo Schubach
* **Membro:** Felipe Duque
* **Membro:** Guilherme Lopes

## 🛠️ Tecnologias e Padrões Utilizados
* **SGBD:** PostgreSQL
* **Modelagem de Dados:** Draw.io (MER Conceitual)
* **Controle de Versão:** Git / GitLab 
* **Padrão de Versionamento:** Commits descritivos em Inglês estruturando as etapas do projeto.

## 📂 Estrutura do Repositório

O projeto está organizado na seguinte sequência lógica de execução e análise:

* `01_create_schema.sql`: Script DDL responsável pela criação do banco, das tabelas (entidades fortes e associativas) e das restrições de integridade (PKs e FKs).
* `02_insert_data.sql`: Script DML contendo a carga inicial de dados fictícios para simular um cenário real de operação da padaria e viabilizar os testes das queries.
* `03_queries_operational.sql`: 10 consultas SQL focadas nas rotinas diárias e de curto prazo (Base da pirâmide gerencial).
* `04_queries_tactical.sql`: 10 consultas SQL voltadas para o controle de médio prazo e planejamento (Meio da pirâmide).
* `05_queries_strategic.sql`: 10 consultas SQL de alto impacto analítico para suporte a decisões de longo prazo (Ápice da pirâmide).
* `docs/`: Diretório destinado ao Modelo Entidade-Relacionamento (MER), Dicionário de Dados e Análise Crítica do projeto.

## 🚀 Como Executar o Banco de Dados

Para reproduzir o ambiente e testar as consultas, siga os passos abaixo:

1. Certifique-se de ter o **PostgreSQL** instalado e rodando em sua máquina (via instalação local ou contêiner Docker).
2. Conecte-se ao seu servidor utilizando uma ferramenta de sua preferência (pgAdmin, DBeaver, psql, etc).
3. Crie um novo banco de dados (ex: `CREATE DATABASE pao_da_roca;`) e conecte-se a ele.
4. Abra e execute o arquivo `01_create_schema.sql` para construir a estrutura do esquema.
5. Abra e execute o arquivo `02_insert_data.sql` para popular as tabelas.
6. Com o banco devidamente populado, execute os scripts `03`, `04` e `05` para validar os relatórios gerenciais e operacionais.

## 🎯 Modelagem e Regras de Negócio
O sistema foi desenhado para resolver complexidades típicas do setor, tais como:
* O relacionamento **N:M** entre receitas e insumos, permitindo fichas técnicas exatas (em kg, litros, etc).
* Vendas anônimas ou identificadas, abastecendo automaticamente um campo de `valor_acumulado` no perfil do cliente para futuras campanhas de recompensa e retenção.
* Fornecimento flexível (Muitos para Muitos), refletindo a realidade da feira livre onde a padaria pode comprar um mesmo insumo de vários fornecedores locais diferentes.