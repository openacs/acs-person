<?xml version="1.0"?>
<queryset>

<fullquery name="person_exists">      
      <querytext>
      
	    select 1 from acs_persons where acs_person_id = :acs_person_id
	
      </querytext>
</fullquery>

 
<fullquery name="person_select">      
      <querytext>
      
    select acs_person_id,
        given_name || ' ' || family_name as name
    from acs_persons
    where acs_person_id = :acs_person_id

      </querytext>
</fullquery>

 
</queryset>
