-- Selezionare per ogni mese dell’anno 2003 il numero di chiamate totali. Utilizzando la funzione RANK(),
-- associare ad ogni mese un numero che identifica la posizione del mese all'interno dei vari mesi
-- dell’anno 2003 in funzione del numero di chiamate totali (1 per il mese con più telefonate, 2 per il
-- secondo mese, ecc.)

SELECT MESE,
       SUM(CHIAMATE),
       RANK() over (ORDER BY SUM(CHIAMATE) DESC)
FROM FATTI F,
     TEMPO TP
WHERE F.ID_TEMPO = TP.ID_TEMPO
  AND ANNO = 2003
GROUP BY MESE;