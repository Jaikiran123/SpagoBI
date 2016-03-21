ALTER TABLE SBI_ORGANIZATIONS ADD COLUMN THEME VARCHAR(100) NULL DEFAULT 'SPAGOBI.THEMES.THEME.default';\p\g
ALTER TABLE SBI_USER ADD COLUMN IS_SUPERADMIN TINYINT(1) DEFAULT 0;\p\g

UPDATE SBI_USER us SET us.IS_SUPERADMIN = 1 WHERE us.ID IN(
	SELECT ur.ID FROM SBI_EXT_USER_ROLES ur WHERE ur.EXT_ROLE_ID IN( 
		SELECT role.EXT_ROLE_ID FROM SBI_EXT_ROLES role WHERE role.ROLE_TYPE_CD = 'ADMIN'
	)
);\p\g

CREATE TABLE SBI_ORGANIZATION_ENGINE (
  ENGINE_ID int(11) NOT NULL,
  ORGANIZATION_ID int(11) NOT NULL,
  USER_IN varchar(100) NOT NULL,
  USER_UP varchar(100) DEFAULT NULL,
  USER_DE varchar(100) DEFAULT NULL,
  TIME_IN timestamp,
  TIME_UP timestamp NULL DEFAULT NULL,
  TIME_DE timestamp NULL DEFAULT NULL,
  SBI_VERSION_IN varchar(10) DEFAULT NULL,
  SBI_VERSION_UP varchar(10) DEFAULT NULL,
  SBI_VERSION_DE varchar(10) DEFAULT NULL,
  META_VERSION varchar(100) DEFAULT NULL,
  ORGANIZATION varchar(20) DEFAULT NULL,
  PRIMARY KEY (ENGINE_ID,ORGANIZATION_ID ),
  CONSTRAINT FK_ENGINE_1 FOREIGN KEY (ENGINE_ID) REFERENCES SBI_ENGINES (ENGINE_ID) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT FK_ORGANIZATION_1 FOREIGN KEY (ORGANIZATION_ID) REFERENCES SBI_ORGANIZATIONS (ID) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;\p\g

CREATE TABLE SBI_ORGANIZATION_DATASOURCE (
  DATASOURCE_ID int(11) NOT NULL,
  ORGANIZATION_ID int(11) NOT NULL,
  USER_IN varchar(100) NOT NULL,
  USER_UP varchar(100) DEFAULT NULL,
  USER_DE varchar(100) DEFAULT NULL,
  TIME_IN timestamp,
  TIME_UP timestamp NULL DEFAULT NULL,
  TIME_DE timestamp NULL DEFAULT NULL,
  SBI_VERSION_IN varchar(10) DEFAULT NULL,
  SBI_VERSION_UP varchar(10) DEFAULT NULL,
  SBI_VERSION_DE varchar(10) DEFAULT NULL,
  META_VERSION varchar(100) DEFAULT NULL,
  ORGANIZATION varchar(20) DEFAULT NULL,
  PRIMARY KEY (DATASOURCE_ID,ORGANIZATION_ID ),
  CONSTRAINT FK_DATASOURCE_2 FOREIGN KEY (DATASOURCE_ID) REFERENCES SBI_DATA_SOURCE (DS_ID) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT FK_ORGANIZATION_2 FOREIGN KEY (ORGANIZATION_ID) REFERENCES SBI_ORGANIZATIONS (ID) ON DELETE NO ACTION ON UPDATE NO ACTION
) ;\p\g

INSERT INTO SBI_ORGANIZATION_DATASOURCE (DATASOURCE_ID, ORGANIZATION_ID, USER_IN, TIME_IN, SBI_VERSION_IN)
  SELECT ds.ds_id, org.id,  "server", SYSDATE(), "4.1"
  FROM SBI_DATA_SOURCE ds, SBI_ORGANIZATIONS org WHERE ds.organization = org.name;\p\g
  
 INSERT INTO SBI_ORGANIZATION_ENGINE (ENGINE_ID, ORGANIZATION_ID, USER_IN, TIME_IN, SBI_VERSION_IN)
  SELECT eng.engine_id, org.id,  "server", SYSDATE(), "4.1"
  FROM SBI_ENGINES eng, SBI_ORGANIZATIONS org WHERE eng.organization = org.name;\p\g
COMMIT;\p\g

UPDATE SBI_OBJECTS r JOIN (
SELECT B.ENGINE_ID AS OK, A.ENGINE_ID AS KO
FROM
(SELECT ENGINE_ID, LABEL, ORGANIZATION FROM SBI_ENGINES WHERE ORGANIZATION !='SPAGOBI') A,
(SELECT ENGINE_ID, LABEL, ORGANIZATION FROM SBI_ENGINES WHERE ORGANIZATION ='SPAGOBI') B
WHERE A.LABEL=B.LABEL
) t ON (r.ENGINE_ID = t.KO)
SET r.ENGINE_ID = t.OK
WHERE r.ENGINE_ID = t.KO;\p\g
(SELECT ENGINE_ID, LABEL, ORGANIZATION FROM SBI_ENGINES WHERE ORGANIZATION !='SPAGOBI');\p\g

DELETE FROM SBI_EXPORTERS where engine_id IN (SELECT ENGINE_ID FROM SBI_ENGINES WHERE ORGANIZATION !='SPAGOBI');\p\g
COMMIT;\p\g

DELETE from SBI_ENGINES where organization !='SPAGOBI';\p\g
COMMIT;\p\g

UPDATE SBI_ENGINES SET DRIVER_NM = 'it.eng.spagobi.engines.drivers.gis.GisDriver' 
		WHERE DRIVER_NM = 'it.eng.spagobi.engines.drivers.generic.GenericDriver' 
		AND BIOBJ_TYPE IN (SELECT VALUE_ID FROM SBI_DOMAINS WHERE DOMAIN_CD = 'BIOBJ_TYPE' AND VALUE_CD = 'MAP');\p\g 
COMMIT;\p\g

ALTER TABLE SBI_EXT_ROLES DROP COLUMN SAVE_SUBOBJECTS;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN SEE_SUBOBJECTS;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_VIEWPOINTS;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_SNAPSHOTS;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_NOTES;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEND_MAIL;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SAVE_INTO_FOLDER;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SAVE_REMEMBER_ME;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_METADATA; 
ALTER TABLE SBI_EXT_ROLES DROP COLUMN SAVE_METADATA;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  BUILD_QBE_QUERY;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  DO_MASSIVE_EXPORT;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  EDIT_WORKSHEET;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  MANAGE_USERS;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_DOCUMENT_BROWSER;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_FAVOURITES;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_SUBSCRIPTIONS;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_MY_DATA;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  SEE_TODO_LIST;
ALTER TABLE SBI_EXT_ROLES DROP COLUMN  CREATE_DOCUMENTS;


CREATE TABLE SBI_AUTHORIZATIONS (
  ID INTEGER NOT NULL,
  NAME varchar(200) DEFAULT NULL,
  USER_IN varchar(100) NOT NULL,
  USER_UP varchar(100) DEFAULT NULL,
  USER_DE varchar(100) DEFAULT NULL,
  TIME_IN timestamp NOT NULL,
  TIME_UP timestamp NULL DEFAULT NULL,
  TIME_DE timestamp NULL DEFAULT NULL,
  SBI_VERSION_IN varchar(10) DEFAULT NULL,
  SBI_VERSION_UP varchar(10) DEFAULT NULL,
  SBI_VERSION_DE varchar(10) DEFAULT NULL,
  META_VERSION varchar(100) DEFAULT NULL,
  ORGANIZATION varchar(20) DEFAULT NULL,
  PRIMARY KEY (ID)
) ;

CREATE TABLE SBI_AUTHORIZATIONS_ROLES (
  AUTHORIZATION_ID INTEGER NOT NULL,
  ROLE_ID INTEGER NOT NULL,
  USER_IN varchar(100) NOT NULL,
  USER_UP varchar(100) DEFAULT NULL,
  USER_DE varchar(100) DEFAULT NULL,
  TIME_IN timestamp NOT NULL,
  TIME_UP timestamp NULL DEFAULT NULL,
  TIME_DE timestamp NULL DEFAULT NULL,
  SBI_VERSION_IN varchar(10) DEFAULT NULL,
  SBI_VERSION_UP varchar(10) DEFAULT NULL,
  SBI_VERSION_DE varchar(10) DEFAULT NULL,
  META_VERSION varchar(100) DEFAULT NULL,
  ORGANIZATION varchar(20) DEFAULT NULL,
  PRIMARY KEY (AUTHORIZATION_ID,ROLE_ID )
  ) ;
  
  ALTER TABLE SBI_AUTHORIZATIONS_ROLES ADD CONSTRAINT FK_ROLE1 FOREIGN KEY (ROLE_ID) REFERENCES SBI_EXT_ROLES (EXT_ROLE_ID);\p\g 
  ALTER TABLE SBI_AUTHORIZATIONS_ROLES ADD CONSTRAINT FK_AUTHORIZATION_1 FOREIGN KEY (AUTHORIZATION_ID) REFERENCES SBI_AUTHORIZATIONS (ID):\p\g

  --27/01/2014: Added SpagoBICockpitEngine configuration
INSERT INTO SBI_ENGINES
(ENGINE_ID,ENCRYPT,NAME,DESCR,MAIN_URL,SECN_URL,OBJ_UPL_DIR,OBJ_USE_DIR,DRIVER_NM,LABEL,ENGINE_TYPE,CLASS_NM,BIOBJ_TYPE,USE_DATASET,USE_DATASOURCE,USER_IN,USER_UP,USER_DE,TIME_IN,
TIME_UP,TIME_DE,SBI_VERSION_IN,SBI_VERSION_UP,SBI_VERSION_DE,META_VERSION,ORGANIZATION)
VALUES ((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_ENGINES'), 0, 'Cockpit Engine', 'Cockpit Engine', '/SpagoBICockpitEngine/CockpitEngineStartAction', NULL, NULL, NULL, 'it.eng.spagobi.engines.drivers.cockpit.CockpitDriver', 'SpagoBICockpitEngine', (SELECT VALUE_ID FROM SBI_DOMAINS WHERE DOMAIN_CD = 'ENGINE_TYPE' AND VALUE_CD = 'EXT'), '',(SELECT VALUE_ID FROM spagobi.SBI_DOMAINS WHERE DOMAIN_CD = 'BIOBJ_TYPE' AND VALUE_CD = 'DOCUMENT_COMPOSITE'), false, false, 'database', 'biadmin', NULL, '2014-01-09 00:00:00', '2014-01-09 00:00:00', NULL, '4.1', '4.1', NULL, NULL, 'SPAGOBI');
update hibernate_sequences set next_val = next_val+1 where sequence_name = 'SBI_ENGINES';
commit;
INSERT INTO SBI_ORGANIZATION_ENGINE (ENGINE_ID, ORGANIZATION_ID, USER_IN, TIME_IN, SBI_VERSION_IN)
values((SELECT engine_id from SBI_ENGINES where label='SpagoBICockpitEngine'), (select id from SBI_ORGANIZATIONS where name = 'SPAGOBI'),
'server', CURRENT_TIMESTAMP, '4.1');
COMMIT;

CREATE TABLE SBI_TRIGGER_PAUSED (
	   ID 					INTEGER  NOT NULL ,
       TRIGGER_NAME	 	    VARCHAR(80) NOT NULL,
       TRIGGER_GROUP 	    VARCHAR(80) NOT NULL,
       JOB_NAME 	        VARCHAR(80) NOT NULL,
       JOB_GROUP 	        VARCHAR(80) NOT NULL,	   	   
       USER_IN              VARCHAR(100) NOT NULL,
       USER_UP              VARCHAR(100),
       USER_DE              VARCHAR(100),
       TIME_IN              TIMESTAMP NOT NULL,
       TIME_UP              TIMESTAMP NULL DEFAULT NULL,
       TIME_DE              TIMESTAMP NULL DEFAULT NULL,
       SBI_VERSION_IN       VARCHAR(10),
       SBI_VERSION_UP       VARCHAR(10),
       SBI_VERSION_DE       VARCHAR(10),
       META_VERSION         VARCHAR(100),
       ORGANIZATION         VARCHAR(20),  
       CONSTRAINT XAK1SBI_TRIGGER_PAUSED UNIQUE(TRIGGER_NAME, TRIGGER_GROUP, JOB_NAME, JOB_GROUP),
       PRIMARY KEY (ID)
) ;\p\g

INSERT INTO SBI_CONFIG ( ID, LABEL, NAME, DESCRIPTION, IS_ACTIVE, VALUE_CHECK, VALUE_TYPE_ID, CATEGORY, USER_IN, TIME_IN) VALUES 
((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_CONFIG'), 
'SPAGOBI.DOCUMENTS.MAX_PREVIEW_IMAGE_SIZE', 'Max preview image size', 'Max dimension for a document''s preview image', true, '1048576',
(select VALUE_ID from SBI_DOMAINS where VALUE_CD = 'NUM' AND DOMAIN_CD = 'PAR_TYPE'), 'GENERIC_CONFIGURATION', 'biadmin', current_timestamp);\p\g
update hibernate_sequences set next_val = next_val+1 where sequence_name = 'SBI_CONFIG';\p\g
commit;\p\g
INSERT INTO SBI_CONFIG ( ID, LABEL, NAME, DESCRIPTION, IS_ACTIVE, VALUE_CHECK, VALUE_TYPE_ID, CATEGORY, USER_IN, TIME_IN) VALUES 
((SELECT next_val FROM hibernate_sequences WHERE sequence_name = 'SBI_CONFIG'), 
'SPAGOBI.DOCUMENTS.MAX_PREVIEW_IMAGES_NUM', 'Max preview images', 'Max number for documents'' preview images', true, '200',
(select VALUE_ID from SBI_DOMAINS where VALUE_CD = 'NUM' AND DOMAIN_CD = 'PAR_TYPE'), 'GENERIC_CONFIGURATION', 'biadmin', current_timestamp);\p\g
update hibernate_sequences set next_val = next_val+1 where sequence_name = 'SBI_CONFIG';\p\g
commit;\p\g