<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="person_delete">      
      <querytext>
      
  begin
    acs_person.delete(:acs_person_id);
  end;

      </querytext>
</fullquery>

 
</queryset>
