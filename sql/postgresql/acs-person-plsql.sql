-- packages/acs-person/sql/postgresql/acs-person-plsql.sql
--
-- @author jon@jongriffin.com
-- @creation-date 2002-09-21
-- @cvs-id $Id$

-- I don't use create or replace on these temp functions
-- because I want to have them explicitly deleted

create function inline_0 () 
returns integer as '  
begin 
    PERFORM acs_object_type__create_type (  
  ''acs_person'', -- object_type  
  ''ACS Person'', -- pretty_name 
  ''ACS Persons'', -- pretty_plural 
  ''acs_object'',   -- supertype 
  ''acs_persons'', -- table_name 
  ''acs_person_id'', -- id_column 
  null, -- package_name 
  ''f'', -- abstract_p 
  null, -- type_extension_table 
  null -- name_method 
  ); 
 
  return 0;  
end;' language 'plpgsql'; 

select inline_0 (); 

drop function inline_0 ();

create or replace function acs_person__new (varchar, varchar, varchar, varchar, varchar, 
integer,integer,varchar,integer)
returns integer as ' 
declare 
  p_given_name           alias for $1;
  p_middle_name          alias for $2; 
  p_family_name          alias for $3; 
  p_formatted_name       alias for $4;
  p_preferred_given_name alias for $5;
  p_user_id              alias for $6; -- this is not the creation user
  p_creation_user        alias for $7;
  p_creation_ip          alias for $8;
  p_context_id           alias for $9;
  v_acs_person_id acs_persons.acs_person_id%TYPE; 
begin 
  v_acs_person_id := acs_object__new (  
    null,  
    ''acs_person'', 
    now(), 
    p_creation_user, 
    p_creation_ip, 
    p_context_id 
  );   
  
  insert into acs_persons 
    ( acs_person_id,
      given_name,
      middle_name,
      family_name,
      formatted_name,
      preferred_given_name,
      user_id
     )
  values
    ( 
      v_acs_person_id,
      p_given_name, 
      p_middle_name,
      p_family_name, 
      p_formatted_name, 
      p_preferred_given_name,
      p_user_id
    );

  PERFORM acs_permission__grant_permission (
     v_acs_person_id,
     p_creation_user,
     ''admin''
  );

   raise NOTICE ''Adding acs_person - %'',v_acs_person_id;
  return v_acs_person_id;

end;' language 'plpgsql';


create or replace function acs_person__del (integer) 
returns integer as ' 
declare 
 p_acs_person_id    alias for $1; 
 v_return integer := 0;  
begin 

   delete from acs_permissions 
     where object_id = p_acs_person_id; 

   delete from acs_persons 
     where acs_person_id = p_acs_person_id;

   raise NOTICE ''Deleting acs_person - %'',p_acs_person_id;

   return v_return;

end;' language 'plpgsql';

create or replace function acs_person__set (varchar, varchar, varchar, varchar, varchar, 
    integer,integer) 
returns integer as ' 
declare 
  p_given_name           alias for $1;
  p_middle_name          alias for $2; 
  p_family_name          alias for $3; 
  p_formatted_name       alias for $4;
  p_preferred_given_name alias for $5;
  p_user_id              alias for $6; -- this is not the creation user
  p_acs_person_id        alias for $7; 
  v_return integer := 0; 
begin 

  update acs_persons
  set given_name           = p_given_name,
      middle_name          = p_middle_name,
      family_name          = p_family_name,      
      formatted_name       = p_formatted_name,
      preferred_given_name = p_preferred_given_name,
      user_id              = p_user_id
  where acs_person_id      = p_acs_person_id;

  raise NOTICE ''Updating acs persons %'',p_acs_person_id;

  return v_return;

end;' language 'plpgsql';

-- ancillary tables

create or replace function acs_person_given_name__set (varchar, varchar, varchar,integer)
returns integer as ' 
declare 
  p_acs_person_id    alias for $1; 
  p_extra_given_name alias for $2;
  p_sort_order       alias for $3;
  p_given_name_id    alias for $4;
  v_return integer := 0; 
begin 

  update acs_persons_given_name
  set   acs_person_id = p_acs_person_id,
        given_name    = p_given_name,
        sort_order    = p_sort_order
  where given_name_id = p_given_name_id

  raise NOTICE ''Updating given_names - %'',p_given_name;

return v_return;' language 'plpgsql';


