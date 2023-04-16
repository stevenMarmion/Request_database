-- A décommenter si vous créez la BD sur un serveur dont vous êtes administrateur
-- CREATE DATABASE IF NOT EXISTS `VAE` DEFAULT CHARACTER SET UTF8 COLLATE utf8_general_ci;
-- USE `VAE`;

CREATE TABLE `CATEGORIE` (
  `idcat` decimal(3,0),
  `nomcat` varchar(50),
  PRIMARY KEY (`idcat`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `ENCHERIR` (
  `idut` decimal(6,0),
  `idve` decimal(8,0),
  `dateheure` datetime,
  `montant` decimal(8,2),
  PRIMARY KEY (`idut`, `idve`, `dateheure`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `OBJET` (
  `idob` decimal(6,0),
  `nomob` varchar(50),
  `descriptionob` text,
  `idut` decimal(6,0),
  `idcat` decimal(3,0),
  PRIMARY KEY (`idob`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `PHOTO` (
  `idph` decimal(6,0),
  `titreph` varchar(50),
  `imgph` blob,
  `idob` decimal(6,0),
  PRIMARY KEY (`idph`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `ROLE` (
  `idrole` decimal(2,0),
  `nomrole` varchar(30),
  PRIMARY KEY (`idrole`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `STATUT` (
  `idst` char,
  `nomst` varchar(30),
  PRIMARY KEY (`idst`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `UTILISATEUR` (
  `idut` decimal(6,0),
  `pseudout` varchar(20) unique,
  `emailut` varchar(100),
  `mdput` varchar(100),
  `activeut` char(1),
  `idrole` decimal(2,0),
  PRIMARY KEY (`idut`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

CREATE TABLE `VENTE` (
  `idve` decimal(8,0),
  `prixbase` decimal(8,2),
  `prixmin` decimal(8,2),
  `debutve` datetime,
  `finve` datetime,
  `idob` decimal(6,0),
  `idst` char,
  PRIMARY KEY (`idve`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

ALTER TABLE `ENCHERIR` ADD FOREIGN KEY (`idve`) REFERENCES `VENTE` (`idve`);
ALTER TABLE `ENCHERIR` ADD FOREIGN KEY (`idut`) REFERENCES `UTILISATEUR` (`idut`);
ALTER TABLE `OBJET` ADD FOREIGN KEY (`idcat`) REFERENCES `CATEGORIE` (`idcat`);
ALTER TABLE `OBJET` ADD FOREIGN KEY (`idut`) REFERENCES `UTILISATEUR` (`idut`);
ALTER TABLE `PHOTO` ADD FOREIGN KEY (`idob`) REFERENCES `OBJET` (`idob`);
ALTER TABLE `UTILISATEUR` ADD FOREIGN KEY (`idrole`) REFERENCES `ROLE` (`idrole`);
ALTER TABLE `VENTE` ADD FOREIGN KEY (`idst`) REFERENCES `STATUT` (`idst`);
ALTER TABLE `VENTE` ADD FOREIGN KEY (`idob`) REFERENCES `OBJET` (`idob`);
