-- packages/acs-person/sql/oracle/acs-person-plsql.sql
--
-- @author jon@jongriffin.com
-- @creation-date 2002-09-25
-- @cvs-id $Id$

begin 
  acs_object_type.create_type (  
    object_type   => 'acs_person',
    pretty_name   => 'ACS Person', 
    pretty_plural => 'ACS Persons', 
    supertype     => 'acs_object',
    table_name    => 'acs_persons',
    id_column     => 'acs_person_id'
  ); 
end;
/
show errors
 
create or replace package acs_person
as
    --
    --
    function new (
        acs_person_id           in acs_persons.acs_person_id%TYPE default null,
        family_name             in acs_persons.family_name%TYPE,
        given_name              in acs_persons.given_name%TYPE,
        middle_name             in acs_persons.middle_name%TYPE default null,
        formatted_name          in acs_persons.formatted_name%TYPE default null,
        preferred_given_name    in acs_persons.preferred_given_name%TYPE default null,
        user_id                 in acs_persons.user_id%TYPE default null
        object_type             in acs_objects.object_type%TYPE default 'acs_object',
        creation_date           in acs_objects.creation_date%TYPE default sysdate,
        creation_use            in acs_objects.creation_user%TYPE default null,
        creation_ip             in acs_objects.creation_ip%TYPE default null,
        context_id              in acs_objects.context_id%TYPE default null
    ) return acs_persons.acs_person_id%TYPE;
    --
    --
    procedure delete (
        acs_person_id in acs_persons.acs_person_id%TYPE
    );
    procedure set (
        acs_person_id           in acs_persons.acs_person_id%TYPE default null,
        family_name             in acs_persons.family_name%TYPE,
        given_name              in acs_persons.given_name%TYPE,
        middle_name             in acs_persons.middle_name%TYPE default null,
        formatted_name          in acs_persons.formatted_name%TYPE default null,
        preferred_given_name    in acs_persons.preferred_given_name%TYPE default null,
        user_id                 in acs_persons.user_id%TYPE default null
    ); 
    --
    -- 
end acs_person_id;
/
show errors


create or replace package body contact
as
    function new (
        acs_person_id           in acs_persons.acs_person_id%TYPE default null,
        family_name             in acs_persons.family_name%TYPE,
        given_name              in acs_persons.given_name%TYPE,
        middle_name             in acs_persons.middle_name%TYPE default null,
        formatted_name          in acs_persons.formatted_name%TYPE default null,
        preferred_given_name    in acs_persons.preferred_given_name%TYPE default null,
        user_id                 in acs_persons.user_id%TYPE default null
        object_type             in acs_objects.object_type%TYPE default 'acs_object',
        creation_date           in acs_objects.creation_date%TYPE default sysdate,
        creation_use            in acs_objects.creation_user%TYPE default null,
        creation_ip             in acs_objects.creation_ip%TYPE default null,
        context_id              in acs_objects.context_id%TYPE default null
    ) return acs_persons.acs_person_id%TYPE
    is
        v_acs_person_id acs_persons.acs_person_id%TYPE;
    begin
        v_acs_person_id := acs_object.new (
            object_id     => acs_person_id,
            object_type   => object_type,
            creation_date => creation_date,
            creation_user => creation_user,
            creation_ip   => creation_ip,
            context_id    => context_id
        );
        --
        insert into acs_persons
          ( acs_person_id, 
            family_name, 
            given_name, 
            middle_name, 
            formatted_name, 
            preferred_given_name
          )
        values
          ( v_acs_person_id, 
            family_name, 
            given_name, 
            middle_name, 
            formatted_name, 
            preferred_given_name);
	return v_acs_person_id;
    end new;
    --
    --
    procedure delete (
        acs_person_id in acs_persons.acs_person_id%TYPE
    )
    is
    begin
        delete from acs_persons
        where  acs_person_id = acs_person.delete.acs_person_id;
        --
        acs_object.delete(acs_person_id);
    end delete;
    --
    --
    procedure set (
        acs_person_id           in acs_persons.acs_person_id%TYPE default null,
        family_name             in acs_persons.family_name%TYPE,
        given_name              in acs_persons.given_name%TYPE,
        middle_name             in acs_persons.middle_name%TYPE default null,
        formatted_name          in acs_persons.formatted_name%TYPE default null,
        preferred_given_name    in acs_persons.preferred_given_name%TYPE default null,
        user_id                 in acs_persons.user_id%TYPE default null
    )
    is
    begin
      update acs_persons
      set 
        given_name           = p_given_name,
        middle_name          = p_middle_name,
        family_name          = p_family_name,      
        formatted_name       = p_formatted_name,
        preferred_given_name = p_preferred_given_name,
        user_id              = p_user_id
      where acs_person_id      = p_acs_person_id;

    end set;
    --
    --

end acs_person;
/
show errors

-- ancillary tables
begin 
  acs_object_type.create_type (  
    object_type   => 'acs_person_given_name',
    pretty_name   => 'ACS Person Given Name', 
    pretty_plural => 'ACS Person Given Names', 
    supertype     => 'acs_object',
    table_name    => 'acs_person_given_name',
    id_column     => 'given_name_id'
  ); 
end;
/
show errors

create or replace package acs_person_given_name
as
    procedure set (
      p_acs_person_id    in acs_persons_given_name.acs_person_id%TYPE,      
      p_extra_given_name in acs_persons_given_name.extra_given_name%TYPE,
      p_sort_order       in acs_persons_given_name.sort_order%TYPE,
      p_given_name_id    in acs_persons_given_name.given_name_id%TYPE
    );

end acs_person_given_name;
/
show errors


create or replace package body acs_person_given_name
as
    procedure set (
      p_acs_person_id    in acs_persons_given_name.acs_person_id%TYPE,      
      p_extra_given_name in acs_persons_given_name.extra_given_name%TYPE,
      p_sort_order       in acs_persons_given_name.sort_order%TYPE,
      p_given_name_id    in acs_persons_given_name.given_name_id%TYPE
    )
    is 
    begin 
      update acs_persons_given_name
      set   
        acs_person_id = p_acs_person_id,
        given_name    = p_given_name,
        sort_order    = p_sort_order
       where given_name_id = p_given_name_id;

end acs_person_given_name;
/
show errors

