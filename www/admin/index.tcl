ad_page_contract {

    Admin page for acs-person

    @author Jon Griffin (jon@jongriffin.com)
    @creation-date 2002-09-21
    @cvs-id $Id$
} {
} -properties {
  context_bar:onevalue
  package_id:onevalue
  user_id:onevalue
  contacts:multirow
  title:onevalue
}

set package_id [ad_conn package_id]

set title "Contacts Admin"
set context_bar [ad_context_bar $title]

set user_id [ad_verify_and_get_user_id]

## setup a status bar 

    
ad_return_template
