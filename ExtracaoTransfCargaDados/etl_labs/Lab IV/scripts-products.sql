drop database IF exists prodgames;

CREATE DATABASE prodgames
  CHARACTER SET utf8
  COLLATE utf8_general_ci;

USE prodgames;

#-------------------------------------------------------------
#DROP TABLES
#-------------------------------------------------------------

drop table IF EXISTS invoices_detail;
drop table IF EXISTS invoices;
drop table IF EXISTS customers;
drop table IF EXISTS cities;
drop table IF EXISTS countries;
drop table IF EXISTS payment_methods;
drop table IF EXISTS buy_methods;
drop table IF EXISTS products;
drop table IF EXISTS manufactures;

#-------------------------------------------------------------
#Tabela - manufactures
#-------------------------------------------------------------

CREATE TABLE manufactures
  (
    man_code  varchar(3)    not null,
    man_desc  varchar(25)   not null,

    CONSTRAINT pk_manufactures_1 primary key(man_code)
  );

CREATE INDEX ix_manufactures_1 ON manufactures(man_code);

#-------------------------------------------------------------
#Tabela - products
#-------------------------------------------------------------

CREATE TABLE products
  (
    pro_code         varchar(8)      not null,
    man_code         varchar(3)      not null,
    pro_name         varchar(255),
    pro_description  varchar(4000),
    pro_type         varchar(10),
    pro_theme        varchar(50),
    pro_pieces       integer,
    pro_packaging    varchar(20),
    pro_shape        varchar(20),
    pro_style        varchar(20),
    pro_buy_price    numeric(6,2),
    pro_sel_price    numeric(6,2),
    pro_stock        integer,
    pro_stock_min    integer,
    pro_stock_max    integer,

    CONSTRAINT pk_products_1 primary key(pro_code,man_code),

    CONSTRAINT fk_products_1 foreign key(man_code) references manufactures(man_code)
  );

CREATE INDEX ix_products_1 ON products(pro_code,man_code);
CREATE INDEX ix_products_2 ON products(man_code);

#-------------------------------------------------------------
#Tabela - buy_methods
#-------------------------------------------------------------

CREATE TABLE buy_methods
  (
    buy_code  varchar(4)    not null,
    buy_desc  varchar(25)   not null,

    CONSTRAINT pk_buy_methods_1 primary key(buy_code)
  );

CREATE INDEX ix_buy_methods_1 ON buy_methods(buy_code);

#-------------------------------------------------------------
#Tabela - payment_methods
#-------------------------------------------------------------

CREATE TABLE payment_methods
  (
    pay_code  varchar(4)    not null,
    pay_desc  varchar(25)   not null,

    CONSTRAINT pk_payment_methods_1 primary key(pay_code)
  );

CREATE INDEX ix_payment_methods_1 ON payment_methods(pay_code);

#-------------------------------------------------------------
#Tabela - countries
#-------------------------------------------------------------

CREATE TABLE countries
  (
    cou_id        integer       not null,
    country_name  varchar(30)   not null,

    CONSTRAINT pk_countries_1 primary key(cou_id)
  );

CREATE INDEX ix_countries_1 ON countries(cou_id);

#-------------------------------------------------------------
#Tabela - cities
#-------------------------------------------------------------

CREATE TABLE cities
  (
    city_id    integer       not null,
    city_name  varchar(30)   not null,
    cou_id     integer       not null,

    CONSTRAINT pk_cities_1 primary key(city_id),

    CONSTRAINT fk_cities_1 foreign key(cou_id) references countries(cou_id)
  );

CREATE INDEX ix_cities_1 ON cities(city_id);
CREATE INDEX ix_cities_2 ON cities(cou_id);

#-------------------------------------------------------------
##Tabela - customers
#-------------------------------------------------------------

CREATE TABLE customers
  (
    cus_id        integer       not null,
    cus_name      varchar(30)   not null,
    cus_lastname  varchar(30),
    add_street    varchar(50),
    add_zipcode   varchar(10),
    city_id       integer       not null,

    CONSTRAINT pk_customers_1 primary key(cus_id),

    CONSTRAINT fk_customers_1 foreign key(city_id) references cities(city_id)
  );

CREATE INDEX ix_customers_1 ON customers(cus_id);
CREATE INDEX ix_customers_2 ON customers(city_id);

#-------------------------------------------------------------
#Tabela - invoices
#-------------------------------------------------------------

CREATE TABLE invoices
  (
    invoice_number  integer        not null,
    pay_code        varchar(4)     not null,
    cus_id          integer        not null,
    buy_code        varchar(4)     not null,
    inv_date        date           not null,
    inv_price       numeric(8,2)   not null,

    CONSTRAINT pk_invoices_1 primary key(invoice_number,pay_code,cus_id),

    CONSTRAINT fk_invoices_1 foreign key(pay_code) references payment_methods(pay_code),
    CONSTRAINT fk_invoices_2 foreign key(cus_id) references customers(cus_id),
    CONSTRAINT fk_invoices_3 foreign key(buy_code) references buy_methods(buy_code)
  );

CREATE INDEX ix_invoices_1 ON invoices(invoice_number,pay_code,cus_id);
CREATE INDEX ix_invoices_2 ON invoices(pay_code);
CREATE INDEX ix_invoices_3 ON invoices(cus_id);
CREATE INDEX ix_invoices_4 ON invoices(buy_code);

#-------------------------------------------------------------
#Tabela - invoices_detail
#-------------------------------------------------------------

CREATE TABLE invoices_detail
  (
    invoice_number  integer        not null,
    linenr          integer        not null,
    pay_code        varchar(4)     not null,
    cus_id          integer        not null,
    pro_code        varchar(8)     not null,
    man_code        varchar(3)     not null,
    cant_prod       integer,
    price_unit      numeric(6,2),
    price           numeric(8,2),

    CONSTRAINT pk_invoices_detail_1 primary key(invoice_number,linenr,pay_code,cus_id,pro_code,man_code),

    CONSTRAINT fk_invoices_detail_1 foreign key(invoice_number,pay_code,cus_id) references invoices(invoice_number,pay_code,cus_id),
    CONSTRAINT fk_invoices_detail_2 foreign key(pro_code,man_code) references products(pro_code,man_code)
  );

CREATE INDEX ix_invoices_detail_1 ON invoices_detail(invoice_number,linenr,pay_code,cus_id,pro_code,man_code);
CREATE INDEX ix_invoices_detail_2 ON invoices_detail(invoice_number,pay_code,cus_id);
CREATE INDEX ix_invoices_detail_3 ON invoices_detail(pro_code,man_code);