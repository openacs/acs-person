select acs_sc_impl__new(
	   'FtsContentProvider',                -- impl_contract_name
           'acs_person',                        -- impl_name
	   'acs_persons'                           -- impl_owner_name
);

select acs_sc_impl_alias__new(
           'FtsContentProvider',		-- impl_contract_name
           'acs_person',       			-- impl_name
	   'datasource',			-- impl_operation_name
	   'acs_persons__datasource',     		-- impl_alias
	   'TCL'				-- impl_pl
);

select acs_sc_impl_alias.new(
           'FtsContentProvider',		-- impl_contract_name
           'acs_person',          			-- impl_name
	   'url',				-- impl_operation_name
	   'acs_persons__url',			-- impl_alias
	   'TCL'				-- impl_pl
);


create function acs_persons__itrg ()
returns opaque as '
begin
    perform search_observer__enqueue(new.acs_person_id,''INSERT'');
    return new;
end;' language 'plpgsql';

create function acs_persons__dtrg ()
returns opaque as '
begin
    perform search_observer__enqueue(old.acs_person_id,''DELETE'');
    return old;
end;' language 'plpgsql';

create function acs_persons__utrg ()
returns opaque as '
begin
    perform search_observer__enqueue(old.acs_person_id,''UPDATE'');
    return old;
end;' language 'plpgsql';


create trigger acs_persons__itrg after insert on acs_persons
for each row execute procedure acs_persons__itrg (); 

create trigger acs_persons__dtrg after delete on acs_persons
for each row execute procedure acs_persons__dtrg (); 

create trigger acs_persons__utrg after update on acs_persons
for each row execute procedure acs_persons__utrg (); 





