<?xml version="1.0"?>

<queryset>
   <rdbms><type>postgresql</type><version>7.1</version></rdbms>

<fullquery name="person_delete">      
      <querytext>

    select acs_person__del(:acs_person_id);
      </querytext>
</fullquery>

 
</queryset>
