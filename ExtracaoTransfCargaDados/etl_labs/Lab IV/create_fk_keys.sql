ALTER TABLE `datawarehouse_olap`.`fato_pedidos` 
ADD PRIMARY KEY (`fk_cliente`, `fk_produto`, `fk_regiao`, `fk_tempo`, `fk_vendedor`),
ADD INDEX `fk_vendedor_idx` (`fk_vendedor` ASC) VISIBLE,
ADD INDEX `fk_tempo_idx` (`fk_tempo` ASC) VISIBLE,
ADD INDEX `fk_regiao_idx` (`fk_regiao` ASC) VISIBLE,
ADD INDEX `fk_produto_idx` (`fk_produto` ASC) VISIBLE;
;
ALTER TABLE `datawarehouse_olap`.`fato_pedidos` 
ADD CONSTRAINT `fk_cliente`
  FOREIGN KEY (`fk_cliente`)
  REFERENCES `datawarehouse_olap`.`dim_cliente` (`fk_cliente`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_produto`
  FOREIGN KEY (`fk_produto`)
  REFERENCES `datawarehouse_olap`.`dim_produto` (`fk_produto`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_regiao`
  FOREIGN KEY (`fk_regiao`)
  REFERENCES `datawarehouse_olap`.`dim_regiao` (`fk_regiao`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_tempo`
  FOREIGN KEY (`fk_tempo`)
  REFERENCES `datawarehouse_olap`.`dim_tempo` (`fk_tempo`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION,
ADD CONSTRAINT `fk_vendedor`
  FOREIGN KEY (`fk_vendedor`)
  REFERENCES `datawarehouse_olap`.`dim_vendedor` (`fk_vendedor`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;