use provaleo;
CREATE TABLE `fornitore` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(30) NOT NULL,
  `sede_legale` varchar(50) NOT NULL,
  `nazione_sede` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
);
CREATE TABLE `prodotto` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(200) NOT NULL,
  `costo` decimal(10,2) NOT NULL,
  `provenienza` varchar(30) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `costo_scontato` decimal(10,2) DEFAULT NULL,
  `id_fornitore` int DEFAULT NULL,
  `quantità_prodotto` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id_fornitore` (`id_fornitore`),
  CONSTRAINT `prodotto_ibfk_1` FOREIGN KEY (`id_fornitore`) REFERENCES `fornitore` (`id`)
) ;
CREATE TABLE `indirizzo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `Via` varchar(255) NOT NULL,
  `Civico` varchar(10) NOT NULL,
  `CodicePostale` varchar(10) NOT NULL,
  `Città` varchar(100) NOT NULL,
  `Nazione` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ;
CREATE TABLE `cliente` (
  `codice_fiscale` varchar(16) NOT NULL,
  `nome` varchar(20) NOT NULL,
  `cognome` varchar(20) NOT NULL,
  `iban` varchar(34) NOT NULL,
  `id_indirizzo` int DEFAULT NULL,
  PRIMARY KEY (`codice_fiscale`),
  UNIQUE KEY `codice_fiscale_UNIQUE` (`codice_fiscale`),
  KEY `id_indirizzo` (`id_indirizzo`),
  CONSTRAINT `cliente_ibfk_1` FOREIGN KEY (`id_indirizzo`) REFERENCES `indirizzo` (`id`)
);
CREATE TABLE `ordine` (
  `id_ordine` int NOT NULL AUTO_INCREMENT,
  `dataora_ordine` datetime NOT NULL,
  `totale_ordine` decimal(10,2) NOT NULL DEFAULT '0.00',
  `storno` tinyint(1) NOT NULL,
  `pagato` tinyint(1) NOT NULL,
  `codice_fiscale_cliente` varchar(16) DEFAULT NULL,
  PRIMARY KEY (`id_ordine`),
  KEY `codice_fiscale_cliente` (`codice_fiscale_cliente`),
  CONSTRAINT `ordine_ibfk_1` FOREIGN KEY (`codice_fiscale_cliente`) REFERENCES `cliente` (`codice_fiscale`)
) ;
CREATE TABLE `ordine_prodotto` (
    `id_ordine` INT NOT NULL,
    `id_prodotto` INT NOT NULL,
    quantità INT DEFAULT NULL,
    PRIMARY KEY (id_ordine , id_prodotto),
    KEY id_prodotto (id_prodotto),
    CONSTRAINT ordine_prodotto_ibfk_1 FOREIGN KEY (id_ordine)
        REFERENCES ordine (id_ordine),
    CONSTRAINT ordine_prodotto_ibfk_2 FOREIGN KEY (id_prodotto)
        REFERENCES prodotto (id)
);
DELIMITER //
CREATE TRIGGER calcola_totale_ordine
AFTER INSERT ON ordine_prodotto
FOR EACH ROW
BEGIN
  DECLARE totale DECIMAL(10, 2);
  
  SELECT SUM(prodotto.costo) INTO totale
  FROM prodotto
  WHERE prodotto.id IN (SELECT id_prodotto FROM ordine_prodotto WHERE id_ordine = NEW.id_ordine);
  
  UPDATE ordine SET totale_ordine = totale WHERE id_ordine = NEW.id_ordine;
END;
//
DELIMITER ;

insert into fornitore(nome,sede_legale,nazione_sede) VALUES ('Mondo Inc.','Milano','Italia');

insert into prodotto(descrizione,costo,provenienza,nome,id_fornitore,quantità_prodotto) VALUES ('Palla da Calcio',9.99,'Italia','Palla Mondo',1,200);

insert into indirizzo(Via,Civico,CodicePostale,Città,Nazione) VALUES ('Piazzale Montesquieu 28','28','00137','Roma','Italia');

insert into cliente(codice_fiscale,nome,cognome,iban,id_indirizzo) VALUES ('XYZJKL12M34N567P','Leonardo','di Manzano','DE89370400440532013000',1);

insert into ordine(dataora_ordine,storno,pagato,codice_fiscale_cliente) VALUES ('2023-07-19 15:30:45',0,1,'XYZJKL12M34N567P');

insert into ordine_prodotto(id_ordine,id_prodotto,quantità) VALUES (1,1,1);
