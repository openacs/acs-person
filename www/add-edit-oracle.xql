<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="new_contact">      
      <querytext>
      
      declare
        id integer;
      begin
        id := contact.new (
        family_name     => :family_name,
        given_name      => :given_name,
        middle_name     => :middle_name,
	formatted_name  => :formatted_name,
	preferred_given_name => :preferred_given_name,
	affix           => :affix,
        suffix          => :suffix,
        title           => :title,
        email           => :email,
        category_id     => :category_id,
	company_name    => :company_name,
	company_type_id => :company_type_id,
        notes           => :notes,
        creation_user   => :user_id,
        creation_ip     => :peeraddr,
        context_id      => :package_id
        );

        acs_permission.grant_permission(
          object_id  => id,
          grantee_id => :user_id,
          privilege  => 'write'
        );

        acs_permission.grant_permission (
          object_id  => id,
          grantee_id => :user_id,
          privilege  => 'delete'
        );
      end;
    
      </querytext>
</fullquery>

 
</queryset>
