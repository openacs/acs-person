-- packages/acs-person/sql/postgresql/acs-person-drop.sql
--
-- @author jon@jongriffin.com
-- @creation-date 2002-09-21
-- @cvs-id $Id$


\i acs-person-sc-drop.sql

-- drop sequence
drop sequence acs_persons_seq;

-- drop functions

drop function acs_person__new (varchar, varchar, varchar, varchar, varchar, 
integer,integer,varchar,integer);

drop function acs_person__del (integer);

drop function acs_person__set (varchar, varchar, varchar, varchar, varchar, 
integer,integer); 

--drop permissions
delete from acs_permissions where object_id in (select acs_person_id from acs_persons);

--drop objects
create function inline_0 ()
returns integer as '
declare
        object_rec   record;
begin
        for object_rec in select object_id from acs_objects where object_type=''acs_person''
        loop
                perform acs_object__delete( object_rec.object_id );
        end loop;

        return 0;
end;' language 'plpgsql';

select inline_0();
drop function inline_0();

-- drop the tables
drop table affix_type;
drop table affix_acs_persons_map;
drop table acs_persons_given_names;
drop table acs_persons_middle_names;
drop table acs_persons_family_names;
drop table acs_persons;


-- drop attributes and object types

select  acs_object_type__drop_type('acs_person','t');
