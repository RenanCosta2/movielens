# MovieLens

Nesse projeto é efetuado a coleta, o armazenamento e o processamento de dados de filmes para o desenvolvimento de análises e dashboards.

## Etapas do projeto
- [Coleta](#coleta)

<img src="./img/arquitetura.png">

### Coleta

A fonte de dados utilizada é proveniente do site [MovieLens](https://grouplens.org/datasets/movielens/ml_belief_2024/). Esses dados contêm avaliações e avaliações esperadas de filmes feitas por usuários no MovieLens entre março de 2023 e maio de 2024.

Devido ao período fixo, esses dados não receberão atualizações após sua publicação. Portanto, os dados foram baixados diretamente do site e armazenados em um bucket na plataforma do Google Cloud Storage.

