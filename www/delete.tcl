ad_page_contract {

    Delete Confirmation page for Contacts

    @author jon@jongriffin.com
    @creation-date 2002-01-16
    @cvs-id $Id$

} {
   contact_id:integer,notnull
}  -validate {
    contact_exists -requires {contact_id} {
	if ![db_0or1row contact_exists {
	    select 1 from contacts where contact_id = :contact_id
	}] {
	    ad_complain "Contact $contact_id does not exist"
	    return 0
	}
	return 1
    }
} -properties {
    title:onevalue
    one_contact:onerow
}

set title "Delete Contact"
set context_bar [ad_context_bar]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

# make sure they don't perform URL surgery
ad_require_permission $contact_id delete

db_1row contact_select {
    select contact_id,
        given_name || ' ' || family_name as name
    from contacts
    where contact_id = :contact_id
} -column_array one_contact

 