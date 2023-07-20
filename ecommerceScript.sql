use e_commercetdgroup;
CREATE TABLE `indirizzo` (
  `ID_Indirizzo`   bigint NOT NULL AUTO_INCREMENT,
  `Via` varchar(100) NOT NULL,
  `Civico` varchar(10) NOT NULL,
  `CodicePostale` varchar(10) NOT NULL,
  `Città` varchar(50) NOT NULL,
  `Nazione` varchar(50) NOT NULL,
  PRIMARY KEY (`ID_Indirizzo`)
);
CREATE TABLE `cliente` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nome` varchar(50) NOT NULL,
  `cognome` varchar(50) NOT NULL,
  `codiceFiscale` char(16) NOT NULL,
  `iban` char(27) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `numeroTelefono` bigint NOT NULL,
  `id_indirizzo` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `codiceFiscale` (`codiceFiscale`),
  UNIQUE KEY `email` (`email`),
  KEY `id_indirizzo` (`id_indirizzo`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzo` (`ID_Indirizzo`)
);
CREATE TABLE `fornitori` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) NOT NULL,
  `SedeLegale` varchar(100) NOT NULL,
  `NazioneSede` varchar(50) NOT NULL,
  `PartitaIVA` varchar(20) NOT NULL,
  `Email` varchar(100) NOT NULL,
  `Telefono` bigint DEFAULT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `PartitaIVA` (`PartitaIVA`),
  UNIQUE KEY `Email` (`Email`)
);
CREATE TABLE `ordine` (
  `ID_ordine` bigint NOT NULL AUTO_INCREMENT,
  `DataoraOrdine` datetime NOT NULL,
  `TotaleOrdine` decimal(10,2) NOT NULL DEFAULT '0.00',
  `Storno` tinyint(1) DEFAULT NULL,
  `Pagato` tinyint(1) DEFAULT NULL,
  `ID_Cliente` bigint NOT NULL,
  `IndirizzoSpedizione` varchar(100) NOT NULL,
  `NumeroTracciamento` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`ID_ordine`),
  UNIQUE KEY `NumeroTracciamento` (`NumeroTracciamento`),
  KEY `ID_Cliente` (`ID_Cliente`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`id`)
);
CREATE TABLE `prodotto` (
  `Id` bigint NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) NOT NULL,
  `Descrizione` varchar(100) NOT NULL,
  `Costo` decimal(10,2) NOT NULL,
  `Provenienza` varchar(50) NOT NULL,
  `CostoScontato` decimal(10,2) DEFAULT NULL,
  `Quantita` int NOT NULL,
  `Disponibilita` tinyint(1) NOT NULL,
  `ID_Fornitore` bigint DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `ID_Fornitore` (`ID_Fornitore`),
  CONSTRAINT `prodotto_ibfk_1` FOREIGN KEY (`ID_Fornitore`) REFERENCES `fornitori` (`Id`)
) ;
CREATE TABLE `ordine_prodotto` (
  `ID_Ordine` bigint NOT NULL,
  `ID_Prodotto` bigint NOT NULL,
  `QuantitaAcquistata` int NOT NULL,
  PRIMARY KEY (`ID_Ordine`,`ID_Prodotto`),
  KEY `ID_Prodotto` (`ID_Prodotto`),
  CONSTRAINT `ordine_prodotto_ibfk_1` FOREIGN KEY (`ID_Ordine`) REFERENCES `ordine` (`ID_ordine`),
  CONSTRAINT `ordine_prodotto_ibfk_2` FOREIGN KEY (`ID_Prodotto`) REFERENCES `prodotto` (`Id`)
);
DELIMITER $$

CREATE TRIGGER update_totale_ordine
AFTER INSERT ON ordine_prodotto
FOR EACH ROW
BEGIN
    DECLARE totale DECIMAL(10, 2);
    SET totale = 0;
    
  
    SELECT SUM(p.Costo * op.QuantitaAcquistata) INTO totale
    FROM prodotto p
    JOIN ordine_prodotto op ON p.Id = op.ID_Prodotto
    WHERE op.ID_Ordine = NEW.ID_Ordine;
    
   
    UPDATE ordine
    SET TotaleOrdine = totale
    WHERE ID_ordine = NEW.ID_Ordine;
END$$

DELIMITER ; 