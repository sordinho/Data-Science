-- Selezionare l’incasso totale per ogni tipo tariffa e per ogni anno. Selezionare inoltre l'incasso totale
-- complessivo, l'incasso totale per ogni tipo di tariffa indifferentemente dall’anno, e l'incasso totale per
-- ogni anno indifferentemente dal tipo di tariffa.

SELECT ANNO,
       TIPO_TARIFFA,
       SUM(PREZZO),
       SUM(SUM(PREZZO)) over () AS TOTALE,
       SUM(SUM(PREZZO)) over (PARTITION BY ANNO)         AS TOTANNO,
       SUM(SUM(PREZZO)) over (PARTITION BY TIPO_TARIFFA) AS TOTTARIFFA
FROM FATTI F,
     TARIFFA TF,
     TEMPO TP
WHERE F.ID_TEMPO = TP.ID_TEMPO
  AND F.ID_TAR = TF.ID_TAR
GROUP BY ANNO, TIPO_TARIFFA;