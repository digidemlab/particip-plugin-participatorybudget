DROP TABLE IF EXISTS task_notify_documentbp_cf;
DROP TABLE IF EXISTS participatorybudget_campaign_area;
DROP TABLE IF EXISTS participatorybudget_votes_per_location;
DROP TABLE IF EXISTS participatorybudget_votes_history;
DROP TABLE IF EXISTS participatorybudget_votes;
DROP TABLE IF EXISTS participatorybudget_user_access_vote;
DROP TABLE IF EXISTS participatorybudget_rgpd_treatment_log;
DROP TABLE IF EXISTS participatorybudget_campaign_theme;
DROP TABLE IF EXISTS participatorybudget_campaign_phase;
DROP TABLE IF EXISTS participatorybudget_campaign_phase_type;
DROP TABLE IF EXISTS participatorybudget_campaign_image;
DROP TABLE IF EXISTS participatorybudget_campaign;
DROP TABLE IF EXISTS participatorybudget_campaign_moderation_type;
DROP TABLE IF EXISTS participatorybudget_bizstat_file;

CREATE TABLE IF NOT EXISTS participatorybudget_bizstat_file (
  id_bizstat_file int NOT NULL AUTO_INCREMENT,
  status varchar(50) NOT NULL,
  id_admin_user int NOT NULL,
  admin_user_access_code varchar(255) NOT NULL,
  admin_user_email varchar(255) NOT NULL,
  reason varchar(255) NOT NULL,
  file_name varchar(500) NOT NULL,
  description varchar(1000) NOT NULL,
  error varchar(4000) DEFAULT NULL,
  creation_date timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  file_value LONG VARBINARY,
  PRIMARY KEY (id_bizstat_file)
);

CREATE TABLE IF NOT EXISTS participatorybudget_campaign_moderation_type (
  id_moderation_type int NOT NULL,
  code_moderation_type varchar(50) NOT NULL,
  libelle varchar(255) NOT NULL,
  PRIMARY KEY (id_moderation_type)
);
ALTER TABLE participatorybudget_campaign_moderation_type ADD CONSTRAINT uc_code_moderation_type UNIQUE (code_moderation_type);

CREATE TABLE IF NOT EXISTS participatorybudget_campaign (
  id_campagne int NOT NULL,
  code_campagne varchar(50) NOT NULL,
  title varchar(255) NOT NULL,
  description varchar(1000) NOT NULL,
  active smallint NOT NULL,
  code_moderation_type varchar(50) NOT NULL,
  moderation_duration int DEFAULT NULL,
  PRIMARY KEY (id_campagne)
);
ALTER TABLE participatorybudget_campaign ADD CONSTRAINT uc_code_campagne UNIQUE (code_campagne);
ALTER TABLE participatorybudget_campaign ADD CONSTRAINT fk_participatorybudget_campaign_moderation  FOREIGN KEY (code_moderation_type) REFERENCES participatorybudget_campaign_moderation_type (code_moderation_type);

CREATE TABLE IF NOT EXISTS participatorybudget_campaign_image (
  id_campagne_image int NOT NULL,
  code_campagne varchar(50) NOT NULL,
  id_file int NOT NULL,
  PRIMARY KEY (id_campagne_image)
);
ALTER TABLE participatorybudget_campaign_image ADD CONSTRAINT fk_participatorybudget_campaign_images_campagne  FOREIGN KEY (code_campagne) REFERENCES participatorybudget_campaign (code_campagne);
ALTER TABLE participatorybudget_campaign_image ADD CONSTRAINT fk_participatorybudget_campaign_images_file  FOREIGN KEY (id_file) REFERENCES core_file (id_file);

CREATE TABLE IF NOT EXISTS participatorybudget_campaign_phase_type (
  id_phase_type int NOT NULL,
  code_phase_type varchar(50) NOT NULL,
  libelle varchar(255) NOT NULL,
  PRIMARY KEY (id_phase_type)
);
ALTER TABLE participatorybudget_campaign_phase_type ADD CONSTRAINT uc_code_phase_type UNIQUE (code_phase_type);

CREATE TABLE IF NOT EXISTS participatorybudget_campaign_phase (
  id_campagne_phase int NOT NULL,
  code_phase_type varchar(50) NOT NULL,
  code_campagne varchar(50) NOT NULL,
  start datetime NOT NULL,
  end datetime NOT NULL,
  PRIMARY KEY (id_campagne_phase)
);
ALTER TABLE participatorybudget_campaign_phase ADD CONSTRAINT fk_participatorybudget_campaign_phases_campagne  FOREIGN KEY (code_campagne) REFERENCES participatorybudget_campaign (code_campagne);
ALTER TABLE participatorybudget_campaign_phase ADD CONSTRAINT fk_participatorybudget_campaign_phases_phase  FOREIGN KEY (code_phase_type) REFERENCES participatorybudget_campaign_phase_type (code_phase_type);

CREATE TABLE IF NOT EXISTS participatorybudget_campaign_theme (
  id_campagne_theme int NOT NULL,
  code_campagne varchar(50) NOT NULL,
  code_theme varchar(50) NOT NULL,
  title varchar(255) NOT NULL,
  description varchar(1000) NOT NULL,
  active smallint NOT NULL,
  image_file int DEFAULT NULL,
  PRIMARY KEY (id_campagne_theme)
);
ALTER TABLE participatorybudget_campaign_theme ADD CONSTRAINT uc_code_theme UNIQUE (code_campagne,code_theme);
ALTER TABLE participatorybudget_campaign_theme ADD CONSTRAINT fk_participatorybudget_campaign_themes_campagne  FOREIGN KEY (code_campagne) REFERENCES participatorybudget_campaign (code_campagne);

CREATE TABLE IF NOT EXISTS participatorybudget_rgpd_treatment_log (
  id_treatment_log int NOT NULL AUTO_INCREMENT,
  treatment_timestamp timestamp DEFAULT CURRENT_TIMESTAMP NOT NULL,
  id_admin_user int NOT NULL,
  admin_user_access_code varchar(255) NOT NULL,
  admin_user_email varchar(255) NOT NULL,
  treatment_type varchar(30) NOT NULL,
  treatment_object_name varchar(100) NOT NULL,
  treatment_object_fields varchar(1000) NOT NULL,
  PRIMARY KEY (id_treatment_log)
);

CREATE TABLE IF NOT EXISTS participatorybudget_user_access_vote (
  id_user varchar(255) NOT NULL,
  has_acces_vote int NOT NULL,
  PRIMARY KEY (id_user)
);

CREATE TABLE IF NOT EXISTS participatorybudget_votes (
  id_user varchar(255) NOT NULL,
  id_projet int NOT NULL,
  date_vote timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  arrondissement int NOT NULL,
  age int NOT NULL,
  birth_date varchar(255) DEFAULT NULL,
  ip_address varchar(100) DEFAULT '' NOT NULL,
  title varchar(255) DEFAULT '' NOT NULL,
  localisation int NOT NULL,
  thematique varchar(255) DEFAULT '' NOT NULL,
  status int DEFAULT '0' NOT NULL,
  mobile_phone varchar(50) DEFAULT NULL,
  email varchar(500) DEFAULT NULL,
  PRIMARY KEY (id_user,id_projet)
);

CREATE TABLE IF NOT EXISTS participatorybudget_votes_history (
  id_user varchar(255) NOT NULL,
  id_projet int NOT NULL,
  date_vote timestamp DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP NOT NULL,
  arrondissement int NOT NULL,
  age int NOT NULL,
  birth_date varchar(255) DEFAULT NULL,
  ip_address varchar(100) DEFAULT '' NOT NULL,
  title varchar(255) DEFAULT '' NOT NULL,
  localisation int NOT NULL,
  thematique varchar(255) DEFAULT '' NOT NULL,
  status int NOT NULL,
  id int NOT NULL,
  status_export_stats int DEFAULT '0' NOT NULL,
  PRIMARY KEY (id)
);
CREATE INDEX participatorybudget_votes_history_index_id_user ON participatorybudget_votes_history ( id_user );

CREATE TABLE IF NOT EXISTS participatorybudget_votes_per_location (
  id int NOT NULL,
  localisation_ardt varchar(50) NOT NULL,
  nb_votes int NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE participatorybudget_campaign_area (
  id_campagne_area int NOT NULL,
  code_campagne varchar(50) NOT NULL,
  title varchar(255) NOT NULL,
  active smallint NOT NULL,
  type varchar(50) NOT NULL,
  number_votes int NOT NULL,
  PRIMARY KEY (id_campagne_area)
);
ALTER TABLE participatorybudget_campaign_area ADD CONSTRAINT fk_participatorybudget_campaign_areas_campagne  FOREIGN KEY (code_campagne) REFERENCES participatorybudget_campaign (code_campagne) ON DELETE NO ACTION ON UPDATE NO ACTION;


CREATE TABLE IF NOT EXISTS task_notify_documentbp_cf (
  id_task int NOT NULL,
  sender_name varchar(255) DEFAULT NULL,
  sender_email varchar(255) DEFAULT NULL,
  subject varchar(255) DEFAULT NULL,
  message varchar(4000),
  recipients_cc varchar(255) DEFAULT '' NOT NULL,
  recipients_bcc varchar(255) DEFAULT '' NOT NULL,
  is_abonnes smallint NOT NULL,
  PRIMARY KEY (id_task)
);
