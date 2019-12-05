CREATE OR REPLACE TRIGGER InizioTelefonata
    AFTER INSERT
    ON STATE_CHANGE
    FOR EACH ROW
    WHEN (NEW.CHANGETYPE = 'C')
DECLARE
    activeCalls NUMBER;
    maxCalls    NUMBER;
    cellID      NUMBER;
    x0          NUMBER;
    x1          NUMBER;
    y0          NUMBER;
    y1          NUMBER;
    maxExId     NUMBER;

BEGIN
    SELECT CELLID, MAXCALLS, X0, X1, Y0, Y1
    INTO cellID, maxCalls, x0, x1, y0, y1
    FROM STATE_CHANGE,
         CELL
    WHERE X < X1
      AND X >= X0
      AND Y < Y1
      AND Y >= Y0;

    SELECT COUNT(*)
    INTO activeCalls
    FROM TELEPHONE
    WHERE X < x1
      AND X >= x0
      AND Y < y1
      AND Y >= y0
      AND PHONESTATE = 'Active';

    IF activeCalls < maxCalls THEN
        UPDATE TELEPHONE SET TELEPHONE.PHONESTATE = 'Active' WHERE TELEPHONE.PHONENO = :NEW.PHONENO;
    ELSE
        SELECT COUNT(*)
        INTO maxExId
        FROM EXCEPTION_LOG
        WHERE CELLID = cellID;

        INSERT INTO EXCEPTION_LOG(EXID, CELLID, EXCEPTIONTYPE) VALUES (maxExId + 1, cellID, 'A');
    end if;
end;