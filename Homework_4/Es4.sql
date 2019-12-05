-- UPDATE MAX CALLS - 2

CREATE OR REPLACE TRIGGER minServiceGuarantee
    AFTER UPDATE OF MAXCALLS
    ON CELL
DECLARE
    MAX_CALLS NUMBER;

BEGIN
    SELECT SUM(MAXCALLS) INTO MAX_CALLS FROM CELL;
    IF MAX_CALLS < 30 THEN
        RAISE_APPLICATION_ERROR(-20123, 'MINIMUM SERVICE GUARANTEE CONSTRAINT VIOLATED');
    end if;
end;
