<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_person">      
      <querytext>
      
      declare
        id integer;
      begin
        id := person.new (
        family_name     => :family_name,
        given_name      => :given_name,
        middle_name     => :middle_name,
	formatted_name  => :formatted_name,
	preferred_given_name => :preferred_given_name,
        acs_user_id     => :acs_user_id,
        creation_user   => :user_id,
        creation_ip     => :peeraddr,
        context_id      => :package_id
        );

      </querytext>
</fullquery>

<fullquery name="set_person">      
      <querytext>
    begin
        acs_person.set (
	:given_name,
        :middle_name,
        :family_name,
	:formatted_name,
	:preferred_given_name,
	:acs_user_id,
        :acs_person_id
    );
    end;

      </querytext>
</fullquery> 
</queryset>
