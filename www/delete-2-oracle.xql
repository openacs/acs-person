<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="contact_delete">      
      <querytext>
      
  begin
    delete from acs_permissions
    where object_id = :contact_id;

    contact.delete(:contact_id);
  end;

      </querytext>
</fullquery>

 
</queryset>
