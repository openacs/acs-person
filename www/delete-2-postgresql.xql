<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="contact_delete">      
      <querytext>

    select contact__del(:contact_id);
      </querytext>
</fullquery>

 
</queryset>
