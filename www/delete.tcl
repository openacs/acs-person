ad_page_contract {

    Delete Confirmation page for acs-person

    @author jon@jongriffin.com
    @creation-date 2002-09-23
    @cvs-id $Id$

} {
   person_id:integer,notnull
}  -validate {
    person_exists -requires {acs_person_id} {
	if ![db_0or1row person_exists {
	}] {
	    ad_complain "Person $acs_person_id does not exist"
	    return 0
	}
	return 1
    }
} -properties {
    title:onevalue
    one_person:onerow
}

set title "Delete Person"
set context_bar [ad_context_bar]
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]

# make sure they don't perform URL surgery
ad_require_permission $acs_person_id delete

db_1row person_select {
} -column_array one_person

 