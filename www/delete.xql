<?xml version="1.0"?>
<queryset>

<fullquery name="contact_exists">      
      <querytext>
      
	    select 1 from contacts where contact_id = :contact_id
	
      </querytext>
</fullquery>

 
<fullquery name="contact_select">      
      <querytext>
      
    select contact_id,
        given_name || ' ' || family_name as name
    from contacts
    where contact_id = :contact_id

      </querytext>
</fullquery>

 
</queryset>
