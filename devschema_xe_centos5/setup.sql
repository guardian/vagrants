create tablespace delivery_data datafile 'tbs_delivery_data.dbf' size 10M autoextend on;

create user local identified by local default tablespace delivery_data quota unlimited on delivery_data temporary tablespace temp;
  
grant create session to local;
grant create type to local;
grant create sequence to local;
grant create table to local;
grant create view to local;
grant create procedure to local;

quit;
/