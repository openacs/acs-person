ad_page_contract {

  @author Jon Griffin jon@jongriffin.com
  @creation-date 2002-09-23
  @cvs-id $Id$
} {
  acs_person_id:integer,notnull
}

ad_require_permission $acs_person_id delete

db_exec_plsql person_delete {

}

ad_returnredirect "."

