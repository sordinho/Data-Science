-- UPDATE MAX CALLS - 1

CREATE OR REPLACE TRIGGER maxCallsUpdate
    BEFORE UPDATE
    OF MAXCALLS ON CELL
    FOR EACH ROW
DECLARE
    ACTIVE_CALLS NUMBER;

BEGIN
    -- SELECT ACTIVE CALLS IN CELL
    SELECT COUNT(*)
    INTO ACTIVE_CALLS
    FROM TELEPHONE
    WHERE PHONESTATE = 'ACTIVE'
      AND :NEW.X0 <= X
      AND X <= :NEW.X1
      AND :NEW.Y0 <= Y
      AND Y <= :NEW.Y1;

    -- CHECK ACTIVE CALL <=MAX_CALLS
    IF (:NEW.MAXCALLS < ACTIVE_CALLS) THEN
        :NEW.MAXCALLS := ACTIVE_CALLS;
    end if;
end;