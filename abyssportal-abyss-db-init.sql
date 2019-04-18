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
    attributetemplate jsonb,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.access_manager_type OWNER TO abyssuser;

--
-- Name: TABLE access_manager_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.access_manager_type IS 'Abyss Platform Access Manager Types and Attribute Templates #paramTable#';


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
-- Name: COLUMN access_manager_type.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.access_manager_type.isactive IS 'Is the Access Manager Type active';


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
    version character varying(255) NOT NULL,
    issandbox boolean DEFAULT false NOT NULL,
    islive boolean DEFAULT false NOT NULL,
    isdefaultversion boolean DEFAULT false NOT NULL,
    islatestversion boolean DEFAULT false NOT NULL,
    apioriginid uuid,
    apiparentid uuid
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
-- Name: COLUMN api.apioriginid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.apioriginid IS 'Origin ID of this API Version';


--
-- Name: COLUMN api.apiparentid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api.apiparentid IS 'Parent ID of API Version';


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

COMMENT ON TABLE abyss.api__api_category IS 'Many to many relationship table between Business API - API Category #paramTable#';


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

COMMENT ON TABLE abyss.api__api_group IS 'Many to many relationship table between Business API - API Group #paramTable#';


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

COMMENT ON TABLE abyss.api__api_tag IS 'Many to many relationship table between Business API - API Tag #paramTable#';


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

COMMENT ON TABLE abyss.api_category IS 'Abyss Platform Entity Groups of Subjects #paramTable#';


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

COMMENT ON TABLE abyss.api_group IS 'Abyss Platform Entity Groups of Subjects #paramTable#';


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
    licenseid uuid NOT NULL,
    isactive boolean DEFAULT false NOT NULL
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
-- Name: COLUMN api_license.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.api_license.isactive IS 'Is the licence active for the API';


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

COMMENT ON TABLE abyss.api_state IS 'Common properties and columns for Abyss Platform Entities #paramTable#';


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

COMMENT ON TABLE abyss.api_tag IS 'Abyss Platform API Tags - In sync to OpenAPI 3.0 Tag Model #paramTable#';


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

COMMENT ON TABLE abyss.api_visibility_type IS 'Abyss Platform Visibility Type of APIs, APPs and other entities #paramTable#';


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

COMMENT ON TABLE abyss.contract_state IS 'Abyss Platform Contract States #paramTable#';


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
    hierarchytree jsonb NOT NULL,
    leafmin integer,
    leafmax integer,
    leaftext text,
    gen1 text NOT NULL,
    gen2 text NOT NULL,
    gen3 text NOT NULL,
    gen4 text NOT NULL,
    gen5 text NOT NULL
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
-- Name: COLUMN generalization_hierarchy.leafmin; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.leafmin IS 'Minimum Leaf Value of Attribute Value - Only for numeric attributes';


--
-- Name: COLUMN generalization_hierarchy.leafmax; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.leafmax IS 'Maximum Leaf Value of Attribute Value - Only for numeric attributes';


--
-- Name: COLUMN generalization_hierarchy.leaftext; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.leaftext IS 'Categorical Value of Attribute Value';


--
-- Name: COLUMN generalization_hierarchy.gen1; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.gen1 IS 'Level 1 Generalized Value - Level 2 for Numerics';


--
-- Name: COLUMN generalization_hierarchy.gen2; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.gen2 IS 'Level 2 Generalized Value - Level 3 for Numerics';


--
-- Name: COLUMN generalization_hierarchy.gen3; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.gen3 IS 'Level 3 Generalized Value - Level 4 for Numerics';


--
-- Name: COLUMN generalization_hierarchy.gen4; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.gen4 IS 'Level 4 Generalized Value - Level 5 for Numerics';


--
-- Name: COLUMN generalization_hierarchy.gen5; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.generalization_hierarchy.gen5 IS 'Level 5 Generalized Value - Level 6 for Numerics';


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
    licensedocument jsonb,
    isactive boolean DEFAULT false NOT NULL
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
-- Name: COLUMN license.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.license.isactive IS 'Is the license active or not';


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

COMMENT ON TABLE abyss.message_type IS 'Abyss Platform Message Types #paramTable#';


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
    url character varying(255),
    isactive boolean DEFAULT false NOT NULL,
    picture text
);


ALTER TABLE abyss.organization OWNER TO abyssuser;

--
-- Name: TABLE organization; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.organization IS 'Abyss Platform Organization Entity #paramTable#';


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
-- Name: COLUMN organization.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.isactive IS 'Is the organization active or not';


--
-- Name: COLUMN organization.picture; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.organization.picture IS 'Picture or Logo of Organization';


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
    typeid uuid NOT NULL,
    isactive boolean DEFAULT false NOT NULL
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
-- Name: COLUMN policy.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy.isactive IS 'Is the policy active or not';


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
    template jsonb NOT NULL,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.policy_type OWNER TO abyssuser;

--
-- Name: TABLE policy_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.policy_type IS 'Abyss Platform Policy Types #paramTable#';


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
-- Name: COLUMN policy_type.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.policy_type.isactive IS 'Is the policy type active or not';


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
    deleted timestamp without time zone DEFAULT '1900-01-01 00:00:00'::timestamp without time zone,
    isdeleted boolean DEFAULT false NOT NULL,
    crudsubjectid uuid NOT NULL,
    resourcetypeid uuid NOT NULL,
    resourcename character varying(255) NOT NULL,
    description character varying(1024) NOT NULL,
    resourcerefid uuid,
    isactive boolean DEFAULT false NOT NULL,
    subresourcename text DEFAULT 'ALL_SUB_RESOURCES'::text NOT NULL
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
-- Name: COLUMN resource.subresourcename; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.resource.subresourcename IS 'Sub Resource Name is Operation ID for Proxy APIs';


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

COMMENT ON TABLE abyss.resource_action IS 'Abyss Platform Resource Actions #paramTable#';


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

COMMENT ON TABLE abyss.resource_type IS 'Abyss Platform Resource Types #paramTable#';


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
    description text,
    distinguishedname text,
    uniqueid text,
    phonebusiness character varying(64),
    phonehome character varying(64),
    phonemobile character varying(64),
    phoneextension character varying(64),
    jobtitle text,
    department text,
    company text
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
-- Name: COLUMN subject.distinguishedname; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.distinguishedname IS 'Distinguished Name stored in User Directory of the Subject';


--
-- Name: COLUMN subject.uniqueid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.uniqueid IS 'Unique ID from User Directory';


--
-- Name: COLUMN subject.phonebusiness; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.phonebusiness IS 'Business Phone Number';


--
-- Name: COLUMN subject.phonehome; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.phonehome IS 'Home Phone Number';


--
-- Name: COLUMN subject.phonemobile; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.phonemobile IS 'Mobile Phone Number';


--
-- Name: COLUMN subject.phoneextension; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.phoneextension IS 'Phone Extension Number';


--
-- Name: COLUMN subject.jobtitle; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.jobtitle IS 'Job Title of Subject';


--
-- Name: COLUMN subject.department; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.department IS 'Department of Subject';


--
-- Name: COLUMN subject.company; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject.company IS 'Company of Subject';


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
    attributetemplate jsonb,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.subject_directory_type OWNER TO abyssuser;

--
-- Name: TABLE subject_directory_type; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_directory_type IS 'Abyss Platform Directory Types and Directory Attributes Templates #paramTable#';


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
-- Name: COLUMN subject_directory_type.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_directory_type.isactive IS 'Is Subject Directory Type active';


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
    subjectgroupid uuid NOT NULL,
    subjectdirectoryid uuid,
    subjecttypeid uuid DEFAULT '21371a15-04f8-445e-a899-006ee11c0e09'::uuid NOT NULL,
    subjectgrouptypeid uuid DEFAULT 'c5ef2da7-b55e-4dec-8be3-96bf30255781'::uuid NOT NULL,
    isactive boolean DEFAULT false NOT NULL,
    effectivestartdate timestamp without time zone DEFAULT now() NOT NULL,
    effectiveenddate timestamp without time zone
);


ALTER TABLE abyss.subject_membership OWNER TO abyssuser;

--
-- Name: TABLE subject_membership; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_membership IS 'Generic Subject Membership Table for Abyss Platform Entities. Shows which subject belongs to which group, role, app.';


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

COMMENT ON COLUMN abyss.subject_membership.subjectid IS 'FK Id of Member Subject';


--
-- Name: COLUMN subject_membership.subjectgroupid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.subjectgroupid IS 'FK ID of Subject Group that Subject is member';


--
-- Name: COLUMN subject_membership.subjectdirectoryid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.subjectdirectoryid IS 'FK ID of Subject Directory';


--
-- Name: COLUMN subject_membership.subjecttypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.subjecttypeid IS 'FK ID of subject type of subject';


--
-- Name: COLUMN subject_membership.subjectgrouptypeid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.subjectgrouptypeid IS 'FK ID of subject type of group';


--
-- Name: COLUMN subject_membership.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.isactive IS 'Is subject membership active';


--
-- Name: COLUMN subject_membership.effectivestartdate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.effectivestartdate IS 'Effective start date time of user that he or she can start using the platform';


--
-- Name: COLUMN subject_membership.effectiveenddate; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_membership.effectiveenddate IS 'Effective end date time of user that he or she can use the platform until';


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
    organizationrefid uuid NOT NULL,
    isowner boolean DEFAULT false NOT NULL,
    isactive boolean DEFAULT false NOT NULL
);


ALTER TABLE abyss.subject_organization OWNER TO abyssuser;

--
-- Name: TABLE subject_organization; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subject_organization IS 'Abyss Platform Subject Organizations #paramTable#';


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
-- Name: COLUMN subject_organization.isowner; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.isowner IS 'Is the subject owner of the organization';


--
-- Name: COLUMN subject_organization.isactive; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subject_organization.isactive IS 'Is the subject membership for the organization active';


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

COMMENT ON TABLE abyss.subject_type IS 'Common properties and columns for Abyss Platform Entities #paramTable#';


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
-- Name: subresource_action; Type: TABLE; Schema: abyss; Owner: abyssuser
--

CREATE TABLE abyss.subresource_action (
    subresource text NOT NULL,
    resourceactionid uuid NOT NULL
);


ALTER TABLE abyss.subresource_action OWNER TO abyssuser;

--
-- Name: TABLE subresource_action; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON TABLE abyss.subresource_action IS 'Sub Resource - Resource Action Mapping #paramTable#';


--
-- Name: COLUMN subresource_action.subresource; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subresource_action.subresource IS 'Sub Resource';


--
-- Name: COLUMN subresource_action.resourceactionid; Type: COMMENT; Schema: abyss; Owner: abyssuser
--

COMMENT ON COLUMN abyss.subresource_action.resourceactionid IS 'FK Id of Resource Action';


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
2	a657b478-55d3-42ea-a7b1-e3cbb8210296	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.585669	2018-11-09 23:16:40.585669	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	4e92c400-1aea-4feb-b2a3-686763706a43	Blank Dashboard	Systems Blank Dashboard	t	[]
3	ca099337-95ac-4bde-9ec0-4634db46055e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.588827	2018-11-09 23:16:40.588827	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	4e92c400-1aea-4feb-b2a3-686763706a43	Systems Default Dashboard	Default Dashboard Description	t	[{"size": "2/3", "uuid": "fe5a0293-6bdb-4fc2-b1d6-24bcd81ab28c", "chart": {"name": "Column Chart", "type": "column"}, "color": "green", "order": 1, "title": "My Proxy APIs & Subscribers"}, {"size": "1/3", "uuid": "560a8452-5f0a-4ed5-a022-d25285df99cb", "chart": null, "color": "purple", "order": 2, "title": "APIs Shared with Me"}, {"size": "1/3", "uuid": "32520383-96f8-4e20-aee8-0a858cde2b7e", "chart": null, "color": "orange", "order": 3, "title": "APIs Shared by Me"}, {"size": "2/3", "uuid": "66f83423-11d0-42bf-93bd-be4c9015ebc9", "chart": {"name": "Pie Chart", "type": "pie"}, "color": "cyan", "order": 4, "title": "My APPS & Subscriptions"}, {"size": "2/3", "uuid": "b3d3edd5-99c2-42df-896c-c1cf881cd3bf", "chart": {"name": "Pie Chart", "type": "pie"}, "color": "red", "order": 5, "title": "My Business APIs"}]
4	138af93d-77f4-40a5-965b-f4c08476a32b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-09 23:16:40.591137	2018-11-09 23:16:40.591137	\N	f	4e92c400-1aea-4feb-b2a3-686763706a43	4e92c400-1aea-4feb-b2a3-686763706a43	Systems Secondary Dashboard	Secondary Dashboard Description	t	[{"size": "1/3", "uuid": "560a8452-5f0a-4ed5-a022-d25285df99cb", "chart": null, "color": "purple", "order": 1, "title": "APIs Shared with Me"}, {"size": "1/3", "uuid": "32520383-96f8-4e20-aee8-0a858cde2b7e", "chart": null, "color": "orange", "order": 2, "title": "APIs Shared by Me"}]
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

COPY abyss.organization (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description, url, isactive, picture) FROM stdin;
0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-21 13:49:02.843767	2019-03-12 18:55:30.074721	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Abyss	Abyss Public Organization	apiportal.com	t	
\.


--
-- Data for Name: policy_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.policy_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, name, description, type, subtype, template, isactive) FROM stdin;
51	f46957d7-e283-4582-9949-f20ae418fd60	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-03 18:40:47.095	2019-02-18 19:01:26.085777	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Privacy Policy Template	Abyss Platform Privacy Policy Template	Privacy	Anonymity Validation	{"info": {"title": "Privacy Policy Template", "x-type": "Privacy", "version": "0.0.3", "x-subType": "Anonymity Validation", "description": "Abyss Platform Privacy Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"PrivacyConfiguration": {"type": "object", "required": ["minimumEquivalanceClassSize", "openApiLifeCycle"], "properties": {"openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}, "minimumEquivalanceClassSize": {"type": "integer", "format": "int32", "example": 2147483647, "maximum": 2147483647, "minimum": 0, "description": "Parameter k of k-anonymity"}}, "description": "Privacy Configuration"}}}, "x-openApiPolicy": "0.0.5"}	t
1	d7d53112-a0c8-42b5-ba18-4a49fea4484d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-28 22:15:10.415	2019-02-18 19:01:16.757187	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Logging Policy Template	Abyss Platform Logging Policy Template	Operational	Logging	{"info": {"title": "Logging Policy Template", "x-type": "Operational", "version": "0.0.3", "x-subType": "Logging", "description": "Abyss Platform Logging Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"LogConfiguration": {"type": "object", "required": ["logLevel", "openApiLifeCycle"], "properties": {"logLevel": {"enum": ["ALL", "TRACE", "DEBUG", "INFO", "WARN", "ERROR", "FATAL", "OFF"], "type": "string", "example": "ERROR", "description": "Log Level"}, "openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}}, "description": "Log Configuration"}}}, "x-openApiPolicy": "0.0.5"}	t
102	db8b4ada-efc5-47bd-9fc1-1988149e7a59	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-11-30 21:09:36.66613	2019-02-18 18:39:48.438079	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Rate Limiting Policy Template	Abyss Platform Rate Limiting Policy Template	QoS	Throttling	{"info": {"title": "Apply Throttling Policy Template", "x-type": "QoS", "version": "0.0.3", "x-subType": "Throttling", "description": "Abyss Platform Throttling Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"ThrottlingConfiguration": {"type": "object", "required": ["delaytimeinmilliseconds", "delayattempts", "ratelimits", "openApiLifeCycle"], "properties": {"methods": {"type": "array", "items": {"enum": ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS", "HEAD", "TRACE", "CONNECT"], "type": "string", "example": "GET"}, "description": "Rate Limited Methods"}, "ratelimits": {"type": "array", "items": {"type": "object", "required": ["numberofreqs", "timeperiod", "timeunit"], "properties": {"timeunit": {"enum": ["Millisecond", "Second", "Minute", "Hour", "Day", "Week", "Month", "Year"], "type": "string", "example": "Second", "description": "Time Unit"}, "timeperiod": {"type": "integer", "format": "int32", "example": 2, "maximum": 1000, "minimum": 0, "description": "Time Period"}, "numberofreqs": {"type": "integer", "format": "int32", "example": 90, "maximum": 1000, "minimum": 0, "description": "Number of Reqs"}}}, "description": "Rate Limits"}, "delayattempts": {"type": "integer", "format": "int32", "example": 5, "maximum": 5, "minimum": 0, "description": "Delay Attempts"}, "openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}, "delaytimeinmilliseconds": {"type": "integer", "format": "int32", "example": 10000, "maximum": 10000, "minimum": 0, "description": "Delay Time in Milliseconds"}}, "description": "Throttling Configuration"}}}, "x-openApiPolicy": "0.0.5"}	t
2	18ec219d-990a-447e-a14b-3032d32bf648	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-28 22:18:51.253	2019-04-08 18:32:50.434551	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	API Authorization Policy Template	Abyss Platform API Authorization Policy Templateee	Service	API Authorization	{"info": {"title": "API Authorization Policy Template", "x-type": "Service", "version": "0.0.3", "x-subType": "API Authorization", "description": "Abyss Platform API Authorization Policy Template"}, "paths": {"/dummy/": {"get": {"summary": "dummy", "responses": {"default": {"description": "dummy"}}, "description": "dummy"}}}, "openapi": "3.0.1", "components": {"schemas": {"AuthorizationConfiguration": {"type": "object", "required": ["appAuthorization", "userAuthorization", "openApiLifeCycle"], "properties": {"appAuthorization": {"enum": ["OFF", "Abyss Access Manager"], "type": "string", "example": "Abyss Access Manager", "description": "App Access Manager"}, "openApiLifeCycle": {"type": "object", "required": ["onProxyRequest", "onProxyResponse", "onBusinessRequest", "onBusinessResponse"], "properties": {"onProxyRequest": {"type": "boolean", "example": true, "description": "Policy Active On Proxy Request"}, "onProxyResponse": {"type": "boolean", "example": false, "description": "Policy Active On Proxy Response"}, "onBusinessRequest": {"type": "boolean", "example": false, "description": "Policy Active On Business Request"}, "onBusinessResponse": {"type": "boolean", "example": false, "description": "Policy Active On Business Response"}}, "description": "Open API Life Cycle"}, "userAuthorization": {"enum": ["OFF", "Abyss Access Manager"], "type": "string", "example": "OFF", "description": "User Access Manager"}}, "description": "Authorization Configuration"}}}, "x-openApiPolicy": "0.0.5"}	t
\.


COPY abyss.resource (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, resourcetypeid, resourcename, description, resourcerefid, isactive, subresourcename) FROM stdin;
16201	210740a1-1302-45b8-a497-40c0dfba4b40	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.208855	2019-03-07 14:43:03.208855	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getAccessManagerTypes	/openapi/AccessManagerType.yaml-com.verapi.portal.oapi.AccessManagerTypeApiController-getAccessManagerTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16202	862f3628-6518-4df0-8337-5610494c06ee	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.364559	2019-03-07 14:43:03.364559	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiProxiesOfSubjectByGroup	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApiProxiesOfSubjectByGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16203	775ea4d3-204a-448c-b96c-bf78435e53f1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.462267	2019-03-07 14:43:03.462267	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getBusinessApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16204	623d5bee-da64-418b-a513-b9bd58843896	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.533226	2019-03-07 14:43:03.533226	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApi	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16252	3058bf08-d958-4b46-b250-67e0ffde7d85	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.331542	2019-03-07 14:43:03.331542	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiCategory	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-getApiApiCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16254	7c85a4cb-b492-488f-8e68-ca58a27d81a9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.555067	2019-03-07 14:43:03.555067	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16258	553081e9-8c1b-41b6-abdf-337909b2d5cf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.855025	2019-03-07 14:43:03.855025	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiTags	/openapi/ApiTag.yaml-com.verapi.portal.oapi.ApiTagApiController-deleteApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
74920	7f3c8d0a-fc6f-4e0a-8bb3-da513c2d3ed6	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-03 19:57:11.505816	2019-04-03 19:57:11.505816	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	Verapi.com Web Site API 1.0.1 API PROXY	This is Verapi.com API. You can find out more about Verapi at [https://verapi.com](https://verapi.com).\n	7d44594f-784b-4b44-bf5a-c4baf3612347	t	ALL_SUB_RESOURCES
16253	bf62b608-6b7f-4fb2-bf01-dc3148f04f9c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.449295	2019-03-07 14:43:03.449295	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiProxiesUnderLicense	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApiProxiesUnderLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16268	8905759a-b9e7-46a2-875f-3224b9fb010a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.386848	2019-03-07 14:43:04.386848	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectPermissions	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-updateSubjectPermissions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16255	e951fbc7-2ac9-4456-9786-7b3c28d2eaad	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.626558	2019-03-07 14:43:03.626558	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiGroupsOfSubject	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getApiGroupsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16256	5ef603dd-0dab-484b-a824-d3883722fce3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.713037	2019-03-07 14:43:03.713037	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiCategories	/openapi/ApiCategory.yaml-com.verapi.portal.oapi.ApiCategoryApiController-addApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16257	712c4ef2-9112-4dba-a4c5-add48bedae9c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.789622	2019-03-07 14:43:03.789622	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getLicensesOfApi	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-getLicensesOfApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
96568	7f5ee6ef-ac4d-4078-a9b2-7b5adfa9132a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.538475	2019-04-04 19:41:33.538475	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteUserAppMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-deleteUserAppMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16260	332e5350-f5b1-4bd2-977b-4c72d29b697b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.953812	2019-03-07 14:43:03.953812	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMessages	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-getMessages	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16261	e6d972c3-30f6-4ca8-af8d-3be419c8bb4c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.028217	2019-03-07 14:43:04.028217	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteOrganization	/openapi/Organization.yaml-com.verapi.portal.oapi.OrganizationApiController-deleteOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16262	32d8113d-a603-4848-8c97-1a20a4e7f9cd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.074646	2019-03-07 14:43:04.074646	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getPolicyTypes	/openapi/PolicyType.yaml-com.verapi.portal.oapi.PolicyTypeApiController-getPolicyTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16263	e2f232f9-54b8-48d6-9f37-bd0883daf241	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.134087	2019-03-07 14:43:04.134087	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResource	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-getResource	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16264	95fa21d0-0ce3-4efd-aa2f-c1b15247f37a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.177451	2019-03-07 14:43:04.177451	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectActivation	/openapi/SubjectActivation.yaml-com.verapi.portal.oapi.SubjectActivationApiController-getSubjectActivation	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16265	c52eb3af-a0c0-4cda-8258-6a4c71e7d2b7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.233943	2019-03-07 14:43:04.233943	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApps	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-updateApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16266	9579fc35-fe51-4a75-a5a3-fc22e7498036	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.29905	2019-03-07 14:43:04.29905	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectDirectoryTypes	/openapi/SubjectDirectoryType.yaml-com.verapi.portal.oapi.SubjectDirectoryTypeApiController-getSubjectDirectoryTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16267	e2103c8c-829b-455b-a144-ef6d748acdea	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.349435	2019-03-07 14:43:04.349435	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectOrganizations	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-addSubjectOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
23307	4612e10b-fe59-4bd6-a2ea-7f5ab6c8aa48	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 13:43:48.423078	2019-03-27 13:43:48.423078	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	checkResetPasswordToken	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-checkResetPasswordToken	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16251	f5661804-032c-4caf-b330-1c92b81d18f3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.211096	2019-03-07 14:43:03.211096	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteAccessManagerTypes	/openapi/AccessManagerType.yaml-com.verapi.portal.oapi.AccessManagerTypeApiController-deleteAccessManagerTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
108801	62ce85ea-9d95-4403-b837-b16ed68ddf92	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-10 12:26:37.394534	2019-04-10 12:26:37.394534	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of Weather APP with Bank Customer API API CONTRACT	Contract of Weather APP with Bank Customer API API	1dfeba57-0b5d-4638-853c-9b98198e750c	t	ALL_SUB_RESOURCES
16259	61ecf465-5507-430a-b933-bd85301af74e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.900684	2019-03-07 14:43:03.900684	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContractsOfApi	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-getContractsOfApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16306	7ea67f33-82e5-4a95-bdc6-a2bbe3f116d0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.763129	2019-03-07 14:43:03.763129	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiGroups	/openapi/ApiGroup.yaml-com.verapi.portal.oapi.ApiGroupApiController-deleteApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16312	002ff33a-f491-4958-bc18-0a4107b6c45b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.11625	2019-03-07 14:43:04.11625	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceAction	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-getResourceAction	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
23262	393b6357-6cfc-4b1e-9ab7-56caa40adad5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 13:43:48.447453	2019-03-27 13:43:48.447453	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	forgotPassword	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-forgotPassword	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
85905	685081ef-37b7-4f48-9d9f-66cb35303e3b	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:50.783991	2019-04-04 08:49:50.783991	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 1.0.0 6a5d1ecd-6893-4a0c-9785-5db6785f08ac API PROXY	omdb database	6a5d1ecd-6893-4a0c-9785-5db6785f08ac	t	ALL_SUB_RESOURCES
85903	cd02c3c7-4ca7-4260-947e-2e9c4d6d580c	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:43.733541	2019-04-04 08:49:43.733541	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 662da772-7dec-4f89-ad6a-3df2ed7a33bc API PROXY	Amadeus	662da772-7dec-4f89-ad6a-3df2ed7a33bc	t	ALL_SUB_RESOURCES
85902	7d7c6c61-9368-4e00-b55f-a1b5d69c774c	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:40.147033	2019-04-04 08:49:40.147033	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 6fbfbafb-9577-48d3-90d8-2b13a238762c API PROXY	Amadeus	6fbfbafb-9577-48d3-90d8-2b13a238762c	t	ALL_SUB_RESOURCES
16302	8e7ed6e4-7544-4934-9b7d-a997e1c20d8e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.333876	2019-03-07 14:43:03.333876	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiCategoriesOfSubject	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-getApiCategoriesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16303	906f8149-ce1f-4534-8157-a291dcdad134	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.431048	2019-03-07 14:43:03.431048	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getBusinessApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16304	a20eccdd-1d14-4dd7-87bb-c710a342d94d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.513682	2019-03-07 14:43:03.513682	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16311	6728a76e-7a54-4570-82c7-33e834d1e4b7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.062189	2019-03-07 14:43:04.062189	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getPoliciesOfSubject	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-getPoliciesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16307	aeac9032-963a-4461-a9c6-0a8641c1cea2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.827085	2019-03-07 14:43:03.827085	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiStates	/openapi/ApiState.yaml-com.verapi.portal.oapi.ApiStateApiController-deleteApiStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16308	381c75c9-0ea5-4dae-bdc5-a8e01e8e878a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.869492	2019-03-07 14:43:03.869492	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	logout	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-logout	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16310	9f905a17-492b-4b72-970b-3e9473fc015d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.992881	2019-03-07 14:43:03.992881	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addMessageTypes	/openapi/MessageType.yaml-com.verapi.portal.oapi.MessageTypeApiController-addMessageTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16317	863c49e5-7bf7-4ad0-bf73-8aedf9d7e3d6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.359877	2019-03-07 14:43:04.359877	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectsOfOrganization	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-getSubjectsOfOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16313	9c76db01-a475-4ffe-a023-dc8b6257e180	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.169437	2019-03-07 14:43:04.169437	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResourceType	/openapi/ResourceType.yaml-com.verapi.portal.oapi.ResourceTypeApiController-deleteResourceType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16314	b74290f1-9b5e-4e91-b47e-c7143f33bb7a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.220809	2019-03-07 14:43:04.220809	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubject	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-deleteSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16315	b62a42a0-504c-434b-b62d-548e3a32472f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.290689	2019-03-07 14:43:04.290689	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectDirectory	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-getSubjectDirectory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16316	7a0992f5-d050-48b1-bf07-4baccb4c0262	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.327394	2019-03-07 14:43:04.327394	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectGroups	/openapi/SubjectGroup.yaml-com.verapi.portal.oapi.SubjectGroupApiController-addSubjectGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
85904	e8b22d66-acb0-4070-90b2-bc29cbf7295f	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:50.329786	2019-04-04 08:49:50.329786	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 1.0.0 2f34d117-1253-4f71-a88a-9301f2db6fa9 API PROXY	omdb database	2f34d117-1253-4f71-a88a-9301f2db6fa9	t	ALL_SUB_RESOURCES
85901	ecbdb777-1142-4f83-b9e8-a0e32c0b486c	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:35.303006	2019-04-04 08:49:35.303006	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 d57723dc-007f-45fd-89c1-8b39719035d4 API PROXY	Amadeus	d57723dc-007f-45fd-89c1-8b39719035d4	t	ALL_SUB_RESOURCES
16301	dcbdac16-4939-4979-8111-0ff93dc89336	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.213329	2019-03-07 14:43:03.213329	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateAccessManagerTypes	/openapi/AccessManagerType.yaml-com.verapi.portal.oapi.AccessManagerTypeApiController-updateAccessManagerTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
85906	8c67b492-fc1b-476d-aaf4-d2e8aac95e56	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 09:42:32.972392	2019-04-04 09:42:32.972392	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4ddbc735-8905-488a-81a4-f21a45ebc4ef	tarikP1 POLICY	deneme	e8093fc7-dd31-4a0c-b9c3-ba0a1ed43b59	t	ALL_SUB_RESOURCES
96517	bc3177b9-4cfa-4d53-9d2d-dede9456a41d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.539534	2019-04-04 19:41:33.539534	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteUserGroupMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-deleteUserGroupMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16305	cda41cdd-f95f-4d28-aacf-bec6649878c0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.628954	2019-03-07 14:43:03.628954	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApiGroupsOfSubject	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getBusinessApiGroupsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
143601	1fc0cd36-6e85-41c7-99d1-5500266a6cd0	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-13 19:40:07.546045	2019-04-13 19:40:07.546045	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of Identity APP APP with Open Weather Map 2 API CONTRACT	Contract of Identity APP APP with Open Weather Map 2 API	72fca54b-6e4e-47ed-b4e9-1645b59de20d	t	ALL_SUB_RESOURCES
16360	4e4f7be4-12c4-4ba2-8e4a-d756965bfba2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.944679	2019-03-07 14:43:03.944679	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateLicensesOfSubject	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-updateLicensesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16364	28de80ee-711b-45de-8dd3-98eb813f5445	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.140092	2019-03-07 14:43:04.140092	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResource	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-deleteResource	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
85954	04684fab-1840-42cc-bf75-091ae9d79509	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:50.571218	2019-04-04 08:49:50.571218	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 1.0.0 576fb009-7442-478f-a23a-2d785b0174db API PROXY	omdb database	576fb009-7442-478f-a23a-2d785b0174db	t	ALL_SUB_RESOURCES
16352	00417aa3-b6c0-43c5-b90e-7b36b070b145	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.343222	2019-03-07 14:43:03.343222	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiApiCategory	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-updateApiApiCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16353	37c76ca8-7a8c-47c4-adbb-35a5fc066555	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.436866	2019-03-07 14:43:03.436866	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiProxiesOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateApiProxiesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16354	222ba6f8-23ed-47c0-96e5-915c661efab3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.533725	2019-03-07 14:43:03.533725	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiProxies	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApiProxies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16357	bd913d23-265c-4124-9673-b3bbb45f6f65	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.779423	2019-03-07 14:43:03.779423	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiLicense	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-getApiLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16358	d454693f-a769-4112-9ea9-cdac4ea5f16e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.841718	2019-03-07 14:43:03.841718	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiTags	/openapi/ApiTag.yaml-com.verapi.portal.oapi.ApiTagApiController-addApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16363	ade94d3b-3a5f-4708-b4a7-a04d6339040f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.096018	2019-03-07 14:43:04.096018	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceAccessTokens	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-getResourceAccessTokens	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16361	40a70220-d171-4d93-a0f0-3dbb557429da	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.980288	2019-03-07 14:43:03.980288	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMessagesOfSubject	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-getMessagesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16362	5b7ebeac-b105-41bb-a8d8-eb5cf81b0c14	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.046417	2019-03-07 14:43:04.046417	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addPoliciesOfSubject	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-addPoliciesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
85953	c2e12e91-5adb-4cd4-8094-49db2037c753	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:48.587928	2019-04-04 08:49:48.587928	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 1.0.0 77c96864-f845-49ad-90f9-c635e57df458 API PROXY	omdb database	77c96864-f845-49ad-90f9-c635e57df458	t	ALL_SUB_RESOURCES
16365	976b8651-2484-43b4-9378-34059a72fbbd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.191186	2019-03-07 14:43:04.191186	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectActivation	/openapi/SubjectActivation.yaml-com.verapi.portal.oapi.SubjectActivationApiController-updateSubjectActivation	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16366	a8064e93-eaa2-46be-bbfd-9f2f3eba86a1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.254124	2019-03-07 14:43:04.254124	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectApps	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-deleteSubjectApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16367	1c86c972-61f2-4b62-8945-d47cc0e7a094	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.294354	2019-03-07 14:43:04.294354	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectDirectories	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-deleteSubjectDirectories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16369	693e2df0-c4c8-4143-bace-764afccdc777	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.373497	2019-03-07 14:43:04.373497	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiSubscriptionsOfSubject	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-updateApiSubscriptionsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
24063	e246a241-18a0-4b8f-bfa8-75f1dac868e3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 13:43:48.758725	2019-03-27 13:43:48.758725	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteMembershipsOfGroup	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-deleteMembershipsOfGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
85952	e81b95a8-3d21-40cf-9a5b-3af01979a78f	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:41.332057	2019-04-04 08:49:41.332057	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 655365bc-de65-4b9c-b5ff-3b106a6a63a8 API PROXY	Amadeus	655365bc-de65-4b9c-b5ff-3b106a6a63a8	t	ALL_SUB_RESOURCES
97065	db87de6a-9567-43ed-b905-688e93c842bb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.540424	2019-04-04 19:41:33.540424	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getGroupRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getGroupRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
85955	8cfd7c5e-e5a8-46d3-8c73-39c675f429c0	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:54.718279	2019-04-04 08:49:54.718279	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 bc3cd07d-4f80-4308-a72d-6caad8afc1c8 API PROXY	Amadeus	bc3cd07d-4f80-4308-a72d-6caad8afc1c8	t	ALL_SUB_RESOURCES
16351	72b6d0d8-99e0-4cf6-8660-6347ca9c83b4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.216426	2019-03-07 14:43:03.216426	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getAccessManagerType	/openapi/AccessManagerType.yaml-com.verapi.portal.oapi.AccessManagerTypeApiController-getAccessManagerType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16359	027f2756-638e-4944-8b5c-8af756b4d4dc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.885686	2019-03-07 14:43:03.885686	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateContract	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-updateContract	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16403	778d12d6-4b6f-4a35-b6f4-9a05b9e1bb07	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.473333	2019-03-07 14:43:03.473333	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiProxies	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteApiProxies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
86002	26cfe4be-ed2b-4fe5-85eb-6991b4c24d05	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 09:29:10.679186	2019-04-04 09:29:10.679186	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 b1e4ed6c-963f-47a5-9dfc-6c8979e346b0 API PROXY	Amadeus	b1e4ed6c-963f-47a5-9dfc-6c8979e346b0	t	ALL_SUB_RESOURCES
16413	80db5e6f-10cd-45c8-932e-ba9c966cd5f2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.219316	2019-03-07 14:43:04.219316	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getUsers	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getUsers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
96768	5fe25dee-53df-4f9c-b2ac-2a70d601412e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.541332	2019-04-04 19:41:33.541332	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateUserGroupMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-updateUserGroupMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
86003	90f8da1e-dd24-491a-be43-6da33a6e4e7e	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 11:11:40.530111	2019-04-04 11:11:40.530111	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4ddbc735-8905-488a-81a4-f21a45ebc4ef	Ihsan Policy N1 POLICY	Ihsan Policy N1	9f456296-c139-465b-b011-460ef55a610f	t	ALL_SUB_RESOURCES
85951	a80b868c-04f3-429b-aca5-f9afaf1ec66e	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 08:49:37.962004	2019-04-04 08:49:37.962004	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 9eb73c4a-c1c4-4c23-bd16-e88a390eed07 API PROXY	Amadeus	9eb73c4a-c1c4-4c23-bd16-e88a390eed07	t	ALL_SUB_RESOURCES
16405	268b96de-3eac-4a03-934c-46512520b7ff	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.705825	2019-03-07 14:43:03.705825	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApiTagsOfSubject	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getBusinessApiTagsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16406	05075581-e592-4f51-860f-7cd4193c1b8d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.804551	2019-03-07 14:43:03.804551	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiLicense	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-deleteApiLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16407	bf2e577e-66a9-44bf-8206-c5cb5c5778e9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.863442	2019-03-07 14:43:03.863442	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiVisibilityType	/openapi/ApiVisibilityType.yaml-com.verapi.portal.oapi.ApiVisibilityTypeApiController-deleteApiVisibilityType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16408	14dccb51-3c45-4d1f-b206-d7873c794e92	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.906722	2019-03-07 14:43:03.906722	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContractState	/openapi/ContractState.yaml-com.verapi.portal.oapi.ContractStateApiController-getContractState	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16409	864cdc00-5559-420a-8702-2ae11932d435	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.954875	2019-03-07 14:43:03.954875	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMessage	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-getMessage	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16410	fb5ec855-968c-405e-9492-dbdd0e1ed52c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.040603	2019-03-07 14:43:04.040603	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addPolicies	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-addPolicies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16412	63147d18-3cc0-41da-9eb7-25281fe34f8d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.158698	2019-03-07 14:43:04.158698	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceType	/openapi/ResourceType.yaml-com.verapi.portal.oapi.ResourceTypeApiController-getResourceType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16414	1a964ce6-8dc1-4d0f-bfcc-a9d903bdba0b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.280407	2019-03-07 14:43:04.280407	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectApp	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-getSubjectApp	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16416	aa67643f-c4ea-46a5-974e-fb0e96e89dc4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.374611	2019-03-07 14:43:04.374611	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getPermissionsOfSubject	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-getPermissionsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
86001	e608fc85-5cb3-41ee-b02c-6f1dc7be9867	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 09:29:09.003007	2019-04-04 09:29:09.003007	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 51a3f15e-9e1f-42c6-8a89-b7d2840f2732 API PROXY	Amadeus	51a3f15e-9e1f-42c6-8a89-b7d2840f2732	t	ALL_SUB_RESOURCES
16401	16218c58-d190-4a73-a9c6-285617802c45	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.218633	2019-03-07 14:43:03.218633	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getAccessManager	/openapi/AccessManager.yaml-com.verapi.portal.oapi.AccessManagerApiController-getAccessManager	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16509	cf85f997-0898-423c-a771-a616a0721e0d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.940873	2019-03-07 14:43:03.940873	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addLicensesOfSubject	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-addLicensesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16411	50bd000c-fb7d-4757-9436-0a9c9401c314	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.098524	2019-03-07 14:43:04.098524	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addResourceAccessTokens	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-addResourceAccessTokens	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16402	ab58f771-906b-4035-ba4c-d1d72c88b4e1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.383471	2019-03-07 14:43:03.383471	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApisSharedWithSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApisSharedWithSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16558	a8ed69c8-ab0e-40fb-b572-0e2f2bcb9447	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.879687	2019-03-07 14:43:03.879687	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addContracts	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-addContracts	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16453	dea05589-0d30-4e40-ba58-8368620526ab	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.448609	2019-03-07 14:43:03.448609	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiProxiesOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-addApiProxiesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16458	eafba0bc-32be-4a5e-9f19-78db64b8ee6d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.939814	2019-03-07 14:43:03.939814	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getLicenses	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-getLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16456	4fb615c1-a71b-4170-8a17-85f6967d5a24	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.783323	2019-03-07 14:43:03.783323	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiLicenses	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-getApiLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16459	d78f6be9-81e2-4aff-9e69-ab3eca0b8c31	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.014572	2019-03-07 14:43:04.014572	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getOrganization	/openapi/Organization.yaml-com.verapi.portal.oapi.OrganizationApiController-getOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16451	cba62264-cd97-425d-9d03-a996103d5806	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.220831	2019-03-07 14:43:03.220831	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addAccessManagers	/openapi/AccessManager.yaml-com.verapi.portal.oapi.AccessManagerApiController-addAccessManagers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
86052	2470205e-4e25-4db6-b3c2-d18ce57f0e3f	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 09:29:11.222067	2019-04-04 10:56:46.170544	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 API PROXY	Amadeus	9db921d7-0783-4880-9a0b-ffcd2ba50fc2	t	ALL_SUB_RESOURCES
96968	56e4ae7a-2472-4ae7-9ccb-32976b4f98d2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.542357	2019-04-04 19:41:33.542357	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addUserRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-addUserRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16454	d4a5e602-3a71-4e19-83c4-3c317f223ee2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.55928	2019-03-07 14:43:03.55928	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-addApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16455	35c02f32-6bbe-499d-b4fb-69722a380a0c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.671319	2019-03-07 14:43:03.671319	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiApiTag	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-updateApiApiTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16457	c15378a2-a9bf-4de5-ba5d-4b3cfa8ddc85	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.868258	2019-03-07 14:43:03.868258	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiVisibilityTypes	/openapi/ApiVisibilityType.yaml-com.verapi.portal.oapi.ApiVisibilityTypeApiController-addApiVisibilityTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55301	2b8c5cfb-6129-4e8b-a566-901f883ef2f2	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-03-28 13:40:04.950552	2019-03-28 13:40:04.950552	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of ABC APP with Ihsan Weather Proxy API 2 API CONTRACT	Contract of ABC APP with Ihsan Weather Proxy API 2 API	aee73e43-a011-4dc5-9ce9-1ae3b449117b	t	ALL_SUB_RESOURCES
16460	9aa549e3-e2f0-42b8-9f72-24777a180ea5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.104611	2019-03-07 14:43:04.104611	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResourceAccessToken	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-updateResourceAccessToken	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16461	ea127f25-29e5-486e-ad52-b183f5a6d50d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.14667	2019-03-07 14:43:04.14667	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResource	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-updateResource	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16462	ddb9ac6c-3355-46a3-bc92-f3057b572d6b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.203809	2019-03-07 14:43:04.203809	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubject	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-updateSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16463	acd5d617-f33a-4de4-a7e2-3d472a3c1a11	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.249238	2019-03-07 14:43:04.249238	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteUsers	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-deleteUsers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16464	ecb598ab-4fc5-441e-a21b-a042957e9bfe	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.301719	2019-03-07 14:43:04.301719	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectDirectoryTypes	/openapi/SubjectDirectoryType.yaml-com.verapi.portal.oapi.SubjectDirectoryTypeApiController-updateSubjectDirectoryTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16465	3ae58def-60b3-4054-bc03-8462f531a413	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.342209	2019-03-07 14:43:04.342209	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMembershipsUnderDirectory	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getMembershipsUnderDirectory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16466	e68c2a07-83eb-473e-8678-22ef47c8ec89	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.38187	2019-03-07 14:43:04.38187	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectPermissions	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-addSubjectPermissions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16452	fe8dd78a-747d-48e3-bb4c-c8456bbad517	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.353855	2019-03-07 14:43:03.353855	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiCategories	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-getApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
86051	d73ef46a-34ce-48af-9cdc-eddb56c440ea	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 09:29:09.935507	2019-04-04 09:29:09.935507	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 1.0.0 73ccc891-0c0d-4ecc-bead-7a235db74b21 API PROXY	Amadeus	73ccc891-0c0d-4ecc-bead-7a235db74b21	t	ALL_SUB_RESOURCES
86101	bf59745c-cad8-4a4f-a539-e6583d9479d8	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 09:42:36.045151	2019-04-04 09:42:36.045151	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	Ihsan License L2 LICENSE	Ihsan License L2 desc	6790ae5c-1eef-4d7c-a3e5-f0bd66302a8b	t	ALL_SUB_RESOURCES
16502	d789428b-63f7-4c6b-a98c-fd15b058cbf6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.355143	2019-03-07 14:43:03.355143	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiProxiesOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteApiProxiesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16503	4f645fcb-ceb3-4b05-8b19-61711e8711f4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.458707	2019-03-07 14:43:03.458707	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteBusinessApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteBusinessApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16504	af0e020d-5621-4a5b-bfbc-6ffaba389ff7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.572798	2019-03-07 14:43:03.572798	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiApiGroup	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-deleteApiApiGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16505	0bb2d5cd-54ea-4707-ac82-b1587ad8bb82	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.675418	2019-03-07 14:43:03.675418	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getProxyApiTagsOfSubject	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getProxyApiTagsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16506	e942f88d-ae6d-4544-a49a-322a7755b6dc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.77009	2019-03-07 14:43:03.77009	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiGroup	/openapi/ApiGroup.yaml-com.verapi.portal.oapi.ApiGroupApiController-getApiGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16507	5891bffb-0530-446d-a204-0c820f63d861	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.850079	2019-03-07 14:43:03.850079	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiTag	/openapi/ApiTag.yaml-com.verapi.portal.oapi.ApiTagApiController-getApiTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16508	0f6f9a79-3862-48b2-b1d2-94288dc42c62	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.896386	2019-03-07 14:43:03.896386	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContractsOfApp	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-getContractsOfApp	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16510	9bdf1759-640b-477c-af00-b41d8ea517af	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.995633	2019-03-07 14:43:03.995633	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteMessageTypes	/openapi/MessageType.yaml-com.verapi.portal.oapi.MessageTypeApiController-deleteMessageTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16511	1797b5aa-9d6c-4396-b26d-f7effb4a067b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.065526	2019-03-07 14:43:04.065526	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deletePolicyType	/openapi/PolicyType.yaml-com.verapi.portal.oapi.PolicyTypeApiController-deletePolicyType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16513	315defaf-2f69-4f95-a491-520ecd58b017	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.170577	2019-03-07 14:43:04.170577	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResourceType	/openapi/ResourceType.yaml-com.verapi.portal.oapi.ResourceTypeApiController-updateResourceType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16514	1c647fbc-25c5-4e1c-9dbd-aba25992514b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.220993	2019-03-07 14:43:04.220993	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateUsers	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-updateUsers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16515	e83244f8-6da6-43a9-88c2-70a326d1a03e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.274311	2019-03-07 14:43:04.274311	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectApps	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-getSubjectApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16516	e698bbdf-8c36-4030-96fe-1b0cbb951b14	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.31311	2019-03-07 14:43:04.31311	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectDirectoryType	/openapi/SubjectDirectoryType.yaml-com.verapi.portal.oapi.SubjectDirectoryTypeApiController-deleteSubjectDirectoryType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16517	2872fade-29ba-4761-966e-abda03ca4ffd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.354007	2019-03-07 14:43:04.354007	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectOrganization	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-deleteSubjectOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16518	51ece0f5-dffc-4eb0-8566-3933bea4519c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.403441	2019-03-07 14:43:04.403441	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectType	/openapi/SubjectType.yaml-com.verapi.portal.oapi.SubjectTypeApiController-deleteSubjectType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
86151	93a52f9b-a58e-4a1f-9069-a6b94496915f	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 09:42:36.083678	2019-04-04 09:42:36.083678	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	Ihsan License L1 LICENSE	Ihsan License L1	992172b1-0477-4729-952a-39e94969329a	t	ALL_SUB_RESOURCES
97018	53175d3f-1224-4de7-b313-bef86c433f8f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.543386	2019-04-04 19:41:33.543386	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getUserAppMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getUserAppMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16501	260b46e3-621b-4dee-9339-a9df1265239e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.223196	2019-03-07 14:43:03.223196	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiCategoryByApiAndCategory	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-getApiApiCategoryByApiAndCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16551	d17eb482-1509-4a8b-befd-4fcf3537b157	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.225305	2019-03-07 14:43:03.225305	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiApiCategory	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-deleteApiApiCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16552	ebe3f5ea-3874-4aa7-93ff-74dcef6b3d3f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.357212	2019-03-07 14:43:03.357212	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getAggregatedTagsOfBusinessApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getAggregatedTagsOfBusinessApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16554	f7413dee-3bad-4951-9f61-206eee0c521d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.555648	2019-03-07 14:43:03.555648	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApi	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16555	85b43dfd-b924-4860-8c24-d79612f67cc7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.664983	2019-03-07 14:43:03.664983	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiApiTags	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-updateApiApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16557	53aafe8a-27b1-42d1-9bea-cabd9cc81493	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.822713	2019-03-07 14:43:03.822713	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiState	/openapi/ApiState.yaml-com.verapi.portal.oapi.ApiStateApiController-updateApiState	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16559	836c9af9-64e4-4ae3-b703-194b8ace72ee	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.93328	2019-03-07 14:43:03.93328	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateLicense	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-updateLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16560	9fd16d70-8701-4018-b1d6-3cd960e69f74	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.038367	2019-03-07 14:43:04.038367	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteOrganizations	/openapi/Organization.yaml-com.verapi.portal.oapi.OrganizationApiController-deleteOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16561	0179c153-dfb9-47a5-b2da-7be92c2711a9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.10306	2019-03-07 14:43:04.10306	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResourceAccessTokens	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-deleteResourceAccessTokens	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16562	d3509cea-3a60-4421-9529-1a97e3de36a5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.148371	2019-03-07 14:43:04.148371	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourcesOfSubject	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-getResourcesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16563	ca23957b-14dd-4bd2-a59d-043eb4450b53	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.191885	2019-03-07 14:43:04.191885	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getUserWithGroupsAndPermissions	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getUserWithGroupsAndPermissions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16564	e7ec8e7e-0597-47d4-b29a-070d6a2306c1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.2485	2019-03-07 14:43:04.2485	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteGroups	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-deleteGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16566	7d66a94d-8abd-47e6-904f-c6acf6c2f952	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.344814	2019-03-07 14:43:04.344814	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectOrganizations	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-getSubjectOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16567	90cfedc5-e5a4-4f3f-b28b-4e5729f22442	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.381634	2019-03-07 14:43:04.381634	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectPermissions	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-deleteSubjectPermissions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55401	d6ae9bf3-c0e1-4f91-ae40-6d653129a8b9	4f5f9d2a-2d85-4f5b-bbb1-253ec051337e	2019-03-28 18:10:15.012858	2019-03-28 18:10:15.012858	1900-01-01 00:00:00	f	f8d811e3-0394-4af3-b30d-e356991069cf	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	secrove APP	secrove	e1bcca94-f159-4916-8432-01944335b4a8	t	ALL_SUB_RESOURCES
86201	98ffa0bd-ec36-421a-858a-0b822b1e66fb	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 10:58:22.738827	2019-04-04 10:58:22.738827	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 2.0.0 700b4411-31b7-478f-867e-2f7db3a01af2 API PROXY	Amadeus	700b4411-31b7-478f-867e-2f7db3a01af2	t	ALL_SUB_RESOURCES
16606	8e299653-7ad4-4c8c-aa27-cf82583b1597	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.80371	2019-03-07 14:43:03.80371	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiLicense	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-updateApiLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16603	b76ffc74-8e6c-4a6a-9ed5-364319a50b1a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.443688	2019-03-07 14:43:03.443688	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiProxiesOfSubjectByCategory	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApiProxiesOfSubjectByCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16604	db2a2ed0-6c6d-4f1e-bcde-67c4c7d52ce9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.568388	2019-03-07 14:43:03.568388	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addBusinessApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-addBusinessApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16608	1cd2a97e-8048-47df-9c2b-c133553e9204	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.861916	2019-03-07 14:43:03.861916	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiVisibilityType	/openapi/ApiVisibilityType.yaml-com.verapi.portal.oapi.ApiVisibilityTypeApiController-updateApiVisibilityType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16609	d03e14ab-5664-4255-b5b7-e2df3f7ed2f2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.915139	2019-03-07 14:43:03.915139	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContractStates	/openapi/ContractState.yaml-com.verapi.portal.oapi.ContractStateApiController-getContractStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16610	f9ed8a3f-1a40-4ce6-b6ea-5c9e20b82ef1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.977978	2019-03-07 14:43:03.977978	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteMessage	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-deleteMessage	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16611	0c51bf83-db19-471d-b9f2-2e8ce4e8dfca	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.036842	2019-03-07 14:43:04.036842	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateOrganizations	/openapi/Organization.yaml-com.verapi.portal.oapi.OrganizationApiController-updateOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16612	ba3cd489-cc10-4c1f-849e-25d8ac6a4374	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.098697	2019-03-07 14:43:04.098697	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceAccessToken	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-getResourceAccessToken	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16613	8562c42d-305d-4aad-9d63-73d8dce8d09c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.149782	2019-03-07 14:43:04.149782	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResources	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-updateResources	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16615	24d31453-4755-4499-a320-b6f01931f1cb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.251058	2019-03-07 14:43:04.251058	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateGroups	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-updateGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16616	bb9eb790-ddec-4780-bc4e-f0bf8262f5a2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.305904	2019-03-07 14:43:04.305904	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectDirectoryType	/openapi/SubjectDirectoryType.yaml-com.verapi.portal.oapi.SubjectDirectoryTypeApiController-getSubjectDirectoryType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16617	8b02f7fd-44ea-4808-a919-5cccc7b100ea	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.34926	2019-03-07 14:43:04.34926	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectOrganization	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-getSubjectOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16618	d30d84e0-4f6d-473e-b63f-fed35068d19b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.389898	2019-03-07 14:43:04.389898	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectPermission	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-deleteSubjectPermission	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55451	754a81fe-0f13-4d41-a948-e26d5ead1dfd	4f5f9d2a-2d85-4f5b-bbb1-253ec051337e	2019-03-28 18:15:34.363727	2019-03-28 18:15:34.363727	1900-01-01 00:00:00	f	f8d811e3-0394-4af3-b30d-e356991069cf	4ddbc735-8905-488a-81a4-f21a45ebc4ef	secrove-policy POLICY	test	a4ab17b9-ca15-4ecd-84bb-2f6f07c88eea	t	ALL_SUB_RESOURCES
97318	c417784d-590f-41cb-8e51-b79b7f630cd5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.544318	2019-04-04 19:41:33.544318	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteUserRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-deleteUserRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16605	2a5ca64a-4e1e-4170-860d-775db8912ae0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.695216	2019-03-07 14:43:03.695216	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiTagsOfSubject	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getApiTagsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16309	ff7326dd-5740-410f-897c-13d42208815f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.937538	2019-03-07 14:43:03.937538	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteLicenses	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-deleteLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16355	0a2b3007-29fd-46d1-a72c-611f62599ec8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.636347	2019-03-07 14:43:03.636347	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getProxyApiGroupsOfSubject	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getProxyApiGroupsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16368	662be35a-d18a-4c20-8d44-968792dec846	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.332891	2019-03-07 14:43:04.332891	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-updateSubjectMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16404	ab4ac7ec-47f1-4031-9c5c-328c480d0358	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.594112	2019-03-07 14:43:03.594112	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiGroup	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getApiApiGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16415	22471ff3-ff1e-4f4d-8502-836d578ab7f2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.334954	2019-03-07 14:43:04.334954	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectGroup	/openapi/SubjectGroup.yaml-com.verapi.portal.oapi.SubjectGroupApiController-getSubjectGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16601	6af96106-9f6a-4a87-ac97-40bd3a01ce93	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.227428	2019-03-07 14:43:03.227428	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateAccessManagerType	/openapi/AccessManagerType.yaml-com.verapi.portal.oapi.AccessManagerTypeApiController-updateAccessManagerType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
91251	920753ff-7807-465a-b20e-3639fe3a9c8b	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 12:50:30.53174	2019-04-04 12:50:30.53174	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	License N1 LICENSE	License N1 Description	449e1805-c7d7-46b8-8571-968348e4fdd0	t	ALL_SUB_RESOURCES
16657	97b7ab98-6f48-4a5f-aca4-b90c7cf4c954	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.829378	2019-03-07 14:43:03.829378	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiState	/openapi/ApiState.yaml-com.verapi.portal.oapi.ApiStateApiController-getApiState	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
91303	92daebd6-e216-4aec-a97a-b0ed8a5ccbc8	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 12:52:41.082665	2019-04-04 12:52:41.082665	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 3.0.0 647433c5-b3a5-47e8-8ce8-937d7ec00b24 API PROXY	omdb database	647433c5-b3a5-47e8-8ce8-937d7ec00b24	t	ALL_SUB_RESOURCES
16652	3128b4a8-a1e2-4ffa-aa9a-6483007900bf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.359373	2019-03-07 14:43:03.359373	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApisOfSubjectByGroup	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getBusinessApisOfSubjectByGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16653	6fa10d3f-e574-4a5a-bb23-adb293417dc8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.453447	2019-03-07 14:43:03.453447	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16654	65624932-010a-4cc2-b182-fa46b921dc38	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.552694	2019-03-07 14:43:03.552694	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiProxy	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApiProxy	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16655	a5dd8ca0-cf29-4aa3-8e01-f97d7e0c80d8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.663199	2019-03-07 14:43:03.663199	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiApiTags	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-addApiApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
91302	631bc8f6-500e-44eb-a590-3d1d30689db2	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 12:52:22.903183	2019-04-04 12:52:22.903183	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 3.0.0 60ef2dee-9f84-4dbb-9a57-fb582299786a API PROXY	omdb database	60ef2dee-9f84-4dbb-9a57-fb582299786a	t	ALL_SUB_RESOURCES
16658	e8563ff0-2106-4546-bca0-208c7360cad3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.878208	2019-03-07 14:43:03.878208	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContracts	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-getContracts	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16660	c212f476-3d34-45c3-9b81-bb3e9b32bedb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.981148	2019-03-07 14:43:03.981148	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateMessage	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-updateMessage	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16661	98930b64-936e-43c1-b828-1fd37d90332a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.042408	2019-03-07 14:43:04.042408	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updatePolicy	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-updatePolicy	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16662	992ad490-efb7-407a-87cd-09e2c744b93c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.11192	2019-03-07 14:43:04.11192	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResourceActions	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-updateResourceActions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16663	a665be0b-4a90-4450-8026-451baf4b9f9a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.147891	2019-03-07 14:43:04.147891	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourcesOfOrganization	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-getResourcesOfOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16664	d8dabb69-b09b-4356-abe5-538cb5e552d9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.20298	2019-03-07 14:43:04.20298	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getGroupsUnderDirectory	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getGroupsUnderDirectory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16665	527648f5-e0fc-4889-a8d7-5102dc2624d3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.270518	2019-03-07 14:43:04.270518	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectApp	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-updateSubjectApp	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16666	8b79cbf2-cbb0-41e4-bfcf-dd56bba16529	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.318747	2019-03-07 14:43:04.318747	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectGroup	/openapi/SubjectGroup.yaml-com.verapi.portal.oapi.SubjectGroupApiController-updateSubjectGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16667	f9d6a62e-46bd-4c85-852d-eac1f0977d8d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.353497	2019-03-07 14:43:04.353497	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getOrganizationsOfSubject	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-getOrganizationsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16668	d9375382-2b51-421b-9f10-6349d03f5ad7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.388689	2019-03-07 14:43:04.388689	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectPermission	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-updateSubjectPermission	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55501	d0a39d83-2187-4ac4-9726-b88cfef64fc6	4f5f9d2a-2d85-4f5b-bbb1-253ec051337e	2019-03-28 18:16:09.556432	2019-03-28 18:16:09.556432	1900-01-01 00:00:00	f	f8d811e3-0394-4af3-b30d-e356991069cf	4a3d51ce-cbd6-405b-bf58-328332efa499	secrove LICENSE	API License Description	6c8c7d3b-7b24-422a-a7ac-9dd448517193	t	ALL_SUB_RESOURCES
91301	c0e06ad3-7de9-429c-b693-a3ed972715c9	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 12:51:07.819987	2019-04-04 12:51:07.819987	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Amadeus 2.0.0 132e1fe8-c1ae-4553-b2b0-b04bf7d72b05 API PROXY	Amadeus	132e1fe8-c1ae-4553-b2b0-b04bf7d72b05	t	ALL_SUB_RESOURCES
16512	28282c19-359a-446c-a249-40e0fcfe2617	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.116704	2019-03-07 14:43:04.116704	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceActionsOfResourceType	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-getResourceActionsOfResourceType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
91304	5e8547a7-1204-4379-b388-51c0026d8b46	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 12:56:57.256498	2019-04-04 16:49:25.235205	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 2.0.0 API PROXY	omdb database	cc136ea1-aa42-40da-9798-c2b9927d94bc	t	ALL_SUB_RESOURCES
16656	97a57b26-c218-42a7-b18e-60d1f63db640	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.754624	2019-03-07 14:43:03.754624	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiGroups	/openapi/ApiGroup.yaml-com.verapi.portal.oapi.ApiGroupApiController-updateApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55351	f243ec17-68de-458a-853b-b4395e40b834	2203c91b-9c51-4a42-b1c8-2c93eb5d434e	2019-03-28 18:01:22.554184	2019-03-28 18:01:22.554184	1900-01-01 00:00:00	f	87918192-96a9-4957-801d-9cb817f9b9dd	505099b4-19da-401c-bd17-8c3a85d89743	systool-api<b>asd 1.0.0 fe067d53-ad9c-4c4f-b4f6-f5082a0a25f3 API PROXY	This is a sample Petstore server.  You can find\nout more about Swagger at\n[http://swagger.io](http://swagger.io) or on\n[irc.freenode.net, #swagger](http://swagger.io/irc/).\n	fe067d53-ad9c-4c4f-b4f6-f5082a0a25f3	t	ALL_SUB_RESOURCES
16651	5b78a1b0-6def-4ad0-954f-a79d95155252	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.229587	2019-03-07 14:43:03.229587	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiApiCategories	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-updateApiApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16702	55f42d65-31cc-469b-9466-74c9294275c2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.363714	2019-03-07 14:43:03.363714	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateBusinessApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateBusinessApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
96618	b0bd7fe9-c06f-4b6a-815f-f8f3b9983763	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.55503	2019-04-04 19:41:33.55503	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addUserAppMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-addUserAppMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16714	0c21731d-cd37-4454-90b6-aa391e1733b0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.311409	2019-03-07 14:43:04.311409	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectGroup	/openapi/SubjectGroup.yaml-com.verapi.portal.oapi.SubjectGroupApiController-deleteSubjectGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16713	e8f7d550-4503-402b-bd19-5c0f2f9256a1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.258992	2019-03-07 14:43:04.258992	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectApps	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-updateSubjectApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16703	b539aa4d-87cd-4ea8-b63f-5e24b32ec44b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.454684	2019-03-07 14:43:03.454684	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getTagsOfBusinessApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getTagsOfBusinessApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16704	80241ec9-a401-446d-8e23-c4754db83e93	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.560392	2019-03-07 14:43:03.560392	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiApiGroups	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-updateApiApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16705	825f2aa5-e5a4-4304-bafc-ace79b69a778	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.69747	2019-03-07 14:43:03.69747	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiTagByApiAndTag	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getApiApiTagByApiAndTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16706	24d95171-e9a9-4531-8ce8-d9b448408476	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.833137	2019-03-07 14:43:03.833137	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiStates	/openapi/ApiState.yaml-com.verapi.portal.oapi.ApiStateApiController-getApiStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16707	e2568445-c4eb-44f5-a0d3-4e1863acc9f9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.885944	2019-03-07 14:43:03.885944	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContract	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-getContract	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16708	e3fd067d-1ab1-4754-9657-ef75738088c1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.940521	2019-03-07 14:43:03.940521	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getLicensesOfSubject	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-getLicensesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16709	b715bfc6-d952-408e-b46e-777911a087d7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.010601	2019-03-07 14:43:04.010601	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMessageTypes	/openapi/MessageType.yaml-com.verapi.portal.oapi.MessageTypeApiController-getMessageTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16710	0aa8b7ad-1834-41c0-9bb2-c8eb710f1954	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.09268	2019-03-07 14:43:04.09268	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deletePolicyTypes	/openapi/PolicyType.yaml-com.verapi.portal.oapi.PolicyTypeApiController-deletePolicyTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16711	8be4a421-1fad-4a5d-8891-8e12039dab2e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.148833	2019-03-07 14:43:04.148833	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResources	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-deleteResources	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16712	6069eb53-89c6-44ae-be8d-e3aae07b0652	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.2054	2019-03-07 14:43:04.2054	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApps	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-addApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16715	ef8eb43a-18e7-4a1d-a578-3f46363f32e2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.355729	2019-03-07 14:43:04.355729	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectOrganizations	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-deleteSubjectOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16716	9b8c053d-d39f-4fa9-8f81-a744e7cbdf89	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.391331	2019-03-07 14:43:04.391331	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectType	/openapi/SubjectType.yaml-com.verapi.portal.oapi.SubjectTypeApiController-getSubjectType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55551	1ea0b1ab-9f21-405a-9b29-dbfb42f45c2a	2203c91b-9c51-4a42-b1c8-2c93eb5d434e	2019-03-28 18:19:36.753446	2019-03-28 18:22:14.153257	1900-01-01 00:00:00	f	87918192-96a9-4957-801d-9cb817f9b9dd	4a3d51ce-cbd6-405b-bf58-328332efa499	systool LICENSE	API License Description	41f59d68-643c-44ed-871b-5824654313c3	t	ALL_SUB_RESOURCES
91351	5917b6fe-2284-430e-a6f7-ccc0afd9ef30	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 12:52:38.10798	2019-04-04 12:52:38.10798	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	omdb 3.0.0 79e3278c-461b-4aec-bea2-b5b28de8f48f API PROXY	omdb database	79e3278c-461b-4aec-bea2-b5b28de8f48f	t	ALL_SUB_RESOURCES
16553	9bb2c35d-7e48-46c5-8cd3-526a713ecbd8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.444986	2019-03-07 14:43:03.444986	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApisOfSubjectByTag	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getBusinessApisOfSubjectByTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16565	b49e6eb8-6f10-40ea-a494-9ab10971bd9a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.311241	2019-03-07 14:43:04.311241	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectGroups	/openapi/SubjectGroup.yaml-com.verapi.portal.oapi.SubjectGroupApiController-updateSubjectGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16602	14f01846-87d2-42c2-8f7e-4e4f7ae449b7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.356683	2019-03-07 14:43:03.356683	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApisOfSubjectByCategory	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getBusinessApisOfSubjectByCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16614	30c02793-26cb-40af-9175-1ea146ca20de	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.190394	2019-03-07 14:43:04.190394	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectActivations	/openapi/SubjectActivation.yaml-com.verapi.portal.oapi.SubjectActivationApiController-updateSubjectActivations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
97119	e9377cc8-e50a-451d-9039-6faab8ade8d9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.553976	2019-04-04 19:41:33.553976	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteGroupRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-deleteGroupRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16701	ca515d9b-6e4e-4ad8-bbc9-18dd8c223817	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.231711	2019-03-07 14:43:03.231711	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateAccessManagers	/openapi/AccessManager.yaml-com.verapi.portal.oapi.AccessManagerApiController-updateAccessManagers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
143651	997f2089-7d63-4f61-93f3-64e745adbbe5	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-13 20:00:23.116253	2019-04-13 20:00:23.116253	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of Fintech APP APP with Swagger Petstore 2 API CONTRACT	Contract of Fintech APP APP with Swagger Petstore 2 API	db7b3d58-ba87-449b-b27e-b45b7cd42dc9	t	ALL_SUB_RESOURCES
16755	3521514f-d509-4f38-9f55-8116c77de5df	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.751461	2019-03-07 14:43:03.751461	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiCategory	/openapi/ApiCategory.yaml-com.verapi.portal.oapi.ApiCategoryApiController-deleteApiCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
98811	a98a0778-dc52-432a-a0b2-1d03d85a6100	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-06 23:44:50.811435	2019-04-06 23:44:50.811435	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	inviteUser	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-inviteUser	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16051	ea0558eb-6a71-4920-ae62-1bc519de1df6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.20169	2019-03-07 14:43:03.20169	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteAccessManagerType	/openapi/AccessManagerType.yaml-com.verapi.portal.oapi.AccessManagerTypeApiController-deleteAccessManagerType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55602	5f091af1-0320-4886-9b16-035dff19922a	2203c91b-9c51-4a42-b1c8-2c93eb5d434e	2019-03-28 18:24:15.176734	2019-03-28 18:24:15.176734	1900-01-01 00:00:00	f	87918192-96a9-4957-801d-9cb817f9b9dd	505099b4-19da-401c-bd17-8c3a85d89743	systool-api<b>asd 1.0.0 83aec7b3-2a8a-4c53-a86f-93ed55443e4b API PROXY	This is a sample Petstore server.  You can find\nout more about Swagger at\n[http://swagger.io](http://swagger.io) or on\n[irc.freenode.net, #swagger](http://swagger.io/irc/).\n	83aec7b3-2a8a-4c53-a86f-93ed55443e4b	t	ALL_SUB_RESOURCES
16753	7bea3d44-f67d-42c3-905d-291585425af7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.520466	2019-03-07 14:43:03.520466	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getBusinessApi	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getBusinessApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16756	f7446280-c76b-4dd4-ac80-af8360f79c70	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.847775	2019-03-07 14:43:03.847775	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiTag	/openapi/ApiTag.yaml-com.verapi.portal.oapi.ApiTagApiController-updateApiTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16757	352ebf2d-4fe9-4e95-b5f6-6a178066cc3f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.891924	2019-03-07 14:43:03.891924	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteContract	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-deleteContract	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16758	2827e5e5-1b29-4de2-bc0f-4aee1edc3a13	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.938358	2019-03-07 14:43:03.938358	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateLicenses	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-updateLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16759	31fadade-3b32-4875-99b6-1ccc598a6b5b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.018089	2019-03-07 14:43:04.018089	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateOrganization	/openapi/Organization.yaml-com.verapi.portal.oapi.OrganizationApiController-updateOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16760	fabb1707-d0ae-4fc4-9dae-fc329ea9d8b3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.077108	2019-03-07 14:43:04.077108	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updatePolicyType	/openapi/PolicyType.yaml-com.verapi.portal.oapi.PolicyTypeApiController-updatePolicyType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16761	f523c705-d212-4679-bc10-d956222d6b86	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.12677	2019-03-07 14:43:04.12677	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResourceActions	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-deleteResourceActions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16762	5a11ac43-1a0c-447c-8786-231949152813	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.168806	2019-03-07 14:43:04.168806	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResourceTypes	/openapi/ResourceType.yaml-com.verapi.portal.oapi.ResourceTypeApiController-deleteResourceTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16763	d0c0172a-1e8f-4c7f-bfe8-7c343f175520	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.22722	2019-03-07 14:43:04.22722	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApps	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16764	824ec62d-5007-41f7-882d-009d779effb7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.301339	2019-03-07 14:43:04.301339	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectDirectories	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-getSubjectDirectories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16766	a243e016-af28-4783-81dc-90d9f0d99751	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.373709	2019-03-07 14:43:04.373709	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiSubscriptionsOfSubject	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-addApiSubscriptionsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16767	fe169793-d1b8-4319-bb65-2d90939e5bc0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.411719	2019-03-07 14:43:04.411719	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getYamlFileList	/openapi/Util.yaml-com.verapi.portal.oapi.util.UtilApiController-getYamlFileList	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16751	51ef7e43-377b-4c2f-bf86-27e659fb0af8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.234142	2019-03-07 14:43:03.234142	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addAccessManagerTypes	/openapi/AccessManagerType.yaml-com.verapi.portal.oapi.AccessManagerTypeApiController-addAccessManagerTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16752	a27b412d-a303-431d-bb29-e09a112060ad	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.407702	2019-03-07 14:43:03.407702	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApisSharedBySubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApisSharedBySubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
92163	1a71b382-953a-458d-a14b-983787645fb8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 13:37:00.042174	2019-04-04 13:37:00.042174	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getRoles	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getRoles	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16754	5deecbe3-9cec-4b41-b18d-05ba2c74b5f4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.639472	2019-03-07 14:43:03.639472	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiTag	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getApiApiTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55601	30ca9584-7449-42e8-ae0a-8e2a8abc069b	2203c91b-9c51-4a42-b1c8-2c93eb5d434e	2019-03-28 18:23:12.917079	2019-03-28 18:23:12.917079	1900-01-01 00:00:00	f	87918192-96a9-4957-801d-9cb817f9b9dd	505099b4-19da-401c-bd17-8c3a85d89743	systool-api<b>asd 1.0.0 ad292a11-fcb3-4e08-97d0-baf989457831 API PROXY	This is a sample Petstore server.  You can find\nout more about Swagger at\n[http://swagger.io](http://swagger.io) or on\n[irc.freenode.net, #swagger](http://swagger.io/irc/).\n	ad292a11-fcb3-4e08-97d0-baf989457831	t	ALL_SUB_RESOURCES
16765	fc70c228-0383-482d-9b9f-1d643fe6047b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.337073	2019-03-07 14:43:04.337073	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-addSubjectMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16810	cf2a6c55-a6d5-44fa-bce0-d996956d4b9e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.039785	2019-03-07 14:43:04.039785	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updatePolicies	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-updatePolicies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16804	7cfab583-1c73-4670-b2c3-7cabba4f9003	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.578736	2019-03-07 14:43:03.578736	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiGroups	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getApiApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16805	4ea09f81-f44c-4736-81b0-0c262ee8dc69	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.710407	2019-03-07 14:43:03.710407	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiCategory	/openapi/ApiCategory.yaml-com.verapi.portal.oapi.ApiCategoryApiController-getApiCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16806	8790431c-94ed-474c-91d6-5f7636722789	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.816197	2019-03-07 14:43:03.816197	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiLicenses	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-updateApiLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16807	a85badc9-be2e-4d3e-be92-36c1f0d35a4b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.864485	2019-03-07 14:43:03.864485	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiVisibilityType	/openapi/ApiVisibilityType.yaml-com.verapi.portal.oapi.ApiVisibilityTypeApiController-getApiVisibilityType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16811	378e6d2d-5341-4b7e-aa7e-2494b237dc0d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.093783	2019-03-07 14:43:04.093783	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceAccessTokenBySubjectPermission	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-getResourceAccessTokenBySubjectPermission	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16812	9c63f4e7-83cc-414a-b35d-0e68ba04490d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.147088	2019-03-07 14:43:04.147088	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourcesOfResourceReference	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-getResourcesOfResourceReference	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16813	7dfd0c38-f523-4f01-a521-720ef1d6646c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.192147	2019-03-07 14:43:04.192147	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updatePasswordOfSubject	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-updatePasswordOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16814	d5c5a19e-2905-4517-b0ee-898be42d9a36	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.248338	2019-03-07 14:43:04.248338	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addGroups	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-addGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16815	3ded6eb6-94eb-4f1c-8cc5-5a3f4a19fde0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.297693	2019-03-07 14:43:04.297693	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectDirectory	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-updateSubjectDirectory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16816	5c1d6a20-6366-4d54-a644-734826271d7a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.343074	2019-03-07 14:43:04.343074	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectMembership	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-deleteSubjectMembership	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16817	fccd97f7-316a-4a98-aa5f-693a0a410dc3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.385686	2019-03-07 14:43:04.385686	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectPermission	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-getSubjectPermission	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55651	7ed6591d-7afc-4bdf-8d36-406ebf7856ee	2203c91b-9c51-4a42-b1c8-2c93eb5d434e	2019-03-28 18:31:50.210904	2019-03-28 18:31:50.210904	1900-01-01 00:00:00	f	87918192-96a9-4957-801d-9cb817f9b9dd	4a3d51ce-cbd6-405b-bf58-328332efa499	systool licenser LICENSE	API License Description	b6c5a1e4-d631-435f-ab81-dd85729fe96e	t	ALL_SUB_RESOURCES
91814	a1e5043a-0316-4332-96a6-4caa4204e6eb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 13:37:00.051328	2019-04-04 13:37:00.051328	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addRoles	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-addRoles	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16808	29396516-6f2c-4c6f-adc3-9341d54619c2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.916034	2019-03-07 14:43:03.916034	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteContractState	/openapi/ContractState.yaml-com.verapi.portal.oapi.ContractStateApiController-deleteContractState	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
100401	0a36c70d-9297-4ff7-95b6-9a1395f81515	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-08 11:23:39.117678	2019-04-08 11:23:39.117678	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4ddbc735-8905-488a-81a4-f21a45ebc4ef	Policy P6 POLICY	Policy P6 decs	fd5bd5e2-8890-4fbc-aa2c-c329ca500e37	t	ALL_SUB_RESOURCES
16809	cd48a771-b248-427a-b6a4-7cafa6661556	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.997286	2019-03-07 14:43:03.997286	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateMessageTypes	/openapi/MessageType.yaml-com.verapi.portal.oapi.MessageTypeApiController-updateMessageTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16801	2184a85a-7a3f-4ea1-8901-2e464f7c7f47	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.236289	2019-03-07 14:43:03.236289	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getAccessManagers	/openapi/AccessManager.yaml-com.verapi.portal.oapi.AccessManagerApiController-getAccessManagers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16802	e32fde53-101e-48ad-92bc-33a50fac7dd6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.36823	2019-03-07 14:43:03.36823	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateBusinessApis	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateBusinessApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16803	db73872e-9f73-427d-bb67-ba43682fd57b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.476237	2019-03-07 14:43:03.476237	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-addApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55701	93e37267-c5b5-42e3-8ee5-0802c9904f87	2203c91b-9c51-4a42-b1c8-2c93eb5d434e	2019-03-28 18:33:26.516473	2019-03-28 18:33:26.516473	1900-01-01 00:00:00	f	87918192-96a9-4957-801d-9cb817f9b9dd	505099b4-19da-401c-bd17-8c3a85d89743	Bu nebi çim api 1.0.0 82a6b986-5f13-46fa-90fd-4cab18ea77c2 API PROXY	This is a sample Petstore server.  You can find\nout more about Swagger at\n[http://swagger.io](http://swagger.io) or on\n[irc.freenode.net, #swagger](http://swagger.io/irc/).\n	82a6b986-5f13-46fa-90fd-4cab18ea77c2	t	ALL_SUB_RESOURCES
16852	d6c69ac7-ddec-4136-9a09-ffd02279e952	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.379048	2019-03-07 14:43:03.379048	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiProxiesOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApiProxiesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
91865	74d1a5a5-70f9-470c-8008-1b7982b4021b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 13:37:00.052238	2019-04-04 13:37:00.052238	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteRoles	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-deleteRoles	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16859	46ca2d99-06fc-4597-a43e-2f35b18ceb8d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.077512	2019-03-07 14:43:04.077512	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addPolicyTypes	/openapi/PolicyType.yaml-com.verapi.portal.oapi.PolicyTypeApiController-addPolicyTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
100451	cfe73205-a251-4e9c-8f9c-a3a748639408	b5c1a396-7c4f-495f-80b8-8d89650d21f0	2019-04-08 15:15:36.233693	2019-04-08 15:15:36.233693	1900-01-01 00:00:00	f	cfdb7e1c-be98-4196-83f0-c31d4ea2aa30	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.3 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	b13a1c6b-9b06-43ad-86b0-69ac720e20d9	t	ALL_SUB_RESOURCES
16853	6a398a12-c64e-45d4-8c65-e5cbd694cfb4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.488923	2019-03-07 14:43:03.488923	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiProxy	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateApiProxy	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16860	4cc5dbe4-3d1a-4622-97ab-e5d69065c9f9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.137738	2019-03-07 14:43:04.137738	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addResources	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-addResources	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16861	0319cb23-b3b4-4971-a125-ca7e790e115b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.179937	2019-03-07 14:43:04.179937	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectActivation	/openapi/SubjectActivation.yaml-com.verapi.portal.oapi.SubjectActivationApiController-deleteSubjectActivation	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16862	e25c8c9c-f433-4afc-8079-43a6ed7417cf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.245675	2019-03-07 14:43:04.245675	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApps	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-deleteApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16854	332a676c-4b61-497d-a07b-9a5db5fed964	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.630821	2019-03-07 14:43:03.630821	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiGroupsByApiAndGroup	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getApiApiGroupsByApiAndGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16863	0f3a53bd-2b12-4ecd-b53f-a6a1acb64306	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.295856	2019-03-07 14:43:04.295856	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectDirectories	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-addSubjectDirectories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16864	30758317-ea50-4671-a04b-44a0786a168e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.347189	2019-03-07 14:43:04.347189	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectMembership	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getSubjectMembership	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16865	bab0a3ec-b2da-451b-bf03-f1b6f559fdf9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.390674	2019-03-07 14:43:04.390674	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectTypes	/openapi/SubjectType.yaml-com.verapi.portal.oapi.SubjectTypeApiController-getSubjectTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16855	982be913-a060-4433-a395-0cb2984e8dd7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.75969	2019-03-07 14:43:03.75969	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiGroups	/openapi/ApiGroup.yaml-com.verapi.portal.oapi.ApiGroupApiController-addApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16856	783e25cf-6a86-4a09-9994-6d2ed0724c09	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.863928	2019-03-07 14:43:03.863928	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiTag	/openapi/ApiTag.yaml-com.verapi.portal.oapi.ApiTagApiController-deleteApiTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16857	4edc85a2-6fbf-4577-bb5c-25418c3c88e1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.912568	2019-03-07 14:43:03.912568	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteContractStates	/openapi/ContractState.yaml-com.verapi.portal.oapi.ContractStateApiController-deleteContractStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
143759	31f28b7c-3c80-49a8-8e3b-ff0c713aeb56	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-13 23:55:18.101209	2019-04-13 23:55:18.101209	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContractsOfUser	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-getContractsOfUser	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16851	83b17754-36b4-41e4-9a79-9409f99aed77	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.238461	2019-03-07 14:43:03.238461	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteAccessManagers	/openapi/AccessManager.yaml-com.verapi.portal.oapi.AccessManagerApiController-deleteAccessManagers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16858	f19b3cdd-3c2b-4b27-a472-72128d92d104	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.98808	2019-03-07 14:43:03.98808	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMessageType	/openapi/MessageType.yaml-com.verapi.portal.oapi.MessageTypeApiController-getMessageType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16904	7ec562a7-dce4-447e-a4a2-4b6d774db49e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.590691	2019-03-07 14:43:03.590691	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiApiGroups	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-addApiApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16911	61ebb501-6c3a-43fc-9cba-4253477c5444	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.128654	2019-03-07 14:43:04.128654	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addResourceActions	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-addResourceActions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16912	c331a61c-8347-4c1e-87db-e35fd6e2235a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.170819	2019-03-07 14:43:04.170819	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectActivations	/openapi/SubjectActivation.yaml-com.verapi.portal.oapi.SubjectActivationApiController-addSubjectActivations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16913	2eefb696-b267-4dd8-a8cd-ce4f1b89b5e7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.224812	2019-03-07 14:43:04.224812	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addUsers	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-addUsers	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16917	0dbfa7e6-01d7-4f79-82d8-9a6040cab3c1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.395472	2019-03-07 14:43:04.395472	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectTypes	/openapi/SubjectType.yaml-com.verapi.portal.oapi.SubjectTypeApiController-updateSubjectTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16906	2e94ec31-1720-4a1e-9c0a-7175f8223bc6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.805376	2019-03-07 14:43:03.805376	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiLicenses	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-addApiLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16907	0d2dd45f-adba-4359-a920-3f0dabc9f327	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.860831	2019-03-07 14:43:03.860831	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiVisibilityTypes	/openapi/ApiVisibilityType.yaml-com.verapi.portal.oapi.ApiVisibilityTypeApiController-updateApiVisibilityTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
55751	8db6b02b-076a-400c-8a3c-dcaae1acff54	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-03-28 18:39:11.137432	2019-03-29 14:59:58.901741	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	Hayvan Api 3.0.0 API PROXY	This is a sample Petstore server.  You can find1\nout more about Swagger at\n[http://swagger.io](http://swagger.io) or on\n[irc.freenode.net, #swagger](http://swagger.io/irc/).\n	37ba878c-5d04-48e3-9339-bf96764db30c	t	ALL_SUB_RESOURCES
91766	03cd1ae1-47e9-48b4-bb44-70a6c7c7501b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 13:37:00.053264	2019-04-04 13:37:00.053264	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateRoles	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-updateRoles	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
100501	18706ef2-01e6-41a0-8879-4047efff48bc	b5c1a396-7c4f-495f-80b8-8d89650d21f0	2019-04-08 15:15:36.287029	2019-04-08 15:15:36.287029	1900-01-01 00:00:00	f	cfdb7e1c-be98-4196-83f0-c31d4ea2aa30	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.4 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	2cf101c4-0fbe-4bc8-9b90-61f478854eeb	t	ALL_SUB_RESOURCES
16914	cf029ed7-a6fb-4b10-991f-366ae1967c22	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.272895	2019-03-07 14:43:04.272895	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectApp	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-deleteSubjectApp	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16908	78fc1ea7-ad92-4f66-9a51-a128be8ea77f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.91647	2019-03-07 14:43:03.91647	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateContractStates	/openapi/ContractState.yaml-com.verapi.portal.oapi.ContractStateApiController-updateContractStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16909	e6a00ace-9821-4a3a-a815-2bae2c46ea57	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.980538	2019-03-07 14:43:03.980538	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteMessages	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-deleteMessages	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
103102	50ce09c1-8dd9-465a-ae12-7386d07426b2	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-09 12:25:07.955172	2019-04-09 12:25:07.955172	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Swagger Petstore 1.0.0 70df8a32-9cbe-4e29-b4af-f924a2397b8f API PROXY	This is a sample Petstore server.  You can find\nout more about Swagger at\n[http://swagger.io](http://swagger.io) or on\n[irc.freenode.net, #swagger](http://swagger.io/irc/).\n	70df8a32-9cbe-4e29-b4af-f924a2397b8f	t	ALL_SUB_RESOURCES
146956	6338586a-1fad-415b-ad64-5e658f70a257	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-14 00:22:11.081208	2019-04-14 00:22:11.081208	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiLicensesOfUser	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-getApiLicensesOfUser	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16915	2bc178ae-cbf4-4b03-8742-141e63fb9409	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.313563	2019-03-07 14:43:04.313563	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectDirectoryType	/openapi/SubjectDirectoryType.yaml-com.verapi.portal.oapi.SubjectDirectoryTypeApiController-updateSubjectDirectoryType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16916	d1d53d63-1f22-49bf-9e2f-db2204a27edd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.351061	2019-03-07 14:43:04.351061	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectOrganization	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-updateSubjectOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16910	f8aeb543-3a41-4074-9303-6a006df55f10	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.057093	2019-03-07 14:43:04.057093	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updatePoliciesOfSubject	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-updatePoliciesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16901	4fdd84e5-b39e-408a-b250-c8997a6d2cc6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.240606	2019-03-07 14:43:03.240606	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiApiCategories	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-deleteApiApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16902	f214c9ab-7000-4aaf-ad27-93fb25c91fd6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.378622	2019-03-07 14:43:03.378622	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiProxiesOfSubjectByTag	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApiProxiesOfSubjectByTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16903	c3d6274d-4f73-4676-b1f9-37b4e890f592	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.472788	2019-03-07 14:43:03.472788	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiProxies	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-addApiProxies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16955	7c594ba6-54f0-4b19-ae83-f5470ac94e8c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.771303	2019-03-07 14:43:03.771303	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiGroup	/openapi/ApiGroup.yaml-com.verapi.portal.oapi.ApiGroupApiController-deleteApiGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16956	02a9db2d-284f-492e-b279-d59db5b8a9d0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.862312	2019-03-07 14:43:03.862312	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiVisibilityTypes	/openapi/ApiVisibilityType.yaml-com.verapi.portal.oapi.ApiVisibilityTypeApiController-getApiVisibilityTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16957	7c3f7ef3-1184-48f1-b085-55d0903b402e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.913933	2019-03-07 14:43:03.913933	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateContractState	/openapi/ContractState.yaml-com.verapi.portal.oapi.ContractStateApiController-updateContractState	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16958	41a7db5c-3737-4b8b-abed-dfa3a80ffc4c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.970321	2019-03-07 14:43:03.970321	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateMessages	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-updateMessages	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16961	61b651ce-f02e-4091-97a6-544f8d42f00e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.150524	2019-03-07 14:43:04.150524	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addResourceTypes	/openapi/ResourceType.yaml-com.verapi.portal.oapi.ResourceTypeApiController-addResourceTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16962	35fbe9a5-f49e-445d-bf99-437588061374	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.20236	2019-03-07 14:43:04.20236	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getUsersWithGroups	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getUsersWithGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16963	4e105987-13ac-414c-9d4b-8f772fd2b153	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.265038	2019-03-07 14:43:04.265038	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getAppsOfSubject	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-getAppsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16964	cbc39a47-ab1c-412f-bc7c-d16f6a26cf45	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.314925	2019-03-07 14:43:04.314925	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectGroups	/openapi/SubjectGroup.yaml-com.verapi.portal.oapi.SubjectGroupApiController-deleteSubjectGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16965	f2518978-3612-4bde-876c-041f527b7b9a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.354869	2019-03-07 14:43:04.354869	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectOrganizations	/openapi/SubjectOrganization.yaml-com.verapi.portal.oapi.SubjectOrganizationApiController-updateSubjectOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16966	ec6e7e0b-5c29-47c0-a31e-cd0e07d1f60a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.392776	2019-03-07 14:43:04.392776	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectType	/openapi/SubjectType.yaml-com.verapi.portal.oapi.SubjectTypeApiController-updateSubjectType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16959	4b17ed0e-10a0-4bb4-89b6-6fce15d39ea4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.040016	2019-03-07 14:43:04.040016	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deletePolicies	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-deletePolicies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
94420	9fefe2bd-49bd-42ac-bacc-b2c954edd7bc	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-04 17:16:59.825788	2019-04-04 17:16:59.825788	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.3 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	b13a1c6b-9b06-43ad-86b0-69ac720e20d9	t	ALL_SUB_RESOURCES
103301	0fb94546-ad55-4bfb-bcfd-54202f8b4d15	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-09 12:25:11.046506	2019-04-09 12:25:11.046506	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	Swagger Petstore 1.0.0 deb0a4ec-f8b0-42fc-b03e-75b0d3385e58 API PROXY	This is a sample Petstore server.  You can find\nout more about Swagger at\n[http://swagger.io](http://swagger.io) or on\n[irc.freenode.net, #swagger](http://swagger.io/irc/).\n	deb0a4ec-f8b0-42fc-b03e-75b0d3385e58	t	ALL_SUB_RESOURCES
148761	d4d041cd-8d31-4a8c-ab78-6ee204798dc7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-14 00:31:49.544715	2019-04-14 00:31:49.544715	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getLicensesOfApiInUse	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-getLicensesOfApiInUse	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16951	daddb452-6097-41f9-bc87-ddefb07f373e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.215511	2019-03-07 14:43:03.215511	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteAccessManager	/openapi/AccessManager.yaml-com.verapi.portal.oapi.AccessManagerApiController-deleteAccessManager	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16952	393f7d54-8e72-444f-83b5-1d1ea46cd7a8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.428916	2019-03-07 14:43:03.428916	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16953	6628751f-767a-41ee-99dc-a652d25abe9b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.513308	2019-03-07 14:43:03.513308	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApi	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16954	5ed4bfaf-70bc-43fd-838d-7517a902424d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.663713	2019-03-07 14:43:03.663713	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiTags	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getApiApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16960	d74f7ed7-6c60-4b14-b386-73ac953b7830	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.111574	2019-03-07 14:43:04.111574	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResourceAction	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-deleteResourceAction	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17008	0fd5ae17-37e3-493a-af19-e5d8f8b072a2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.933925	2019-03-07 14:43:03.933925	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteLicense	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-deleteLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17014	3fe5e89b-0d1e-40f9-b99b-a3ecc643cb90	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.222639	2019-03-07 14:43:04.222639	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjects	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-addSubjects	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
95319	30c98995-e9f1-4f95-a42f-767a96756ec9	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-04 17:16:59.847683	2019-04-04 17:16:59.847683	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.4 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	2cf101c4-0fbe-4bc8-9b90-61f478854eeb	t	ALL_SUB_RESOURCES
17002	63491cfe-562b-44e2-8dc6-09cd6b08ec0d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.390439	2019-03-07 14:43:03.390439	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteBusinessApi	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteBusinessApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17009	8e1c6bf1-8ac0-4919-a324-e1e8103c41bf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.983175	2019-03-07 14:43:03.983175	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateMessageType	/openapi/MessageType.yaml-com.verapi.portal.oapi.MessageTypeApiController-updateMessageType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17010	d614f22a-9496-46f5-a00d-e90a3496fed6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.033731	2019-03-07 14:43:04.033731	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getPolicy	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-getPolicy	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17011	b9d05409-8fb7-4d27-a8a7-c4ac7ed55bc8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.079004	2019-03-07 14:43:04.079004	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getPolicyType	/openapi/PolicyType.yaml-com.verapi.portal.oapi.PolicyTypeApiController-getPolicyType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17003	7058ab43-8170-43a1-8fcb-d76df748af77	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.483852	2019-03-07 14:43:03.483852	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-getApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17012	0f6f490a-cc5a-4ee5-a9de-1c5cee02bd96	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.12929	2019-03-07 14:43:04.12929	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceActions	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-getResourceActions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17015	bd830ed4-0368-43a5-98de-11c9c93576a5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.284797	2019-03-07 14:43:04.284797	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectApps	/openapi/SubjectApp.yaml-com.verapi.portal.oapi.SubjectAppApiController-addSubjectApps	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17016	2341d653-6451-4f2e-9d07-b3c133507d1e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.32668	2019-03-07 14:43:04.32668	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectGroups	/openapi/SubjectGroup.yaml-com.verapi.portal.oapi.SubjectGroupApiController-getSubjectGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17017	f4e7cfbb-c992-4fb4-b4a1-d9b56cb0a0d1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.37481	2019-03-07 14:43:04.37481	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiSubscriptionsToMyApis	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-getApiSubscriptionsToMyApis	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17018	c98fbadf-b4cf-4fd2-a598-db9369f424de	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.408346	2019-03-07 14:43:04.408346	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectTypes	/openapi/SubjectType.yaml-com.verapi.portal.oapi.SubjectTypeApiController-deleteSubjectTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
56851	7cd1b8f7-e0bb-4ba1-a5f4-2823854120a9	4f5f9d2a-2d85-4f5b-bbb1-253ec051337e	2019-03-29 11:18:16.430372	2019-03-29 11:18:16.430372	1900-01-01 00:00:00	f	f8d811e3-0394-4af3-b30d-e356991069cf	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of secrove APP with '--><Svg/onload=prompt(1)> API CONTRACT	Contract of secrove APP with '--><Svg/onload=prompt(1)> API	a7f7c559-7214-40b1-bd57-9beb61f3e928	t	ALL_SUB_RESOURCES
17004	b8336395-299e-4275-a25b-d82ec4ad7f3d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.567713	2019-03-07 14:43:03.567713	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiApiGroups	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-deleteApiApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17005	147c2064-eb23-4c86-b771-6e6f7d02f374	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.728911	2019-03-07 14:43:03.728911	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiCategories	/openapi/ApiCategory.yaml-com.verapi.portal.oapi.ApiCategoryApiController-updateApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
109565	80df4709-4299-47be-a0e7-5be757ee0e8d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-10 23:53:08.494713	2019-04-10 23:53:08.494713	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addAppsCascaded	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-addAppsCascaded	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
122001	74c03f63-385d-44d1-9acf-2a57021e865d	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-11 15:41:44.567186	2019-04-11 15:41:44.567186	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of Dene8 APP with Halon API API CONTRACT	Contract of Dene8 APP with Halon API API	7ed9c83f-7866-4262-b2ff-91a923541c46	t	ALL_SUB_RESOURCES
17006	4c29a759-1db2-4da2-a373-66c26732fe95	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.82881	2019-03-07 14:43:03.82881	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiStates	/openapi/ApiState.yaml-com.verapi.portal.oapi.ApiStateApiController-addApiStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17013	179ea074-f450-44e7-b028-a6d67124c2ac	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.16899	2019-03-07 14:43:04.16899	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResourceTypes	/openapi/ResourceType.yaml-com.verapi.portal.oapi.ResourceTypeApiController-updateResourceTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17001	dfa18809-7e11-46df-89b4-eef7973a2546	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.24425	2019-03-07 14:43:03.24425	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addApiApiCategories	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-addApiApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
17007	59a85195-4126-4c23-8ae3-6aa61c8b0639	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.881681	2019-03-07 14:43:03.881681	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteContracts	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-deleteContracts	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16104	7172f5ac-9b61-49f3-94d8-fb51c8cd78ea	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.494189	2019-03-07 14:43:03.494189	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiProxy	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteApiProxy	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16105	35c58270-cb24-463b-bade-57a50f331cab	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.614884	2019-03-07 14:43:03.614884	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiGroups	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getApiGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16106	635c503e-da3a-4627-8af4-75b75ae92639	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.719456	2019-03-07 14:43:03.719456	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiCategory	/openapi/ApiCategory.yaml-com.verapi.portal.oapi.ApiCategoryApiController-updateApiCategory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16109	f034835a-2ac3-457e-8fdd-34621b78be27	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.929963	2019-03-07 14:43:03.929963	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getLicense	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-getLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16110	7887184c-8a70-4813-a1d7-52f5077f865a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.982143	2019-03-07 14:43:03.982143	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteMessageType	/openapi/MessageType.yaml-com.verapi.portal.oapi.MessageTypeApiController-deleteMessageType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16111	7f4ed457-37c7-433d-9984-8f5f04da8110	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.04717	2019-03-07 14:43:04.04717	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getPolicies	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-getPolicies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16112	f8ba5a42-a332-4cd4-8163-3a9959b50771	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.106572	2019-03-07 14:43:04.106572	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResourceAccessTokens	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-updateResourceAccessTokens	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16113	2be146f4-658f-4057-845b-9db33be9bbdc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.150954	2019-03-07 14:43:04.150954	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourceTypes	/openapi/ResourceType.yaml-com.verapi.portal.oapi.ResourceTypeApiController-getResourceTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16114	7a99c748-80ed-42cf-a43b-36c6ebff5337	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.19511	2019-03-07 14:43:04.19511	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getUsersUnderDirectory	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getUsersUnderDirectory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16115	ca0d8bb5-50f4-4eb5-9d99-fea187bdfe8e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.250429	2019-03-07 14:43:04.250429	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getGroups	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getGroups	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16116	10a226fc-f66c-4694-b4f9-dad141ef64bc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.295397	2019-03-07 14:43:04.295397	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectDirectories	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-updateSubjectDirectories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16117	4dc84784-7493-4afd-92f1-c07fb8e6ef16	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.332699	2019-03-07 14:43:04.332699	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getSubjectMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16118	b77cb4dc-79ce-4d89-981a-f2951c1891eb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.376127	2019-03-07 14:43:04.376127	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiSubscriptionsOfSubject	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-deleteApiSubscriptionsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
57502	ea172807-ea66-44ad-9d8f-9c6469981b7b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-29 13:23:20.710938	2019-03-29 13:23:20.710938	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiCategoriesByApi	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-getApiCategoriesByApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
95268	d132c296-249c-49c3-be1e-164106b8068d	b5f1e874-4f05-472e-80e2-16a8865a53f3	2019-04-04 17:17:21.19729	2019-04-04 17:17:21.19729	1900-01-01 00:00:00	f	8c0300a4-a5a9-4a12-a258-1274aeca6f1f	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.3 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	b13a1c6b-9b06-43ad-86b0-69ac720e20d9	t	ALL_SUB_RESOURCES
102651	7adcc20a-c3f6-4cde-b806-47ab4fb90db9	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-08 18:22:27.289703	2019-04-08 18:22:27.289703	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	Bank Customer API 1.0.2 API PROXY	Bank Customer API	2f13d8ac-5f92-418e-b1ba-d1746a26b6cc	t	ALL_SUB_RESOURCES
110151	8bd60cfb-1e33-4834-b6e7-9763a04e00cd	dbf8ed8f-e311-4d00-af93-a4560bd7420f	2019-04-11 10:44:58.024663	2019-04-11 10:44:58.024663	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	License N2 LICENSE	API License Description	af31456d-a9ef-4ec5-a3b0-dafa5559ff41	t	ALL_SUB_RESOURCES
16107	1318e4f6-e86e-4ead-83bc-fd60003e0dfe	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.826477	2019-03-07 14:43:03.826477	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiState	/openapi/ApiState.yaml-com.verapi.portal.oapi.ApiStateApiController-deleteApiState	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16102	ec7913ba-2634-40c5-bf53-0eba08ac1f1b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.332446	2019-03-07 14:43:03.332446	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getProxyApiCategoriesOfSubject	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-getProxyApiCategoriesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16103	69a1308e-8f76-4b36-b8e6-905ae6e139c6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.432193	2019-03-07 14:43:03.432193	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteBusinessApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-deleteBusinessApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16108	756e599c-d447-47c6-95c1-e4d534390fe9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.874296	2019-03-07 14:43:03.874296	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	login	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-login	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
123051	a2307dc1-9d69-44f8-b191-e9f4c783bfcc	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-11 17:35:50.946915	2019-04-14 17:38:09.693372	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	Abyss 1.0.0 API PROXY	Abyss platform APIs	8f3418e1-58e9-411f-816f-0d3f526a0dbb	t	ALL_SUB_RESOURCES
16057	b0d4c39c-746e-434a-89b2-45a533f4ff7c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.854313	2019-03-07 14:43:03.854313	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiTags	/openapi/ApiTag.yaml-com.verapi.portal.oapi.ApiTagApiController-updateApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16069	9a22ce1a-4eab-4c95-89b9-8d71a7fdaf41	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.412643	2019-03-07 14:43:04.412643	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	validateOpenAPIv3Spec	/openapi/Util.yaml-com.verapi.portal.oapi.util.UtilApiController-validateOpenAPIv3Spec	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16053	1388bcbb-9262-4f71-8953-e6ac32bce3fe	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.451868	2019-03-07 14:43:03.451868	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addBusinessApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-addBusinessApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16054	b72dddd8-91a3-4d5c-a009-523cf19b742e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.561769	2019-03-07 14:43:03.561769	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiProxies	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateApiProxies	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16058	2879eb4b-3c22-43bc-8e71-0e005ff44108	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.894101	2019-03-07 14:43:03.894101	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getContractsOfLicense	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-getContractsOfLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16059	3b476a86-22fa-4493-ae63-fa4f4348ff36	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.94232	2019-03-07 14:43:03.94232	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteLicensesOfSubject	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-deleteLicensesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16061	90be2edb-9713-4008-b3ca-6b57c597a03a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.037172	2019-03-07 14:43:04.037172	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deletePolicy	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-deletePolicy	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16062	9ba045f5-2149-4127-b9f7-c4ae8acbd28a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.097869	2019-03-07 14:43:04.097869	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteResourceAccessToken	/openapi/ResourceAccessToken.yaml-com.verapi.portal.oapi.ResourceAccessTokenApiController-deleteResourceAccessToken	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16063	a29a02a7-dc50-4232-aa57-0a36c2764509	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.15136	2019-03-07 14:43:04.15136	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResourcesOfResourceType	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-getResourcesOfResourceType	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16055	c50194bb-2438-4c26-b558-8c827f80b162	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.687613	2019-03-07 14:43:03.687613	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiApiTag	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-deleteApiApiTag	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16065	45693a90-0ffb-436a-8760-786f0b3c1d1b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.246341	2019-03-07 14:43:04.246341	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjects	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-deleteSubjects	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16066	d1e74caa-9afc-472e-84c3-ec3448600d98	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.299687	2019-03-07 14:43:04.299687	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectDirectoryTypes	/openapi/SubjectDirectoryType.yaml-com.verapi.portal.oapi.SubjectDirectoryTypeApiController-addSubjectDirectoryTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16067	3adbc8f8-43c6-4ca9-a3f4-b18cf19a7e4b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.336897	2019-03-07 14:43:04.336897	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMembershipsOfSubject	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getMembershipsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16068	d36d5333-b19d-410e-8c89-10712e623c08	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.375025	2019-03-07 14:43:04.375025	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiSubscriptionsOfSubject	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-getApiSubscriptionsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16056	22dd3681-db22-4397-903c-3bc3112befba	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.785589	2019-03-07 14:43:03.785589	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApisOfLicense	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-getApisOfLicense	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
57754	c037ec12-a7fc-44d9-86e4-35d421a513a6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-29 13:23:20.774524	2019-03-29 13:23:20.774524	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiGroupsByApi	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getApiGroupsByApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
95368	de4f6f2c-4fc9-4e73-a972-1a434fc7f4ce	b5f1e874-4f05-472e-80e2-16a8865a53f3	2019-04-04 17:17:21.225884	2019-04-04 17:17:21.225884	1900-01-01 00:00:00	f	8c0300a4-a5a9-4a12-a258-1274aeca6f1f	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.4 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	2cf101c4-0fbe-4bc8-9b90-61f478854eeb	t	ALL_SUB_RESOURCES
16060	74e3f9af-b3e5-49db-8a99-762979941ec3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.988332	2019-03-07 14:43:03.988332	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addMessages	/openapi/Message.yaml-com.verapi.portal.oapi.MessageApiController-addMessages	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16064	d804d583-5e51-4d88-9fb0-49049e84d602	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.190833	2019-03-07 14:43:04.190833	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubject	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
102701	300d743e-6612-4ee7-8993-5e5b5c1c0495	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-08 18:22:32.112713	2019-04-08 18:22:32.112713	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	Open Weather Map 2 2.5 API PROXY	Current weather data for one location\n	f470d3d2-d6c2-4c52-b0bc-d64c3be0e393	t	ALL_SUB_RESOURCES
16052	494e1910-5229-4d83-bae7-6e40abc6395c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.334456	2019-03-07 14:43:03.334456	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiCategories	/openapi/ApiApiCategory.yaml-com.verapi.portal.oapi.ApiApiCategoryApiController-getApiApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16167	7f0dd1bd-2b13-4c53-9b09-bb173385d2e2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.381443	2019-03-07 14:43:04.381443	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectPermissions	/openapi/SubjectPermission.yaml-com.verapi.portal.oapi.SubjectPermissionApiController-getSubjectPermissions	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
57054	5dee91ed-6815-4991-8461-d487788c1778	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-29 13:23:20.775953	2019-03-29 13:23:20.775953	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiApiGroupsOfSubject	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-getApiApiGroupsOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16155	782098d0-eadd-4a8b-9ee9-dd86d8dfb0cb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.640946	2019-03-07 14:43:03.640946	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiApiTags	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-deleteApiApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16156	edaffc53-2c01-4a75-91f6-3de75c2e1499	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.739507	2019-03-07 14:43:03.739507	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiCategories	/openapi/ApiCategory.yaml-com.verapi.portal.oapi.ApiCategoryApiController-deleteApiCategories	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16157	fbfae3bf-93ba-4794-aea9-e8813ad887d4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.809479	2019-03-07 14:43:03.809479	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiLicenses	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-deleteApiLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16161	ff771dbd-405c-4b5f-8325-4a1722b5b076	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.081202	2019-03-07 14:43:04.081202	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updatePolicyTypes	/openapi/PolicyType.yaml-com.verapi.portal.oapi.PolicyTypeApiController-updatePolicyTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16162	19de221a-762c-4727-82d0-b077100e0eb9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.127581	2019-03-07 14:43:04.127581	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateResourceAction	/openapi/ResourceAction.yaml-com.verapi.portal.oapi.ResourceActionApiController-updateResourceAction	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16163	7312c61b-d512-45e8-aa6f-44ffb0c267de	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.187636	2019-03-07 14:43:04.187636	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectActivations	/openapi/SubjectActivation.yaml-com.verapi.portal.oapi.SubjectActivationApiController-deleteSubjectActivations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16164	1653ffce-409f-417f-9ad7-98ba8e9ed9ae	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.246622	2019-03-07 14:43:04.246622	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjects	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-updateSubjects	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16158	d8cb3f1a-f34b-4644-9db4-8b5be7ed573c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.864246	2019-03-07 14:43:03.864246	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteApiVisibilityTypes	/openapi/ApiVisibilityType.yaml-com.verapi.portal.oapi.ApiVisibilityTypeApiController-deleteApiVisibilityTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16159	7ac2d003-57fa-48a7-a13d-83ae9a6c9aec	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.91993	2019-03-07 14:43:03.91993	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addContractStates	/openapi/ContractState.yaml-com.verapi.portal.oapi.ContractStateApiController-addContractStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
95119	54b6c939-5148-41e8-aa12-c90bebbe3450	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 17:59:29.368617	2019-04-04 17:59:29.368617	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.4 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	2cf101c4-0fbe-4bc8-9b90-61f478854eeb	t	ALL_SUB_RESOURCES
102751	afbe6942-2ec4-4abf-a94d-4635c2d10667	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-08 18:22:44.741084	2019-04-08 18:22:44.741084	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	intel CPU 1.0.0 API PROXY		4c2634ef-3d93-44b8-bf8e-b766af0d177a	t	ALL_SUB_RESOURCES
16165	8cd50cc8-c5ac-4f72-97d9-3424f4462c7d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.302599	2019-03-07 14:43:04.302599	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectDirectoryTypes	/openapi/SubjectDirectoryType.yaml-com.verapi.portal.oapi.SubjectDirectoryTypeApiController-deleteSubjectDirectoryTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16166	d8bea5d3-dce9-4dc5-9f03-963b4b07ce87	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.339879	2019-03-07 14:43:04.339879	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateSubjectMembership	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-updateSubjectMembership	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16152	a5f590f4-b426-432a-9943-3b0b133c77bd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.364128	2019-03-07 14:43:03.364128	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateBusinessApi	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateBusinessApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16153	d684a0b8-4a7b-4449-9cfb-0db3e4af4c92	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.450799	2019-03-07 14:43:03.450799	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApisOfSubject	/openapi/Api.yaml-com.verapi.portal.oapi.ApiApiController-updateApisOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16154	33909356-25d3-4bc4-850d-d68892226de1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.57316	2019-03-07 14:43:03.57316	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiApiGroup	/openapi/ApiApiGroup.yaml-com.verapi.portal.oapi.ApiApiGroupApiController-updateApiApiGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16160	b9610754-716f-4451-97aa-ae022302a240	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.038117	2019-03-07 14:43:04.038117	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addOrganizations	/openapi/Organization.yaml-com.verapi.portal.oapi.OrganizationApiController-addOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
56955	f293b2b3-68b8-4b05-a19d-4bdce9d1eefc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-29 13:23:20.793557	2019-03-29 13:23:20.793557	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiTagsByApi	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getApiTagsByApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16207	c4586a51-78e9-410f-b27c-e8ce47daa5ae	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.839475	2019-03-07 14:43:03.839475	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiStates	/openapi/ApiState.yaml-com.verapi.portal.oapi.ApiStateApiController-updateApiStates	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16208	cea94e37-693a-4226-9c99-8c0b457100b6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.88207	2019-03-07 14:43:03.88207	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateContracts	/openapi/Contract.yaml-com.verapi.portal.oapi.ContractApiController-updateContracts	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16209	fee468d9-cdfd-4e0a-aa54-26ff60e53b38	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.940279	2019-03-07 14:43:03.940279	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addLicenses	/openapi/License.yaml-com.verapi.portal.oapi.LicenseApiController-addLicenses	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
95218	29e22c59-4c94-4591-a3dc-d63f8b485ca8	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-04 17:59:29.375523	2019-04-04 17:59:29.375523	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	505099b4-19da-401c-bd17-8c3a85d89743	My Petstore 1.0.3 API PROXY	This is a sample server Petstore server.  You can find out more about Swagger at [http://swagger.io](http://swagger.io) or on [irc.freenode.net, #swagger](http://swagger.io/irc/).  For this sample, you can use the api key `special-key` to test the authorization filters.	b13a1c6b-9b06-43ad-86b0-69ac720e20d9	t	ALL_SUB_RESOURCES
106964	26c5fffb-3b60-46df-aa9e-ae5e46c352f5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-09 22:04:35.676706	2019-04-09 22:04:35.676706	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getAppsOfUser	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getAppsOfUser	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16210	8862e794-dde0-4aef-a9c3-2af82f8fa2fd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.025389	2019-03-07 14:43:04.025389	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getOrganizations	/openapi/Organization.yaml-com.verapi.portal.oapi.OrganizationApiController-getOrganizations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
119251	d192fd8f-d3a8-4325-a4a2-6b7c36c35956	dbf8ed8f-e311-4d00-af93-a4560bd7420f	2019-04-11 14:38:21.696909	2019-04-11 14:38:21.696909	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	Silver Plus License LICENSE	Silver Plus License desc	f829d9c3-7b90-4a2f-a44a-cecf70e6655e	t	ALL_SUB_RESOURCES
133669	c9999028-ff03-4d3c-af7b-3b1a5f84b426	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-12 12:01:52.202154	2019-04-12 12:01:52.202154	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	convertSwaggerToOpenAPIv3Spec	/openapi/Util.yaml-com.verapi.portal.oapi.util.UtilApiController-convertSwaggerToOpenAPIv3Spec	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16211	6bc03965-8fa0-4f9c-96c9-679471b65661	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.076402	2019-03-07 14:43:04.076402	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deletePoliciesOfSubject	/openapi/Policy.yaml-com.verapi.portal.oapi.PolicyApiController-deletePoliciesOfSubject	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16205	2b9af69f-61dc-4c4d-91ba-fb0eeeeb6855	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.642094	2019-03-07 14:43:03.642094	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiTags	/openapi/ApiApiTag.yaml-com.verapi.portal.oapi.ApiApiTagApiController-getApiTags	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16206	1d56d1b2-86cd-4639-bca1-1063725a2393	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:03.762731	2019-03-07 14:43:03.762731	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateApiGroup	/openapi/ApiGroup.yaml-com.verapi.portal.oapi.ApiGroupApiController-updateApiGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16212	d3a1de0a-164a-4e1b-968b-f8814f8d28b8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.134837	2019-03-07 14:43:04.134837	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getResources	/openapi/Resource.yaml-com.verapi.portal.oapi.ResourceApiController-getResources	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16213	26b9db13-c611-4dbc-8bad-258da91d2f63	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.176297	2019-03-07 14:43:04.176297	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjectActivations	/openapi/SubjectActivation.yaml-com.verapi.portal.oapi.SubjectActivationApiController-getSubjectActivations	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16214	1055a195-eff6-4848-b821-85aaeae4de61	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.230268	2019-03-07 14:43:04.230268	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getSubjects	/openapi/Subject.yaml-com.verapi.portal.oapi.SubjectApiController-getSubjects	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16215	e96f9d9d-f3fa-4192-b209-f8a016703b41	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.296586	2019-03-07 14:43:04.296586	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectDirectory	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-deleteSubjectDirectory	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16216	6d1da046-a867-4408-bbd5-db12b1431f87	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.342386	2019-03-07 14:43:04.342386	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	deleteSubjectMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-deleteSubjectMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
16217	e37044d9-701e-4b5a-bae0-66a793a086b6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-07 14:43:04.391558	2019-03-07 14:43:04.391558	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addSubjectTypes	/openapi/SubjectType.yaml-com.verapi.portal.oapi.SubjectTypeApiController-addSubjectTypes	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
23051	fa97d843-f9f3-457e-b70c-1aa8579dc721	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-03-08 19:35:58.51463	2019-03-08 19:35:58.51463	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4ddbc735-8905-488a-81a4-f21a45ebc4ef	Ihsan P POLICY		c986ab2b-cbf5-4255-9e32-adefe95be581	t	ALL_SUB_RESOURCES
57657	6b7388bf-3403-40a4-ae3d-7f2e89ca5d4a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-29 13:23:20.819833	2019-03-29 13:23:20.819833	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getApiLicensesOfApi	/openapi/ApiLicense.yaml-com.verapi.portal.oapi.ApiLicenseApiController-getApiLicensesOfApi	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
96465	65d490f0-4de3-4a56-836e-aebc9d1abf97	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.520682	2019-04-04 19:41:33.520682	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateUserAppMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-updateUserAppMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
102851	53fd6e3a-fda7-4df4-b683-c9363b95cdaa	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-08 18:23:57.03317	2019-04-08 18:23:57.03317	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of Identity APP APP with Bank Customer API API CONTRACT	Contract of Identity APP APP with Bank Customer API API	ae4f5257-41c8-4088-aab9-9eeea27d358c	t	ALL_SUB_RESOURCES
102852	129ea6e1-6d59-4492-a3c6-59dabfa71860	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-08 18:24:01.197098	2019-04-08 18:24:01.197098	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of Şenol APP APP with Bank Customer API API CONTRACT	Contract of Şenol APP APP with Bank Customer API API	debe296c-6fcd-440e-9648-57eaafb564bb	t	ALL_SUB_RESOURCES
108451	6ab283fb-7265-4fda-9fef-a75cfc16c441	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-10 10:47:12.470871	2019-04-10 10:47:12.470871	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4ddbc735-8905-488a-81a4-f21a45ebc4ef	Ihsan Policy NP2 POLICY	Ihsan Policy NP2 desc	108497e9-72e9-40a4-ab06-8f3792e099b2	t	ALL_SUB_RESOURCES
135201	c821466b-a037-4875-bee3-5633be1ef68f	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-12 14:29:13.632606	2019-04-12 14:29:13.632606	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	License N2 LICENSE	API License Description	af31456d-a9ef-4ec5-a3b0-dafa5559ff41	t	ALL_SUB_RESOURCES
63014	8a8b2b9f-2d84-4375-8de5-55fd58abd374	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 00:24:07.573632	2019-04-03 00:24:07.573632	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	startSubjectDirectorySync	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-startSubjectDirectorySync	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
96866	81f446ae-1a75-4502-9753-6ccdbdc5ba03	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.521897	2019-04-04 19:41:33.521897	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getUserRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getUserRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
135251	aff215e1-1b81-45d0-a60f-c55a65eea384	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-04-12 14:29:13.642414	2019-04-12 14:29:13.642414	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	Silver Plus License LICENSE	Silver Plus License desc	f829d9c3-7b90-4a2f-a44a-cecf70e6655e	t	ALL_SUB_RESOURCES
23101	82ec9590-d9e3-43bc-8c12-03e05c7edba7	e1105933-b965-44a8-992b-5d853a61e154	2019-03-18 11:06:31.510872	2019-03-18 11:06:31.510872	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	4ddbc735-8905-488a-81a4-f21a45ebc4ef	Faiks Policy P1 POLICY	Faiks Policy P1	aed0cf17-76af-4f21-b42b-b1000b31831a	t	ALL_SUB_RESOURCES
63165	5868526a-2bbb-4933-baa6-e1e016d0dc7e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 00:24:07.574819	2019-04-03 00:24:07.574819	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	finishSubjectDirectorySync	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-finishSubjectDirectorySync	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
97268	b92857fe-7a43-494a-b211-0524101749dd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.52855	2019-04-04 19:41:33.52855	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getUserGroupMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getUserGroupMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
23151	32152725-93d5-45d6-8ddd-58c90619467b	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-03-18 11:24:28.743646	2019-03-18 11:24:28.743646	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	4a3d51ce-cbd6-405b-bf58-328332efa499	Faiks License L1 LICENSE	Faiks License L1 Decs	7203d196-b54d-42fe-90b9-8e095039ce60	t	ALL_SUB_RESOURCES
62914	b242dfa9-1ac2-4a80-a4b5-d2e5c53fb87b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 00:24:07.576221	2019-04-03 00:24:07.576221	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	failSubjectDirectorySync	/openapi/SubjectDirectory.yaml-com.verapi.portal.oapi.SubjectDirectoryApiController-failSubjectDirectorySync	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
97218	1ee27776-9dcc-45b0-9ced-7f41ed46fe14	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.529474	2019-04-04 19:41:33.529474	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addUserGroupMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-addUserGroupMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
23201	a1ea3931-7007-41c4-876a-a4307dab2b2c	d7c26fce-35a6-4b68-8da3-7209aaa75ff3	2019-03-20 09:24:19.406344	2019-03-20 09:24:19.406344	1900-01-01 00:00:00	f	9adac0e8-5f5b-4612-97dc-5bb6ab9de4ce	4a3d51ce-cbd6-405b-bf58-328332efa499	License L6 LICENSE	License L6 decs	e351a5f5-9d18-4617-bb54-17ebe92c1e49	t	ALL_SUB_RESOURCES
66657	54ae91b1-a5d7-4644-ba26-2c1f70c56f84	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 15:51:22.536388	2019-04-03 15:51:22.536388	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	setCurrentOrganization	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-setCurrentOrganization	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
96716	0a96bfc3-0c67-4671-ab42-384eb10768c9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.530419	2019-04-04 19:41:33.530419	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	addGroupRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-addGroupRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
139401	cf5f123c-35b1-4a99-ac27-b0c8fb358a94	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-12 15:10:02.318107	2019-04-12 15:10:02.318107	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of Pet Lover APP APP with Halon API API CONTRACT	Contract of Pet Lover APP APP with Halon API API	7d84cd5d-2ad0-4e81-b744-45f5704c2bdc	t	ALL_SUB_RESOURCES
158421	27c0d641-47e0-4ff1-8607-b994d1bf5ad2	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-15 09:13:33.751824	2019-04-15 09:13:33.751824	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	IFS CASCADED APP	IFS C	483ad37b-d7ca-4912-adaa-ea360bcc01f1	t	ALL_SUB_RESOURCES
24207	9ae765e4-aab0-4c9f-86d1-cfeaedd0e634	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 13:43:48.415833	2019-03-27 13:43:48.415833	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	resetPassword	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-resetPassword	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
24214	f443c764-37d8-4dae-93eb-7190a284c8a2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 13:43:48.75426	2019-03-27 13:43:48.75426	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	getMembershipsOfGroup	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-getMembershipsOfGroup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
73068	8736774c-1e81-4ef8-a895-d88e8c14791c	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-03 17:15:26.119491	2019-04-03 17:15:26.119491	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	505099b4-19da-401c-bd17-8c3a85d89743	Open Weather Map 2.5 API PROXY	Current weather data for one location\n	212180df-f07e-4dbe-bc0a-273515373307	t	ALL_SUB_RESOURCES
96416	900678de-7571-430d-a917-99b49caf4c7e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.531419	2019-04-04 19:41:33.531419	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateGroupRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-updateGroupRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
103101	2f849195-20b9-4b9b-999b-703186d5cc80	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-09 11:51:32.247896	2019-04-09 11:51:32.247896	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	0e600a0a-8edc-41f2-8749-2560278d33f1	Contract of BenimAPP APP with Bank Customer API API CONTRACT	Contract of BenimAPP APP with Bank Customer API API	9237f5fa-6122-4c7f-a3d2-42b8aa18e76e	t	ALL_SUB_RESOURCES
161819	e56b17c7-ac98-499c-8afa-fc5aa53f5aa3	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-15 12:02:21.555867	2019-04-15 12:02:21.555867	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	IFS CASCADED 1 APP	IFS C1	0a03b810-b41b-48f7-98cc-5b613379c13e	t	ALL_SUB_RESOURCES
24158	64afc6e5-7d3d-4d69-bbbd-30da09b5c4ee	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 13:43:48.419683	2019-03-27 13:43:48.419683	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	signup	/openapi/Authentication.yaml-com.verapi.portal.oapi.AuthenticationApiController-signup	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
75219	ea97ef45-062a-4fef-b806-39d8185f674b	d7ad9209-6d36-4f6c-91ed-e9fa60dc6758	2019-04-03 19:36:57.103328	2019-04-03 19:36:57.103328	1900-01-01 00:00:00	f	e4baecf4-70e6-4c8b-8cf9-1de8b7f68f88	4ddbc735-8905-488a-81a4-f21a45ebc4ef	Hakans Policy POLICY	Such a nice policy	f9ed7eec-4650-44d3-86a9-e1516bfc6e90	t	ALL_SUB_RESOURCES
96665	210343bf-cf1b-4771-92df-e525903cbde8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:41:33.537604	2019-04-04 19:41:33.537604	1900-01-01 00:00:00	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	updateUserRoleMemberships	/openapi/SubjectMembership.yaml-com.verapi.portal.oapi.SubjectMembershipApiController-updateUserRoleMemberships	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t	ALL_SUB_RESOURCES
162171	33f9cecd-94a1-480a-8270-43e365e101a4	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-04-15 13:39:01.123554	2019-04-15 13:39:01.123554	1900-01-01 00:00:00	f	32c9c734-11cb-44c9-b06f-0b52e076672d	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	IFS CASCADED 2 APP	IFS C2	4e6a83c3-c5fa-4102-9224-d9149a48ebad	t	ALL_SUB_RESOURCES
\.
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
20	cf52d8fc-591f-42dc-be1b-13983086f64d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-01 16:45:56.618026	2019-03-01 16:45:56.618026	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	INVOKE OPERATION	Open Api Operation Invoke	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	t
\.


--
-- Data for Name: resource_type; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.resource_type (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, type, isactive) FROM stdin;
7	35a77205-18d3-4f5c-bbfc-917a794ea5c8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-01 11:56:05.755916	2018-06-01 11:56:05.755916	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PATH	f
6	a4cb8765-7b70-4fff-8427-7f6c97542d29	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-06-01 11:56:05.755916	2018-06-01 11:56:05.755916	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	API PRODUCT	f
5	8ef4c919-6a11-4c9a-9042-842c6073b995	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.486379	2018-05-18 15:29:35.486379	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PORTAL FUNCTIONS	f
8	9f4be4c4-fbbe-4f13-a5e1-5b8f3d8e30ec	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-10 22:34:09.562204	2018-07-10 22:34:09.562204	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	APP	t
2	4ddbc735-8905-488a-81a4-f21a45ebc4ef	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.42376	2018-05-18 15:29:35.42376	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	POLICY	t
3	0e600a0a-8edc-41f2-8749-2560278d33f1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.443148	2018-05-18 15:29:35.443148	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	CONTRACT	t
4	4a3d51ce-cbd6-405b-bf58-328332efa499	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.462033	2018-05-18 15:29:35.462033	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	LICENSE	t
9	12947d53-022a-4dcf-bb06-ffa81dab4c16	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-20 23:02:22.847	2018-07-20 23:02:25.284	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	PLATFORM	t
10	41bfd648-308e-401f-a1ce-9dbbf4e56eb6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-01 16:04:37.832834	2019-03-01 16:04:37.832834	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	OPENAPI OPERATION	t
1	505099b4-19da-401c-bd17-8c3a85d89743	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:29:35.403573	2018-05-18 15:29:35.403573	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	API PROXY	t
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, isactivated, subjecttypeid, subjectname, firstname, lastname, displayname, email, secondaryemail, effectivestartdate, effectiveenddate, password, passwordsalt, picture, totallogincount, failedlogincount, invalidpasswordattemptcount, ispasswordchangerequired, passwordexpiresat, lastloginat, lastpasswordchangeat, lastauthenticatedat, lastfailedloginat, subjectdirectoryid, islocked, issandbox, url, isrestrictedtoprocessing, description, distinguishedname, uniqueid, phonebusiness, phonehome, phonemobile, phoneextension, jobtitle, department, company) FROM stdin;
501	32c9c734-11cb-44c9-b06f-0b52e076672d	9287b7dc-058d-4399-aad0-6fa704decb6b	2018-04-10 13:52:37.949772	2019-04-04 19:35:42.286968	2018-07-26 12:41:02.021301	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	21371a15-04f8-445e-a899-006ee11c0e09	faik	FAIK	SAGLAR	FAIK SAGLAR	faik.saglar@verapi.com	faik.saglar@verapi.com	2018-04-10 13:52:37.949	2018-12-27 01:00:43	402089DB7AF5CB4266DDAFB6A67A2C3597065E0614019ED3A6DBFC7C953A82B705C665E4ABA29075766F2BBC969CEE36AF4B7B4CC0697B9DB1CE8A03EED38890	35435E302011D1BC5E45D628FFCCDDA463F0018BB9017F7CAA724D72B51C6AB0		7	5	2	f	2019-07-03 14:11:03.865078	\N	2019-04-01 17:32:57.496209	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f	faik.com	f										
35800	79bbd44a-b89d-4f4d-ac97-6b42b6f92fb7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 12:45:08.803122	2019-03-27 12:45:08.803122	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	api.owner	Api	Owner	Api Owner Role	api.owner@verapi.com	info@verapi.com	2019-03-27 12:45:08.803122	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	Api Owner of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
1	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-05-18 15:24:32.756208	2018-06-07 02:52:05.110817	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	f	80fc37d5-0594-456c-851b-a7e68fe55e9e	administrator	System	Admin	Abyss System Admin	admin@verapi.com	a@b	2018-05-18 15:24:32.756208	2018-07-29 15:24:32.756208	1234	abcd		0	0	0	t	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
35900	bbbd8a53-2291-49e3-8192-35bb7f30fcce	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 23:46:58.914588	2019-03-27 23:46:58.914588	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	21371a15-04f8-445e-a899-006ee11c0e09	platform.guest	platform	guest	Platform Guest	guest@verapi.com	\N	2019-03-27 23:46:58.914588	\N	ABC	DEF		7	5	2	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f										
35801	7d0b3bcb-5cbd-407d-9e8b-dcc2a1c6a72b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 12:49:31.269276	2019-03-27 12:49:31.269276	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	api.developer	Api	Developer	Api Developer Role	api.developer@verapi.com	info@verapi.com	2019-03-27 12:45:08.803122	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	Api Developer of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
35802	e99eeb19-9df8-4c0d-929b-9e140dd7e7d0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 12:49:31.274447	2019-03-27 12:49:31.274447	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	app.owner	App	Owner	App Owner Role	app.owner@verapi.com	info@verapi.com	2019-03-27 12:45:08.803122	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	App Owner of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
35803	357addea-b43f-45b3-bfdd-86cf3bfd8520	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 12:49:31.278546	2019-03-27 12:49:31.278546	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	app.developer	App	Developer	App Developer Role	app.developer@verapi.com	info@verapi.com	2019-03-27 12:45:08.803122	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	App Developer of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
35804	5cd2bf16-1204-4050-b447-284b6d666f7b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 12:49:31.286704	2019-03-27 12:49:31.286704	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	api.tester	Api	Tester	Api Tester Role	api.tester@verapi.com	info@verapi.com	2019-03-27 12:45:08.803122	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	Api Tester of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
26401	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-10-29 18:39:37.393764	2018-10-29 18:39:37.393764	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	sys.admin	System	Admin	System Admin	system.admin@verapi.com	info@verapi.com	2018-10-29 18:39:37.393764	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	System Admin of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
26402	96243892-c6c4-4d1b-9a05-9a6c0e456438	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-10-29 18:43:29.850524	2018-10-29 18:43:29.850524	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	tenant.admin	Tenant	Admin	Tenant Admin	tenant.admin@verapi.com	info@verapi.com	2018-10-29 18:43:29.850524	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	Tenant Admin of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
26403	33336649-65b7-4003-97ed-0bb5c2d8e7ea	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-10-29 18:45:57.689759	2018-10-29 18:45:57.689759	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	organization.admin	Organization	Admin	Organization Admin	organization.admin@verapi.com	info@verapi.com	2018-10-29 18:45:57.689759	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	Organization Admin of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
26404	cd97c753-2cf1-446e-a5c9-ba7330d27e1d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-10-29 18:47:30.249662	2018-10-29 18:47:30.249662	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	api.admin	Api	Admin	Api Admin	api.admin@verapi.com	info@verapi.com	2018-10-29 18:47:30.249662	\N	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f		f	Api Admin of Platform	\N	\N	\N	\N	\N	\N	\N	\N	\N
35805	309d18da-918c-4753-9c87-03fd85adfc04	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 12:49:31.286704	2019-04-15 20:18:23.951682	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	t	bb76f638-632d-41f8-9511-9865091701f9	guest	Abyss Guest Role	Abyss Guest Role	Abyss Guest Role	guest@verapi.com	guest@verapi.com	2019-03-27 12:45:08.803122	2019-07-03 15:25:08.984	ABC	DEF		0	0	0	f	\N	\N	\N	\N	\N	ac504ae6-2bc9-40fa-8dfb-0ce501089573	f	f	role.guest.verapi.com	f	Guest of Platform									
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
-- Data for Name: subject_membership; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject_membership (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, subjectid, subjectgroupid, subjectdirectoryid, subjecttypeid, subjectgrouptypeid, isactive, effectivestartdate, effectiveenddate) FROM stdin;
4000	bf89eb8e-79c9-4de0-83a0-7b203c70f87b	9287b7dc-058d-4399-aad0-6fa704decb6b	2019-03-27 18:10:28.848651	2019-03-27 18:10:28.848651	\N	f	32c9c734-11cb-44c9-b06f-0b52e076672d	32c9c734-11cb-44c9-b06f-0b52e076672d	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	\N	21371a15-04f8-445e-a899-006ee11c0e09	bb76f638-632d-41f8-9511-9865091701f9	t	2019-04-18 14:51:36.035252	\N
-- Data for Name: subject_organization; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subject_organization (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, subjectid, organizationrefid, isowner, isactive) FROM stdin;
1	c30878c1-d351-48e9-bb13-25a73aec49ae	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2018-07-06 20:50:46.786	2018-07-06 20:50:42.637	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	32c9c734-11cb-44c9-b06f-0b52e076672d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	f	f
\.

COPY abyss.subject_permission (id, uuid, organizationid, created, updated, deleted, isdeleted, crudsubjectid, permission, description, effectivestartdate, effectiveenddate, subjectid, resourceid, resourceactionid, accessmanagerid, isactive) FROM stdin;
20801	83957126-6ee1-4b0c-bc37-9feb5f41f51d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cba62264-cd97-425d-9d03-a996103d5806	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20802	e4d5dda3-b24f-4fe8-abd9-01bb3fe4f0b9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	51ef7e43-377b-4c2f-bf86-27e659fb0af8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20803	371f0103-ebf5-4e39-96a9-64a822229460	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	dfa18809-7e11-46df-89b4-eef7973a2546	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20804	26631de5-ca76-4c67-b8f5-882c8def9b70	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7ec562a7-dce4-447e-a4a2-4b6d774db49e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20805	cb00e035-4682-4f6d-8ebd-f2a063ecc459	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a5dd8ca0-cf29-4aa3-8e01-f97d7e0c80d8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20806	8f9991d1-d7ad-4e05-9401-581dfe27446f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5ef603dd-0dab-484b-a824-d3883722fce3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20807	439ded3c-520d-4021-b3fb-4221c0d33a2a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	982be913-a060-4433-a395-0cb2984e8dd7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20808	28b23b39-c3f6-4d33-9d42-a0fecfe2d742	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2e94ec31-1720-4a1e-9c0a-7175f8223bc6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20809	781083cd-0edc-4422-a48b-b286b973a4cf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c3d6274d-4f73-4676-b1f9-37b4e890f592	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20810	e7769647-bb75-4972-8c4a-212a47971c96	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	dea05589-0d30-4e40-ba58-8368620526ab	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20811	e783f59f-2ab6-4a96-8569-fc20b91caa53	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d4a5e602-3a71-4e19-83c4-3c317f223ee2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20812	2b8f0389-be56-45c2-9935-eaf17cc5c439	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	db73872e-9f73-427d-bb67-ba43682fd57b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20813	09300212-3440-426f-9661-28bbab7fc927	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4c29a759-1db2-4da2-a373-66c26732fe95	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20814	7e5be0e6-f941-43c2-8099-deb9c915494f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a243e016-af28-4783-81dc-90d9f0d99751	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20815	39d4a221-e9bb-4142-9e97-f769225f102b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d454693f-a769-4112-9ea9-cdac4ea5f16e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20816	cb52f6bc-2ee9-4b70-81cf-d441f090ceb4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c15378a2-a9bf-4de5-ba5d-4b3cfa8ddc85	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20817	1bfa9612-9ca9-4210-834d-48ac8a93ac5f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6069eb53-89c6-44ae-be8d-e3aae07b0652	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20818	2a0e12ad-d891-4215-8cd2-762bad139336	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	db2a2ed0-6c6d-4f1e-bcde-67c4c7d52ce9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20819	83b84599-242b-47cd-bad1-924bd3cd6599	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1388bcbb-9262-4f71-8953-e6ac32bce3fe	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20820	b9c0cb63-b6c1-4c1e-aa93-1683ce842907	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a8ed69c8-ab0e-40fb-b572-0e2f2bcb9447	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20821	7833b354-eb57-41c4-9498-a33c2c9a4976	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7ac2d003-57fa-48a7-a13d-83ae9a6c9aec	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20822	2e80a9d4-9b00-45fd-ab9e-f53b9aa78392	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d5c5a19e-2905-4517-b0ee-898be42d9a36	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20823	063142c4-07ee-42cf-8659-f56771c4b238	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fee468d9-cdfd-4e0a-aa54-26ff60e53b38	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20824	14638496-a216-47cd-bd89-b568a27a3374	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cf85f997-0898-423c-a771-a616a0721e0d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20825	c6aace56-8c0c-49f0-8c95-ce8913fba00a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	74e3f9af-b3e5-49db-8a99-762979941ec3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20826	35f7dc9c-a039-46da-8178-d7ea9b03ccbc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9f905a17-492b-4b72-970b-3e9473fc015d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20827	9f80d2fa-3ab5-49ee-a0d7-1682832085e0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b9610754-716f-4451-97aa-ae022302a240	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20828	d0c6b450-b088-477e-85bb-87491164d695	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fb5ec855-968c-405e-9492-dbdd0e1ed52c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20829	75bed9c8-6ff4-432f-80f6-8714c3d793c4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5b7ebeac-b105-41bb-a8d8-eb5cf81b0c14	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20830	7171fee3-cb9e-45d3-8c66-3a9f2a11f06d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	46ca2d99-06fc-4597-a43e-2f35b18ceb8d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20831	26776197-6da3-4999-9ec1-71ff97d00508	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	50bd000c-fb7d-4757-9436-0a9c9401c314	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20832	83424506-6231-4a07-839a-11b9d2568a37	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	61ebb501-6c3a-43fc-9cba-4253477c5444	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20833	8297d6c0-570f-451a-9222-f4f1eaa0af2a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4cc5dbe4-3d1a-4622-97ab-e5d69065c9f9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20834	4b31b5bf-464c-4efc-aadf-3a6ad1416d3a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	61b651ce-f02e-4091-97a6-544f8d42f00e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20835	2ab8fd6f-c504-4cda-8896-b80df1724581	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c331a61c-8347-4c1e-87db-e35fd6e2235a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20836	3c062156-de1d-4e0a-aad0-3072323a451b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	bd830ed4-0368-43a5-98de-11c9c93576a5	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20837	a02a7490-d420-44b1-97b2-ad5b9672714d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0f3a53bd-2b12-4ecd-b53f-a6a1acb64306	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20838	58087ca4-bf97-42db-bab8-fca3bb859525	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d1e74caa-9afc-472e-84c3-ec3448600d98	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20839	ae0d0259-1972-4da7-a36e-11bc0b4eaec0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7a0992f5-d050-48b1-bf07-4baccb4c0262	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20840	aa5fced6-fff3-43ea-a8a8-6ddb871a6587	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fc70c228-0383-482d-9b9f-1d643fe6047b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20841	a882e088-9403-4ed1-bd8d-d62fcb48c636	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e2103c8c-829b-455b-a144-ef6d748acdea	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20842	549f210b-202e-4237-a2cf-84984b380b29	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e68c2a07-83eb-473e-8678-22ef47c8ec89	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20843	c5e798f4-49fd-4b9f-9ebe-7594239828ac	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3fe5e89b-0d1e-40f9-b99b-a3ecc643cb90	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20844	68d066fe-2f65-4231-b139-3499dfb17686	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e37044d9-701e-4b5a-bae0-66a793a086b6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20845	3bcf67cb-42e3-4c2e-9681-ed7339c4becd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2eefb696-b267-4dd8-a8cd-ce4f1b89b5e7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20846	39971ed2-10b5-489b-aafa-46e6ec637d49	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4612e10b-fe59-4bd6-a2ea-7f5ab6c8aa48	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20847	5bba8031-3e29-4a61-8ac7-7683ee1fb0dd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	daddb452-6097-41f9-bc87-ddefb07f373e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20848	77c38ac0-1a67-4452-9a13-74d6242d470f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	83b17754-36b4-41e4-9a79-9409f99aed77	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20849	9c394fc9-cda4-4057-ba54-800ba899d239	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ea0558eb-6a71-4920-ae62-1bc519de1df6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20850	bd7196c8-e1c9-4f61-94a4-3407d33203be	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f5661804-032c-4caf-b330-1c92b81d18f3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20851	3dc63a0d-0fe2-40c5-931e-dfc4a948a02c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6628751f-767a-41ee-99dc-a652d25abe9b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20852	6a8d9539-616b-4927-9bf5-203669773ee1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4fdd84e5-b39e-408a-b250-c8997a6d2cc6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20853	da210fd8-706e-494c-bbf6-62a9d8075bee	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d17eb482-1509-4a8b-befd-4fcf3537b157	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20854	04c6c384-e27f-4569-99e0-f4068e8ad9d0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	af0e020d-5621-4a5b-bfbc-6ffaba389ff7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20855	eddc8397-2ee8-48f8-9b55-682d47ef348c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b8336395-299e-4275-a25b-d82ec4ad7f3d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20856	f19fda14-1a78-4a49-be84-4823b66fb7eb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c50194bb-2438-4c26-b558-8c827f80b162	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20857	8cb52b83-cd3f-49ee-93ba-aae8c9680d27	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	782098d0-eadd-4a8b-9ee9-dd86d8dfb0cb	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20858	bbfd08fe-1adb-4f12-bd96-d2abd8015c11	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	edaffc53-2c01-4a75-91f6-3de75c2e1499	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20859	c5aa5ad8-fac6-4d95-ba1e-e71da148c121	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3521514f-d509-4f38-9f55-8116c77de5df	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20860	5cc2b83b-1a46-4e25-a4c5-0427d131a37b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7c594ba6-54f0-4b19-ae83-f5470ac94e8c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20861	3ba9d562-0a1d-45d9-bca4-f33f2956cda8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7ea67f33-82e5-4a95-bdc6-a2bbe3f116d0	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20862	2f144ed4-1044-455f-b5ef-e1e25caf7f22	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	05075581-e592-4f51-860f-7cd4193c1b8d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20863	c74d30e7-411a-4c2b-a7e6-79440287bedb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fbfae3bf-93ba-4794-aea9-e8813ad887d4	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20864	6e580b6b-da73-4ece-bd23-30f4ffab7eb2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	778d12d6-4b6f-4a35-b6f4-9a05b9e1bb07	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20865	9832ac6e-a4a5-4d48-9d62-d7292af7c768	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d789428b-63f7-4c6b-a98c-fd15b058cbf6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20866	8ce71820-424f-4b77-95cd-3bfdc156e906	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7172f5ac-9b61-49f3-94d8-fb51c8cd78ea	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20867	ffc05dd0-1ef2-4b63-b239-cbc9bc640954	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6fa10d3f-e574-4a5a-bb23-adb293417dc8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20868	78800271-2e26-4b60-afff-ead1e5a688d7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	393f7d54-8e72-444f-83b5-1d1ea46cd7a8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20869	5f9ca907-c2e5-4bc8-a44e-85888e902890	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1318e4f6-e86e-4ead-83bc-fd60003e0dfe	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20870	343c225d-971f-4612-9f53-e9ca1bc1264a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	aeac9032-963a-4461-a9c6-0a8641c1cea2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20871	ecc56bfa-236b-4444-bd42-ba6dd5fab08e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b77cb4dc-79ce-4d89-981a-f2951c1891eb	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20872	3cf891b9-bcfa-4463-be3b-3a4a4770d416	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	783e25cf-6a86-4a09-9994-6d2ed0724c09	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20873	68c3d617-e93c-4422-acbf-7cc6b9f2b888	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	553081e9-8c1b-41b6-abdf-337909b2d5cf	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20874	46b931a7-a3b6-4e35-b84f-7db32d5c82c6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	bf2e577e-66a9-44bf-8206-c5cb5c5778e9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20875	5971298a-3274-4215-8285-42decfcdde4e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d8cb3f1a-f34b-4644-9db4-8b5be7ed573c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20876	d7c26fbd-1bfc-448a-b5f9-0d6d7c067655	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e25c8c9c-f433-4afc-8079-43a6ed7417cf	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20877	0304867a-d6ca-455b-8be0-385bfc9985b1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	63491cfe-562b-44e2-8dc6-09cd6b08ec0d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20878	43b2904d-4b46-49e2-87a9-5de0c758c4a0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4f645fcb-ceb3-4b05-8b19-61711e8711f4	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20879	4ae4f9a9-5eae-4e40-826b-b70e9807b1a0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	69a1308e-8f76-4b36-b8e6-905ae6e139c6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20880	ab6fcdb6-0d45-40cf-98b7-9e055931846a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	352ebf2d-4fe9-4e95-b5f6-6a178066cc3f	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20881	873315e3-662b-4277-b6f5-9c12f0cc155c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	59a85195-4126-4c23-8ae3-6aa61c8b0639	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20882	c7204c09-8758-4340-8344-73a6d921e37f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	29396516-6f2c-4c6f-adc3-9341d54619c2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20883	352d8b6c-f3ef-4ade-91ab-515a0b3755bf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4edc85a2-6fbf-4577-bb5c-25418c3c88e1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20884	f7a008c7-8205-4147-a925-d8c9e326f91c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e7ec8e7e-0597-47d4-b29a-070d6a2306c1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20885	2aa3e338-8248-44b5-a8cd-751f19e78df1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0fd5ae17-37e3-493a-af19-e5d8f8b072a2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20886	2a49ff31-5529-4e12-b306-9d7b7a8ceef6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ff7326dd-5740-410f-897c-13d42208815f	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20887	07f8509e-48d7-4c07-a448-f17c6613f78d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3b476a86-22fa-4493-ae63-fa4f4348ff36	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20888	404963c9-7542-403b-be40-920cdad02648	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e246a241-18a0-4b8f-bfa8-75f1dac868e3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20889	8202dc98-2798-4ff9-8ca2-f18648fb412b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f9ed8a3f-1a40-4ce6-b6ea-5c9e20b82ef1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20890	773ff270-0dd8-48bb-8d4f-c2a5e4488a63	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e6a00ace-9821-4a3a-a815-2bae2c46ea57	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20891	9afc3b13-37b4-4203-a5ee-8cb80b5ef4da	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7887184c-8a70-4813-a1d7-52f5077f865a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20892	7647d1d7-d507-4076-a7b3-07c88cc99589	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9bdf1759-640b-477c-af00-b41d8ea517af	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20893	012d450d-2eb0-48d1-a58e-f598008bd14b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e6d972c3-30f6-4ca8-af8d-3be419c8bb4c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20894	f23e3214-2720-4400-b5f5-84080119a21f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9fd16d70-8701-4018-b1d6-3cd960e69f74	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20895	b9ce4899-7e30-456f-b342-ade9851856c1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4b17ed0e-10a0-4bb4-89b6-6fce15d39ea4	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20896	a17497dc-5afe-4638-8f94-0044e5ac26c4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6bc03965-8fa0-4f9c-96c9-679471b65661	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20897	39497091-134e-4198-b1ae-ead03dab3ab9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	90be2edb-9713-4008-b3ca-6b57c597a03a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20898	1d00bc3e-6758-4b1f-a6df-e9e9e4f04b6b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1797b5aa-9d6c-4396-b26d-f7effb4a067b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20899	7713102c-7736-45fd-bbad-89108c8b1c77	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0aa8b7ad-1834-41c0-9bb2-c8eb710f1954	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20900	f5b4a290-f94d-4a3b-aaf7-b7bb7ff3181d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	28de80ee-711b-45de-8dd3-98eb813f5445	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20901	9be9bc24-9f52-49e3-a8db-0de5fc71b775	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9ba045f5-2149-4127-b9f7-c4ae8acbd28a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20902	34c440fc-3737-4307-9591-e8c25730148b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0179c153-dfb9-47a5-b2da-7be92c2711a9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20903	df1c5b32-5233-4b50-90e4-8902ee81a7e4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d74f7ed7-6c60-4b14-b386-73ac953b7830	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20904	bfa3c8bf-d886-48d7-9d92-36d51d8cc9e6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f523c705-d212-4679-bc10-d956222d6b86	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20905	266ae526-5782-4be8-8198-ff66bee55d57	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8be4a421-1fad-4a5d-8891-8e12039dab2e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20906	d691ab48-096e-42f3-996f-90ddeea6b2cc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9c76db01-a475-4ffe-a023-dc8b6257e180	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20907	2e025d13-3ad0-400b-9f80-517081430f91	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5a11ac43-1a0c-447c-8786-231949152813	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20908	cc2fe642-66a5-4d82-9430-82155490776b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b74290f1-9b5e-4e91-b47e-c7143f33bb7a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20909	9f7b6157-85d7-4e39-a152-a45a15b601df	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0319cb23-b3b4-4971-a125-ca7e790e115b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20910	c23c1df6-04e8-4357-9ac9-546847d055ca	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7312c61b-d512-45e8-aa6f-44ffb0c267de	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20911	1dfeee38-a1b7-49e6-9341-b95b48653d1f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cf029ed7-a6fb-4b10-991f-366ae1967c22	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20912	4b06b617-885c-403f-b496-b625c825bd1c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a8064e93-eaa2-46be-bbfd-9f2f3eba86a1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20913	dba78dc0-233e-458e-b57e-cdc13db158ac	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1c86c972-61f2-4b62-8945-d47cc0e7a094	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20914	df9f45dd-701d-4ded-8d0c-572dc53edd9d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e96f9d9d-f3fa-4192-b209-f8a016703b41	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20915	250206cf-a078-4cfd-a6fd-fe30d1eb59a4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e698bbdf-8c36-4030-96fe-1b0cbb951b14	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20916	9eab8b1e-3abd-45a0-b6f6-07e9b3eb423d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8cd50cc8-c5ac-4f72-97d9-3424f4462c7d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20917	24f0c8f9-f38b-4d17-b4cd-49ad0e30ec21	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0c21731d-cd37-4454-90b6-aa391e1733b0	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20918	81defb25-198b-410e-bbf0-82c016644c47	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cbc39a47-ab1c-412f-bc7c-d16f6a26cf45	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20919	2090d808-ebd4-4358-afd2-f64c8892f80f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5c1d6a20-6366-4d54-a644-734826271d7a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20920	a86e56ed-d230-4f01-b5c0-bca27fad3cec	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6d1da046-a867-4408-bbd5-db12b1431f87	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20921	aa645f95-1989-4c12-ab34-070ba87c89eb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2872fade-29ba-4761-966e-abda03ca4ffd	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20922	dc0a70d0-f83c-487b-8c32-ce0443865caa	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ef8eb43a-18e7-4a1d-a578-3f46363f32e2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20923	b7405a04-a3b0-49dd-9f09-ba812b412856	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d30d84e0-4f6d-473e-b63f-fed35068d19b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20924	21f84e66-cbcd-4757-a27a-0f495c81b36e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	90cfedc5-e5a4-4f3f-b28b-4e5729f22442	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20925	1809fba5-a8f3-4952-acd8-ab10d64cc356	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	45693a90-0ffb-436a-8760-786f0b3c1d1b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20926	11a15a0d-e7dd-4010-ac5d-049907860b79	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	51ece0f5-dffc-4eb0-8566-3933bea4519c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20927	310b26aa-c159-4cdb-b9ca-0f114fca52be	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c98fbadf-b4cf-4fd2-a598-db9369f424de	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20928	966abff3-0b59-4ff3-88fa-d8ba9c078767	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	acd5d617-f33a-4de4-a7e2-3d472a3c1a11	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20929	be5fe611-faf5-44a9-97cd-4abdea3fbf24	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	393b6357-6cfc-4b1e-9ab7-56caa40adad5	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20930	8b040da0-929d-4ee2-846a-35edc487b343	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	16218c58-d190-4a73-a9c6-285617802c45	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20931	062c3ae6-3c52-4d99-8554-ad3a32748b59	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2184a85a-7a3f-4ea1-8901-2e464f7c7f47	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20932	00d9a53a-4b94-41bb-ae84-c6d603f9f141	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	72b6d0d8-99e0-4cf6-8660-6347ca9c83b4	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20933	214f7fb8-1501-4234-b624-480d7fc921d1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	210740a1-1302-45b8-a497-40c0dfba4b40	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20934	4dbb6c1c-605e-4e43-b6a6-7294a81c7220	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ebe3f5ea-3874-4aa7-93ff-74dcef6b3d3f	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20935	1169c0b7-995b-48e6-baf8-a68a4a770cbb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	623d5bee-da64-418b-a513-b9bd58843896	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20936	6c33e0e2-8cf5-4266-8e52-e2a4a048fc50	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	494e1910-5229-4d83-bae7-6e40abc6395c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20937	d7c03ad4-3af2-4271-9a1f-a69ffc4814b1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3058bf08-d958-4b46-b250-67e0ffde7d85	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20938	008d4962-d968-4bdb-9b4d-c6a41c2c262f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	260b46e3-621b-4dee-9339-a9df1265239e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20939	2d85bb1a-b279-4492-b78b-73a5ecbfeb9f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ab4ac7ec-47f1-4031-9c5c-328c480d0358	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20940	bcdf85fb-342e-4777-a88d-30fff5e15bcd	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7cfab583-1c73-4670-b2c3-7cabba4f9003	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20941	e0471e46-f981-4a69-9a2d-61353af83c4b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	332a676c-4b61-497d-a07b-9a5db5fed964	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20942	2d0fc647-9638-4559-9ebf-d1c30d22ec15	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5deecbe3-9cec-4b41-b18d-05ba2c74b5f4	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20943	165aa192-f0dc-4558-b236-fc266abbf420	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	825f2aa5-e5a4-4304-bafc-ace79b69a778	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20944	4c238c1f-cc49-4235-bd7d-ae6ba691e457	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5ed4bfaf-70bc-43fd-838d-7517a902424d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20945	0ac82b50-7bba-404c-b99f-2199d3094843	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fe8dd78a-747d-48e3-bb4c-c8456bbad517	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20946	80affd48-b09d-4eca-b97b-f6bff445f52a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8e7ed6e4-7544-4934-9b7d-a997e1c20d8e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20947	8aa72df0-0ef4-47b1-b13b-28b86de0f287	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4ea09f81-f44c-4736-81b0-0c262ee8dc69	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20948	b805f62e-3332-4761-9736-9934c0be5631	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e942f88d-ae6d-4544-a49a-322a7755b6dc	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20949	1f41db5b-e6ea-4ebb-8ae9-32265569fdec	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	35c58270-cb24-463b-bade-57a50f331cab	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20950	cda9adbe-abb5-4823-8ea3-0c3a5b6a17a9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e951fbc7-2ac9-4456-9786-7b3c28d2eaad	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20951	2b5522f8-8e36-4648-a4bc-c2c1501f0b58	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	bd913d23-265c-4124-9673-b3bbb45f6f65	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20952	5ab41903-2e5f-43f8-b16a-8e84c4d2b625	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4fb615c1-a71b-4170-8a17-85f6967d5a24	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20953	61a905dd-5f25-4844-b26a-9b4f62ad8dde	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	222ba6f8-23ed-47c0-96e5-915c661efab3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20954	856d05d5-0ab0-4777-806c-0ada8e95e4c1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d6c69ac7-ddec-4136-9a09-ffd02279e952	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20955	caff51cd-50f2-4db3-8584-f316024270ca	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b76ffc74-8e6c-4a6a-9ed5-364319a50b1a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20956	2b8ad6e8-8275-41fe-bf5c-b0e3ea1dadd0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	862f3628-6518-4df0-8337-5610494c06ee	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20957	d7883ebb-b2b9-4f9d-a7de-d83813ac3239	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f214c9ab-7000-4aaf-ad27-93fb25c91fd6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20958	155388b4-8243-4d58-a607-22f39e6fe079	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	bf62b608-6b7f-4fb2-bf01-dc3148f04f9c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20959	eaf64d7f-a818-4c80-b2c3-0b80da102d38	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	65624932-010a-4cc2-b182-fa46b921dc38	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20960	76336683-084e-4a4c-bc20-9713995de3f9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7c85a4cb-b492-488f-8e68-ca58a27d81a9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20961	ea31d1ca-c7c4-4fb1-9a14-b27efd5578e3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	22dd3681-db22-4397-903c-3bc3112befba	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20962	765413d4-f84c-42b1-9006-6f36b13860f5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7058ab43-8170-43a1-8fcb-d76df748af77	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20963	5251e37c-db0e-4254-8000-1b33d36cc7fa	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a27b412d-a303-431d-bb29-e09a112060ad	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20964	841bcffc-1704-4b59-b84d-0e1041aef749	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ab58f771-906b-4035-ba4c-d1d72c88b4e1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20965	26faaa15-5ede-479c-8ffa-cde7be43af0f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	97b7ab98-6f48-4a5f-aca4-b90c7cf4c954	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20966	e8d4c10f-5988-4c49-81b8-7c2c2e020764	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	24d95171-e9a9-4531-8ce8-d9b448408476	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20967	e5843c2a-d498-4bcb-900d-e9f07a87b724	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d36d5333-b19d-410e-8c89-10712e623c08	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20968	d77e25f7-6144-4f05-acf5-da6f745a3d25	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f4e7cfbb-c992-4fb4-b4a1-d9b56cb0a0d1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20969	469e6e16-0c6d-4b39-b24a-906f81a13658	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5891bffb-0530-446d-a204-0c820f63d861	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20970	c1f3635e-4d98-45cf-9958-ae51569214a8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2b9af69f-61dc-4c4d-91ba-fb0eeeeb6855	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20971	61fe3b5a-1e29-4af3-8378-dba86d182fe5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2a5ca64a-4e1e-4170-860d-775db8912ae0	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20972	c656f93e-f852-4d3e-bb41-cae566b5b400	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a85badc9-be2e-4d3e-be92-36c1f0d35a4b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20973	d57ffc75-6045-4269-9edc-4c0311778cbf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	02a9db2d-284f-492e-b279-d59db5b8a9d0	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20974	20356896-8ef7-4bb5-b72c-c1a45ba80a77	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d0c0172a-1e8f-4c7f-bfe8-7c343f175520	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20975	a0041138-d4ef-46bd-8eb0-6ddc5114997f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4e105987-13ac-414c-9d4b-8f772fd2b153	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20976	713e1394-c651-464b-a9ca-e409c43cadba	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7bea3d44-f67d-42c3-905d-291585425af7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20977	012fae93-5326-4023-8f79-005866a9e748	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cda41cdd-f95f-4d28-aacf-bec6649878c0	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20978	111073ab-6874-426a-9890-3c98fd5c56a5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	775ea4d3-204a-448c-b96c-bf78435e53f1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20979	bdf08360-621c-451a-b08d-fc34ac287d4a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	906f8149-ce1f-4534-8157-a291dcdad134	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20980	7b03c156-cd88-4247-9404-0af381f6cc80	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	14f01846-87d2-42c2-8f7e-4e4f7ae449b7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20981	e3d33be0-d314-40aa-a2b7-9d6db9407fc5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3128b4a8-a1e2-4ffa-aa9a-6483007900bf	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20982	d745e7d7-489a-411d-a6b7-7eb17a8368e0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9bb2c35d-7e48-46c5-8cd3-526a713ecbd8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20983	9fc01458-114d-4720-8338-183e030fb6b5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	268b96de-3eac-4a03-934c-46512520b7ff	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20984	40ee7b5c-e143-4a1c-8c06-7361e2b09aa3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	34d9dae1-0e8a-49f2-8482-5cbfcec16834	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20985	38a1a272-7b28-4bdf-bf20-50329857c176	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e2568445-c4eb-44f5-a0d3-4e1863acc9f9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20986	ffe4bf84-3ea6-46f4-ba2e-139f51635f83	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e8563ff0-2106-4546-bca0-208c7360cad3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20987	4f00956d-9137-487e-8240-218b615f7aa4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	61ecf465-5507-430a-b933-bd85301af74e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20988	6942f937-8d25-4318-bd2a-657171151735	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0f6f9a79-3862-48b2-b1d2-94288dc42c62	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20989	17cb1403-6778-460a-b3de-3c9034a3d41c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2879eb4b-3c22-43bc-8e71-0e005ff44108	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20990	21ffade2-53fb-4a20-98de-781b0ece4ca4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	14dccb51-3c45-4d1f-b206-d7873c794e92	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20991	f40f9dd2-547d-4708-a0b1-08a1e0d0a31f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d03e14ab-5664-4255-b5b7-e2df3f7ed2f2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20992	b00bb5a1-c985-40ec-a27d-2ebc35e87b7b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ca0d8bb5-50f4-4eb5-9d99-fea187bdfe8e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20993	e1bf8331-a4e1-4e97-a3c8-b2086f550276	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d8dabb69-b09b-4356-abe5-538cb5e552d9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20994	10a75d57-2981-4b72-a28e-96cdb8e5f271	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f034835a-2ac3-457e-8fdd-34621b78be27	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20995	963b203a-a7d4-4a07-b4f8-6a395a2e4944	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	eafba0bc-32be-4a5e-9f19-78db64b8ee6d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20996	1f9585b9-6b93-4eb5-8ba3-1b9d3180de74	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	712c4ef2-9112-4dba-a4c5-add48bedae9c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20997	7d6dd94b-a1f1-4ba4-9d46-01c4b85e2f44	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e3fd067d-1ab1-4754-9657-ef75738088c1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20998	a72af81a-5545-4da2-9a6f-f5204ca42827	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f443c764-37d8-4dae-93eb-7190a284c8a2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
20999	eeebd907-b58d-473e-a3bb-c35972a5d90b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3adbc8f8-43c6-4ca9-a3f4-b18cf19a7e4b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21000	9d8d41e5-d993-4db7-81f0-2344fd84f946	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:38:25.541701	2019-03-27 21:38:25.541701	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3ae58def-60b3-4054-bc03-8462f531a413	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21001	24ed0254-819d-482a-8aaa-6fe9a613e58a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	864cdc00-5559-420a-8702-2ae11932d435	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21002	c961396f-37e5-4364-aa23-20e20b1438b1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	332e5350-f5b1-4bd2-977b-4c72d29b697b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21003	ac23b085-4885-4468-a218-cc06c84b9e71	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	40a70220-d171-4d93-a0f0-3dbb557429da	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21004	2e0f7e81-28a5-4d6a-a920-8a961e87845e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f19b3cdd-3c2b-4b27-a472-72128d92d104	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21005	32a373ea-1395-49a5-b205-72150242e7c4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b715bfc6-d952-408e-b46e-777911a087d7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21006	e1d43d11-a485-47e1-9117-74d53090d02e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d78f6be9-81e2-4aff-9e69-ab3eca0b8c31	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21007	81a81942-6392-4dea-8fd1-195eeb7ad7f1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8862e794-dde0-4aef-a9c3-2af82f8fa2fd	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21008	eb19e2ee-b1ef-4b16-8cf4-0c587894f84f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f9d6a62e-46bd-4c85-852d-eac1f0977d8d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21009	d33b769e-672d-4002-b5ac-def621467adc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	aa67643f-c4ea-46a5-974e-fb0e96e89dc4	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21010	faf919fa-9f43-4702-a5b1-ef297d04d692	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7f4ed457-37c7-433d-9984-8f5f04da8110	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21011	79313edf-2775-4f72-b62f-9d649ddf594c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6728a76e-7a54-4570-82c7-33e834d1e4b7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21012	5707f3b3-da00-440f-9040-8349cd8a0073	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d614f22a-9496-46f5-a00d-e90a3496fed6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21013	23389fd0-7c72-470e-8b41-3f65db75f518	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b9d05409-8fb7-4d27-a8a7-c4ac7ed55bc8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21014	50c864b8-6487-4ecb-8476-23b64d2ba363	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	32d8113d-a603-4848-8c97-1a20a4e7f9cd	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21015	25a6c02f-2f4c-4916-b15f-86297ed2e60b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ec7913ba-2634-40c5-bf53-0eba08ac1f1b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21016	954d9f32-a534-4180-b045-6f3f39b8643d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0a2b3007-29fd-46d1-a72c-611f62599ec8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21017	fb4562fa-6949-4070-8461-825c9841f11a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0bb2d5cd-54ea-4707-ac82-b1587ad8bb82	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21018	f8f6add9-2cca-4eb3-a30e-c067e258ee5e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e2f232f9-54b8-48d6-9f37-bd0883daf241	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21019	8d0de015-bcfa-44d4-a8b0-9ed365861066	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ba3cd489-cc10-4c1f-849e-25d8ac6a4374	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21020	7f748f98-cb97-4415-a5bd-59bf23b88711	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	378e6d2d-5341-4b7e-aa7e-2494b237dc0d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21021	6b145b1a-aa6a-448d-a9a4-dc660ef62eb0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ade94d3b-3a5f-4708-b4a7-a04d6339040f	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21022	7b0fff3d-d15f-4d4e-9a86-e1e76604767e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	002ff33a-f491-4958-bc18-0a4107b6c45b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21023	7393c6b9-bd76-4864-819e-1d317e2eb3f5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0f6f490a-cc5a-4ee5-a9de-1c5cee02bd96	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21024	bb6b1cb9-b033-4f97-9b0c-461fbe8fc2b0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	28282c19-359a-446c-a249-40e0fcfe2617	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21025	90b024e8-fa86-461d-8d02-2623eaad5c5d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d3a1de0a-164a-4e1b-968b-f8814f8d28b8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21026	a7ed8d79-a020-41da-b2f7-19cdd1d1a98c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a665be0b-4a90-4450-8026-451baf4b9f9a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21027	542babf3-cf74-4944-ae0d-21021ad81795	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9c63f4e7-83cc-414a-b35d-0e68ba04490d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21028	c0c4fcae-83d5-41d8-9cbb-1f5cfee6dd65	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a29a02a7-dc50-4232-aa57-0a36c2764509	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21029	a03d9851-a9a1-4431-b083-f5647e5f1860	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d3509cea-3a60-4421-9529-1a97e3de36a5	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21030	d2ec8301-1a8e-4293-889c-60c12ce87b2c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	63147d18-3cc0-41da-9eb7-25281fe34f8d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21031	7c809948-fdc0-4d38-961e-368db846150a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2be146f4-658f-4057-845b-9db33be9bbdc	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21032	71ef9211-7085-49c8-8656-e8591b04cd9d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d804d583-5e51-4d88-9fb0-49049e84d602	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21033	91f60fc0-ed8d-4b49-a913-d0dcb7d8ff01	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	95fa21d0-0ce3-4efd-aa2f-c1b15247f37a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21034	d3ffde92-a77d-463d-b2e0-74f4e7c343fe	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	26b9db13-c611-4dbc-8bad-258da91d2f63	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21035	1b33e040-5a04-4540-a3fe-1319520f67e4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1a964ce6-8dc1-4d0f-bfcc-a9d903bdba0b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21036	853f6158-c91e-4a71-8e8f-7371ecdbb3c7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e83244f8-6da6-43a9-88c2-70a326d1a03e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21037	5b233947-be96-48ec-9f6c-97525e94bfe4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	824ec62d-5007-41f7-882d-009d779effb7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21038	b02e0133-089c-4668-88e8-f85b4c364d1b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b62a42a0-504c-434b-b62d-548e3a32472f	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21039	f8767b29-ce1e-48e3-b629-69a629248dc8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	bb9eb790-ddec-4780-bc4e-f0bf8262f5a2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21040	dfe2a056-8455-4462-b0e4-19a47092c7cb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9579fc35-fe51-4a75-a5a3-fc22e7498036	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21041	98a3163b-8eb9-4e39-8cd0-1482de0b417b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	22471ff3-ff1e-4f4d-8502-836d578ab7f2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21042	38b450e7-26ed-49e4-aab6-3976bd7b1bb5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2341d653-6451-4f2e-9d07-b3c133507d1e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21043	f789b109-2b2d-459d-a1fd-b02eff392fdf	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	30758317-ea50-4671-a04b-44a0786a168e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21044	74f3027e-16d0-4e4b-b7ab-f0320fd4ee9c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4dc84784-7493-4afd-92f1-c07fb8e6ef16	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21045	74a09659-a6da-46b9-843f-06c12deb1b66	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8b02f7fd-44ea-4808-a919-5cccc7b100ea	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21046	ea19ae37-1005-4de7-915d-b15b60f29e64	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7d66a94d-8abd-47e6-904f-c6acf6c2f952	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21047	a257a6bb-4abf-4e26-86c0-6abce021a1f7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fccd97f7-316a-4a98-aa5f-693a0a410dc3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21048	4cab3c3f-d60b-49b2-8a8a-04b6060a0093	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7f0dd1bd-2b13-4c53-9b09-bb173385d2e2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21049	befb426e-72d3-4db8-9710-5493ae36bc72	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1055a195-eff6-4848-b821-85aaeae4de61	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21050	4b0bceb7-86fe-45ed-9532-ac277a7401eb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	863c49e5-7bf7-4ad0-bf73-8aedf9d7e3d6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21051	0674b09e-ee21-4ff2-9084-6878e0510124	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9b8c053d-d39f-4fa9-8f81-a744e7cbdf89	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21052	b71eab4a-da4b-4046-8a5f-b75a273b4278	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	bab0a3ec-b2da-451b-bf03-f1b6f559fdf9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21053	0272e673-250a-46b2-927b-5808ef29f587	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b539aa4d-87cd-4ea8-b63f-5e24b32ec44b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21054	65ff4d15-56df-43dc-b3f2-7778095a4c5a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	80db5e6f-10cd-45c8-932e-ba9c966cd5f2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21055	13f90782-f4bc-46f4-8d3e-84e0f3ececf4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7a99c748-80ed-42cf-a43b-36c6ebff5337	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21056	fb1ba49d-7cdb-45fb-b0db-6c113d36f635	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	35fbe9a5-f49e-445d-bf99-437588061374	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21057	fb1325f0-be52-484b-a077-b5fe2bee98a8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ca23957b-14dd-4bd2-a59d-043eb4450b53	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21058	519e859c-b31a-48c7-92a7-3cf25457f864	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fe169793-d1b8-4319-bb65-2d90939e5bc0	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21059	bfe1d85e-5a26-4f33-b6c3-ae7e0928652b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	756e599c-d447-47c6-95c1-e4d534390fe9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21060	fe7ad23a-bb73-4e0f-9611-c75176fd9a78	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	381c75c9-0ea5-4dae-bdc5-a8e01e8e878a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21061	fc9759cb-b3ae-4b7e-b71f-801301d79c9a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9ae765e4-aab0-4c9f-86d1-cfeaedd0e634	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21062	58d670a1-31d1-49c8-a2ee-60a38c57ab26	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	64afc6e5-7d3d-4d69-bbbd-30da09b5c4ee	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21063	ac1c394d-a69a-49c7-a51b-491adb1c54b6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c3c33a70-3790-48ec-a10d-d6442b18757b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21064	5d9743ba-9788-46f9-9333-60a56f5c7272	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ca515d9b-6e4e-4ad8-bbc9-18dd8c223817	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21065	ef2631ae-477c-4573-a405-3472956c84b8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6af96106-9f6a-4a87-ac97-40bd3a01ce93	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21066	35bf27ff-52fa-4d81-8b74-17752cb1af7c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	dcbdac16-4939-4979-8111-0ff93dc89336	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21067	08e41a84-370c-4243-af56-42e0eeb6f1e3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f7413dee-3bad-4951-9f61-206eee0c521d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21068	24cea7c9-fda2-4d82-a4d3-859fe8947dc7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5b78a1b0-6def-4ad0-954f-a79d95155252	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21069	8ab1b7e8-d860-4ffd-91c3-188db807766c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	00417aa3-b6c0-43c5-b90e-7b36b070b145	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21070	4bfbf5c6-a362-4f3a-8167-bfa3fd98b85b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	33909356-25d3-4bc4-850d-d68892226de1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21071	afe930cf-d860-4fa8-98e6-14ae8aaad84a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	80241ec9-a401-446d-8e23-c4754db83e93	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21072	f858e02c-be54-44a3-ba90-dc724ca8f41f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	35c02f32-6bbe-499d-b4fb-69722a380a0c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21073	81dd446a-1a60-44a2-bed8-b6a722dddb12	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	85b43dfd-b924-4860-8c24-d79612f67cc7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21074	73512ebd-3813-4241-8452-ebc2363c9630	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	147c2064-eb23-4c86-b771-6e6f7d02f374	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21075	3ecb71e0-f213-41c6-ad70-51b7c742ec85	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	635c503e-da3a-4627-8af4-75b75ae92639	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21076	adf2e7ea-7ef6-4aa8-9cbe-d785be36a07e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1d56d1b2-86cd-4639-bca1-1063725a2393	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21077	f720fd89-1ff2-4112-8b1e-d29fc2933634	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	97a57b26-c218-42a7-b18e-60d1f63db640	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21078	175e2925-b862-4d76-a73f-2af50df08020	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8e299653-7ad4-4c8c-aa27-cf82583b1597	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21079	f8936008-66b4-415f-af50-bb148379d0f4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8790431c-94ed-474c-91d6-5f7636722789	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21080	c4ee7e38-34d4-4a8e-8642-59c95e74f149	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b72dddd8-91a3-4d5c-a009-523cf19b742e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21081	8959c526-0676-4eb2-b6e4-7220ccd293dc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	37c76ca8-7a8c-47c4-adbb-35a5fc066555	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21082	df23fa49-a29a-4e20-a7f2-178dfcb5c550	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6a398a12-c64e-45d4-8c65-e5cbd694cfb4	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21083	c5c6e7f0-a8f4-4120-a5bc-a1001090cb5c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a20eccdd-1d14-4dd7-87bb-c710a342d94d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21084	b6b21fee-7fe4-42a3-bcba-7eb26ad82782	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d684a0b8-4a7b-4449-9cfb-0db3e4af4c92	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21085	76eafd57-9e2c-472d-b2b2-aae92f73e3bb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	53aafe8a-27b1-42d1-9bea-cabd9cc81493	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21086	f2e18f25-e364-4bf0-ab18-9987063991d8	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c4586a51-78e9-410f-b27c-e8ce47daa5ae	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21087	889a8583-9845-4703-846a-532c701e5eec	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	693e2df0-c4c8-4143-bace-764afccdc777	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21088	3a6fc6b6-7850-409c-931d-d3eef1671da2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f7446280-c76b-4dd4-ac80-af8360f79c70	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21089	fd6db473-4e48-4a98-a20e-7b4df86121fb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b0d4c39c-746e-434a-89b2-45a533f4ff7c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21090	d64944fc-058a-4361-a668-eedebb160fe0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1cd2a97e-8048-47df-9c2b-c133553e9204	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21091	29ce5fd8-ea70-494d-993b-af59cba4aacb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0d2dd45f-adba-4359-a920-3f0dabc9f327	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21092	4f448f9f-4cb6-400e-89d7-72e5b8877256	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c52eb3af-a0c0-4cda-8258-6a4c71e7d2b7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21093	2927aa2f-661b-4260-b492-16ef6054df73	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a5f590f4-b426-432a-9943-3b0b133c77bd	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21094	7520c22b-41dd-45a9-9b09-2faba32f4c29	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e32fde53-101e-48ad-92bc-33a50fac7dd6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21095	a760f16d-937e-425c-996c-731713844a3e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	55f42d65-31cc-469b-9466-74c9294275c2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21096	e0c207a7-6c2b-44ce-8ae4-494ae28f72e5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	027f2756-638e-4944-8b5c-8af756b4d4dc	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21097	b1acb77e-46be-4115-b5a0-2742904c50d2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cea94e37-693a-4226-9c99-8c0b457100b6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21098	9ca2ae91-5504-4cf7-9fdb-ea093b5c208d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7c3f7ef3-1184-48f1-b085-55d0903b402e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21099	b6e5cd1d-68c4-4974-805e-56dd83b62db5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	78fc1ea7-ad92-4f66-9a51-a128be8ea77f	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21100	fa8dde5c-5e94-428e-98cb-d2d7577cb99f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	24d31453-4755-4499-a320-b6f01931f1cb	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21101	dedc7671-ce31-4725-9fbb-cc0244014832	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	836c9af9-64e4-4ae3-b703-194b8ace72ee	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21102	69d927af-bcfb-4ee1-bf18-afd2b4328267	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2827e5e5-1b29-4de2-bc0f-4aee1edc3a13	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21103	fd140a26-30cc-4ffd-ac30-43df130bbd6c	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	4e4f7be4-12c4-4ba2-8e4a-d756965bfba2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21104	d8af96fa-7512-47d6-90ec-565db91948c4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c212f476-3d34-45c3-9b81-bb3e9b32bedb	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21105	3622504f-f755-4c5c-a297-534d6fe80274	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	41a7db5c-3737-4b8b-abed-dfa3a80ffc4c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21106	60c12f72-410d-4105-8e27-3de8032596c3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8e1c6bf1-8ac0-4919-a324-e1e8103c41bf	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21107	89637aef-040c-4156-99e6-7b319bcbe570	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cd48a771-b248-427a-b6a4-7cafa6661556	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21108	5ecf69fa-6306-4036-a625-a764bcdb9875	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	31fadade-3b32-4875-99b6-1ccc598a6b5b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21109	92f83e13-e0ff-4cef-967f-67fabe32a51e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0c51bf83-db19-471d-b9f2-2e8ce4e8dfca	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21110	354abc7f-9964-4358-9194-3ca2545364db	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7dfd0c38-f523-4f01-a521-720ef1d6646c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21111	38012e9c-6ac4-456f-a919-6d1d8a88ac35	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	cf2a6c55-a6d5-44fa-bce0-d996956d4b9e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21112	63bc9f7e-bb89-41e6-8d50-bb659a4e7d7d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f8aeb543-3a41-4074-9303-6a006df55f10	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21113	7d4616b7-2df1-48d6-b233-4614746840ae	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	98930b64-936e-43c1-b828-1fd37d90332a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21114	826a60c4-43a5-4fb2-8545-6e0efb99fc97	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	fabb1707-d0ae-4fc4-9dae-fc329ea9d8b3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21115	60faae52-ff54-4547-bd7b-879bfab24a6a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ff771dbd-405c-4b5f-8325-4a1722b5b076	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21116	980ae659-9fe1-4c31-91f3-ee7fddc3e225	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ea127f25-29e5-486e-ad52-b183f5a6d50d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21117	973f444c-5e25-4686-a412-9478b2e6629e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9aa549e3-e2f0-42b8-9f72-24777a180ea5	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21118	ef375843-9434-4dce-9d4c-fff54a03c8ca	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f8ba5a42-a332-4cd4-8163-3a9959b50771	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21119	59734f25-cfaf-4c7e-adf6-2b8632deaba6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	19de221a-762c-4727-82d0-b077100e0eb9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21120	0d4ac1ab-bd38-453d-adae-fd9522f1e7c5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	992ad490-efb7-407a-87cd-09e2c744b93c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21121	5391ebd8-bfdf-4ea2-b7b1-85976a6c8f58	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8562c42d-305d-4aad-9d63-73d8dce8d09c	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21122	fb350e7a-2e07-4c23-84d2-aaef1609c52a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	315defaf-2f69-4f95-a491-520ecd58b017	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21123	71989809-8a15-410d-a3c8-b7dc65826b91	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	179ea074-f450-44e7-b028-a6d67124c2ac	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21124	093b203b-0235-4349-9a1e-ede3d4c667f2	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ddb9ac6c-3355-46a3-bc92-f3057b572d6b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21125	34257cb3-9810-4bb1-90d8-7c5b8ecb137b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	976b8651-2484-43b4-9378-34059a72fbbd	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21126	132aebf8-3942-4f08-8f4c-52b1fdd6c3e9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	30c02793-26cb-40af-9175-1ea146ca20de	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21127	8fd43041-abdc-4e2c-a4ff-227cdc479047	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	527648f5-e0fc-4889-a8d7-5102dc2624d3	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21128	b371da12-6c0a-4c73-9489-1dd732bff02a	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e8f7d550-4503-402b-bd19-5c0f2f9256a1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21129	211a47b4-784a-4f61-ae70-b2f980ba1290	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	10a226fc-f66c-4694-b4f9-dad141ef64bc	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21130	1864aee0-1c40-4179-9fd6-9102284952c0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	3ded6eb6-94eb-4f1c-8cc5-5a3f4a19fde0	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21131	5fada7ba-c54a-4180-80d4-0e76047f366d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	2bc178ae-cbf4-4b03-8742-141e63fb9409	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21132	d440dc74-f5cd-481f-b66a-40bad0e62b75	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ecb598ab-4fc5-441e-a21b-a042957e9bfe	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21133	fe5700ae-ce2e-4fba-aaf9-820f4f5d2cf1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8b79cbf2-cbb0-41e4-bfcf-dd56bba16529	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21134	174af8f6-8072-4bcd-bf17-446d330f7dd4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b49e6eb8-6f10-40ea-a494-9ab10971bd9a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21135	9c234fd8-2cbb-4c7d-86a3-c4889083ad39	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d8bea5d3-dce9-4dc5-9f03-963b4b07ce87	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21136	c9b2180c-e103-4590-94c6-db10ee625ac9	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	662be35a-d18a-4c20-8d44-968792dec846	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21137	d5056b50-5a3d-4dd2-b85a-614b238be172	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d1d53d63-1f22-49bf-9e2f-db2204a27edd	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21138	a4e2d9d8-5b45-43ca-b354-2a24d451f4fe	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f2518978-3612-4bde-876c-041f527b7b9a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21139	b5c07a4e-49c7-4b7c-aa48-5276547e160b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d9375382-2b51-421b-9f10-6349d03f5ad7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21140	58bcd954-162e-461f-a725-62b5efd0ede0	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8905759a-b9e7-46a2-875f-3224b9fb010a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21141	a126889c-9bd8-44c4-ac1e-05115b06d5a4	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1653ffce-409f-417f-9ad7-98ba8e9ed9ae	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21142	9a976065-69dc-436f-a6fa-f579fa196249	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ec6e7e0b-5c29-47c0-a31e-cd0e07d1f60a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21143	2647c79a-97ff-4e01-a733-fec64c287fdb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0dbfa7e6-01d7-4f79-82d8-9a6040cab3c1	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21144	7e112989-f676-4ceb-8798-21ec8512d0f1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1c647fbc-25c5-4e1c-9dbd-aba25992514b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21145	5bbb2b01-5998-4207-a7a8-b1e25b184769	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 21:42:54.092032	2019-03-27 21:42:54.092032	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	9a22ce1a-4eab-4c95-89b9-8d71a7fdaf41	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21146	e97b4772-7e74-4703-9b0d-a3b956bc7122	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 23:25:17.444609	2019-03-27 23:25:17.444609	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 23:25:17.444609	\N	309d18da-918c-4753-9c87-03fd85adfc04	4612e10b-fe59-4bd6-a2ea-7f5ab6c8aa48	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21147	d9b6c02a-1300-45d5-a6a2-2ae4ece9f5eb	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 23:25:17.444609	2019-03-27 23:25:17.444609	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 23:25:17.444609	\N	309d18da-918c-4753-9c87-03fd85adfc04	393b6357-6cfc-4b1e-9ab7-56caa40adad5	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21148	1f8d43ec-f14f-469e-863a-a70648fd7aaa	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 23:25:17.444609	2019-03-27 23:25:17.444609	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 23:25:17.444609	\N	309d18da-918c-4753-9c87-03fd85adfc04	756e599c-d447-47c6-95c1-e4d534390fe9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21149	1b58c0f7-bd47-4003-921c-5bd09badac9b	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 23:25:17.444609	2019-03-27 23:25:17.444609	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 23:25:17.444609	\N	309d18da-918c-4753-9c87-03fd85adfc04	9ae765e4-aab0-4c9f-86d1-cfeaedd0e634	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21150	41dc8bff-2945-4751-a61b-5fb42bd286da	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-27 23:25:17.444609	2019-03-27 23:25:17.444609	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 23:25:17.444609	\N	309d18da-918c-4753-9c87-03fd85adfc04	64afc6e5-7d3d-4d69-bbbd-30da09b5c4ee	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21601	f8d0044c-1cd5-436c-8966-5553f6507522	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-30 12:01:39.15403	2019-03-30 12:01:39.15403	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5dee91ed-6815-4991-8461-d487788c1778	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21602	85fc37c2-30c0-4107-98c2-b80fbcf4fcda	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-30 12:01:39.161061	2019-03-30 12:01:39.161061	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	ea172807-ea66-44ad-9d8f-9c6469981b7b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21603	caae4a26-fd95-4dff-8231-398bbdd324ad	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-30 12:01:39.166081	2019-03-30 12:01:39.166081	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c037ec12-a7fc-44d9-86e4-35d421a513a6	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21604	e7e7bf44-c312-4efc-a2aa-ecc1bcb297d7	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-30 12:01:39.170314	2019-03-30 12:01:39.170314	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6b7388bf-3403-40a4-ae3d-7f2e89ca5d4a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21605	5409c0e3-bab8-481d-85c0-d2c6c53eb85d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-03-30 12:01:39.177166	2019-03-30 12:01:39.177166	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	f293b2b3-68b8-4b05-a19d-4bdce9d1eefc	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21701	20c88e4f-380a-4696-8422-5b607661ffb1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 09:47:33.398746	2019-04-03 09:47:33.398746	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b242dfa9-1ac2-4a80-a4b5-d2e5c53fb87b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21702	ba3416e4-2b9c-4eba-9106-58b55b60fb24	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 09:47:33.405786	2019-04-03 09:47:33.405786	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5868526a-2bbb-4933-baa6-e1e016d0dc7e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21703	0669fb43-95a8-4a9d-a37f-694a604cf404	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 09:47:33.408571	2019-04-03 09:47:33.408571	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:42:54.092032	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	8a8b2b9f-2d84-4375-8de5-55fd58abd374	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
21801	859a186d-d997-47e3-abc6-cfc49c65139f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-03 16:03:35.77611	2019-04-03 16:03:35.77611	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	54ae91b1-a5d7-4644-ba26-2c1f70c56f84	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22401	057f56b2-b254-4035-afac-a78bab3b0e0d	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 14:24:27.380814	2019-04-04 14:24:27.380814	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a1e5043a-0316-4332-96a6-4caa4204e6eb	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22402	365b8c6b-1573-437c-8975-3bc0a2b0ab5e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 14:24:27.387271	2019-04-04 14:24:27.387271	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	74d1a5a5-70f9-470c-8008-1b7982b4021b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22403	e2e97c80-f884-46ea-8d4d-b1a4b4a35386	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 14:24:27.390785	2019-04-04 14:24:27.390785	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1a71b382-953a-458d-a14b-983787645fb8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22404	99d1a544-8571-4c99-baaf-add499bf8370	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 14:24:27.394076	2019-04-04 14:24:27.394076	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	03cd1ae1-47e9-48b4-bb44-70a6c7c7501b	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22405	c1b5b4c1-8c26-429e-887f-893c59d84caa	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.431811	2019-04-04 19:46:52.431811	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	0a96bfc3-0c67-4671-ab42-384eb10768c9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22406	de92862e-0f7e-44e5-b435-b35f3ea0d0aa	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.440041	2019-04-04 19:46:52.440041	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b0bd7fe9-c06f-4b6a-815f-f8f3b9983763	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22407	3af59bf1-2696-41f6-a7ec-a240b1d3d1d3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.44804	2019-04-04 19:46:52.44804	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	1ee27776-9dcc-45b0-9ced-7f41ed46fe14	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22408	dbe72485-ca0c-48ea-ab78-d59e1316ecef	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.452294	2019-04-04 19:46:52.452294	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	56e4ae7a-2472-4ae7-9ccb-32976b4f98d2	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22409	a7ed681b-5245-4d6a-99a6-eade227f7396	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.46202	2019-04-04 19:46:52.46202	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	e9377cc8-e50a-451d-9039-6faab8ade8d9	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22410	63572da6-3906-4ba1-b64c-40a2c5cdb975	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.47047	2019-04-04 19:46:52.47047	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	7f5ee6ef-ac4d-4078-a9b2-7b5adfa9132a	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22411	8412dd9d-db12-4214-a01e-36909ee6dca6	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.474471	2019-04-04 19:46:52.474471	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	bc3177b9-4cfa-4d53-9d2d-dede9456a41d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22412	8894ca0b-8b79-438c-8324-04b3e7c717c1	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.477807	2019-04-04 19:46:52.477807	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c417784d-590f-41cb-8e51-b79b7f630cd5	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22413	20b13b03-b015-4e4a-ae07-7cb20c47569f	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.481774	2019-04-04 19:46:52.481774	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	db87de6a-9567-43ed-b905-688e93c842bb	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22414	c6361504-ed9d-4b0a-8705-43f1042055fc	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.485613	2019-04-04 19:46:52.485613	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	53175d3f-1224-4de7-b313-bef86c433f8f	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22415	2dc13ecb-2544-4b55-8651-6e2c9a5a0380	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.488811	2019-04-04 19:46:52.488811	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	b92857fe-7a43-494a-b211-0524101749dd	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22416	f6f122fb-9e88-43de-9f99-426cde69ab35	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.491833	2019-04-04 19:46:52.491833	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	81f446ae-1a75-4502-9753-6ccdbdc5ba03	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22417	04e07808-6a8a-44c6-9ccf-963a67dc0907	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.495708	2019-04-04 19:46:52.495708	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	900678de-7571-430d-a917-99b49caf4c7e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22418	1aab97dd-2976-40df-9a9b-072a063179b3	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.499855	2019-04-04 19:46:52.499855	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	65d490f0-4de3-4a56-836e-aebc9d1abf97	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22419	410a22af-6fc8-4b26-91d7-a6bb5bb68ada	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.503545	2019-04-04 19:46:52.503545	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	5fe25dee-53df-4f9c-b2ac-2a70d601412e	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22420	e8bfc18a-982f-45fe-b3e1-adef0d206ab5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-04 19:46:52.507021	2019-04-04 19:46:52.507021	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	210343bf-cf1b-4771-92df-e525903cbde8	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
22501	32eeb43e-9244-4fa5-b5a7-648cf485010e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-06 23:53:52.583562	2019-04-06 23:53:52.583562	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	a98a0778-dc52-432a-a0b2-1d03d85a6100	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
23201	2b3eb24f-65eb-47b7-ba39-e8b2c4efb2ac	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-09 22:06:32.281545	2019-04-09 22:06:32.281545	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	26c5fffb-3b60-46df-aa9e-ae5e46c352f5	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
23501	ff5ea4e2-ea9b-40e7-9ab7-76a849ebd626	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-10 23:53:52.394025	2019-04-10 23:53:52.394025	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	80df4709-4299-47be-a0e7-5be757ee0e8d	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
23701	c98b4ece-ca88-4f80-a77d-7f9b533a7e4e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-12 12:03:42.013595	2019-04-12 12:03:42.013595	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	c9999028-ff03-4d3c-af7b-3b1a5f84b426	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
24701	084c1daf-ec12-42ae-8057-eb832a64fcd5	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-13 23:59:21.413688	2019-04-13 23:59:21.413688	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	31f28b7c-3c80-49a8-8e3b-ff0c713aeb56	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
24702	1ac84ffb-d3a5-489b-80e6-bf142afbc425	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-14 00:24:57.773476	2019-04-14 00:24:57.773476	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	6338586a-1fad-415b-ad64-5e658f70a257	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
24703	5d7128c4-77d3-4ec0-945e-19e32a867b9e	3c65fafc-8f3a-4243-9c4e-2821aa32d293	2019-04-14 00:33:23.751709	2019-04-14 00:33:23.751709	\N	f	e20ca770-3c44-4a2d-b55d-2ebcaa0536bc	Permission to Access Open API Operation for Sys Admin	Permission to Access Open API Operation for Sys Admin	2019-03-27 21:38:25.541701	\N	4af1fc1d-a735-4c95-92c1-c68d3be4a53a	d4d041cd-8d31-4a8c-ab78-6ee204798dc7	cf52d8fc-591f-42dc-be1b-13983086f64d	6223ebbe-b30f-4976-bcf9-364003142379	t
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
-- Data for Name: subresource_action; Type: TABLE DATA; Schema: abyss; Owner: abyssuser
--

COPY abyss.subresource_action (subresource, resourceactionid) FROM stdin;
getApiProxiesOfSubject	bf0b6ac2-7d07-49c6-b3f8-0fd7c927126e
getApiProxiesOfSubjectByCategory	bf0b6ac2-7d07-49c6-b3f8-0fd7c927126e
getApiProxiesOfSubjectByGroup	bf0b6ac2-7d07-49c6-b3f8-0fd7c927126e
getApiProxiesOfSubjectByTag	bf0b6ac2-7d07-49c6-b3f8-0fd7c927126e
getApiProxiesUnderLicense	bf0b6ac2-7d07-49c6-b3f8-0fd7c927126e
getApiProxies	bf0b6ac2-7d07-49c6-b3f8-0fd7c927126e
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

SELECT pg_catalog.setval('abyss.access_manager_id_seq', 7, true);


--
-- Name: access_manager_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.access_manager_type_id_seq', 10, true);


--
-- Name: api__api_category_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api__api_category_id_seq', 42, true);


--
-- Name: api__api_group_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api__api_group_id_seq', 32, true);


--
-- Name: api__api_tag_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api__api_tag_id_seq', 41, true);


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

SELECT pg_catalog.setval('abyss.api_license_id_seq', 151, true);


--
-- Name: api_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_seq', 5799, true);


--
-- Name: api_state_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_state_id_seq', 10, false);


--
-- Name: api_tag_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_tag_seq', 449, true);


--
-- Name: api_visibility_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.api_visibility_type_id_seq', 1, false);




--
-- Name: contract_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.contract_seq', 4000, true);


--
-- Name: contract_state_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.contract_state_id_seq', 1, false);


--
-- Name: conversationid_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.conversationid_seq', 30, true);


--
-- Name: dashboard_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.dashboard_id_seq', 5, true);


--
-- Name: license_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.license_id_seq', 44, true);


--
-- Name: message_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.message_id_seq', 78, true);


--
-- Name: message_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.message_type_id_seq', 1, false);


--
-- Name: organization_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.organization_seq', 4100, true);


--
-- Name: policy_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.policy_id_seq', 46, true);


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

SELECT pg_catalog.setval('abyss.resource_access_token_id_seq', 320, true);


--
-- Name: resource_action_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.resource_action_seq', 300, true);


--
-- Name: resource_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.resource_seq', 172850, true);


--
-- Name: resource_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.resource_type_id_seq', 6, true);


--
-- Name: subject_activation_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_activation_seq', 11599, true);


--
-- Name: subject_apps_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_apps_seq', 4700, true);


--
-- Name: subject_directory_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_directory_seq', 900, true);


--
-- Name: subject_directory_type_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_directory_type_seq', 500, true);


--
-- Name: subject_membership_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_membership_seq', 8799, true);


--
-- Name: subject_organization_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_organization_id_seq', 90, true);


--
-- Name: subject_permission_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_permission_seq', 25700, true);


--
-- Name: subject_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_seq', 42599, true);


--
-- Name: subject_type_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.subject_type_id_seq', 4, true);


--
-- Name: widget_id_seq; Type: SEQUENCE SET; Schema: abyss; Owner: abyssuser
--

SELECT pg_catalog.setval('abyss.widget_id_seq', 5, true);


--
-- Name: access_manager access_manager_unique_constraint; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.access_manager
    ADD CONSTRAINT access_manager_unique_constraint UNIQUE (organizationid, deleted, accessmanagername);


--
-- Name: api__api_category api__api_category_unique_constraint; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_category
    ADD CONSTRAINT api__api_category_unique_constraint UNIQUE (deleted, apiid, apicategoryid);


--
-- Name: api__api_category api__api_category_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_category
    ADD CONSTRAINT api__api_category_unq UNIQUE (apiid, apicategoryid);


--
-- Name: api__api_group api__api_group_unique_constraint; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_group
    ADD CONSTRAINT api__api_group_unique_constraint UNIQUE (deleted, apiid, apigroupid);


--
-- Name: api__api_group api__api_group_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_group
    ADD CONSTRAINT api__api_group_unq UNIQUE (apiid, apigroupid);


--
-- Name: api__api_tag api__api_tag_unique_constraint; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_tag
    ADD CONSTRAINT api__api_tag_unique_constraint UNIQUE (deleted, apiid, apitagid);


--
-- Name: api__api_tag api__api_tag_unq; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api__api_tag
    ADD CONSTRAINT api__api_tag_unq UNIQUE (apiid, apitagid);


--
-- Name: api_category api_category_unique_constraint; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_category
    ADD CONSTRAINT api_category_unique_constraint UNIQUE (deleted, name);


--
-- Name: api_group api_group_unique_constraint; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_group
    ADD CONSTRAINT api_group_unique_constraint UNIQUE (subjectid, name);


--
-- Name: api_license api_license__apiid__licenseid_unqconst; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_license
    ADD CONSTRAINT api_license_unique_contraint UNIQUE (deleted, isdeleted, apiid, licenseid);


--
-- Name: api_tag api_tag_unique_constraint; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_tag
    ADD CONSTRAINT api_tag_unique_constraint UNIQUE (deleted, name);


--
-- Name: contract contract_unqc; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.contract
    ADD CONSTRAINT contract_unqc UNIQUE (apiid, subjectid, environment, licenseid, deleted);


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
-- Name: api_state pk_api_state_id; Type: CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.api_state
    ADD CONSTRAINT pk_api_state_id PRIMARY KEY (id);


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
    ADD CONSTRAINT subject_organization_unique_contraint UNIQUE (deleted, isdeleted, subjectid, organizationrefid);


--
-- Name: access_manager_accessmanagername; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX access_manager_accessmanagername ON abyss.access_manager USING btree (accessmanagername);


--
-- Name: access_manager_accessmanagertypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX access_manager_accessmanagertypeid ON abyss.access_manager USING btree (accessmanagertypeid);


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
-- Name: api__api_tag_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api__api_tag_uuid ON abyss.api__api_tag USING btree (uuid);


--
-- Name: api_apibaseid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_apioriginid ON abyss.api USING btree (apioriginid);


--
-- Name: api_apioriginuuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX api_apiparentid ON abyss.api USING btree (apiparentid);


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
-- Name: api_category_name; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_category_name ON abyss.api_category USING btree (name);


--
-- Name: api_category_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX api_category_uuid ON abyss.api_category USING btree (uuid);


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

CREATE UNIQUE INDEX idx_subject_directory_unique_order_per_organization ON abyss.subject_directory USING btree (organizationid, deleted, isdeleted, directoryname, directorypriorityorder);


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

CREATE UNIQUE INDEX resource__protected_resource_index ON abyss.resource USING btree (organizationid, resourcetypeid, resourcename, deleted);


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
-- Name: resource_isactive; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_isactive ON abyss.resource USING btree (isactive);


--
-- Name: resource_resourcerefid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_resourcerefid ON abyss.resource USING btree (resourcerefid);


--
-- Name: resource_resourcetypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX resource_resourcetypeid ON abyss.resource USING btree (resourcetypeid);


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
-- Name: subject_distinguishedname; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_distinguishedname ON abyss.subject USING btree (distinguishedname);


--
-- Name: subject_email; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_email ON abyss.subject USING btree (email);


--
-- Name: subject_id; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_id ON abyss.subject USING btree (id);


--
-- Name: subject_membership_subjectdirectoryid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_membership_subjectdirectoryid ON abyss.subject_membership USING btree (subjectdirectoryid);


--
-- Name: subject_membership_subjectgroupid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_membership_subjectgroupid ON abyss.subject_membership USING btree (subjectgroupid);


--
-- Name: subject_membership_subjectgrouptypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_membership_subjectgrouptypeid ON abyss.subject_membership USING btree (subjectgrouptypeid);


--
-- Name: subject_membership_subjectid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_membership_subjectid ON abyss.subject_membership USING btree (subjectid);


--
-- Name: subject_membership_subjecttypeid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_membership_subjecttypeid ON abyss.subject_membership USING btree (subjecttypeid);


--
-- Name: subject_membership_unique_index; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_membership_unique_index ON abyss.subject_membership USING btree (deleted, isdeleted, subjectid, subjectgroupid, subjecttypeid, subjectgrouptypeid);


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
-- Name: subject_permission_permission; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_permission_permission ON abyss.subject_permission USING btree (permission);


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
-- Name: subject_uniqueid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subject_uniqueid ON abyss.subject USING btree (uniqueid);


--
-- Name: subject_uuid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE UNIQUE INDEX subject_uuid ON abyss.subject USING btree (uuid);


--
-- Name: subresource_action_resourceactionid; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subresource_action_resourceactionid ON abyss.subresource_action USING btree (resourceactionid);


--
-- Name: subresource_action_subresource; Type: INDEX; Schema: abyss; Owner: abyssuser
--

CREATE INDEX subresource_action_subresource ON abyss.subresource_action USING btree (subresource);

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
-- Name: subject_membership fk_o2m_subject_type__subject_membership; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_membership
    ADD CONSTRAINT fk_o2m_subject_type__subject_membership FOREIGN KEY (subjecttypeid) REFERENCES abyss.subject_type(uuid);


--
-- Name: subject_membership fk_o2m_subject_type__subject_membership2; Type: FK CONSTRAINT; Schema: abyss; Owner: abyssuser
--

ALTER TABLE ONLY abyss.subject_membership
    ADD CONSTRAINT fk_o2m_subject_type__subject_membership2 FOREIGN KEY (subjectgrouptypeid) REFERENCES abyss.subject_type(uuid);


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

