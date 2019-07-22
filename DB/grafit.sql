DROP DATABASE IF EXISTS `grafit`;

CREATE DATABASE `grafit` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

use grafit;
DROP TABLE IF EXISTS `grafit`.`etichette`;
DROP TABLE IF EXISTS `grafit`.`fustelle_x_sagome`;
DROP TABLE IF EXISTS `grafit`.`fustelle`;
DROP TABLE IF EXISTS `grafit`.`sagome`;
DROP TABLE IF EXISTS `grafit`.`materiali`;
DROP TABLE IF EXISTS `grafit`.`frontali`;
DROP TABLE IF EXISTS `grafit`.`adesivi`;

CREATE TABLE `grafit`.`fustelle` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descrizione` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `unita_di_misura` ENUM('mm','cm','dm','mil','inch','hand'),
  `base` decimal(3,2) DEFAULT NULL,
  `altezza` decimal(3,2) DEFAULT NULL,
  `diametro_maggiore` decimal(3,2) DEFAULT NULL,
  `diametro_minore` decimal(3,2) DEFAULT NULL,
  `figura` polygon DEFAULT NULL,
  `aggiornato_al` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  KEY (`aggiornato_al`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`sagome` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipologia` enum('Rettangolo', 'Quadrato', 'Cerchio', 'Ellisse', 'Personalizzato') NOT NULL DEFAULT 'Rettangolo',
  `nome` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descrizione` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `aggiornato_al` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  KEY (`aggiornato_al`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`fustelle_x_sagome` (
  `id_sagoma` int(11) NOT NULL,
  `id_fustella` int(11) NOT NULL,
  `aggiornato_al` timestamp NULL DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP,
  KEY `aggiornato_al` (`aggiornato_al`),
  KEY `fk_fustelle_x_sagome_sagome_idx` (`id_sagoma`),
  KEY `fk_fustelle_x_sagome_fustelle_idx` (`id_fustella`),
  CONSTRAINT `fk_fustelle_x_sagome_fustelle` FOREIGN KEY (`id_fustella`) REFERENCES `grafit`.`fustelle` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_fustelle_x_sagome_sagome` FOREIGN KEY (`id_sagoma`) REFERENCES `grafit`.`sagome` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`frontali` (
  `id` int(11) NOT NULL  AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descrizione` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `aggiornato_al` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  KEY (`aggiornato_al`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`adesivi` (
  `id` int(11) NOT NULL  AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descrizione` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `aggiornato_al` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nome_UNIQUE` (`nome`),
  KEY (`aggiornato_al`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`materiali` (
  `id` int(11) NOT NULL  AUTO_INCREMENT,
  `descrizione` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `id_frontale` int(11) NOT NULL,
  `id_adesivo` int(11) NOT NULL,
  `codice_supporto` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `aggiornato_al` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY (`aggiornato_al`),
  KEY `fk_materiali_frontali_idx` (`id_frontale`),
  KEY `fk_materiali_adesivi_idx` (`id_adesivo`),
  CONSTRAINT `fk_materiali_frontali` FOREIGN KEY (`id_frontale`) REFERENCES `grafit`.`frontali` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_materiali_adesivi` FOREIGN KEY (`id_adesivo`) REFERENCES `grafit`.`adesivi` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`rese` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `formato` ENUM('Rotolo', 'Foglio', 'Piega'),
  `descrizione` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `aggiornato_al` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP,
   primary key
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`etichette` (
  `id` int(11) NOT NULL  AUTO_INCREMENT,
  `nome` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `descrizione` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci DEFAULT NULL,
  `id_sagoma` int(11) NOT NULL,
  `id_materiale` int(11) NOT NULL,
  `unita_di_misura` ENUM('mm','cm','dm','mil','inch','hand'),
  `diametro_anima` decimal(5,2) NOT NULL,
  `diametro_esterno` decimal(5,2) NOT NULL,
  `numero_etichette_x_rotolo` int(11) NOT NULL,
  `numero_rotoli_x_confezione` int(11) NOT NULL,
  `aggiornato_al` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
	ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY(`id`),
  KEY (`aggiornato_al`),
  KEY `fk_etichette_sagome_idx` (`id_sagoma`),
  KEY `fk_etichette_materiali_idx` (`id_materiale`),
  CONSTRAINT `fk_etichette_sagome` FOREIGN KEY (`id_sagoma`) REFERENCES `grafit`.`sagome`  (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_etichette_materiali` FOREIGN KEY (`id_materiale`) REFERENCES `grafit`.`materiali`  (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

CREATE TABLE `grafit`.`etichette_x_rese` (
  `id_etichetta` int(11) NOT NULL,
  `id_resa` int(11) NOT NULL,
  `aggiornato_al` timestamp NULL DEFAULT CURRENT_TIMESTAMP 
    ON UPDATE CURRENT_TIMESTAMP,
  KEY `aggiornato_al` (`aggiornato_al`),
  KEY `fk_etichette_x_rese_etichette_idx` (`id_sagoma`),
  KEY `fk_etichette_x_rese_rese_idx` (`id_fustella`),
  CONSTRAINT `fk_etichette_x_rese_etichette` FOREIGN KEY (`id_resa`) REFERENCES `grafit`.`etichetta` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_etichette_x_rese_rese` FOREIGN KEY (`id_etichetta`) REFERENCES `grafit`.`resa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
