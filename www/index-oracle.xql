<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="persons_select">      
      <querytext>
      
    select acs_person_id,
           family_name,
           given_name,
           middle_name
    from acs_persons p, acs_objects o
    where p.acs_person_id = o.object_id
    and o.context_id = :package_id
    ${search_clause}
    ${starts_with_clause}
    order by $ordering
      </querytext>
</fullquery>

 
</queryset>
