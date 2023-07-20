USE ecommercetdnuovo;
CREATE TABLE `indirizzo` (
  `ID_Indirizzo` bigint NOT NULL AUTO_INCREMENT,
  `Via` varchar(100) DEFAULT NULL,
  `Civico` varchar(10) DEFAULT NULL,
  `Codice_Postale` varchar(10) DEFAULT NULL,
  `Citta` varchar(100) DEFAULT NULL,
  `Nazione` varchar(100) DEFAULT NULL,
  `Citofono` varchar(20) DEFAULT NULL,
  `Indirizzo_di_residenza` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID_Indirizzo`),
  UNIQUE KEY `Citofono` (`Citofono`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `fornitore` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) DEFAULT NULL,
  `Sede_Legale` varchar(200) DEFAULT NULL,
  `Nazione_Sede` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ;

CREATE TABLE `cliente` (
  `ID_Cliente` bigint NOT NULL AUTO_INCREMENT,
  `Nome` varchar(100) DEFAULT NULL,
  `Cognome` varchar(100) DEFAULT NULL,
  `Codice_Fiscale` varchar(16) DEFAULT NULL,
  `Iban` varchar(34) DEFAULT NULL,
  `ID_Indirizzo` bigint DEFAULT NULL,
  PRIMARY KEY (`ID_Cliente`),
  UNIQUE KEY `cliente_codice_fiscale_unique` (`Codice_Fiscale`),
  KEY `cliente_indirizzo_fk` (`ID_Indirizzo`),
  CONSTRAINT `cliente_indirizzo_fk` FOREIGN KEY (`ID_Indirizzo`) REFERENCES `indirizzo` (`ID_Indirizzo`)
) ;
CREATE TABLE `prodotto` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nome` varchar(50) DEFAULT NULL,
  `Descrizione` varchar(200) DEFAULT NULL,
  `Costo` decimal(10,2) DEFAULT NULL,
  `Provenienza` varchar(50) DEFAULT NULL,
  `Costo_Scontato` decimal(10,2) DEFAULT NULL,
  `ID_Fornitore` int DEFAULT NULL,
  `Quantita` int DEFAULT NULL,
  `ID_Cliente` bigint DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ID_Fornitore` (`ID_Fornitore`),
  KEY `prodotto_ibfk_2` (`ID_Cliente`),
  CONSTRAINT `prodotto_ibfk_2` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`)
) ;
CREATE TABLE `ordine_prodotto` (
  `ID_Ordine` bigint DEFAULT NULL,
  `ID_Prodotto` int NOT NULL,
  `Quantita` int DEFAULT NULL,
  `ImportoTotale` decimal(10,2) DEFAULT NULL,
  KEY `ID_Ordine` (`ID_Ordine`),
  KEY `ID_Prodotto` (`ID_Prodotto`),
  CONSTRAINT `ordine_prodotto_ibfk_2` FOREIGN KEY (`ID_Prodotto`) REFERENCES `prodotto` (`ID`)
) ;

CREATE TABLE `ordine` (
  `ID_ordine` bigint NOT NULL AUTO_INCREMENT,
  `Dataora_Ordine` datetime DEFAULT NULL,
  `Totale_Ordine` decimal(10,2) DEFAULT NULL,
  `Storno` int DEFAULT '0',
  `Pagato` int DEFAULT '0',
  `ID_Cliente` bigint DEFAULT NULL,
  PRIMARY KEY (`ID_ordine`),
  KEY `ordine_cliente_fk` (`ID_Cliente`),
  CONSTRAINT `ordine_cliente_fk` FOREIGN KEY (`ID_Cliente`) REFERENCES `cliente` (`ID_Cliente`)
) ;

