ad_page_contract {

  @author Jon Griffin jon@jongriffin.com
  @creation-date 2002-01-16
  @cvs-id $Id$
} {
  contact_id:integer,notnull
}

ad_require_permission $contact_id delete

db_exec_plsql contact_delete {

}

ad_returnredirect "."

