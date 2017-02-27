CREATE SCHEMA eho_schema AUTHORIZATION postgres;

CREATE TABLE eho_schema.ar_internal_metadata
	(
	 key character varying NOT NULL,
	 value character varying,
	 created_at timestamp without time zone NOT NULL,
	 updated_at timestamp without time zone NOT NULL,
	 CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key)
	)
	WITH (
	 OIDS=FALSE
	);

ALTER TABLE eho_schema.ar_internal_metadata
	 OWNER TO postgres;

CREATE TABLE eho_schema.schema_migrations
(
 version character varying NOT NULL,
 CONSTRAINT schema_migrations_pkey PRIMARY KEY (version)
)
WITH (
 OIDS=FALSE
);

ALTER TABLE eho_schema.schema_migrations
 OWNER TO postgres;