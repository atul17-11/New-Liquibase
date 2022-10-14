--liquibase formatted sql

--changeset your.name:1 labels:example-label context:example-context
--comment: example comment
--create table person (
 --   id int identity(1,1) PRIMARY KEY,
  --  name varchar(50) not null,
  --  address1 varchar(50),
  --  address2 varchar(50),
   -- city varchar(30)
--)
--rollback DROP TABLE person;

--changeset your.name:2 labels:example-label context:example-context
--comment: example comment
--create table company (
 --   id int identity(1,1) PRIMARY KEY,
 --   name varchar(50) not null,
   -- address1 varchar(50),
    --address2 varchar(50),
    --city varchar(30)
--)
--rollback DROP TABLE company;

--changeset other.dev:3 labels:example-label context:example-context
--comment: example comment
--alter table person add column country varchar(2)
--rollback ALTER TABLE person DROP COLUMN country;
alter table person add column state varchar(2)

