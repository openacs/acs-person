-- packages/acs-person/sql/oracle/acs-person-drop.sql
--
-- @author jon@jongriffin.com
-- @creation-date 2002-09-25
-- @cvs-id $Id$

set server output on

--@@ acs-person-sc-drop.sql

-- drop sequence
drop sequence acs_persons_seq;

-- drop functions

drop package acs_person;

--drop permissions
delete from acs_permissions where object_id in (select acs_person_id from acs_persons);

-- drop the tables
drop table affix_type;
drop table affix_acs_persons_map;
drop table acs_persons_given_names;
drop table acs_persons_middle_names;
drop table acs_persons_family_names;
drop table acs_persons;


-- drop attributes and object types

execute acs_object_type.drop_type('acs_person','t');

show errors;