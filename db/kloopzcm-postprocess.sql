﻿CREATE SEQUENCE md_pk_seq
   INCREMENT 1
   START 1000;
ALTER TABLE md_pk_seq OWNER TO cmsuser;
COMMENT ON SEQUENCE md_pk_seq IS 'metadata pk sequenece';

CREATE SEQUENCE cm_pk_seq
   INCREMENT 1
   START 1000;
ALTER TABLE cm_pk_seq OWNER TO cmsuser;
COMMENT ON SEQUENCE cm_pk_seq IS 'cm pk sequenece';

CREATE SEQUENCE ns_pk_seq
   INCREMENT 1
   START 1000;
ALTER TABLE ns_pk_seq OWNER TO cmsuser;
COMMENT ON SEQUENCE ns_pk_seq IS 'ns pk sequenece';

CREATE SEQUENCE dj_pk_seq
   INCREMENT 1
   START 1000;
ALTER TABLE dj_pk_seq OWNER TO cmsuser;
COMMENT ON SEQUENCE dj_pk_seq IS 'dj pk sequenece';

CREATE SEQUENCE event_pk_seq
   INCREMENT 1
   START 1000;
ALTER TABLE event_pk_seq OWNER TO cmsuser;
COMMENT ON SEQUENCE event_pk_seq IS 'pk sequenece for events';

CREATE SEQUENCE log_pk_seq
   INCREMENT 1
   START 1000;
ALTER TABLE log_pk_seq OWNER TO cmsuser;
COMMENT ON SEQUENCE log_pk_seq IS 'pk sequenece for logs';

-- ALTER TABLE md_classes ADD COLUMN format TEXT;

-- ALTER TABLE dj_deployment ADD COLUMN comments text;
-- ALTER TABLE dj_deployment ADD COLUMN ops text;

-- ALTER TABLE dj_deployment_rfc ADD COLUMN ops text;

-- ALTER TABLE md_class_attributes ADD COLUMN is_immutable BOOLEAN DEFAULT false NOT NULL;

-- ALTER TABLE md_class_actions ADD COLUMN arguments TEXT;

-- ALTER TABLE md_classes ADD COLUMN flags INTEGER DEFAULT 0 NOT NULL;
--  ALTER TABLE cm_ci_log ADD COLUMN created_by character varying(200);
-- ALTER TABLE cm_ci_log ADD COLUMN updated_by character varying(200);

-- ALTER TABLE cm_ci_attribute_log ADD COLUMN created_by character varying(200);
-- ALTER TABLE cm_ci_attribute_log ADD COLUMN updated_by character varying(200);

-- ALTER TABLE cm_ci_relation_log ADD COLUMN created_by character varying(200);
-- ALTER TABLE cm_ci_relation_log ADD COLUMN updated_by character varying(200);

-- ALTER TABLE cm_ci_relation_attr_log ADD COLUMN created_by character varying(200);
-- ALTER TABLE cm_ci_relation_attr_log ADD COLUMN updated_by character varying(200);


ALTER TABLE dj_rfc_ci DROP CONSTRAINT dj_rfc_rid_fk;

ALTER TABLE dj_rfc_ci
  ADD CONSTRAINT dj_rfc_rid_fk FOREIGN KEY (release_id)
      REFERENCES dj_releases (release_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE CASCADE;

ALTER TABLE dj_rfc_relation DROP CONSTRAINT dj_relation_rfc_relid_fk;

ALTER TABLE dj_rfc_relation
  ADD CONSTRAINT dj_relation_rfc_relid_fk FOREIGN KEY (release_id)
      REFERENCES dj_releases (release_id) MATCH SIMPLE
      ON UPDATE RESTRICT ON DELETE CASCADE;


CREATE TABLE ns_opt (
                ci_id BIGINT NOT NULL,
                ns_id BIGINT NOT NULL,
                created TIMESTAMP NOT NULL,
                CONSTRAINT ns_opt_pk PRIMARY KEY (ci_id, ns_id)
);


CREATE INDEX ns_opt_ns_id_idx
 ON ns_opt
 ( ns_id );

ALTER TABLE ns_opt ADD CONSTRAINT ns_path_ns_opt_fk
FOREIGN KEY (ns_id)
REFERENCES ns_namespaces (ns_id)
ON DELETE CASCADE
ON UPDATE NO ACTION
NOT DEFERRABLE;


-- CREATE INDEX cm_ops_proc_ci_id_idx ON cm_ops_procedures   ( ci_id );

-- CREATE INDEX cm_ops_proc_state_id_idx  ON cm_ops_procedures ( state_id );

-- CREATE INDEX cm_ops_actions_proc_id_idx  ON cm_ops_actions  ( ops_proc_id );

-- CREATE INDEX cm_ops_actions_ci_id_idx ON cm_ops_actions ( ci_id );

-- CREATE INDEX cm_ops_actions_state_id_idx  ON cm_ops_actions ( state_id );

CREATE UNIQUE INDEX dj_dpmt_state_idx ON dj_deployment (release_id, state_id) where state_id in (100, 300, 500);

CREATE UNIQUE INDEX dj_release_state_idx ON dj_releases (ns_id, release_state_id) where release_state_id = 100;

CREATE UNIQUE INDEX md_class_attr_name_idx ON md_class_attributes (class_id ASC NULLS LAST, attribute_name ASC NULLS LAST);

insert into md_classes (class_id, class_name, short_class_name, access_level, is_namespace, description)
values (100, 'Ci','Ci','global', false,'This is basic super class, all classes will extend this one');

insert into md_classes (class_id, class_name, short_class_name, access_level, is_namespace, description)
values (200, 'Component','Component','global', false,'This is component super class, all components will extend this one');

insert into ns_namespaces (ns_id, ns_path)
values (100, '/');

insert into cm_ci_state (ci_state_id, state_name) values (100, 'default');
insert into cm_ci_state (ci_state_id, state_name) values (200, 'pending_deletion');
insert into cm_ci_state (ci_state_id, state_name) values (300, 'replace');
insert into cm_ci_state (ci_state_id, state_name) values (400, 'locked');
insert into cm_ci_state (ci_state_id, state_name) values (500, 'manifest_locked');

insert into dj_release_states (release_state_id, state_name) values (100,'open');
insert into dj_release_states (release_state_id, state_name) values (200,'closed');
insert into dj_release_states (release_state_id, state_name) values (300,'canceled');

insert into cms_event_type (event_type_id, event_type) values (100,'insert');
insert into cms_event_type (event_type_id, event_type) values (200,'update');
insert into cms_event_type (event_type_id, event_type) values (300,'delete');

insert into dj_rfc_ci_actions (action_id, action_name) values (100, 'add');
insert into dj_rfc_ci_actions (action_id, action_name) values (200, 'update');
insert into dj_rfc_ci_actions (action_id, action_name) values (300, 'delete');
insert into dj_rfc_ci_actions (action_id, action_name) values (400, 'replace');

insert into dj_deployment_rfc_states (state_id, state_name) values (10,'pending');
insert into dj_deployment_rfc_states (state_id, state_name) values (100,'inprogress');
insert into dj_deployment_rfc_states (state_id, state_name) values (200,'complete');
insert into dj_deployment_rfc_states (state_id, state_name) values (300,'failed');
insert into dj_deployment_rfc_states (state_id, state_name) values (400,'canceled');

insert into dj_deployment_states (state_id, state_name) values (10,'pending');
insert into dj_deployment_states (state_id, state_name) values (100,'active');
insert into dj_deployment_states (state_id, state_name) values (200,'complete');
insert into dj_deployment_states (state_id, state_name) values (300,'failed');
insert into dj_deployment_states (state_id, state_name) values (400,'canceled');
insert into dj_deployment_states (state_id, state_name) values (500,'paused');


insert into cm_ops_proc_state (state_id, state_name) values (10,'pending');
insert into cm_ops_proc_state (state_id, state_name) values (100,'active');
insert into cm_ops_proc_state (state_id, state_name) values (200,'complete');
insert into cm_ops_proc_state (state_id, state_name) values (300,'failed');
insert into cm_ops_proc_state (state_id, state_name) values (400,'canceled');
insert into cm_ops_proc_state (state_id, state_name) values (500,'discarded');


insert into cm_ops_action_state (state_id, state_name) values (10,'pending');
insert into cm_ops_action_state (state_id, state_name) values (100,'inprogress');
insert into cm_ops_action_state (state_id, state_name) values (200,'complete');
insert into cm_ops_action_state (state_id, state_name) values (300,'failed');
insert into cm_ops_action_state (state_id, state_name) values (400,'canceled');

insert into dj_approval_states (state_id, state_name) values (100,'pending');
insert into dj_approval_states (state_id, state_name) values (200,'approved');
insert into dj_approval_states (state_id, state_name) values (300,'rejected');
insert into dj_approval_states (state_id, state_name) values (400,'expired');
