-- On/Off telephone state change

CREATE OR REPLACE TRIGGER onOff
    AFTER INSERT
    ON STATE_CHANGE
    FOR EACH ROW
    WHEN (NEW.CHANGETYPE = 'O' OR NEW.CHANGETYPE = 'F')
DECLARE
    DELTA_PHONE NUMBER;

BEGIN
    IF :NEW.CHANGETYPE = 'O' THEN
        -- TELEPHONE POWER ON => INSERT
        INSERT INTO TELEPHONE (PHONENO, X, Y, PHONESTATE) VALUES (:NEW.PHONENO, :NEW.X, :NEW.Y, 'ON');
        DELTA_PHONE := 1;
    ELSE
        -- TELEPHONE POWER OFF => DELETE
        DELETE FROM TELEPHONE WHERE TELEPHONE.PHONENO = :NEW.PHONENO;
        DELTA_PHONE := -1;
    end if;

    -- UPDATE PHONE# FOR THIS CELL
    UPDATE CELL
    SET CURRENTPHONE# = CURRENTPHONE# + DELTA_PHONE
    WHERE X0 <= :NEW.X
      AND :NEW.X <= X1
      AND Y0 <= :NEW.Y
      AND :NEW.Y <= Y1;
end;
/