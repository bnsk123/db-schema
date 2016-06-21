--CREATE ROLE kloopzcm LOGIN ENCRYPTED PASSWORD 'md5bd21eadfdda4b653e92100ab7cf341d2'
--  SUPERUSER CREATEDB CREATEROLE
--   VALID UNTIL 'infinity';
--COMMENT ON ROLE kloopzcm IS 'user for config managemen system';

CREATE DATABASE cmsdb
  WITH ENCODING='UTF8'
       OWNER=cmsuser
       CONNECTION LIMIT=-1;


       CREATE ROLE authuser LOGIN
        PASSWORD '9EEm98T97k3LGz2Dqnc3'
        NOSUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;

       CREATE DATABASE authdb
        WITH OWNER = authuser
             ENCODING = 'UTF8'
             TABLESPACE = pg_default
             CONNECTION LIMIT = 1000;

       --oneops cms
       CREATE ROLE cmsuser LOGIN
        ENCRYPTED PASSWORD 'md571acb73bf30765bc33079aab2da50ba9'
        SUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;

       CREATE DATABASE cmsdb
        WITH OWNER = cmsuser
             ENCODING = 'UTF8'
             TABLESPACE = pg_default
             CONNECTION LIMIT = 1000;

       --activiti schema
       CREATE ROLE activitiuser LOGIN
        PASSWORD 'a5aKuCvZQichToqJ3xSi'
        NOSUPERUSER INHERIT CREATEDB CREATEROLE REPLICATION;

       CREATE DATABASE activitidb
        WITH OWNER = activitiuser
             ENCODING = 'UTF8'
             TABLESPACE = pg_default
             CONNECTION LIMIT = 1000;
