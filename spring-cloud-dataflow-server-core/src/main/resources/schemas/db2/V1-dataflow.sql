create sequence hibernate_sequence start with 1 increment by 1;

create table app_registration (
  id bigint not null,
  object_version bigint,
  default_version smallint,
  metadata_uri clob(255),
  name varchar(255),
  type integer,
  uri clob(255),
  version varchar(255),
  primary key (id)
);

create table task_deployment (
  id bigint not null,
  object_version bigint,
  task_deployment_id varchar(255) not null,
  task_definition_name varchar(255) not null,
  platform_name varchar(255) not null,
  created_on timestamp,
  primary key (id)
);

create table audit_records (
  id bigint not null,
  audit_action bigint,
  audit_data long varchar,
  audit_operation bigint,
  correlation_id varchar(255),
  created_by varchar(255),
  created_on timestamp,
  primary key (id)
);

create table stream_definitions (
  definition_name varchar(255) not null,
  definition clob(255),
  primary key (definition_name)
);

create table task_definitions (
  definition_name varchar(255) not null,
  definition clob(255),
  primary key (definition_name)
);

create table accounts (
  account_name varchar(255) not null,
  namespace varchar(255) not null,
  deployment_service_account_name varchar(255),
  entry_point_style varchar(255),
  primary key (account_name)
);

CREATE TABLE TASK_EXECUTION (
  TASK_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
  START_TIME TIMESTAMP DEFAULT NULL,
  END_TIME TIMESTAMP DEFAULT NULL,
  TASK_NAME  VARCHAR(100),
  EXIT_CODE INTEGER,
  EXIT_MESSAGE VARCHAR(2500),
  ERROR_MESSAGE VARCHAR(2500),
  LAST_UPDATED TIMESTAMP,
  EXTERNAL_EXECUTION_ID VARCHAR(255),
  PARENT_EXECUTION_ID BIGINT
);

CREATE TABLE TASK_EXECUTION_PARAMS (
  TASK_EXECUTION_ID BIGINT NOT NULL,
  TASK_PARAM VARCHAR(2500),
  constraint TASK_EXEC_PARAMS_FK foreign key (TASK_EXECUTION_ID)
  references TASK_EXECUTION(TASK_EXECUTION_ID)
);

CREATE TABLE TASK_TASK_BATCH (
  TASK_EXECUTION_ID BIGINT NOT NULL,
  JOB_EXECUTION_ID BIGINT NOT NULL,
  constraint TASK_EXEC_BATCH_FK foreign key (TASK_EXECUTION_ID)
  references TASK_EXECUTION(TASK_EXECUTION_ID)
);

CREATE SEQUENCE TASK_SEQ AS BIGINT START WITH 0 MINVALUE 0 MAXVALUE 9223372036854775807 NOCACHE NOCYCLE;

CREATE TABLE TASK_LOCK (
  LOCK_KEY CHAR(36) NOT NULL,
  REGION VARCHAR(100) NOT NULL,
  CLIENT_ID CHAR(36),
  CREATED_DATE TIMESTAMP NOT NULL,
  constraint LOCK_PK primary key (LOCK_KEY, REGION)
);

CREATE TABLE BATCH_JOB_INSTANCE (
  JOB_INSTANCE_ID BIGINT NOT NULL PRIMARY KEY,
  VERSION BIGINT,
  JOB_NAME VARCHAR(100) NOT NULL,
  JOB_KEY VARCHAR(32) NOT NULL,
  constraint JOB_INST_UN unique (JOB_NAME, JOB_KEY)
);

CREATE TABLE BATCH_JOB_EXECUTION (
  JOB_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
  VERSION BIGINT,
  JOB_INSTANCE_ID BIGINT NOT NULL,
  CREATE_TIME TIMESTAMP NOT NULL,
  START_TIME TIMESTAMP DEFAULT NULL,
  END_TIME TIMESTAMP DEFAULT NULL,
  STATUS VARCHAR(10),
  EXIT_CODE VARCHAR(2500),
  EXIT_MESSAGE VARCHAR(2500),
  LAST_UPDATED TIMESTAMP,
  JOB_CONFIGURATION_LOCATION VARCHAR(2500) NULL,
  constraint JOB_INST_EXEC_FK foreign key (JOB_INSTANCE_ID)
  references BATCH_JOB_INSTANCE(JOB_INSTANCE_ID)
);

CREATE TABLE BATCH_JOB_EXECUTION_PARAMS (
  JOB_EXECUTION_ID BIGINT NOT NULL,
  TYPE_CD VARCHAR(6) NOT NULL,
  KEY_NAME VARCHAR(100) NOT NULL,
  STRING_VAL VARCHAR(250),
  DATE_VAL TIMESTAMP DEFAULT NULL,
  LONG_VAL BIGINT,
  DOUBLE_VAL DOUBLE PRECISION,
  IDENTIFYING CHAR(1) NOT NULL,
  constraint JOB_EXEC_PARAMS_FK foreign key (JOB_EXECUTION_ID)
  references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
);

CREATE TABLE BATCH_STEP_EXECUTION (
  STEP_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
  VERSION BIGINT NOT NULL,
  STEP_NAME VARCHAR(100) NOT NULL,
  JOB_EXECUTION_ID BIGINT NOT NULL,
  START_TIME TIMESTAMP NOT NULL,
  END_TIME TIMESTAMP DEFAULT NULL,
  STATUS VARCHAR(10),
  COMMIT_COUNT BIGINT,
  READ_COUNT BIGINT,
  FILTER_COUNT BIGINT,
  WRITE_COUNT BIGINT,
  READ_SKIP_COUNT BIGINT,
  WRITE_SKIP_COUNT BIGINT,
  PROCESS_SKIP_COUNT BIGINT,
  ROLLBACK_COUNT BIGINT,
  EXIT_CODE VARCHAR(2500),
  EXIT_MESSAGE VARCHAR(2500),
  LAST_UPDATED TIMESTAMP,
  constraint JOB_EXEC_STEP_FK foreign key (JOB_EXECUTION_ID)
  references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
);

CREATE TABLE BATCH_STEP_EXECUTION_CONTEXT (
  STEP_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
  SHORT_CONTEXT VARCHAR(2500) NOT NULL,
  SERIALIZED_CONTEXT CLOB,
  constraint STEP_EXEC_CTX_FK foreign key (STEP_EXECUTION_ID)
  references BATCH_STEP_EXECUTION(STEP_EXECUTION_ID)
);

CREATE TABLE BATCH_JOB_EXECUTION_CONTEXT (
  JOB_EXECUTION_ID BIGINT NOT NULL PRIMARY KEY,
  SHORT_CONTEXT VARCHAR(2500) NOT NULL,
  SERIALIZED_CONTEXT CLOB,
  constraint JOB_EXEC_CTX_FK foreign key (JOB_EXECUTION_ID)
  references BATCH_JOB_EXECUTION(JOB_EXECUTION_ID)
);

CREATE SEQUENCE BATCH_STEP_EXECUTION_SEQ AS BIGINT MAXVALUE 9223372036854775807 NO CYCLE;

CREATE SEQUENCE BATCH_JOB_EXECUTION_SEQ AS BIGINT MAXVALUE 9223372036854775807 NO CYCLE;

CREATE SEQUENCE BATCH_JOB_SEQ AS BIGINT MAXVALUE 9223372036854775807 NO CYCLE;
