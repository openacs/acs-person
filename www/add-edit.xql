<?xml version="1.0"?>
<queryset>

<fullquery name="person_select">      
      <querytext>
      
    select p.acs_person_id,
        family_name, 
        given_name,
        middle_name,
        formatted_name,
        preferred_given_name
    from acs_persons p
    where p.acs_person_id = :acs_person_id
  
      </querytext>
</fullquery>

 
</queryset>
