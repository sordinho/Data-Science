-- Selezionare per ogni data del mese di luglio 2003 l’incasso totale, e la media giornaliera degli incassi
-- delle chiamate effettuate negli ultimi tre giorni.

SELECT DATA,
       SUM(PREZZO),
       AVG( SUM(PREZZO)) over (ORDER BY DATA ROWS 2 PRECEDING )
FROM FATTI F,
    TEMPO TP
WHERE F.ID_TEMPO = TP.ID_TEMPO
  AND ANNO = 2003
  AND MESE = '7-2003'
GROUP BY DATA
ORDER BY DATA