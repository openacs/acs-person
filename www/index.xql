<?xml version="1.0"?>
<queryset>

<fullquery name="get_first_letters">      
      <querytext>
      
    select distinct substr(upper(family_name), 0, 1) as letter from acs_persons

      </querytext>
</fullquery>


<fullquery name="retrieved_contacts">      
      <querytext>
      select count(*)
      from acs_persons p, acs_objects o
      where p.acs_person_id = o.object_id
      ${search_clause}
      ${starts_with_clause}
      </querytext>
</fullquery>

 
</queryset>
