# packages/acs-person/www/add-edit.tcl

ad_page_contract {
  @author Jon Griffin jon@jongriffin.com
  @creation-date 2002-09-21
  @cvs-id $Id$
} {
    acs_person_id:integer,optional
    {family_name ""}
    {given_name ""}
    {middle_name ""}
    {formatted_name ""}
    {preferred_given_name ""}
    {acs_user_id ""}
} -properties {
  context_bar:onevalue
  page_title:onevalue
}

# 
set package_id [ad_conn package_id]
set user_id [ad_conn user_id]
set peeraddr [ad_conn peeraddr]

## vars for quasi localization
## since this isn't available yet this is a reminder to myself

set cbar_title "Person Info"
#set cbar_title "Informacion de una persona"
set page_title_e "Edit Person"
set page_title_c "Create Person"

if {[info exists acs_person_id]} {

  set page_title $page_title_e
  set context_bar [ad_context_bar [list "." $cbar_title ] [list "one?acs_person_id=$acs_person_id" $cbar_title] $page_title]
} else {
  ad_require_permission $package_id create
  set page_title $page_title_c
  set context_bar [ad_context_bar [list "." $cbar_title] $page_title ]
}

ad_form -name new_person -form {

acs_person_id:key

{given_name:text(text) 
    {label "First Name"}
    {html {size 40}}
    {value {$given_name}}}

{middle_name:text(text) 
    {label "Middle"}
    {html { size 30 }}}

{family_name:text(text)
    {label "Last Name"}
    {html { size 40 }}}

{formatted_name:text(text)
    {label "Formatted Name"}
    {html { size 40 }}
    optional}
     
{preferred_given_name:text(text)
    {label "Preferred Name"}
    {html { size 40 }}
    optional}

{acs_user_id:text(text)
    {label "ACS User"}
    {html {size 10}}
    optional}
} -select_query_name person_select -validate {

} -new_data {

  db_exec_plsql new_person { }
  ad_returnredirect "."
  ad_script_abort

} -edit_data {
  ad_require_permission $acs_person_id write

  db_exec_plsql set_person { }
  ad_returnredirect "."
  ad_script_abort
}

ad_return_template



