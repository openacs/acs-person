<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="person_select">      
      <querytext>
    select acs_person_id,
        given_name,
	family_name,
	middle_name,
	preferred_given_name,
	formatted_name,
	given_name || ' ' || family_name as pretty_name,
        case when acs_permission__permission_p(acs_person_id,:user_id,'write') = 't'
  	  then 1 else 0 end as write_p,
        case when acs_permission__permission_p(acs_person_id,:user_id,'delete') = 't'
	  then 1 else 0 end as delete_p
    from acs_persons p 
    where acs_person_id = :acs_person_id

      </querytext>
</fullquery>

</queryset>
