-- Per ogni mese, selezionare il numero di chiamate totali e l'incasso totale. Utilizzando la funzione
-- RANK(), associare ad ogni mese un numero che identifica la posizione del mese all'interno dei mesi in
-- funzione dell'incasso totale effettuato (1 per il mese che ha incassato di più, 2 per il secondo mese,
-- ecc.)

SELECT MESE,
       SUM(CHIAMATE) AS NUM_CHIAMATE,
       SUM(PREZZO) AS TOT_MESE,
       RANK() over (ORDER BY SUM(PREZZO) DESC )
FROM TEMPO TP,
     FATTI F
WHERE TP.ID_TEMPO = F.ID_TEMPO
GROUP BY MESE;