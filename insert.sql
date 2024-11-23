-- Hogy lehessen többször futtatni -- 
DELETE FROM tagsag;
DELETE FROM egyesulet;
DELETE FROM ember;
INSERT INTO ember (szuletesdatum, nev) VALUES('1946-12-01', "Tamás Evelin");
INSERT INTO ember (szuletesdatum, nev) VALUES('1980-06-18', "Bálint Olívia");
INSERT INTO ember (szuletesdatum, nev) VALUES('1990-01-30', "Kozma Ottó");
INSERT INTO ember (szuletesdatum, nev) VALUES('1981-09-27', "Juhász András");
INSERT INTO ember (szuletesdatum, nev) VALUES('1975-05-13', "Török Gábor");

INSERT INTO egyesulet (alapitasev, alapitoid, tagdij, nev) VALUES ('1980', (SELECT emberid FROM ember WHERE nev='Török Gábor'), 3000, 'Informatikusok Országos Szövetsége');
INSERT INTO egyesulet (alapitasev, alapitoid, tagdij, nev) VALUES ('2010', (SELECT emberid FROM ember WHERE nev='Juhász András'), 4500, 'PHP programozók társasága');
INSERT INTO egyesulet (alapitasev, alapitoid, tagdij, nev) VALUES ('2017', (SELECT emberid FROM ember WHERE nev='Bálint Olívia'), 2700, 'CSS kedvelők szövetsége');
INSERT INTO egyesulet (alapitasev, alapitoid, tagdij, nev) VALUES ('2001', (SELECT emberid FROM ember WHERE nev='Kozma Ottó'), 5000, 'SQL adatbázist használók egyesülete');

-- alapítók --
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='Informatikusok Országos Szövetsége'),
        (SELECT emberid FROM ember WHERE nev='Török Gábor'),
        '1980'
);
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='PHP programozók társasága'),
        (SELECT emberid FROM ember WHERE nev='Juhász András'),
        '2010'
);
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='CSS kedvelők szövetsége'),
        (SELECT emberid FROM ember WHERE nev='Bálint Olívia'),
        '2017'
);
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='SQL adatbázist használók egyesülete'),
        (SELECT emberid FROM ember WHERE nev='Kozma Ottó'),
        '2001'
);

-- tagok --
-- Informatikusok országos szövetsége --
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='Informatikusok Országos Szövetsége'),
        (SELECT emberid FROM ember WHERE nev='Tamás Evelin'),
        '1981'
);
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='Informatikusok Országos Szövetsége'),
        (SELECT emberid FROM ember WHERE nev='Bálint Olívia'),
        '1990'
);

-- PHP programozók társasága --
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='PHP programozók társasága'),
        (SELECT emberid FROM ember WHERE nev='Tamás Evelin'),
        '2012'
);

-- CSS kedvelők szövetséges
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='CSS kedvelők szövetsége'),
        (SELECT emberid FROM ember WHERE nev='Kozma Ottó'),
        '2014'
);
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='CSS kedvelők szövetsége'),
        (SELECT emberid FROM ember WHERE nev='Juhász András'),
        '2019'
);
INSERT INTO tagsag (egyesulet_egyesuletid, ember_emberid, csatlakozas) 
    VALUES (
        (SELECT egyesuletid FROM egyesulet WHERE nev='CSS kedvelők szövetsége'),
        (SELECT emberid FROM ember WHERE nev='Tamás Evelin'),
        '2020'
);

SELECT * FROM ember;
SELECT * FROM egyesulet;
SELECT * FROM tagsag;