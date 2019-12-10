ALTER TABLE `datawarehouse_olap`.`fato_pedidos` 
DROP FOREIGN KEY `fk_vendedor`,
DROP FOREIGN KEY `fk_tempo`,
DROP FOREIGN KEY `fk_regiao`,
DROP FOREIGN KEY `fk_produto`,
DROP FOREIGN KEY `fk_cliente`;
ALTER TABLE `datawarehouse_olap`.`fato_pedidos` 
DROP INDEX `fk_produto_idx` ,
DROP INDEX `fk_regiao_idx` ,
DROP INDEX `fk_tempo_idx` ,
DROP INDEX `fk_vendedor_idx` ;

