ad_page_contract {

    Displays a list of people

    @author Jon Griffin (jon@jongriffin.com)
    @creation-date 2002-09-21
    @cvs-id $Id$
} {
  {start:integer "1"}
  {search_p 0}
  {search_string ""}
  {search_in ""}
  {sort ""}
  {starts_with ""}
} -properties {
  context_bar:onevalue
  package_id:onevalue
  user_id:onevalue
  persons:multirow
  title:onevalue
  first_letter:multirow
  acs_persons_create_p:onevalue
}


set user_id [ad_verify_and_get_user_id]
set package_id [ad_conn package_id]

set title "People"
set context_bar [ad_context_bar $title]

set acs_persons_create_p [ad_permission_p $package_id create]
set admin_p [ad_permission_p $package_id admin]


db_multirow first_letter get_first_letters { }


switch $sort {
    "fname" { set ordering "given_name, family_name, company_name" }
    "lname" { set ordering "family_name, given_name, company_name" }
    default { set ordering "family_name" }
}

if { ![empty_string_p $starts_with] } {
       switch $starts_with {
	"all" { set starts_with_clause "" }
        "other" { set starts_with_clause "and family_name is null" }
        default { set starts_with_clause "and upper(family_name) like '${starts_with}%'" }
    }

} else {
    set starts_with_clause ""
}


## should be able to get rid of this with search package
if { $search_p == 1 && ![string equal $search_string ""]} {
    switch $search_in {
	"fname" { set search_clause "and lower(given_name) like '%' || lower(:search_string) || '%'" }
	"lname" { set search_clause "and lower(family_name) like '%' || lower(:search_string) || '%'" }
        "any" { set search_clause "and (lower(family_name) like '%' || lower(:search_string) || '%' or
                                        lower(given_name) like '%' || lower(:search_string) || '%')" }
    }

} else {
    set search_clause ""
}


set max_dspl [ad_parameter MaxPersonsShow acs_persons 10]
set count 0

db_multirow persons acs_persons_select { }

set total_contacts [db_string retrieved_contacts "select count(*)
                                                  from contacts c, acs_objects o
                                                  where c.contact_id = o.object_id
                                                  ${search_clause}
                                                  ${starts_with_clause}"]

#                                                  and o.context_id = :package_id

# make paging links
if { $count < [expr $start + $max_dspl] } {
    set next_start ""
} else {
    if {[expr $start + 2 * $max_dspl - $total_contacts] < 0 } {
	set next_val $max_dspl
    } else {
	set next_val [expr $total_contacts - $start - $max_dspl + 1]
    }

    set next_start "<a href=index?start=[expr $start + $max_dspl]&search_p=${search_p}&search_string=${search_string}&search_in=${search_in}&starts_with=${starts_with}&sort=${sort}>NEXT $next_val<a/>"
}

if { $start == 1 } {
    set prev_start ""
} else {
    set prev_start "<a href=index?start=[expr $start - $max_dspl]&search_p=${search_p}&search_string=${search_string}&search_in=${search_in}&starts_with=${starts_with}&sort=${sort}>PREV $max_dspl</a>"
}

if { ![empty_string_p $next_start] && ![empty_string_p $prev_start] } {
    set divider " | "
} else {
    set divider ""
}

if { [expr $start + $max_dspl - 1] > $total_contacts } {
    if { $total_contacts == 0 } {
	set start 0 }
    set showing "Showing: $start - $total_contacts"
} else {
    set showing "Showing: $start - [expr $start + $max_dspl - 1]"
}

set pagination_link " $prev_start$divider$next_start "


## setup a status bar     
#  where o.context_id = :package_id
#  and acs_permission.permission_p(contact_id, :user_id, 'read') = 't'

ad_return_template
