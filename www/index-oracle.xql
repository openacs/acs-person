<?xml version="1.0"?>

<queryset>
   <rdbms><type>oracle</type><version>8.1.6</version></rdbms>

<fullquery name="contacts_select">      
      <querytext>
      
    select contact_id,
           family_name,
           given_name,
           middle_name,
	   company_name,
           g.category_name as category
    from contacts c, acs_objects o, contact_categories g
    where c.contact_id = o.object_id
    and c.category_type_id = g.category_type_id(+)
    and o.context_id = :package_id
    ${search_clause}
    ${starts_with_clause}
    order by $ordering
      </querytext>
</fullquery>

 
</queryset>
