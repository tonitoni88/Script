use e_commercetdgroup;
INSERT INTO indirizzo (Via, Civico, CodicePostale, Città, Nazione)
VALUES ('Via Roma', '123', '00100', 'Roma', 'Italia');
INSERT INTO cliente (nome, cognome, codiceFiscale, iban, email, numeroTelefono, id_indirizzo)
VALUES ('Antonio', 'Aloia', 'ALOANT01H12H501A', 'IT60X0542811101000000123456', 'antonio.aloia@gmail.com', 1234567890, 1);
INSERT INTO fornitori (Nome, SedeLegale, NazioneSede, PartitaIVA, Email, Telefono)
VALUES ('Nike', 'Via della Vittoria 1', 'Italia', '01234567890', 'info@nike.com', 9876543210);
INSERT INTO prodotto (Nome, Descrizione, Costo, Provenienza, CostoScontato, Quantita, Disponibilita, ID_Fornitore)
VALUES ('Air Force', 'Scarpe sportive Nike Air Force', 100.00, 'Stati Uniti', NULL, 50, 1, 1);
INSERT INTO ordine (DataoraOrdine, ID_Cliente, IndirizzoSpedizione, NumeroTracciamento)
VALUES (NOW(), 1, 'Via Roma 123, 00100, Roma, Italia', 'TRACCIAMENTO123');
INSERT INTO ordine_prodotto (ID_Ordine, ID_Prodotto, QuantitaAcquistata)
VALUES (1, 1, 1);