# packages/acs-person/www/add-edit.tcl

ad_page_contract {
  @author Jon Griffin jon@jongriffin.com
  @creation-date 2002-09-21
  @cvs-id $Id$
} {
    acs_person_id:integer,notnull,optional
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

set package_id [ad_conn package_id]

## vars for quasi localization
## since this isn't available yet this is a reminder to myself

set cbar_title "Person Info"
#set cbar_title "Informacion de una persona"
set page_title_e "Edit Person"
set page_title_c "Create Person"

if {[info exists acs_person_id]} {
  ad_require_permission $acs_person_id write
  set page_title $page_title_e
  set context_bar [ad_context_bar [list "." $cbar_title ] [list "one?acs_person_id=$acs_person_id" $cbar_title] $page_title]
} else {
  ad_require_permission $package_id create
  set page_title $page_title_c
  set context_bar [ad_context_bar [list "." $cbar_title] $page_title ]
}

template::form create new_person

if {[template::form is_request new_person] && [info exists acs_person_id]} {

  template::element create new_person acs_person_id \
      -widget hidden \
      -datatype number \
      -value $acs_person_id

  db_1row person_select { }

}

template::element create new_person given_name \
    -datatype text \
    -label "First Name" \
    -html { size 40 } \
    -value $given_name

template::element create new_person middle_name \
    -datatype text \
    -label "Middle" \
    -html { size 30 } \
    -value $middle_name

template::element create new_person family_name \
    -datatype text \
    -label "Last Name" \
    -html { size 40 } \
    -value $family_name

template::element create new_person formatted_name \
    -datatype text \
    -label "Formatted Name" \
    -html { size 40 } \
    -value $formatted_name

template::element create new_person preferred_given_name \
    -datatype text \
    -label "Preferred Name" \
    -html { size 40 } \
    -value $preferred_given_name

template::element create new_person spacer3 \
    -datatype text \
    -widget inform \
    -label "" \
    -value "<br>"

template::element create new_person acs_user_id \
    -datatype text \
    -label "ACS User" \
    -html { size 20 } \
    -value $acs_user_id

#######################################
### start of processing of update/new
#######################################
## this will only  update the person part

if [template::form is_valid new_person] {
  set user_id [ad_conn user_id]
  set peeraddr [ad_conn peeraddr]

  if [info exists acs_person_id] {
    db_exec_plsql set_person {
    }
} else {
    db_exec_plsql new_person {
    }
}

  ad_returnredirect "."
}

ad_return_template



