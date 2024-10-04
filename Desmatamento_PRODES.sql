SELECT * FROM `basedosdados.br_inpe_prodes.municipio_bioma` LIMIT 1000;

--Pergunta 1: Qual é a área total desmatada por bioma em um município específico?
SELECT
  bioma,
  SUM(desmatado) AS total_desmatado
FROM
  `basedosdados.br_inpe_prodes.municipio_bioma`
WHERE
  id_municipio = '2100709'
GROUP BY
  bioma
ORDER BY
  bioma;

-- Pergunta 2: Qual é o bioma com a maior área desmatada em um Município específico?
SELECT
  bioma,
  SUM(desmatado) AS total_desmatado
FROM
  `basedosdados.br_inpe_prodes.municipio_bioma`
WHERE
  id_municipio = '1707207'
GROUP BY
  bioma
ORDER BY
  total_desmatado DESC
LIMIT 1;

-- Pergunta 3: Qual foi a tendência de desmatamento ao longo dos anos em um bioma específico?
SELECT
  ano,
  SUM(desmatado) AS total_desmatado
FROM
  `basedosdados.br_inpe_prodes.municipio_bioma`
WHERE
  bioma = 'Cerrado'
GROUP BY
  ano
ORDER BY
  ano;

--Pergunta 4: Qual é a média de desmatamento anual por bioma?
SELECT
  bioma,
  AVG(desmatado) AS media_anual_desmatado
FROM (
  SELECT
    bioma,
    ano,
    SUM(desmatado) AS desmatado
  FROM
    `basedosdados.br_inpe_prodes.municipio_bioma`
  GROUP BY
    bioma, ano
) AS desmatamento_por_ano
GROUP BY
  bioma
ORDER BY
  media_anual_desmatado DESC;

-- Pergunta 5: Quais municípios apresentaram aumento no desmatamento em um ano específico?
SELECT
  m1.id_municipio,
  m1.desmatado AS desmatamento_atual,
  m2.desmatado AS desmatamento_anterior
FROM (
  SELECT
    id_municipio,
    SUM(desmatado) AS desmatado
  FROM
    `basedosdados.br_inpe_prodes.municipio_bioma`
  WHERE
    ano = 2020
  GROUP BY
    id_municipio
) AS m1
JOIN (
  SELECT
    id_municipio,
    SUM(desmatado) AS desmatado
  FROM
    `basedosdados.br_inpe_prodes.municipio_bioma`
  WHERE
    ano = 2019
  GROUP BY
    id_municipio
) AS m2
ON m1.id_municipio = m2.id_municipio
WHERE
  m1.desmatado > m2.desmatado
ORDER BY
  m1.desmatado DESC;

-- Pergunta 6: Qual bioma teve o menor desmatamento em um determinado ano?
SELECT
  bioma,
  SUM(desmatado) AS total_desmatado
FROM
  `basedosdados.br_inpe_prodes.municipio_bioma`
WHERE
  ano = 2019
GROUP BY
  bioma
ORDER BY
  total_desmatado ASC 
LIMIT 1;

--Pergunta 7: Qual a distribuição do desmatamento por bioma em um gráfico?
SELECT
  bioma,
  SUM(desmatado) AS total_desmatado
FROM
  `basedosdados.br_inpe_prodes.municipio_bioma`
GROUP BY
  bioma
ORDER BY
  total_desmatado DESC;

-- Pergunta 8: Quais municípios tiveram a maior área desmatada no último ano disponível?
SELECT
  id_municipio,
  SUM(desmatado) AS total_desmatado
FROM
  `basedosdados.br_inpe_prodes.municipio_bioma`
WHERE
  ano = (SELECT MAX(ano) FROM `basedosdados.br_inpe_prodes.municipio_bioma`)
GROUP BY
  id_municipio
ORDER BY
  total_desmatado DESC
LIMIT 3; 
