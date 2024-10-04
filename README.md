# Desmatamento PRODES

O projeto PRODES realiza o monitoramento por satélites do desmatamento por corte raso na Amazônia Legal e, desde 1988, produz as taxas anuais de desmatamento na região, que são utilizadas pelo governo brasileiro para o estabelecimento de políticas públicas. Essas taxas são estimadas a partir dos incrementos de desmatamento identificados em cada imagem de satélite que cobre a Amazônia Legal. Os dados são apresentados inicialmente em dezembro de cada ano como estimativas, e os dados consolidados são divulgados no primeiro semestre do ano seguinte. Os dados utilizados nesta pesquisa abrangem o período de 2000 a 2022.

A seguir, apresento o objetivo das consultas, as estratégias utilizadas e os resultados obtidos:

## Pergunta 1: Qual é a área total desmatada por bioma em um município específico?
Foi realizada uma consulta para calcular a área total desmatada por bioma em um município específico (com ID 2100709). A consulta soma os valores da coluna desmatado, agrupando os resultados por bioma e ordenando-os em ordem crescente. O resultado mostra a quantidade total de desmatamento para cada bioma dentro do município. Considerando o município selecionado, temos dois biomas: Amazônia e Cerrado. No primeiro, a área total desmatada foi de **6852.4 km²**, enquanto no segundo foi de **4.6 km²**.

## Pergunta 2: Qual é o bioma com a maior área desmatada em um município específico?
Nesta consulta SQL, foi buscado identificar qual bioma tem a maior área desmatada em um município específico (com ID 1707207). A consulta soma os valores da coluna desmatado, agrupando os resultados por bioma e ordenando-os em ordem decrescente de área desmatada. O uso do `LIMIT 1` garante que apenas o bioma com a maior área desmatada seja retornado. Assim, o resultado mostra que o bioma mais afetado pelo desmatamento nesse município foi o **Cerrado**, com **22800.8 km²**.

## Pergunta 3: Qual foi a tendência de desmatamento ao longo dos anos em um bioma específico?
Foi analisada a tendência de desmatamento ao longo dos anos para o bioma **Cerrado**. A consulta soma os valores da coluna desmatado para cada ano, agrupando os resultados por ano e ordenando-os em ordem crescente. O resultado revela como a área desmatada variou ao longo dos anos, permitindo identificar tendências de aumento ou diminuição do desmatamento nesse período. Observou-se que houve uma tendência de aumento de desmatamento no bioma **Cerrado**: em 2000, a área total desmatada era de **705759.52 km²**, enquanto em 2022 esse número subiu para **1006135.5 km²**.

## Pergunta 4: Qual é a média de desmatamento anual por bioma?
A consulta foi realizada em duas etapas. Primeiramente, uma subconsulta soma o desmatamento por bioma e ano, resultando em um total para cada bioma em cada ano. Em seguida, a consulta principal calcula a média (AVG) do desmatamento anual para cada bioma com base nos resultados da subconsulta, agrupando-os e ordenando-os em ordem decrescente da média de desmatamento anual. O resultado final permite comparações entre os biomas. A média anual de desmatamento por bioma, da maior para a menor, é:
- **Cerrado** - 892174.5 km²
- **Mata Atlântica** - 769201.2 km²
- **Amazônia** - 655081.9 km²
- **Caatinga** - 328005.9 km²
- **Pampa** - 99784.8 km²
- **Pantanal** - 22733.6 km²

## Pergunta 5: Quais municípios apresentaram aumento no desmatamento em um ano específico?
A consulta foi dividida em duas subconsultas. A subconsulta m1 soma o desmatamento para cada município em 2020, enquanto a subconsulta m2 faz o mesmo para 2019. As duas subconsultas são unidas com base no id_municipio, e a condição `WHERE m1.desmatado > m2.desmatado` filtra os municípios onde o desmatamento em 2020 foi maior que em 2019. Os resultados são, então, ordenados em ordem decrescente pelo desmatamento atual em 2020. O resultado final fornece uma lista dos municípios que aumentaram o desmatamento de um ano para o outro; nesse caso, cerca de **50 municípios** apresentaram esse aumento.

## Pergunta 6: Qual bioma teve o menor desmatamento em um determinado ano?
Nesta consulta, foi calculada a soma do desmatamento (SUM(desmatado)) para cada bioma no ano de **2019**. Os resultados foram agrupados por bioma e ordenados em ordem crescente de desmatamento total (ORDER BY total_desmatado ASC), de forma a destacar os biomas com menor desmatamento. O uso de `LIMIT 1` garante que apenas o bioma com o menor desmatamento seja retornado. Em 2019, o bioma com o menor desmatamento foi o **Pantanal**, com **27377.1 km²** desmatados.

## Pergunta 7: Qual a distribuição do desmatamento por bioma em um gráfico?
Nessa consulta, foi calculada a soma total do desmatamento (SUM(desmatado)) para cada bioma, agrupando os dados por bioma e ordenando-os em ordem decrescente de desmatamento total. O resultado fornece os dados necessários para criar um gráfico que mostre a distribuição do desmatamento por bioma, facilitando a visualização de quais biomas são mais impactados. O gráfico resultante da consulta encontra-se no mesmo repositório.

## Pergunta 8: Quais municípios tiveram a maior área desmatada no último ano disponível?
Nesta consulta, foi identificada a lista dos municípios que tiveram a maior área desmatada no último ano disponível. A subconsulta determina qual é o ano mais recente presente nos dados, e a consulta principal calcula a soma total do desmatamento (SUM(desmatado)) para cada município nesse ano. Os dados são agrupados por id_municipio e ordenados em ordem decrescente de desmatamento total. O uso de `LIMIT 3` garante que apenas os três municípios com maior desmatamento sejam retornados. No último ano disponível, os 3 municípios com maior área desmatada foram **'5007109'**, **'1100205'** e **'1500602'**.
