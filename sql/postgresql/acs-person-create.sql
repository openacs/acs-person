-- @cvs-id:$Id$	

-- This is a fairly direct mapping of the HR-XML PersonName v1.0 schema
-- see the docs for explanations

-- create a package sequence
create sequence acs_persons_seq;

-- create some lookup tables

-- affix_type 
create table affix_type (
    affix_type_id    integer
                     constraint affix_type_id_pk
                         primary key,
    xml_name         varchar(20)
                     constraint affix_type_xml_name_nn
                         not null,
    help_text        varchar(400)
                     constraint affix_type_pretty_name_nn
                         not null
);

-- add some initial data

insert into affix_type 
    (affix_type_id, xml_name,help_text)
values
    (nextval('acs_persons_seq'),'aristocraticTitle','i.e. Baron, Graf, Earl, etc.');

insert into affix_type 
    (affix_type_id, xml_name,help_text)
values
    (nextval('acs_persons_seq'),'aristocraticPrefix','i.e. Von, etc.');

insert into affix_type 
    (affix_type_id, xml_name,help_text)
values
    (nextval('acs_persons_seq'),'formOfAddress','Contains the salutation, 
i.e. Mr., Mrs., Hon., Dr., etc.');

insert into affix_type 
    (affix_type_id,xml_name,help_text)
values
    (nextval('acs_persons_seq'),'FamilyNamePrefix','Contains the part of the person''s
name that precedes the family name. i.e. Van den, Von, etc.');

insert into affix_type 
    (affix_type_id,xml_name,help_text)
values
    (nextval('acs_persons_seq'),'generation','i.e. Sr. Jr., III');

insert into affix_type 
    (affix_type_id,xml_name,help_text)
values
    (nextval('acs_persons_seq'),'qualifications','Contains the letters used to describe the academic qualifications held by a person and/or the distinctions conferred upon them.
i.e. PhD, MD, CPA, MCSD, etc.');




-- Main table
create table acs_persons (
    acs_person_id        integer 
                         constraint acs_person_id_pk
                             primary key
                         constraint acs_person_id_fk
                             references acs_objects(object_id),
    formatted_name       varchar (200),
    given_name           varchar (100),
    preferred_given_name varchar (100),
    middle_name          varchar (100),
    -- The spec says that all fields should be optional
    -- This data model requires at least the family_name
    -- element. Madonna and Prince go here whether they 
    -- consider that a family name or not. 
    family_name          varchar (100)
                             constraint acs_prsn_fmly_nme_nn
                         not null,
    -- link into users
    user_id              integer
                         constraint acs_user_id_fk
                             references users(user_id)
);

create index acs_persons_full_name_ix on acs_persons (given_name,family_name);
create index acs_persons_family_name_ix on acs_persons (family_name);

comment on table acs_persons is '
This is the main table for acs_persons. It is a direct mapping of the HR-XML
PersonName v1.0 schema
';

comment on column acs_persons.acs_person_id is '
Primary key.
';

comment on column acs_persons.family_name is '
The last name.
';

comment on column acs_persons.given_name is '
Given or first name.
';

comment on column acs_persons.middle_name is '
This could also be more than one name.
';

comment on column acs_persons.formatted_name is '
This is the name as it might appear in a letter.
';

comment on column acs_persons.preferred_given_name is '
';


comment on column acs_persons.acs_person_id is '
Foriegn key. This can be null as we also want to use this for non-users progams
i.e. contact manager etc.
';


-- Now the map tables

-- affix_acs_persons_map
--
-- This is necessary due to the way HR-XML implemented the affix system.
-- Since it is many to many this is the only way.

create table affix_acs_persons_map (
    acs_person_id    integer
                     constraint affix_person_id_fk
                         references persons(person_id),
    affix_type_id    integer
                     constraint affix_type_id_fk
                         references affix_type(affix_type_id),
    ---- add the primary key to ensure uniqueness
    constraint affix_acs_prsn_map_pk
    primary key (acs_person_id,affix_type_id)
);

-- acs_persons_given_names
create table acs_persons_given_names (
    given_name_id    integer
                     constraint acs_prsn_gvn_nme_pk
                     primary key,
    acs_person_id    integer
                     constraint acs_prsn_gvn_nme_fk
                         references acs_persons(acs_person_id),
    extra_given_name varchar(100)
                     constraint acs_prsn_gvn_nme_name_nn
                         not null,
    sort_order       integer,
    ---- add some constraints to keep data sanity
    constraint acs_prsn_gvn_nme_uq
    unique (acs_person_id,extra_given_name,sort_order)
);

create table acs_persons_middle_names (
    middle_name_id   integer
                     constraint acs_prsn_mdl_nme_pk
                     primary key,
    acs_person_id    integer
                     constraint acs_prsn_mdl_nme_fk
                         references acs_persons(acs_person_id),
    extra_middle_name varchar(100)
                     constraint acs_prsn_mdl_nme_name_nn
                         not null,
    sort_order       integer,
    ---- add some constraints to keep data sanity
    constraint acs_prsn_mdl_nme_uq
    unique (acs_person_id,extra_middle_name,sort_order)
);

create table acs_persons_family_names (
    family_name_id   integer
                     constraint acs_prsn_fmly_nme_pk
                     primary key,
    acs_person_id    integer
                     constraint acs_prsn_fmly_nme_fk
                         references acs_persons(acs_person_id),
    extra_family_name varchar(100)
                     constraint acs_prsn_fmly_nme_name_nn
                         not null,
    sort_order       integer,
    ---- add some constraints to keep data sanity
    constraint acs_prsn_fmly_nme_uq
    unique (acs_person_id,extra_family_name,sort_order)
);

-- plsql procs
\i acs-person-plsql.sql

-- Service contract
-- Broken drop script
-- \i acs-person-sc-create.sql
