<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="person_select">      
      <querytext>
      
    select acs_person_id,
        given_name,
	family_name,
	middle_name,
	preferred_given_name,
	formatted_name,
	given_name || ' ' || family_name as pretty_name,
        decode(acs_permission.permission_p(contact_id,
                                        :user_id,
                                        'write'),
            't',1,
            'f',0) as write_p,
       decode(acs_permission.permission_p(contact_id,
                                        :user_id,
                                        'delete'),
            't',1,
            'f',0) as delete_p
    from acs_persons p
    where acs_person_id = :acs_person_id

      </querytext>
</fullquery>

 
</queryset>
