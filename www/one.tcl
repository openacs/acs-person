# packages/acs-person/www/one.tcl

ad_page_contract {
  @author Jon Griffin jon@jongriffin.com
  @creation-date 2002-09-21
  @cvs-id $Id$
} {
    acs_person_id:integer,notnull
}  -validate {
    person_exists -requires {person_id} {
	if ![db_0or1row person_exists {
	}] {
	    ad_complain "$acs_person_id does not exist"
	    return 0
	}
	return 1
    }
} -properties {
  context_bar:onevalue
  page_title:onevalue
  person:onerow
}

## vars for quasi localization
## since this isn't available yet this is a reminder to myself

set page_title "Viewing"
set cbar_title "View One Person"

## set cbar_title "Informacion de una persona"

set context_bar [ad_context_bar $page_title]

set user_id [ad_verify_and_get_user_id]

set person_write_p [ad_permission_p $acs_person_id "write"]

db_1row person_select {

} -column_array person


