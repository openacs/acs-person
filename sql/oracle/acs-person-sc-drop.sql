select acs_sc_binding__delete(
           'FtsContentProvider',		-- contract_name
	   'acs_person'			-- impl_name
);

select acs_sc_impl__delete(
	   'FtsContentProvider',		-- impl_contract_name
           'acs_person'				-- impl_name
);




drop trigger acs_persons__utrg on acs_persons;
drop trigger acs_persons__dtrg on acs_persons;
drop trigger acs_persons__itrg on acs_persons;



drop function acs_persons__utrg ();
drop function acs_persons__dtrg ();
drop function acs_persons__itrg ();

