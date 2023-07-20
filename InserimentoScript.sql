USE ecommercetdnuovo;
INSERT INTO Fornitore (Nome, Sede_Legale, Nazione_Sede)
VALUES
	('bb', 'Sbbba', 'rm'),
    ('cc', 'Se', 'pp'),
    ('sd', 'Legale', 'rm');

INSERT INTO indirizzo (Via, Civico, Codice_Postale, Citta, Nazione, Citofono, Indirizzo_di_residenza)
VALUES 
    ('Via 1', '1', '00100', 'Roma', 'Italia', 'CITOFOewq', 'Residenza Principale'),
    ('Via 2', '2', '00100', 'Roma', 'Italia', 'CITOFwq', 'Ufficio'),
    ('Via 3', '3', '00100', 'Roma', 'Italia', 'CITOFq', 'Altro Indirizzo');

INSERT INTO cliente (Nome, Cognome, Codice_Fiscale, Iban, ID_Indirizzo)
VALUES
    ('Cliente 1', 'Cognome 1', 'ABC12345', 'IT0123456789012345678901234', 77),
    ('Cliente 2', 'Cognome 2', 'DEF23456', 'IT1234567890123456789012345', 78),
    ('Cliente 3', 'Cognome 3', 'GHI34567', 'IT2345678901234567890123456', 79);
    
INSERT INTO prodotto (Nome, Descrizione, Costo, Provenienza, Costo_Scontato, ID_Fornitore, Quantita, ID_Cliente)
VALUES
    ('Prodotto 1', 'Descrizione Prodotto 1', 50.00, 'Provenienza 1', 45.00, 1, 10, NULL),
    ('Prodotto 2', 'Descrizione Prodotto 2', 30.00, 'Provenienza 2', 27.00, 2, 5, NULL),
    ('Prodotto 3', 'Descrizione Prodotto 3', 25.00, 'Provenienza 3', 22.50, 2, 8, NULL);

INSERT INTO ordine (Dataora_Ordine, Totale_Ordine, Storno, Pagato, ID_Cliente)
VALUES
    ('2023-07-20 10:00:00', 100.00, 0, 1, 7),
    ('2023-07-20 11:00:00', 150.00, 0, 1, 8),
    ('2023-07-20 12:00:00', 200.00, 1, 0, 7);

INSERT INTO ordine_prodotto (ID_Ordine, ID_Prodotto, Quantita, ImportoTotale)
VALUES
    (1, 2, 2, 90.00),
    (2, 1, 3, 81.00);

