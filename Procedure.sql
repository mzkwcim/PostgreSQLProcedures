CREATE OR REPLACE FUNCTION OPIS_FILMU(p_id_filmu INTEGER) RETURNS VOID AS $$
DECLARE
    v_tytul_filmu TEXT;
    v_rok_produkcji_filmu TEXT;
    v_lista_aktorow TEXT;
BEGIN
    -- Pobierz tytuł filmu
    SELECT tytul INTO v_tytul_filmu
    FROM filmy
    WHERE id_filmu = p_id_filmu;

    -- Pobierz rok produkcji filmu
    SELECT rok_produkcji INTO v_rok_produkcji_filmu
    FROM filmy
    WHERE id_filmu = p_id_filmu;

    -- Pobierz listę aktorów
    SELECT STRING_AGG(imie || ' ' || nazwisko, ', ') INTO v_lista_aktorow
    FROM obsada AS o
    JOIN aktorzy AS a ON o.id_aktora = a.id_aktora
    WHERE o.id_filmu = p_id_filmu;

    -- Wyświetl opis filmu
    RAISE NOTICE 'Film "%", nakręcony w roku %, przy udziale aktorów: %', v_tytul_filmu, v_rok_produkcji_filmu, COALESCE(v_lista_aktorow, 'brak danych');
END;
$$ LANGUAGE PLPGSQL;
