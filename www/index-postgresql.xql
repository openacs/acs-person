<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="acs_persons_select">      
      <querytext>
    select acs_person_id,
           family_name,
           given_name,
           middle_name,
           acs_permission__permission_p(acs_person_id,:user_id,'write') as write_p,
           acs_permission__permission_p(acs_person_id,:user_id,'delete') as delete_p
    from acs_objects o,acs_persons p
    where p.acs_person_id = o.object_id
    and o.context_id = :package_id
    order by $ordering
      </querytext>
</fullquery>
 
</queryset>
