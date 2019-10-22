SELECT ANNO,
       TIPO_TARIFFA,
       SUM(PREZZO),
--        SUM(PREZZO) over () AS TOTALE
       SUM(PREZZO) over (PARTITION BY ANNO)         AS TOTANNO
--        SUM(PREZZO) over (PARTITION BY TIPO_TARIFFA) AS TOTTARIFFA
FROM FATTI F,
     TARIFFA TF,
     TEMPO TP
WHERE F.ID_TEMPO = TP.ID_TEMPO
  AND F.ID_TAR = TF.ID_TAR
GROUP BY ANNO, TIPO_TARIFFA