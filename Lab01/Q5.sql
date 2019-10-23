-- Selezionare per ogni mese, l'incasso del mese e l’incasso cumulativo dall’inizio dell’anno.

SELECT MESE, ANNO, SUM(PREZZO), SUM(SUM(PREZZO)) over (PARTITION BY ANNO ORDER BY MESE ROWS UNBOUNDED PRECEDING )
FROM FATTI F,
     TEMPO TP
WHERE F.ID_TEMPO = TP.ID_TEMPO
GROUP BY MESE, ANNO
-- ORDER BY MESE
