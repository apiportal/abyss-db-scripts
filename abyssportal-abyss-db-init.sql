--
-- PostgreSQL database dump
--

-- Dumped from database version 11.1
-- Dumped by pg_dump version 11.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS abyssportal;
--
-- Name: abyssportal; Type: DATABASE; Schema: -; Owner: abyssuser
--
CREATE DATABASE abyssportal WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_US.UTF-8' LC_CTYPE = 'en_US.UTF-8';


-- CREATE USER ******************+++++++++++++//////////
CREATE ROLE abyssuser WITH INHERIT LOGIN ENCRYPTED PASSWORD 'User007';

GRANT ALL PRIVILEGES ON DATABASE abyssportal TO abyssuser;

ALTER DATABASE abyssportal OWNER TO abyssuser;

\connect abyssportal

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: DATABASE abyssportal; Type: COMMENT; Schema: -; Owner: abyssuser
--

COMMENT ON DATABASE abyssportal IS 'Abyss Portal Database';


--
-- Name: abyss; Type: SCHEMA; Schema: -; Owner: abyssuser
--

CREATE SCHEMA abyss;


ALTER SCHEMA abyss OWNER TO abyssuser;

--
-- Name: SCHEMA abyss; Type: COMMENT; Schema: -; Owner: abyssuser
--

COMMENT ON SCHEMA abyss IS 'Abyss BE Schema';

--
-- Create PG CRYPTO EXTENSION
--
CREATE EXTENSION pgcrypto WITH SCHEMA abyss;

ALTER EXTENSION pgcrypto SET SCHEMA abyss;

SET search_path = abyss, pg_catalog;

--
-- Name: e_contract_status; Type: TYPE; Schema: abyss; Owner: abyssuser
--

CREATE TYPE abyss.e_contract_status AS ENUM (
    'draft',
    'inforce',
    'archived'
);


ALTER TYPE abyss.e_contract_status OWNER TO abyssuser;

--
-- Name: getuuidofapi(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofapi(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from api_bckup where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofapi(integer) OWNER TO abyssuser;

--
-- Name: getuuidofapi2(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofapi2(integer) RETURNS uuid
    LANGUAGE plpgsql
    AS $_$
DECLARE
  vuuid uuid;
BEGIN
  IF $1 IS NULL
  THEN
    vuuid = NULL;
  ELSE

    SELECT uuid
    into vuuid
    FROM api
    WHERE id = $1;

    IF NOT FOUND
    THEN
      RAISE EXCEPTION 'No record at %.', $1;
    END IF;

  END IF;
  -- Since execution is not finished, we can check whether rows were returned
  -- and raise exception if not.

  RETURN vuuid;
END
$_$;


ALTER FUNCTION abyss.getuuidofapi2(integer) OWNER TO abyssuser;

--
-- Name: getuuidofapistate(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofapistate(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from api_state where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofapistate(integer) OWNER TO abyssuser;

--
-- Name: getuuidofapivisibility(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofapivisibility(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from api_visibility_type where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofapivisibility(integer) OWNER TO abyssuser;

--
-- Name: getuuidoforganization(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidoforganization(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from organization where id = $1;$_$;


ALTER FUNCTION abyss.getuuidoforganization(integer) OWNER TO abyssuser;

--
-- Name: getuuidofresourcetype(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofresourcetype(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from resource_type where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofresourcetype(integer) OWNER TO abyssuser;

--
-- Name: getuuidofsubject(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofsubject(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from subject where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofsubject(integer) OWNER TO abyssuser;

--
-- Name: getuuidofsubjectdirectory(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofsubjectdirectory(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from subject_directory where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofsubjectdirectory(integer) OWNER TO abyssuser;

--
-- Name: getuuidofsubjectdirectorytype(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofsubjectdirectorytype(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from subject_directory_type where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofsubjectdirectorytype(integer) OWNER TO abyssuser;

--
-- Name: getuuidofsubjectgroup(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofsubjectgroup(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from subject_group where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofsubjectgroup(integer) OWNER TO abyssuser;

--
-- Name: getuuidofsubjectpermission(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofsubjectpermission(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from subject_permission where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofsubjectpermission(integer) OWNER TO abyssuser;

--
-- Name: getuuidofsubjecttype(integer); Type: FUNCTION; Schema: abyss; Owner: abyssuser
--

CREATE FUNCTION abyss.getuuidofsubjecttype(integer) RETURNS uuid
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$select uuid from subject_type where id = $1;$_$;


ALTER FUNCTION abyss.getuuidofsubjecttype(integer) OWNER TO abyssuser;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: access_manager; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.access_manager (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    accessmanagername character varying(64) NOT NULL,
    description character varying(255),
    isactive boolean DEFAULT false NOT NULL,
    accessmanagertypeid uuid NOT NULL,
    accessmanagerattributes jsonb
);


ALTER TABLE abyss.access_manager OWNER TO abyssuser;

--
-- Name: TABLE access_manager; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.access_manager IS 'Abyss Platform Access Manager';


--
-- Name: COLUMN access_manager.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.id IS 'Primary Key';


--
-- Name: COLUMN access_manager.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN access_manager.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.organizationid IS 'Id of Organization';


--
-- Name: COLUMN access_manager.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN access_manager.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN access_manager.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN access_manager.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN access_manager.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN access_manager.accessmanagername; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.accessmanagername IS 'Name of Access Manager';


--
-- Name: COLUMN access_manager.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.description IS 'Description of Access Manager';


--
-- Name: COLUMN access_manager.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.isactive IS 'Is the access manager active or not';


--
-- Name: COLUMN access_manager.accessmanagertypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.accessmanagertypeid IS 'FK ID of access manager type';


--
-- Name: COLUMN access_manager.accessmanagerattributes; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager.accessmanagerattributes IS 'Detailed attributes of the access manager in json format #jsonb#';


--
-- Name: access_manager_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.access_manager_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.access_manager_id_seq OWNER TO abyssuser;

--
-- Name: access_manager_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.access_manager_id_seq OWNED BY abyss.access_manager.id;


--
-- Name: access_manager_type; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.access_manager_type (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    typename character varying(255) NOT NULL,
    description character varying(255),
    attributetemplate jsonb
);


ALTER TABLE abyss.access_manager_type OWNER TO abyssuser;

--
-- Name: TABLE access_manager_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.access_manager_type IS 'Abyss Platform Access Manager Types and Attribute Templates';


--
-- Name: COLUMN access_manager_type.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.id IS 'Primary Key';


--
-- Name: COLUMN access_manager_type.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN access_manager_type.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.organizationid IS 'Id of Organization';


--
-- Name: COLUMN access_manager_type.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN access_manager_type.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN access_manager_type.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN access_manager_type.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN access_manager_type.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN access_manager_type.typename; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.typename IS 'Access Manager Type Name';


--
-- Name: COLUMN access_manager_type.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.description IS 'Description of Access Manager Type';


--
-- Name: COLUMN access_manager_type.attributetemplate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.attributetemplate IS 'Access Manager Attributes Template';


--
-- Name: access_manager_type_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.access_manager_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.access_manager_type_id_seq OWNER TO abyssuser;

--
-- Name: access_manager_type_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.access_manager_type_id_seq OWNED BY abyss.access_manager_type.id;


--
-- Name: api_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.api_seq OWNER TO abyssuser;

--
-- Name: api; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api (
    id integer DEFAULT nextval('abyss.api_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    isproxyapi boolean DEFAULT false NOT NULL,
    apistateid uuid NOT NULL,
    apivisibilityid uuid NOT NULL,
    languagename character varying(64) NOT NULL,
    languageversion character varying(64) NOT NULL,
    languageformat integer DEFAULT 0 NOT NULL,
    originaldocument text NOT NULL,
    openapidocument jsonb NOT NULL,
    extendeddocument jsonb DEFAULT '{}'::json,
    businessapiid uuid,
    image text,
    color character varying(64) DEFAULT '#006699'::character varying,
    deployed timestamp without time zone,
    changelog text,
    apioriginuuid uuid,
    version character varying(255),
    issandbox boolean DEFAULT false NOT NULL,
    islive boolean DEFAULT false NOT NULL,
    isdefaultversion boolean DEFAULT false NOT NULL,
    islatestversion boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.api OWNER TO abyssuser;

--
-- Name: TABLE api; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api IS 'APIs of Abyss Platform Subjects';


--
-- Name: COLUMN api.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.id IS 'Primary Key - ID of Specific API Version';


--
-- Name: COLUMN api.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.subjectid IS 'FK ID of owner Subject';


--
-- Name: COLUMN api.isproxyapi; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.isproxyapi IS 'Type of API. False - Business API, True - API Proxy';


--
-- Name: COLUMN api.apistateid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.apistateid IS 'FK ID of State of Business API';


--
-- Name: COLUMN api.apivisibilityid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.apivisibilityid IS 'ID of Business API Visibility - Private, Closed Group, Public, ...';


--
-- Name: COLUMN api.languagename; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.languagename IS 'Formal API Description Language - Swagger, OpenAPI, RAML, WADL, WSDL, ...';


--
-- Name: COLUMN api.languageversion; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.languageversion IS 'Version of Description Language';


--
-- Name: COLUMN api.languageformat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.languageformat IS 'Data format type. 0 - JSON, 1 - YAML, 2 - XML';


--
-- Name: COLUMN api.originaldocument; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.originaldocument IS 'Original API DSL Document';


--
-- Name: COLUMN api.openapidocument; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.openapidocument IS 'Transformed API DSL document in Open API json format. Shareable. #jsonb#';


--
-- Name: COLUMN api.extendeddocument; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.extendeddocument IS 'Extended OpenAPI document of Abyss Platform changed both for Business API registration and Proxy API creation. Private. #jsonb#';


--
-- Name: COLUMN api.businessapiid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.businessapiid IS 'FK ID of Business API for API Proxies';


--
-- Name: COLUMN api.image; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.image IS 'Image data of Business API';


--
-- Name: COLUMN api.color; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.color IS 'Color of Business API';


--
-- Name: COLUMN api.deployed; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.deployed IS 'Deployed Date Time of API';


--
-- Name: COLUMN api.changelog; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.changelog IS 'Release notes and change log of API';


--
-- Name: COLUMN api.apioriginuuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.apioriginuuid IS 'Origin ID of this API version';


--
-- Name: COLUMN api.version; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.version IS 'Version of API';


--
-- Name: COLUMN api.issandbox; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.issandbox IS 'Is API Sandbox';


--
-- Name: COLUMN api.islive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.islive IS 'Is API Live';


--
-- Name: COLUMN api.isdefaultversion; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.isdefaultversion IS 'Is this API Version Default';


--
-- Name: COLUMN api.islatestversion; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.islatestversion IS 'Is this API Version Latest';


--
-- Name: api__api_category; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api__api_category (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    apiid uuid NOT NULL,
    apicategoryid uuid NOT NULL
);


ALTER TABLE abyss.api__api_category OWNER TO abyssuser;

--
-- Name: TABLE api__api_category; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api__api_category IS 'Many to many relationship table between Business API - API Category';


--
-- Name: COLUMN api__api_category.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.id IS 'Primary Key';


--
-- Name: COLUMN api__api_category.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api__api_category.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api__api_category.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api__api_category.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api__api_category.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api__api_category.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api__api_category.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api__api_category.apiid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.apiid IS 'FK UUID of API for many to many relationship of API categories';


--
-- Name: COLUMN api__api_category.apicategoryid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_category.apicategoryid IS 'FK UUID of API category for many to many relationship of API categories';


--
-- Name: api__api_category_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api__api_category_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.api__api_category_id_seq OWNER TO abyssuser;

--
-- Name: api__api_category_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.api__api_category_id_seq OWNED BY abyss.api__api_category.id;


--
-- Name: api__api_group; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api__api_group (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    apiid uuid NOT NULL,
    apigroupid uuid NOT NULL
);


ALTER TABLE abyss.api__api_group OWNER TO abyssuser;

--
-- Name: TABLE api__api_group; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api__api_group IS 'Many to many relationship table between Business API - API Group';


--
-- Name: COLUMN api__api_group.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.id IS 'Primary Key';


--
-- Name: COLUMN api__api_group.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api__api_group.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api__api_group.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api__api_group.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api__api_group.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api__api_group.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api__api_group.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api__api_group.apiid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.apiid IS 'FK UUID of API for many to many relationship of API groups';


--
-- Name: COLUMN api__api_group.apigroupid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_group.apigroupid IS 'FK UUID of API Group for many to many relationship of API groups';


--
-- Name: api__api_group_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api__api_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.api__api_group_id_seq OWNER TO abyssuser;

--
-- Name: api__api_group_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.api__api_group_id_seq OWNED BY abyss.api__api_group.id;


--
-- Name: api__api_tag; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api__api_tag (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    apiid uuid NOT NULL,
    apitagid uuid NOT NULL
);


ALTER TABLE abyss.api__api_tag OWNER TO abyssuser;

--
-- Name: TABLE api__api_tag; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api__api_tag IS 'Many to many relationship table between Business API - API Tag';


--
-- Name: COLUMN api__api_tag.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.id IS 'Primary Key';


--
-- Name: COLUMN api__api_tag.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api__api_tag.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api__api_tag.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api__api_tag.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api__api_tag.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api__api_tag.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api__api_tag.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api__api_tag.apiid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.apiid IS 'FK UUID of API for many to many relationship of API tags';


--
-- Name: COLUMN api__api_tag.apitagid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api__api_tag.apitagid IS 'FK UUID of API tags for many to many relationship of API tags';


--
-- Name: api__api_tag_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api__api_tag_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.api__api_tag_id_seq OWNER TO abyssuser;

--
-- Name: api__api_tag_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.api__api_tag_id_seq OWNED BY abyss.api__api_tag.id;


--
-- Name: api_category_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api_category_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.api_category_seq OWNER TO abyssuser;

--
-- Name: api_category; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api_category (
    id integer DEFAULT nextval('abyss.api_category_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255)
);


ALTER TABLE abyss.api_category OWNER TO abyssuser;

--
-- Name: TABLE api_category; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api_category IS 'Abyss Platform Entity Groups of Subjects';


--
-- Name: COLUMN api_category.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.id IS 'Primary Key';


--
-- Name: COLUMN api_category.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api_category.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api_category.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api_category.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api_category.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api_category.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api_category.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api_category.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.name IS 'Name of tag';


--
-- Name: COLUMN api_category.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_category.description IS 'Description of group';


--
-- Name: api_group_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api_group_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.api_group_seq OWNER TO abyssuser;

--
-- Name: api_group; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api_group (
    id integer DEFAULT nextval('abyss.api_group_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255)
);


ALTER TABLE abyss.api_group OWNER TO abyssuser;

--
-- Name: TABLE api_group; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api_group IS 'Abyss Platform Entity Groups of Subjects';


--
-- Name: COLUMN api_group.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.id IS 'Primary Key';


--
-- Name: COLUMN api_group.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api_group.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api_group.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.created IS 'Timestamp of creation';


--
-- Name: COLUMN api_group.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.updated IS 'Timestamp of update';


--
-- Name: COLUMN api_group.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.deleted IS 'Timestamp of deletion';


--
-- Name: COLUMN api_group.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.isdeleted IS 'Is record logically deleted';


--
-- Name: COLUMN api_group.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api_group.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.subjectid IS 'FK ID of Subject Owning the API Group';


--
-- Name: COLUMN api_group.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.name IS 'Name of tag';


--
-- Name: COLUMN api_group.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_group.description IS 'Description of group';


--
-- Name: api_license_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api_license_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.api_license_id_seq OWNER TO abyssuser;

--
-- Name: api_license; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api_license (
    id integer DEFAULT nextval('abyss.api_license_id_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    apiid uuid NOT NULL,
    licenseid uuid NOT NULL
);


ALTER TABLE abyss.api_license OWNER TO abyssuser;

--
-- Name: TABLE api_license; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api_license IS 'Abyss Platform Api Licenses';


--
-- Name: COLUMN api_license.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.id IS 'Primary Key';


--
-- Name: COLUMN api_license.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api_license.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api_license.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api_license.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api_license.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api_license.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api_license.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api_license.apiid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.apiid IS 'FK ID of owning api';


--
-- Name: COLUMN api_license.licenseid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.licenseid IS 'FK ID of license';


--
-- Name: api_state; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api_state (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(500) NOT NULL
);


ALTER TABLE abyss.api_state OWNER TO abyssuser;

--
-- Name: TABLE api_state; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api_state IS 'Common properties and columns for Abyss Platform Entities';


--
-- Name: COLUMN api_state.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.id IS 'Primary Key';


--
-- Name: COLUMN api_state.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api_state.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api_state.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api_state.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api_state.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api_state.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api_state.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api_state.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.name IS 'Name of API State';


--
-- Name: COLUMN api_state.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_state.description IS 'Description of API State';


--
-- Name: api_state_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.api_state_id_seq OWNER TO abyssuser;

--
-- Name: api_state_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.api_state_id_seq OWNED BY abyss.api_state.id;


--
-- Name: api_tag_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api_tag_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.api_tag_seq OWNER TO abyssuser;

--
-- Name: api_tag; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api_tag (
    id integer DEFAULT nextval('abyss.api_tag_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    externaldescription text,
    externalurl character varying(255)
);


ALTER TABLE abyss.api_tag OWNER TO abyssuser;

--
-- Name: TABLE api_tag; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api_tag IS 'Abyss Platform API Tags - In sync to OpenAPI 3.0 Tag Model';


--
-- Name: COLUMN api_tag.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.id IS 'Primary Key';


--
-- Name: COLUMN api_tag.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api_tag.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api_tag.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api_tag.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api_tag.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api_tag.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api_tag.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api_tag.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.name IS 'Name of tag';


--
-- Name: COLUMN api_tag.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.description IS 'Description of group';


--
-- Name: COLUMN api_tag.externaldescription; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.externaldescription IS 'Description of External Documentation';


--
-- Name: COLUMN api_tag.externalurl; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_tag.externalurl IS 'URL of External Documentation';


--
-- Name: api_visibility_type; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.api_visibility_type (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(64) NOT NULL,
    description character varying(255) NOT NULL
);


ALTER TABLE abyss.api_visibility_type OWNER TO abyssuser;

--
-- Name: TABLE api_visibility_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.api_visibility_type IS 'Abyss Platform Visibility Type of APIs, APPs and other entities';


--
-- Name: COLUMN api_visibility_type.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.id IS 'Primary Key';


--
-- Name: COLUMN api_visibility_type.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN api_visibility_type.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.organizationid IS 'Id of Organization';


--
-- Name: COLUMN api_visibility_type.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN api_visibility_type.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN api_visibility_type.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN api_visibility_type.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN api_visibility_type.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN api_visibility_type.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.name IS 'Name of API Visibility Type - Private, Closed Group, Public, ...';


--
-- Name: COLUMN api_visibility_type.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_visibility_type.description IS 'Description of API visibility type';


--
-- Name: api_visibility_type_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.api_visibility_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.api_visibility_type_id_seq OWNER TO abyssuser;

--
-- Name: api_visibility_type_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.api_visibility_type_id_seq OWNED BY abyss.api_visibility_type.id;


--
-- Name: attribute; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.attribute (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    attributetype smallint NOT NULL,
    name text NOT NULL,
    description text,
    semantictag text,
    domaincategory character varying(255) NOT NULL,
    hierarchytreeid uuid
);


ALTER TABLE abyss.attribute OWNER TO abyssuser;

--
-- Name: TABLE attribute; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.attribute IS 'Abyss Platform Privacy Identifiers, Quasi Identifiers, Sensitive Attributes';


--
-- Name: COLUMN attribute.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.id IS 'Primary Key';


--
-- Name: COLUMN attribute.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN attribute.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.organizationid IS 'Id of Organization';


--
-- Name: COLUMN attribute.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN attribute.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN attribute.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN attribute.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN attribute.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN attribute.attributetype; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.attributetype IS 'Attribute Type. Bit 0 ID. Bit 1 QID. Bit 2 Sensitive
000 - Auxilary
001 1 - ID
010 2 - QID
100 4 - S
110 6 - S + QID';


--
-- Name: COLUMN attribute.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.name IS 'Name of Attribute';


--
-- Name: COLUMN attribute.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.description IS 'Description';


--
-- Name: COLUMN attribute.semantictag; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.semantictag IS 'Semantic Tag';


--
-- Name: COLUMN attribute.domaincategory; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.domaincategory IS 'Domain Category - Numeric, Categorical, Ordinal';


--
-- Name: COLUMN attribute.hierarchytreeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute.hierarchytreeid IS 'FK ID of Hierarchy Tree';


--
-- Name: attribute_has; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.attribute_has (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    attributeid uuid NOT NULL,
    attributepatternid uuid NOT NULL
);


ALTER TABLE abyss.attribute_has OWNER TO abyssuser;

--
-- Name: TABLE attribute_has; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.attribute_has IS 'Abyss Platform Attributes Patterns';


--
-- Name: COLUMN attribute_has.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.id IS 'Primary Key';


--
-- Name: COLUMN attribute_has.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN attribute_has.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.organizationid IS 'Id of Organization';


--
-- Name: COLUMN attribute_has.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN attribute_has.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN attribute_has.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN attribute_has.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN attribute_has.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN attribute_has.attributeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.attributeid IS 'FK ID of Privacy Attribute';


--
-- Name: COLUMN attribute_has.attributepatternid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_has.attributepatternid IS 'FK ID of Privacy Attribute Pattern Id';


--
-- Name: attribute_has_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.attribute_has_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.attribute_has_id_seq OWNER TO abyssuser;

--
-- Name: attribute_has_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.attribute_has_id_seq OWNED BY abyss.attribute_has.id;


--
-- Name: attribute_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.attribute_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.attribute_id_seq OWNER TO abyssuser;

--
-- Name: attribute_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.attribute_id_seq OWNED BY abyss.attribute.id;


--
-- Name: attribute_pattern; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.attribute_pattern (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    description text,
    pattern text,
    maskingpattern text
);


ALTER TABLE abyss.attribute_pattern OWNER TO abyssuser;

--
-- Name: TABLE attribute_pattern; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.attribute_pattern IS 'Abyss Platform Attribute Patterns';


--
-- Name: COLUMN attribute_pattern.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.id IS 'Primary Key';


--
-- Name: COLUMN attribute_pattern.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN attribute_pattern.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.organizationid IS 'Id of Organization';


--
-- Name: COLUMN attribute_pattern.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN attribute_pattern.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN attribute_pattern.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN attribute_pattern.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN attribute_pattern.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN attribute_pattern.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.description IS 'Description of pattern';


--
-- Name: COLUMN attribute_pattern.pattern; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.pattern IS 'Pattern of Attribute in regex format';


--
-- Name: COLUMN attribute_pattern.maskingpattern; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.attribute_pattern.maskingpattern IS 'Masking Pattern of Attribute';


--
-- Name: attribute_pattern_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.attribute_pattern_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.attribute_pattern_id_seq OWNER TO abyssuser;

--
-- Name: attribute_pattern_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.attribute_pattern_id_seq OWNED BY abyss.attribute_pattern.id;


--
-- Name: contract_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.contract_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.contract_seq OWNER TO abyssuser;

--
-- Name: contract; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.contract (
    id integer DEFAULT nextval('abyss.contract_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(2048),
    apiid uuid NOT NULL,
    subjectid uuid NOT NULL,
    environment character varying(255) NOT NULL,
    contractstateid uuid NOT NULL,
    status abyss.e_contract_status DEFAULT 'draft'::abyss.e_contract_status NOT NULL,
    isrestrictedtosubsetofapi boolean DEFAULT false NOT NULL,
    licenseid uuid NOT NULL,
    subjectpermissionid uuid NOT NULL
);


ALTER TABLE abyss.contract OWNER TO abyssuser;

--
-- Name: TABLE contract; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.contract IS 'Abyss Platform Contracts between USER, ORG, APP and API, PRODUCT';


--
-- Name: COLUMN contract.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.id IS 'Primary Key';


--
-- Name: COLUMN contract.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN contract.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.organizationid IS 'Id of Organization';


--
-- Name: COLUMN contract.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN contract.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN contract.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN contract.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN contract.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN contract.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.name IS 'Name of contract';


--
-- Name: COLUMN contract.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.description IS 'The text description of the contract';


--
-- Name: COLUMN contract.apiid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.apiid IS 'FK ID of API Version that this contract binds';


--
-- Name: COLUMN contract.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.subjectid IS 'FK ID of Subject / App that this contract binds';


--
-- Name: COLUMN contract.environment; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.environment IS 'Environment that the contract relates to (Sandbox or Production).';


--
-- Name: COLUMN contract.contractstateid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.contractstateid IS 'FK ID of the current state of the contract.

The state values for an API contract are

pending_approval
config_pending (used only in certain custom workflow scenarios or in LaaS integration)
approved
activated
rejected
resubmitted
suspended
cancelled';


--
-- Name: COLUMN contract.status; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.status IS 'The status of the contract.
draft - Indicates the contract has not yet been activated. workflow status of Pending Approval, Approved, and any other state before the contract is activated will have this status value.
inforce - Indicates that the contract is either Active or Suspended.
archived - Indicates that the active life of the contract is over. The workflow status of Cancelled, adn any other action that results in the cancellation of the contract (such as deletion of the app or API) will have this status value';


--
-- Name: COLUMN contract.isrestrictedtosubsetofapi; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.isrestrictedtosubsetofapi IS 'Is app''s access to the API is restricted to a subset of the API';


--
-- Name: COLUMN contract.licenseid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.licenseid IS 'FK ID of license';


--
-- Name: COLUMN contract.subjectpermissionid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract.subjectpermissionid IS 'FK ID of Subject Permission';


--
-- Name: contract_state; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.contract_state (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text
);


ALTER TABLE abyss.contract_state OWNER TO abyssuser;

--
-- Name: TABLE contract_state; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.contract_state IS 'Abyss Platform Contract States';


--
-- Name: COLUMN contract_state.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.id IS 'Primary Key';


--
-- Name: COLUMN contract_state.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN contract_state.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.organizationid IS 'Id of Organization';


--
-- Name: COLUMN contract_state.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN contract_state.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN contract_state.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN contract_state.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN contract_state.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN contract_state.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.name IS 'Name of Contract State';


--
-- Name: COLUMN contract_state.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.contract_state.description IS 'Description of Contract State';


--
-- Name: contract_state_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.contract_state_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.contract_state_id_seq OWNER TO abyssuser;

--
-- Name: contract_state_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.contract_state_id_seq OWNED BY abyss.contract_state.id;


--
-- Name: conversationid_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.conversationid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.conversationid_seq OWNER TO abyssuser;

--
-- Name: dashboard; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.dashboard (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    ownersubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    ispublic boolean DEFAULT false NOT NULL,
    widgets jsonb
);


ALTER TABLE abyss.dashboard OWNER TO abyssuser;

--
-- Name: TABLE dashboard; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.dashboard IS 'Abyss Platform Dashboards';


--
-- Name: COLUMN dashboard.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.id IS 'Primary Key';


--
-- Name: COLUMN dashboard.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN dashboard.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.organizationid IS 'Id of Organization';


--
-- Name: COLUMN dashboard.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN dashboard.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN dashboard.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN dashboard.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN dashboard.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN dashboard.ownersubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.ownersubjectid IS 'FK ID of Subject owning the dashboard';


--
-- Name: COLUMN dashboard.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.name IS 'Name of dashboard';


--
-- Name: COLUMN dashboard.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.description IS 'Description of dashboard';


--
-- Name: COLUMN dashboard.ispublic; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.ispublic IS 'Is dashboard public or sharable';


--
-- Name: COLUMN dashboard.widgets; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.dashboard.widgets IS 'Array of wigdets configurations';


--
-- Name: dashboard_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.dashboard_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.dashboard_id_seq OWNER TO abyssuser;

--
-- Name: dashboard_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.dashboard_id_seq OWNED BY abyss.dashboard.id;


--
-- Name: generalization_hierarchy; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.generalization_hierarchy (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    hierarchytree jsonb NOT NULL
);


ALTER TABLE abyss.generalization_hierarchy OWNER TO abyssuser;

--
-- Name: TABLE generalization_hierarchy; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.generalization_hierarchy IS 'Abyss Platform Generalization Hierarchy of Quasi Identifiers for Privacy';


--
-- Name: COLUMN generalization_hierarchy.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.id IS 'Primary Key';


--
-- Name: COLUMN generalization_hierarchy.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN generalization_hierarchy.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.organizationid IS 'Id of Organization';


--
-- Name: COLUMN generalization_hierarchy.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN generalization_hierarchy.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN generalization_hierarchy.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN generalization_hierarchy.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN generalization_hierarchy.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN generalization_hierarchy.hierarchytree; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.hierarchytree IS 'Hierarchy Tree of the Attribute';


--
-- Name: generalization_hierarchy_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.generalization_hierarchy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.generalization_hierarchy_id_seq OWNER TO abyssuser;

--
-- Name: generalization_hierarchy_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.generalization_hierarchy_id_seq OWNED BY abyss.generalization_hierarchy.id;


--
-- Name: license; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.license (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    version character varying(255) NOT NULL,
    subjectid uuid NOT NULL,
    licensedocument jsonb
);


ALTER TABLE abyss.license OWNER TO abyssuser;

--
-- Name: TABLE license; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.license IS 'Abyss Platform Licenses';


--
-- Name: COLUMN license.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.id IS 'Primary Key';


--
-- Name: COLUMN license.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN license.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.organizationid IS 'Id of Organization';


--
-- Name: COLUMN license.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN license.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN license.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN license.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN license.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN license.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.name IS 'Name of License';


--
-- Name: COLUMN license.version; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.version IS 'Version of license';


--
-- Name: COLUMN license.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.subjectid IS 'FK ID of owing Subject';


--
-- Name: COLUMN license.licensedocument; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.licensedocument IS 'License of contract. A license is a tailored API access package designed by the Business Admin/API Admin and offered to the app developer. A license includes one or more license terms, each of which can include multiple scopes, giving access to specifically designated operations, and multiple quality of service (QoS) policies, and also one or more legal agreements applicable to the license.
Terms of Service - QoS, SLA
Legal';


--
-- Name: license_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.license_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.license_id_seq OWNER TO abyssuser;

--
-- Name: license_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.license_id_seq OWNED BY abyss.license.id;


--
-- Name: message; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.message (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    messagetypeid uuid NOT NULL,
    parentmessageid uuid,
    ownersubjectid uuid NOT NULL,
    conversationid bigint DEFAULT nextval('abyss.conversationid_seq'::regclass) NOT NULL,
    folder text NOT NULL,
    sender jsonb NOT NULL,
    receiver jsonb NOT NULL,
    subject text NOT NULL,
    bodycontenttype text NOT NULL,
    body text NOT NULL,
    priority character varying(255) NOT NULL,
    isstarred boolean DEFAULT false NOT NULL,
    isread boolean DEFAULT false NOT NULL,
    sentat timestamp without time zone DEFAULT now(),
    readat timestamp without time zone,
    istrashed boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.message OWNER TO abyssuser;

--
-- Name: TABLE message; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.message IS 'Abyss Platform Messages';


--
-- Name: COLUMN message.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.id IS 'Primary Key';


--
-- Name: COLUMN message.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN message.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.organizationid IS 'Id of Organization';


--
-- Name: COLUMN message.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN message.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN message.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN message.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN message.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN message.messagetypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.messagetypeid IS 'FK ID of Message Type';


--
-- Name: COLUMN message.parentmessageid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.parentmessageid IS 'Parent Message Id. New message is null. Reply messages not null.';


--
-- Name: COLUMN message.ownersubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.ownersubjectid IS 'FK ID of Subject owning the message';


--
-- Name: COLUMN message.conversationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.conversationid IS 'Identifier of the conversation chain';


--
-- Name: COLUMN message.folder; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.folder IS 'Folder that the message resides in. INBOX, SENT, DRAFT, TRASH.';


--
-- Name: COLUMN message.sender; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.sender IS 'Sender Subject';


--
-- Name: COLUMN message.receiver; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.receiver IS 'Receiver Subject';


--
-- Name: COLUMN message.subject; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.subject IS 'Message Subject';


--
-- Name: COLUMN message.bodycontenttype; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.bodycontenttype IS 'Content Type of Message Body';


--
-- Name: COLUMN message.body; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.body IS 'Message Body stored as Markdown format';


--
-- Name: COLUMN message.priority; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.priority IS 'High, Normal, Low Importance';


--
-- Name: COLUMN message.isstarred; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.isstarred IS 'Is the message starred';


--
-- Name: COLUMN message.isread; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.isread IS 'Is Message Read';


--
-- Name: COLUMN message.sentat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.sentat IS 'Message Sent Timestamp';


--
-- Name: COLUMN message.readat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.readat IS 'Message Read Timestamp';


--
-- Name: COLUMN message.istrashed; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message.istrashed IS 'Is Message Trashed';


--
-- Name: message_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.message_id_seq OWNER TO abyssuser;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.message_id_seq OWNED BY abyss.message.id;


--
-- Name: message_type; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.message_type (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.message_type OWNER TO abyssuser;

--
-- Name: TABLE message_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.message_type IS 'Abyss Platform Message Types';


--
-- Name: COLUMN message_type.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.id IS 'Primary Key';


--
-- Name: COLUMN message_type.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN message_type.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.organizationid IS 'Id of Organization';


--
-- Name: COLUMN message_type.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN message_type.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN message_type.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN message_type.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN message_type.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN message_type.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.name IS 'Name of Message Type';


--
-- Name: COLUMN message_type.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.description IS 'Description of Message TYpe';


--
-- Name: COLUMN message_type.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.message_type.isactive IS 'Is Message Type Active';


--
-- Name: message_type_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.message_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.message_type_id_seq OWNER TO abyssuser;

--
-- Name: message_type_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.message_type_id_seq OWNED BY abyss.message_type.id;


--
-- Name: organization_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.organization_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.organization_seq OWNER TO abyssuser;

--
-- Name: organization; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.organization (
    id integer DEFAULT nextval('abyss.organization_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description text,
    url character varying(255)
);


ALTER TABLE abyss.organization OWNER TO abyssuser;

--
-- Name: TABLE organization; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.organization IS 'Abyss Platform Organization Entity';


--
-- Name: COLUMN organization.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.id IS 'Primary Key';


--
-- Name: COLUMN organization.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN organization.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.organizationid IS 'Id of Organization';


--
-- Name: COLUMN organization.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN organization.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN organization.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN organization.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN organization.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN organization.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.name IS 'Name of organization';


--
-- Name: COLUMN organization.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.description IS 'Description of organization';


--
-- Name: COLUMN organization.url; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.url IS 'URL / Website of Organization';


--
-- Name: policy_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.policy_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.policy_id_seq OWNER TO abyssuser;

--
-- Name: policy; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.policy (
    id integer DEFAULT nextval('abyss.policy_id_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(2048),
    policyinstance jsonb NOT NULL,
    typeid uuid NOT NULL
);


ALTER TABLE abyss.policy OWNER TO abyssuser;

--
-- Name: TABLE policy; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.policy IS 'Abyss Platform Policy';


--
-- Name: COLUMN policy.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.id IS 'Primary Key';


--
-- Name: COLUMN policy.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN policy.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.organizationid IS 'Id of Organization';


--
-- Name: COLUMN policy.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN policy.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN policy.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN policy.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN policy.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN policy.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.subjectid IS 'FK ID of Subject / App that this contract binds';


--
-- Name: COLUMN policy.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.name IS 'Name of policy';


--
-- Name: COLUMN policy.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.description IS 'Description of policy';


--
-- Name: COLUMN policy.policyinstance; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.policyinstance IS 'Instance of Policy in Json Format #jsonb#';


--
-- Name: COLUMN policy.typeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.typeid IS 'FK ID of Policy Type';


--
-- Name: policy_type_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.policy_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.policy_type_seq OWNER TO abyssuser;

--
-- Name: policy_type; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.policy_type (
    id integer DEFAULT nextval('abyss.policy_type_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(2048),
    type character varying(255) NOT NULL,
    subtype character varying(255),
    template jsonb NOT NULL
);


ALTER TABLE abyss.policy_type OWNER TO abyssuser;

--
-- Name: TABLE policy_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.policy_type IS 'Abyss Platform Policy Types';


--
-- Name: COLUMN policy_type.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.id IS 'Primary Key';


--
-- Name: COLUMN policy_type.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN policy_type.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.organizationid IS 'Id of Organization';


--
-- Name: COLUMN policy_type.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN policy_type.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN policy_type.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN policy_type.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN policy_type.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN policy_type.name; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.name IS 'Name of policy';


--
-- Name: COLUMN policy_type.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.description IS 'Description of policy';


--
-- Name: COLUMN policy_type.type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.type IS 'Type of Policy - Operational, Service Level, Compliance, Denial of Service ...';


--
-- Name: COLUMN policy_type.subtype; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.subtype IS 'Sub Type of Policy - API Security, Auditing, CORS, OAuth, Logging, ...';


--
-- Name: COLUMN policy_type.template; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.template IS 'Template of Policy in Json Format #jsonb#';


--
-- Name: preferences; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.preferences (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    uisettings jsonb NOT NULL,
    activedashboardid uuid
);


ALTER TABLE abyss.preferences OWNER TO abyssuser;

--
-- Name: TABLE preferences; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.preferences IS 'Abyss Platform User Preferences';


--
-- Name: COLUMN preferences.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.id IS 'Primary Key';


--
-- Name: COLUMN preferences.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN preferences.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.organizationid IS 'Id of Organization';


--
-- Name: COLUMN preferences.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN preferences.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN preferences.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN preferences.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN preferences.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN preferences.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.subjectid IS 'FK ID of Subject owning the preferences';


--
-- Name: COLUMN preferences.uisettings; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.uisettings IS 'UI settings configuration of the user';


--
-- Name: COLUMN preferences.activedashboardid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.preferences.activedashboardid IS 'ID of active dashboard';


--
-- Name: preferences_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.preferences_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.preferences_id_seq OWNER TO abyssuser;

--
-- Name: preferences_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.preferences_id_seq OWNED BY abyss.preferences.id;


--
-- Name: quasi_id_set; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.quasi_id_set (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    qidlist text NOT NULL
);


ALTER TABLE abyss.quasi_id_set OWNER TO abyssuser;

--
-- Name: TABLE quasi_id_set; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.quasi_id_set IS 'Abyss Platform Sets of Quasi IDs';


--
-- Name: COLUMN quasi_id_set.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.id IS 'Primary Key';


--
-- Name: COLUMN quasi_id_set.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN quasi_id_set.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.organizationid IS 'Id of Organization';


--
-- Name: COLUMN quasi_id_set.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN quasi_id_set.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN quasi_id_set.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN quasi_id_set.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN quasi_id_set.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN quasi_id_set.qidlist; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.quasi_id_set.qidlist IS 'Delimited Ordered List of Attribute.ID
Query possible with LIKE %.3.% and like %.10.%
Format -> .3.5.10.13.33.';


--
-- Name: quasi_id_set_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.quasi_id_set_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.quasi_id_set_id_seq OWNER TO abyssuser;

--
-- Name: quasi_id_set_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.quasi_id_set_id_seq OWNED BY abyss.quasi_id_set.id;


--
-- Name: resource_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.resource_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.resource_seq OWNER TO abyssuser;

--
-- Name: resource; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.resource (
    id integer DEFAULT nextval('abyss.resource_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    resourcetypeid uuid NOT NULL,
    resourcename character varying(255) NOT NULL,
    description character varying(1024) NOT NULL,
    resourcerefid uuid,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.resource OWNER TO abyssuser;

--
-- Name: TABLE resource; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.resource IS 'Abyss Platform Protected Resources';


--
-- Name: COLUMN resource.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.id IS 'Primary Key';


--
-- Name: COLUMN resource.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN resource.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.organizationid IS 'Id of Organization';


--
-- Name: COLUMN resource.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN resource.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN resource.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN resource.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN resource.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN resource.resourcetypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.resourcetypeid IS 'FK ID of resource type';


--
-- Name: COLUMN resource.resourcename; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.resourcename IS 'Name of protected resource';


--
-- Name: COLUMN resource.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.description IS 'Description of resource';


--
-- Name: COLUMN resource.resourcerefid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.resourcerefid IS 'FK ID of the resource with the designated type';


--
-- Name: COLUMN resource.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.isactive IS 'Is Resource Active';


--
-- Name: resource_access_token; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.resource_access_token (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectpermissionid uuid NOT NULL,
    resourcetypeid uuid NOT NULL,
    resourcerefid uuid NOT NULL,
    token text NOT NULL,
    expiredate timestamp without time zone NOT NULL,
    email character varying(255),
    nonce character varying(255) NOT NULL,
    userdata character varying(255) NOT NULL,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.resource_access_token OWNER TO abyssuser;

--
-- Name: TABLE resource_access_token; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.resource_access_token IS 'Access Tokens of Abyss Platform Resources';


--
-- Name: COLUMN resource_access_token.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.id IS 'Primary Key';


--
-- Name: COLUMN resource_access_token.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN resource_access_token.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.organizationid IS 'Id of Organization';


--
-- Name: COLUMN resource_access_token.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN resource_access_token.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN resource_access_token.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN resource_access_token.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN resource_access_token.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN resource_access_token.subjectpermissionid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.subjectpermissionid IS 'FK ID of corresponding subject permission';


--
-- Name: COLUMN resource_access_token.resourcetypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.resourcetypeid IS 'FK ID of resource type that specifies type of token';


--
-- Name: COLUMN resource_access_token.resourcerefid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.resourcerefid IS 'FK ID of the resource with the designated resource type';


--
-- Name: COLUMN resource_access_token.token; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.token IS 'Activation token';


--
-- Name: COLUMN resource_access_token.expiredate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.expiredate IS 'Expire date of activation code';


--
-- Name: COLUMN resource_access_token.email; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.email IS 'The email address that token is sent to';


--
-- Name: COLUMN resource_access_token.nonce; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.nonce IS 'The number used only once in the token generation process';


--
-- Name: COLUMN resource_access_token.userdata; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.userdata IS 'User Data used in token generation process';


--
-- Name: COLUMN resource_access_token.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_access_token.isactive IS 'Is Token Active';


--
-- Name: resource_access_token_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.resource_access_token_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.resource_access_token_id_seq OWNER TO abyssuser;

--
-- Name: resource_access_token_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.resource_access_token_id_seq OWNED BY abyss.resource_access_token.id;


--
-- Name: resource_action_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.resource_action_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 50;


ALTER TABLE abyss.resource_action_seq OWNER TO abyssuser;

--
-- Name: resource_action; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.resource_action (
    id integer DEFAULT nextval('abyss.resource_action_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    actionname character varying(255) NOT NULL,
    description character varying(1024) NOT NULL,
    resourcetypeid uuid NOT NULL,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.resource_action OWNER TO abyssuser;

--
-- Name: TABLE resource_action; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.resource_action IS 'Abyss Platform Resource Actions';


--
-- Name: COLUMN resource_action.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.id IS 'Primary Key';


--
-- Name: COLUMN resource_action.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN resource_action.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.organizationid IS 'Id of Organization';


--
-- Name: COLUMN resource_action.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.created IS 'Timestamp of creation';


--
-- Name: COLUMN resource_action.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.updated IS 'Timestamp of update';


--
-- Name: COLUMN resource_action.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.deleted IS 'Timestamp of deletion';


--
-- Name: COLUMN resource_action.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.isdeleted IS 'Is record logically deleted';


--
-- Name: COLUMN resource_action.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN resource_action.actionname; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.actionname IS 'Action Name';


--
-- Name: COLUMN resource_action.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.description IS 'Description of Action';


--
-- Name: COLUMN resource_action.resourcetypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.resourcetypeid IS 'FK ID of Resource Type';


--
-- Name: COLUMN resource_action.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_action.isactive IS 'Is Resource Action Active';


--
-- Name: resource_type; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.resource_type (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    type character varying(255) NOT NULL,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.resource_type OWNER TO abyssuser;

--
-- Name: TABLE resource_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.resource_type IS 'Abyss Platform Resource Types';


--
-- Name: COLUMN resource_type.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.id IS 'Primary Key';


--
-- Name: COLUMN resource_type.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN resource_type.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.organizationid IS 'Id of Organization';


--
-- Name: COLUMN resource_type.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.created IS 'Timestamp of creation';


--
-- Name: COLUMN resource_type.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.updated IS 'Timestamp of update';


--
-- Name: COLUMN resource_type.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.deleted IS 'Timestamp of deletion';


--
-- Name: COLUMN resource_type.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.isdeleted IS 'Is record logically deleted';


--
-- Name: COLUMN resource_type.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN resource_type.type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.type IS 'Resource Type';


--
-- Name: COLUMN resource_type.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource_type.isactive IS 'Is Resource Type Active';


--
-- Name: resource_type_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.resource_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.resource_type_id_seq OWNER TO abyssuser;

--
-- Name: resource_type_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.resource_type_id_seq OWNED BY abyss.resource_type.id;


--
-- Name: subject_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.subject_seq OWNER TO abyssuser;

--
-- Name: subject; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject (
    id integer DEFAULT nextval('abyss.subject_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    isactivated boolean DEFAULT false NOT NULL,
    subjecttypeid uuid NOT NULL,
    subjectname character varying(64) NOT NULL,
    firstname character varying(64) NOT NULL,
    lastname character varying(64) NOT NULL,
    displayname character varying(128) NOT NULL,
    email character varying(100) NOT NULL,
    secondaryemail character varying(100),
    effectivestartdate timestamp without time zone DEFAULT now() NOT NULL,
    effectiveenddate timestamp without time zone,
    password character varying(255) NOT NULL,
    passwordsalt character varying(255) NOT NULL,
    picture text,
    totallogincount integer DEFAULT 0 NOT NULL,
    failedlogincount integer DEFAULT 0 NOT NULL,
    invalidpasswordattemptcount integer DEFAULT 0 NOT NULL,
    ispasswordchangerequired boolean DEFAULT true NOT NULL,
    passwordexpiresat timestamp without time zone,
    lastloginat timestamp without time zone,
    lastpasswordchangeat timestamp without time zone,
    lastauthenticatedat timestamp without time zone,
    lastfailedloginat timestamp without time zone,
    subjectdirectoryid uuid NOT NULL,
    islocked boolean DEFAULT false,
    issandbox boolean DEFAULT false,
    url character varying(255),
    isrestrictedtoprocessing boolean DEFAULT false NOT NULL,
    description text
);


ALTER TABLE abyss.subject OWNER TO abyssuser;

--
-- Name: TABLE subject; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject IS 'User entity of the Abyss Platform IdM';


--
-- Name: COLUMN subject.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.id IS 'Primary Key';


--
-- Name: COLUMN subject.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.organizationid IS 'FK ID of Organization';


--
-- Name: COLUMN subject.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject.isactivated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.isactivated IS 'Is user activated after signup by validating secondary verification mechanism #readOnly#';


--
-- Name: COLUMN subject.subjecttypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.subjecttypeid IS 'Id of Subject Type';


--
-- Name: COLUMN subject.subjectname; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.subjectname IS 'Username of user that is going to be used as credential';


--
-- Name: COLUMN subject.firstname; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.firstname IS 'First name of user';


--
-- Name: COLUMN subject.lastname; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.lastname IS 'Surname of user';


--
-- Name: COLUMN subject.displayname; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.displayname IS 'Display name or alias of user';


--
-- Name: COLUMN subject.email; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.email IS 'Main contact email of user #email#';


--
-- Name: COLUMN subject.secondaryemail; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.secondaryemail IS 'Secondary email of user for recovering account etc. #email#';


--
-- Name: COLUMN subject.effectivestartdate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.effectivestartdate IS 'Effective start date time of user that he or she can start using the platform';


--
-- Name: COLUMN subject.effectiveenddate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.effectiveenddate IS 'Effective end date time of user that he or she can use the platform until';


--
-- Name: COLUMN subject.password; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.password IS 'Password of user that is going to be used as credential #Level:1# #writeOnly#';


--
-- Name: COLUMN subject.passwordsalt; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.passwordsalt IS 'Salt of password #Level:0#';


--
-- Name: COLUMN subject.picture; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.picture IS 'Picture of subject #base64#';


--
-- Name: COLUMN subject.totallogincount; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.totallogincount IS 'Total Login Count of Subject #readOnly#';


--
-- Name: COLUMN subject.failedlogincount; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.failedlogincount IS 'Failed Login Count of Subject #readOnly#';


--
-- Name: COLUMN subject.invalidpasswordattemptcount; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.invalidpasswordattemptcount IS 'Invalid Password Attempt Count of Subject #readOnly#';


--
-- Name: COLUMN subject.ispasswordchangerequired; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.ispasswordchangerequired IS 'Does subject have to change password #readOnly#';


--
-- Name: COLUMN subject.passwordexpiresat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.passwordexpiresat IS 'Password expire date time. After this time subject must change password is still logon else should reset password to get a new one. #readOnly#';


--
-- Name: COLUMN subject.lastloginat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.lastloginat IS 'Last login date time of subject #readOnly#';


--
-- Name: COLUMN subject.lastpasswordchangeat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.lastpasswordchangeat IS 'Last password change date time #readOnly#';


--
-- Name: COLUMN subject.lastauthenticatedat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.lastauthenticatedat IS 'Last successful authentication date time #readOnly#';


--
-- Name: COLUMN subject.lastfailedloginat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.lastfailedloginat IS 'Last failed login attempt date time #readOnly#';


--
-- Name: COLUMN subject.subjectdirectoryid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.subjectdirectoryid IS 'FK ID of Subject Directory';


--
-- Name: COLUMN subject.islocked; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.islocked IS 'Is Subject Locked / Disabled';


--
-- Name: COLUMN subject.issandbox; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.issandbox IS 'Is Subject Sandbox';


--
-- Name: COLUMN subject.url; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.url IS 'Url / Web Site Address of Subject (User or APP)';


--
-- Name: COLUMN subject.isrestrictedtoprocessing; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.isrestrictedtoprocessing IS 'Is Subject Data Restricted to Processing - GDPR Compliance';


--
-- Name: COLUMN subject.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.description IS 'Description of subject';


--
-- Name: subject_activation_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_activation_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.subject_activation_seq OWNER TO abyssuser;

--
-- Name: subject_activation; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_activation (
    id integer DEFAULT nextval('abyss.subject_activation_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    expiredate timestamp without time zone NOT NULL,
    token character varying(255) NOT NULL,
    tokentype character varying(32) NOT NULL,
    email character varying(255) NOT NULL,
    nonce character varying(255) NOT NULL,
    userdata character varying(255) NOT NULL
);


ALTER TABLE abyss.subject_activation OWNER TO abyssuser;

--
-- Name: TABLE subject_activation; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_activation IS 'Activation and reset token storage of Abyss Platform Subjects';


--
-- Name: COLUMN subject_activation.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.id IS 'Primary Key';


--
-- Name: COLUMN subject_activation.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_activation.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_activation.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_activation.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_activation.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_activation.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_activation.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_activation.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.subjectid IS 'The user that the activation code is generated';


--
-- Name: COLUMN subject_activation.expiredate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.expiredate IS 'Expire date of activation code';


--
-- Name: COLUMN subject_activation.token; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.token IS 'Activation token';


--
-- Name: COLUMN subject_activation.tokentype; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.tokentype IS 'Type of token - Activation (token.type.activation), Reset Password (token.type.reset.password)';


--
-- Name: COLUMN subject_activation.email; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.email IS 'The email address that token is sent to';


--
-- Name: COLUMN subject_activation.nonce; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.nonce IS 'The number used only once in the token generation process';


--
-- Name: COLUMN subject_activation.userdata; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_activation.userdata IS 'User Data used in token generation process';


--
-- Name: subject_apps_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_apps_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.subject_apps_seq OWNER TO abyssuser;

--
-- Name: subject_app; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_app (
    id integer DEFAULT nextval('abyss.subject_apps_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    appid uuid NOT NULL
);


ALTER TABLE abyss.subject_app OWNER TO abyssuser;

--
-- Name: TABLE subject_app; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_app IS 'Abyss Platform Apps of Subjects';


--
-- Name: COLUMN subject_app.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.id IS 'Primary Key';


--
-- Name: COLUMN subject_app.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_app.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_app.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_app.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_app.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_app.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_app.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_app.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.subjectid IS 'FK ID of Subject owning APPs';


--
-- Name: COLUMN subject_app.appid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_app.appid IS 'FK ID of APPs owned by Subjects';


--
-- Name: subject_directory_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_directory_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.subject_directory_seq OWNER TO abyssuser;

--
-- Name: subject_directory; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_directory (
    id integer DEFAULT nextval('abyss.subject_directory_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    directoryname character varying(64) NOT NULL,
    description character varying(255),
    isactive boolean DEFAULT false NOT NULL,
    istemplate boolean DEFAULT false NOT NULL,
    directorytypeid uuid NOT NULL,
    directorypriorityorder integer NOT NULL,
    directoryattributes jsonb,
    lastsyncronizedat timestamp without time zone,
    lastsyncronizationduration integer
);


ALTER TABLE abyss.subject_directory OWNER TO abyssuser;

--
-- Name: TABLE subject_directory; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_directory IS 'Abyss Platform Subject Directory';


--
-- Name: COLUMN subject_directory.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.id IS 'Primary Key';


--
-- Name: COLUMN subject_directory.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_directory.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_directory.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_directory.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_directory.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_directory.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_directory.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_directory.directoryname; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.directoryname IS 'Name of subject directory';


--
-- Name: COLUMN subject_directory.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.description IS 'Description of subject directory';


--
-- Name: COLUMN subject_directory.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.isactive IS 'Is the directory active or not';


--
-- Name: COLUMN subject_directory.istemplate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.istemplate IS 'Is the directory template or not';


--
-- Name: COLUMN subject_directory.directorytypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.directorytypeid IS 'FK ID of directory type to distinguish Internal, LDAP, AD, etc.';


--
-- Name: COLUMN subject_directory.directorypriorityorder; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.directorypriorityorder IS 'Priority Order of Subject Directory Precedence';


--
-- Name: COLUMN subject_directory.directoryattributes; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.directoryattributes IS 'Detailed attributes of the directory in json format  #jsonb#';


--
-- Name: COLUMN subject_directory.lastsyncronizedat; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.lastsyncronizedat IS 'Last syncronization date time of directory';


--
-- Name: COLUMN subject_directory.lastsyncronizationduration; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory.lastsyncronizationduration IS 'Last syncronization duration in milliseconds';


--
-- Name: subject_directory_type_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_directory_type_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.subject_directory_type_seq OWNER TO abyssuser;

--
-- Name: subject_directory_type; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_directory_type (
    id integer DEFAULT nextval('abyss.subject_directory_type_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    typename character varying(255) NOT NULL,
    description character varying(255),
    attributetemplate jsonb
);


ALTER TABLE abyss.subject_directory_type OWNER TO abyssuser;

--
-- Name: TABLE subject_directory_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_directory_type IS 'Abyss Platform Directory Types and Directory Attributes Templates';


--
-- Name: COLUMN subject_directory_type.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.id IS 'Primary Key';


--
-- Name: COLUMN subject_directory_type.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_directory_type.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_directory_type.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_directory_type.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_directory_type.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_directory_type.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_directory_type.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_directory_type.typename; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.typename IS 'Subject Directory Type Name';


--
-- Name: COLUMN subject_directory_type.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.description IS 'Description of Directory Type';


--
-- Name: COLUMN subject_directory_type.attributetemplate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.attributetemplate IS 'Directory Attributes Template';


--
-- Name: subject_membership_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_membership_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.subject_membership_seq OWNER TO abyssuser;

--
-- Name: subject_membership; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_membership (
    id integer DEFAULT nextval('abyss.subject_membership_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    subjectgroupid uuid NOT NULL
);


ALTER TABLE abyss.subject_membership OWNER TO abyssuser;

--
-- Name: TABLE subject_membership; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_membership IS 'User Membership Table for Abyss Platform Entities. Shows which user belongs to which group.';


--
-- Name: COLUMN subject_membership.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.id IS 'Primary Key';


--
-- Name: COLUMN subject_membership.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_membership.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_membership.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_membership.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_membership.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_membership.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_membership.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_membership.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.subjectid IS 'Id of Member User';


--
-- Name: COLUMN subject_membership.subjectgroupid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.subjectgroupid IS 'FK ID of Subject Group that Subject is member';


--
-- Name: subject_organization; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_organization (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid DEFAULT '3c65fafc-8f3a-4243-9c4e-2821aa32d293'::uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    subjectid uuid NOT NULL,
    organizationrefid uuid NOT NULL
);


ALTER TABLE abyss.subject_organization OWNER TO abyssuser;

--
-- Name: TABLE subject_organization; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_organization IS 'Abyss Platform Subject Organizations';


--
-- Name: COLUMN subject_organization.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.id IS 'Primary Key';


--
-- Name: COLUMN subject_organization.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_organization.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_organization.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_organization.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_organization.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_organization.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_organization.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_organization.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.subjectid IS 'FK ID of Subject';


--
-- Name: COLUMN subject_organization.organizationrefid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.organizationrefid IS 'FK ID of Organization';


--
-- Name: subject_organization_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_organization_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.subject_organization_id_seq OWNER TO abyssuser;

--
-- Name: subject_organization_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.subject_organization_id_seq OWNED BY abyss.subject_organization.id;


--
-- Name: subject_permission_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_permission_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 100;


ALTER TABLE abyss.subject_permission_seq OWNER TO abyssuser;

--
-- Name: subject_permission; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_permission (
    id integer DEFAULT nextval('abyss.subject_permission_seq'::regclass) NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    permission character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    effectivestartdate timestamp without time zone DEFAULT now() NOT NULL,
    effectiveenddate timestamp without time zone,
    subjectid uuid NOT NULL,
    resourceid uuid NOT NULL,
    resourceactionid uuid NOT NULL,
    accessmanagerid uuid NOT NULL,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.subject_permission OWNER TO abyssuser;

--
-- Name: TABLE subject_permission; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_permission IS 'User Permissions for Abyss Platform AM holding permissions given directly to user / subject';


--
-- Name: COLUMN subject_permission.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.id IS 'Primary Key';


--
-- Name: COLUMN subject_permission.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_permission.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_permission.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_permission.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_permission.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_permission.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_permission.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_permission.permission; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.permission IS 'Permission of subject';


--
-- Name: COLUMN subject_permission.description; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.description IS 'Description of permission record';


--
-- Name: COLUMN subject_permission.effectivestartdate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.effectivestartdate IS 'Effective start date time of permission that it is active';


--
-- Name: COLUMN subject_permission.effectiveenddate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.effectiveenddate IS 'Effective end date time of permission that is active until';


--
-- Name: COLUMN subject_permission.subjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.subjectid IS 'FK ID of Subject having the permission';


--
-- Name: COLUMN subject_permission.resourceid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.resourceid IS 'FK ID of Resource';


--
-- Name: COLUMN subject_permission.resourceactionid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.resourceactionid IS 'FK ID of Resource Action';


--
-- Name: COLUMN subject_permission.accessmanagerid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.accessmanagerid IS 'FK ID of Access Manager';


--
-- Name: COLUMN subject_permission.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_permission.isactive IS 'Is Subject Permission Active';


--
-- Name: subject_type; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subject_type (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    typename character varying(64) NOT NULL,
    typedescription character varying(255) NOT NULL
);


ALTER TABLE abyss.subject_type OWNER TO abyssuser;

--
-- Name: TABLE subject_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_type IS 'Common properties and columns for Abyss Platform Entities';


--
-- Name: COLUMN subject_type.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.id IS 'Primary Key';


--
-- Name: COLUMN subject_type.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN subject_type.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.organizationid IS 'Id of Organization';


--
-- Name: COLUMN subject_type.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN subject_type.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN subject_type.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN subject_type.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN subject_type.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN subject_type.typename; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.typename IS 'Name of Subject Type';


--
-- Name: COLUMN subject_type.typedescription; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_type.typedescription IS 'Description of Subject Type';


--
-- Name: subject_type_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.subject_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.subject_type_id_seq OWNER TO abyssuser;

--
-- Name: subject_type_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.subject_type_id_seq OWNED BY abyss.subject_type.id;


--
-- Name: widget; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.widget (
    id integer NOT NULL,
    uuid uuid DEFAULT abyss.gen_random_uuid() NOT NULL,
    organizationid uuid NOT NULL,
    created timestamp without time zone DEFAULT now() NOT NULL,
    updated timestamp without time zone DEFAULT now() NOT NULL,
    deleted timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    detail jsonb NOT NULL
);


ALTER TABLE abyss.widget OWNER TO abyssuser;

--
-- Name: TABLE widget; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.widget IS 'Abyss Platform Dashboard Widget Templates';


--
-- Name: COLUMN widget.id; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.id IS 'Primary Key';


--
-- Name: COLUMN widget.uuid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.uuid IS 'Secondary primary key. Used in front end messages for security reasons.';


--
-- Name: COLUMN widget.organizationid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.organizationid IS 'Id of Organization';


--
-- Name: COLUMN widget.created; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.created IS 'Timestamp of creation #readOnly#';


--
-- Name: COLUMN widget.updated; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.updated IS 'Timestamp of update #readOnly#';


--
-- Name: COLUMN widget.deleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.deleted IS 'Timestamp of deletion #readOnly#';


--
-- Name: COLUMN widget.isdeleted; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.isdeleted IS 'Is record logically deleted #readOnly#';


--
-- Name: COLUMN widget.crudsubjectid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.crudsubjectid IS 'ID of Subject that reads, creates, updates or deletes';


--
-- Name: COLUMN widget.detail; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.widget.detail IS 'Details of widget';


--
-- Name: widget_id_seq; Type: SEQUENCE; Schema: abyss; Owner: abyssuser
--

CREATE SEQUENCE abyss.widget_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE abyss.widget_id_seq OWNER TO abyssuser;

--
-- Name: widget_id_seq; Type: SEQUENCE OWNED BY; Schema: abyss; Owner: abyssuser
--

ALTER SEQUENCE abyss.widget_id_seq OWNED BY abyss.widget.id;


--
-- Name: access_manager id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.access_manager ALTER COLUMN id SET DEFAULT nextval('abyss.access_manager_id_seq'::regclass);


--
-- Name: access_manager_type id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.access_manager_type ALTER COLUMN id SET DEFAULT nextval('abyss.access_manager_type_id_seq'::regclass);


--
-- Name: api__api_category id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_category ALTER COLUMN id SET DEFAULT nextval('abyss.api__api_category_id_seq'::regclass);


--
-- Name: api__api_group id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_group ALTER COLUMN id SET DEFAULT nextval('abyss.api__api_group_id_seq'::regclass);


--
-- Name: api__api_tag id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_tag ALTER COLUMN id SET DEFAULT nextval('abyss.api__api_tag_id_seq'::regclass);


--
-- Name: api_state id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_state ALTER COLUMN id SET DEFAULT nextval('abyss.api_state_id_seq'::regclass);


--
-- Name: api_visibility_type id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_visibility_type ALTER COLUMN id SET DEFAULT nextval('abyss.api_visibility_type_id_seq'::regclass);


--
-- Name: attribute id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.attribute ALTER COLUMN id SET DEFAULT nextval('abyss.attribute_id_seq'::regclass);


--
-- Name: attribute_has id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.attribute_has ALTER COLUMN id SET DEFAULT nextval('abyss.attribute_has_id_seq'::regclass);


--
-- Name: attribute_pattern id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.attribute_pattern ALTER COLUMN id SET DEFAULT nextval('abyss.attribute_pattern_id_seq'::regclass);


--
-- Name: contract_state id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract_state ALTER COLUMN id SET DEFAULT nextval('abyss.contract_state_id_seq'::regclass);


--
-- Name: dashboard id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.dashboard ALTER COLUMN id SET DEFAULT nextval('abyss.dashboard_id_seq'::regclass);


--
-- Name: generalization_hierarchy id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.generalization_hierarchy ALTER COLUMN id SET DEFAULT nextval('abyss.generalization_hierarchy_id_seq'::regclass);


--
-- Name: license id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.license ALTER COLUMN id SET DEFAULT nextval('abyss.license_id_seq'::regclass);


--
-- Name: message id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.message ALTER COLUMN id SET DEFAULT nextval('abyss.message_id_seq'::regclass);


--
-- Name: message_type id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.message_type ALTER COLUMN id SET DEFAULT nextval('abyss.message_type_id_seq'::regclass);


--
-- Name: preferences id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.preferences ALTER COLUMN id SET DEFAULT nextval('abyss.preferences_id_seq'::regclass);


--
-- Name: quasi_id_set id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.quasi_id_set ALTER COLUMN id SET DEFAULT nextval('abyss.quasi_id_set_id_seq'::regclass);


--
-- Name: resource_access_token id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_access_token ALTER COLUMN id SET DEFAULT nextval('abyss.resource_access_token_id_seq'::regclass);


--
-- Name: resource_type id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_type ALTER COLUMN id SET DEFAULT nextval('abyss.resource_type_id_seq'::regclass);


--
-- Name: subject_organization id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_organization ALTER COLUMN id SET DEFAULT nextval('abyss.subject_organization_id_seq'::regclass);


--
-- Name: subject_type id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_type ALTER COLUMN id SET DEFAULT nextval('abyss.subject_type_id_seq'::regclass);


--
-- Name: widget id; Type: DEFAULT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.widget ALTER COLUMN id SET DEFAULT nextval('abyss.widget_id_seq'::regclass);


--
-- Data for Name: access_manager; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.access_manager (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, accessmanagername, description, isactive, accessmanagertypeid, accessmanagerattributes) FROM stdin;
1	6223ebbe-b30f-4976-bcf9-364003142379	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 16:25:28.569	2018-07-06 16:25:30.494	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Abyss Access Manager	Abyss Access Manager	t	ac9e07cd-b6a0-48f4-921d-9dddcfd8e84a	\N
\.


--
-- Data for Name: access_manager_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.access_manager_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, typename, description, attributetemplate) FROM stdin;
1	ac9e07cd-b6a0-48f4-921d-9dddcfd8e84a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 16:20:19.072	2018-07-06 16:20:21.368	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Abyss Access Manager	Abyss Access Manager Integration Template	\N
2	938fe88a-b4fb-4e2c-9e09-de14acfd23ca	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 16:20:19.072	2018-07-06 16:20:21.368	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	OpenAM Access Manager	OpenAM Access Manager Integration Template	\N
3	8794cfd0-738a-491c-a053-9aec9a807d34	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 16:20:19.072	2018-07-06 16:20:21.368	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	RSA Access Manager	RSA Access Manager Integration Template	\N
4	7647fdc1-c20a-494d-9739-8435c02257a8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 16:20:19.072	2018-07-06 16:20:21.368	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Tivoli Access Manager	Tivoli Access Manager Integration Template	\N
5	f621c21b-6eaf-48d4-9d91-b9f0df0d1f46	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 16:20:19.072	2018-07-06 16:20:21.368	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Oracle Access Manager	Tivoli Access Manager Integration Template	\N
6	c7ef3fe6-c86b-4907-96f0-15a0bdd7259d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 16:20:19.072	2018-07-06 16:20:21.368	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	ForgeRock Access Manager	ForgeRock Access Manager Integration Template	\N
\.


--
-- Data for Name: api_category; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.api_category (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description) FROM stdin;
2	30e29d00-102b-4f74-991a-f0d4454ed06c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:00.890508	2018-05-18 15:29:00.890508	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Communication	\N
3	0497371e-fa0f-4833-829c-9f2b36c4a7f2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:00.92109	2018-05-18 15:29:00.92109	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Data	\N
4	d38fe06a-025d-4f83-ae02-a5cdb4d17fbd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:00.928811	2018-05-18 15:29:00.928811	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Database	\N
5	634fb579-0eac-4ad9-959d-0ca333cf58f2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:00.955421	2018-05-18 15:29:00.955421	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Devices	\N
6	2bd62206-3e43-46d5-acc9-1ac770da62a6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:00.972787	2018-05-18 15:29:00.972787	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	eCommerce	\N
7	e7015d40-feb1-4fdc-b195-a5f4780501a0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:00.982614	2018-05-18 15:29:00.982614	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Education	\N
8	8c4f2d1a-f38d-49fc-be07-ff910795692e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.000473	2018-05-18 15:29:01.000473	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Email	\N
9	a062254e-740e-461b-bd0a-f60c8937c079	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.030832	2018-05-18 15:29:01.030832	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Entertainment	\N
10	f2cabe5e-5870-4485-a5b9-af4930ea2b5e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.044724	2018-05-18 15:29:01.044724	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Events	\N
11	30de88f9-3f7a-43bc-89c4-727755744dd8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.062077	2018-05-18 15:29:01.062077	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Finance	\N
12	19a9ba1c-a907-4b05-a5cd-570cc3e569ff	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.079646	2018-05-18 15:29:01.079646	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Financial	\N
13	db53c566-b713-4377-8d65-210c6ec0050d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.096858	2018-05-18 15:29:01.096858	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Food	\N
14	4d48915f-e667-41cc-9ef0-91e2edb87cd2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.108324	2018-05-18 15:29:01.108324	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Gaming	\N
15	c14d5a01-e4e7-4c9f-b5de-978f98bbf8d8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.137333	2018-05-18 15:29:01.137333	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Health	\N
16	abd734f0-cd16-41f5-b0d5-6d7d6bfc6bb8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.150755	2018-05-18 15:29:01.150755	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Fitness	\N
17	43438e4b-62ab-47a0-a094-c9e4f02cbe68	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.153427	2018-05-18 15:29:01.153427	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Location	\N
18	926e4f47-80e5-45c5-900d-b7d5f543ee9a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.165969	2018-05-18 15:29:01.165969	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Logistics	\N
19	f9604737-2215-4754-a1c9-563e86204262	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.177604	2018-05-18 15:29:01.177604	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Machine Learning	\N
20	4529f760-49e8-4e88-b6c9-eb57e6daf959	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.202634	2018-05-18 15:29:01.202634	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Mapping	\N
21	207e5090-8629-4e7a-83fa-9dfaba0ca91a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.217174	2018-05-18 15:29:01.217174	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Media	\N
22	405f76b1-9aa4-4964-91d5-23f6b09f39c9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.228953	2018-05-18 15:29:01.228953	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Medical	\N
23	f56ddab7-9c76-480b-a0fc-565c0987efe3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.259891	2018-05-18 15:29:01.259891	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Music	\N
24	3c5c3b0a-67ce-4af2-a590-5fc2529fbff2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.2814	2018-05-18 15:29:01.2814	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	News	\N
25	9ee320f6-3b82-45af-90e5-6c05c036ffbb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.300081	2018-05-18 15:29:01.300081	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Reward	\N
26	3c069be4-39d5-455d-97ca-2b48ddedb202	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.317474	2018-05-18 15:29:01.317474	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Science	\N
27	9563e135-ae91-47f9-a71e-cf2f27bb0234	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.338043	2018-05-18 15:29:01.338043	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Search	\N
28	58825297-6d65-4f23-a96e-1469a8d75748	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.356912	2018-05-18 15:29:01.356912	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	SMS	\N
29	972658a4-7fae-4d4c-a2df-e4a78de86e5d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.379181	2018-05-18 15:29:01.379181	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Social	\N
30	28800325-fcda-4d35-89ac-c24ed8e78d38	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.397996	2018-05-18 15:29:01.397996	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Sports	\N
31	5cea54e3-4e2a-49d3-841c-071de7853192	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.412709	2018-05-18 15:29:01.412709	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Storage	\N
32	f3e9d8e9-073d-4ed3-9788-6a84621b2533	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.426751	2018-05-18 15:29:01.426751	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Text Analysis	\N
33	3b8baf51-1987-4f02-94b1-b28a58c7aeee	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.440461	2018-05-18 15:29:01.440461	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Translation	\N
35	e911357c-8c4a-4c94-af12-1fae1f694bd0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.464211	2018-05-18 15:29:01.464211	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Weather	\N
36	202dc853-51cc-4742-9ca7-5d15ad05cf75	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.476067	2018-05-18 15:29:01.476067	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Visual Recognition	\N
37	26e87c2b-2e0e-4d73-ada9-b182a84c3105	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.500436	2018-05-18 15:29:01.500436	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Video	\N
38	e8b7721e-fcc5-41da-b307-30717e48a7bc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.508006	2018-05-18 15:29:01.508006	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Image	\N
40	a068f5f0-1637-4c7a-a9a3-ef87735bf75c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.550144	2018-05-18 15:29:01.550144	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Business	\N
41	b7230674-fad7-4bd9-b2de-a3f9aea60465	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.569091	2018-05-18 15:29:01.569091	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Advertising	\N
42	d56989f1-adcd-4eae-8a93-767fbe7127c8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.588833	2018-05-18 15:29:01.588833	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Payment	\N
44	862337cb-c545-4309-a8e4-e3c275481bbe	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.67224	2018-05-18 15:29:01.67224	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Monitoring	\N
45	93f68fb6-092d-411e-9f08-0132a2c610ff	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.686914	2018-05-18 15:29:01.686914	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Sensor Processing	\N
46	d14744ed-5cf4-4ecc-bc60-d6e6fe858b16	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.698081	2018-05-18 15:29:01.698081	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Signal Processing	\N
47	ca2c4a69-9265-4a8b-bc61-d82080753ea1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.736738	2018-05-18 15:29:01.736738	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Security	\N
48	1779b676-1457-429b-9253-3f1b7e5ec3aa	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.746109	2018-05-18 15:29:01.746109	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Identification	\N
49	03dfe0c4-a95b-4fc7-9f92-401ee3f19273	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.772739	2018-05-18 15:29:01.772739	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Image Processing	\N
34	924482c3-2e44-4337-971c-5de05a7327ed	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.453103	2018-05-18 15:29:01.453103	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Travel	\N
43	469c735b-0c76-4596-87ff-4d0607bcae9c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.609911	2018-05-18 15:29:01.609911	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Transportation	\N
1	3c30a832-ff49-4e30-9bca-3da622ea4037	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:00.794284	2018-05-18 15:29:00.794284	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Commerce	\N
39	e4588ca6-1e17-4510-bb76-2e2201608f6d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:01.5319	2018-06-14 21:13:50.134385	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Business Softwaree	
\.


--
-- Data for Name: api_state; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.api_state (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description) FROM stdin;
1	274a8e10-9c14-44fb-8e84-ea74a90531b9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.555511	2018-05-18 15:24:46.555511	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Initial	Initial State of API just after creation
2	dccb1796-9338-4ae8-a0d9-02654d1e2c6d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.574969	2018-05-18 15:24:46.574969	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Draft	The draft state for an API is when an API definition is not staged
3	52240c72-a34e-46e2-a949-f8983e2a5a6e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.619154	2018-05-18 15:24:46.619154	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Staged	When the APIs have been successfully registered or created, API Developer stages the APIs in his own private sandbox API environment
4	915fe07d-4e0b-4ae7-b0ca-f9649946402d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.634352	2018-05-18 15:24:46.634352	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Published	When API Developers stage the APIs in his own private sandbox API environment and successfully test, API Developers | Administrators stage the APIs in the public sandbox API environment
5	1425993f-f6be-4ca0-84fe-8a83e983ffd9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.651769	2018-05-18 15:24:46.651769	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Promoted	\tAfter the APIs are published in the public sandbox API environment, API administrators can promote and deploy APIs to the production API environment
6	f6efa915-70ff-40ca-91ac-6ba939c86844	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.670544	2018-05-18 15:24:46.670544	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Demoted	After the APIs are demoted from the production API environment, API developers re-stage into their own stage area
7	352db612-7fd8-4465-9e49-b2ee063fdbf9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.689762	2018-05-18 15:24:46.689762	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Deprecated	When API administrators deprecate APIs, they flag the APIs with a date when they will be retired from API Catalog. API consumers can see the planned retirement date in API Portal. The APIs are deprecated in both the sandbox API and production API environments
8	f1e8c6b4-bcbd-4bb3-9ba9-19bbf94ce954	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.707068	2018-05-18 15:24:46.707068	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Retired	When the APIs are retired, API administrators unpublish the APIs from API Catalog. The retired APIs are no longer available to API consumers or client applications. The APIs are retired in both the sandbox API and production API environments
9	ad0dff11-1149-4981-b08a-1b2ab3d694dd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.731786	2018-05-18 15:24:46.731786	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Archived	When you archive an API, the API version can neither be viewed nor can its Plans be subscribed to, and all of the associated APIs are taken offline. The API version is not displayed by default in the APIs list
10	5a4eb4cc-995d-4bc9-96e0-462084882332	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.745388	2018-05-18 15:24:46.745388	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Removed	Final state of API after removal from Portfolio
\.

--
-- Data for Name: api_visibility_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.api_visibility_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description) FROM stdin;
1	e63c2874-aa12-433c-9dcf-65c1e8738a14	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.769826	2018-05-18 15:24:46.769826	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Public	Entitites with public visibility
2	043d4827-cff4-43f9-9d5b-782d1f83b3f0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.78831	2018-05-18 15:24:46.78831	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Private	Entitites with private visibility
3	dbe39c26-3a5b-4110-ab92-c6db7fa811c8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:46.806049	2018-05-18 15:24:46.806049	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Closed-Group	Entitites with closed group visibility
\.


--
-- Data for Name: contract_state; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.contract_state (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description) FROM stdin;
1	3bf898b8-8ea2-40b2-9db5-08528c9a738a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.248307	2018-06-12 10:31:28.248307	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	pending_approval	\N
2	08de0bd4-f07d-4c83-a78e-f30b41308573	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.275444	2018-06-12 10:31:28.275444	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	config_pending	\N
3	5943f8fa-b0b8-435e-a726-219ea6f05a98	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.301568	2018-06-12 10:31:28.301568	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	approved	\N
4	846282ec-1329-4a3c-908b-672b4de3ade2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.327162	2018-06-12 10:31:28.327162	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	activated	\N
5	72653b66-b845-4d75-ad2b-605c5561342e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.351836	2018-06-12 10:31:28.351836	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	rejected	\N
6	52a5e97c-eeac-46dd-9ff1-2bd25626932f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.377314	2018-06-12 10:31:28.377314	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	resubmitted	\N
7	66f298f9-b5db-4fc0-8d7e-c9dc24de88ee	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.401636	2018-06-12 10:31:28.401636	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	suspended	\N
8	4666fada-2fa9-4d94-8cb4-1619883c12ff	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-12 10:31:28.426299	2018-06-12 10:31:28.426299	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	cancelled	\N
\.


--
-- Data for Name: dashboard; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.dashboard (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, ownersubjectid, name, description, ispublic, widgets) FROM stdin;
1	a657b478-55d3-42ea-a7b1-e3cbb8210296	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.585669	2018-11-09 23:16:40.585669	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	4e92c400-1aea-4feb-b2a3-686763706a43	Blank Dashboard	Systems Blank Dashboard	t	[]
2	ca099337-95ac-4bde-9ec0-4634db46055e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.588827	2018-11-09 23:16:40.588827	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	4e92c400-1aea-4feb-b2a3-686763706a43	Systems Default Dashboard	Default Dashboard Description	t	[{"size": "2/3", "uuid": "fe5a0293-6bdb-4fc2-b1d6-24bcd81ab28c", "chart": {"name": "Column Chart", "type": "column"}, "color": "green", "order": 1, "title": "My Proxy APIs & Subscribers"}, {"size": "1/3", "uuid": "560a8452-5f0a-4ed5-a022-d25285df99cb", "chart": null, "color": "purple", "order": 2, "title": "APIs Shared with Me"}, {"size": "1/3", "uuid": "32520383-96f8-4e20-aee8-0a858cde2b7e", "chart": null, "color": "orange", "order": 3, "title": "APIs Shared by Me"}, {"size": "2/3", "uuid": "66f83423-11d0-42bf-93bd-be4c9015ebc9", "chart": {"name": "Pie Chart", "type": "pie"}, "color": "cyan", "order": 4, "title": "My APPS & Subscriptions"}, {"size": "2/3", "uuid": "b3d3edd5-99c2-42df-896c-c1cf881cd3bf", "chart": {"name": "Pie Chart", "type": "pie"}, "color": "red", "order": 5, "title": "My Business APIs"}]
3	138af93d-77f4-40a5-965b-f4c08476a32b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.591137	2018-11-09 23:16:40.591137	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	4e92c400-1aea-4feb-b2a3-686763706a43	Systems Secondary Dashboard	Secondary Dashboard Description	t	[{"size": "1/3", "uuid": "560a8452-5f0a-4ed5-a022-d25285df99cb", "chart": null, "color": "purple", "order": 1, "title": "APIs Shared with Me"}, {"size": "1/3", "uuid": "32520383-96f8-4e20-aee8-0a858cde2b7e", "chart": null, "color": "orange", "order": 2, "title": "APIs Shared by Me"}]
\.


--
-- Data for Name: message_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.message_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description, isactive) FROM stdin;
1	5edb149a-841f-4814-a6a2-40fa5d0caff6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.339015	2018-07-10 22:34:55.339015	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Instant Notification	Instant Notification	f
2	d0262303-924a-4370-a537-73c10861d529	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.375053	2018-07-10 22:34:55.375053	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Question	Question	f
3	5f36dd4c-be51-4ec5-9eaa-bc58164314e7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.406585	2018-07-10 22:34:55.406585	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Support Demand	Support Demand	f
4	1f250c9d-e45a-4643-8084-0ffe1a39fdda	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.443012	2018-07-10 22:34:55.443012	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	License Issue	License Issue	f
5	03c1307f-e24c-467b-9b87-2a795b2d4750	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.479083	2018-07-10 22:34:55.479083	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	SLA Issue	SLA Issue	f
6	83bb2922-de06-4f0f-97a4-afb408b6d7c1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.514729	2018-07-10 22:34:55.514729	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Ticket	Ticket	f
7	b11ff37f-4563-4e7c-857a-11f3b19e5744	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.5378	2018-07-10 22:34:55.5378	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Contract	Contract	f
8	7453b1ab-7a8d-485b-bcac-59d4c7f93bbe	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.575433	2018-07-10 22:34:55.575433	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	General	General	t
9	8c4a9109-62d5-469c-94ca-100764ca2897	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.605815	2018-07-10 22:34:55.605815	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Request Fulfillment	Request Fulfillment	f
10	54498533-0597-49ed-a0ef-b2b774634fa0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.636167	2018-07-10 22:34:55.636167	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Subscription Request	Subscription Request Message	t
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.organization (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description, url) FROM stdin;
0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-21 13:49:02.843767	2018-05-21 13:49:02.843767	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Abyss	Abyss Default Organization	\N
\.


--
-- Data for Name: policy_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.policy_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description, type, subtype, template) FROM stdin;
1	18ec219d-990a-447e-a14b-3032d32bf648	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-28 22:18:51.253	2018-06-28 22:18:53.301	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	API Authorization Policy Template	Abyss Platform API Authorization Policy Template	Service	API Authorization	{"info": {"title": "API Authorization Policy Template", "x-type": "Service", "version": "0.0.3", "x-subType": "API Authorization", "description": "Abyss Platform API Authorization Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"AuthorizationConfiguration": {"type": "object", "required": ["appAuthorization", "userAuthorization", "openApiLifeCycle"], "properties": {"appAuthorization": {"enum": ["OFF", "Abyss Access Manager"], "type": "string", "example": "Abyss Access Manager", "description": "App Access Manager"}, "openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}, "userAuthorization": {"enum": ["OFF", "Abyss Access Manager"], "type": "string", "example": "OFF", "description": "User Access Manager"}}, "description": "Authorization Configuration"}}}, "x-openApiPolicy": "0.0.5"}
2	f46957d7-e283-4582-9949-f20ae418fd60	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-03 18:40:47.095	2018-07-03 18:40:41.892	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Privacy Policy Template	Abyss Platform Privacy Policy Template	Privacy	Anonymity Validation	{"info": {"title": "Privacy Policy Template", "x-type": "Privacy", "version": "0.0.3", "x-subType": "Anonymity Validation", "description": "Abyss Platform Privacy Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"PrivacyConfiguration": {"type": "object", "required": ["minimumEquivalanceClassSize", "openApiLifeCycle"], "properties": {"openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}, "minimumEquivalanceClassSize": {"type": "integer", "format": "int32", "example": 2147483647, "maximum": 2147483647, "minimum": 0, "description": "Parameter k of k-anonymity"}}, "description": "Privacy Configuration"}}}, "x-openApiPolicy": "0.0.5"}
3	d7d53112-a0c8-42b5-ba18-4a49fea4484d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-28 22:15:10.415	2018-06-28 22:15:12.934	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Logging Policy Template	Abyss Platform Logging Policy Template	Operational	Logging	{"info": {"title": "Logging Policy Template", "x-type": "Operational", "version": "0.0.3", "x-subType": "Logging", "description": "Abyss Platform Logging Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"LogConfiguration": {"type": "object", "required": ["logLevel", "openApiLifeCycle"], "properties": {"logLevel": {"enum": ["ALL", "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL", "OFF"], "type": "string", "example": "ERROR", "description": "Log Level"}, "openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}}, "description": "Log Configuration"}}}, "x-openApiPolicy": "0.0.5"}
4	db8b4ada-efc5-47bd-9fc1-1988149e7a59	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-30 21:09:36.66613	2018-11-30 21:09:36.66613	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Rate Limiting Policy Template	Abyss Platform Rate Limiting Policy Template	QoS	Throttling	{"info": {"title": "Apply Throttling Policy Template", "x-type": "QoS", "version": "0.0.3", "x-subType": "Throttling", "description": "Abyss Platform Throttling Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"ThrottlingConfiguration": {"type": "object", "required": ["delaytimeinmilliseconds", "delayattempts", "ratelimits", "openApiLifeCycle"], "properties": {"methods": {"type": "array", "items": {"enum": ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS", "HEAD", "TRACE", "CONNECT"], "type": "string", "example": "GET"}, "description": "Rate Limited Methods"}, "ratelimits": {"type": "array", "items": {"type": "object", "required": ["numberofreqs", "timeperiod", "timeunit"], "properties": {"timeunit": {"enum": ["Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year"], "type": "string", "example": "Second", "description": "Time Unit"}, "timeperiod": {"type": "integer", "format": "int32", "example": 2, "maximum": 1000, "minimum": 0, "description": "Time Period"}, "numberofreqs": {"type": "integer", "format": "int32", "example": 90, "maximum": 1000, "minimum": 0, "description": "Number of Reqs"}}}, "description": "Rate Limits"}, "delayattempts": {"type": "integer", "format": "int32", "example": 5, "maximum": 5, "minimum": 0, "description": "Delay Attempts"}, "openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}, "delaytimeinmilliseconds": {"type": "integer", "format": "int32", "example": 10000, "maximum": 10000, "minimum": 0, "description": "Delay Time in Milliseconds"}}, "description": "Throttling Configuration"}}}, "x-openApiPolicy": "0.0.5"}
\.


--
-- Data for Name: resource_action; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.resource_action (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, actionname, description, resourcetypeid, isactive) FROM stdin;
1	7559c85b-b09b-47bf-ac6e-bd6828957dd3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.570488	2018-05-18 15:29:35.570488	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	GET	Http Get Method	505099b4-19da-401c-bd17-8c3a85d89743	f
2	c50ab5f3-04a5-4c72-9a42-363c9f2c346d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.590478	2018-05-18 15:29:35.590478	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PUT	Http Put Method	505099b4-19da-401c-bd17-8c3a85d89743	f
3	03c09b64-0fc0-4be7-b8cf-1ac77d518dc3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.596186	2018-05-18 15:29:35.596186	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	POST	Http Post Method	505099b4-19da-401c-bd17-8c3a85d89743	f
4	e1d5f4ff-704b-4fdf-907b-17b4868f5e11	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.609307	2018-05-18 15:29:35.609307	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	DELETE	Http Delete Method	505099b4-19da-401c-bd17-8c3a85d89743	f
5	c789f128-1afc-4730-b473-00f36ee8323d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.622444	2018-05-18 15:29:35.622444	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	OPTIONS	Http Options Method	505099b4-19da-401c-bd17-8c3a85d89743	f
6	b4f768b0-1893-46d4-973b-a5495d305b37	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.622444	2018-05-18 15:29:35.622444	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	HEAD	Http Head Method	505099b4-19da-401c-bd17-8c3a85d89743	f
7	8429aabe-c2da-4d8f-9eb2-1d70d753adc0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.622444	2018-05-18 15:29:35.622444	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PATCH	Http Patch Method	505099b4-19da-401c-bd17-8c3a85d89743	f
8	d4fca5d4-ddb3-4661-bc7e-cf67bd35289b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.622444	2018-05-18 15:29:35.622444	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	TRACE	Http Trace Method	505099b4-19da-401c-bd17-8c3a85d89743	f
9	d5318796-9ad3-4445-892f-27670cda77d6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.622444	2018-05-18 15:29:35.622444	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	ALL	All Http Methods	505099b4-19da-401c-bd17-8c3a85d89743	f
11	bf0b6ac2-7d07-49c6-b3f8-0fd7c927126e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.159524	2018-07-10 22:34:55.159524	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	VIEW_API	View API	505099b4-19da-401c-bd17-8c3a85d89743	t
12	1872e4a2-645a-49e5-b7eb-38162981e478	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.195201	2018-07-10 22:34:55.195201	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	LIST_API	List API	505099b4-19da-401c-bd17-8c3a85d89743	f
13	7e55b086-75e0-4209-9cc5-51baa38393ed	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.227812	2018-07-10 22:34:55.227812	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	EDIT_API	Edit API	505099b4-19da-401c-bd17-8c3a85d89743	t
14	fc027a6b-c196-4333-afe3-2ec464b2aba7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.270493	2018-07-10 22:34:55.270493	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	CREATE_API	Create API	505099b4-19da-401c-bd17-8c3a85d89743	f
15	af2015f4-1c21-4f10-b0a4-75d1f0502198	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:55.304419	2018-07-10 22:34:55.304419	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	DELETE_API	Delete API	505099b4-19da-401c-bd17-8c3a85d89743	f
10	c5639f00-94c9-4cc9-8ad9-df76f9d162a8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-28 23:04:33.102	2018-06-28 23:04:35.532	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	INVOKE_API	Invoke Operation	505099b4-19da-401c-bd17-8c3a85d89743	t
16	761c8386-4624-416e-b9e4-b59ea2c597fc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-12 16:16:22.202	2018-07-12 16:16:24.467	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	CONSUME_APP	Consume APP	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	t
17	e085cb50-8a98-4511-bc8a-00edabbae8a9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-12 16:16:22.202	2018-07-12 16:16:24.467	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	OWN_APP	Own APP	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	t
18	426af14c-a0c6-4fa5-97b8-d82581b66836	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-17 15:51:45.113	2018-07-17 15:51:47.661	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	VIEW_API_LOG	View API Logs	505099b4-19da-401c-bd17-8c3a85d89743	t
19	2318f036-10e5-41b0-8b51-24adbffd2a2e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-20 23:25:50.519	2018-07-20 23:25:52.886	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	USE_PLATFORM	Use Platform	12947d53-022a-4dcf-bb06-ffa81dab4c16	t
\.


--
-- Data for Name: resource_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.resource_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, type, isactive) FROM stdin;
7	35a77205-18d3-4f5c-bbfc-917a794ea5c8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-01 11:56:05.755916	2018-06-01 11:56:05.755916	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PATH	f
6	a4cb8765-7b70-4fff-8427-7f6c97542d29	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-01 11:56:05.755916	2018-06-01 11:56:05.755916	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	API PRODUCT	f
5	8ef4c919-6a11-4c9a-9042-842c6073b995	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.486379	2018-05-18 15:29:35.486379	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PORTAL FUNCTIONS	f
8	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:09.562204	2018-07-10 22:34:09.562204	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	APP	t
1	505099b4-19da-401c-bd17-8c3a85d89743	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.403573	2018-05-18 15:29:35.403573	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	API	t
2	4ddbc735-8905-488a-81a4-f21a45ebc4ef	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.42376	2018-05-18 15:29:35.42376	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	POLICY	t
3	0e600a0a-8edc-41f2-8749-2560278d33f1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.443148	2018-05-18 15:29:35.443148	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	CONTRACT	t
4	4a3d51ce-cbd6-405b-bf58-328332efa499	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.462033	2018-05-18 15:29:35.462033	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	LICENSE	t
9	12947d53-022a-4dcf-bb06-ffa81dab4c16	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-20 23:02:22.847	2018-07-20 23:02:25.284	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PLATFORM	t
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, isactivated, subjecttypeid, subjectname, firstname, lastname, displayname, email, secondaryemail, effectivestartdate, effectiveenddate, password, passwordsalt, picture, totallogincount, failedlogincount, invalidpasswordattemptcount, ispasswordchangerequired, passwordexpiresat, lastloginat, lastpasswordchangeat, lastauthenticatedat, lastfailedloginat, subjectdirectoryid, islocked, issandbox, url, isrestrictedtoprocessing, description) FROM stdin;
1	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:32.756208	2018-06-07 02:52:05.110817	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	f	80fc37d5-0594-456c-851b-a7e68fe55e9e	faik.saglar	System	Admin	Abyss System Admin	faik.saglar@verapi.com	a@b	2018-05-18 15:24:32.756208	2018-07-29 15:24:32.756208	1234	abcd		0	0	0	t	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f	\N	f	\N
\.


--
-- Data for Name: subject_directory; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject_directory (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, directoryname, description, isactive, istemplate, directorytypeid, directorypriorityorder, directoryattributes, lastsyncronizedat, lastsyncronizationduration) FROM stdin;
1	ac504ae6-2bc9-40fa-8dfb-0ce501089573	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:23:04.604749	2018-12-20 10:43:23.013705	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Abyss Internal Directory	Description	t	f	92c04bd5-1a74-4b12-b61a-57eea625af49	1	{}	2018-06-12 14:57:23.029	0
\.


--
-- Data for Name: subject_directory_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject_directory_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, typename, description, attributetemplate) FROM stdin;
1	92c04bd5-1a74-4b12-b61a-57eea625af49	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:23:04.581407	2018-05-18 15:23:04.581407	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Internal Directory	\N	{"ldap.url": "ldap://ldapserver.company.com:389", "ldap.basedn": "dc=company,dc=local", "ldap.secure": "FALSE", "ldap.userdn": "ldapuser@company.com", "ldap.user.dn": "NULL", "autoAddGroups": "NULL", "ldap.group.dn": "NULL", "ldap.password": "***********", "ldap.referral": "TRUE", "ldap.group.name": "cn", "ldap.user.email": "mail", "ldap.user.group": "memberOf", "ldap.external.id": "objectGUID", "ldap.user.filter": "(&(objectCategory=Person)(sAMAccountName=*)(|(memberOf=CN=UsersGroup1,CN=Builtin,DC=company,DC=local)(memberOf=CN=UsersGroup2,CN=Builtin,DC=company,DC=local)(memberOf=CN=UsersGroup1,CN=Builtin,DC=company,DC=local)))", "ldap.group.filter": "(&(objectCategory=group)(|(name=UsersGroup1)(name=UsersGroup2)(name=UsersGroup3)))", "ldap.local.groups": "TRUE", "ldap.pagedresults": "TRUE", "ldap.pool.maxsize": "NULL", "ldap.pool.timeout": "0", "ldap.read.timeout": "120000", "ldap.pool.initsize": "NULL", "ldap.pool.prefsize": "NULL", "ldap.user.lastname": "sn", "ldap.user.password": "unicodePwd", "ldap.user.username": "sAMAccountName", "ldap.roles.disabled": "TRUE", "ldap.user.firstname": "givenName", "ldap.group.usernames": "member", "ldap.user.encryption": "sha", "ldap.search.timelimit": "60000", "ldap.user.displayname": "displayName", "ldap.user.objectclass": "CompanyUsers", "ldap.group.description": "description", "ldap.group.objectclass": "top; group", "ldap.pagedresults.size": "1000", "ldap.propogate.changes": "FALSE", "ldap.user.username.rdn": "cn", "localUserStatusEnabled": "FALSE", "user_encryption_method": "company-security", "ldap.connection.timeout": "10000", "ldap.usermembership.use": "TRUE", "ldap.filter.expiredUsers": "TRUE", "sync.incremental.enabled": "TRUE", "ldap.nestedgroups.disabled": "TRUE", "ldap.relaxed.dn.standardisation": "TRUE", "com.directory.sync.lastdurationms": "129", "com.directory.sync.issynchronising": "FALSE", "ldap.usermembership.use.for.groups": "TRUE", "com.directory.sync.laststartsynctime": "1.51309E+12", "directory.cache.synchronise.interval": "3600", "com.directory.sync.currentstartsynctime": "NULL"}
2	0be14bbc-0007-44c3-94b1-9ba923e52e12	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:23:04.326362	2018-05-18 15:23:04.326362	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Microsoft Active Directory	\N	{"info": {"title": "User Directory Attribute Config Template", "x-type": "Abyss Open LDAP", "version": "0.0.2", "x-subType": "Microsoft Active Directory", "description": "Abyss Platform User Directory Attribute Config Schema Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"LdapConfiguration": {"type": "object", "required": ["ldap.url", "ldap.userdn", "ldap.password", "ldap.basedn", "ldap.secure"], "properties": {"ldap.url": {"type": "string", "example": "ldap://ldapserver.company.com:389", "x-value": "ldap://localhost:389", "description": "Ldap Connection Url - Host and Port"}, "ldap.basedn": {"type": "string", "example": "dc=company,dc=local", "x-value": "dc=company,dc=local", "description": "Base DN"}, "ldap.secure": {"type": "boolean", "example": false, "x-value": false, "description": "Use SSL"}, "ldap.userdn": {"type": "string", "example": "ldapuser@company.com", "x-value": "", "description": "Ldap User DN"}, "ldap.password": {"type": "string", "format": "password", "example": "pwd", "x-value": "", "description": "Ldap Password"}, "ldap.user.filter": {"type": "string", "example": "(objectCategory=Person)(sAMAccountName=*)", "x-value": "(objectCategory=Person)(sAMAccountName=*)", "description": "User Object Filter"}, "ldap.read.timeout": {"type": "integer", "example": "120000", "x-value": "", "description": "LDAP Read Timeout"}, "ldap.user.lastname": {"type": "string", "example": "givenName", "x-value": "", "description": "User Last Name Field Name"}, "ldap.user.password": {"type": "string", "example": "sn", "x-value": "", "description": "User Password Field Name"}, "ldap.user.username": {"type": "string", "example": "sAMAccountName", "x-value": "User Name Attribute", "description": "User Name Attribute"}, "ldap.user.firstname": {"type": "string", "example": "givenName", "x-value": "", "description": "User First Name Field Name"}, "ldap.user.objectclass": {"type": "string", "example": "CompanyUsers", "x-value": "", "description": "User Object Classz"}}}}}, "x-abyssOpenLdap": "0.0.2"}
3	11da556e-7c89-481b-80cf-6df70cb90d9e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:23:04.513043	2018-05-18 15:23:04.513043	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	OpenLDAP	\N	{"info": {"title": "User Directory Attribute Config Template", "x-type": "Abyss Open LDAP", "version": "0.0.3", "x-subType": "Microsoft Active Directory", "description": "Abyss Platform User Directory Attribute Config Schema Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"LdapConfiguration": {"type": "object", "required": ["ldap.url", "ldap.userdn", "ldap.password", "ldap.basedn", "ldap.secure"], "properties": {"ldap.url": {"type": "string", "example": "ldap://ldapserver.company.com:389", "x-value": "ldap://localhost:389", "description": "Ldap Connection Url - Host and Port"}, "ldap.basedn": {"type": "string", "example": "dc=company,dc=local", "x-value": "dc=company,dc=local", "description": "Base DN"}, "ldap.secure": {"type": "boolean", "example": false, "x-value": false, "description": "Use SSL"}, "ldap.userdn": {"type": "string", "example": "ldapuser@company.com", "x-value": "", "description": "Ldap User DN"}, "ldap.password": {"type": "string", "format": "password", "example": "pwd", "x-value": "", "description": "Ldap Password"}, "ldap.user.filter": {"type": "string", "example": "(objectCategory=Person)(sAMAccountName=*)", "x-value": "(objectCategory=Person)(sAMAccountName=*)", "description": "User Object Filter"}, "ldap.read.timeout": {"type": "integer", "example": "120000", "x-value": "", "description": "LDAP Read Timeout"}, "ldap.user.lastname": {"type": "string", "example": "givenName", "x-value": "", "description": "User Last Name Field Name"}, "ldap.user.password": {"type": "string", "example": "sn", "x-value": "", "description": "User Password Field Name"}, "ldap.user.username": {"type": "string", "example": "sAMAccountName", "x-value": "User Name Attribute", "description": "User Name Attribute"}, "ldap.user.firstname": {"type": "string", "example": "givenName", "x-value": "", "description": "User First Name Field Name"}, "ldap.user.objectclass": {"type": "string", "example": "CompanyUsers", "x-value": "", "description": "User Object Classz"}, "ldap.group.schema.settings": {"type": "object", "required": ["ldap.group.objectclass", "ldap.group.filter", "ldap.group.name", "ldap.group.description"], "properties": {"ldap.group.name": {"type": "string", "example": "cn", "description": "Group Name Attribute"}, "ldap.group.filter": {"type": "string", "example": "(&(objectCategory=group)(|(name=UsersGroup1)(name=UsersGroup2)(name=UsersGroup3)))", "description": "Group Object Filter"}, "ldap.group.description": {"type": "string", "example": "description", "description": "Group Description Attribute"}, "ldap.group.objectclass": {"type": "string", "example": "top; group", "description": "Group Object Class"}}}}}}}, "x-abyssOpenLdap": "0.0.3"}
4	99058344-ff93-452d-9d1c-94b56868c280	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:23:04.481136	2018-05-18 15:23:04.481136	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Generic Directory Server	\N	{"ldap.url": "ldap://ldapserver.company.com:389", "ldap.basedn": "dc=company,dc=local", "ldap.secure": "FALSE", "ldap.userdn": "ldapuser@company.com", "ldap.user.dn": "NULL", "autoAddGroups": "NULL", "ldap.group.dn": "NULL", "ldap.password": "***********", "ldap.referral": "TRUE", "ldap.group.name": "cn", "ldap.user.email": "mail", "ldap.user.group": "memberOf", "ldap.external.id": "objectGUID", "ldap.user.filter": "(&(objectCategory=Person)(sAMAccountName=*)(|(memberOf=CN=UsersGroup1,CN=Builtin,DC=company,DC=local)(memberOf=CN=UsersGroup2,CN=Builtin,DC=company,DC=local)(memberOf=CN=UsersGroup1,CN=Builtin,DC=company,DC=local)))", "ldap.group.filter": "(&(objectCategory=group)(|(name=UsersGroup1)(name=UsersGroup2)(name=UsersGroup3)))", "ldap.local.groups": "TRUE", "ldap.pagedresults": "TRUE", "ldap.pool.maxsize": "NULL", "ldap.pool.timeout": "0", "ldap.read.timeout": "120000", "ldap.pool.initsize": "NULL", "ldap.pool.prefsize": "NULL", "ldap.user.lastname": "sn", "ldap.user.password": "unicodePwd", "ldap.user.username": "sAMAccountName", "ldap.roles.disabled": "TRUE", "ldap.user.firstname": "givenName", "ldap.group.usernames": "member", "ldap.user.encryption": "sha", "ldap.search.timelimit": "60000", "ldap.user.displayname": "displayName", "ldap.user.objectclass": "CompanyUsers", "ldap.group.description": "description", "ldap.group.objectclass": "top; group", "ldap.pagedresults.size": "1000", "ldap.propogate.changes": "FALSE", "ldap.user.username.rdn": "cn", "localUserStatusEnabled": "FALSE", "user_encryption_method": "company-security", "ldap.connection.timeout": "10000", "ldap.usermembership.use": "TRUE", "ldap.filter.expiredUsers": "TRUE", "sync.incremental.enabled": "TRUE", "ldap.nestedgroups.disabled": "TRUE", "ldap.relaxed.dn.standardisation": "TRUE", "com.directory.sync.lastdurationms": "129", "com.directory.sync.issynchronising": "FALSE", "ldap.usermembership.use.for.groups": "TRUE", "com.directory.sync.laststartsynctime": "1.51309E+12", "directory.cache.synchronise.interval": "3600", "com.directory.sync.currentstartsynctime": "NULL"}
\.


--
-- Data for Name: subject_organization; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject_organization (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, subjectid, organizationrefid) FROM stdin;
1	c30878c1-d351-48e9-bb13-25a73aec49ae	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 20:50:46.786	2018-07-06 20:50:42.637	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	32c9c734-11cb-44c9-b06f-0b52e076672d	3c65fafc-8f3a-4243-9c4e-2821aa32d293
2	62b033e1-7eae-4d20-b4b8-2448025e388d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 20:50:49.636	2018-07-06 20:50:44.901	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	32c9c734-11cb-44c9-b06f-0b52e076672d	9287b7dc-058d-4399-aad0-6fa704decb6b
\.



--
-- Data for Name: subject_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, typename, typedescription) FROM stdin;
1	21371a15-04f8-445e-a899-006ee11c0e09	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:23:04.303896	2018-05-18 15:23:04.303896	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	USER	Physical Users using Platform
2	ca80dd37-7484-46d3-b4a1-a8af93b2d3c6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:23:04.314144	2018-05-18 15:23:04.314144	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	APP	Applications using Platform
3	80fc37d5-0594-456c-851b-a7e68fe55e9e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-21 13:49:02.820815	2018-05-21 13:49:02.820815	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	SYSTEM	System User
4	c5ef2da7-b55e-4dec-8be3-96bf30255781	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-08-27 09:40:38.16	2018-08-27 09:40:42.199	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	GROUP	Groups using Platform
5	bb76f638-632d-41f8-9511-9865091701f9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-10-29 18:33:37.450127	2018-10-29 18:33:37.450127	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	ROLE	Roles or Security Groups using Platform
\.


--
-- Data for Name: widget; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.widget (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, detail) FROM stdin;
1	fe5a0293-6bdb-4fc2-b1d6-24bcd81ab28c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.567619	2018-11-09 23:16:40.567619	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	{"comp": "my-proxy-apis", "size": "2/3", "chart": {"name": "Column Chart", "type": "column"}, "color": "green", "title": "My Proxy APIs & Subscribers"}
2	560a8452-5f0a-4ed5-a022-d25285df99cb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.570545	2018-11-09 23:16:40.570545	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	{"comp": "apis-shared-with-me", "size": "1/3", "chart": null, "color": "purple", "title": "APIs Shared with Me"}
3	32520383-96f8-4e20-aee8-0a858cde2b7e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.573087	2018-11-09 23:16:40.573087	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	{"comp": "apis-shared-by-me", "size": "1/3", "chart": null, "color": "orange", "title": "APIs Shared by Me"}
4	66f83423-11d0-42bf-93bd-be4c9015ebc9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.575743	2018-11-09 23:16:40.575743	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	{"comp": "my-apps-subscriptions", "size": "2/3", "chart": {"name": "Pie Chart", "type": "pie"}, "color": "cyan", "title": "My APPS & Subscriptions"}
5	b3d3edd5-99c2-42df-896c-c1cf881cd3bf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.578944	2018-11-09 23:16:40.578944	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	{"comp": "my-business-apis", "size": "2/3", "chart": {"name": "Pie Chart", "type": "pie"}, "color": "red", "title": "My Business APIs"}
\.


--
-- Name: access_manager_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.access_manager_id_seq', 3, true);


--
-- Name: access_manager_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.access_manager_type_id_seq', 8, true);


--
-- Name: api__api_category_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api__api_category_id_seq', 29, true);


--
-- Name: api__api_group_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api__api_group_id_seq', 23, true);


--
-- Name: api__api_tag_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api__api_tag_id_seq', 27, true);


--
-- Name: api_category_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_category_seq', 50, true);


--
-- Name: api_group_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_group_seq', 449, true);


--
-- Name: api_license_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_license_id_seq', 42, true);


--
-- Name: api_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_seq', 2899, true);


--
-- Name: api_state_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_state_id_seq', 10, false);


--
-- Name: api_tag_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_tag_seq', 349, true);


--
-- Name: api_visibility_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_visibility_type_id_seq', 1, false);




--
-- Name: contract_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.contract_seq', 2300, true);


--
-- Name: contract_state_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.contract_state_id_seq', 1, false);


--
-- Name: conversationid_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.conversationid_seq', 25, true);


--
-- Name: dashboard_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.dashboard_id_seq', 5, true);


--
-- Name: license_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.license_id_seq', 24, true);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.message_id_seq', 62, true);


--
-- Name: message_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.message_type_id_seq', 1, false);


--
-- Name: organization_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.organization_seq', 2000, true);


--
-- Name: policy_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.policy_id_seq', 28, true);


--
-- Name: policy_type_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.policy_type_seq', 150, true);


--
-- Name: preferences_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.preferences_id_seq', 1, true);


--
-- Name: resource_access_token_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.resource_access_token_id_seq', 213, true);


--
-- Name: resource_action_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.resource_action_seq', 250, true);


--
-- Name: resource_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.resource_seq', 6650, true);


--
-- Name: resource_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.resource_type_id_seq', 5, true);


--
-- Name: subject_activation_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_activation_seq', 5999, true);


--
-- Name: subject_apps_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_apps_seq', 3900, true);


--
-- Name: subject_directory_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_directory_seq', 600, true);


--
-- Name: subject_directory_type_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_directory_type_seq', 300, true);


--
-- Name: subject_membership_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_membership_seq', 2099, true);


--
-- Name: subject_organization_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_organization_id_seq', 19, true);


--
-- Name: subject_permission_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_permission_seq', 14500, true);


--
-- Name: subject_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_seq', 31599, true);


--
-- Name: subject_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_type_id_seq', 4, true);


--
-- Name: widget_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.widget_id_seq', 5, true);


--
-- Name: api__api_category api__api_category_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_category
    ADD CONSTRAINT api__api_category_unq UNIQUE (apiid, apicategoryid);


--
-- Name: api__api_group api__api_group_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_group
    ADD CONSTRAINT api__api_group_unq UNIQUE (apiid, apigroupid);


--
-- Name: api__api_tag api__api_tag_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_tag
    ADD CONSTRAINT api__api_tag_unq UNIQUE (apiid, apitagid);


--
-- Name: api_license api_license__apiid__licenseid_unqconst; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_license
    ADD CONSTRAINT api_license__apiid__licenseid_unqconst UNIQUE (apiid, licenseid);


--
-- Name: contract contract_unqc; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT contract_unqc UNIQUE (apiid, subjectid, environment, licenseid, deleted);


--
-- Name: api_state pk_${name}.${tableName}_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_state
    ADD CONSTRAINT "pk_${name}.${tableName}_id" PRIMARY KEY (id);


--
-- Name: access_manager pk_access_manager_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.access_manager
    ADD CONSTRAINT pk_access_manager_id PRIMARY KEY (id);


--
-- Name: access_manager_type pk_access_manager_type_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.access_manager_type
    ADD CONSTRAINT pk_access_manager_type_id PRIMARY KEY (id);


--
-- Name: api__api_category pk_api__api_category_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_category
    ADD CONSTRAINT pk_api__api_category_id PRIMARY KEY (id);


--
-- Name: api__api_group pk_api__api_group_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_group
    ADD CONSTRAINT pk_api__api_group_id PRIMARY KEY (id);


--
-- Name: api__api_tag pk_api__api_tag_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_tag
    ADD CONSTRAINT pk_api__api_tag_id PRIMARY KEY (id);


--
-- Name: api_category pk_api_category_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_category
    ADD CONSTRAINT pk_api_category_id PRIMARY KEY (id);


--
-- Name: api_group pk_api_group_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_group
    ADD CONSTRAINT pk_api_group_id PRIMARY KEY (id);


--
-- Name: api pk_api_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api
    ADD CONSTRAINT pk_api_id PRIMARY KEY (id);


--
-- Name: api_tag pk_api_tag_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_tag
    ADD CONSTRAINT pk_api_tag_id PRIMARY KEY (id);


--
-- Name: api_visibility_type pk_api_visibility_type_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_visibility_type
    ADD CONSTRAINT pk_api_visibility_type_id PRIMARY KEY (id);



--
-- Name: contract pk_contract_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT pk_contract_id PRIMARY KEY (id);


--
-- Name: contract_state pk_contract_state_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract_state
    ADD CONSTRAINT pk_contract_state_id PRIMARY KEY (id);


--
-- Name: dashboard pk_dashboard_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.dashboard
    ADD CONSTRAINT pk_dashboard_id PRIMARY KEY (id);


--
-- Name: license pk_license_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.license
    ADD CONSTRAINT pk_license_id PRIMARY KEY (id);


--
-- Name: message pk_message_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.message
    ADD CONSTRAINT pk_message_id PRIMARY KEY (id);


--
-- Name: message_type pk_message_type_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.message_type
    ADD CONSTRAINT pk_message_type_id PRIMARY KEY (id);


--
-- Name: organization pk_organization_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.organization
    ADD CONSTRAINT pk_organization_id PRIMARY KEY (id);


--
-- Name: policy pk_policy_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.policy
    ADD CONSTRAINT pk_policy_id PRIMARY KEY (id);


--
-- Name: policy_type pk_policy_type_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.policy_type
    ADD CONSTRAINT pk_policy_type_id PRIMARY KEY (id);


--
-- Name: preferences pk_preferences_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.preferences
    ADD CONSTRAINT pk_preferences_id PRIMARY KEY (id);


--
-- Name: resource_access_token pk_resource_access_token_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_access_token
    ADD CONSTRAINT pk_resource_access_token_id PRIMARY KEY (id);


--
-- Name: resource_action pk_resource_action_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_action
    ADD CONSTRAINT pk_resource_action_id PRIMARY KEY (id);


--
-- Name: resource pk_resource_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource
    ADD CONSTRAINT pk_resource_id PRIMARY KEY (id);


--
-- Name: resource_type pk_resource_type_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_type
    ADD CONSTRAINT pk_resource_type_id PRIMARY KEY (id);


--
-- Name: subject_activation pk_subject_activation_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_activation
    ADD CONSTRAINT pk_subject_activation_id PRIMARY KEY (id);


--
-- Name: subject_app pk_subject_apps_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_app
    ADD CONSTRAINT pk_subject_apps_id PRIMARY KEY (id, subjectid, appid);


--
-- Name: subject_directory pk_subject_directory_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_directory
    ADD CONSTRAINT pk_subject_directory_id PRIMARY KEY (id);


--
-- Name: subject_directory_type pk_subject_directory_type_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_directory_type
    ADD CONSTRAINT pk_subject_directory_type_id PRIMARY KEY (id);


--
-- Name: subject pk_subject_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject
    ADD CONSTRAINT pk_subject_id PRIMARY KEY (id);


--
-- Name: api_license pk_subject_license_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_license
    ADD CONSTRAINT pk_subject_license_id PRIMARY KEY (id, apiid, licenseid);


--
-- Name: subject_organization pk_subject_organization_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_organization
    ADD CONSTRAINT pk_subject_organization_id PRIMARY KEY (id);


--
-- Name: subject_permission pk_subject_permission_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_permission
    ADD CONSTRAINT pk_subject_permission_id PRIMARY KEY (id);


--
-- Name: subject_type pk_subject_type_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_type
    ADD CONSTRAINT pk_subject_type_id PRIMARY KEY (id);


--
-- Name: subject_membership pk_user_membership_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_membership
    ADD CONSTRAINT pk_user_membership_id PRIMARY KEY (id);


--
-- Name: widget pk_widget_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.widget
    ADD CONSTRAINT pk_widget_id PRIMARY KEY (id);


--
-- Name: subject_app subject_app_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_app
    ADD CONSTRAINT subject_app_unq UNIQUE (subjectid, appid);


--
-- Name: subject_organization subject_organization_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_organization
    ADD CONSTRAINT subject_organization_unq UNIQUE (subjectid, organizationrefid);


--
-- Name: access_manager_accessmanagername; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX access_manager_accessmanagername ON abyss.access_manager USING btree (accessmanagername);


--
-- Name: access_manager_accessmanagertypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX access_manager_accessmanagertypeid ON abyss.access_manager USING btree (accessmanagertypeid);


--
-- Name: access_manager_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX access_manager_id ON abyss.access_manager USING btree (id);


--
-- Name: access_manager_type_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX access_manager_type_id ON abyss.access_manager_type USING btree (id);


--
-- Name: access_manager_type_typename; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX access_manager_type_typename ON abyss.access_manager_type USING btree (typename);


--
-- Name: access_manager_type_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX access_manager_type_uuid ON abyss.access_manager_type USING btree (uuid);


--
-- Name: access_manager_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX access_manager_uuid ON abyss.access_manager USING btree (uuid);


--
-- Name: api__api_category_apicategoryid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api__api_category_apicategoryid ON abyss.api__api_category USING btree (apicategoryid);


--
-- Name: api__api_category_apiid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api__api_category_apiid ON abyss.api__api_category USING btree (apiid);


--
-- Name: api__api_category_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api__api_category_id ON abyss.api__api_category USING btree (id);


--
-- Name: api__api_category_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api__api_category_uuid ON abyss.api__api_category USING btree (uuid);


--
-- Name: api__api_group_apigroupid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api__api_group_apigroupid ON abyss.api__api_group USING btree (apigroupid);


--
-- Name: api__api_group_apiid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api__api_group_apiid ON abyss.api__api_group USING btree (apiid);


--
-- Name: api__api_group_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api__api_group_id ON abyss.api__api_group USING btree (id);


--
-- Name: api__api_group_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api__api_group_uuid ON abyss.api__api_group USING btree (uuid);


--
-- Name: api__api_tag_apiid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api__api_tag_apiid ON abyss.api__api_tag USING btree (apiid);


--
-- Name: api__api_tag_apitagid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api__api_tag_apitagid ON abyss.api__api_tag USING btree (apitagid);


--
-- Name: api__api_tag_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api__api_tag_id ON abyss.api__api_tag USING btree (id);


--
-- Name: api__api_tag_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api__api_tag_uuid ON abyss.api__api_tag USING btree (uuid);


--
-- Name: api_apibaseid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_apibaseid ON abyss.api USING btree (apioriginuuid);


--
-- Name: api_apioriginuuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_apioriginuuid ON abyss.api USING btree (apioriginuuid);


--
-- Name: api_apistateid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_apistateid ON abyss.api USING btree (apistateid);


--
-- Name: api_apivisibilityid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_apivisibilityid ON abyss.api USING btree (apivisibilityid);


--
-- Name: api_businessapiid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_businessapiid ON abyss.api USING btree (businessapiid);


--
-- Name: api_category_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_category_id ON abyss.api_category USING btree (id);


--
-- Name: api_category_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_category_name ON abyss.api_category USING btree (name);


--
-- Name: api_category_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_category_uuid ON abyss.api_category USING btree (uuid);


--
-- Name: api_group_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_group_id ON abyss.api_group USING btree (id);


--
-- Name: api_group_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_group_name ON abyss.api_group USING btree (name);


--
-- Name: api_group_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_group_subjectid ON abyss.api_group USING btree (subjectid);


--
-- Name: api_group_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_group_uuid ON abyss.api_group USING btree (uuid);


--
-- Name: api_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_id ON abyss.api USING btree (id);


--
-- Name: api_islive; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_islive ON abyss.api USING btree (islive);


--
-- Name: api_isproxyapi; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_isproxyapi ON abyss.api USING btree (isproxyapi);


--
-- Name: api_issandbox; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_issandbox ON abyss.api USING btree (issandbox);


--
-- Name: api_languageformat; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_languageformat ON abyss.api USING btree (languageformat);


--
-- Name: api_languagename; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_languagename ON abyss.api USING btree (languagename);


--
-- Name: api_license_apiid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_license_apiid ON abyss.api_license USING btree (apiid);


--
-- Name: api_license_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_license_id ON abyss.api_license USING btree (id);


--
-- Name: api_license_licenseid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_license_licenseid ON abyss.api_license USING btree (licenseid);


--
-- Name: api_license_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_license_uuid ON abyss.api_license USING btree (uuid);


--
-- Name: api_state_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_state_id ON abyss.api_state USING btree (id);


--
-- Name: api_state_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_state_name ON abyss.api_state USING btree (name);


--
-- Name: api_state_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_state_uuid ON abyss.api_state USING btree (uuid);


--
-- Name: api_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_subjectid ON abyss.api USING btree (subjectid);


--
-- Name: api_tag_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_tag_id ON abyss.api_tag USING btree (id);


--
-- Name: api_tag_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_tag_name ON abyss.api_tag USING btree (name);


--
-- Name: api_tag_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_tag_uuid ON abyss.api_tag USING btree (uuid);


--
-- Name: api_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_uuid ON abyss.api USING btree (uuid);


--
-- Name: api_version; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_version ON abyss.api USING btree (version);


--
-- Name: api_visibility_type_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_visibility_type_id ON abyss.api_visibility_type USING btree (id);


--
-- Name: api_visibility_type_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_visibility_type_name ON abyss.api_visibility_type USING btree (name);


--
-- Name: api_visibility_type_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_visibility_type_uuid ON abyss.api_visibility_type USING btree (uuid);


--
-- Name: contract_apiid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX contract_apiid ON abyss.contract USING btree (apiid);


--
-- Name: contract_contractstateid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX contract_contractstateid ON abyss.contract USING btree (contractstateid);


--
-- Name: contract_environment; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX contract_environment ON abyss.contract USING btree (environment);


--
-- Name: contract_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX contract_id ON abyss.contract USING btree (id);


--
-- Name: contract_licenseid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX contract_licenseid ON abyss.contract USING btree (licenseid);


--
-- Name: contract_state_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX contract_state_id ON abyss.contract_state USING btree (id);


--
-- Name: contract_state_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX contract_state_name ON abyss.contract_state USING btree (name);


--
-- Name: contract_state_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX contract_state_uuid ON abyss.contract_state USING btree (uuid);


--
-- Name: contract_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX contract_subjectid ON abyss.contract USING btree (subjectid);


--
-- Name: contract_subjectpermissionid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX contract_subjectpermissionid ON abyss.contract USING btree (subjectpermissionid);


--
-- Name: contract_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX contract_uuid ON abyss.contract USING btree (uuid);


--
-- Name: idx_api_group_of_subject; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX idx_api_group_of_subject ON abyss.api_group USING btree (subjectid, name);


--
-- Name: idx_subject_directory_unique_order_per_subject; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX idx_subject_directory_unique_order_per_subject ON abyss.subject_directory USING btree (directorypriorityorder);


--
-- Name: license_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX license_id ON abyss.license USING btree (id);


--
-- Name: license_of_organization_idx; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX license_of_organization_idx ON abyss.license USING btree (organizationid, name, subjectid, version);


--
-- Name: license_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX license_subjectid ON abyss.license USING btree (subjectid);


--
-- Name: license_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX license_uuid ON abyss.license USING btree (uuid);


--
-- Name: license_version; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX license_version ON abyss.license USING btree (version);


--
-- Name: message_conversationid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX message_conversationid ON abyss.message USING btree (conversationid);


--
-- Name: message_folder; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX message_folder ON abyss.message USING btree (folder);


--
-- Name: message_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX message_id ON abyss.message USING btree (id);


--
-- Name: message_isread; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX message_isread ON abyss.message USING btree (isread);


--
-- Name: message_ownersubjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX message_ownersubjectid ON abyss.message USING btree (ownersubjectid);


--
-- Name: message_subject; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX message_subject ON abyss.message USING btree (subject);


--
-- Name: message_type_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX message_type_id ON abyss.message_type USING btree (id);


--
-- Name: message_type_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX message_type_name ON abyss.message_type USING btree (name);


--
-- Name: message_type_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX message_type_uuid ON abyss.message_type USING btree (uuid);


--
-- Name: message_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX message_uuid ON abyss.message USING btree (uuid);


--
-- Name: organization_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX organization_id ON abyss.organization USING btree (id);


--
-- Name: organization_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX organization_name ON abyss.organization USING btree (name);


--
-- Name: organization_organizationid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX organization_organizationid ON abyss.organization USING btree (organizationid);


--
-- Name: organization_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX organization_uuid ON abyss.organization USING btree (uuid);


--
-- Name: policy_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX policy_id ON abyss.policy USING btree (id);


--
-- Name: policy_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX policy_name ON abyss.policy USING btree (name);


--
-- Name: policy_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX policy_subjectid ON abyss.policy USING btree (subjectid);


--
-- Name: policy_type_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX policy_type_id ON abyss.policy_type USING btree (id);


--
-- Name: policy_type_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX policy_type_name ON abyss.policy_type USING btree (name);


--
-- Name: policy_type_subtype; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX policy_type_subtype ON abyss.policy_type USING btree (subtype);


--
-- Name: policy_type_type; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX policy_type_type ON abyss.policy_type USING btree (type);


--
-- Name: policy_type_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX policy_type_uuid ON abyss.policy_type USING btree (uuid);


--
-- Name: policy_typeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX policy_typeid ON abyss.policy USING btree (typeid);


--
-- Name: policy_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX policy_uuid ON abyss.policy USING btree (uuid);


--
-- Name: resource__protected_resource_idx; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource__protected_resource_idx ON abyss.resource USING btree (resourcetypeid, resourcename, deleted);


--
-- Name: resource_access_token_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_access_token_id ON abyss.resource_access_token USING btree (id);


--
-- Name: resource_access_token_resourcerefid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_access_token_resourcerefid ON abyss.resource_access_token USING btree (resourcerefid);


--
-- Name: resource_access_token_resourcetypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_access_token_resourcetypeid ON abyss.resource_access_token USING btree (resourcetypeid);


--
-- Name: resource_access_token_subjectpermissionid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_access_token_subjectpermissionid ON abyss.resource_access_token USING btree (subjectpermissionid);


--
-- Name: resource_access_token_token; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_access_token_token ON abyss.resource_access_token USING btree (token);


--
-- Name: resource_access_token_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_access_token_uuid ON abyss.resource_access_token USING btree (uuid);


--
-- Name: resource_action_actionname; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_action_actionname ON abyss.resource_action USING btree (actionname);


--
-- Name: resource_action_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_action_id ON abyss.resource_action USING btree (id);


--
-- Name: resource_action_isactive; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_action_isactive ON abyss.resource_action USING btree (isactive);


--
-- Name: resource_action_resourcetypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_action_resourcetypeid ON abyss.resource_action USING btree (resourcetypeid);


--
-- Name: resource_action_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_action_uuid ON abyss.resource_action USING btree (uuid);


--
-- Name: resource_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_id ON abyss.resource USING btree (id);


--
-- Name: resource_isactive; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_isactive ON abyss.resource USING btree (isactive);


--
-- Name: resource_resourceid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_resourceid ON abyss.resource USING btree (resourcerefid);


--
-- Name: resource_resourcerefid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_resourcerefid ON abyss.resource USING btree (resourcerefid);


--
-- Name: resource_resourcetypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_resourcetypeid ON abyss.resource USING btree (resourcetypeid);


--
-- Name: resource_type_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_type_id ON abyss.resource_type USING btree (id);


--
-- Name: resource_type_type; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_type_type ON abyss.resource_type USING btree (type);


--
-- Name: resource_type_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_type_uuid ON abyss.resource_type USING btree (uuid);


--
-- Name: resource_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX resource_uuid ON abyss.resource USING btree (uuid);


--
-- Name: subject_activation_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_activation_id ON abyss.subject_activation USING btree (id);


--
-- Name: subject_activation_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_activation_subjectid ON abyss.subject_activation USING btree (subjectid);


--
-- Name: subject_activation_token; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_activation_token ON abyss.subject_activation USING btree (token);


--
-- Name: subject_activation_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_activation_uuid ON abyss.subject_activation USING btree (uuid);


--
-- Name: subject_app_appid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_app_appid ON abyss.subject_app USING btree (appid);


--
-- Name: subject_app_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_app_subjectid ON abyss.subject_app USING btree (subjectid);


--
-- Name: subject_apps_appid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_apps_appid ON abyss.subject_app USING btree (appid);


--
-- Name: subject_apps_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_apps_id ON abyss.subject_app USING btree (id);


--
-- Name: subject_apps_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_apps_subjectid ON abyss.subject_app USING btree (subjectid);


--
-- Name: subject_apps_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_apps_uuid ON abyss.subject_app USING btree (uuid);


--
-- Name: subject_directory_directoryname; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_directory_directoryname ON abyss.subject_directory USING btree (directoryname);


--
-- Name: subject_directory_directorytypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_directory_directorytypeid ON abyss.subject_directory USING btree (directorytypeid);


--
-- Name: subject_directory_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_directory_id ON abyss.subject_directory USING btree (id);


--
-- Name: subject_directory_type_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_directory_type_id ON abyss.subject_directory_type USING btree (id);


--
-- Name: subject_directory_type_typename; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_directory_type_typename ON abyss.subject_directory_type USING btree (typename);


--
-- Name: subject_directory_type_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_directory_type_uuid ON abyss.subject_directory_type USING btree (uuid);


--
-- Name: subject_directory_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_directory_uuid ON abyss.subject_directory USING btree (uuid);


--
-- Name: subject_email; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_email ON abyss.subject USING btree (email);


--
-- Name: subject_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_id ON abyss.subject USING btree (id);


--
-- Name: subject_membership_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_membership_id ON abyss.subject_membership USING btree (id);


--
-- Name: subject_membership_subjectgroupid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_membership_subjectgroupid ON abyss.subject_membership USING btree (subjectgroupid);


--
-- Name: subject_membership_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_membership_subjectid ON abyss.subject_membership USING btree (subjectid);


--
-- Name: subject_membership_unique_index; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_membership_unique_index ON abyss.subject_membership USING btree (deleted, isdeleted, subjectid, subjectgroupid);


--
-- Name: subject_membership_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_membership_uuid ON abyss.subject_membership USING btree (uuid);


--
-- Name: subject_organization_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_organization_id ON abyss.subject_organization USING btree (id);


--
-- Name: subject_organization_organizationrefid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_organization_organizationrefid ON abyss.subject_organization USING btree (organizationrefid);


--
-- Name: subject_organization_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_organization_subjectid ON abyss.subject_organization USING btree (subjectid);


--
-- Name: subject_organization_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_organization_uuid ON abyss.subject_organization USING btree (uuid);


--
-- Name: subject_organizationid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_organizationid ON abyss.subject USING btree (organizationid);


--
-- Name: subject_permission__permissions_of_subject_idx; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_permission__permissions_of_subject_idx ON abyss.subject_permission USING btree (organizationid, subjectid, resourceid, resourceactionid, deleted);


--
-- Name: subject_permission_accessmanagerid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_permission_accessmanagerid ON abyss.subject_permission USING btree (accessmanagerid);


--
-- Name: subject_permission_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_permission_id ON abyss.subject_permission USING btree (id);


--
-- Name: subject_permission_resourceactionid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_permission_resourceactionid ON abyss.subject_permission USING btree (resourceactionid);


--
-- Name: subject_permission_resourceid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_permission_resourceid ON abyss.subject_permission USING btree (resourceid);


--
-- Name: subject_permission_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_permission_subjectid ON abyss.subject_permission USING btree (subjectid);


--
-- Name: subject_permission_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_permission_uuid ON abyss.subject_permission USING btree (uuid);


--
-- Name: subject_subjectdirectoryid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_subjectdirectoryid ON abyss.subject USING btree (subjectdirectoryid);


--
-- Name: subject_subjectname; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_subjectname ON abyss.subject USING btree (subjectname);


--
-- Name: subject_subjecttypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_subjecttypeid ON abyss.subject USING btree (subjecttypeid);


--
-- Name: subject_type_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_type_id ON abyss.subject_type USING btree (id);


--
-- Name: subject_type_typename; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_type_typename ON abyss.subject_type USING btree (typename);


--
-- Name: subject_type_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_type_uuid ON abyss.subject_type USING btree (uuid);


--
-- Name: subject_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_uuid ON abyss.subject USING btree (uuid);


--
-- Name: subject_permission fk_access_manager__subject_permission; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_permission
    ADD CONSTRAINT fk_access_manager__subject_permission FOREIGN KEY (accessmanagerid) REFERENCES abyss.access_manager(uuid);


--
-- Name: api fk_m2o_api__api_state; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api
    ADD CONSTRAINT fk_m2o_api__api_state FOREIGN KEY (apistateid) REFERENCES abyss.api_state(uuid);


--
-- Name: api fk_m2o_api__api_visibility_type; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api
    ADD CONSTRAINT fk_m2o_api__api_visibility_type FOREIGN KEY (apivisibilityid) REFERENCES abyss.api_visibility_type(uuid);


--
-- Name: api fk_m2o_api__subject; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api
    ADD CONSTRAINT fk_m2o_api__subject FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: api_group fk_m2o_api_group__subject; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_group
    ADD CONSTRAINT fk_m2o_api_group__subject FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: api fk_m2o_api_proxy__business_api; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api
    ADD CONSTRAINT fk_m2o_api_proxy__business_api FOREIGN KEY (businessapiid) REFERENCES abyss.api(uuid);


--
-- Name: api__api_category fk_m2o_category__api; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_category
    ADD CONSTRAINT fk_m2o_category__api FOREIGN KEY (apicategoryid) REFERENCES abyss.api_category(uuid);


--
-- Name: contract fk_m2o_contract__api; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT fk_m2o_contract__api FOREIGN KEY (apiid) REFERENCES abyss.api(uuid);


--
-- Name: contract fk_m2o_contract__subject; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT fk_m2o_contract__subject FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: contract fk_m2o_contract_state__contract; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT fk_m2o_contract_state__contract FOREIGN KEY (contractstateid) REFERENCES abyss.contract_state(uuid);


--
-- Name: api__api_group fk_m2o_group__api; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_group
    ADD CONSTRAINT fk_m2o_group__api FOREIGN KEY (apigroupid) REFERENCES abyss.api_group(uuid);


--
-- Name: subject fk_m2o_subject__subject_directory; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject
    ADD CONSTRAINT fk_m2o_subject__subject_directory FOREIGN KEY (subjectdirectoryid) REFERENCES abyss.subject_directory(uuid);


--
-- Name: subject fk_m2o_subject__subject_type; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject
    ADD CONSTRAINT fk_m2o_subject__subject_type FOREIGN KEY (subjecttypeid) REFERENCES abyss.subject_type(uuid);


--
-- Name: subject_activation fk_m2o_subject_activation__subject; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_activation
    ADD CONSTRAINT fk_m2o_subject_activation__subject FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: subject_directory fk_m2o_subject_directory_type__subject_directory; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_directory
    ADD CONSTRAINT fk_m2o_subject_directory_type__subject_directory FOREIGN KEY (directorytypeid) REFERENCES abyss.subject_directory_type(uuid);


--
-- Name: subject_permission fk_m2o_subject_permission__resource; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_permission
    ADD CONSTRAINT fk_m2o_subject_permission__resource FOREIGN KEY (resourceid) REFERENCES abyss.resource(uuid);


--
-- Name: subject_permission fk_m2o_subject_permission__resource_action; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_permission
    ADD CONSTRAINT fk_m2o_subject_permission__resource_action FOREIGN KEY (resourceactionid) REFERENCES abyss.resource_action(uuid);


--
-- Name: api__api_tag fk_m2o_tag__api; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_tag
    ADD CONSTRAINT fk_m2o_tag__api FOREIGN KEY (apitagid) REFERENCES abyss.api_tag(uuid);


--
-- Name: subject_permission fk_o2m_access_manager__subject_permission; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_permission
    ADD CONSTRAINT fk_o2m_access_manager__subject_permission FOREIGN KEY (accessmanagerid) REFERENCES abyss.access_manager(uuid);


--
-- Name: access_manager fk_o2m_access_manager_type__access_manager; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.access_manager
    ADD CONSTRAINT fk_o2m_access_manager_type__access_manager FOREIGN KEY (accessmanagertypeid) REFERENCES abyss.access_manager_type(uuid);


--
-- Name: api_license fk_o2m_api__api_license; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_license
    ADD CONSTRAINT fk_o2m_api__api_license FOREIGN KEY (apiid) REFERENCES abyss.api(uuid);


--
-- Name: api__api_category fk_o2m_api__category; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_category
    ADD CONSTRAINT fk_o2m_api__category FOREIGN KEY (apiid) REFERENCES abyss.api(uuid);


--
-- Name: api__api_group fk_o2m_api__group; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_group
    ADD CONSTRAINT fk_o2m_api__group FOREIGN KEY (apiid) REFERENCES abyss.api(uuid);


--
-- Name: api__api_tag fk_o2m_api__tag; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_tag
    ADD CONSTRAINT fk_o2m_api__tag FOREIGN KEY (apiid) REFERENCES abyss.api(uuid);


--
-- Name: contract fk_o2m_license__contract; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT fk_o2m_license__contract FOREIGN KEY (licenseid) REFERENCES abyss.license(uuid);


--
-- Name: api_license fk_o2m_license__subject_license; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_license
    ADD CONSTRAINT fk_o2m_license__subject_license FOREIGN KEY (licenseid) REFERENCES abyss.license(uuid);


--
-- Name: message fk_o2m_message_type__message; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.message
    ADD CONSTRAINT fk_o2m_message_type__message FOREIGN KEY (messagetypeid) REFERENCES abyss.message_type(uuid);


--
-- Name: subject fk_o2m_organization__subject; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject
    ADD CONSTRAINT fk_o2m_organization__subject FOREIGN KEY (organizationid) REFERENCES abyss.organization(uuid);


--
-- Name: subject_organization fk_o2m_organization__subject_organization; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_organization
    ADD CONSTRAINT fk_o2m_organization__subject_organization FOREIGN KEY (organizationrefid) REFERENCES abyss.organization(uuid);


--
-- Name: policy fk_o2m_policy_type__policy; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.policy
    ADD CONSTRAINT fk_o2m_policy_type__policy FOREIGN KEY (typeid) REFERENCES abyss.policy_type(uuid);


--
-- Name: resource fk_o2m_resource_type__resource; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource
    ADD CONSTRAINT fk_o2m_resource_type__resource FOREIGN KEY (resourcetypeid) REFERENCES abyss.resource_type(uuid);


--
-- Name: resource_access_token fk_o2m_resource_type__resource_access_token; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_access_token
    ADD CONSTRAINT fk_o2m_resource_type__resource_access_token FOREIGN KEY (resourcetypeid) REFERENCES abyss.resource_type(uuid);


--
-- Name: resource_action fk_o2m_resource_type__resource_action; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_action
    ADD CONSTRAINT fk_o2m_resource_type__resource_action FOREIGN KEY (resourcetypeid) REFERENCES abyss.resource_type(uuid);


--
-- Name: organization fk_o2m_sub_organization; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.organization
    ADD CONSTRAINT fk_o2m_sub_organization FOREIGN KEY (organizationid) REFERENCES abyss.organization(uuid);


--
-- Name: subject_app fk_o2m_subject__app_id; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_app
    ADD CONSTRAINT fk_o2m_subject__app_id FOREIGN KEY (appid) REFERENCES abyss.subject(uuid);


--
-- Name: license fk_o2m_subject__license; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.license
    ADD CONSTRAINT fk_o2m_subject__license FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: policy fk_o2m_subject__policy; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.policy
    ADD CONSTRAINT fk_o2m_subject__policy FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: subject_membership fk_o2m_subject__subject_group_membership; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_membership
    ADD CONSTRAINT fk_o2m_subject__subject_group_membership FOREIGN KEY (subjectgroupid) REFERENCES abyss.subject(uuid);


--
-- Name: subject_app fk_o2m_subject__subject_id; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_app
    ADD CONSTRAINT fk_o2m_subject__subject_id FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: subject_membership fk_o2m_subject__subject_membership; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_membership
    ADD CONSTRAINT fk_o2m_subject__subject_membership FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: subject_organization fk_o2m_subject__subject_organization; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_organization
    ADD CONSTRAINT fk_o2m_subject__subject_organization FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: subject_permission fk_o2m_subject__subject_permission; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_permission
    ADD CONSTRAINT fk_o2m_subject__subject_permission FOREIGN KEY (subjectid) REFERENCES abyss.subject(uuid);


--
-- Name: resource_access_token fk_o2m_subject_permission__resource_access_token; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource_access_token
    ADD CONSTRAINT fk_o2m_subject_permission__resource_access_token FOREIGN KEY (subjectpermissionid) REFERENCES abyss.subject_permission(uuid);


--
-- Name: resource fk_o2o_protected_resource_resource_type; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.resource
    ADD CONSTRAINT fk_o2o_protected_resource_resource_type FOREIGN KEY (resourcetypeid) REFERENCES abyss.resource_type(uuid);


--
-- Name: contract fk_o2o_subject_permission__contract; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT fk_o2o_subject_permission__contract FOREIGN KEY (subjectpermissionid) REFERENCES abyss.subject_permission(uuid);


--
-- Name: DATABASE abyssportal; Type: ACL; Schema: -; Owner: abyssuser
--

GRANT TEMPORARY ON DATABASE abyssportal TO postgres;

--
-- PostgreSQL database dump complete
--

