CREATE OR REPLACE TRIGGER GaranziaDelServizio
AFTER UPDATE OF MAXCALLS ON CELL
DECLARE
maxCalls NUMBER;
BEGIN
    SELECT COUNT(*) INTO maxCalls
    FROM CELL;
    IF maxCalls < 30 THEN
        RAISE_APPLICATION_ERROR(-20900,'MaxCalls troppo piccolo');
    end if;
end;