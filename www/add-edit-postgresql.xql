<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="new_person">      
      <querytext>
        select acs_person__new (
	:acs_person_id,
	:given_name,
        :middle_name,	
        :family_name,
	:formatted_name,
	:preferred_given_name,
	:acs_user_id,
        :user_id,
        :peeraddr,
        :package_id
    );

      </querytext>
</fullquery>

<fullquery name="set_person">      
      <querytext>
        select acs_person__set (
	:given_name,
        :middle_name,
        :family_name,
	:formatted_name,
	:preferred_given_name,
	:acs_user_id,
        :acs_person_id
    );

      </querytext>
</fullquery>
 
</queryset>
