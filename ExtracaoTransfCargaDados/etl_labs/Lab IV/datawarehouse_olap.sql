drop database IF exists datawarehouse_olap;

#
# Bases de dados OLAP para Treinamento Pentaho CE
#

CREATE DATABASE  `datawarehouse_olap` ;

USE `datawarehouse_olap`;


CREATE TABLE `dim_cliente` (
  `fk_cliente` int(8) NOT NULL,
  `cod_cliente` int(8) default NULL,
  `nome` varchar(50) default NULL,
  `telefone` varchar(100) default NULL,
  `sexo` varchar(9)  default NULL,
  `estado_civil` varchar(20) default NULL,
  `endereco` varchar(40)  default NULL,
  `data_inicial` date default NULL,
  `data_final` date default NULL,
  `versao` int(10) default NULL,
  PRIMARY KEY  (`fk_cliente`)
) ENGINE=InnoDB;



CREATE TABLE `dim_produto` (
  `fk_produto` int(8) NOT NULL,
  `codigo_produto` int(8) default NULL,
  `descricao` varchar(30) default NULL,
  `linha` varchar(30)  default NULL,
  `fornecedor` varchar(50)  NOT NULL,
  PRIMARY KEY  (`fk_produto`)
) ENGINE=InnoDB;


CREATE TABLE `dim_regiao` (
  `fk_regiao` int(8) NOT NULL,
  `cidade` varchar(50) default NULL,
  `estado` varchar(2) default NULL,
  `regiao` varchar(20)default NULL,
  PRIMARY KEY  (`fk_regiao`)
) ENGINE=InnoDB;


CREATE TABLE `dim_tempo` (
  `fk_tempo` int(11) NOT NULL,
  `mes` int(8) default NULL,
  `trimestre` int(8) default NULL,
  `ano` int(8) default NULL,
  `data` date default NULL,
  `descmes` varchar(3) default NULL,
  PRIMARY KEY  (`fk_tempo`)
) ENGINE=InnoDB;


CREATE TABLE  `dim_vendedor` (
  `fk_vendedor` int(8) NOT NULL,
  `vendedor` varchar(20) default NULL,
  `vlr_comissao` double default NULL,
  `cod_vendedor` int(8) default NULL,
  PRIMARY KEY  (`fk_vendedor`)
) ENGINE=InnoDB ;


CREATE TABLE `fato_pedidos` (
  `fk_cliente` int(8) NOT NULL,
  `fk_produto` int(11) NOT NULL,
  `fk_regiao` int(11) NOT NULL,
  `fk_tempo` int(8) NOT NULL,
  `fk_vendedor` int(8) NOT NULL,
  `qtd_venda` int(8) NOT NULL,
  `vlr_venda` float(17,0) NOT NULL
) ENGINE=InnoDB;
