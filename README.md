# MovieLens

**Desafio técnico 01 — Case real com BigQuery e Metabase** lançado como comunidade [Dados Por Todos](https://www.instagram.com/dadosportodos) com o objetivo de incentivar o aprendizado prático.

Nesse projeto é desenvolvido um pipeline de dados completo, incluindo a coleta, o armazenamento e o processamento de dados de filmes para o desenvolvimento de análises e dashboards.

## Etapas do projeto
- [Coleta](#coleta)
- [Camada Bronze](#camada-bronze)
- [Camada Silver](#camada-silver)
- [Camada Gold](#camada-gold)
- [Dashboard Analítico](#dashboard-analítico)

<img src="./img/arquitetura.png">

### Coleta

A fonte de dados utilizada é proveniente do site [MovieLens](https://grouplens.org/datasets/movielens/ml_belief_2024/). Esses dados contêm avaliações e avaliações esperadas de filmes feitas por usuários no MovieLens entre março de 2023 e maio de 2024.

Devido ao período fixo, esses dados não receberão atualizações após sua publicação. Portanto, os dados foram baixados diretamente do site e armazenados em um bucket na plataforma do **Google Cloud Storage**.

Esses dados representarão a camada `raw`, ou camada de dados brutos.

### Camada Bronze

Nessa etapa, os arquivos `.csv` armazenados no **Google Cloud Storage** são carregados como tabelas no Google **BigQuery**, preservando sua estrutura original.

### Camada Silver

Na camada Silver são aplicadas as transformações necessárias nos dados para garantir a qualidade, consistência e organização dos dados.

As transformações realizadas foram:

- **Limpeza:** remoção de registros inconsistentes (**-1** e **NULL**) na avaliação dos filmes.
- **Padronização dos tipos:** conversão das colunas para tipos adequados.
- **Modelagem:** organização dos dados em uma estrutura com tabelas dimensão e fato.
    - as informações de **título e ano do filme** originalmente consolidadas em uma única coluna, foram separadas em colunas distintas.
    - a coluna de **gêneros**, que originalmente estava armazenada como uma string delimitada por `"|"`, foi transformada em uma tabela de dimensão e uma tabela de relacionamento entre filmes e gêneros.

<img src="./img/modelagem.png">

As consultas SQL responsáveis pela criação dessas tabelas podem ser encontradas no diretório: `/sql/silver/`

### Camada Gold

A partir das tabelas estruturadas na camada Silver, esta camada armazena um conjunto de **views analíticas** contendo métricas agregadas e estruturas de dados preparadas para consumo. Essas views são projetadas para facilitar a análise e a integração com ferramentas de BI.

Principais views:

- `vw_movie_kpis` - Métricas agregadas das avaliações dos filmes (total, média, desvio padrão).
- `vw_top_movies` - Melhores filmes bom base na média das avaliações.
- `vw_ratings_heatmap` - Avaliações ao longo do tempo.
- `vw_scatter_popularity_vs_quality` - Métricas de média e total de avaliações dos filmes para fim de comparação.
- `vw_user_activity` - Métricas de atividade dos usuários.
- `vw_genre_performance` - Métricas agregadas das avaliações dos gêneros filmes (total, média, desvio padrão).

As consultas SQL responsáveis pela criação dessas vies podem ser encontradas no diretório: `/sql/gold/`

### Dashboard Analítico

Utilizando das views da camada analítica foi desenvolvido as seguintes visualizações:

- KPIs Gerais
    - Total de Usuários
    - Total de Filmes
    - Total de Avaliações
- Métricas de Filmes
    - Top 10 por Total de Avaliações
    - Top 10 por Média de Avaliação
    - Gráfico de Dispersão Popularidade X Qualidade 
- Métricas de Gêneros dos Filmes
    - Top 10 por Média de Avaliação
    - Gráfico de Dispersão Popularidade X Qualidade 
- Métricas Gerais
    - Mapa de Calor da quantidade de avaliações ao longo do tempo
    - Tabela com métricas agregadas das atividades dos usuários

![alt text](image.png)
![alt text](image-1.png)