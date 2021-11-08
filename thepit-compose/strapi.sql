--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0 (Debian 14.0-1.pgdg110+1)
-- Dumped by pg_dump version 14.0 (Debian 14.0-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: core_store; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.core_store (
    id integer NOT NULL,
    key character varying(255),
    value text,
    type character varying(255),
    environment character varying(255),
    tag character varying(255)
);


ALTER TABLE public.core_store OWNER TO strapi;

--
-- Name: core_store_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.core_store_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.core_store_id_seq OWNER TO strapi;

--
-- Name: core_store_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.core_store_id_seq OWNED BY public.core_store.id;


--
-- Name: game_participants_results; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.game_participants_results (
    id integer NOT NULL,
    scheduled_game_participant integer,
    result character varying(255),
    published_at timestamp with time zone,
    created_by integer,
    updated_by integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.game_participants_results OWNER TO strapi;

--
-- Name: game_participants_results_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.game_participants_results_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.game_participants_results_id_seq OWNER TO strapi;

--
-- Name: game_participants_results_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.game_participants_results_id_seq OWNED BY public.game_participants_results.id;


--
-- Name: i18n_locales; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.i18n_locales (
    id integer NOT NULL,
    name character varying(255),
    code character varying(255),
    created_by integer,
    updated_by integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.i18n_locales OWNER TO strapi;

--
-- Name: i18n_locales_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.i18n_locales_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.i18n_locales_id_seq OWNER TO strapi;

--
-- Name: i18n_locales_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.i18n_locales_id_seq OWNED BY public.i18n_locales.id;


--
-- Name: scheduled_game_participants; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.scheduled_game_participants (
    id integer NOT NULL,
    nft_id character varying(255),
    scheduled_game integer,
    published_at timestamp with time zone,
    created_by integer,
    updated_by integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    game_participants_result integer,
    user_address character varying(255)
);


ALTER TABLE public.scheduled_game_participants OWNER TO strapi;

--
-- Name: scheduled_game_participants_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.scheduled_game_participants_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scheduled_game_participants_id_seq OWNER TO strapi;

--
-- Name: scheduled_game_participants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.scheduled_game_participants_id_seq OWNED BY public.scheduled_game_participants.id;


--
-- Name: scheduled_games; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.scheduled_games (
    id integer NOT NULL,
    game_date timestamp with time zone,
    published_at timestamp with time zone,
    created_by integer,
    updated_by integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.scheduled_games OWNER TO strapi;

--
-- Name: scheduled_games_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.scheduled_games_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.scheduled_games_id_seq OWNER TO strapi;

--
-- Name: scheduled_games_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.scheduled_games_id_seq OWNED BY public.scheduled_games.id;


--
-- Name: strapi_administrator; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_administrator (
    id integer NOT NULL,
    firstname character varying(255),
    lastname character varying(255),
    username character varying(255),
    email character varying(255) NOT NULL,
    password character varying(255),
    "resetPasswordToken" character varying(255),
    "registrationToken" character varying(255),
    "isActive" boolean,
    blocked boolean,
    "preferedLanguage" character varying(255)
);


ALTER TABLE public.strapi_administrator OWNER TO strapi;

--
-- Name: strapi_administrator_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_administrator_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_administrator_id_seq OWNER TO strapi;

--
-- Name: strapi_administrator_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_administrator_id_seq OWNED BY public.strapi_administrator.id;


--
-- Name: strapi_permission; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_permission (
    id integer NOT NULL,
    action character varying(255) NOT NULL,
    subject character varying(255),
    properties jsonb,
    conditions jsonb,
    role integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.strapi_permission OWNER TO strapi;

--
-- Name: strapi_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_permission_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_permission_id_seq OWNER TO strapi;

--
-- Name: strapi_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_permission_id_seq OWNED BY public.strapi_permission.id;


--
-- Name: strapi_role; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_role (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    code character varying(255) NOT NULL,
    description character varying(255),
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.strapi_role OWNER TO strapi;

--
-- Name: strapi_role_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_role_id_seq OWNER TO strapi;

--
-- Name: strapi_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_role_id_seq OWNED BY public.strapi_role.id;


--
-- Name: strapi_users_roles; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_users_roles (
    id integer NOT NULL,
    user_id integer,
    role_id integer
);


ALTER TABLE public.strapi_users_roles OWNER TO strapi;

--
-- Name: strapi_users_roles_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_users_roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_users_roles_id_seq OWNER TO strapi;

--
-- Name: strapi_users_roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_users_roles_id_seq OWNED BY public.strapi_users_roles.id;


--
-- Name: strapi_webhooks; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.strapi_webhooks (
    id integer NOT NULL,
    name character varying(255),
    url text,
    headers jsonb,
    events jsonb,
    enabled boolean
);


ALTER TABLE public.strapi_webhooks OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.strapi_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.strapi_webhooks_id_seq OWNER TO strapi;

--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.strapi_webhooks_id_seq OWNED BY public.strapi_webhooks.id;


--
-- Name: upload_file; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_file (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    "alternativeText" character varying(255),
    caption character varying(255),
    width integer,
    height integer,
    formats jsonb,
    hash character varying(255) NOT NULL,
    ext character varying(255),
    mime character varying(255) NOT NULL,
    size numeric(10,2) NOT NULL,
    url character varying(255) NOT NULL,
    "previewUrl" character varying(255),
    provider character varying(255) NOT NULL,
    provider_metadata jsonb,
    created_by integer,
    updated_by integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.upload_file OWNER TO strapi;

--
-- Name: upload_file_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_file_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_file_id_seq OWNER TO strapi;

--
-- Name: upload_file_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_file_id_seq OWNED BY public.upload_file.id;


--
-- Name: upload_file_morph; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public.upload_file_morph (
    id integer NOT NULL,
    upload_file_id integer,
    related_id integer,
    related_type text,
    field text,
    "order" integer
);


ALTER TABLE public.upload_file_morph OWNER TO strapi;

--
-- Name: upload_file_morph_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public.upload_file_morph_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.upload_file_morph_id_seq OWNER TO strapi;

--
-- Name: upload_file_morph_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public.upload_file_morph_id_seq OWNED BY public.upload_file_morph.id;


--
-- Name: users-permissions_permission; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public."users-permissions_permission" (
    id integer NOT NULL,
    type character varying(255) NOT NULL,
    controller character varying(255) NOT NULL,
    action character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    policy character varying(255),
    role integer,
    created_by integer,
    updated_by integer
);


ALTER TABLE public."users-permissions_permission" OWNER TO strapi;

--
-- Name: users-permissions_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public."users-permissions_permission_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."users-permissions_permission_id_seq" OWNER TO strapi;

--
-- Name: users-permissions_permission_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public."users-permissions_permission_id_seq" OWNED BY public."users-permissions_permission".id;


--
-- Name: users-permissions_role; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public."users-permissions_role" (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255),
    created_by integer,
    updated_by integer
);


ALTER TABLE public."users-permissions_role" OWNER TO strapi;

--
-- Name: users-permissions_role_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public."users-permissions_role_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."users-permissions_role_id_seq" OWNER TO strapi;

--
-- Name: users-permissions_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public."users-permissions_role_id_seq" OWNED BY public."users-permissions_role".id;


--
-- Name: users-permissions_user; Type: TABLE; Schema: public; Owner: strapi
--

CREATE TABLE public."users-permissions_user" (
    id integer NOT NULL,
    username character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    provider character varying(255),
    password character varying(255),
    "resetPasswordToken" character varying(255),
    "confirmationToken" character varying(255),
    confirmed boolean,
    blocked boolean,
    role integer,
    created_by integer,
    updated_by integer,
    created_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public."users-permissions_user" OWNER TO strapi;

--
-- Name: users-permissions_user_id_seq; Type: SEQUENCE; Schema: public; Owner: strapi
--

CREATE SEQUENCE public."users-permissions_user_id_seq"
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public."users-permissions_user_id_seq" OWNER TO strapi;

--
-- Name: users-permissions_user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: strapi
--

ALTER SEQUENCE public."users-permissions_user_id_seq" OWNED BY public."users-permissions_user".id;


--
-- Name: core_store id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.core_store ALTER COLUMN id SET DEFAULT nextval('public.core_store_id_seq'::regclass);


--
-- Name: game_participants_results id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.game_participants_results ALTER COLUMN id SET DEFAULT nextval('public.game_participants_results_id_seq'::regclass);


--
-- Name: i18n_locales id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locales ALTER COLUMN id SET DEFAULT nextval('public.i18n_locales_id_seq'::regclass);


--
-- Name: scheduled_game_participants id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.scheduled_game_participants ALTER COLUMN id SET DEFAULT nextval('public.scheduled_game_participants_id_seq'::regclass);


--
-- Name: scheduled_games id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.scheduled_games ALTER COLUMN id SET DEFAULT nextval('public.scheduled_games_id_seq'::regclass);


--
-- Name: strapi_administrator id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_administrator ALTER COLUMN id SET DEFAULT nextval('public.strapi_administrator_id_seq'::regclass);


--
-- Name: strapi_permission id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_permission ALTER COLUMN id SET DEFAULT nextval('public.strapi_permission_id_seq'::regclass);


--
-- Name: strapi_role id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_role ALTER COLUMN id SET DEFAULT nextval('public.strapi_role_id_seq'::regclass);


--
-- Name: strapi_users_roles id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_users_roles ALTER COLUMN id SET DEFAULT nextval('public.strapi_users_roles_id_seq'::regclass);


--
-- Name: strapi_webhooks id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks ALTER COLUMN id SET DEFAULT nextval('public.strapi_webhooks_id_seq'::regclass);


--
-- Name: upload_file id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_file ALTER COLUMN id SET DEFAULT nextval('public.upload_file_id_seq'::regclass);


--
-- Name: upload_file_morph id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_file_morph ALTER COLUMN id SET DEFAULT nextval('public.upload_file_morph_id_seq'::regclass);


--
-- Name: users-permissions_permission id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_permission" ALTER COLUMN id SET DEFAULT nextval('public."users-permissions_permission_id_seq"'::regclass);


--
-- Name: users-permissions_role id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_role" ALTER COLUMN id SET DEFAULT nextval('public."users-permissions_role_id_seq"'::regclass);


--
-- Name: users-permissions_user id; Type: DEFAULT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_user" ALTER COLUMN id SET DEFAULT nextval('public."users-permissions_user_id_seq"'::regclass);


--
-- Data for Name: core_store; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.core_store (id, key, value, type, environment, tag) FROM stdin;
15	plugin_content_manager_configuration_content_types::plugins::users-permissions.user	{"uid":"plugins::users-permissions.user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"username","defaultSortBy":"username","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"username":{"edit":{"label":"Username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Username","searchable":true,"sortable":true}},"email":{"edit":{"label":"Email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Email","searchable":true,"sortable":true}},"provider":{"edit":{"label":"Provider","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Provider","searchable":true,"sortable":true}},"password":{"edit":{"label":"Password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"ResetPasswordToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"ResetPasswordToken","searchable":true,"sortable":true}},"confirmationToken":{"edit":{"label":"ConfirmationToken","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"ConfirmationToken","searchable":true,"sortable":true}},"confirmed":{"edit":{"label":"Confirmed","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Confirmed","searchable":true,"sortable":true}},"blocked":{"edit":{"label":"Blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Blocked","searchable":true,"sortable":true}},"role":{"edit":{"label":"Role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"Role","searchable":true,"sortable":true}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","username","email","confirmed"],"editRelations":["role"],"edit":[[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"confirmed","size":4}],[{"name":"blocked","size":4}]]}}	object		
5	model_def_strapi::user	{"uid":"strapi::user","collectionName":"strapi_administrator","kind":"collectionType","info":{"name":"User","description":""},"options":{"timestamps":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"firstname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"lastname":{"type":"string","unique":false,"minLength":1,"configurable":false,"required":false},"username":{"type":"string","unique":false,"configurable":false,"required":false},"email":{"type":"email","minLength":6,"configurable":false,"required":true,"unique":true,"private":true},"password":{"type":"password","minLength":6,"configurable":false,"required":false,"private":true},"resetPasswordToken":{"type":"string","configurable":false,"private":true},"registrationToken":{"type":"string","configurable":false,"private":true},"isActive":{"type":"boolean","default":false,"configurable":false,"private":true},"roles":{"collection":"role","collectionName":"strapi_users_roles","via":"users","dominant":true,"plugin":"admin","configurable":false,"private":true,"attribute":"role","column":"id","isVirtual":true},"blocked":{"type":"boolean","default":false,"configurable":false,"private":true},"preferedLanguage":{"type":"string","configurable":false,"required":false}}}	object	\N	\N
6	model_def_plugins::users-permissions.permission	{"uid":"plugins::users-permissions.permission","collectionName":"users-permissions_permission","kind":"collectionType","info":{"name":"permission","description":""},"options":{"timestamps":false},"pluginOptions":{"content-manager":{"visible":false}},"attributes":{"type":{"type":"string","required":true,"configurable":false},"controller":{"type":"string","required":true,"configurable":false},"action":{"type":"string","required":true,"configurable":false},"enabled":{"type":"boolean","required":true,"configurable":false},"policy":{"type":"string","configurable":false},"role":{"model":"role","via":"permissions","plugin":"users-permissions","configurable":false},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
7	model_def_plugins::users-permissions.role	{"uid":"plugins::users-permissions.role","collectionName":"users-permissions_role","kind":"collectionType","info":{"name":"role","description":""},"options":{"timestamps":false},"pluginOptions":{"content-manager":{"visible":false}},"attributes":{"name":{"type":"string","minLength":3,"required":true,"configurable":false},"description":{"type":"string","configurable":false},"type":{"type":"string","unique":true,"configurable":false},"permissions":{"collection":"permission","via":"role","plugin":"users-permissions","configurable":false,"isVirtual":true},"users":{"collection":"user","via":"role","configurable":false,"plugin":"users-permissions","isVirtual":true},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
8	model_def_plugins::users-permissions.user	{"uid":"plugins::users-permissions.user","collectionName":"users-permissions_user","kind":"collectionType","info":{"name":"user","description":""},"options":{"draftAndPublish":false,"timestamps":["created_at","updated_at"]},"attributes":{"username":{"type":"string","minLength":3,"unique":true,"configurable":false,"required":true},"email":{"type":"email","minLength":6,"configurable":false,"required":true},"provider":{"type":"string","configurable":false},"password":{"type":"password","minLength":6,"configurable":false,"private":true},"resetPasswordToken":{"type":"string","configurable":false,"private":true},"confirmationToken":{"type":"string","configurable":false,"private":true},"confirmed":{"type":"boolean","default":false,"configurable":false},"blocked":{"type":"boolean","default":false,"configurable":false},"role":{"model":"role","via":"users","plugin":"users-permissions","configurable":false},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
2	model_def_strapi::webhooks	{"uid":"strapi::webhooks","collectionName":"strapi_webhooks","info":{"name":"Strapi webhooks","description":""},"options":{"timestamps":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string"},"url":{"type":"text"},"headers":{"type":"json"},"events":{"type":"json"},"enabled":{"type":"boolean"}}}	object	\N	\N
3	model_def_strapi::permission	{"uid":"strapi::permission","collectionName":"strapi_permission","kind":"collectionType","info":{"name":"Permission","description":""},"options":{"timestamps":["created_at","updated_at"]},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"action":{"type":"string","minLength":1,"configurable":false,"required":true},"subject":{"type":"string","minLength":1,"configurable":false,"required":false},"properties":{"type":"json","configurable":false,"required":false,"default":{}},"conditions":{"type":"json","configurable":false,"required":false,"default":[]},"role":{"configurable":false,"model":"role","plugin":"admin"}}}	object	\N	\N
11	plugin_users-permissions_grant	{"email":{"enabled":true,"icon":"envelope"},"discord":{"enabled":false,"icon":"discord","key":"","secret":"","callback":"/auth/discord/callback","scope":["identify","email"]},"facebook":{"enabled":false,"icon":"facebook-square","key":"","secret":"","callback":"/auth/facebook/callback","scope":["email"]},"google":{"enabled":false,"icon":"google","key":"","secret":"","callback":"/auth/google/callback","scope":["email"]},"github":{"enabled":false,"icon":"github","key":"","secret":"","callback":"/auth/github/callback","scope":["user","user:email"]},"microsoft":{"enabled":false,"icon":"windows","key":"","secret":"","callback":"/auth/microsoft/callback","scope":["user.read"]},"twitter":{"enabled":false,"icon":"twitter","key":"","secret":"","callback":"/auth/twitter/callback"},"instagram":{"enabled":false,"icon":"instagram","key":"","secret":"","callback":"/auth/instagram/callback","scope":["user_profile"]},"vk":{"enabled":false,"icon":"vk","key":"","secret":"","callback":"/auth/vk/callback","scope":["email"]},"twitch":{"enabled":false,"icon":"twitch","key":"","secret":"","callback":"/auth/twitch/callback","scope":["user:read:email"]},"linkedin":{"enabled":false,"icon":"linkedin","key":"","secret":"","callback":"/auth/linkedin/callback","scope":["r_liteprofile","r_emailaddress"]},"cognito":{"enabled":false,"icon":"aws","key":"","secret":"","subdomain":"my.subdomain.com","callback":"/auth/cognito/callback","scope":["email","openid","profile"]},"reddit":{"enabled":false,"icon":"reddit","key":"","secret":"","state":true,"callback":"/auth/reddit/callback","scope":["identity"]},"auth0":{"enabled":false,"icon":"","key":"","secret":"","subdomain":"my-tenant.eu","callback":"/auth/auth0/callback","scope":["openid","email","profile"]},"cas":{"enabled":false,"icon":"book","key":"","secret":"","callback":"/auth/cas/callback","scope":["openid email"],"subdomain":"my.subdomain.com/cas"}}	object		
12	plugin_upload_settings	{"sizeOptimization":true,"responsiveDimensions":true}	object	development	
13	plugin_content_manager_configuration_content_types::strapi::permission	{"uid":"strapi::permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"action","defaultSortBy":"action","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"action":{"edit":{"label":"Action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Action","searchable":true,"sortable":true}},"subject":{"edit":{"label":"Subject","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Subject","searchable":true,"sortable":true}},"properties":{"edit":{"label":"Properties","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Properties","searchable":false,"sortable":false}},"conditions":{"edit":{"label":"Conditions","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Conditions","searchable":false,"sortable":false}},"role":{"edit":{"label":"Role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"Role","searchable":true,"sortable":true}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","action","subject","role"],"editRelations":["role"],"edit":[[{"name":"action","size":6},{"name":"subject","size":6}],[{"name":"properties","size":12}],[{"name":"conditions","size":12}]]}}	object		
14	plugin_content_manager_configuration_content_types::strapi::role	{"uid":"strapi::role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"name":{"edit":{"label":"Name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Name","searchable":true,"sortable":true}},"code":{"edit":{"label":"Code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Code","searchable":true,"sortable":true}},"description":{"edit":{"label":"Description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Description","searchable":true,"sortable":true}},"users":{"edit":{"label":"Users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"firstname"},"list":{"label":"Users","searchable":false,"sortable":false}},"permissions":{"edit":{"label":"Permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"action"},"list":{"label":"Permissions","searchable":false,"sortable":false}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","description"],"editRelations":["users","permissions"],"edit":[[{"name":"name","size":6},{"name":"code","size":6}],[{"name":"description","size":6}]]}}	object		
21	plugin_i18n_default_locale	"en"	string		
10	model_def_plugins::i18n.locale	{"uid":"plugins::i18n.locale","collectionName":"i18n_locales","kind":"collectionType","info":{"name":"locale","description":""},"options":{"timestamps":["created_at","updated_at"]},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","min":1,"max":50,"configurable":false},"code":{"type":"string","unique":true,"configurable":false},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
16	plugin_content_manager_configuration_content_types::plugins::users-permissions.role	{"uid":"plugins::users-permissions.role","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"name":{"edit":{"label":"Name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Name","searchable":true,"sortable":true}},"description":{"edit":{"label":"Description","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Description","searchable":true,"sortable":true}},"type":{"edit":{"label":"Type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Type","searchable":true,"sortable":true}},"permissions":{"edit":{"label":"Permissions","description":"","placeholder":"","visible":true,"editable":true,"mainField":"type"},"list":{"label":"Permissions","searchable":false,"sortable":false}},"users":{"edit":{"label":"Users","description":"","placeholder":"","visible":true,"editable":true,"mainField":"username"},"list":{"label":"Users","searchable":false,"sortable":false}}},"layouts":{"list":["id","name","description","type"],"editRelations":["permissions","users"],"edit":[[{"name":"name","size":6},{"name":"description","size":6}],[{"name":"type","size":6}]]}}	object		
17	plugin_content_manager_configuration_content_types::plugins::users-permissions.permission	{"uid":"plugins::users-permissions.permission","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"type","defaultSortBy":"type","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"type":{"edit":{"label":"Type","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Type","searchable":true,"sortable":true}},"controller":{"edit":{"label":"Controller","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Controller","searchable":true,"sortable":true}},"action":{"edit":{"label":"Action","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Action","searchable":true,"sortable":true}},"enabled":{"edit":{"label":"Enabled","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Enabled","searchable":true,"sortable":true}},"policy":{"edit":{"label":"Policy","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Policy","searchable":true,"sortable":true}},"role":{"edit":{"label":"Role","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"Role","searchable":true,"sortable":true}}},"layouts":{"list":["id","type","controller","action"],"editRelations":["role"],"edit":[[{"name":"type","size":6},{"name":"controller","size":6}],[{"name":"action","size":6},{"name":"enabled","size":4}],[{"name":"policy","size":6}]]}}	object		
18	plugin_content_manager_configuration_content_types::strapi::user	{"uid":"strapi::user","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"firstname","defaultSortBy":"firstname","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"firstname":{"edit":{"label":"Firstname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Firstname","searchable":true,"sortable":true}},"lastname":{"edit":{"label":"Lastname","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Lastname","searchable":true,"sortable":true}},"username":{"edit":{"label":"Username","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Username","searchable":true,"sortable":true}},"email":{"edit":{"label":"Email","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Email","searchable":true,"sortable":true}},"password":{"edit":{"label":"Password","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Password","searchable":true,"sortable":true}},"resetPasswordToken":{"edit":{"label":"ResetPasswordToken","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"ResetPasswordToken","searchable":true,"sortable":true}},"registrationToken":{"edit":{"label":"RegistrationToken","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"RegistrationToken","searchable":true,"sortable":true}},"isActive":{"edit":{"label":"IsActive","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"IsActive","searchable":true,"sortable":true}},"roles":{"edit":{"label":"Roles","description":"","placeholder":"","visible":true,"editable":true,"mainField":"name"},"list":{"label":"Roles","searchable":false,"sortable":false}},"blocked":{"edit":{"label":"Blocked","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Blocked","searchable":true,"sortable":true}},"preferedLanguage":{"edit":{"label":"PreferedLanguage","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"PreferedLanguage","searchable":true,"sortable":true}}},"layouts":{"list":["id","firstname","lastname","username"],"editRelations":["roles"],"edit":[[{"name":"firstname","size":6},{"name":"lastname","size":6}],[{"name":"username","size":6},{"name":"email","size":6}],[{"name":"password","size":6},{"name":"resetPasswordToken","size":6}],[{"name":"registrationToken","size":6},{"name":"isActive","size":4}],[{"name":"blocked","size":4},{"name":"preferedLanguage","size":6}]]}}	object		
19	plugin_content_manager_configuration_content_types::plugins::upload.file	{"uid":"plugins::upload.file","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"name":{"edit":{"label":"Name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Name","searchable":true,"sortable":true}},"alternativeText":{"edit":{"label":"AlternativeText","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"AlternativeText","searchable":true,"sortable":true}},"caption":{"edit":{"label":"Caption","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Caption","searchable":true,"sortable":true}},"width":{"edit":{"label":"Width","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Width","searchable":true,"sortable":true}},"height":{"edit":{"label":"Height","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Height","searchable":true,"sortable":true}},"formats":{"edit":{"label":"Formats","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Formats","searchable":false,"sortable":false}},"hash":{"edit":{"label":"Hash","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Hash","searchable":true,"sortable":true}},"ext":{"edit":{"label":"Ext","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Ext","searchable":true,"sortable":true}},"mime":{"edit":{"label":"Mime","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Mime","searchable":true,"sortable":true}},"size":{"edit":{"label":"Size","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Size","searchable":true,"sortable":true}},"url":{"edit":{"label":"Url","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Url","searchable":true,"sortable":true}},"previewUrl":{"edit":{"label":"PreviewUrl","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"PreviewUrl","searchable":true,"sortable":true}},"provider":{"edit":{"label":"Provider","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Provider","searchable":true,"sortable":true}},"provider_metadata":{"edit":{"label":"Provider_metadata","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Provider_metadata","searchable":false,"sortable":false}},"related":{"edit":{"label":"Related","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Related","searchable":false,"sortable":false}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","alternativeText","caption"],"editRelations":["related"],"edit":[[{"name":"name","size":6},{"name":"alternativeText","size":6}],[{"name":"caption","size":6},{"name":"width","size":4}],[{"name":"height","size":4}],[{"name":"formats","size":12}],[{"name":"hash","size":6},{"name":"ext","size":6}],[{"name":"mime","size":6},{"name":"size","size":4}],[{"name":"url","size":6},{"name":"previewUrl","size":6}],[{"name":"provider","size":6}],[{"name":"provider_metadata","size":12}]]}}	object		
24	core_admin_auth	{"providers":{"autoRegister":false,"defaultRole":null}}	object		
20	plugin_content_manager_configuration_content_types::plugins::i18n.locale	{"uid":"plugins::i18n.locale","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"name","defaultSortBy":"name","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"name":{"edit":{"label":"Name","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Name","searchable":true,"sortable":true}},"code":{"edit":{"label":"Code","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Code","searchable":true,"sortable":true}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","name","code","created_at"],"editRelations":[],"edit":[[{"name":"name","size":6},{"name":"code","size":6}]]}}	object		
22	plugin_users-permissions_email	{"reset_password":{"display":"Email.template.reset_password","icon":"sync","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Reset password","message":"<p>We heard that you lost your password. Sorry about that!</p>\\n\\n<p>But don’t worry! You can use the following link to reset your password:</p>\\n<p><%= URL %>?code=<%= TOKEN %></p>\\n\\n<p>Thanks.</p>"}},"email_confirmation":{"display":"Email.template.email_confirmation","icon":"check-square","options":{"from":{"name":"Administration Panel","email":"no-reply@strapi.io"},"response_email":"","object":"Account confirmation","message":"<p>Thank you for registering!</p>\\n\\n<p>You have to confirm your email address. Please click on the link below.</p>\\n\\n<p><%= URL %>?confirmation=<%= CODE %></p>\\n\\n<p>Thanks.</p>"}}}	object		
23	plugin_users-permissions_advanced	{"unique_email":true,"allow_register":true,"email_confirmation":false,"email_reset_password":null,"email_confirmation_redirection":null,"default_role":"authenticated"}	object		
27	model_def_application::scheduled-game-participants.scheduled-game-participants	{"uid":"application::scheduled-game-participants.scheduled-game-participants","collectionName":"scheduled_game_participants","kind":"collectionType","info":{"name":"Scheduled_game_participants","description":""},"options":{"increments":true,"timestamps":["created_at","updated_at"],"draftAndPublish":true},"pluginOptions":{},"attributes":{"scheduled_game":{"model":"scheduled-games","via":"scheduled_game_participants"},"game_participants_result":{"via":"scheduled_game_participant","model":"game-participants-results"},"nft_id":{"type":"string"},"user_address":{"type":"string"},"published_at":{"type":"datetime","configurable":false,"writable":true,"visible":false},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
28	plugin_content_manager_configuration_content_types::application::scheduled-game-participants.scheduled-game-participants	{"uid":"application::scheduled-game-participants.scheduled-game-participants","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"scheduled_game":{"edit":{"label":"Scheduled_game","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"Scheduled_game","searchable":true,"sortable":true}},"game_participants_result":{"edit":{"label":"Game_participants_result","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"Game_participants_result","searchable":true,"sortable":true}},"nft_id":{"edit":{"label":"Nft_id","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Nft_id","searchable":true,"sortable":true}},"user_address":{"edit":{"label":"User_address","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"User_address","searchable":true,"sortable":true}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","nft_id","scheduled_game","created_at"],"edit":[[{"name":"nft_id","size":6},{"name":"user_address","size":6}]],"editRelations":["scheduled_game","game_participants_result"]}}	object		
4	model_def_strapi::role	{"uid":"strapi::role","collectionName":"strapi_role","kind":"collectionType","info":{"name":"Role","description":""},"options":{"timestamps":["created_at","updated_at"]},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"code":{"type":"string","minLength":1,"unique":true,"configurable":false,"required":true},"description":{"type":"string","configurable":false},"users":{"configurable":false,"collection":"user","via":"roles","plugin":"admin","attribute":"user","column":"id","isVirtual":true},"permissions":{"configurable":false,"plugin":"admin","collection":"permission","via":"role","isVirtual":true}}}	object	\N	\N
1	model_def_strapi::core-store	{"uid":"strapi::core-store","collectionName":"core_store","info":{"name":"core_store","description":""},"options":{"timestamps":false},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"key":{"type":"string"},"value":{"type":"text"},"type":{"type":"string"},"environment":{"type":"string"},"tag":{"type":"string"}}}	object	\N	\N
26	plugin_content_manager_configuration_content_types::application::scheduled-games.scheduled-games	{"uid":"application::scheduled-games.scheduled-games","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"game_date":{"edit":{"label":"Game_date","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Game_date","searchable":true,"sortable":true}},"scheduled_game_participants":{"edit":{"label":"Scheduled_game_participants","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"Scheduled_game_participants","searchable":false,"sortable":false}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","game_date","created_at","updated_at"],"edit":[[{"name":"game_date","size":6}]],"editRelations":["scheduled_game_participants"]}}	object		
30	plugin_content_manager_configuration_content_types::application::game-participants-results.game-participants-results	{"uid":"application::game-participants-results.game-participants-results","settings":{"bulkable":true,"filterable":true,"searchable":true,"pageSize":10,"mainField":"id","defaultSortBy":"id","defaultSortOrder":"ASC"},"metadatas":{"id":{"edit":{},"list":{"label":"Id","searchable":true,"sortable":true}},"scheduled_game_participant":{"edit":{"label":"Scheduled_game_participant","description":"","placeholder":"","visible":true,"editable":true,"mainField":"id"},"list":{"label":"Scheduled_game_participant","searchable":true,"sortable":true}},"result":{"edit":{"label":"Result","description":"","placeholder":"","visible":true,"editable":true},"list":{"label":"Result","searchable":true,"sortable":true}},"created_at":{"edit":{"label":"Created_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Created_at","searchable":true,"sortable":true}},"updated_at":{"edit":{"label":"Updated_at","description":"","placeholder":"","visible":false,"editable":true},"list":{"label":"Updated_at","searchable":true,"sortable":true}}},"layouts":{"list":["id","scheduled_game_participant","result","created_at"],"editRelations":["scheduled_game_participant"],"edit":[[{"name":"result","size":6}]]}}	object		
29	model_def_application::game-participants-results.game-participants-results	{"uid":"application::game-participants-results.game-participants-results","collectionName":"game_participants_results","kind":"collectionType","info":{"name":"Game_participants_results"},"options":{"increments":true,"timestamps":["created_at","updated_at"],"draftAndPublish":true},"pluginOptions":{},"attributes":{"scheduled_game_participant":{"via":"game_participants_result","model":"scheduled-game-participants"},"result":{"type":"enumeration","enum":["died","won"]},"published_at":{"type":"datetime","configurable":false,"writable":true,"visible":false},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
25	model_def_application::scheduled-games.scheduled-games	{"uid":"application::scheduled-games.scheduled-games","collectionName":"scheduled_games","kind":"collectionType","info":{"name":"Scheduled_games"},"options":{"increments":true,"timestamps":["created_at","updated_at"],"draftAndPublish":true},"pluginOptions":{},"attributes":{"game_date":{"type":"datetime"},"scheduled_game_participants":{"via":"scheduled_game","collection":"scheduled-game-participants","isVirtual":true},"published_at":{"type":"datetime","configurable":false,"writable":true,"visible":false},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
9	model_def_plugins::upload.file	{"uid":"plugins::upload.file","collectionName":"upload_file","kind":"collectionType","info":{"name":"file","description":""},"options":{"timestamps":["created_at","updated_at"]},"pluginOptions":{"content-manager":{"visible":false},"content-type-builder":{"visible":false}},"attributes":{"name":{"type":"string","configurable":false,"required":true},"alternativeText":{"type":"string","configurable":false},"caption":{"type":"string","configurable":false},"width":{"type":"integer","configurable":false},"height":{"type":"integer","configurable":false},"formats":{"type":"json","configurable":false},"hash":{"type":"string","configurable":false,"required":true},"ext":{"type":"string","configurable":false},"mime":{"type":"string","configurable":false,"required":true},"size":{"type":"decimal","configurable":false,"required":true},"url":{"type":"string","configurable":false,"required":true},"previewUrl":{"type":"string","configurable":false},"provider":{"type":"string","configurable":false,"required":true},"provider_metadata":{"type":"json","configurable":false},"related":{"collection":"*","filter":"field","configurable":false},"created_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true},"updated_by":{"model":"user","plugin":"admin","configurable":false,"writable":false,"visible":false,"private":true}}}	object	\N	\N
\.


--
-- Data for Name: game_participants_results; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.game_participants_results (id, scheduled_game_participant, result, published_at, created_by, updated_by, created_at, updated_at) FROM stdin;
679	\N	died	2021-11-08 10:18:19.99+00	\N	\N	2021-11-08 10:18:32.16+00	2021-11-08 10:18:32.402+00
989	\N	died	2021-11-08 10:18:32.81+00	\N	\N	2021-11-08 10:18:47.965+00	2021-11-08 10:18:48.054+00
991	\N	died	2021-11-08 10:18:32.821+00	\N	\N	2021-11-08 10:18:48.049+00	2021-11-08 10:18:48.086+00
993	\N	died	2021-11-08 10:18:32.835+00	\N	\N	2021-11-08 10:18:48.081+00	2021-11-08 10:18:48.158+00
3058	\N	died	2021-11-08 10:18:41.199+00	\N	\N	2021-11-08 10:19:32.223+00	2021-11-08 10:19:32.334+00
997	\N	died	2021-11-08 10:18:32.853+00	\N	\N	2021-11-08 10:18:48.154+00	2021-11-08 10:18:48.27+00
4204	\N	died	2021-11-08 10:19:00.948+00	\N	\N	2021-11-08 10:19:58.393+00	2021-11-08 10:19:58.663+00
1001	\N	died	2021-11-08 10:18:32.874+00	\N	\N	2021-11-08 10:18:48.266+00	2021-11-08 10:18:48.385+00
1008	\N	died	2021-11-08 10:18:32.894+00	\N	\N	2021-11-08 10:18:48.379+00	2021-11-08 10:18:48.437+00
1011	\N	died	2021-11-08 10:18:32.92+00	\N	\N	2021-11-08 10:18:48.432+00	2021-11-08 10:18:48.574+00
4214	\N	died	2021-11-08 10:19:01.181+00	\N	\N	2021-11-08 10:19:58.659+00	2021-11-08 10:19:58.697+00
1017	\N	died	2021-11-08 10:18:32.938+00	\N	\N	2021-11-08 10:18:48.569+00	2021-11-08 10:18:48.645+00
1021	\N	died	2021-11-08 10:18:32.96+00	\N	\N	2021-11-08 10:18:48.642+00	2021-11-08 10:18:48.78+00
1026	\N	died	2021-11-08 10:18:32.981+00	\N	\N	2021-11-08 10:18:48.773+00	2021-11-08 10:18:48.811+00
4216	\N	died	2021-11-08 10:19:01.231+00	\N	\N	2021-11-08 10:19:58.692+00	2021-11-08 10:19:58.77+00
1028	\N	died	2021-11-08 10:18:32.991+00	\N	\N	2021-11-08 10:18:48.808+00	2021-11-08 10:18:49.013+00
1037	\N	died	2021-11-08 10:18:33.041+00	\N	\N	2021-11-08 10:18:49.008+00	2021-11-08 10:18:49.07+00
1040	\N	died	2021-11-08 10:18:33.058+00	\N	\N	2021-11-08 10:18:49.065+00	2021-11-08 10:18:49.099+00
4218	\N	died	2021-11-08 10:19:01.267+00	\N	\N	2021-11-08 10:19:58.766+00	2021-11-08 10:19:58.89+00
1042	\N	died	2021-11-08 10:18:33.063+00	\N	\N	2021-11-08 10:18:49.095+00	2021-11-08 10:18:49.224+00
5346	\N	died	2021-11-08 10:19:45.272+00	\N	\N	2021-11-08 10:20:32.204+00	2021-11-08 10:20:32.395+00
1046	\N	died	2021-11-08 10:18:33.081+00	\N	\N	2021-11-08 10:18:49.219+00	2021-11-08 10:18:49.3+00
1050	\N	died	2021-11-08 10:18:33.103+00	\N	\N	2021-11-08 10:18:49.294+00	2021-11-08 10:18:49.393+00
4222	\N	died	2021-11-08 10:19:01.34+00	\N	\N	2021-11-08 10:19:58.885+00	2021-11-08 10:19:58.953+00
1053	\N	died	2021-11-08 10:18:33.113+00	\N	\N	2021-11-08 10:18:49.388+00	2021-11-08 10:18:49.495+00
1059	\N	died	2021-11-08 10:18:33.135+00	\N	\N	2021-11-08 10:18:49.487+00	2021-11-08 10:18:49.662+00
1066	\N	died	2021-11-08 10:18:33.176+00	\N	\N	2021-11-08 10:18:49.658+00	2021-11-08 10:18:49.705+00
4226	\N	died	2021-11-08 10:19:01.484+00	\N	\N	2021-11-08 10:19:58.949+00	2021-11-08 10:19:59.071+00
1068	\N	died	2021-11-08 10:18:33.187+00	\N	\N	2021-11-08 10:18:49.699+00	2021-11-08 10:18:49.777+00
1073	\N	died	2021-11-08 10:18:33.198+00	\N	\N	2021-11-08 10:18:49.774+00	2021-11-08 10:18:49.902+00
1077	\N	died	2021-11-08 10:18:33.216+00	\N	\N	2021-11-08 10:18:49.895+00	2021-11-08 10:18:49.956+00
4230	\N	died	2021-11-08 10:19:01.658+00	\N	\N	2021-11-08 10:19:59.067+00	2021-11-08 10:19:59.171+00
1080	\N	died	2021-11-08 10:18:33.228+00	\N	\N	2021-11-08 10:18:49.952+00	2021-11-08 10:18:50.119+00
5352	\N	died	2021-11-08 10:19:45.339+00	\N	\N	2021-11-08 10:20:32.389+00	2021-11-08 10:20:32.666+00
1087	\N	died	2021-11-08 10:18:33.261+00	\N	\N	2021-11-08 10:18:50.115+00	2021-11-08 10:18:50.186+00
1091	\N	died	2021-11-08 10:18:33.274+00	\N	\N	2021-11-08 10:18:50.18+00	2021-11-08 10:18:50.233+00
4235	\N	died	2021-11-08 10:19:01.724+00	\N	\N	2021-11-08 10:19:59.168+00	2021-11-08 10:19:59.205+00
1094	\N	died	2021-11-08 10:18:33.282+00	\N	\N	2021-11-08 10:18:50.229+00	2021-11-08 10:18:50.345+00
1098	\N	died	2021-11-08 10:18:33.308+00	\N	\N	2021-11-08 10:18:50.351+00	2021-11-08 10:18:50.618+00
4237	\N	died	2021-11-08 10:19:01.733+00	\N	\N	2021-11-08 10:19:59.202+00	2021-11-08 10:19:59.262+00
1110	\N	died	2021-11-08 10:18:33.371+00	\N	\N	2021-11-08 10:18:50.613+00	2021-11-08 10:18:50.84+00
4241	\N	died	2021-11-08 10:19:01.745+00	\N	\N	2021-11-08 10:19:59.258+00	2021-11-08 10:19:59.348+00
5362	\N	died	2021-11-08 10:19:45.491+00	\N	\N	2021-11-08 10:20:32.662+00	2021-11-08 10:20:32.699+00
4246	\N	died	2021-11-08 10:19:01.756+00	\N	\N	2021-11-08 10:19:59.344+00	2021-11-08 10:19:59.513+00
4253	\N	died	2021-11-08 10:19:01.81+00	\N	\N	2021-11-08 10:19:59.51+00	2021-11-08 10:19:59.546+00
4255	\N	died	2021-11-08 10:19:01.823+00	\N	\N	2021-11-08 10:19:59.543+00	2021-11-08 10:19:59.599+00
5364	\N	died	2021-11-08 10:19:45.522+00	\N	\N	2021-11-08 10:20:32.695+00	2021-11-08 10:20:32.771+00
4258	\N	died	2021-11-08 10:19:01.898+00	\N	\N	2021-11-08 10:19:59.593+00	2021-11-08 10:19:59.714+00
5363	\N	died	2021-11-08 10:19:45.505+00	\N	\N	2021-11-08 10:20:32.679+00	2021-11-08 10:20:32.771+00
4262	\N	died	2021-11-08 10:19:01.957+00	\N	\N	2021-11-08 10:19:59.71+00	2021-11-08 10:19:59.815+00
4268	\N	died	2021-11-08 10:19:02.173+00	\N	\N	2021-11-08 10:19:59.81+00	2021-11-08 10:19:59.971+00
4274	\N	died	2021-11-08 10:19:02.289+00	\N	\N	2021-11-08 10:19:59.968+00	2021-11-08 10:20:00.038+00
5367	\N	died	2021-11-08 10:19:45.589+00	\N	\N	2021-11-08 10:20:32.762+00	2021-11-08 10:20:32.954+00
4278	\N	died	2021-11-08 10:19:02.424+00	\N	\N	2021-11-08 10:20:00.034+00	2021-11-08 10:20:00.072+00
5371	\N	died	2021-11-08 10:19:45.723+00	\N	\N	2021-11-08 10:20:32.947+00	2021-11-08 10:20:33.174+00
5377	\N	died	2021-11-08 10:19:45.972+00	\N	\N	2021-11-08 10:20:33.164+00	2021-11-08 10:20:33.292+00
5369	\N	died	2021-11-08 10:19:45.622+00	\N	\N	2021-11-08 10:20:32.904+00	2021-11-08 10:20:33.292+00
5370	\N	died	2021-11-08 10:19:45.705+00	\N	\N	2021-11-08 10:20:32.925+00	2021-11-08 10:20:33.292+00
5384	\N	died	2021-11-08 10:19:46.331+00	\N	\N	2021-11-08 10:20:33.287+00	2021-11-08 10:20:33.353+00
5374	\N	died	2021-11-08 10:19:45.774+00	\N	\N	2021-11-08 10:20:33.004+00	2021-11-08 10:20:33.353+00
5386	\N	died	2021-11-08 10:19:46.466+00	\N	\N	2021-11-08 10:20:33.339+00	2021-11-08 10:20:33.392+00
5388	\N	died	2021-11-08 10:19:46.497+00	\N	\N	2021-11-08 10:20:33.387+00	2021-11-08 10:20:33.495+00
680	\N	died	2021-11-08 10:18:20.046+00	\N	\N	2021-11-08 10:18:32.262+00	2021-11-08 10:18:32.614+00
686	\N	died	2021-11-08 10:18:20.423+00	\N	\N	2021-11-08 10:18:32.592+00	2021-11-08 10:18:32.872+00
691	\N	died	2021-11-08 10:18:20.732+00	\N	\N	2021-11-08 10:18:32.85+00	2021-11-08 10:18:33.016+00
3059	\N	died	2021-11-08 10:18:41.206+00	\N	\N	2021-11-08 10:19:32.256+00	2021-11-08 10:19:32.478+00
697	\N	died	2021-11-08 10:18:20.982+00	\N	\N	2021-11-08 10:18:33.138+00	2021-11-08 10:18:33.802+00
710	\N	died	2021-11-08 10:18:21.593+00	\N	\N	2021-11-08 10:18:33.911+00	2021-11-08 10:18:34.287+00
718	\N	died	2021-11-08 10:18:21.988+00	\N	\N	2021-11-08 10:18:34.361+00	2021-11-08 10:18:34.602+00
3070	\N	died	2021-11-08 10:18:41.228+00	\N	\N	2021-11-08 10:19:32.473+00	2021-11-08 10:19:32.712+00
722	\N	died	2021-11-08 10:18:22.232+00	\N	\N	2021-11-08 10:18:34.602+00	2021-11-08 10:18:34.959+00
732	\N	died	2021-11-08 10:18:22.771+00	\N	\N	2021-11-08 10:18:35.163+00	2021-11-08 10:18:35.471+00
737	\N	died	2021-11-08 10:18:23.061+00	\N	\N	2021-11-08 10:18:35.472+00	2021-11-08 10:18:35.824+00
3077	\N	died	2021-11-08 10:18:41.25+00	\N	\N	2021-11-08 10:19:32.708+00	2021-11-08 10:19:32.923+00
750	\N	died	2021-11-08 10:18:23.692+00	\N	\N	2021-11-08 10:18:36.181+00	2021-11-08 10:18:36.41+00
5347	\N	died	2021-11-08 10:19:45.288+00	\N	\N	2021-11-08 10:20:32.275+00	2021-11-08 10:20:32.666+00
755	\N	died	2021-11-08 10:18:23.934+00	\N	\N	2021-11-08 10:18:36.439+00	2021-11-08 10:18:36.63+00
761	\N	died	2021-11-08 10:18:24.275+00	\N	\N	2021-11-08 10:18:36.783+00	2021-11-08 10:18:37.369+00
3082	\N	died	2021-11-08 10:18:41.259+00	\N	\N	2021-11-08 10:19:32.92+00	2021-11-08 10:19:32.964+00
773	\N	died	2021-11-08 10:18:24.903+00	\N	\N	2021-11-08 10:18:37.492+00	2021-11-08 10:18:37.952+00
787	\N	died	2021-11-08 10:18:25.566+00	\N	\N	2021-11-08 10:18:38.245+00	2021-11-08 10:18:38.521+00
795	\N	died	2021-11-08 10:18:26.051+00	\N	\N	2021-11-08 10:18:38.742+00	2021-11-08 10:18:40.033+00
3085	\N	died	2021-11-08 10:18:41.265+00	\N	\N	2021-11-08 10:19:32.96+00	2021-11-08 10:19:33.065+00
808	\N	died	2021-11-08 10:18:27.049+00	\N	\N	2021-11-08 10:18:40.02+00	2021-11-08 10:18:40.522+00
815	\N	died	2021-11-08 10:18:27.454+00	\N	\N	2021-11-08 10:18:40.553+00	2021-11-08 10:18:40.834+00
824	\N	died	2021-11-08 10:18:27.997+00	\N	\N	2021-11-08 10:18:41.181+00	2021-11-08 10:18:41.412+00
3091	\N	died	2021-11-08 10:18:41.28+00	\N	\N	2021-11-08 10:19:33.06+00	2021-11-08 10:19:33.182+00
828	\N	died	2021-11-08 10:18:28.239+00	\N	\N	2021-11-08 10:18:41.443+00	2021-11-08 10:18:41.89+00
5357	\N	died	2021-11-08 10:19:45.391+00	\N	\N	2021-11-08 10:20:32.572+00	2021-11-08 10:20:32.983+00
840	\N	died	2021-11-08 10:18:29.23+00	\N	\N	2021-11-08 10:18:42.543+00	2021-11-08 10:18:42.699+00
856	\N	died	2021-11-08 10:18:30.55+00	\N	\N	2021-11-08 10:18:44.113+00	2021-11-08 10:18:44.504+00
3095	\N	died	2021-11-08 10:18:41.287+00	\N	\N	2021-11-08 10:19:33.179+00	2021-11-08 10:19:33.278+00
867	\N	died	2021-11-08 10:18:31.051+00	\N	\N	2021-11-08 10:18:44.584+00	2021-11-08 10:18:45.008+00
879	\N	died	2021-11-08 10:18:31.186+00	\N	\N	2021-11-08 10:18:45.005+00	2021-11-08 10:18:45.218+00
888	\N	died	2021-11-08 10:18:31.241+00	\N	\N	2021-11-08 10:18:45.215+00	2021-11-08 10:18:45.35+00
3101	\N	died	2021-11-08 10:18:41.301+00	\N	\N	2021-11-08 10:19:33.274+00	2021-11-08 10:19:33.307+00
893	\N	died	2021-11-08 10:18:31.28+00	\N	\N	2021-11-08 10:18:45.346+00	2021-11-08 10:18:45.388+00
3103	\N	died	2021-11-08 10:18:41.301+00	\N	\N	2021-11-08 10:19:33.304+00	2021-11-08 10:19:33.491+00
5372	\N	died	2021-11-08 10:19:45.739+00	\N	\N	2021-11-08 10:20:32.968+00	2021-11-08 10:20:33.292+00
3110	\N	died	2021-11-08 10:18:41.324+00	\N	\N	2021-11-08 10:19:33.487+00	2021-11-08 10:19:33.656+00
3117	\N	died	2021-11-08 10:18:41.339+00	\N	\N	2021-11-08 10:19:33.652+00	2021-11-08 10:19:33.69+00
3119	\N	died	2021-11-08 10:18:41.348+00	\N	\N	2021-11-08 10:19:33.686+00	2021-11-08 10:19:33.825+00
3109	\N	died	2021-11-08 10:18:41.324+00	\N	\N	2021-11-08 10:19:33.443+00	2021-11-08 10:19:33.825+00
5381	\N	died	2021-11-08 10:19:46.264+00	\N	\N	2021-11-08 10:20:33.237+00	2021-11-08 10:20:33.577+00
3124	\N	died	2021-11-08 10:18:41.356+00	\N	\N	2021-11-08 10:19:33.82+00	2021-11-08 10:19:33.925+00
3130	\N	died	2021-11-08 10:18:41.371+00	\N	\N	2021-11-08 10:19:33.921+00	2021-11-08 10:19:34.089+00
3137	\N	died	2021-11-08 10:18:41.387+00	\N	\N	2021-11-08 10:19:34.085+00	2021-11-08 10:19:34.122+00
5398	\N	died	2021-11-08 10:19:46.706+00	\N	\N	2021-11-08 10:20:33.571+00	2021-11-08 10:20:33.666+00
3139	\N	died	2021-11-08 10:18:41.4+00	\N	\N	2021-11-08 10:19:34.117+00	2021-11-08 10:19:34.182+00
5404	\N	died	2021-11-08 10:19:46.747+00	\N	\N	2021-11-08 10:20:33.662+00	2021-11-08 10:20:33.716+00
5408	\N	died	2021-11-08 10:19:46.752+00	\N	\N	2021-11-08 10:20:33.712+00	2021-11-08 10:20:33.77+00
5410	\N	died	2021-11-08 10:19:46.754+00	\N	\N	2021-11-08 10:20:33.764+00	2021-11-08 10:20:33.867+00
5416	\N	died	2021-11-08 10:19:46.765+00	\N	\N	2021-11-08 10:20:33.862+00	2021-11-08 10:20:34.026+00
5422	\N	died	2021-11-08 10:19:46.826+00	\N	\N	2021-11-08 10:20:34.021+00	2021-11-08 10:20:34.104+00
5425	\N	died	2021-11-08 10:19:46.832+00	\N	\N	2021-11-08 10:20:34.089+00	2021-11-08 10:20:34.144+00
681	\N	died	2021-11-08 10:18:20.115+00	\N	\N	2021-11-08 10:18:32.335+00	2021-11-08 10:18:32.439+00
690	\N	died	2021-11-08 10:18:20.691+00	\N	\N	2021-11-08 10:18:32.803+00	2021-11-08 10:18:33.38+00
706	\N	died	2021-11-08 10:18:21.377+00	\N	\N	2021-11-08 10:18:33.613+00	2021-11-08 10:18:34.23+00
3060	\N	died	2021-11-08 10:18:41.206+00	\N	\N	2021-11-08 10:19:32.27+00	2021-11-08 10:19:32.712+00
714	\N	died	2021-11-08 10:18:21.766+00	\N	\N	2021-11-08 10:18:34.094+00	2021-11-08 10:18:34.631+00
724	\N	died	2021-11-08 10:18:22.332+00	\N	\N	2021-11-08 10:18:34.698+00	2021-11-08 10:18:35.193+00
733	\N	died	2021-11-08 10:18:22.814+00	\N	\N	2021-11-08 10:18:35.201+00	2021-11-08 10:18:35.689+00
3074	\N	died	2021-11-08 10:18:41.234+00	\N	\N	2021-11-08 10:19:32.54+00	2021-11-08 10:19:33.065+00
742	\N	died	2021-11-08 10:18:23.297+00	\N	\N	2021-11-08 10:18:35.702+00	2021-11-08 10:18:35.896+00
751	\N	died	2021-11-08 10:18:23.756+00	\N	\N	2021-11-08 10:18:36.249+00	2021-11-08 10:18:37.026+00
766	\N	died	2021-11-08 10:18:24.5+00	\N	\N	2021-11-08 10:18:37.039+00	2021-11-08 10:18:37.442+00
3088	\N	died	2021-11-08 10:18:41.271+00	\N	\N	2021-11-08 10:19:33.01+00	2021-11-08 10:19:33.278+00
771	\N	died	2021-11-08 10:18:24.808+00	\N	\N	2021-11-08 10:18:37.413+00	2021-11-08 10:18:37.808+00
5348	\N	died	2021-11-08 10:19:45.29+00	\N	\N	2021-11-08 10:20:32.306+00	2021-11-08 10:20:32.666+00
779	\N	died	2021-11-08 10:18:25.213+00	\N	\N	2021-11-08 10:18:37.833+00	2021-11-08 10:18:38.212+00
785	\N	died	2021-11-08 10:18:25.465+00	\N	\N	2021-11-08 10:18:38.112+00	2021-11-08 10:18:39.206+00
3100	\N	died	2021-11-08 10:18:41.294+00	\N	\N	2021-11-08 10:19:33.26+00	2021-11-08 10:19:33.656+00
800	\N	died	2021-11-08 10:18:26.598+00	\N	\N	2021-11-08 10:18:39.389+00	2021-11-08 10:18:40.522+00
821	\N	died	2021-11-08 10:18:27.811+00	\N	\N	2021-11-08 10:18:40.943+00	2021-11-08 10:18:41.36+00
827	\N	died	2021-11-08 10:18:28.184+00	\N	\N	2021-11-08 10:18:41.377+00	2021-11-08 10:18:41.799+00
3115	\N	died	2021-11-08 10:18:41.339+00	\N	\N	2021-11-08 10:19:33.623+00	2021-11-08 10:19:33.925+00
851	\N	died	2021-11-08 10:18:30.199+00	\N	\N	2021-11-08 10:18:43.822+00	2021-11-08 10:18:44.317+00
860	\N	died	2021-11-08 10:18:30.816+00	\N	\N	2021-11-08 10:18:44.352+00	2021-11-08 10:18:44.76+00
870	\N	died	2021-11-08 10:18:31.107+00	\N	\N	2021-11-08 10:18:44.685+00	2021-11-08 10:18:45.218+00
3129	\N	died	2021-11-08 10:18:41.371+00	\N	\N	2021-11-08 10:19:33.907+00	2021-11-08 10:19:34.182+00
885	\N	died	2021-11-08 10:18:31.221+00	\N	\N	2021-11-08 10:18:45.165+00	2021-11-08 10:18:45.623+00
5355	\N	died	2021-11-08 10:19:45.374+00	\N	\N	2021-11-08 10:20:32.454+00	2021-11-08 10:20:32.891+00
906	\N	died	2021-11-08 10:18:31.351+00	\N	\N	2021-11-08 10:18:45.618+00	2021-11-08 10:18:46.181+00
916	\N	died	2021-11-08 10:18:31.692+00	\N	\N	2021-11-08 10:18:46.175+00	2021-11-08 10:18:46.23+00
3142	\N	died	2021-11-08 10:18:41.408+00	\N	\N	2021-11-08 10:19:34.165+00	2021-11-08 10:19:34.416+00
918	\N	died	2021-11-08 10:18:31.729+00	\N	\N	2021-11-08 10:18:46.221+00	2021-11-08 10:18:46.259+00
5418	\N	died	2021-11-08 10:19:46.781+00	\N	\N	2021-11-08 10:20:33.896+00	2021-11-08 10:20:34.257+00
921	\N	died	2021-11-08 10:18:31.798+00	\N	\N	2021-11-08 10:18:46.298+00	2021-11-08 10:18:46.425+00
3153	\N	died	2021-11-08 10:18:41.431+00	\N	\N	2021-11-08 10:19:34.397+00	2021-11-08 10:19:34.899+00
926	\N	died	2021-11-08 10:18:31.869+00	\N	\N	2021-11-08 10:18:46.422+00	2021-11-08 10:18:46.658+00
3177	\N	died	2021-11-08 10:18:41.492+00	\N	\N	2021-11-08 10:19:34.895+00	2021-11-08 10:19:35.119+00
5368	\N	died	2021-11-08 10:19:45.605+00	\N	\N	2021-11-08 10:20:32.873+00	2021-11-08 10:20:33.174+00
3187	\N	died	2021-11-08 10:18:41.521+00	\N	\N	2021-11-08 10:19:35.115+00	2021-11-08 10:19:35.148+00
3189	\N	died	2021-11-08 10:18:41.521+00	\N	\N	2021-11-08 10:19:35.144+00	2021-11-08 10:19:35.199+00
3192	\N	died	2021-11-08 10:18:41.529+00	\N	\N	2021-11-08 10:19:35.196+00	2021-11-08 10:19:35.262+00
5375	\N	died	2021-11-08 10:19:45.805+00	\N	\N	2021-11-08 10:20:33.041+00	2021-11-08 10:20:33.409+00
3196	\N	died	2021-11-08 10:18:41.542+00	\N	\N	2021-11-08 10:19:35.258+00	2021-11-08 10:19:35.424+00
3204	\N	died	2021-11-08 10:18:41.568+00	\N	\N	2021-11-08 10:19:35.419+00	2021-11-08 10:19:35.474+00
3207	\N	died	2021-11-08 10:18:41.577+00	\N	\N	2021-11-08 10:19:35.47+00	2021-11-08 10:19:35.539+00
5389	\N	died	2021-11-08 10:19:46.514+00	\N	\N	2021-11-08 10:20:33.404+00	2021-11-08 10:20:33.561+00
5458	\N	died	2021-11-08 10:19:46.948+00	\N	\N	2021-11-08 10:20:34.846+00	2021-11-08 10:20:34.925+00
3211	\N	died	2021-11-08 10:18:41.585+00	\N	\N	2021-11-08 10:19:35.536+00	2021-11-08 10:19:35.569+00
5395	\N	died	2021-11-08 10:19:46.67+00	\N	\N	2021-11-08 10:20:33.521+00	2021-11-08 10:20:33.784+00
5411	\N	died	2021-11-08 10:19:46.755+00	\N	\N	2021-11-08 10:20:33.779+00	2021-11-08 10:20:34.026+00
5432	\N	died	2021-11-08 10:19:46.906+00	\N	\N	2021-11-08 10:20:34.221+00	2021-11-08 10:20:34.854+00
5463	\N	died	2021-11-08 10:19:47.014+00	\N	\N	2021-11-08 10:20:34.92+00	2021-11-08 10:20:35.024+00
5465	\N	died	2021-11-08 10:19:47.035+00	\N	\N	2021-11-08 10:20:35.007+00	2021-11-08 10:20:35.1+00
5468	\N	died	2021-11-08 10:19:47.064+00	\N	\N	2021-11-08 10:20:35.081+00	2021-11-08 10:20:35.352+00
5478	\N	died	2021-11-08 10:19:47.397+00	\N	\N	2021-11-08 10:20:35.346+00	2021-11-08 10:20:35.403+00
5480	\N	died	2021-11-08 10:19:47.431+00	\N	\N	2021-11-08 10:20:35.389+00	2021-11-08 10:20:35.445+00
876	\N	died	2021-11-08 10:18:31.142+00	\N	\N	2021-11-08 10:18:44.9+00	2021-11-08 10:18:45.029+00
682	\N	died	2021-11-08 10:18:20.166+00	\N	\N	2021-11-08 10:18:32.381+00	2021-11-08 10:18:32.614+00
688	\N	died	2021-11-08 10:18:20.614+00	\N	\N	2021-11-08 10:18:32.722+00	2021-11-08 10:18:33.225+00
696	\N	died	2021-11-08 10:18:20.935+00	\N	\N	2021-11-08 10:18:33.09+00	2021-11-08 10:18:33.635+00
880	\N	died	2021-11-08 10:18:31.193+00	\N	\N	2021-11-08 10:18:45.026+00	2021-11-08 10:18:45.35+00
709	\N	died	2021-11-08 10:18:21.513+00	\N	\N	2021-11-08 10:18:33.785+00	2021-11-08 10:18:34.23+00
3171	\N	died	2021-11-08 10:18:41.482+00	\N	\N	2021-11-08 10:19:34.798+00	2021-11-08 10:19:35.119+00
723	\N	died	2021-11-08 10:18:22.27+00	\N	\N	2021-11-08 10:18:34.646+00	2021-11-08 10:18:35.055+00
734	\N	died	2021-11-08 10:18:22.861+00	\N	\N	2021-11-08 10:18:35.262+00	2021-11-08 10:18:35.824+00
890	\N	died	2021-11-08 10:18:31.251+00	\N	\N	2021-11-08 10:18:45.248+00	2021-11-08 10:18:45.505+00
745	\N	died	2021-11-08 10:18:23.431+00	\N	\N	2021-11-08 10:18:35.869+00	2021-11-08 10:18:36.207+00
756	\N	died	2021-11-08 10:18:24.012+00	\N	\N	2021-11-08 10:18:36.513+00	2021-11-08 10:18:36.919+00
763	\N	died	2021-11-08 10:18:24.378+00	\N	\N	2021-11-08 10:18:36.897+00	2021-11-08 10:18:37.073+00
902	\N	died	2021-11-08 10:18:31.317+00	\N	\N	2021-11-08 10:18:45.499+00	2021-11-08 10:18:45.647+00
769	\N	died	2021-11-08 10:18:24.617+00	\N	\N	2021-11-08 10:18:37.202+00	2021-11-08 10:18:37.808+00
3061	\N	died	2021-11-08 10:18:41.206+00	\N	\N	2021-11-08 10:19:32.286+00	2021-11-08 10:19:32.923+00
777	\N	died	2021-11-08 10:18:25.125+00	\N	\N	2021-11-08 10:18:37.739+00	2021-11-08 10:18:38.267+00
907	\N	died	2021-11-08 10:18:31.37+00	\N	\N	2021-11-08 10:18:45.641+00	2021-11-08 10:18:46.181+00
793	\N	died	2021-11-08 10:18:25.883+00	\N	\N	2021-11-08 10:18:38.606+00	2021-11-08 10:18:39.206+00
797	\N	died	2021-11-08 10:18:26.407+00	\N	\N	2021-11-08 10:18:39.182+00	2021-11-08 10:18:39.282+00
411	\N	died	2021-11-08 10:18:09.148+00	\N	\N	2021-11-08 10:18:19.053+00	2021-11-08 10:18:19.51+00
801	\N	died	2021-11-08 10:18:26.634+00	\N	\N	2021-11-08 10:18:39.422+00	2021-11-08 10:18:40.522+00
816	\N	died	2021-11-08 10:18:27.534+00	\N	\N	2021-11-08 10:18:40.633+00	2021-11-08 10:18:40.745+00
917	\N	died	2021-11-08 10:18:31.699+00	\N	\N	2021-11-08 10:18:46.185+00	2021-11-08 10:18:46.402+00
818	\N	died	2021-11-08 10:18:27.652+00	\N	\N	2021-11-08 10:18:40.754+00	2021-11-08 10:18:41.211+00
823	\N	died	2021-11-08 10:18:27.924+00	\N	\N	2021-11-08 10:18:41.086+00	2021-11-08 10:18:41.48+00
836	\N	died	2021-11-08 10:18:28.888+00	\N	\N	2021-11-08 10:18:42.179+00	2021-11-08 10:18:42.574+00
924	\N	died	2021-11-08 10:18:31.852+00	\N	\N	2021-11-08 10:18:46.393+00	2021-11-08 10:18:46.658+00
846	\N	died	2021-11-08 10:18:29.759+00	\N	\N	2021-11-08 10:18:43.042+00	2021-11-08 10:18:43.964+00
3080	\N	died	2021-11-08 10:18:41.258+00	\N	\N	2021-11-08 10:19:32.839+00	2021-11-08 10:19:33.082+00
855	\N	died	2021-11-08 10:18:30.5+00	\N	\N	2021-11-08 10:18:44.06+00	2021-11-08 10:18:44.479+00
863	\N	died	2021-11-08 10:18:30.978+00	\N	\N	2021-11-08 10:18:44.505+00	2021-11-08 10:18:44.797+00
873	\N	died	2021-11-08 10:18:31.124+00	\N	\N	2021-11-08 10:18:44.787+00	2021-11-08 10:18:44.905+00
3092	\N	died	2021-11-08 10:18:41.28+00	\N	\N	2021-11-08 10:19:33.078+00	2021-11-08 10:19:33.278+00
930	\N	died	2021-11-08 10:18:31.915+00	\N	\N	2021-11-08 10:18:46.487+00	2021-11-08 10:18:46.78+00
3181	\N	died	2021-11-08 10:18:41.498+00	\N	\N	2021-11-08 10:19:35.011+00	2021-11-08 10:19:35.262+00
941	\N	died	2021-11-08 10:18:32.062+00	\N	\N	2021-11-08 10:18:46.776+00	2021-11-08 10:18:46.85+00
943	\N	died	2021-11-08 10:18:32.11+00	\N	\N	2021-11-08 10:18:46.84+00	2021-11-08 10:18:47.011+00
3099	\N	died	2021-11-08 10:18:41.294+00	\N	\N	2021-11-08 10:19:33.244+00	2021-11-08 10:19:33.656+00
948	\N	died	2021-11-08 10:18:32.258+00	\N	\N	2021-11-08 10:18:47.037+00	2021-11-08 10:18:47.318+00
5406	\N	died	2021-11-08 10:19:46.75+00	\N	\N	2021-11-08 10:20:33.687+00	2021-11-08 10:20:34.026+00
961	\N	died	2021-11-08 10:18:32.418+00	\N	\N	2021-11-08 10:18:47.313+00	2021-11-08 10:18:47.536+00
970	\N	died	2021-11-08 10:18:32.558+00	\N	\N	2021-11-08 10:18:47.532+00	2021-11-08 10:18:47.576+00
3113	\N	died	2021-11-08 10:18:41.332+00	\N	\N	2021-11-08 10:19:33.587+00	2021-11-08 10:19:34.089+00
971	\N	died	2021-11-08 10:18:32.588+00	\N	\N	2021-11-08 10:18:47.567+00	2021-11-08 10:18:47.631+00
974	\N	died	2021-11-08 10:18:32.641+00	\N	\N	2021-11-08 10:18:47.635+00	2021-11-08 10:18:47.817+00
3133	\N	died	2021-11-08 10:18:41.379+00	\N	\N	2021-11-08 10:19:33.973+00	2021-11-08 10:19:34.32+00
980	\N	died	2021-11-08 10:18:32.764+00	\N	\N	2021-11-08 10:18:47.813+00	2021-11-08 10:18:47.969+00
3148	\N	died	2021-11-08 10:18:41.423+00	\N	\N	2021-11-08 10:19:34.315+00	2021-11-08 10:19:34.566+00
5349	\N	died	2021-11-08 10:19:45.306+00	\N	\N	2021-11-08 10:20:32.338+00	2021-11-08 10:20:32.666+00
3157	\N	died	2021-11-08 10:18:41.439+00	\N	\N	2021-11-08 10:19:34.512+00	2021-11-08 10:19:34.802+00
3195	\N	died	2021-11-08 10:18:41.536+00	\N	\N	2021-11-08 10:19:35.244+00	2021-11-08 10:19:35.474+00
3206	\N	died	2021-11-08 10:18:41.577+00	\N	\N	2021-11-08 10:19:35.456+00	2021-11-08 10:19:35.585+00
5359	\N	died	2021-11-08 10:19:45.407+00	\N	\N	2021-11-08 10:20:32.613+00	2021-11-08 10:20:33.174+00
3214	\N	died	2021-11-08 10:18:41.594+00	\N	\N	2021-11-08 10:19:35.582+00	2021-11-08 10:19:35.733+00
3223	\N	died	2021-11-08 10:18:41.61+00	\N	\N	2021-11-08 10:19:35.728+00	2021-11-08 10:19:35.777+00
3226	\N	died	2021-11-08 10:18:41.617+00	\N	\N	2021-11-08 10:19:35.773+00	2021-11-08 10:19:35.848+00
5376	\N	died	2021-11-08 10:19:45.939+00	\N	\N	2021-11-08 10:20:33.138+00	2021-11-08 10:20:33.514+00
3228	\N	died	2021-11-08 10:18:41.617+00	\N	\N	2021-11-08 10:19:35.844+00	2021-11-08 10:19:35.886+00
5394	\N	died	2021-11-08 10:19:46.647+00	\N	\N	2021-11-08 10:20:33.505+00	2021-11-08 10:20:33.596+00
5399	\N	died	2021-11-08 10:19:46.723+00	\N	\N	2021-11-08 10:20:33.588+00	2021-11-08 10:20:33.716+00
5417	\N	died	2021-11-08 10:19:46.767+00	\N	\N	2021-11-08 10:20:33.879+00	2021-11-08 10:20:34.129+00
5426	\N	died	2021-11-08 10:19:46.833+00	\N	\N	2021-11-08 10:20:34.124+00	2021-11-08 10:20:34.257+00
5431	\N	died	2021-11-08 10:19:46.905+00	\N	\N	2021-11-08 10:20:34.204+00	2021-11-08 10:20:34.6+00
5447	\N	died	2021-11-08 10:19:46.927+00	\N	\N	2021-11-08 10:20:34.596+00	2021-11-08 10:20:34.785+00
5440	\N	died	2021-11-08 10:19:46.919+00	\N	\N	2021-11-08 10:20:34.387+00	2021-11-08 10:20:34.785+00
913	\N	died	2021-11-08 10:18:31.632+00	\N	\N	2021-11-08 10:18:45.926+00	2021-11-08 10:18:46.658+00
683	\N	died	2021-11-08 10:18:20.196+00	\N	\N	2021-11-08 10:18:32.422+00	2021-11-08 10:18:32.872+00
693	\N	died	2021-11-08 10:18:20.815+00	\N	\N	2021-11-08 10:18:32.947+00	2021-11-08 10:18:33.478+00
704	\N	died	2021-11-08 10:18:21.296+00	\N	\N	2021-11-08 10:18:33.516+00	2021-11-08 10:18:33.938+00
931	\N	died	2021-11-08 10:18:31.919+00	\N	\N	2021-11-08 10:18:46.505+00	2021-11-08 10:18:46.82+00
715	\N	died	2021-11-08 10:18:21.803+00	\N	\N	2021-11-08 10:18:34.145+00	2021-11-08 10:18:34.845+00
725	\N	died	2021-11-08 10:18:22.371+00	\N	\N	2021-11-08 10:18:34.754+00	2021-11-08 10:18:35.471+00
942	\N	died	2021-11-08 10:18:32.085+00	\N	\N	2021-11-08 10:18:46.809+00	2021-11-08 10:18:47.011+00
736	\N	died	2021-11-08 10:18:23.027+00	\N	\N	2021-11-08 10:18:35.436+00	2021-11-08 10:18:35.689+00
743	\N	died	2021-11-08 10:18:23.335+00	\N	\N	2021-11-08 10:18:35.751+00	2021-11-08 10:18:36.207+00
1083	\N	died	2021-11-08 10:18:33.239+00	\N	\N	2021-11-08 10:18:49.996+00	2021-11-08 10:18:50.435+00
749	\N	died	2021-11-08 10:18:23.645+00	\N	\N	2021-11-08 10:18:36.117+00	2021-11-08 10:18:36.956+00
767	\N	died	2021-11-08 10:18:24.533+00	\N	\N	2021-11-08 10:18:37.094+00	2021-11-08 10:18:37.808+00
947	\N	died	2021-11-08 10:18:32.235+00	\N	\N	2021-11-08 10:18:47.014+00	2021-11-08 10:18:47.17+00
781	\N	died	2021-11-08 10:18:25.301+00	\N	\N	2021-11-08 10:18:37.93+00	2021-11-08 10:18:38.212+00
3112	\N	died	2021-11-08 10:18:41.332+00	\N	\N	2021-11-08 10:19:33.575+00	2021-11-08 10:19:33.844+00
786	\N	died	2021-11-08 10:18:25.524+00	\N	\N	2021-11-08 10:18:38.184+00	2021-11-08 10:18:38.521+00
408	\N	died	2021-11-08 10:18:09.096+00	\N	\N	2021-11-08 10:18:18.96+00	2021-11-08 10:18:19.766+00
424	\N	died	2021-11-08 10:18:09.419+00	\N	\N	2021-11-08 10:18:19.59+00	2021-11-08 10:18:20.227+00
794	\N	died	2021-11-08 10:18:25.945+00	\N	\N	2021-11-08 10:18:38.665+00	2021-11-08 10:18:39.776+00
448	\N	died	2021-11-08 10:18:09.633+00	\N	\N	2021-11-08 10:18:20.221+00	2021-11-08 10:18:20.494+00
453	\N	died	2021-11-08 10:18:09.687+00	\N	\N	2021-11-08 10:18:20.484+00	2021-11-08 10:18:20.739+00
954	\N	died	2021-11-08 10:18:32.377+00	\N	\N	2021-11-08 10:18:47.16+00	2021-11-08 10:18:47.536+00
456	\N	died	2021-11-08 10:18:09.767+00	\N	\N	2021-11-08 10:18:20.721+00	2021-11-08 10:18:20.863+00
810	\N	died	2021-11-08 10:18:27.168+00	\N	\N	2021-11-08 10:18:40.197+00	2021-11-08 10:18:41.211+00
463	\N	died	2021-11-08 10:18:10.024+00	\N	\N	2021-11-08 10:18:21.02+00	2021-11-08 10:18:21.134+00
832	\N	died	2021-11-08 10:18:28.518+00	\N	\N	2021-11-08 10:18:41.767+00	2021-11-08 10:18:42.215+00
837	\N	died	2021-11-08 10:18:28.94+00	\N	\N	2021-11-08 10:18:42.227+00	2021-11-08 10:18:42.636+00
963	\N	died	2021-11-08 10:18:32.446+00	\N	\N	2021-11-08 10:18:47.364+00	2021-11-08 10:18:47.807+00
849	\N	died	2021-11-08 10:18:30.035+00	\N	\N	2021-11-08 10:18:43.685+00	2021-11-08 10:18:43.911+00
1099	\N	died	2021-11-08 10:18:33.31+00	\N	\N	2021-11-08 10:18:50.364+00	2021-11-08 10:18:50.84+00
861	\N	died	2021-11-08 10:18:30.914+00	\N	\N	2021-11-08 10:18:44.452+00	2021-11-08 10:18:44.76+00
871	\N	died	2021-11-08 10:18:31.113+00	\N	\N	2021-11-08 10:18:44.716+00	2021-11-08 10:18:45.35+00
979	\N	died	2021-11-08 10:18:32.759+00	\N	\N	2021-11-08 10:18:47.8+00	2021-11-08 10:18:47.969+00
889	\N	died	2021-11-08 10:18:31.246+00	\N	\N	2021-11-08 10:18:45.231+00	2021-11-08 10:18:45.401+00
896	\N	died	2021-11-08 10:18:31.291+00	\N	\N	2021-11-08 10:18:45.395+00	2021-11-08 10:18:45.483+00
1120	\N	died	2021-11-08 10:18:33.417+00	\N	\N	2021-11-08 10:18:50.833+00	2021-11-08 10:18:50.873+00
899	\N	died	2021-11-08 10:18:31.306+00	\N	\N	2021-11-08 10:18:45.448+00	2021-11-08 10:18:46.181+00
988	\N	died	2021-11-08 10:18:32.805+00	\N	\N	2021-11-08 10:18:47.948+00	2021-11-08 10:18:48.406+00
1009	\N	died	2021-11-08 10:18:32.91+00	\N	\N	2021-11-08 10:18:48.404+00	2021-11-08 10:18:48.574+00
1122	\N	died	2021-11-08 10:18:33.423+00	\N	\N	2021-11-08 10:18:50.866+00	2021-11-08 10:18:50.904+00
1014	\N	died	2021-11-08 10:18:32.932+00	\N	\N	2021-11-08 10:18:48.522+00	2021-11-08 10:18:49.013+00
3062	\N	died	2021-11-08 10:18:41.214+00	\N	\N	2021-11-08 10:19:32.298+00	2021-11-08 10:19:32.712+00
1032	\N	died	2021-11-08 10:18:33.013+00	\N	\N	2021-11-08 10:18:48.874+00	2021-11-08 10:18:49.3+00
3201	\N	died	2021-11-08 10:18:41.552+00	\N	\N	2021-11-08 10:19:35.337+00	2021-11-08 10:19:35.733+00
1049	\N	died	2021-11-08 10:18:33.098+00	\N	\N	2021-11-08 10:18:49.274+00	2021-11-08 10:18:49.662+00
1063	\N	died	2021-11-08 10:18:33.161+00	\N	\N	2021-11-08 10:18:49.555+00	2021-11-08 10:18:49.92+00
3076	\N	died	2021-11-08 10:18:41.234+00	\N	\N	2021-11-08 10:19:32.571+00	2021-11-08 10:19:33.182+00
1078	\N	died	2021-11-08 10:18:33.222+00	\N	\N	2021-11-08 10:18:49.914+00	2021-11-08 10:18:50.119+00
1124	\N	died	2021-11-08 10:18:33.434+00	\N	\N	2021-11-08 10:18:50.899+00	2021-11-08 10:18:50.971+00
1115	\N	died	2021-11-08 10:18:33.391+00	\N	\N	2021-11-08 10:18:50.699+00	2021-11-08 10:18:51.044+00
3094	\N	died	2021-11-08 10:18:41.287+00	\N	\N	2021-11-08 10:19:33.16+00	2021-11-08 10:19:33.29+00
1128	\N	died	2021-11-08 10:18:33.448+00	\N	\N	2021-11-08 10:18:50.967+00	2021-11-08 10:18:51.27+00
1129	\N	died	2021-11-08 10:18:33.452+00	\N	\N	2021-11-08 10:18:51.041+00	2021-11-08 10:18:51.27+00
1138	\N	died	2021-11-08 10:18:33.501+00	\N	\N	2021-11-08 10:18:51.267+00	2021-11-08 10:18:51.321+00
3102	\N	died	2021-11-08 10:18:41.301+00	\N	\N	2021-11-08 10:19:33.287+00	2021-11-08 10:19:33.386+00
1141	\N	died	2021-11-08 10:18:33.512+00	\N	\N	2021-11-08 10:18:51.316+00	2021-11-08 10:18:51.358+00
3144	\N	died	2021-11-08 10:18:41.408+00	\N	\N	2021-11-08 10:19:34.194+00	2021-11-08 10:19:34.416+00
3105	\N	died	2021-11-08 10:18:41.309+00	\N	\N	2021-11-08 10:19:33.382+00	2021-11-08 10:19:33.656+00
1143	\N	died	2021-11-08 10:18:33.523+00	\N	\N	2021-11-08 10:18:51.355+00	2021-11-08 10:18:51.466+00
3174	\N	died	2021-11-08 10:18:41.492+00	\N	\N	2021-11-08 10:19:34.849+00	2021-11-08 10:19:35.119+00
3125	\N	died	2021-11-08 10:18:41.363+00	\N	\N	2021-11-08 10:19:33.84+00	2021-11-08 10:19:34.089+00
3132	\N	died	2021-11-08 10:18:41.371+00	\N	\N	2021-11-08 10:19:33.952+00	2021-11-08 10:19:34.199+00
3218	\N	died	2021-11-08 10:18:41.601+00	\N	\N	2021-11-08 10:19:35.649+00	2021-11-08 10:19:36.211+00
3151	\N	died	2021-11-08 10:18:41.431+00	\N	\N	2021-11-08 10:19:34.366+00	2021-11-08 10:19:34.665+00
3166	\N	died	2021-11-08 10:18:41.46+00	\N	\N	2021-11-08 10:19:34.661+00	2021-11-08 10:19:34.853+00
3184	\N	died	2021-11-08 10:18:41.514+00	\N	\N	2021-11-08 10:19:35.066+00	2021-11-08 10:19:35.424+00
5387	\N	died	2021-11-08 10:19:46.482+00	\N	\N	2021-11-08 10:20:33.371+00	2021-11-08 10:20:33.495+00
3244	\N	died	2021-11-08 10:18:41.667+00	\N	\N	2021-11-08 10:19:36.208+00	2021-11-08 10:19:36.359+00
5350	\N	died	2021-11-08 10:19:45.323+00	\N	\N	2021-11-08 10:20:32.356+00	2021-11-08 10:20:32.666+00
3253	\N	died	2021-11-08 10:18:41.683+00	\N	\N	2021-11-08 10:19:36.352+00	2021-11-08 10:19:36.391+00
3255	\N	died	2021-11-08 10:18:41.684+00	\N	\N	2021-11-08 10:19:36.387+00	2021-11-08 10:19:36.423+00
5360	\N	died	2021-11-08 10:19:45.473+00	\N	\N	2021-11-08 10:20:32.629+00	2021-11-08 10:20:33.292+00
5378	\N	died	2021-11-08 10:19:46.023+00	\N	\N	2021-11-08 10:20:33.187+00	2021-11-08 10:20:33.377+00
451	\N	died	2021-11-08 10:18:09.663+00	\N	\N	2021-11-08 10:18:20.377+00	2021-11-08 10:18:21.35+00
474	\N	died	2021-11-08 10:18:10.44+00	\N	\N	2021-11-08 10:18:21.506+00	2021-11-08 10:18:22.329+00
494	\N	died	2021-11-08 10:18:11.09+00	\N	\N	2021-11-08 10:18:22.365+00	2021-11-08 10:18:22.791+00
3063	\N	died	2021-11-08 10:18:41.214+00	\N	\N	2021-11-08 10:19:32.31+00	2021-11-08 10:19:32.804+00
503	\N	died	2021-11-08 10:18:11.387+00	\N	\N	2021-11-08 10:18:22.801+00	2021-11-08 10:18:23.051+00
509	\N	died	2021-11-08 10:18:11.744+00	\N	\N	2021-11-08 10:18:23.141+00	2021-11-08 10:18:23.667+00
521	\N	died	2021-11-08 10:18:12.29+00	\N	\N	2021-11-08 10:18:23.746+00	2021-11-08 10:18:24.127+00
3078	\N	died	2021-11-08 10:18:41.251+00	\N	\N	2021-11-08 10:19:32.8+00	2021-11-08 10:19:32.944+00
534	\N	died	2021-11-08 10:18:12.544+00	\N	\N	2021-11-08 10:18:24.158+00	2021-11-08 10:18:24.42+00
3200	\N	died	2021-11-08 10:18:41.552+00	\N	\N	2021-11-08 10:19:35.321+00	2021-11-08 10:19:35.733+00
541	\N	died	2021-11-08 10:18:12.677+00	\N	\N	2021-11-08 10:18:24.404+00	2021-11-08 10:18:24.814+00
549	\N	died	2021-11-08 10:18:13.025+00	\N	\N	2021-11-08 10:18:24.799+00	2021-11-08 10:18:25.172+00
3083	\N	died	2021-11-08 10:18:41.264+00	\N	\N	2021-11-08 10:19:32.94+00	2021-11-08 10:19:32.989+00
560	\N	died	2021-11-08 10:18:13.349+00	\N	\N	2021-11-08 10:18:25.284+00	2021-11-08 10:18:25.675+00
571	\N	died	2021-11-08 10:18:13.64+00	\N	\N	2021-11-08 10:18:25.721+00	2021-11-08 10:18:26.376+00
409	\N	died	2021-11-08 10:18:09.104+00	\N	\N	2021-11-08 10:18:18.992+00	2021-11-08 10:18:19.546+00
422	\N	died	2021-11-08 10:18:09.403+00	\N	\N	2021-11-08 10:18:19.534+00	2021-11-08 10:18:19.824+00
431	\N	died	2021-11-08 10:18:09.485+00	\N	\N	2021-11-08 10:18:19.805+00	2021-11-08 10:18:19.878+00
3086	\N	died	2021-11-08 10:18:41.271+00	\N	\N	2021-11-08 10:19:32.981+00	2021-11-08 10:19:33.182+00
434	\N	died	2021-11-08 10:18:09.508+00	\N	\N	2021-11-08 10:18:19.871+00	2021-11-08 10:18:20.027+00
440	\N	died	2021-11-08 10:18:09.554+00	\N	\N	2021-11-08 10:18:20.015+00	2021-11-08 10:18:20.129+00
444	\N	died	2021-11-08 10:18:09.586+00	\N	\N	2021-11-08 10:18:20.121+00	2021-11-08 10:18:20.199+00
3093	\N	died	2021-11-08 10:18:41.286+00	\N	\N	2021-11-08 10:19:33.147+00	2021-11-08 10:19:33.386+00
447	\N	died	2021-11-08 10:18:09.627+00	\N	\N	2021-11-08 10:18:20.2+00	2021-11-08 10:18:20.494+00
579	\N	died	2021-11-08 10:18:13.959+00	\N	\N	2021-11-08 10:18:26.397+00	2021-11-08 10:18:26.614+00
3216	\N	died	2021-11-08 10:18:41.594+00	\N	\N	2021-11-08 10:19:35.612+00	2021-11-08 10:19:36.053+00
584	\N	died	2021-11-08 10:18:14.179+00	\N	\N	2021-11-08 10:18:26.621+00	2021-11-08 10:18:27.018+00
590	\N	died	2021-11-08 10:18:14.598+00	\N	\N	2021-11-08 10:18:27.04+00	2021-11-08 10:18:27.191+00
3104	\N	died	2021-11-08 10:18:41.301+00	\N	\N	2021-11-08 10:19:33.37+00	2021-11-08 10:19:33.676+00
596	\N	died	2021-11-08 10:18:14.882+00	\N	\N	2021-11-08 10:18:27.312+00	2021-11-08 10:18:28.424+00
622	\N	died	2021-11-08 10:18:16.949+00	\N	\N	2021-11-08 10:18:29.074+00	2021-11-08 10:18:29.252+00
624	\N	died	2021-11-08 10:18:17.225+00	\N	\N	2021-11-08 10:18:29.286+00	2021-11-08 10:18:29.54+00
3118	\N	died	2021-11-08 10:18:41.348+00	\N	\N	2021-11-08 10:19:33.673+00	2021-11-08 10:19:33.825+00
638	\N	died	2021-11-08 10:18:18.132+00	\N	\N	2021-11-08 10:18:30.103+00	2021-11-08 10:18:30.525+00
647	\N	died	2021-11-08 10:18:18.612+00	\N	\N	2021-11-08 10:18:30.541+00	2021-11-08 10:18:31.049+00
658	\N	died	2021-11-08 10:18:19.038+00	\N	\N	2021-11-08 10:18:31.033+00	2021-11-08 10:18:31.349+00
3122	\N	died	2021-11-08 10:18:41.356+00	\N	\N	2021-11-08 10:19:33.736+00	2021-11-08 10:19:34.089+00
666	\N	died	2021-11-08 10:18:19.357+00	\N	\N	2021-11-08 10:18:31.521+00	2021-11-08 10:18:31.721+00
3240	\N	died	2021-11-08 10:18:41.659+00	\N	\N	2021-11-08 10:19:36.049+00	2021-11-08 10:19:36.359+00
669	\N	died	2021-11-08 10:18:19.529+00	\N	\N	2021-11-08 10:18:31.689+00	2021-11-08 10:18:32.099+00
678	\N	died	2021-11-08 10:18:19.942+00	\N	\N	2021-11-08 10:18:32.088+00	2021-11-08 10:18:32.356+00
3134	\N	died	2021-11-08 10:18:41.379+00	\N	\N	2021-11-08 10:19:34.035+00	2021-11-08 10:19:34.416+00
5351	\N	died	2021-11-08 10:19:45.324+00	\N	\N	2021-11-08 10:20:32.37+00	2021-11-08 10:20:32.666+00
3150	\N	died	2021-11-08 10:18:41.424+00	\N	\N	2021-11-08 10:19:34.346+00	2021-11-08 10:19:34.614+00
3162	\N	died	2021-11-08 10:18:41.453+00	\N	\N	2021-11-08 10:19:34.598+00	2021-11-08 10:19:34.786+00
3170	\N	died	2021-11-08 10:18:41.468+00	\N	\N	2021-11-08 10:19:34.777+00	2021-11-08 10:19:35.119+00
3180	\N	died	2021-11-08 10:18:41.498+00	\N	\N	2021-11-08 10:19:34.995+00	2021-11-08 10:19:35.219+00
5361	\N	died	2021-11-08 10:19:45.489+00	\N	\N	2021-11-08 10:20:32.645+00	2021-11-08 10:20:33.292+00
3193	\N	died	2021-11-08 10:18:41.536+00	\N	\N	2021-11-08 10:19:35.215+00	2021-11-08 10:19:35.424+00
3248	\N	died	2021-11-08 10:18:41.676+00	\N	\N	2021-11-08 10:19:36.275+00	2021-11-08 10:19:36.517+00
3263	\N	died	2021-11-08 10:18:41.705+00	\N	\N	2021-11-08 10:19:36.512+00	2021-11-08 10:19:36.595+00
3268	\N	died	2021-11-08 10:18:41.726+00	\N	\N	2021-11-08 10:19:36.591+00	2021-11-08 10:19:36.789+00
5380	\N	died	2021-11-08 10:19:46.172+00	\N	\N	2021-11-08 10:20:33.22+00	2021-11-08 10:20:33.561+00
3271	\N	died	2021-11-08 10:18:41.731+00	\N	\N	2021-11-08 10:19:36.782+00	2021-11-08 10:19:36.916+00
5449	\N	died	2021-11-08 10:19:46.93+00	\N	\N	2021-11-08 10:20:34.612+00	2021-11-08 10:20:34.925+00
3276	\N	died	2021-11-08 10:18:41.737+00	\N	\N	2021-11-08 10:19:36.912+00	2021-11-08 10:19:36.958+00
3279	\N	died	2021-11-08 10:18:41.743+00	\N	\N	2021-11-08 10:19:36.953+00	2021-11-08 10:19:37.058+00
5396	\N	died	2021-11-08 10:19:46.672+00	\N	\N	2021-11-08 10:20:33.537+00	2021-11-08 10:20:33.867+00
3285	\N	died	2021-11-08 10:18:41.755+00	\N	\N	2021-11-08 10:19:37.054+00	2021-11-08 10:19:37.225+00
3292	\N	died	2021-11-08 10:18:41.77+00	\N	\N	2021-11-08 10:19:37.221+00	2021-11-08 10:19:37.258+00
5413	\N	died	2021-11-08 10:19:46.758+00	\N	\N	2021-11-08 10:20:33.812+00	2021-11-08 10:20:34.104+00
5424	\N	died	2021-11-08 10:19:46.83+00	\N	\N	2021-11-08 10:20:34.056+00	2021-11-08 10:20:34.291+00
5462	\N	died	2021-11-08 10:19:46.999+00	\N	\N	2021-11-08 10:20:34.913+00	2021-11-08 10:20:35.352+00
5434	\N	died	2021-11-08 10:19:46.909+00	\N	\N	2021-11-08 10:20:34.273+00	2021-11-08 10:20:34.41+00
5441	\N	died	2021-11-08 10:19:46.919+00	\N	\N	2021-11-08 10:20:34.405+00	2021-11-08 10:20:34.55+00
5477	\N	died	2021-11-08 10:19:47.33+00	\N	\N	2021-11-08 10:20:35.322+00	2021-11-08 10:20:35.829+00
5444	\N	died	2021-11-08 10:19:46.925+00	\N	\N	2021-11-08 10:20:34.538+00	2021-11-08 10:20:34.785+00
5497	\N	died	2021-11-08 10:19:47.881+00	\N	\N	2021-11-08 10:20:35.811+00	2021-11-08 10:20:36.051+00
5505	\N	died	2021-11-08 10:19:48.014+00	\N	\N	2021-11-08 10:20:36.039+00	2021-11-08 10:20:36.087+00
5507	\N	died	2021-11-08 10:19:48.083+00	\N	\N	2021-11-08 10:20:36.081+00	2021-11-08 10:20:36.185+00
407	\N	died	2021-11-08 10:18:09.085+00	\N	\N	2021-11-08 10:18:18.923+00	2021-11-08 10:18:19.374+00
417	\N	died	2021-11-08 10:18:09.353+00	\N	\N	2021-11-08 10:18:19.363+00	2021-11-08 10:18:19.766+00
623	\N	died	2021-11-08 10:18:17.132+00	\N	\N	2021-11-08 10:18:29.218+00	2021-11-08 10:18:29.54+00
425	\N	died	2021-11-08 10:18:09.42+00	\N	\N	2021-11-08 10:18:19.618+00	2021-11-08 10:18:20.027+00
817	\N	died	2021-11-08 10:18:27.608+00	\N	\N	2021-11-08 10:18:40.714+00	2021-11-08 10:18:40.913+00
437	\N	died	2021-11-08 10:18:09.536+00	\N	\N	2021-11-08 10:18:19.949+00	2021-11-08 10:18:20.199+00
446	\N	died	2021-11-08 10:18:09.619+00	\N	\N	2021-11-08 10:18:20.186+00	2021-11-08 10:18:20.264+00
628	\N	died	2021-11-08 10:18:17.49+00	\N	\N	2021-11-08 10:18:29.506+00	2021-11-08 10:18:29.781+00
449	\N	died	2021-11-08 10:18:09.642+00	\N	\N	2021-11-08 10:18:20.254+00	2021-11-08 10:18:20.739+00
671	\N	died	2021-11-08 10:18:19.67+00	\N	\N	2021-11-08 10:18:31.811+00	2021-11-08 10:18:32.356+00
457	\N	died	2021-11-08 10:18:09.811+00	\N	\N	2021-11-08 10:18:20.772+00	2021-11-08 10:18:21.184+00
632	\N	died	2021-11-08 10:18:17.775+00	\N	\N	2021-11-08 10:18:29.747+00	2021-11-08 10:18:30.048+00
468	\N	died	2021-11-08 10:18:10.208+00	\N	\N	2021-11-08 10:18:21.251+00	2021-11-08 10:18:21.774+00
481	\N	died	2021-11-08 10:18:10.665+00	\N	\N	2021-11-08 10:18:21.794+00	2021-11-08 10:18:21.996+00
488	\N	died	2021-11-08 10:18:10.925+00	\N	\N	2021-11-08 10:18:22.122+00	2021-11-08 10:18:22.791+00
499	\N	died	2021-11-08 10:18:11.258+00	\N	\N	2021-11-08 10:18:22.597+00	2021-11-08 10:18:23.299+00
639	\N	died	2021-11-08 10:18:18.136+00	\N	\N	2021-11-08 10:18:30.103+00	2021-11-08 10:18:30.287+00
513	\N	died	2021-11-08 10:18:11.852+00	\N	\N	2021-11-08 10:18:23.282+00	2021-11-08 10:18:23.396+00
641	\N	died	2021-11-08 10:18:18.308+00	\N	\N	2021-11-08 10:18:30.26+00	2021-11-08 10:18:30.525+00
516	\N	died	2021-11-08 10:18:11.949+00	\N	\N	2021-11-08 10:18:23.42+00	2021-11-08 10:18:23.966+00
524	\N	died	2021-11-08 10:18:12.391+00	\N	\N	2021-11-08 10:18:23.834+00	2021-11-08 10:18:24.42+00
648	\N	died	2021-11-08 10:18:18.699+00	\N	\N	2021-11-08 10:18:30.629+00	2021-11-08 10:18:31.349+00
542	\N	died	2021-11-08 10:18:12.717+00	\N	\N	2021-11-08 10:18:24.457+00	2021-11-08 10:18:24.814+00
825	\N	died	2021-11-08 10:18:28.057+00	\N	\N	2021-11-08 10:18:41.247+00	2021-11-08 10:18:41.89+00
551	\N	died	2021-11-08 10:18:13.036+00	\N	\N	2021-11-08 10:18:24.829+00	2021-11-08 10:18:25.226+00
661	\N	died	2021-11-08 10:18:19.159+00	\N	\N	2021-11-08 10:18:31.225+00	2021-11-08 10:18:31.614+00
559	\N	died	2021-11-08 10:18:13.315+00	\N	\N	2021-11-08 10:18:25.248+00	2021-11-08 10:18:25.405+00
563	\N	died	2021-11-08 10:18:13.428+00	\N	\N	2021-11-08 10:18:25.396+00	2021-11-08 10:18:25.721+00
684	\N	died	2021-11-08 10:18:20.249+00	\N	\N	2021-11-08 10:18:32.459+00	2021-11-08 10:18:33.016+00
572	\N	died	2021-11-08 10:18:13.643+00	\N	\N	2021-11-08 10:18:25.729+00	2021-11-08 10:18:26.642+00
594	\N	died	2021-11-08 10:18:14.77+00	\N	\N	2021-11-08 10:18:27.198+00	2021-11-08 10:18:27.834+00
612	\N	died	2021-11-08 10:18:16.107+00	\N	\N	2021-11-08 10:18:28.39+00	2021-11-08 10:18:28.624+00
616	\N	died	2021-11-08 10:18:16.443+00	\N	\N	2021-11-08 10:18:28.655+00	2021-11-08 10:18:29.252+00
695	\N	died	2021-11-08 10:18:20.886+00	\N	\N	2021-11-08 10:18:33.028+00	2021-11-08 10:18:33.38+00
883	\N	died	2021-11-08 10:18:31.212+00	\N	\N	2021-11-08 10:18:45.132+00	2021-11-08 10:18:45.388+00
703	\N	died	2021-11-08 10:18:21.257+00	\N	\N	2021-11-08 10:18:33.459+00	2021-11-08 10:18:33.938+00
711	\N	died	2021-11-08 10:18:21.615+00	\N	\N	2021-11-08 10:18:33.932+00	2021-11-08 10:18:34.393+00
842	\N	died	2021-11-08 10:18:29.363+00	\N	\N	2021-11-08 10:18:42.661+00	2021-11-08 10:18:42.981+00
739	\N	died	2021-11-08 10:18:23.147+00	\N	\N	2021-11-08 10:18:35.564+00	2021-11-08 10:18:36.207+00
753	\N	died	2021-11-08 10:18:23.842+00	\N	\N	2021-11-08 10:18:36.336+00	2021-11-08 10:18:36.919+00
845	\N	died	2021-11-08 10:18:29.67+00	\N	\N	2021-11-08 10:18:42.94+00	2021-11-08 10:18:43.624+00
760	\N	died	2021-11-08 10:18:24.225+00	\N	\N	2021-11-08 10:18:36.725+00	2021-11-08 10:18:37.174+00
775	\N	died	2021-11-08 10:18:24.998+00	\N	\N	2021-11-08 10:18:37.603+00	2021-11-08 10:18:38.328+00
789	\N	died	2021-11-08 10:18:25.664+00	\N	\N	2021-11-08 10:18:38.353+00	2021-11-08 10:18:39.349+00
894	\N	died	2021-11-08 10:18:31.286+00	\N	\N	2021-11-08 10:18:45.364+00	2021-11-08 10:18:45.483+00
802	\N	died	2021-11-08 10:18:26.677+00	\N	\N	2021-11-08 10:18:39.465+00	2021-11-08 10:18:39.889+00
962	\N	died	2021-11-08 10:18:32.427+00	\N	\N	2021-11-08 10:18:47.336+00	2021-11-08 10:18:47.631+00
807	\N	died	2021-11-08 10:18:27.002+00	\N	\N	2021-11-08 10:18:39.939+00	2021-11-08 10:18:40.522+00
850	\N	died	2021-11-08 10:18:30.109+00	\N	\N	2021-11-08 10:18:43.741+00	2021-11-08 10:18:44.034+00
945	\N	died	2021-11-08 10:18:32.158+00	\N	\N	2021-11-08 10:18:46.887+00	2021-11-08 10:18:47.119+00
858	\N	died	2021-11-08 10:18:30.683+00	\N	\N	2021-11-08 10:18:44.228+00	2021-11-08 10:18:44.76+00
1016	\N	died	2021-11-08 10:18:32.938+00	\N	\N	2021-11-08 10:18:48.559+00	2021-11-08 10:18:49.013+00
869	\N	died	2021-11-08 10:18:31.099+00	\N	\N	2021-11-08 10:18:44.663+00	2021-11-08 10:18:45.218+00
900	\N	died	2021-11-08 10:18:31.306+00	\N	\N	2021-11-08 10:18:45.462+00	2021-11-08 10:18:46.181+00
915	\N	died	2021-11-08 10:18:31.665+00	\N	\N	2021-11-08 10:18:46.034+00	2021-11-08 10:18:46.658+00
973	\N	died	2021-11-08 10:18:32.629+00	\N	\N	2021-11-08 10:18:47.622+00	2021-11-08 10:18:47.718+00
936	\N	died	2021-11-08 10:18:31.986+00	\N	\N	2021-11-08 10:18:46.67+00	2021-11-08 10:18:46.889+00
1058	\N	died	2021-11-08 10:18:33.135+00	\N	\N	2021-11-08 10:18:49.474+00	2021-11-08 10:18:49.777+00
949	\N	died	2021-11-08 10:18:32.272+00	\N	\N	2021-11-08 10:18:47.053+00	2021-11-08 10:18:47.536+00
1000	\N	died	2021-11-08 10:18:32.869+00	\N	\N	2021-11-08 10:18:48.199+00	2021-11-08 10:18:48.418+00
977	\N	died	2021-11-08 10:18:32.728+00	\N	\N	2021-11-08 10:18:47.714+00	2021-11-08 10:18:47.969+00
984	\N	died	2021-11-08 10:18:32.785+00	\N	\N	2021-11-08 10:18:47.882+00	2021-11-08 10:18:48.27+00
1010	\N	died	2021-11-08 10:18:32.915+00	\N	\N	2021-11-08 10:18:48.414+00	2021-11-08 10:18:48.574+00
1070	\N	died	2021-11-08 10:18:33.187+00	\N	\N	2021-11-08 10:18:49.721+00	2021-11-08 10:18:49.932+00
1036	\N	died	2021-11-08 10:18:33.035+00	\N	\N	2021-11-08 10:18:48.996+00	2021-11-08 10:18:49.495+00
1085	\N	died	2021-11-08 10:18:33.252+00	\N	\N	2021-11-08 10:18:50.035+00	2021-11-08 10:18:50.503+00
1105	\N	died	2021-11-08 10:18:33.343+00	\N	\N	2021-11-08 10:18:50.478+00	2021-11-08 10:18:50.84+00
1079	\N	died	2021-11-08 10:18:33.222+00	\N	\N	2021-11-08 10:18:49.928+00	2021-11-08 10:18:50.119+00
1113	\N	died	2021-11-08 10:18:33.382+00	\N	\N	2021-11-08 10:18:50.661+00	2021-11-08 10:18:50.887+00
3064	\N	died	2021-11-08 10:18:41.214+00	\N	\N	2021-11-08 10:19:32.327+00	2021-11-08 10:19:32.368+00
1123	\N	died	2021-11-08 10:18:33.429+00	\N	\N	2021-11-08 10:18:50.883+00	2021-11-08 10:18:50.971+00
3066	\N	died	2021-11-08 10:18:41.22+00	\N	\N	2021-11-08 10:19:32.364+00	2021-11-08 10:19:32.507+00
5353	\N	died	2021-11-08 10:19:45.356+00	\N	\N	2021-11-08 10:20:32.406+00	2021-11-08 10:20:32.684+00
510	\N	died	2021-11-08 10:18:11.817+00	\N	\N	2021-11-08 10:18:23.207+00	2021-11-08 10:18:23.606+00
523	\N	died	2021-11-08 10:18:12.387+00	\N	\N	2021-11-08 10:18:23.833+00	2021-11-08 10:18:24.326+00
538	\N	died	2021-11-08 10:18:12.648+00	\N	\N	2021-11-08 10:18:24.318+00	2021-11-08 10:18:24.508+00
670	\N	died	2021-11-08 10:18:19.585+00	\N	\N	2021-11-08 10:18:31.756+00	2021-11-08 10:18:32.614+00
547	\N	died	2021-11-08 10:18:12.964+00	\N	\N	2021-11-08 10:18:24.719+00	2021-11-08 10:18:25.172+00
557	\N	died	2021-11-08 10:18:13.25+00	\N	\N	2021-11-08 10:18:25.152+00	2021-11-08 10:18:25.268+00
561	\N	died	2021-11-08 10:18:13.382+00	\N	\N	2021-11-08 10:18:25.337+00	2021-11-08 10:18:25.536+00
685	\N	died	2021-11-08 10:18:20.366+00	\N	\N	2021-11-08 10:18:32.544+00	2021-11-08 10:18:33.478+00
566	\N	died	2021-11-08 10:18:13.482+00	\N	\N	2021-11-08 10:18:25.516+00	2021-11-08 10:18:25.978+00
872	\N	died	2021-11-08 10:18:31.118+00	\N	\N	2021-11-08 10:18:44.749+00	2021-11-08 10:18:44.868+00
573	\N	died	2021-11-08 10:18:13.666+00	\N	\N	2021-11-08 10:18:25.784+00	2021-11-08 10:18:27.018+00
589	\N	died	2021-11-08 10:18:14.545+00	\N	\N	2021-11-08 10:18:26.992+00	2021-11-08 10:18:27.13+00
702	\N	died	2021-11-08 10:18:21.225+00	\N	\N	2021-11-08 10:18:33.42+00	2021-11-08 10:18:34.23+00
595	\N	died	2021-11-08 10:18:14.83+00	\N	\N	2021-11-08 10:18:27.257+00	2021-11-08 10:18:27.702+00
412	\N	died	2021-11-08 10:18:09.197+00	\N	\N	2021-11-08 10:18:19.109+00	2021-11-08 10:18:19.766+00
1004	\N	died	2021-11-08 10:18:32.883+00	\N	\N	2021-11-08 10:18:48.314+00	2021-11-08 10:18:48.78+00
427	\N	died	2021-11-08 10:18:09.433+00	\N	\N	2021-11-08 10:18:19.674+00	2021-11-08 10:18:20.129+00
611	\N	died	2021-11-08 10:18:15.986+00	\N	\N	2021-11-08 10:18:28.284+00	2021-11-08 10:18:28.964+00
441	\N	died	2021-11-08 10:18:09.563+00	\N	\N	2021-11-08 10:18:20.052+00	2021-11-08 10:18:20.494+00
452	\N	died	2021-11-08 10:18:09.673+00	\N	\N	2021-11-08 10:18:20.427+00	2021-11-08 10:18:21.604+00
713	\N	died	2021-11-08 10:18:21.714+00	\N	\N	2021-11-08 10:18:34.043+00	2021-11-08 10:18:34.602+00
473	\N	died	2021-11-08 10:18:10.403+00	\N	\N	2021-11-08 10:18:21.457+00	2021-11-08 10:18:22.24+00
491	\N	died	2021-11-08 10:18:11.024+00	\N	\N	2021-11-08 10:18:22.26+00	2021-11-08 10:18:22.791+00
500	\N	died	2021-11-08 10:18:11.29+00	\N	\N	2021-11-08 10:18:22.676+00	2021-11-08 10:18:23.299+00
625	\N	died	2021-11-08 10:18:17.228+00	\N	\N	2021-11-08 10:18:29.295+00	2021-11-08 10:18:30.048+00
726	\N	died	2021-11-08 10:18:22.435+00	\N	\N	2021-11-08 10:18:34.814+00	2021-11-08 10:18:35.055+00
643	\N	died	2021-11-08 10:18:18.37+00	\N	\N	2021-11-08 10:18:30.327+00	2021-11-08 10:18:30.838+00
874	\N	died	2021-11-08 10:18:31.13+00	\N	\N	2021-11-08 10:18:44.864+00	2021-11-08 10:18:44.95+00
651	\N	died	2021-11-08 10:18:18.8+00	\N	\N	2021-11-08 10:18:30.75+00	2021-11-08 10:18:31.557+00
1093	\N	died	2021-11-08 10:18:33.282+00	\N	\N	2021-11-08 10:18:50.215+00	2021-11-08 10:18:50.568+00
730	\N	died	2021-11-08 10:18:22.629+00	\N	\N	2021-11-08 10:18:35.025+00	2021-11-08 10:18:35.241+00
735	\N	died	2021-11-08 10:18:22.914+00	\N	\N	2021-11-08 10:18:35.323+00	2021-11-08 10:18:35.946+00
878	\N	died	2021-11-08 10:18:31.171+00	\N	\N	2021-11-08 10:18:44.948+00	2021-11-08 10:18:45.218+00
748	\N	died	2021-11-08 10:18:23.589+00	\N	\N	2021-11-08 10:18:36.061+00	2021-11-08 10:18:36.919+00
762	\N	died	2021-11-08 10:18:24.31+00	\N	\N	2021-11-08 10:18:36.825+00	2021-11-08 10:18:37.23+00
776	\N	died	2021-11-08 10:18:25.048+00	\N	\N	2021-11-08 10:18:37.655+00	2021-11-08 10:18:38.521+00
886	\N	died	2021-11-08 10:18:31.231+00	\N	\N	2021-11-08 10:18:45.188+00	2021-11-08 10:18:45.785+00
792	\N	died	2021-11-08 10:18:25.794+00	\N	\N	2021-11-08 10:18:38.498+00	2021-11-08 10:18:39.206+00
1024	\N	died	2021-11-08 10:18:32.97+00	\N	\N	2021-11-08 10:18:48.745+00	2021-11-08 10:18:49.013+00
803	\N	died	2021-11-08 10:18:26.734+00	\N	\N	2021-11-08 10:18:39.559+00	2021-11-08 10:18:40.522+00
812	\N	died	2021-11-08 10:18:27.26+00	\N	\N	2021-11-08 10:18:40.326+00	2021-11-08 10:18:41.211+00
911	\N	died	2021-11-08 10:18:31.59+00	\N	\N	2021-11-08 10:18:45.819+00	2021-11-08 10:18:46.462+00
826	\N	died	2021-11-08 10:18:28.13+00	\N	\N	2021-11-08 10:18:41.329+00	2021-11-08 10:18:41.723+00
1152	\N	died	2021-11-08 10:18:33.56+00	\N	\N	2021-11-08 10:18:51.541+00	2021-11-08 10:18:51.858+00
831	\N	died	2021-11-08 10:18:28.449+00	\N	\N	2021-11-08 10:18:41.689+00	2021-11-08 10:18:42.057+00
844	\N	died	2021-11-08 10:18:29.597+00	\N	\N	2021-11-08 10:18:42.882+00	2021-11-08 10:18:43.72+00
928	\N	died	2021-11-08 10:18:31.904+00	\N	\N	2021-11-08 10:18:46.463+00	2021-11-08 10:18:46.745+00
852	\N	died	2021-11-08 10:18:30.27+00	\N	\N	2021-11-08 10:18:43.878+00	2021-11-08 10:18:44.096+00
862	\N	died	2021-11-08 10:18:30.945+00	\N	\N	2021-11-08 10:18:44.479+00	2021-11-08 10:18:44.76+00
1035	\N	died	2021-11-08 10:18:33.024+00	\N	\N	2021-11-08 10:18:48.973+00	2021-11-08 10:18:49.495+00
938	\N	died	2021-11-08 10:18:32.011+00	\N	\N	2021-11-08 10:18:46.713+00	2021-11-08 10:18:47.119+00
950	\N	died	2021-11-08 10:18:32.3+00	\N	\N	2021-11-08 10:18:47.081+00	2021-11-08 10:18:47.536+00
965	\N	died	2021-11-08 10:18:32.465+00	\N	\N	2021-11-08 10:18:47.397+00	2021-11-08 10:18:47.718+00
1056	\N	died	2021-11-08 10:18:33.129+00	\N	\N	2021-11-08 10:18:49.442+00	2021-11-08 10:18:49.674+00
978	\N	died	2021-11-08 10:18:32.753+00	\N	\N	2021-11-08 10:18:47.741+00	2021-11-08 10:18:47.969+00
1107	\N	died	2021-11-08 10:18:33.351+00	\N	\N	2021-11-08 10:18:50.565+00	2021-11-08 10:18:50.84+00
986	\N	died	2021-11-08 10:18:32.793+00	\N	\N	2021-11-08 10:18:47.916+00	2021-11-08 10:18:48.385+00
1067	\N	died	2021-11-08 10:18:33.176+00	\N	\N	2021-11-08 10:18:49.67+00	2021-11-08 10:18:49.777+00
1071	\N	died	2021-11-08 10:18:33.192+00	\N	\N	2021-11-08 10:18:49.739+00	2021-11-08 10:18:50.119+00
1082	\N	died	2021-11-08 10:18:33.239+00	\N	\N	2021-11-08 10:18:49.981+00	2021-11-08 10:18:50.233+00
1135	\N	died	2021-11-08 10:18:33.48+00	\N	\N	2021-11-08 10:18:51.138+00	2021-11-08 10:18:51.627+00
1126	\N	died	2021-11-08 10:18:33.44+00	\N	\N	2021-11-08 10:18:50.928+00	2021-11-08 10:18:51.27+00
1112	\N	died	2021-11-08 10:18:33.382+00	\N	\N	2021-11-08 10:18:50.648+00	2021-11-08 10:18:51.27+00
1134	\N	died	2021-11-08 10:18:33.48+00	\N	\N	2021-11-08 10:18:51.124+00	2021-11-08 10:18:51.627+00
3065	\N	died	2021-11-08 10:18:41.214+00	\N	\N	2021-11-08 10:19:32.345+00	2021-11-08 10:19:32.449+00
3068	\N	died	2021-11-08 10:18:41.22+00	\N	\N	2021-11-08 10:19:32.445+00	2021-11-08 10:19:32.712+00
1154	\N	died	2021-11-08 10:18:33.578+00	\N	\N	2021-11-08 10:18:51.581+00	2021-11-08 10:18:52.081+00
1168	\N	died	2021-11-08 10:18:33.632+00	\N	\N	2021-11-08 10:18:51.855+00	2021-11-08 10:18:52.081+00
1178	\N	died	2021-11-08 10:18:33.679+00	\N	\N	2021-11-08 10:18:52.076+00	2021-11-08 10:18:52.161+00
3075	\N	died	2021-11-08 10:18:41.234+00	\N	\N	2021-11-08 10:19:32.553+00	2021-11-08 10:19:33.278+00
1180	\N	died	2021-11-08 10:18:33.689+00	\N	\N	2021-11-08 10:18:52.157+00	2021-11-08 10:18:52.212+00
3098	\N	died	2021-11-08 10:18:41.294+00	\N	\N	2021-11-08 10:19:33.236+00	2021-11-08 10:19:33.656+00
3111	\N	died	2021-11-08 10:18:41.324+00	\N	\N	2021-11-08 10:19:33.503+00	2021-11-08 10:19:33.711+00
3136	\N	died	2021-11-08 10:18:41.387+00	\N	\N	2021-11-08 10:19:34.072+00	2021-11-08 10:19:34.436+00
3120	\N	died	2021-11-08 10:18:41.348+00	\N	\N	2021-11-08 10:19:33.704+00	2021-11-08 10:19:33.857+00
3126	\N	died	2021-11-08 10:18:41.364+00	\N	\N	2021-11-08 10:19:33.852+00	2021-11-08 10:19:34.089+00
5354	\N	died	2021-11-08 10:19:45.373+00	\N	\N	2021-11-08 10:20:32.438+00	2021-11-08 10:20:32.73+00
3155	\N	died	2021-11-08 10:18:41.439+00	\N	\N	2021-11-08 10:19:34.431+00	2021-11-08 10:19:34.582+00
5365	\N	died	2021-11-08 10:19:45.538+00	\N	\N	2021-11-08 10:20:32.714+00	2021-11-08 10:20:32.954+00
418	\N	died	2021-11-08 10:18:09.359+00	\N	\N	2021-11-08 10:18:19.392+00	2021-11-08 10:18:19.766+00
426	\N	died	2021-11-08 10:18:09.427+00	\N	\N	2021-11-08 10:18:19.653+00	2021-11-08 10:18:20.027+00
635	\N	died	2021-11-08 10:18:17.958+00	\N	\N	2021-11-08 10:18:29.917+00	2021-11-08 10:18:30.838+00
439	\N	died	2021-11-08 10:18:09.55+00	\N	\N	2021-11-08 10:18:19.994+00	2021-11-08 10:18:20.827+00
814	\N	died	2021-11-08 10:18:27.398+00	\N	\N	2021-11-08 10:18:40.495+00	2021-11-08 10:18:40.662+00
459	\N	died	2021-11-08 10:18:09.882+00	\N	\N	2021-11-08 10:18:20.842+00	2021-11-08 10:18:21.046+00
650	\N	died	2021-11-08 10:18:18.737+00	\N	\N	2021-11-08 10:18:30.672+00	2021-11-08 10:18:31.349+00
464	\N	died	2021-11-08 10:18:10.057+00	\N	\N	2021-11-08 10:18:21.068+00	2021-11-08 10:18:21.395+00
472	\N	died	2021-11-08 10:18:10.367+00	\N	\N	2021-11-08 10:18:21.416+00	2021-11-08 10:18:22.188+00
489	\N	died	2021-11-08 10:18:10.957+00	\N	\N	2021-11-08 10:18:22.17+00	2021-11-08 10:18:22.441+00
495	\N	died	2021-11-08 10:18:11.133+00	\N	\N	2021-11-08 10:18:22.424+00	2021-11-08 10:18:22.817+00
665	\N	died	2021-11-08 10:18:19.24+00	\N	\N	2021-11-08 10:18:31.361+00	2021-11-08 10:18:32.099+00
504	\N	died	2021-11-08 10:18:11.423+00	\N	\N	2021-11-08 10:18:22.855+00	2021-11-08 10:18:23.299+00
819	\N	died	2021-11-08 10:18:27.692+00	\N	\N	2021-11-08 10:18:40.806+00	2021-11-08 10:18:41.211+00
677	\N	died	2021-11-08 10:18:19.908+00	\N	\N	2021-11-08 10:18:32.024+00	2021-11-08 10:18:32.924+00
687	\N	died	2021-11-08 10:18:20.479+00	\N	\N	2021-11-08 10:18:32.632+00	2021-11-08 10:18:32.924+00
511	\N	died	2021-11-08 10:18:11.831+00	\N	\N	2021-11-08 10:18:23.223+00	2021-11-08 10:18:23.966+00
522	\N	died	2021-11-08 10:18:12.356+00	\N	\N	2021-11-08 10:18:23.807+00	2021-11-08 10:18:24.326+00
535	\N	died	2021-11-08 10:18:12.574+00	\N	\N	2021-11-08 10:18:24.208+00	2021-11-08 10:18:24.623+00
698	\N	died	2021-11-08 10:18:21.038+00	\N	\N	2021-11-08 10:18:33.202+00	2021-11-08 10:18:33.537+00
546	\N	died	2021-11-08 10:18:12.875+00	\N	\N	2021-11-08 10:18:24.607+00	2021-11-08 10:18:25.172+00
554	\N	died	2021-11-08 10:18:13.116+00	\N	\N	2021-11-08 10:18:24.989+00	2021-11-08 10:18:25.536+00
705	\N	died	2021-11-08 10:18:21.342+00	\N	\N	2021-11-08 10:18:33.571+00	2021-11-08 10:18:34.23+00
565	\N	died	2021-11-08 10:18:13.45+00	\N	\N	2021-11-08 10:18:25.459+00	2021-11-08 10:18:25.978+00
580	\N	died	2021-11-08 10:18:14.025+00	\N	\N	2021-11-08 10:18:26.471+00	2021-11-08 10:18:27.018+00
586	\N	died	2021-11-08 10:18:14.332+00	\N	\N	2021-11-08 10:18:26.795+00	2021-11-08 10:18:27.417+00
719	\N	died	2021-11-08 10:18:22.042+00	\N	\N	2021-11-08 10:18:34.416+00	2021-11-08 10:18:34.959+00
603	\N	died	2021-11-08 10:18:15.34+00	\N	\N	2021-11-08 10:18:27.755+00	2021-11-08 10:18:28.149+00
608	\N	died	2021-11-08 10:18:15.787+00	\N	\N	2021-11-08 10:18:28.122+00	2021-11-08 10:18:28.424+00
829	\N	died	2021-11-08 10:18:28.287+00	\N	\N	2021-11-08 10:18:41.503+00	2021-11-08 10:18:42.057+00
614	\N	died	2021-11-08 10:18:16.24+00	\N	\N	2021-11-08 10:18:28.51+00	2021-11-08 10:18:29.112+00
731	\N	died	2021-11-08 10:18:22.687+00	\N	\N	2021-11-08 10:18:35.082+00	2021-11-08 10:18:35.471+00
738	\N	died	2021-11-08 10:18:23.102+00	\N	\N	2021-11-08 10:18:35.509+00	2021-11-08 10:18:36.207+00
754	\N	died	2021-11-08 10:18:23.888+00	\N	\N	2021-11-08 10:18:36.386+00	2021-11-08 10:18:36.544+00
835	\N	died	2021-11-08 10:18:28.753+00	\N	\N	2021-11-08 10:18:42.022+00	2021-11-08 10:18:42.574+00
759	\N	died	2021-11-08 10:18:24.173+00	\N	\N	2021-11-08 10:18:36.664+00	2021-11-08 10:18:37.808+00
923	\N	died	2021-11-08 10:18:31.833+00	\N	\N	2021-11-08 10:18:46.339+00	2021-11-08 10:18:46.462+00
774	\N	died	2021-11-08 10:18:24.949+00	\N	\N	2021-11-08 10:18:37.532+00	2021-11-08 10:18:38.212+00
839	\N	died	2021-11-08 10:18:29.078+00	\N	\N	2021-11-08 10:18:42.368+00	2021-11-08 10:18:43.569+00
791	\N	died	2021-11-08 10:18:25.759+00	\N	\N	2021-11-08 10:18:38.461+00	2021-11-08 10:18:39.282+00
983	\N	died	2021-11-08 10:18:32.78+00	\N	\N	2021-11-08 10:18:47.866+00	2021-11-08 10:18:48.17+00
798	\N	died	2021-11-08 10:18:26.474+00	\N	\N	2021-11-08 10:18:39.257+00	2021-11-08 10:18:39.481+00
806	\N	died	2021-11-08 10:18:26.944+00	\N	\N	2021-11-08 10:18:39.862+00	2021-11-08 10:18:40.522+00
927	\N	died	2021-11-08 10:18:31.897+00	\N	\N	2021-11-08 10:18:46.452+00	2021-11-08 10:18:46.745+00
1054	\N	died	2021-11-08 10:18:33.117+00	\N	\N	2021-11-08 10:18:49.406+00	2021-11-08 10:18:49.662+00
864	\N	died	2021-11-08 10:18:31.007+00	\N	\N	2021-11-08 10:18:44.53+00	2021-11-08 10:18:45.218+00
887	\N	died	2021-11-08 10:18:31.236+00	\N	\N	2021-11-08 10:18:45.197+00	2021-11-08 10:18:45.785+00
956	\N	died	2021-11-08 10:18:32.394+00	\N	\N	2021-11-08 10:18:47.181+00	2021-11-08 10:18:47.536+00
909	\N	died	2021-11-08 10:18:31.524+00	\N	\N	2021-11-08 10:18:45.77+00	2021-11-08 10:18:46.259+00
1015	\N	died	2021-11-08 10:18:32.932+00	\N	\N	2021-11-08 10:18:48.536+00	2021-11-08 10:18:49.013+00
919	\N	died	2021-11-08 10:18:31.752+00	\N	\N	2021-11-08 10:18:46.25+00	2021-11-08 10:18:46.309+00
937	\N	died	2021-11-08 10:18:31.994+00	\N	\N	2021-11-08 10:18:46.682+00	2021-11-08 10:18:47.011+00
946	\N	died	2021-11-08 10:18:32.211+00	\N	\N	2021-11-08 10:18:46.996+00	2021-11-08 10:18:47.119+00
998	\N	died	2021-11-08 10:18:32.858+00	\N	\N	2021-11-08 10:18:48.166+00	2021-11-08 10:18:48.385+00
951	\N	died	2021-11-08 10:18:32.337+00	\N	\N	2021-11-08 10:18:47.107+00	2021-11-08 10:18:47.176+00
967	\N	died	2021-11-08 10:18:32.54+00	\N	\N	2021-11-08 10:18:47.47+00	2021-11-08 10:18:47.969+00
1108	\N	died	2021-11-08 10:18:33.356+00	\N	\N	2021-11-08 10:18:50.582+00	2021-11-08 10:18:50.84+00
1003	\N	died	2021-11-08 10:18:32.878+00	\N	\N	2021-11-08 10:18:48.295+00	2021-11-08 10:18:48.574+00
1061	\N	died	2021-11-08 10:18:33.151+00	\N	\N	2021-11-08 10:18:49.524+00	2021-11-08 10:18:49.902+00
1034	\N	died	2021-11-08 10:18:33.018+00	\N	\N	2021-11-08 10:18:48.955+00	2021-11-08 10:18:49.41+00
1116	\N	died	2021-11-08 10:18:33.396+00	\N	\N	2021-11-08 10:18:50.715+00	2021-11-08 10:18:51.27+00
1074	\N	died	2021-11-08 10:18:33.204+00	\N	\N	2021-11-08 10:18:49.792+00	2021-11-08 10:18:50.119+00
1086	\N	died	2021-11-08 10:18:33.257+00	\N	\N	2021-11-08 10:18:50.099+00	2021-11-08 10:18:50.586+00
1147	\N	died	2021-11-08 10:18:33.54+00	\N	\N	2021-11-08 10:18:51.461+00	2021-11-08 10:18:51.627+00
1131	\N	died	2021-11-08 10:18:33.456+00	\N	\N	2021-11-08 10:18:51.073+00	2021-11-08 10:18:51.332+00
1142	\N	died	2021-11-08 10:18:33.512+00	\N	\N	2021-11-08 10:18:51.328+00	2021-11-08 10:18:51.466+00
3067	\N	died	2021-11-08 10:18:41.22+00	\N	\N	2021-11-08 10:19:32.378+00	2021-11-08 10:19:32.712+00
1145	\N	died	2021-11-08 10:18:33.534+00	\N	\N	2021-11-08 10:18:51.384+00	2021-11-08 10:18:51.627+00
3073	\N	died	2021-11-08 10:18:41.228+00	\N	\N	2021-11-08 10:19:32.519+00	2021-11-08 10:19:33.065+00
3090	\N	died	2021-11-08 10:18:41.28+00	\N	\N	2021-11-08 10:19:33.045+00	2021-11-08 10:19:33.491+00
3108	\N	died	2021-11-08 10:18:41.309+00	\N	\N	2021-11-08 10:19:33.419+00	2021-11-08 10:19:33.727+00
5356	\N	died	2021-11-08 10:19:45.389+00	\N	\N	2021-11-08 10:20:32.496+00	2021-11-08 10:20:32.954+00
486	\N	died	2021-11-08 10:18:10.858+00	\N	\N	2021-11-08 10:18:22.039+00	2021-11-08 10:18:22.39+00
496	\N	died	2021-11-08 10:18:11.165+00	\N	\N	2021-11-08 10:18:22.471+00	2021-11-08 10:18:22.872+00
673	\N	died	2021-11-08 10:18:19.731+00	\N	\N	2021-11-08 10:18:31.856+00	2021-11-08 10:18:32.356+00
506	\N	died	2021-11-08 10:18:11.54+00	\N	\N	2021-11-08 10:18:23.024+00	2021-11-08 10:18:23.299+00
515	\N	died	2021-11-08 10:18:11.916+00	\N	\N	2021-11-08 10:18:23.379+00	2021-11-08 10:18:23.606+00
1062	\N	died	2021-11-08 10:18:33.161+00	\N	\N	2021-11-08 10:18:49.542+00	2021-11-08 10:18:49.902+00
526	\N	died	2021-11-08 10:18:12.481+00	\N	\N	2021-11-08 10:18:23.931+00	2021-11-08 10:18:24.542+00
689	\N	died	2021-11-08 10:18:20.642+00	\N	\N	2021-11-08 10:18:32.752+00	2021-11-08 10:18:33.225+00
545	\N	died	2021-11-08 10:18:12.835+00	\N	\N	2021-11-08 10:18:24.563+00	2021-11-08 10:18:25.172+00
556	\N	died	2021-11-08 10:18:13.216+00	\N	\N	2021-11-08 10:18:25.117+00	2021-11-08 10:18:25.577+00
847	\N	died	2021-11-08 10:18:29.85+00	\N	\N	2021-11-08 10:18:43.36+00	2021-11-08 10:18:43.774+00
568	\N	died	2021-11-08 10:18:13.57+00	\N	\N	2021-11-08 10:18:25.61+00	2021-11-08 10:18:25.978+00
575	\N	died	2021-11-08 10:18:13.741+00	\N	\N	2021-11-08 10:18:25.875+00	2021-11-08 10:18:27.018+00
700	\N	died	2021-11-08 10:18:21.124+00	\N	\N	2021-11-08 10:18:33.293+00	2021-11-08 10:18:33.592+00
593	\N	died	2021-11-08 10:18:14.767+00	\N	\N	2021-11-08 10:18:27.192+00	2021-11-08 10:18:27.473+00
413	\N	died	2021-11-08 10:18:09.235+00	\N	\N	2021-11-08 10:18:19.148+00	2021-11-08 10:18:19.766+00
429	\N	died	2021-11-08 10:18:09.453+00	\N	\N	2021-11-08 10:18:19.734+00	2021-11-08 10:18:20.199+00
445	\N	died	2021-11-08 10:18:09.591+00	\N	\N	2021-11-08 10:18:20.145+00	2021-11-08 10:18:20.739+00
454	\N	died	2021-11-08 10:18:09.701+00	\N	\N	2021-11-08 10:18:20.622+00	2021-11-08 10:18:21.046+00
707	\N	died	2021-11-08 10:18:21.428+00	\N	\N	2021-11-08 10:18:33.671+00	2021-11-08 10:18:34.23+00
462	\N	died	2021-11-08 10:18:09.982+00	\N	\N	2021-11-08 10:18:20.972+00	2021-11-08 10:18:21.311+00
469	\N	died	2021-11-08 10:18:10.255+00	\N	\N	2021-11-08 10:18:21.29+00	2021-11-08 10:18:21.604+00
716	\N	died	2021-11-08 10:18:21.86+00	\N	\N	2021-11-08 10:18:34.208+00	2021-11-08 10:18:34.393+00
477	\N	died	2021-11-08 10:18:10.524+00	\N	\N	2021-11-08 10:18:21.6+00	2021-11-08 10:18:21.96+00
602	\N	died	2021-11-08 10:18:15.267+00	\N	\N	2021-11-08 10:18:27.681+00	2021-11-08 10:18:28.149+00
607	\N	died	2021-11-08 10:18:15.699+00	\N	\N	2021-11-08 10:18:28.047+00	2021-11-08 10:18:28.624+00
615	\N	died	2021-11-08 10:18:16.351+00	\N	\N	2021-11-08 10:18:28.593+00	2021-11-08 10:18:28.91+00
721	\N	died	2021-11-08 10:18:22.18+00	\N	\N	2021-11-08 10:18:34.558+00	2021-11-08 10:18:34.845+00
621	\N	died	2021-11-08 10:18:16.866+00	\N	\N	2021-11-08 10:18:29.001+00	2021-11-08 10:18:29.616+00
854	\N	died	2021-11-08 10:18:30.422+00	\N	\N	2021-11-08 10:18:43.996+00	2021-11-08 10:18:44.385+00
631	\N	died	2021-11-08 10:18:17.674+00	\N	\N	2021-11-08 10:18:29.659+00	2021-11-08 10:18:30.215+00
727	\N	died	2021-11-08 10:18:22.482+00	\N	\N	2021-11-08 10:18:34.859+00	2021-11-08 10:18:35.471+00
642	\N	died	2021-11-08 10:18:18.366+00	\N	\N	2021-11-08 10:18:30.32+00	2021-11-08 10:18:30.838+00
957	\N	died	2021-11-08 10:18:32.399+00	\N	\N	2021-11-08 10:18:47.248+00	2021-11-08 10:18:47.536+00
655	\N	died	2021-11-08 10:18:18.986+00	\N	\N	2021-11-08 10:18:30.937+00	2021-11-08 10:18:31.557+00
746	\N	died	2021-11-08 10:18:23.467+00	\N	\N	2021-11-08 10:18:35.916+00	2021-11-08 10:18:36.41+00
865	\N	died	2021-11-08 10:18:31.031+00	\N	\N	2021-11-08 10:18:44.558+00	2021-11-08 10:18:44.905+00
757	\N	died	2021-11-08 10:18:24.103+00	\N	\N	2021-11-08 10:18:36.596+00	2021-11-08 10:18:36.919+00
765	\N	died	2021-11-08 10:18:24.462+00	\N	\N	2021-11-08 10:18:37.006+00	2021-11-08 10:18:37.369+00
772	\N	died	2021-11-08 10:18:24.86+00	\N	\N	2021-11-08 10:18:37.45+00	2021-11-08 10:18:37.911+00
875	\N	died	2021-11-08 10:18:31.136+00	\N	\N	2021-11-08 10:18:44.883+00	2021-11-08 10:18:45.121+00
782	\N	died	2021-11-08 10:18:25.342+00	\N	\N	2021-11-08 10:18:37.979+00	2021-11-08 10:18:38.267+00
788	\N	died	2021-11-08 10:18:25.619+00	\N	\N	2021-11-08 10:18:38.304+00	2021-11-08 10:18:39.206+00
796	\N	died	2021-11-08 10:18:26.29+00	\N	\N	2021-11-08 10:18:39.05+00	2021-11-08 10:18:40.15+00
882	\N	died	2021-11-08 10:18:31.207+00	\N	\N	2021-11-08 10:18:45.117+00	2021-11-08 10:18:45.35+00
813	\N	died	2021-11-08 10:18:27.317+00	\N	\N	2021-11-08 10:18:40.407+00	2021-11-08 10:18:41.211+00
966	\N	died	2021-11-08 10:18:32.494+00	\N	\N	2021-11-08 10:18:47.425+00	2021-11-08 10:18:47.969+00
830	\N	died	2021-11-08 10:18:28.393+00	\N	\N	2021-11-08 10:18:41.631+00	2021-11-08 10:18:42.266+00
1030	\N	died	2021-11-08 10:18:33.003+00	\N	\N	2021-11-08 10:18:48.841+00	2021-11-08 10:18:49.089+00
841	\N	died	2021-11-08 10:18:29.299+00	\N	\N	2021-11-08 10:18:42.597+00	2021-11-08 10:18:42.856+00
892	\N	died	2021-11-08 10:18:31.275+00	\N	\N	2021-11-08 10:18:45.285+00	2021-11-08 10:18:45.647+00
912	\N	died	2021-11-08 10:18:31.597+00	\N	\N	2021-11-08 10:18:45.826+00	2021-11-08 10:18:46.481+00
981	\N	died	2021-11-08 10:18:32.769+00	\N	\N	2021-11-08 10:18:47.832+00	2021-11-08 10:18:48.069+00
935	\N	died	2021-11-08 10:18:31.959+00	\N	\N	2021-11-08 10:18:46.647+00	2021-11-08 10:18:46.745+00
929	\N	died	2021-11-08 10:18:31.914+00	\N	\N	2021-11-08 10:18:46.477+00	2021-11-08 10:18:46.745+00
1104	\N	died	2021-11-08 10:18:33.343+00	\N	\N	2021-11-08 10:18:50.471+00	2021-11-08 10:18:50.84+00
939	\N	died	2021-11-08 10:18:32.022+00	\N	\N	2021-11-08 10:18:46.737+00	2021-11-08 10:18:46.82+00
944	\N	died	2021-11-08 10:18:32.131+00	\N	\N	2021-11-08 10:18:46.864+00	2021-11-08 10:18:47.252+00
992	\N	died	2021-11-08 10:18:32.831+00	\N	\N	2021-11-08 10:18:48.065+00	2021-11-08 10:18:48.158+00
1052	\N	died	2021-11-08 10:18:33.113+00	\N	\N	2021-11-08 10:18:49.323+00	2021-11-08 10:18:49.662+00
995	\N	died	2021-11-08 10:18:32.841+00	\N	\N	2021-11-08 10:18:48.112+00	2021-11-08 10:18:48.385+00
1096	\N	died	2021-11-08 10:18:33.29+00	\N	\N	2021-11-08 10:18:50.269+00	2021-11-08 10:18:50.503+00
1005	\N	died	2021-11-08 10:18:32.888+00	\N	\N	2021-11-08 10:18:48.333+00	2021-11-08 10:18:48.645+00
1020	\N	died	2021-11-08 10:18:32.955+00	\N	\N	2021-11-08 10:18:48.625+00	2021-11-08 10:18:49.013+00
1041	\N	died	2021-11-08 10:18:33.063+00	\N	\N	2021-11-08 10:18:49.085+00	2021-11-08 10:18:49.224+00
1092	\N	died	2021-11-08 10:18:33.278+00	\N	\N	2021-11-08 10:18:50.198+00	2021-11-08 10:18:50.345+00
1044	\N	died	2021-11-08 10:18:33.075+00	\N	\N	2021-11-08 10:18:49.191+00	2021-11-08 10:18:49.393+00
1076	\N	died	2021-11-08 10:18:33.216+00	\N	\N	2021-11-08 10:18:49.882+00	2021-11-08 10:18:50.202+00
1146	\N	died	2021-11-08 10:18:33.54+00	\N	\N	2021-11-08 10:18:51.399+00	2021-11-08 10:18:51.627+00
1114	\N	died	2021-11-08 10:18:33.387+00	\N	\N	2021-11-08 10:18:50.681+00	2021-11-08 10:18:50.919+00
1148	\N	died	2021-11-08 10:18:33.543+00	\N	\N	2021-11-08 10:18:51.481+00	2021-11-08 10:18:51.627+00
1125	\N	died	2021-11-08 10:18:33.44+00	\N	\N	2021-11-08 10:18:50.915+00	2021-11-08 10:18:51.06+00
1130	\N	died	2021-11-08 10:18:33.452+00	\N	\N	2021-11-08 10:18:51.055+00	2021-11-08 10:18:51.321+00
1140	\N	died	2021-11-08 10:18:33.506+00	\N	\N	2021-11-08 10:18:51.298+00	2021-11-08 10:18:51.466+00
1132	\N	died	2021-11-08 10:18:33.47+00	\N	\N	2021-11-08 10:18:51.099+00	2021-11-08 10:18:51.485+00
3069	\N	died	2021-11-08 10:18:41.22+00	\N	\N	2021-11-08 10:19:32.461+00	2021-11-08 10:19:32.923+00
3079	\N	died	2021-11-08 10:18:41.251+00	\N	\N	2021-11-08 10:19:32.819+00	2021-11-08 10:19:33.065+00
3087	\N	died	2021-11-08 10:18:41.271+00	\N	\N	2021-11-08 10:19:32.996+00	2021-11-08 10:19:33.278+00
5358	\N	died	2021-11-08 10:19:45.406+00	\N	\N	2021-11-08 10:20:32.596+00	2021-11-08 10:20:33.174+00
3097	\N	died	2021-11-08 10:18:41.294+00	\N	\N	2021-11-08 10:19:33.219+00	2021-11-08 10:19:33.491+00
3123	\N	died	2021-11-08 10:18:41.356+00	\N	\N	2021-11-08 10:19:33.802+00	2021-11-08 10:19:34.089+00
497	\N	died	2021-11-08 10:18:11.191+00	\N	\N	2021-11-08 10:18:22.505+00	2021-11-08 10:18:22.925+00
507	\N	died	2021-11-08 10:18:11.573+00	\N	\N	2021-11-08 10:18:23.058+00	2021-11-08 10:18:23.396+00
3235	\N	died	2021-11-08 10:18:41.634+00	\N	\N	2021-11-08 10:19:35.963+00	2021-11-08 10:19:36.359+00
519	\N	died	2021-11-08 10:18:12.17+00	\N	\N	2021-11-08 10:18:23.642+00	2021-11-08 10:18:23.966+00
529	\N	died	2021-11-08 10:18:12.497+00	\N	\N	2021-11-08 10:18:23.978+00	2021-11-08 10:18:24.078+00
3072	\N	died	2021-11-08 10:18:41.228+00	\N	\N	2021-11-08 10:19:32.502+00	2021-11-08 10:19:32.923+00
532	\N	died	2021-11-08 10:18:12.509+00	\N	\N	2021-11-08 10:18:24.065+00	2021-11-08 10:18:24.326+00
536	\N	died	2021-11-08 10:18:12.607+00	\N	\N	2021-11-08 10:18:24.264+00	2021-11-08 10:18:25.172+00
552	\N	died	2021-11-08 10:18:13.054+00	\N	\N	2021-11-08 10:18:24.875+00	2021-11-08 10:18:25.721+00
3081	\N	died	2021-11-08 10:18:41.258+00	\N	\N	2021-11-08 10:19:32.852+00	2021-11-08 10:19:33.278+00
570	\N	died	2021-11-08 10:18:13.633+00	\N	\N	2021-11-08 10:18:25.704+00	2021-11-08 10:18:26.376+00
583	\N	died	2021-11-08 10:18:14.176+00	\N	\N	2021-11-08 10:18:26.621+00	2021-11-08 10:18:27.13+00
415	\N	died	2021-11-08 10:18:09.336+00	\N	\N	2021-11-08 10:18:19.228+00	2021-11-08 10:18:19.477+00
591	\N	died	2021-11-08 10:18:14.667+00	\N	\N	2021-11-08 10:18:27.104+00	2021-11-08 10:18:27.417+00
420	\N	died	2021-11-08 10:18:09.387+00	\N	\N	2021-11-08 10:18:19.465+00	2021-11-08 10:18:19.766+00
3096	\N	died	2021-11-08 10:18:41.287+00	\N	\N	2021-11-08 10:19:33.194+00	2021-11-08 10:19:33.407+00
428	\N	died	2021-11-08 10:18:09.44+00	\N	\N	2021-11-08 10:18:19.702+00	2021-11-08 10:18:20.129+00
443	\N	died	2021-11-08 10:18:09.568+00	\N	\N	2021-11-08 10:18:20.095+00	2021-11-08 10:18:20.739+00
597	\N	died	2021-11-08 10:18:14.958+00	\N	\N	2021-11-08 10:18:27.395+00	2021-11-08 10:18:27.674+00
458	\N	died	2021-11-08 10:18:09.85+00	\N	\N	2021-11-08 10:18:20.808+00	2021-11-08 10:18:21.046+00
3249	\N	died	2021-11-08 10:18:41.676+00	\N	\N	2021-11-08 10:19:36.287+00	2021-11-08 10:19:36.595+00
466	\N	died	2021-11-08 10:18:10.14+00	\N	\N	2021-11-08 10:18:21.164+00	2021-11-08 10:18:21.604+00
601	\N	died	2021-11-08 10:18:15.264+00	\N	\N	2021-11-08 10:18:27.674+00	2021-11-08 10:18:28.149+00
476	\N	died	2021-11-08 10:18:10.515+00	\N	\N	2021-11-08 10:18:21.596+00	2021-11-08 10:18:21.811+00
483	\N	died	2021-11-08 10:18:10.74+00	\N	\N	2021-11-08 10:18:21.896+00	2021-11-08 10:18:22.494+00
3107	\N	died	2021-11-08 10:18:41.309+00	\N	\N	2021-11-08 10:19:33.404+00	2021-11-08 10:19:33.656+00
609	\N	died	2021-11-08 10:18:15.857+00	\N	\N	2021-11-08 10:18:28.171+00	2021-11-08 10:18:28.477+00
617	\N	died	2021-11-08 10:18:16.541+00	\N	\N	2021-11-08 10:18:28.75+00	2021-11-08 10:18:29.322+00
3114	\N	died	2021-11-08 10:18:41.332+00	\N	\N	2021-11-08 10:19:33.603+00	2021-11-08 10:19:33.925+00
634	\N	died	2021-11-08 10:18:17.885+00	\N	\N	2021-11-08 10:18:29.847+00	2021-11-08 10:18:30.345+00
649	\N	died	2021-11-08 10:18:18.733+00	\N	\N	2021-11-08 10:18:30.672+00	2021-11-08 10:18:31.349+00
662	\N	died	2021-11-08 10:18:19.185+00	\N	\N	2021-11-08 10:18:31.267+00	2021-11-08 10:18:31.837+00
3127	\N	died	2021-11-08 10:18:41.364+00	\N	\N	2021-11-08 10:19:33.869+00	2021-11-08 10:19:34.106+00
674	\N	died	2021-11-08 10:18:19.785+00	\N	\N	2021-11-08 10:18:31.895+00	2021-11-08 10:18:32.614+00
3265	\N	died	2021-11-08 10:18:41.712+00	\N	\N	2021-11-08 10:19:36.549+00	2021-11-08 10:19:36.974+00
3138	\N	died	2021-11-08 10:18:41.387+00	\N	\N	2021-11-08 10:19:34.102+00	2021-11-08 10:19:34.182+00
3141	\N	died	2021-11-08 10:18:41.4+00	\N	\N	2021-11-08 10:19:34.144+00	2021-11-08 10:19:34.332+00
3149	\N	died	2021-11-08 10:18:41.424+00	\N	\N	2021-11-08 10:19:34.327+00	2021-11-08 10:19:34.566+00
3280	\N	died	2021-11-08 10:18:41.743+00	\N	\N	2021-11-08 10:19:36.969+00	2021-11-08 10:19:37.225+00
3159	\N	died	2021-11-08 10:18:41.446+00	\N	\N	2021-11-08 10:19:34.548+00	2021-11-08 10:19:34.867+00
5366	\N	died	2021-11-08 10:19:45.572+00	\N	\N	2021-11-08 10:20:32.746+00	2021-11-08 10:20:32.995+00
3175	\N	died	2021-11-08 10:18:41.492+00	\N	\N	2021-11-08 10:19:34.861+00	2021-11-08 10:19:35.119+00
3185	\N	died	2021-11-08 10:18:41.514+00	\N	\N	2021-11-08 10:19:35.077+00	2021-11-08 10:19:35.424+00
3203	\N	died	2021-11-08 10:18:41.568+00	\N	\N	2021-11-08 10:19:35.371+00	2021-11-08 10:19:35.777+00
3224	\N	died	2021-11-08 10:18:41.61+00	\N	\N	2021-11-08 10:19:35.744+00	2021-11-08 10:19:35.865+00
5373	\N	died	2021-11-08 10:19:45.756+00	\N	\N	2021-11-08 10:20:32.987+00	2021-11-08 10:20:33.292+00
3229	\N	died	2021-11-08 10:18:41.617+00	\N	\N	2021-11-08 10:19:35.861+00	2021-11-08 10:19:35.898+00
5451	\N	died	2021-11-08 10:19:46.932+00	\N	\N	2021-11-08 10:20:34.637+00	2021-11-08 10:20:35.051+00
3231	\N	died	2021-11-08 10:18:41.625+00	\N	\N	2021-11-08 10:19:35.894+00	2021-11-08 10:19:35.999+00
3287	\N	died	2021-11-08 10:18:41.762+00	\N	\N	2021-11-08 10:19:37.09+00	2021-11-08 10:19:37.441+00
5383	\N	died	2021-11-08 10:19:46.299+00	\N	\N	2021-11-08 10:20:33.27+00	2021-11-08 10:20:33.666+00
3302	\N	died	2021-11-08 10:18:41.796+00	\N	\N	2021-11-08 10:19:37.437+00	2021-11-08 10:19:37.524+00
3307	\N	died	2021-11-08 10:18:41.809+00	\N	\N	2021-11-08 10:19:37.519+00	2021-11-08 10:19:37.702+00
3311	\N	died	2021-11-08 10:18:41.815+00	\N	\N	2021-11-08 10:19:37.696+00	2021-11-08 10:19:37.784+00
5403	\N	died	2021-11-08 10:19:46.745+00	\N	\N	2021-11-08 10:20:33.654+00	2021-11-08 10:20:34.104+00
3313	\N	died	2021-11-08 10:18:41.821+00	\N	\N	2021-11-08 10:19:37.78+00	2021-11-08 10:19:37.937+00
5517	\N	died	2021-11-08 10:19:48.248+00	\N	\N	2021-11-08 10:20:36.373+00	2021-11-08 10:20:37.127+00
3320	\N	died	2021-11-08 10:18:41.835+00	\N	\N	2021-11-08 10:19:37.932+00	2021-11-08 10:19:38+00
3324	\N	died	2021-11-08 10:18:41.843+00	\N	\N	2021-11-08 10:19:37.995+00	2021-11-08 10:19:38.166+00
5423	\N	died	2021-11-08 10:19:46.828+00	\N	\N	2021-11-08 10:20:34.037+00	2021-11-08 10:20:34.257+00
3331	\N	died	2021-11-08 10:18:41.863+00	\N	\N	2021-11-08 10:19:38.158+00	2021-11-08 10:19:38.191+00
5429	\N	died	2021-11-08 10:19:46.901+00	\N	\N	2021-11-08 10:20:34.17+00	2021-11-08 10:20:34.41+00
5491	\N	died	2021-11-08 10:19:47.748+00	\N	\N	2021-11-08 10:20:35.68+00	2021-11-08 10:20:35.797+00
5439	\N	died	2021-11-08 10:19:46.916+00	\N	\N	2021-11-08 10:20:34.371+00	2021-11-08 10:20:34.785+00
5501	\N	died	2021-11-08 10:19:47.947+00	\N	\N	2021-11-08 10:20:35.955+00	2021-11-08 10:20:36.396+00
5466	\N	died	2021-11-08 10:19:47.036+00	\N	\N	2021-11-08 10:20:35.038+00	2021-11-08 10:20:35.352+00
5474	\N	died	2021-11-08 10:19:47.285+00	\N	\N	2021-11-08 10:20:35.188+00	2021-11-08 10:20:35.685+00
5496	\N	died	2021-11-08 10:19:47.867+00	\N	\N	2021-11-08 10:20:35.789+00	2021-11-08 10:20:36.051+00
5535	\N	died	2021-11-08 10:19:48.707+00	\N	\N	2021-11-08 10:20:37.109+00	2021-11-08 10:20:37.324+00
5541	\N	died	2021-11-08 10:19:48.858+00	\N	\N	2021-11-08 10:20:37.316+00	2021-11-08 10:20:37.366+00
5543	\N	died	2021-11-08 10:19:48.89+00	\N	\N	2021-11-08 10:20:37.357+00	2021-11-08 10:20:37.468+00
5548	\N	died	2021-11-08 10:19:49.006+00	\N	\N	2021-11-08 10:20:37.464+00	2021-11-08 10:20:37.655+00
633	\N	died	2021-11-08 10:18:17.882+00	\N	\N	2021-11-08 10:18:29.839+00	2021-11-08 10:18:30.525+00
676	\N	died	2021-11-08 10:18:19.866+00	\N	\N	2021-11-08 10:18:31.989+00	2021-11-08 10:18:32.872+00
646	\N	died	2021-11-08 10:18:18.608+00	\N	\N	2021-11-08 10:18:30.54+00	2021-11-08 10:18:30.953+00
857	\N	died	2021-11-08 10:18:30.637+00	\N	\N	2021-11-08 10:18:44.192+00	2021-11-08 10:18:44.76+00
657	\N	died	2021-11-08 10:18:19.015+00	\N	\N	2021-11-08 10:18:30.983+00	2021-11-08 10:18:31.349+00
664	\N	died	2021-11-08 10:18:19.22+00	\N	\N	2021-11-08 10:18:31.326+00	2021-11-08 10:18:31.557+00
414	\N	died	2021-11-08 10:18:09.325+00	\N	\N	2021-11-08 10:18:19.218+00	2021-11-08 10:18:19.477+00
667	\N	died	2021-11-08 10:18:19.428+00	\N	\N	2021-11-08 10:18:31.588+00	2021-11-08 10:18:31.837+00
419	\N	died	2021-11-08 10:18:09.375+00	\N	\N	2021-11-08 10:18:19.434+00	2021-11-08 10:18:19.836+00
433	\N	died	2021-11-08 10:18:09.499+00	\N	\N	2021-11-08 10:18:19.841+00	2021-11-08 10:18:20.027+00
866	\N	died	2021-11-08 10:18:31.043+00	\N	\N	2021-11-08 10:18:44.568+00	2021-11-08 10:18:44.922+00
438	\N	died	2021-11-08 10:18:09.541+00	\N	\N	2021-11-08 10:18:19.968+00	2021-11-08 10:18:21.046+00
692	\N	died	2021-11-08 10:18:20.778+00	\N	\N	2021-11-08 10:18:32.897+00	2021-11-08 10:18:33.225+00
461	\N	died	2021-11-08 10:18:09.948+00	\N	\N	2021-11-08 10:18:20.925+00	2021-11-08 10:18:21.604+00
475	\N	died	2021-11-08 10:18:10.507+00	\N	\N	2021-11-08 10:18:21.583+00	2021-11-08 10:18:21.722+00
480	\N	died	2021-11-08 10:18:10.624+00	\N	\N	2021-11-08 10:18:21.755+00	2021-11-08 10:18:21.96+00
485	\N	died	2021-11-08 10:18:10.806+00	\N	\N	2021-11-08 10:18:21.976+00	2021-11-08 10:18:22.188+00
701	\N	died	2021-11-08 10:18:21.17+00	\N	\N	2021-11-08 10:18:33.359+00	2021-11-08 10:18:33.938+00
490	\N	died	2021-11-08 10:18:10.989+00	\N	\N	2021-11-08 10:18:22.222+00	2021-11-08 10:18:22.791+00
501	\N	died	2021-11-08 10:18:11.357+00	\N	\N	2021-11-08 10:18:22.769+00	2021-11-08 10:18:22.925+00
505	\N	died	2021-11-08 10:18:11.457+00	\N	\N	2021-11-08 10:18:22.903+00	2021-11-08 10:18:23.299+00
712	\N	died	2021-11-08 10:18:21.661+00	\N	\N	2021-11-08 10:18:33.981+00	2021-11-08 10:18:34.845+00
512	\N	died	2021-11-08 10:18:11.834+00	\N	\N	2021-11-08 10:18:23.23+00	2021-11-08 10:18:23.966+00
877	\N	died	2021-11-08 10:18:31.148+00	\N	\N	2021-11-08 10:18:44.918+00	2021-11-08 10:18:45.218+00
528	\N	died	2021-11-08 10:18:12.492+00	\N	\N	2021-11-08 10:18:23.952+00	2021-11-08 10:18:24.024+00
530	\N	died	2021-11-08 10:18:12.504+00	\N	\N	2021-11-08 10:18:24.014+00	2021-11-08 10:18:24.127+00
728	\N	died	2021-11-08 10:18:22.515+00	\N	\N	2021-11-08 10:18:34.89+00	2021-11-08 10:18:35.689+00
533	\N	died	2021-11-08 10:18:12.518+00	\N	\N	2021-11-08 10:18:24.109+00	2021-11-08 10:18:24.326+00
1019	\N	died	2021-11-08 10:18:32.949+00	\N	\N	2021-11-08 10:18:48.609+00	2021-11-08 10:18:48.791+00
539	\N	died	2021-11-08 10:18:12.656+00	\N	\N	2021-11-08 10:18:24.322+00	2021-11-08 10:18:24.743+00
550	\N	died	2021-11-08 10:18:13.032+00	\N	\N	2021-11-08 10:18:24.814+00	2021-11-08 10:18:25.978+00
741	\N	died	2021-11-08 10:18:23.261+00	\N	\N	2021-11-08 10:18:35.665+00	2021-11-08 10:18:35.824+00
576	\N	died	2021-11-08 10:18:13.774+00	\N	\N	2021-11-08 10:18:25.924+00	2021-11-08 10:18:26.431+00
585	\N	died	2021-11-08 10:18:14.208+00	\N	\N	2021-11-08 10:18:26.67+00	2021-11-08 10:18:27.674+00
600	\N	died	2021-11-08 10:18:15.232+00	\N	\N	2021-11-08 10:18:27.638+00	2021-11-08 10:18:27.936+00
744	\N	died	2021-11-08 10:18:23.385+00	\N	\N	2021-11-08 10:18:35.804+00	2021-11-08 10:18:36.207+00
605	\N	died	2021-11-08 10:18:15.474+00	\N	\N	2021-11-08 10:18:27.861+00	2021-11-08 10:18:28.91+00
884	\N	died	2021-11-08 10:18:31.217+00	\N	\N	2021-11-08 10:18:45.148+00	2021-11-08 10:18:45.435+00
627	\N	died	2021-11-08 10:18:17.32+00	\N	\N	2021-11-08 10:18:29.36+00	2021-11-08 10:18:29.781+00
747	\N	died	2021-11-08 10:18:23.524+00	\N	\N	2021-11-08 10:18:35.988+00	2021-11-08 10:18:36.467+00
1090	\N	died	2021-11-08 10:18:33.271+00	\N	\N	2021-11-08 10:18:50.165+00	2021-11-08 10:18:50.435+00
764	\N	died	2021-11-08 10:18:24.41+00	\N	\N	2021-11-08 10:18:36.935+00	2021-11-08 10:18:37.115+00
770	\N	died	2021-11-08 10:18:24.737+00	\N	\N	2021-11-08 10:18:37.34+00	2021-11-08 10:18:37.808+00
898	\N	died	2021-11-08 10:18:31.301+00	\N	\N	2021-11-08 10:18:45.431+00	2021-11-08 10:18:45.52+00
778	\N	died	2021-11-08 10:18:25.164+00	\N	\N	2021-11-08 10:18:37.776+00	2021-11-08 10:18:37.911+00
784	\N	died	2021-11-08 10:18:25.436+00	\N	\N	2021-11-08 10:18:38.076+00	2021-11-08 10:18:39.206+00
799	\N	died	2021-11-08 10:18:26.536+00	\N	\N	2021-11-08 10:18:39.322+00	2021-11-08 10:18:39.688+00
903	\N	died	2021-11-08 10:18:31.322+00	\N	\N	2021-11-08 10:18:45.515+00	2021-11-08 10:18:45.785+00
804	\N	died	2021-11-08 10:18:26.803+00	\N	\N	2021-11-08 10:18:39.67+00	2021-11-08 10:18:40.15+00
1027	\N	died	2021-11-08 10:18:32.981+00	\N	\N	2021-11-08 10:18:48.787+00	2021-11-08 10:18:49.013+00
809	\N	died	2021-11-08 10:18:27.114+00	\N	\N	2021-11-08 10:18:40.117+00	2021-11-08 10:18:40.662+00
910	\N	died	2021-11-08 10:18:31.568+00	\N	\N	2021-11-08 10:18:45.8+00	2021-11-08 10:18:46.309+00
820	\N	died	2021-11-08 10:18:27.758+00	\N	\N	2021-11-08 10:18:40.884+00	2021-11-08 10:18:41.36+00
834	\N	died	2021-11-08 10:18:28.664+00	\N	\N	2021-11-08 10:18:41.937+00	2021-11-08 10:18:42.574+00
843	\N	died	2021-11-08 10:18:29.518+00	\N	\N	2021-11-08 10:18:42.807+00	2021-11-08 10:18:43.569+00
848	\N	died	2021-11-08 10:18:29.926+00	\N	\N	2021-11-08 10:18:43.586+00	2021-11-08 10:18:43.911+00
1031	\N	died	2021-11-08 10:18:33.008+00	\N	\N	2021-11-08 10:18:48.858+00	2021-11-08 10:18:49.224+00
922	\N	died	2021-11-08 10:18:31.814+00	\N	\N	2021-11-08 10:18:46.316+00	2021-11-08 10:18:46.658+00
934	\N	died	2021-11-08 10:18:31.941+00	\N	\N	2021-11-08 10:18:46.559+00	2021-11-08 10:18:47.272+00
958	\N	died	2021-11-08 10:18:32.404+00	\N	\N	2021-11-08 10:18:47.265+00	2021-11-08 10:18:47.536+00
1101	\N	died	2021-11-08 10:18:33.327+00	\N	\N	2021-11-08 10:18:50.416+00	2021-11-08 10:18:50.84+00
968	\N	died	2021-11-08 10:18:32.547+00	\N	\N	2021-11-08 10:18:47.503+00	2021-11-08 10:18:47.969+00
1171	\N	died	2021-11-08 10:18:33.655+00	\N	\N	2021-11-08 10:18:51.957+00	2021-11-08 10:18:52.174+00
985	\N	died	2021-11-08 10:18:32.789+00	\N	\N	2021-11-08 10:18:47.899+00	2021-11-08 10:18:48.385+00
1002	\N	died	2021-11-08 10:18:32.878+00	\N	\N	2021-11-08 10:18:48.283+00	2021-11-08 10:18:48.503+00
1119	\N	died	2021-11-08 10:18:33.411+00	\N	\N	2021-11-08 10:18:50.815+00	2021-11-08 10:18:51.27+00
1012	\N	died	2021-11-08 10:18:32.927+00	\N	\N	2021-11-08 10:18:48.499+00	2021-11-08 10:18:48.645+00
1045	\N	died	2021-11-08 10:18:33.081+00	\N	\N	2021-11-08 10:18:49.207+00	2021-11-08 10:18:49.662+00
1060	\N	died	2021-11-08 10:18:33.146+00	\N	\N	2021-11-08 10:18:49.512+00	2021-11-08 10:18:49.705+00
1153	\N	died	2021-11-08 10:18:33.56+00	\N	\N	2021-11-08 10:18:51.554+00	2021-11-08 10:18:51.945+00
1069	\N	died	2021-11-08 10:18:33.187+00	\N	\N	2021-11-08 10:18:49.705+00	2021-11-08 10:18:49.902+00
1075	\N	died	2021-11-08 10:18:33.209+00	\N	\N	2021-11-08 10:18:49.865+00	2021-11-08 10:18:50.186+00
1162	\N	died	2021-11-08 10:18:33.604+00	\N	\N	2021-11-08 10:18:51.754+00	2021-11-08 10:18:52.081+00
1137	\N	died	2021-11-08 10:18:33.497+00	\N	\N	2021-11-08 10:18:51.241+00	2021-11-08 10:18:51.696+00
3071	\N	died	2021-11-08 10:18:41.228+00	\N	\N	2021-11-08 10:19:32.485+00	2021-11-08 10:19:32.957+00
1158	\N	died	2021-11-08 10:18:33.594+00	\N	\N	2021-11-08 10:18:51.69+00	2021-11-08 10:18:51.778+00
3106	\N	died	2021-11-08 10:18:41.309+00	\N	\N	2021-11-08 10:19:33.394+00	2021-11-08 10:19:33.656+00
1170	\N	died	2021-11-08 10:18:33.642+00	\N	\N	2021-11-08 10:18:51.941+00	2021-11-08 10:18:52.095+00
3084	\N	died	2021-11-08 10:18:41.265+00	\N	\N	2021-11-08 10:19:32.953+00	2021-11-08 10:19:33.065+00
3116	\N	died	2021-11-08 10:18:41.339+00	\N	\N	2021-11-08 10:19:33.636+00	2021-11-08 10:19:34.089+00
3089	\N	died	2021-11-08 10:18:41.28+00	\N	\N	2021-11-08 10:19:33.032+00	2021-11-08 10:19:33.407+00
1179	\N	died	2021-11-08 10:18:33.684+00	\N	\N	2021-11-08 10:18:52.09+00	2021-11-08 10:18:52.212+00
3140	\N	died	2021-11-08 10:18:41.4+00	\N	\N	2021-11-08 10:19:34.129+00	2021-11-08 10:19:34.299+00
1173	\N	died	2021-11-08 10:18:33.661+00	\N	\N	2021-11-08 10:18:51.991+00	2021-11-08 10:18:52.281+00
1181	\N	died	2021-11-08 10:18:33.689+00	\N	\N	2021-11-08 10:18:52.17+00	2021-11-08 10:18:52.281+00
1183	\N	died	2021-11-08 10:18:33.698+00	\N	\N	2021-11-08 10:18:52.208+00	2021-11-08 10:18:52.281+00
5407	\N	died	2021-11-08 10:19:46.751+00	\N	\N	2021-11-08 10:20:33.704+00	2021-11-08 10:20:34.026+00
3131	\N	died	2021-11-08 10:18:41.371+00	\N	\N	2021-11-08 10:19:33.939+00	2021-11-08 10:19:34.133+00
5379	\N	died	2021-11-08 10:19:46.072+00	\N	\N	2021-11-08 10:20:33.204+00	2021-11-08 10:20:33.495+00
3145	\N	died	2021-11-08 10:18:41.415+00	\N	\N	2021-11-08 10:19:34.265+00	2021-11-08 10:19:34.566+00
3156	\N	died	2021-11-08 10:18:41.439+00	\N	\N	2021-11-08 10:19:34.494+00	2021-11-08 10:19:34.632+00
5392	\N	died	2021-11-08 10:19:46.564+00	\N	\N	2021-11-08 10:20:33.454+00	2021-11-08 10:20:33.716+00
5421	\N	died	2021-11-08 10:19:46.825+00	\N	\N	2021-11-08 10:20:34.005+00	2021-11-08 10:20:34.41+00
668	\N	died	2021-11-08 10:18:19.46+00	\N	\N	2021-11-08 10:18:31.63+00	2021-11-08 10:18:32.099+00
675	\N	died	2021-11-08 10:18:19.817+00	\N	\N	2021-11-08 10:18:31.932+00	2021-11-08 10:18:32.663+00
881	\N	died	2021-11-08 10:18:31.202+00	\N	\N	2021-11-08 10:18:45.044+00	2021-11-08 10:18:45.35+00
694	\N	died	2021-11-08 10:18:20.857+00	\N	\N	2021-11-08 10:18:32.995+00	2021-11-08 10:18:33.225+00
410	\N	died	2021-11-08 10:18:09.119+00	\N	\N	2021-11-08 10:18:19.021+00	2021-11-08 10:18:19.242+00
416	\N	died	2021-11-08 10:18:09.344+00	\N	\N	2021-11-08 10:18:19.244+00	2021-11-08 10:18:19.766+00
423	\N	died	2021-11-08 10:18:09.407+00	\N	\N	2021-11-08 10:18:19.56+00	2021-11-08 10:18:19.897+00
699	\N	died	2021-11-08 10:18:21.077+00	\N	\N	2021-11-08 10:18:33.25+00	2021-11-08 10:18:33.592+00
435	\N	died	2021-11-08 10:18:09.514+00	\N	\N	2021-11-08 10:18:19.889+00	2021-11-08 10:18:20.129+00
442	\N	died	2021-11-08 10:18:09.568+00	\N	\N	2021-11-08 10:18:20.074+00	2021-11-08 10:18:20.739+00
455	\N	died	2021-11-08 10:18:09.733+00	\N	\N	2021-11-08 10:18:20.68+00	2021-11-08 10:18:21.311+00
708	\N	died	2021-11-08 10:18:21.469+00	\N	\N	2021-11-08 10:18:33.721+00	2021-11-08 10:18:34.23+00
471	\N	died	2021-11-08 10:18:10.329+00	\N	\N	2021-11-08 10:18:21.371+00	2021-11-08 10:18:21.722+00
891	\N	died	2021-11-08 10:18:31.263+00	\N	\N	2021-11-08 10:18:45.264+00	2021-11-08 10:18:45.589+00
482	\N	died	2021-11-08 10:18:10.699+00	\N	\N	2021-11-08 10:18:21.85+00	2021-11-08 10:18:22.276+00
493	\N	died	2021-11-08 10:18:11.062+00	\N	\N	2021-11-08 10:18:22.317+00	2021-11-08 10:18:23.051+00
717	\N	died	2021-11-08 10:18:21.898+00	\N	\N	2021-11-08 10:18:34.263+00	2021-11-08 10:18:34.481+00
508	\N	died	2021-11-08 10:18:11.645+00	\N	\N	2021-11-08 10:18:23.084+00	2021-11-08 10:18:23.438+00
1033	\N	died	2021-11-08 10:18:33.018+00	\N	\N	2021-11-08 10:18:48.891+00	2021-11-08 10:18:49.312+00
517	\N	died	2021-11-08 10:18:11.983+00	\N	\N	2021-11-08 10:18:23.458+00	2021-11-08 10:18:23.966+00
525	\N	died	2021-11-08 10:18:12.427+00	\N	\N	2021-11-08 10:18:23.877+00	2021-11-08 10:18:24.363+00
720	\N	died	2021-11-08 10:18:22.08+00	\N	\N	2021-11-08 10:18:34.456+00	2021-11-08 10:18:34.845+00
540	\N	died	2021-11-08 10:18:12.659+00	\N	\N	2021-11-08 10:18:24.351+00	2021-11-08 10:18:24.743+00
548	\N	died	2021-11-08 10:18:12.967+00	\N	\N	2021-11-08 10:18:24.719+00	2021-11-08 10:18:25.172+00
729	\N	died	2021-11-08 10:18:22.552+00	\N	\N	2021-11-08 10:18:34.937+00	2021-11-08 10:18:35.108+00
555	\N	died	2021-11-08 10:18:13.151+00	\N	\N	2021-11-08 10:18:25.037+00	2021-11-08 10:18:25.536+00
569	\N	died	2021-11-08 10:18:13.598+00	\N	\N	2021-11-08 10:18:25.653+00	2021-11-08 10:18:25.978+00
904	\N	died	2021-11-08 10:18:31.328+00	\N	\N	2021-11-08 10:18:45.584+00	2021-11-08 10:18:45.785+00
577	\N	died	2021-11-08 10:18:13.809+00	\N	\N	2021-11-08 10:18:26.032+00	2021-11-08 10:18:26.614+00
581	\N	died	2021-11-08 10:18:14.086+00	\N	\N	2021-11-08 10:18:26.526+00	2021-11-08 10:18:27.018+00
740	\N	died	2021-11-08 10:18:23.216+00	\N	\N	2021-11-08 10:18:35.63+00	2021-11-08 10:18:36.41+00
588	\N	died	2021-11-08 10:18:14.482+00	\N	\N	2021-11-08 10:18:26.934+00	2021-11-08 10:18:27.417+00
1106	\N	died	2021-11-08 10:18:33.348+00	\N	\N	2021-11-08 10:18:50.498+00	2021-11-08 10:18:50.637+00
598	\N	died	2021-11-08 10:18:15.02+00	\N	\N	2021-11-08 10:18:27.447+00	2021-11-08 10:18:27.78+00
752	\N	died	2021-11-08 10:18:23.816+00	\N	\N	2021-11-08 10:18:36.302+00	2021-11-08 10:18:36.544+00
606	\N	died	2021-11-08 10:18:15.541+00	\N	\N	2021-11-08 10:18:27.917+00	2021-11-08 10:18:28.424+00
613	\N	died	2021-11-08 10:18:16.167+00	\N	\N	2021-11-08 10:18:28.446+00	2021-11-08 10:18:28.91+00
908	\N	died	2021-11-08 10:18:31.516+00	\N	\N	2021-11-08 10:18:45.765+00	2021-11-08 10:18:46.23+00
618	\N	died	2021-11-08 10:18:16.691+00	\N	\N	2021-11-08 10:18:28.872+00	2021-11-08 10:18:29.112+00
630	\N	died	2021-11-08 10:18:17.587+00	\N	\N	2021-11-08 10:18:29.594+00	2021-11-08 10:18:30.128+00
758	\N	died	2021-11-08 10:18:24.135+00	\N	\N	2021-11-08 10:18:36.617+00	2021-11-08 10:18:37.026+00
640	\N	died	2021-11-08 10:18:18.226+00	\N	\N	2021-11-08 10:18:30.19+00	2021-11-08 10:18:30.35+00
645	\N	died	2021-11-08 10:18:18.549+00	\N	\N	2021-11-08 10:18:30.497+00	2021-11-08 10:18:30.838+00
768	\N	died	2021-11-08 10:18:24.574+00	\N	\N	2021-11-08 10:18:37.152+00	2021-11-08 10:18:37.808+00
654	\N	died	2021-11-08 10:18:18.983+00	\N	\N	2021-11-08 10:18:30.931+00	2021-11-08 10:18:31.105+00
659	\N	died	2021-11-08 10:18:19.077+00	\N	\N	2021-11-08 10:18:31.082+00	2021-11-08 10:18:31.557+00
920	\N	died	2021-11-08 10:18:31.759+00	\N	\N	2021-11-08 10:18:46.262+00	2021-11-08 10:18:46.402+00
780	\N	died	2021-11-08 10:18:25.255+00	\N	\N	2021-11-08 10:18:37.886+00	2021-11-08 10:18:38.002+00
1051	\N	died	2021-11-08 10:18:33.109+00	\N	\N	2021-11-08 10:18:49.308+00	2021-11-08 10:18:49.429+00
783	\N	died	2021-11-08 10:18:25.393+00	\N	\N	2021-11-08 10:18:38.026+00	2021-11-08 10:18:38.521+00
790	\N	died	2021-11-08 10:18:25.714+00	\N	\N	2021-11-08 10:18:38.417+00	2021-11-08 10:18:39.688+00
925	\N	died	2021-11-08 10:18:31.858+00	\N	\N	2021-11-08 10:18:46.402+00	2021-11-08 10:18:46.658+00
805	\N	died	2021-11-08 10:18:26.874+00	\N	\N	2021-11-08 10:18:39.756+00	2021-11-08 10:18:40.15+00
811	\N	died	2021-11-08 10:18:27.201+00	\N	\N	2021-11-08 10:18:40.243+00	2021-11-08 10:18:40.745+00
932	\N	died	2021-11-08 10:18:31.923+00	\N	\N	2021-11-08 10:18:46.524+00	2021-11-08 10:18:47.119+00
822	\N	died	2021-11-08 10:18:27.87+00	\N	\N	2021-11-08 10:18:41.016+00	2021-11-08 10:18:41.723+00
833	\N	died	2021-11-08 10:18:28.603+00	\N	\N	2021-11-08 10:18:41.86+00	2021-11-08 10:18:42.215+00
838	\N	died	2021-11-08 10:18:29.004+00	\N	\N	2021-11-08 10:18:42.292+00	2021-11-08 10:18:42.856+00
853	\N	died	2021-11-08 10:18:30.33+00	\N	\N	2021-11-08 10:18:43.927+00	2021-11-08 10:18:44.152+00
1055	\N	died	2021-11-08 10:18:33.124+00	\N	\N	2021-11-08 10:18:49.424+00	2021-11-08 10:18:49.662+00
859	\N	died	2021-11-08 10:18:30.758+00	\N	\N	2021-11-08 10:18:44.289+00	2021-11-08 10:18:44.76+00
868	\N	died	2021-11-08 10:18:31.079+00	\N	\N	2021-11-08 10:18:44.638+00	2021-11-08 10:18:45.047+00
953	\N	died	2021-11-08 10:18:32.363+00	\N	\N	2021-11-08 10:18:47.139+00	2021-11-08 10:18:47.298+00
1064	\N	died	2021-11-08 10:18:33.165+00	\N	\N	2021-11-08 10:18:49.622+00	2021-11-08 10:18:49.965+00
960	\N	died	2021-11-08 10:18:32.414+00	\N	\N	2021-11-08 10:18:47.294+00	2021-11-08 10:18:47.536+00
969	\N	died	2021-11-08 10:18:32.551+00	\N	\N	2021-11-08 10:18:47.515+00	2021-11-08 10:18:47.969+00
987	\N	died	2021-11-08 10:18:32.799+00	\N	\N	2021-11-08 10:18:47.931+00	2021-11-08 10:18:48.385+00
1111	\N	died	2021-11-08 10:18:33.377+00	\N	\N	2021-11-08 10:18:50.632+00	2021-11-08 10:18:50.873+00
1006	\N	died	2021-11-08 10:18:32.888+00	\N	\N	2021-11-08 10:18:48.344+00	2021-11-08 10:18:48.599+00
1160	\N	died	2021-11-08 10:18:33.6+00	\N	\N	2021-11-08 10:18:51.721+00	2021-11-08 10:18:51.778+00
1018	\N	died	2021-11-08 10:18:32.943+00	\N	\N	2021-11-08 10:18:48.59+00	2021-11-08 10:18:48.78+00
1023	\N	died	2021-11-08 10:18:32.97+00	\N	\N	2021-11-08 10:18:48.733+00	2021-11-08 10:18:49.013+00
1121	\N	died	2021-11-08 10:18:33.417+00	\N	\N	2021-11-08 10:18:50.845+00	2021-11-08 10:18:50.971+00
1081	\N	died	2021-11-08 10:18:33.228+00	\N	\N	2021-11-08 10:18:49.961+00	2021-11-08 10:18:50.186+00
1089	\N	died	2021-11-08 10:18:33.271+00	\N	\N	2021-11-08 10:18:50.152+00	2021-11-08 10:18:50.345+00
1097	\N	died	2021-11-08 10:18:33.301+00	\N	\N	2021-11-08 10:18:50.341+00	2021-11-08 10:18:50.435+00
1163	\N	died	2021-11-08 10:18:33.61+00	\N	\N	2021-11-08 10:18:51.774+00	2021-11-08 10:18:51.81+00
1102	\N	died	2021-11-08 10:18:33.332+00	\N	\N	2021-11-08 10:18:50.43+00	2021-11-08 10:18:50.503+00
3121	\N	died	2021-11-08 10:18:41.356+00	\N	\N	2021-11-08 10:19:33.724+00	2021-11-08 10:19:33.925+00
1127	\N	died	2021-11-08 10:18:33.444+00	\N	\N	2021-11-08 10:18:50.948+00	2021-11-08 10:18:51.27+00
1184	\N	died	2021-11-08 10:18:33.702+00	\N	\N	2021-11-08 10:18:52.225+00	2021-11-08 10:18:52.507+00
1136	\N	died	2021-11-08 10:18:33.492+00	\N	\N	2021-11-08 10:18:51.165+00	2021-11-08 10:18:51.627+00
1157	\N	died	2021-11-08 10:18:33.589+00	\N	\N	2021-11-08 10:18:51.622+00	2021-11-08 10:18:51.724+00
1165	\N	died	2021-11-08 10:18:33.621+00	\N	\N	2021-11-08 10:18:51.807+00	2021-11-08 10:18:52.081+00
1156	\N	died	2021-11-08 10:18:33.584+00	\N	\N	2021-11-08 10:18:51.603+00	2021-11-08 10:18:52.081+00
1172	\N	died	2021-11-08 10:18:33.655+00	\N	\N	2021-11-08 10:18:51.97+00	2021-11-08 10:18:52.281+00
3128	\N	died	2021-11-08 10:18:41.364+00	\N	\N	2021-11-08 10:19:33.887+00	2021-11-08 10:19:34.299+00
3173	\N	died	2021-11-08 10:18:41.482+00	\N	\N	2021-11-08 10:19:34.828+00	2021-11-08 10:19:35.119+00
1177	\N	died	2021-11-08 10:18:33.673+00	\N	\N	2021-11-08 10:18:52.057+00	2021-11-08 10:18:52.521+00
3146	\N	died	2021-11-08 10:18:41.415+00	\N	\N	2021-11-08 10:19:34.279+00	2021-11-08 10:19:34.566+00
1185	\N	died	2021-11-08 10:18:33.702+00	\N	\N	2021-11-08 10:18:52.237+00	2021-11-08 10:18:52.653+00
1196	\N	died	2021-11-08 10:18:33.757+00	\N	\N	2021-11-08 10:18:52.516+00	2021-11-08 10:18:52.653+00
3158	\N	died	2021-11-08 10:18:41.439+00	\N	\N	2021-11-08 10:19:34.527+00	2021-11-08 10:19:34.832+00
3183	\N	died	2021-11-08 10:18:41.506+00	\N	\N	2021-11-08 10:19:35.045+00	2021-11-08 10:19:35.424+00
3199	\N	died	2021-11-08 10:18:41.552+00	\N	\N	2021-11-08 10:19:35.307+00	2021-11-08 10:19:35.549+00
5382	\N	died	2021-11-08 10:19:46.284+00	\N	\N	2021-11-08 10:20:33.254+00	2021-11-08 10:20:33.666+00
3212	\N	died	2021-11-08 10:18:41.585+00	\N	\N	2021-11-08 10:19:35.544+00	2021-11-08 10:19:35.599+00
3215	\N	died	2021-11-08 10:18:41.594+00	\N	\N	2021-11-08 10:19:35.594+00	2021-11-08 10:19:35.777+00
3225	\N	died	2021-11-08 10:18:41.61+00	\N	\N	2021-11-08 10:19:35.752+00	2021-11-08 10:19:35.999+00
5400	\N	died	2021-11-08 10:19:46.74+00	\N	\N	2021-11-08 10:20:33.604+00	2021-11-08 10:20:33.751+00
5409	\N	died	2021-11-08 10:19:46.753+00	\N	\N	2021-11-08 10:20:33.731+00	2021-11-08 10:20:33.867+00
421	\N	died	2021-11-08 10:18:09.393+00	\N	\N	2021-11-08 10:18:19.493+00	2021-11-08 10:18:19.766+00
430	\N	died	2021-11-08 10:18:09.458+00	\N	\N	2021-11-08 10:18:19.755+00	2021-11-08 10:18:19.824+00
432	\N	died	2021-11-08 10:18:09.494+00	\N	\N	2021-11-08 10:18:19.824+00	2021-11-08 10:18:20.027+00
672	\N	died	2021-11-08 10:18:19.696+00	\N	\N	2021-11-08 10:18:31.825+00	2021-11-08 10:18:32.356+00
436	\N	died	2021-11-08 10:18:09.527+00	\N	\N	2021-11-08 10:18:19.916+00	2021-11-08 10:18:20.494+00
895	\N	died	2021-11-08 10:18:31.291+00	\N	\N	2021-11-08 10:18:45.384+00	2021-11-08 10:18:45.417+00
450	\N	died	2021-11-08 10:18:09.646+00	\N	\N	2021-11-08 10:18:20.283+00	2021-11-08 10:18:20.827+00
460	\N	died	2021-11-08 10:18:09.911+00	\N	\N	2021-11-08 10:18:20.879+00	2021-11-08 10:18:21.134+00
465	\N	died	2021-11-08 10:18:10.093+00	\N	\N	2021-11-08 10:18:21.107+00	2021-11-08 10:18:21.311+00
897	\N	died	2021-11-08 10:18:31.296+00	\N	\N	2021-11-08 10:18:45.413+00	2021-11-08 10:18:45.483+00
470	\N	died	2021-11-08 10:18:10.293+00	\N	\N	2021-11-08 10:18:21.331+00	2021-11-08 10:18:21.604+00
3143	\N	died	2021-11-08 10:18:41.408+00	\N	\N	2021-11-08 10:19:34.177+00	2021-11-08 10:19:34.299+00
478	\N	died	2021-11-08 10:18:10.549+00	\N	\N	2021-11-08 10:18:21.65+00	2021-11-08 10:18:22.062+00
487	\N	died	2021-11-08 10:18:10.889+00	\N	\N	2021-11-08 10:18:22.071+00	2021-11-08 10:18:22.441+00
901	\N	died	2021-11-08 10:18:31.309+00	\N	\N	2021-11-08 10:18:45.48+00	2021-11-08 10:18:45.607+00
498	\N	died	2021-11-08 10:18:11.225+00	\N	\N	2021-11-08 10:18:22.545+00	2021-11-08 10:18:23.475+00
520	\N	died	2021-11-08 10:18:12.224+00	\N	\N	2021-11-08 10:18:23.689+00	2021-11-08 10:18:24.058+00
531	\N	died	2021-11-08 10:18:12.509+00	\N	\N	2021-11-08 10:18:24.043+00	2021-11-08 10:18:24.179+00
905	\N	died	2021-11-08 10:18:31.337+00	\N	\N	2021-11-08 10:18:45.601+00	2021-11-08 10:18:46.181+00
537	\N	died	2021-11-08 10:18:12.642+00	\N	\N	2021-11-08 10:18:24.308+00	2021-11-08 10:18:24.48+00
1161	\N	died	2021-11-08 10:18:33.604+00	\N	\N	2021-11-08 10:18:51.739+00	2021-11-08 10:18:51.945+00
544	\N	died	2021-11-08 10:18:12.799+00	\N	\N	2021-11-08 10:18:24.527+00	2021-11-08 10:18:25.172+00
558	\N	died	2021-11-08 10:18:13.283+00	\N	\N	2021-11-08 10:18:25.206+00	2021-11-08 10:18:25.355+00
914	\N	died	2021-11-08 10:18:31.639+00	\N	\N	2021-11-08 10:18:45.936+00	2021-11-08 10:18:46.658+00
564	\N	died	2021-11-08 10:18:13.432+00	\N	\N	2021-11-08 10:18:25.406+00	2021-11-08 10:18:26.376+00
1166	\N	died	2021-11-08 10:18:33.626+00	\N	\N	2021-11-08 10:18:51.825+00	2021-11-08 10:18:52.081+00
578	\N	died	2021-11-08 10:18:13.901+00	\N	\N	2021-11-08 10:18:26.328+00	2021-11-08 10:18:26.504+00
582	\N	died	2021-11-08 10:18:14.142+00	\N	\N	2021-11-08 10:18:26.587+00	2021-11-08 10:18:27.018+00
933	\N	died	2021-11-08 10:18:31.934+00	\N	\N	2021-11-08 10:18:46.547+00	2021-11-08 10:18:47.17+00
587	\N	died	2021-11-08 10:18:14.407+00	\N	\N	2021-11-08 10:18:26.865+00	2021-11-08 10:18:27.674+00
604	\N	died	2021-11-08 10:18:15.409+00	\N	\N	2021-11-08 10:18:27.809+00	2021-11-08 10:18:28.149+00
620	\N	died	2021-11-08 10:18:16.775+00	\N	\N	2021-11-08 10:18:28.936+00	2021-11-08 10:18:29.54+00
955	\N	died	2021-11-08 10:18:32.389+00	\N	\N	2021-11-08 10:18:47.173+00	2021-11-08 10:18:47.536+00
629	\N	died	2021-11-08 10:18:17.583+00	\N	\N	2021-11-08 10:18:29.586+00	2021-11-08 10:18:30.048+00
637	\N	died	2021-11-08 10:18:18.057+00	\N	\N	2021-11-08 10:18:30.025+00	2021-11-08 10:18:30.215+00
964	\N	died	2021-11-08 10:18:32.456+00	\N	\N	2021-11-08 10:18:47.376+00	2021-11-08 10:18:47.631+00
644	\N	died	2021-11-08 10:18:18.458+00	\N	\N	2021-11-08 10:18:30.419+00	2021-11-08 10:18:30.931+00
653	\N	died	2021-11-08 10:18:18.95+00	\N	\N	2021-11-08 10:18:30.898+00	2021-11-08 10:18:30.987+00
1207	\N	died	2021-11-08 10:18:33.811+00	\N	\N	2021-11-08 10:18:52.758+00	2021-11-08 10:18:53.653+00
660	\N	died	2021-11-08 10:18:19.115+00	\N	\N	2021-11-08 10:18:31.152+00	2021-11-08 10:18:31.837+00
976	\N	died	2021-11-08 10:18:32.724+00	\N	\N	2021-11-08 10:18:47.711+00	2021-11-08 10:18:48.054+00
990	\N	died	2021-11-08 10:18:32.815+00	\N	\N	2021-11-08 10:18:48.032+00	2021-11-08 10:18:48.105+00
1169	\N	died	2021-11-08 10:18:33.636+00	\N	\N	2021-11-08 10:18:51.923+00	2021-11-08 10:18:52.396+00
994	\N	died	2021-11-08 10:18:32.841+00	\N	\N	2021-11-08 10:18:48.101+00	2021-11-08 10:18:48.27+00
1174	\N	died	2021-11-08 10:18:33.661+00	\N	\N	2021-11-08 10:18:52.004+00	2021-11-08 10:18:52.396+00
999	\N	died	2021-11-08 10:18:32.863+00	\N	\N	2021-11-08 10:18:48.182+00	2021-11-08 10:18:48.574+00
1013	\N	died	2021-11-08 10:18:32.927+00	\N	\N	2021-11-08 10:18:48.511+00	2021-11-08 10:18:48.78+00
1025	\N	died	2021-11-08 10:18:32.975+00	\N	\N	2021-11-08 10:18:48.755+00	2021-11-08 10:18:49.07+00
1188	\N	died	2021-11-08 10:18:33.714+00	\N	\N	2021-11-08 10:18:52.292+00	2021-11-08 10:18:52.653+00
1038	\N	died	2021-11-08 10:18:33.046+00	\N	\N	2021-11-08 10:18:49.025+00	2021-11-08 10:18:49.119+00
1197	\N	died	2021-11-08 10:18:33.763+00	\N	\N	2021-11-08 10:18:52.536+00	2021-11-08 10:18:52.672+00
1043	\N	died	2021-11-08 10:18:33.066+00	\N	\N	2021-11-08 10:18:49.114+00	2021-11-08 10:18:49.3+00
1048	\N	died	2021-11-08 10:18:33.092+00	\N	\N	2021-11-08 10:18:49.261+00	2021-11-08 10:18:49.662+00
1193	\N	died	2021-11-08 10:18:33.746+00	\N	\N	2021-11-08 10:18:52.426+00	2021-11-08 10:18:52.709+00
1065	\N	died	2021-11-08 10:18:33.169+00	\N	\N	2021-11-08 10:18:49.64+00	2021-11-08 10:18:50.119+00
1201	\N	died	2021-11-08 10:18:33.782+00	\N	\N	2021-11-08 10:18:52.649+00	2021-11-08 10:18:52.709+00
1084	\N	died	2021-11-08 10:18:33.245+00	\N	\N	2021-11-08 10:18:50.016+00	2021-11-08 10:18:50.454+00
1103	\N	died	2021-11-08 10:18:33.337+00	\N	\N	2021-11-08 10:18:50.449+00	2021-11-08 10:18:50.609+00
1109	\N	died	2021-11-08 10:18:33.367+00	\N	\N	2021-11-08 10:18:50.606+00	2021-11-08 10:18:50.84+00
1118	\N	died	2021-11-08 10:18:33.405+00	\N	\N	2021-11-08 10:18:50.798+00	2021-11-08 10:18:51.321+00
1240	\N	died	2021-11-08 10:18:33.972+00	\N	\N	2021-11-08 10:18:53.649+00	2021-11-08 10:18:53.943+00
1139	\N	died	2021-11-08 10:18:33.501+00	\N	\N	2021-11-08 10:18:51.278+00	2021-11-08 10:18:51.369+00
1144	\N	died	2021-11-08 10:18:33.528+00	\N	\N	2021-11-08 10:18:51.365+00	2021-11-08 10:18:51.52+00
1149	\N	died	2021-11-08 10:18:33.549+00	\N	\N	2021-11-08 10:18:51.505+00	2021-11-08 10:18:51.778+00
1151	\N	died	2021-11-08 10:18:33.554+00	\N	\N	2021-11-08 10:18:51.529+00	2021-11-08 10:18:51.83+00
1250	\N	died	2021-11-08 10:18:34.028+00	\N	\N	2021-11-08 10:18:53.939+00	2021-11-08 10:18:53.978+00
3135	\N	died	2021-11-08 10:18:41.379+00	\N	\N	2021-11-08 10:19:34.052+00	2021-11-08 10:19:34.416+00
3147	\N	died	2021-11-08 10:18:41.415+00	\N	\N	2021-11-08 10:19:34.294+00	2021-11-08 10:19:34.416+00
1194	\N	died	2021-11-08 10:18:33.748+00	\N	\N	2021-11-08 10:18:52.439+00	2021-11-08 10:18:52.728+00
3154	\N	died	2021-11-08 10:18:41.431+00	\N	\N	2021-11-08 10:19:34.411+00	2021-11-08 10:19:34.566+00
3209	\N	died	2021-11-08 10:18:41.577+00	\N	\N	2021-11-08 10:19:35.504+00	2021-11-08 10:19:35.733+00
3160	\N	died	2021-11-08 10:18:41.446+00	\N	\N	2021-11-08 10:19:34.562+00	2021-11-08 10:19:34.614+00
3289	\N	died	2021-11-08 10:18:41.762+00	\N	\N	2021-11-08 10:19:37.121+00	2021-11-08 10:19:37.524+00
1202	\N	died	2021-11-08 10:18:33.787+00	\N	\N	2021-11-08 10:18:52.667+00	2021-11-08 10:18:52.777+00
1189	\N	died	2021-11-08 10:18:33.718+00	\N	\N	2021-11-08 10:18:52.308+00	2021-11-08 10:18:52.777+00
1204	\N	died	2021-11-08 10:18:33.8+00	\N	\N	2021-11-08 10:18:52.703+00	2021-11-08 10:18:52.777+00
3163	\N	died	2021-11-08 10:18:41.453+00	\N	\N	2021-11-08 10:19:34.61+00	2021-11-08 10:19:34.732+00
1190	\N	died	2021-11-08 10:18:33.722+00	\N	\N	2021-11-08 10:18:52.324+00	2021-11-08 10:18:52.843+00
3167	\N	died	2021-11-08 10:18:41.46+00	\N	\N	2021-11-08 10:19:34.728+00	2021-11-08 10:19:34.884+00
1198	\N	died	2021-11-08 10:18:33.765+00	\N	\N	2021-11-08 10:18:52.548+00	2021-11-08 10:18:52.877+00
1186	\N	died	2021-11-08 10:18:33.705+00	\N	\N	2021-11-08 10:18:52.256+00	2021-11-08 10:18:52.877+00
3176	\N	died	2021-11-08 10:18:41.492+00	\N	\N	2021-11-08 10:19:34.879+00	2021-11-08 10:19:35.119+00
3186	\N	died	2021-11-08 10:18:41.514+00	\N	\N	2021-11-08 10:19:35.094+00	2021-11-08 10:19:35.449+00
3270	\N	died	2021-11-08 10:18:41.726+00	\N	\N	2021-11-08 10:19:36.661+00	2021-11-08 10:19:36.958+00
1205	\N	died	2021-11-08 10:18:33.805+00	\N	\N	2021-11-08 10:18:52.724+00	2021-11-08 10:18:52.995+00
3205	\N	died	2021-11-08 10:18:41.568+00	\N	\N	2021-11-08 10:19:35.445+00	2021-11-08 10:19:35.539+00
1252	\N	died	2021-11-08 10:18:34.034+00	\N	\N	2021-11-08 10:18:53.974+00	2021-11-08 10:18:54.012+00
5402	\N	died	2021-11-08 10:19:46.743+00	\N	\N	2021-11-08 10:20:33.637+00	2021-11-08 10:20:34.026+00
1254	\N	died	2021-11-08 10:18:34.039+00	\N	\N	2021-11-08 10:18:54.008+00	2021-11-08 10:18:54.079+00
3219	\N	died	2021-11-08 10:18:41.601+00	\N	\N	2021-11-08 10:19:35.661+00	2021-11-08 10:19:36.359+00
1258	\N	died	2021-11-08 10:18:34.06+00	\N	\N	2021-11-08 10:18:54.074+00	2021-11-08 10:18:54.142+00
1262	\N	died	2021-11-08 10:18:34.072+00	\N	\N	2021-11-08 10:18:54.138+00	2021-11-08 10:18:54.301+00
3246	\N	died	2021-11-08 10:18:41.667+00	\N	\N	2021-11-08 10:19:36.236+00	2021-11-08 10:19:36.504+00
3306	\N	died	2021-11-08 10:18:41.809+00	\N	\N	2021-11-08 10:19:37.508+00	2021-11-08 10:19:38+00
3259	\N	died	2021-11-08 10:18:41.699+00	\N	\N	2021-11-08 10:19:36.457+00	2021-11-08 10:19:36.789+00
3278	\N	died	2021-11-08 10:18:41.743+00	\N	\N	2021-11-08 10:19:36.941+00	2021-11-08 10:19:37.225+00
3323	\N	died	2021-11-08 10:18:41.842+00	\N	\N	2021-11-08 10:19:37.983+00	2021-11-08 10:19:38.212+00
3334	\N	died	2021-11-08 10:18:41.87+00	\N	\N	2021-11-08 10:19:38.208+00	2021-11-08 10:19:38.482+00
5385	\N	died	2021-11-08 10:19:46.464+00	\N	\N	2021-11-08 10:20:33.308+00	2021-11-08 10:20:33.495+00
3340	\N	died	2021-11-08 10:18:41.884+00	\N	\N	2021-11-08 10:19:38.35+00	2021-11-08 10:19:38.536+00
5419	\N	died	2021-11-08 10:19:46.798+00	\N	\N	2021-11-08 10:20:33.914+00	2021-11-08 10:20:34.345+00
3351	\N	died	2021-11-08 10:18:41.907+00	\N	\N	2021-11-08 10:19:38.532+00	2021-11-08 10:19:38.758+00
3355	\N	died	2021-11-08 10:18:41.914+00	\N	\N	2021-11-08 10:19:38.754+00	2021-11-08 10:19:38.914+00
5390	\N	died	2021-11-08 10:19:46.547+00	\N	\N	2021-11-08 10:20:33.421+00	2021-11-08 10:20:33.666+00
5455	\N	died	2021-11-08 10:19:46.943+00	\N	\N	2021-11-08 10:20:34.797+00	2021-11-08 10:20:34.925+00
3359	\N	died	2021-11-08 10:18:41.921+00	\N	\N	2021-11-08 10:19:38.909+00	2021-11-08 10:19:38.956+00
5460	\N	died	2021-11-08 10:19:46.981+00	\N	\N	2021-11-08 10:20:34.88+00	2021-11-08 10:20:35.352+00
5436	\N	died	2021-11-08 10:19:46.911+00	\N	\N	2021-11-08 10:20:34.321+00	2021-11-08 10:20:34.807+00
467	\N	died	2021-11-08 10:18:10.176+00	\N	\N	2021-11-08 10:18:21.218+00	2021-11-08 10:18:21.722+00
663	\N	died	2021-11-08 10:18:19.215+00	\N	\N	2021-11-08 10:18:31.32+00	2021-11-08 10:18:32.171+00
479	\N	died	2021-11-08 10:18:10.581+00	\N	\N	2021-11-08 10:18:21.703+00	2021-11-08 10:18:21.96+00
484	\N	died	2021-11-08 10:18:10.774+00	\N	\N	2021-11-08 10:18:21.938+00	2021-11-08 10:18:22.188+00
492	\N	died	2021-11-08 10:18:11.058+00	\N	\N	2021-11-08 10:18:22.312+00	2021-11-08 10:18:22.791+00
940	\N	died	2021-11-08 10:18:32.05+00	\N	\N	2021-11-08 10:18:46.767+00	2021-11-08 10:18:47.024+00
502	\N	died	2021-11-08 10:18:11.383+00	\N	\N	2021-11-08 10:18:22.796+00	2021-11-08 10:18:23.341+00
514	\N	died	2021-11-08 10:18:11.887+00	\N	\N	2021-11-08 10:18:23.325+00	2021-11-08 10:18:23.606+00
518	\N	died	2021-11-08 10:18:12.108+00	\N	\N	2021-11-08 10:18:23.58+00	2021-11-08 10:18:23.966+00
527	\N	died	2021-11-08 10:18:12.488+00	\N	\N	2021-11-08 10:18:23.942+00	2021-11-08 10:18:24.48+00
952	\N	died	2021-11-08 10:18:32.347+00	\N	\N	2021-11-08 10:18:47.12+00	2021-11-08 10:18:47.298+00
543	\N	died	2021-11-08 10:18:12.762+00	\N	\N	2021-11-08 10:18:24.49+00	2021-11-08 10:18:25.172+00
1199	\N	died	2021-11-08 10:18:33.773+00	\N	\N	2021-11-08 10:18:52.618+00	2021-11-08 10:18:52.995+00
553	\N	died	2021-11-08 10:18:13.081+00	\N	\N	2021-11-08 10:18:24.943+00	2021-11-08 10:18:25.355+00
959	\N	died	2021-11-08 10:18:32.414+00	\N	\N	2021-11-08 10:18:47.281+00	2021-11-08 10:18:47.576+00
562	\N	died	2021-11-08 10:18:13.416+00	\N	\N	2021-11-08 10:18:25.386+00	2021-11-08 10:18:25.536+00
567	\N	died	2021-11-08 10:18:13.516+00	\N	\N	2021-11-08 10:18:25.557+00	2021-11-08 10:18:25.978+00
3152	\N	died	2021-11-08 10:18:41.431+00	\N	\N	2021-11-08 10:19:34.377+00	2021-11-08 10:19:34.751+00
574	\N	died	2021-11-08 10:18:13.699+00	\N	\N	2021-11-08 10:18:25.831+00	2021-11-08 10:18:27.018+00
592	\N	died	2021-11-08 10:18:14.733+00	\N	\N	2021-11-08 10:18:27.165+00	2021-11-08 10:18:27.417+00
972	\N	died	2021-11-08 10:18:32.595+00	\N	\N	2021-11-08 10:18:47.576+00	2021-11-08 10:18:47.718+00
599	\N	died	2021-11-08 10:18:15.092+00	\N	\N	2021-11-08 10:18:27.531+00	2021-11-08 10:18:28.201+00
610	\N	died	2021-11-08 10:18:15.925+00	\N	\N	2021-11-08 10:18:28.229+00	2021-11-08 10:18:28.91+00
619	\N	died	2021-11-08 10:18:16.769+00	\N	\N	2021-11-08 10:18:28.928+00	2021-11-08 10:18:29.112+00
975	\N	died	2021-11-08 10:18:32.718+00	\N	\N	2021-11-08 10:18:47.704+00	2021-11-08 10:18:47.969+00
626	\N	died	2021-11-08 10:18:17.316+00	\N	\N	2021-11-08 10:18:29.352+00	2021-11-08 10:18:29.781+00
1213	\N	died	2021-11-08 10:18:33.838+00	\N	\N	2021-11-08 10:18:52.906+00	2021-11-08 10:18:53.62+00
636	\N	died	2021-11-08 10:18:17.961+00	\N	\N	2021-11-08 10:18:29.918+00	2021-11-08 10:18:30.838+00
652	\N	died	2021-11-08 10:18:18.858+00	\N	\N	2021-11-08 10:18:30.809+00	2021-11-08 10:18:30.931+00
3286	\N	died	2021-11-08 10:18:41.755+00	\N	\N	2021-11-08 10:19:37.071+00	2021-11-08 10:19:37.273+00
656	\N	died	2021-11-08 10:18:19.008+00	\N	\N	2021-11-08 10:18:30.971+00	2021-11-08 10:18:31.349+00
982	\N	died	2021-11-08 10:18:32.774+00	\N	\N	2021-11-08 10:18:47.848+00	2021-11-08 10:18:48.158+00
1238	\N	died	2021-11-08 10:18:33.961+00	\N	\N	2021-11-08 10:18:53.616+00	2021-11-08 10:18:53.943+00
996	\N	died	2021-11-08 10:18:32.846+00	\N	\N	2021-11-08 10:18:48.131+00	2021-11-08 10:18:48.385+00
1007	\N	died	2021-11-08 10:18:32.894+00	\N	\N	2021-11-08 10:18:48.365+00	2021-11-08 10:18:48.78+00
1022	\N	died	2021-11-08 10:18:32.965+00	\N	\N	2021-11-08 10:18:48.658+00	2021-11-08 10:18:48.83+00
1248	\N	died	2021-11-08 10:18:34.016+00	\N	\N	2021-11-08 10:18:53.899+00	2021-11-08 10:18:54.301+00
1029	\N	died	2021-11-08 10:18:32.997+00	\N	\N	2021-11-08 10:18:48.825+00	2021-11-08 10:18:49.07+00
3168	\N	died	2021-11-08 10:18:41.468+00	\N	\N	2021-11-08 10:19:34.748+00	2021-11-08 10:19:34.967+00
1039	\N	died	2021-11-08 10:18:33.051+00	\N	\N	2021-11-08 10:18:49.049+00	2021-11-08 10:18:49.3+00
1047	\N	died	2021-11-08 10:18:33.085+00	\N	\N	2021-11-08 10:18:49.238+00	2021-11-08 10:18:49.495+00
1265	\N	died	2021-11-08 10:18:34.084+00	\N	\N	2021-11-08 10:18:54.188+00	2021-11-08 10:18:54.366+00
1057	\N	died	2021-11-08 10:18:33.129+00	\N	\N	2021-11-08 10:18:49.455+00	2021-11-08 10:18:49.777+00
1072	\N	died	2021-11-08 10:18:33.192+00	\N	\N	2021-11-08 10:18:49.753+00	2021-11-08 10:18:50.186+00
1088	\N	died	2021-11-08 10:18:33.266+00	\N	\N	2021-11-08 10:18:50.132+00	2021-11-08 10:18:50.251+00
1276	\N	died	2021-11-08 10:18:34.13+00	\N	\N	2021-11-08 10:18:54.362+00	2021-11-08 10:18:54.445+00
1095	\N	died	2021-11-08 10:18:33.286+00	\N	\N	2021-11-08 10:18:50.247+00	2021-11-08 10:18:50.435+00
1100	\N	died	2021-11-08 10:18:33.327+00	\N	\N	2021-11-08 10:18:50.401+00	2021-11-08 10:18:50.84+00
1117	\N	died	2021-11-08 10:18:33.396+00	\N	\N	2021-11-08 10:18:50.729+00	2021-11-08 10:18:51.27+00
1279	\N	died	2021-11-08 10:18:34.141+00	\N	\N	2021-11-08 10:18:54.441+00	2021-11-08 10:18:54.512+00
1133	\N	died	2021-11-08 10:18:33.475+00	\N	\N	2021-11-08 10:18:51.108+00	2021-11-08 10:18:51.52+00
3178	\N	died	2021-11-08 10:18:41.498+00	\N	\N	2021-11-08 10:19:34.963+00	2021-11-08 10:19:35.135+00
1150	\N	died	2021-11-08 10:18:33.554+00	\N	\N	2021-11-08 10:18:51.516+00	2021-11-08 10:18:51.724+00
1159	\N	died	2021-11-08 10:18:33.6+00	\N	\N	2021-11-08 10:18:51.708+00	2021-11-08 10:18:51.797+00
1283	\N	died	2021-11-08 10:18:34.17+00	\N	\N	2021-11-08 10:18:54.508+00	2021-11-08 10:18:54.616+00
1164	\N	died	2021-11-08 10:18:33.616+00	\N	\N	2021-11-08 10:18:51.793+00	2021-11-08 10:18:51.85+00
1155	\N	died	2021-11-08 10:18:33.584+00	\N	\N	2021-11-08 10:18:51.591+00	2021-11-08 10:18:52.081+00
1167	\N	died	2021-11-08 10:18:33.632+00	\N	\N	2021-11-08 10:18:51.847+00	2021-11-08 10:18:52.081+00
1182	\N	died	2021-11-08 10:18:33.693+00	\N	\N	2021-11-08 10:18:52.189+00	2021-11-08 10:18:52.396+00
1187	\N	died	2021-11-08 10:18:33.709+00	\N	\N	2021-11-08 10:18:52.274+00	2021-11-08 10:18:52.396+00
3188	\N	died	2021-11-08 10:18:41.521+00	\N	\N	2021-11-08 10:19:35.131+00	2021-11-08 10:19:35.199+00
3295	\N	died	2021-11-08 10:18:41.777+00	\N	\N	2021-11-08 10:19:37.269+00	2021-11-08 10:19:37.425+00
1175	\N	died	2021-11-08 10:18:33.667+00	\N	\N	2021-11-08 10:18:52.024+00	2021-11-08 10:18:52.41+00
3191	\N	died	2021-11-08 10:18:41.529+00	\N	\N	2021-11-08 10:19:35.179+00	2021-11-08 10:19:35.424+00
1176	\N	died	2021-11-08 10:18:33.667+00	\N	\N	2021-11-08 10:18:52.038+00	2021-11-08 10:18:52.507+00
1191	\N	died	2021-11-08 10:18:33.736+00	\N	\N	2021-11-08 10:18:52.392+00	2021-11-08 10:18:52.507+00
1192	\N	died	2021-11-08 10:18:33.739+00	\N	\N	2021-11-08 10:18:52.407+00	2021-11-08 10:18:52.54+00
3198	\N	died	2021-11-08 10:18:41.542+00	\N	\N	2021-11-08 10:19:35.287+00	2021-11-08 10:19:35.539+00
1195	\N	died	2021-11-08 10:18:33.754+00	\N	\N	2021-11-08 10:18:52.502+00	2021-11-08 10:18:52.653+00
1289	\N	died	2021-11-08 10:18:34.193+00	\N	\N	2021-11-08 10:18:54.612+00	2021-11-08 10:18:54.703+00
3210	\N	died	2021-11-08 10:18:41.585+00	\N	\N	2021-11-08 10:19:35.524+00	2021-11-08 10:19:35.733+00
1294	\N	died	2021-11-08 10:18:34.21+00	\N	\N	2021-11-08 10:18:54.699+00	2021-11-08 10:18:54.794+00
3298	\N	died	2021-11-08 10:18:41.784+00	\N	\N	2021-11-08 10:19:37.325+00	2021-11-08 10:19:37.702+00
1299	\N	died	2021-11-08 10:18:34.232+00	\N	\N	2021-11-08 10:18:54.79+00	2021-11-08 10:18:54.821+00
1301	\N	died	2021-11-08 10:18:34.238+00	\N	\N	2021-11-08 10:18:54.816+00	2021-11-08 10:18:54.939+00
3222	\N	died	2021-11-08 10:18:41.61+00	\N	\N	2021-11-08 10:19:35.715+00	2021-11-08 10:19:35.999+00
1305	\N	died	2021-11-08 10:18:34.257+00	\N	\N	2021-11-08 10:18:54.934+00	2021-11-08 10:18:55.021+00
3339	\N	died	2021-11-08 10:18:41.878+00	\N	\N	2021-11-08 10:19:38.33+00	2021-11-08 10:19:38.515+00
1310	\N	died	2021-11-08 10:18:34.283+00	\N	\N	2021-11-08 10:18:55.016+00	2021-11-08 10:18:55.128+00
3236	\N	died	2021-11-08 10:18:41.65+00	\N	\N	2021-11-08 10:19:35.985+00	2021-11-08 10:19:36.359+00
1317	\N	died	2021-11-08 10:18:34.3+00	\N	\N	2021-11-08 10:18:55.122+00	2021-11-08 10:18:55.229+00
5420	\N	died	2021-11-08 10:19:46.823+00	\N	\N	2021-11-08 10:20:33.973+00	2021-11-08 10:20:34.41+00
3251	\N	died	2021-11-08 10:18:41.676+00	\N	\N	2021-11-08 10:19:36.319+00	2021-11-08 10:19:36.609+00
3269	\N	died	2021-11-08 10:18:41.726+00	\N	\N	2021-11-08 10:19:36.605+00	2021-11-08 10:19:36.916+00
3349	\N	died	2021-11-08 10:18:41.899+00	\N	\N	2021-11-08 10:19:38.494+00	2021-11-08 10:19:38.758+00
3273	\N	died	2021-11-08 10:18:41.731+00	\N	\N	2021-11-08 10:19:36.811+00	2021-11-08 10:19:37.225+00
3309	\N	died	2021-11-08 10:18:41.815+00	\N	\N	2021-11-08 10:19:37.557+00	2021-11-08 10:19:37.95+00
5391	\N	died	2021-11-08 10:19:46.548+00	\N	\N	2021-11-08 10:20:33.437+00	2021-11-08 10:20:33.716+00
3321	\N	died	2021-11-08 10:18:41.835+00	\N	\N	2021-11-08 10:19:37.946+00	2021-11-08 10:19:38.166+00
3327	\N	died	2021-11-08 10:18:41.849+00	\N	\N	2021-11-08 10:19:38.09+00	2021-11-08 10:19:38.335+00
3353	\N	died	2021-11-08 10:18:41.907+00	\N	\N	2021-11-08 10:19:38.662+00	2021-11-08 10:19:38.956+00
3361	\N	died	2021-11-08 10:18:41.922+00	\N	\N	2021-11-08 10:19:38.936+00	2021-11-08 10:19:39.966+00
5405	\N	died	2021-11-08 10:19:46.748+00	\N	\N	2021-11-08 10:20:33.679+00	2021-11-08 10:20:33.802+00
3392	\N	died	2021-11-08 10:18:42.003+00	\N	\N	2021-11-08 10:19:39.962+00	2021-11-08 10:19:40.075+00
5448	\N	died	2021-11-08 10:19:46.93+00	\N	\N	2021-11-08 10:20:34.604+00	2021-11-08 10:20:34.925+00
3399	\N	died	2021-11-08 10:18:42.024+00	\N	\N	2021-11-08 10:19:40.07+00	2021-11-08 10:19:40.207+00
3405	\N	died	2021-11-08 10:18:42.04+00	\N	\N	2021-11-08 10:19:40.203+00	2021-11-08 10:19:40.292+00
5412	\N	died	2021-11-08 10:19:46.757+00	\N	\N	2021-11-08 10:20:33.798+00	2021-11-08 10:20:34.026+00
5495	\N	died	2021-11-08 10:19:47.848+00	\N	\N	2021-11-08 10:20:35.772+00	2021-11-08 10:20:36.208+00
3407	\N	died	2021-11-08 10:18:42.041+00	\N	\N	2021-11-08 10:19:40.287+00	2021-11-08 10:19:40.535+00
5438	\N	died	2021-11-08 10:19:46.916+00	\N	\N	2021-11-08 10:20:34.354+00	2021-11-08 10:20:34.785+00
5476	\N	died	2021-11-08 10:19:47.298+00	\N	\N	2021-11-08 10:20:35.29+00	2021-11-08 10:20:35.797+00
5459	\N	died	2021-11-08 10:19:46.965+00	\N	\N	2021-11-08 10:20:34.863+00	2021-11-08 10:20:35.071+00
5467	\N	died	2021-11-08 10:19:47.047+00	\N	\N	2021-11-08 10:20:35.063+00	2021-11-08 10:20:35.352+00
5510	\N	died	2021-11-08 10:19:48.148+00	\N	\N	2021-11-08 10:20:36.198+00	2021-11-08 10:20:36.396+00
5516	\N	died	2021-11-08 10:19:48.231+00	\N	\N	2021-11-08 10:20:36.35+00	2021-11-08 10:20:37.324+00
5537	\N	died	2021-11-08 10:19:48.79+00	\N	\N	2021-11-08 10:20:37.156+00	2021-11-08 10:20:37.499+00
5549	\N	died	2021-11-08 10:19:49.007+00	\N	\N	2021-11-08 10:20:37.483+00	2021-11-08 10:20:37.856+00
1208	\N	died	2021-11-08 10:18:33.821+00	\N	\N	2021-11-08 10:18:52.773+00	2021-11-08 10:18:52.995+00
1203	\N	died	2021-11-08 10:18:33.795+00	\N	\N	2021-11-08 10:18:52.685+00	2021-11-08 10:18:52.995+00
1209	\N	died	2021-11-08 10:18:33.825+00	\N	\N	2021-11-08 10:18:52.839+00	2021-11-08 10:18:52.995+00
1200	\N	died	2021-11-08 10:18:33.777+00	\N	\N	2021-11-08 10:18:52.633+00	2021-11-08 10:18:52.995+00
1211	\N	died	2021-11-08 10:18:33.834+00	\N	\N	2021-11-08 10:18:52.874+00	2021-11-08 10:18:52.995+00
1210	\N	died	2021-11-08 10:18:33.83+00	\N	\N	2021-11-08 10:18:52.858+00	2021-11-08 10:18:53.078+00
1218	\N	died	2021-11-08 10:18:33.872+00	\N	\N	2021-11-08 10:18:52.991+00	2021-11-08 10:18:53.078+00
1220	\N	died	2021-11-08 10:18:33.877+00	\N	\N	2021-11-08 10:18:53.074+00	2021-11-08 10:18:53.127+00
3164	\N	died	2021-11-08 10:18:41.453+00	\N	\N	2021-11-08 10:19:34.627+00	2021-11-08 10:19:34.764+00
1223	\N	died	2021-11-08 10:18:33.883+00	\N	\N	2021-11-08 10:18:53.122+00	2021-11-08 10:18:53.191+00
1227	\N	died	2021-11-08 10:18:33.894+00	\N	\N	2021-11-08 10:18:53.187+00	2021-11-08 10:18:53.293+00
1230	\N	died	2021-11-08 10:18:33.899+00	\N	\N	2021-11-08 10:18:53.288+00	2021-11-08 10:18:53.554+00
3169	\N	died	2021-11-08 10:18:41.468+00	\N	\N	2021-11-08 10:19:34.761+00	2021-11-08 10:19:35.119+00
1234	\N	died	2021-11-08 10:18:33.941+00	\N	\N	2021-11-08 10:18:53.551+00	2021-11-08 10:18:53.943+00
1244	\N	died	2021-11-08 10:18:33.989+00	\N	\N	2021-11-08 10:18:53.749+00	2021-11-08 10:18:54.094+00
1259	\N	died	2021-11-08 10:18:34.06+00	\N	\N	2021-11-08 10:18:54.087+00	2021-11-08 10:18:54.301+00
3179	\N	died	2021-11-08 10:18:41.498+00	\N	\N	2021-11-08 10:19:34.977+00	2021-11-08 10:19:35.168+00
1266	\N	died	2021-11-08 10:18:34.089+00	\N	\N	2021-11-08 10:18:54.208+00	2021-11-08 10:18:54.445+00
3390	\N	died	2021-11-08 10:18:42.003+00	\N	\N	2021-11-08 10:19:39.941+00	2021-11-08 10:19:40.075+00
1278	\N	died	2021-11-08 10:18:34.135+00	\N	\N	2021-11-08 10:18:54.4+00	2021-11-08 10:18:54.616+00
1287	\N	died	2021-11-08 10:18:34.182+00	\N	\N	2021-11-08 10:18:54.571+00	2021-11-08 10:18:54.794+00
3190	\N	died	2021-11-08 10:18:41.529+00	\N	\N	2021-11-08 10:19:35.164+00	2021-11-08 10:19:35.24+00
1298	\N	died	2021-11-08 10:18:34.227+00	\N	\N	2021-11-08 10:18:54.772+00	2021-11-08 10:18:55.128+00
1315	\N	died	2021-11-08 10:18:34.295+00	\N	\N	2021-11-08 10:18:55.095+00	2021-11-08 10:18:55.429+00
1332	\N	died	2021-11-08 10:18:34.357+00	\N	\N	2021-11-08 10:18:55.426+00	2021-11-08 10:18:55.53+00
3194	\N	died	2021-11-08 10:18:41.536+00	\N	\N	2021-11-08 10:19:35.236+00	2021-11-08 10:19:35.424+00
1338	\N	died	2021-11-08 10:18:34.378+00	\N	\N	2021-11-08 10:18:55.525+00	2021-11-08 10:18:55.562+00
1340	\N	died	2021-11-08 10:18:34.382+00	\N	\N	2021-11-08 10:18:55.557+00	2021-11-08 10:18:55.595+00
1342	\N	died	2021-11-08 10:18:34.389+00	\N	\N	2021-11-08 10:18:55.592+00	2021-11-08 10:18:55.747+00
3202	\N	died	2021-11-08 10:18:41.568+00	\N	\N	2021-11-08 10:19:35.357+00	2021-11-08 10:19:35.733+00
1348	\N	died	2021-11-08 10:18:34.408+00	\N	\N	2021-11-08 10:18:55.743+00	2021-11-08 10:18:55.812+00
3395	\N	died	2021-11-08 10:18:42.016+00	\N	\N	2021-11-08 10:19:40.005+00	2021-11-08 10:19:40.274+00
1352	\N	died	2021-11-08 10:18:34.426+00	\N	\N	2021-11-08 10:18:55.808+00	2021-11-08 10:18:55.95+00
1361	\N	died	2021-11-08 10:18:34.452+00	\N	\N	2021-11-08 10:18:55.946+00	2021-11-08 10:18:56.019+00
3221	\N	died	2021-11-08 10:18:41.601+00	\N	\N	2021-11-08 10:19:35.7+00	2021-11-08 10:19:35.848+00
1365	\N	died	2021-11-08 10:18:34.472+00	\N	\N	2021-11-08 10:18:56.015+00	2021-11-08 10:18:56.088+00
5393	\N	died	2021-11-08 10:19:46.58+00	\N	\N	2021-11-08 10:20:33.473+00	2021-11-08 10:20:33.561+00
1369	\N	died	2021-11-08 10:18:34.495+00	\N	\N	2021-11-08 10:18:56.083+00	2021-11-08 10:18:56.138+00
1372	\N	died	2021-11-08 10:18:34.508+00	\N	\N	2021-11-08 10:18:56.133+00	2021-11-08 10:18:56.26+00
3227	\N	died	2021-11-08 10:18:41.617+00	\N	\N	2021-11-08 10:19:35.786+00	2021-11-08 10:19:35.932+00
1380	\N	died	2021-11-08 10:18:34.537+00	\N	\N	2021-11-08 10:18:56.256+00	2021-11-08 10:18:56.309+00
1383	\N	died	2021-11-08 10:18:34.544+00	\N	\N	2021-11-08 10:18:56.305+00	2021-11-08 10:18:56.346+00
1385	\N	died	2021-11-08 10:18:34.549+00	\N	\N	2021-11-08 10:18:56.34+00	2021-11-08 10:18:56.425+00
3232	\N	died	2021-11-08 10:18:41.625+00	\N	\N	2021-11-08 10:19:35.916+00	2021-11-08 10:19:36.032+00
1390	\N	died	2021-11-08 10:18:34.582+00	\N	\N	2021-11-08 10:18:56.42+00	2021-11-08 10:18:56.509+00
3406	\N	died	2021-11-08 10:18:42.041+00	\N	\N	2021-11-08 10:19:40.27+00	2021-11-08 10:19:40.535+00
1394	\N	died	2021-11-08 10:18:34.597+00	\N	\N	2021-11-08 10:18:56.498+00	2021-11-08 10:18:56.624+00
1402	\N	died	2021-11-08 10:18:34.627+00	\N	\N	2021-11-08 10:18:56.621+00	2021-11-08 10:18:56.665+00
3239	\N	died	2021-11-08 10:18:41.65+00	\N	\N	2021-11-08 10:19:36.028+00	2021-11-08 10:19:36.359+00
1404	\N	died	2021-11-08 10:18:34.634+00	\N	\N	2021-11-08 10:18:56.658+00	2021-11-08 10:18:56.73+00
5499	\N	died	2021-11-08 10:19:47.914+00	\N	\N	2021-11-08 10:20:35.923+00	2021-11-08 10:20:36.396+00
1408	\N	died	2021-11-08 10:18:34.649+00	\N	\N	2021-11-08 10:18:56.726+00	2021-11-08 10:18:56.791+00
1412	\N	died	2021-11-08 10:18:34.666+00	\N	\N	2021-11-08 10:18:56.787+00	2021-11-08 10:18:56.948+00
3247	\N	died	2021-11-08 10:18:41.667+00	\N	\N	2021-11-08 10:19:36.254+00	2021-11-08 10:19:36.504+00
1421	\N	died	2021-11-08 10:18:34.708+00	\N	\N	2021-11-08 10:18:56.944+00	2021-11-08 10:18:56.98+00
1423	\N	died	2021-11-08 10:18:34.714+00	\N	\N	2021-11-08 10:18:56.974+00	2021-11-08 10:18:57.008+00
1425	\N	died	2021-11-08 10:18:34.72+00	\N	\N	2021-11-08 10:18:57.005+00	2021-11-08 10:18:57.097+00
3261	\N	died	2021-11-08 10:18:41.699+00	\N	\N	2021-11-08 10:19:36.478+00	2021-11-08 10:19:36.924+00
1430	\N	died	2021-11-08 10:18:34.756+00	\N	\N	2021-11-08 10:18:57.092+00	2021-11-08 10:18:57.172+00
3409	\N	died	2021-11-08 10:18:42.052+00	\N	\N	2021-11-08 10:19:40.362+00	2021-11-08 10:19:40.982+00
1434	\N	died	2021-11-08 10:18:34.776+00	\N	\N	2021-11-08 10:18:57.167+00	2021-11-08 10:18:57.291+00
3277	\N	died	2021-11-08 10:18:41.737+00	\N	\N	2021-11-08 10:19:36.92+00	2021-11-08 10:19:37.058+00
1442	\N	died	2021-11-08 10:18:34.804+00	\N	\N	2021-11-08 10:18:57.287+00	2021-11-08 10:18:57.321+00
3283	\N	died	2021-11-08 10:18:41.749+00	\N	\N	2021-11-08 10:19:37.025+00	2021-11-08 10:19:37.311+00
3297	\N	died	2021-11-08 10:18:41.784+00	\N	\N	2021-11-08 10:19:37.303+00	2021-11-08 10:19:37.524+00
3417	\N	died	2021-11-08 10:18:42.067+00	\N	\N	2021-11-08 10:19:40.921+00	2021-11-08 10:19:41.275+00
3303	\N	died	2021-11-08 10:18:41.802+00	\N	\N	2021-11-08 10:19:37.455+00	2021-11-08 10:19:37.761+00
5397	\N	died	2021-11-08 10:19:46.69+00	\N	\N	2021-11-08 10:20:33.554+00	2021-11-08 10:20:33.666+00
3312	\N	died	2021-11-08 10:18:41.821+00	\N	\N	2021-11-08 10:19:37.758+00	2021-11-08 10:19:37.937+00
3317	\N	died	2021-11-08 10:18:41.829+00	\N	\N	2021-11-08 10:19:37.888+00	2021-11-08 10:19:38.166+00
3330	\N	died	2021-11-08 10:18:41.849+00	\N	\N	2021-11-08 10:19:38.138+00	2021-11-08 10:19:38.482+00
3347	\N	died	2021-11-08 10:18:41.899+00	\N	\N	2021-11-08 10:19:38.463+00	2021-11-08 10:19:39.162+00
5401	\N	died	2021-11-08 10:19:46.742+00	\N	\N	2021-11-08 10:20:33.621+00	2021-11-08 10:20:33.867+00
3367	\N	died	2021-11-08 10:18:41.948+00	\N	\N	2021-11-08 10:19:39.137+00	2021-11-08 10:19:39.944+00
3436	\N	died	2021-11-08 10:18:42.106+00	\N	\N	2021-11-08 10:19:41.271+00	2021-11-08 10:19:41.416+00
5481	\N	died	2021-11-08 10:19:47.433+00	\N	\N	2021-11-08 10:20:35.422+00	2021-11-08 10:20:35.529+00
3445	\N	died	2021-11-08 10:18:42.124+00	\N	\N	2021-11-08 10:19:41.411+00	2021-11-08 10:19:41.515+00
3448	\N	died	2021-11-08 10:18:42.132+00	\N	\N	2021-11-08 10:19:41.511+00	2021-11-08 10:19:41.55+00
5415	\N	died	2021-11-08 10:19:46.76+00	\N	\N	2021-11-08 10:20:33.846+00	2021-11-08 10:20:34.257+00
3450	\N	died	2021-11-08 10:18:42.132+00	\N	\N	2021-11-08 10:19:41.546+00	2021-11-08 10:19:41.618+00
3454	\N	died	2021-11-08 10:18:42.141+00	\N	\N	2021-11-08 10:19:41.613+00	2021-11-08 10:19:41.718+00
3458	\N	died	2021-11-08 10:18:42.15+00	\N	\N	2021-11-08 10:19:41.72+00	2021-11-08 10:19:41.868+00
5430	\N	died	2021-11-08 10:19:46.903+00	\N	\N	2021-11-08 10:20:34.189+00	2021-11-08 10:20:34.442+00
3468	\N	died	2021-11-08 10:18:42.174+00	\N	\N	2021-11-08 10:19:41.863+00	2021-11-08 10:19:42.083+00
3478	\N	died	2021-11-08 10:18:42.192+00	\N	\N	2021-11-08 10:19:42.079+00	2021-11-08 10:19:42.352+00
3488	\N	died	2021-11-08 10:18:42.33+00	\N	\N	2021-11-08 10:19:42.332+00	2021-11-08 10:19:42.425+00
5442	\N	died	2021-11-08 10:19:46.922+00	\N	\N	2021-11-08 10:20:34.427+00	2021-11-08 10:20:34.6+00
3492	\N	died	2021-11-08 10:18:42.411+00	\N	\N	2021-11-08 10:19:42.417+00	2021-11-08 10:19:42.453+00
5492	\N	died	2021-11-08 10:19:47.749+00	\N	\N	2021-11-08 10:20:35.699+00	2021-11-08 10:20:36.051+00
5446	\N	died	2021-11-08 10:19:46.927+00	\N	\N	2021-11-08 10:20:34.582+00	2021-11-08 10:20:34.841+00
5456	\N	died	2021-11-08 10:19:46.943+00	\N	\N	2021-11-08 10:20:34.813+00	2021-11-08 10:20:35.024+00
5464	\N	died	2021-11-08 10:19:47.032+00	\N	\N	2021-11-08 10:20:34.938+00	2021-11-08 10:20:35.352+00
5539	\N	died	2021-11-08 10:19:48.811+00	\N	\N	2021-11-08 10:20:37.192+00	2021-11-08 10:20:37.856+00
5470	\N	died	2021-11-08 10:19:47.231+00	\N	\N	2021-11-08 10:20:35.13+00	2021-11-08 10:20:35.431+00
5484	\N	died	2021-11-08 10:19:47.631+00	\N	\N	2021-11-08 10:20:35.481+00	2021-11-08 10:20:35.721+00
5515	\N	died	2021-11-08 10:19:48.215+00	\N	\N	2021-11-08 10:20:36.324+00	2021-11-08 10:20:36.666+00
5524	\N	died	2021-11-08 10:19:48.414+00	\N	\N	2021-11-08 10:20:36.649+00	2021-11-08 10:20:36.881+00
5512	\N	died	2021-11-08 10:19:48.181+00	\N	\N	2021-11-08 10:20:36.249+00	2021-11-08 10:20:36.881+00
5554	\N	died	2021-11-08 10:19:49.108+00	\N	\N	2021-11-08 10:20:37.664+00	2021-11-08 10:20:37.909+00
5530	\N	died	2021-11-08 10:19:48.565+00	\N	\N	2021-11-08 10:20:36.863+00	2021-11-08 10:20:37.059+00
5521	\N	died	2021-11-08 10:19:48.382+00	\N	\N	2021-11-08 10:20:36.543+00	2021-11-08 10:20:37.059+00
5569	\N	died	2021-11-08 10:19:49.333+00	\N	\N	2021-11-08 10:20:37.955+00	2021-11-08 10:20:38.133+00
5534	\N	died	2021-11-08 10:19:48.69+00	\N	\N	2021-11-08 10:20:37.049+00	2021-11-08 10:20:37.324+00
5565	\N	died	2021-11-08 10:19:49.273+00	\N	\N	2021-11-08 10:20:37.905+00	2021-11-08 10:20:37.96+00
5573	\N	died	2021-11-08 10:19:49.459+00	\N	\N	2021-11-08 10:20:38.116+00	2021-11-08 10:20:38.443+00
3161	\N	died	2021-11-08 10:18:41.446+00	\N	\N	2021-11-08 10:19:34.577+00	2021-11-08 10:19:34.654+00
1219	\N	died	2021-11-08 10:18:33.872+00	\N	\N	2021-11-08 10:18:53.053+00	2021-11-08 10:18:53.345+00
1231	\N	died	2021-11-08 10:18:33.913+00	\N	\N	2021-11-08 10:18:53.341+00	2021-11-08 10:18:53.605+00
1237	\N	died	2021-11-08 10:18:33.957+00	\N	\N	2021-11-08 10:18:53.6+00	2021-11-08 10:18:53.943+00
3165	\N	died	2021-11-08 10:18:41.46+00	\N	\N	2021-11-08 10:19:34.649+00	2021-11-08 10:19:34.817+00
1247	\N	died	2021-11-08 10:18:34.01+00	\N	\N	2021-11-08 10:18:53.882+00	2021-11-08 10:18:54.301+00
1269	\N	died	2021-11-08 10:18:34.108+00	\N	\N	2021-11-08 10:18:54.258+00	2021-11-08 10:18:54.616+00
1288	\N	died	2021-11-08 10:18:34.193+00	\N	\N	2021-11-08 10:18:54.599+00	2021-11-08 10:18:55.021+00
3172	\N	died	2021-11-08 10:18:41.482+00	\N	\N	2021-11-08 10:19:34.812+00	2021-11-08 10:19:35.119+00
1308	\N	died	2021-11-08 10:18:34.272+00	\N	\N	2021-11-08 10:18:54.984+00	2021-11-08 10:18:55.313+00
1325	\N	died	2021-11-08 10:18:34.328+00	\N	\N	2021-11-08 10:18:55.309+00	2021-11-08 10:18:55.408+00
1331	\N	died	2021-11-08 10:18:34.349+00	\N	\N	2021-11-08 10:18:55.405+00	2021-11-08 10:18:55.53+00
3182	\N	died	2021-11-08 10:18:41.506+00	\N	\N	2021-11-08 10:19:35.031+00	2021-11-08 10:19:35.424+00
1334	\N	died	2021-11-08 10:18:34.364+00	\N	\N	2021-11-08 10:18:55.46+00	2021-11-08 10:18:55.758+00
3401	\N	died	2021-11-08 10:18:42.032+00	\N	\N	2021-11-08 10:19:40.108+00	2021-11-08 10:19:40.911+00
1349	\N	died	2021-11-08 10:18:34.408+00	\N	\N	2021-11-08 10:18:55.754+00	2021-11-08 10:18:55.95+00
1357	\N	died	2021-11-08 10:18:34.439+00	\N	\N	2021-11-08 10:18:55.882+00	2021-11-08 10:18:56.26+00
3197	\N	died	2021-11-08 10:18:41.542+00	\N	\N	2021-11-08 10:19:35.269+00	2021-11-08 10:19:35.539+00
1375	\N	died	2021-11-08 10:18:34.522+00	\N	\N	2021-11-08 10:18:56.188+00	2021-11-08 10:18:56.445+00
1391	\N	died	2021-11-08 10:18:34.582+00	\N	\N	2021-11-08 10:18:56.438+00	2021-11-08 10:18:56.624+00
1401	\N	died	2021-11-08 10:18:34.627+00	\N	\N	2021-11-08 10:18:56.608+00	2021-11-08 10:18:56.948+00
3208	\N	died	2021-11-08 10:18:41.577+00	\N	\N	2021-11-08 10:19:35.486+00	2021-11-08 10:19:35.733+00
1417	\N	died	2021-11-08 10:18:34.687+00	\N	\N	2021-11-08 10:18:56.875+00	2021-11-08 10:18:57.172+00
1433	\N	died	2021-11-08 10:18:34.77+00	\N	\N	2021-11-08 10:18:57.148+00	2021-11-08 10:18:57.382+00
1445	\N	died	2021-11-08 10:18:34.81+00	\N	\N	2021-11-08 10:18:57.379+00	2021-11-08 10:18:57.471+00
3217	\N	died	2021-11-08 10:18:41.594+00	\N	\N	2021-11-08 10:19:35.632+00	2021-11-08 10:19:36.082+00
1450	\N	died	2021-11-08 10:18:34.841+00	\N	\N	2021-11-08 10:18:57.467+00	2021-11-08 10:18:57.535+00
3416	\N	died	2021-11-08 10:18:42.067+00	\N	\N	2021-11-08 10:19:40.908+00	2021-11-08 10:19:41.082+00
1454	\N	died	2021-11-08 10:18:34.848+00	\N	\N	2021-11-08 10:18:57.531+00	2021-11-08 10:18:57.589+00
1457	\N	died	2021-11-08 10:18:34.861+00	\N	\N	2021-11-08 10:18:57.586+00	2021-11-08 10:18:57.705+00
3242	\N	died	2021-11-08 10:18:41.659+00	\N	\N	2021-11-08 10:19:36.077+00	2021-11-08 10:19:36.359+00
1464	\N	died	2021-11-08 10:18:34.885+00	\N	\N	2021-11-08 10:18:57.7+00	2021-11-08 10:18:57.803+00
5414	\N	died	2021-11-08 10:19:46.759+00	\N	\N	2021-11-08 10:20:33.829+00	2021-11-08 10:20:34.158+00
1470	\N	died	2021-11-08 10:18:34.916+00	\N	\N	2021-11-08 10:18:57.799+00	2021-11-08 10:18:57.834+00
1472	\N	died	2021-11-08 10:18:34.922+00	\N	\N	2021-11-08 10:18:57.83+00	2021-11-08 10:18:57.889+00
3250	\N	died	2021-11-08 10:18:41.676+00	\N	\N	2021-11-08 10:19:36.303+00	2021-11-08 10:19:36.595+00
1475	\N	died	2021-11-08 10:18:34.933+00	\N	\N	2021-11-08 10:18:57.884+00	2021-11-08 10:18:57.956+00
1479	\N	died	2021-11-08 10:18:34.955+00	\N	\N	2021-11-08 10:18:57.951+00	2021-11-08 10:18:58.08+00
1484	\N	died	2021-11-08 10:18:34.978+00	\N	\N	2021-11-08 10:18:58.075+00	2021-11-08 10:18:58.19+00
3267	\N	died	2021-11-08 10:18:41.712+00	\N	\N	2021-11-08 10:19:36.571+00	2021-11-08 10:19:37.058+00
1490	\N	died	2021-11-08 10:18:35.034+00	\N	\N	2021-11-08 10:18:58.189+00	2021-11-08 10:18:58.356+00
3425	\N	died	2021-11-08 10:18:42.083+00	\N	\N	2021-11-08 10:19:41.047+00	2021-11-08 10:19:41.416+00
1500	\N	died	2021-11-08 10:18:35.078+00	\N	\N	2021-11-08 10:18:58.352+00	2021-11-08 10:18:58.533+00
1508	\N	died	2021-11-08 10:18:35.112+00	\N	\N	2021-11-08 10:18:58.529+00	2021-11-08 10:18:58.589+00
3282	\N	died	2021-11-08 10:18:41.749+00	\N	\N	2021-11-08 10:19:37.003+00	2021-11-08 10:19:37.258+00
1511	\N	died	2021-11-08 10:18:35.125+00	\N	\N	2021-11-08 10:18:58.585+00	2021-11-08 10:18:58.639+00
5528	\N	died	2021-11-08 10:19:48.547+00	\N	\N	2021-11-08 10:20:36.785+00	2021-11-08 10:20:37.395+00
1514	\N	died	2021-11-08 10:18:35.136+00	\N	\N	2021-11-08 10:18:58.635+00	2021-11-08 10:18:58.743+00
1518	\N	died	2021-11-08 10:18:35.143+00	\N	\N	2021-11-08 10:18:58.739+00	2021-11-08 10:18:58.813+00
3293	\N	died	2021-11-08 10:18:41.777+00	\N	\N	2021-11-08 10:19:37.24+00	2021-11-08 10:19:37.425+00
1522	\N	died	2021-11-08 10:18:35.159+00	\N	\N	2021-11-08 10:18:58.809+00	2021-11-08 10:18:58.958+00
1526	\N	died	2021-11-08 10:18:35.174+00	\N	\N	2021-11-08 10:18:58.955+00	2021-11-08 10:18:59.023+00
1530	\N	died	2021-11-08 10:18:35.181+00	\N	\N	2021-11-08 10:18:59.016+00	2021-11-08 10:18:59.156+00
3300	\N	died	2021-11-08 10:18:41.796+00	\N	\N	2021-11-08 10:19:37.354+00	2021-11-08 10:19:37.937+00
1535	\N	died	2021-11-08 10:18:35.204+00	\N	\N	2021-11-08 10:18:59.146+00	2021-11-08 10:18:59.224+00
3442	\N	died	2021-11-08 10:18:42.124+00	\N	\N	2021-11-08 10:19:41.366+00	2021-11-08 10:19:41.787+00
1539	\N	died	2021-11-08 10:18:35.237+00	\N	\N	2021-11-08 10:18:59.218+00	2021-11-08 10:18:59.464+00
3318	\N	died	2021-11-08 10:18:41.829+00	\N	\N	2021-11-08 10:19:37.903+00	2021-11-08 10:19:38.174+00
1549	\N	died	2021-11-08 10:18:35.277+00	\N	\N	2021-11-08 10:18:59.459+00	2021-11-08 10:18:59.515+00
3332	\N	died	2021-11-08 10:18:41.863+00	\N	\N	2021-11-08 10:19:38.169+00	2021-11-08 10:19:38.226+00
3335	\N	died	2021-11-08 10:18:41.87+00	\N	\N	2021-11-08 10:19:38.221+00	2021-11-08 10:19:38.482+00
3462	\N	died	2021-11-08 10:18:42.158+00	\N	\N	2021-11-08 10:19:41.783+00	2021-11-08 10:19:41.887+00
3342	\N	died	2021-11-08 10:18:41.885+00	\N	\N	2021-11-08 10:19:38.378+00	2021-11-08 10:19:38.914+00
5428	\N	died	2021-11-08 10:19:46.9+00	\N	\N	2021-11-08 10:20:34.154+00	2021-11-08 10:20:34.345+00
3356	\N	died	2021-11-08 10:18:41.914+00	\N	\N	2021-11-08 10:19:38.813+00	2021-11-08 10:19:39.162+00
3366	\N	died	2021-11-08 10:18:41.948+00	\N	\N	2021-11-08 10:19:39.12+00	2021-11-08 10:19:39.393+00
3379	\N	died	2021-11-08 10:18:41.98+00	\N	\N	2021-11-08 10:19:39.388+00	2021-11-08 10:19:39.709+00
5435	\N	died	2021-11-08 10:19:46.91+00	\N	\N	2021-11-08 10:20:34.308+00	2021-11-08 10:20:34.572+00
3385	\N	died	2021-11-08 10:18:41.988+00	\N	\N	2021-11-08 10:19:39.705+00	2021-11-08 10:19:39.928+00
3389	\N	died	2021-11-08 10:18:41.995+00	\N	\N	2021-11-08 10:19:39.921+00	2021-11-08 10:19:39.975+00
3393	\N	died	2021-11-08 10:18:42.003+00	\N	\N	2021-11-08 10:19:39.971+00	2021-11-08 10:19:40.207+00
5445	\N	died	2021-11-08 10:19:46.925+00	\N	\N	2021-11-08 10:20:34.567+00	2021-11-08 10:20:34.785+00
3469	\N	died	2021-11-08 10:18:42.174+00	\N	\N	2021-11-08 10:19:41.879+00	2021-11-08 10:19:42.117+00
5544	\N	died	2021-11-08 10:19:48.907+00	\N	\N	2021-11-08 10:20:37.381+00	2021-11-08 10:20:37.617+00
3479	\N	died	2021-11-08 10:18:42.192+00	\N	\N	2021-11-08 10:19:42.096+00	2021-11-08 10:19:42.425+00
3491	\N	died	2021-11-08 10:18:42.393+00	\N	\N	2021-11-08 10:19:42.398+00	2021-11-08 10:19:42.714+00
5452	\N	died	2021-11-08 10:19:46.937+00	\N	\N	2021-11-08 10:20:34.654+00	2021-11-08 10:20:35.352+00
3503	\N	died	2021-11-08 10:18:42.694+00	\N	\N	2021-11-08 10:19:42.699+00	2021-11-08 10:19:42.985+00
3513	\N	died	2021-11-08 10:18:42.976+00	\N	\N	2021-11-08 10:19:42.977+00	2021-11-08 10:19:43.024+00
3515	\N	died	2021-11-08 10:18:43.01+00	\N	\N	2021-11-08 10:19:43.015+00	2021-11-08 10:19:43.075+00
5471	\N	died	2021-11-08 10:19:47.253+00	\N	\N	2021-11-08 10:20:35.148+00	2021-11-08 10:20:35.529+00
3517	\N	died	2021-11-08 10:18:43.056+00	\N	\N	2021-11-08 10:19:43.06+00	2021-11-08 10:19:43.151+00
3522	\N	died	2021-11-08 10:18:43.169+00	\N	\N	2021-11-08 10:19:43.146+00	2021-11-08 10:19:43.23+00
5485	\N	died	2021-11-08 10:19:47.649+00	\N	\N	2021-11-08 10:20:35.505+00	2021-11-08 10:20:36.051+00
3526	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.225+00	2021-11-08 10:19:43.39+00
5551	\N	died	2021-11-08 10:19:49.056+00	\N	\N	2021-11-08 10:20:37.599+00	2021-11-08 10:20:37.856+00
5500	\N	died	2021-11-08 10:19:47.931+00	\N	\N	2021-11-08 10:20:35.939+00	2021-11-08 10:20:36.31+00
5513	\N	died	2021-11-08 10:19:48.199+00	\N	\N	2021-11-08 10:20:36.264+00	2021-11-08 10:20:36.881+00
5561	\N	died	2021-11-08 10:19:49.223+00	\N	\N	2021-11-08 10:20:37.772+00	2021-11-08 10:20:38.443+00
5580	\N	died	2021-11-08 10:19:49.641+00	\N	\N	2021-11-08 10:20:38.292+00	2021-11-08 10:20:38.875+00
5600	\N	died	2021-11-08 10:19:49.907+00	\N	\N	2021-11-08 10:20:38.858+00	2021-11-08 10:20:39.161+00
5609	\N	died	2021-11-08 10:19:50.009+00	\N	\N	2021-11-08 10:20:39.141+00	2021-11-08 10:20:39.246+00
5612	\N	died	2021-11-08 10:19:50.107+00	\N	\N	2021-11-08 10:20:39.239+00	2021-11-08 10:20:39.3+00
5614	\N	died	2021-11-08 10:19:50.14+00	\N	\N	2021-11-08 10:20:39.29+00	2021-11-08 10:20:39.37+00
1206	\N	died	2021-11-08 10:18:33.806+00	\N	\N	2021-11-08 10:18:52.737+00	2021-11-08 10:18:53.092+00
1221	\N	died	2021-11-08 10:18:33.878+00	\N	\N	2021-11-08 10:18:53.087+00	2021-11-08 10:18:53.191+00
1225	\N	died	2021-11-08 10:18:33.888+00	\N	\N	2021-11-08 10:18:53.158+00	2021-11-08 10:18:53.379+00
3213	\N	died	2021-11-08 10:18:41.585+00	\N	\N	2021-11-08 10:19:35.564+00	2021-11-08 10:19:35.733+00
1232	\N	died	2021-11-08 10:18:33.919+00	\N	\N	2021-11-08 10:18:53.375+00	2021-11-08 10:18:53.666+00
1241	\N	died	2021-11-08 10:18:33.972+00	\N	\N	2021-11-08 10:18:53.663+00	2021-11-08 10:18:53.957+00
1251	\N	died	2021-11-08 10:18:34.028+00	\N	\N	2021-11-08 10:18:53.953+00	2021-11-08 10:18:53.992+00
3220	\N	died	2021-11-08 10:18:41.601+00	\N	\N	2021-11-08 10:19:35.679+00	2021-11-08 10:19:36.016+00
1253	\N	died	2021-11-08 10:18:34.034+00	\N	\N	2021-11-08 10:18:53.988+00	2021-11-08 10:18:54.079+00
1256	\N	died	2021-11-08 10:18:34.051+00	\N	\N	2021-11-08 10:18:54.048+00	2021-11-08 10:18:54.301+00
1271	\N	died	2021-11-08 10:18:34.113+00	\N	\N	2021-11-08 10:18:54.287+00	2021-11-08 10:18:54.703+00
3238	\N	died	2021-11-08 10:18:41.65+00	\N	\N	2021-11-08 10:19:36.011+00	2021-11-08 10:19:36.359+00
1292	\N	died	2021-11-08 10:18:34.204+00	\N	\N	2021-11-08 10:18:54.666+00	2021-11-08 10:18:54.951+00
3466	\N	died	2021-11-08 10:18:42.158+00	\N	\N	2021-11-08 10:19:41.837+00	2021-11-08 10:19:42.048+00
1306	\N	died	2021-11-08 10:18:34.258+00	\N	\N	2021-11-08 10:18:54.947+00	2021-11-08 10:18:55.128+00
1314	\N	died	2021-11-08 10:18:34.295+00	\N	\N	2021-11-08 10:18:55.083+00	2021-11-08 10:18:55.408+00
3245	\N	died	2021-11-08 10:18:41.667+00	\N	\N	2021-11-08 10:19:36.221+00	2021-11-08 10:19:36.414+00
1330	\N	died	2021-11-08 10:18:34.349+00	\N	\N	2021-11-08 10:18:55.388+00	2021-11-08 10:18:55.659+00
1343	\N	died	2021-11-08 10:18:34.389+00	\N	\N	2021-11-08 10:18:55.655+00	2021-11-08 10:18:55.78+00
1350	\N	died	2021-11-08 10:18:34.419+00	\N	\N	2021-11-08 10:18:55.776+00	2021-11-08 10:18:55.95+00
3256	\N	died	2021-11-08 10:18:41.692+00	\N	\N	2021-11-08 10:19:36.408+00	2021-11-08 10:19:36.504+00
1358	\N	died	2021-11-08 10:18:34.445+00	\N	\N	2021-11-08 10:18:55.899+00	2021-11-08 10:18:56.26+00
1377	\N	died	2021-11-08 10:18:34.529+00	\N	\N	2021-11-08 10:18:56.218+00	2021-11-08 10:18:56.509+00
1395	\N	died	2021-11-08 10:18:34.597+00	\N	\N	2021-11-08 10:18:56.509+00	2021-11-08 10:18:56.73+00
3260	\N	died	2021-11-08 10:18:41.699+00	\N	\N	2021-11-08 10:19:36.47+00	2021-11-08 10:19:36.916+00
1407	\N	died	2021-11-08 10:18:34.641+00	\N	\N	2021-11-08 10:18:56.705+00	2021-11-08 10:18:56.948+00
3476	\N	died	2021-11-08 10:18:42.183+00	\N	\N	2021-11-08 10:19:42.045+00	2021-11-08 10:19:42.352+00
1420	\N	died	2021-11-08 10:18:34.701+00	\N	\N	2021-11-08 10:18:56.927+00	2021-11-08 10:18:57.291+00
1439	\N	died	2021-11-08 10:18:34.797+00	\N	\N	2021-11-08 10:18:57.246+00	2021-11-08 10:18:57.535+00
3275	\N	died	2021-11-08 10:18:41.737+00	\N	\N	2021-11-08 10:19:36.896+00	2021-11-08 10:19:37.225+00
1453	\N	died	2021-11-08 10:18:34.848+00	\N	\N	2021-11-08 10:18:57.513+00	2021-11-08 10:18:57.803+00
5427	\N	died	2021-11-08 10:19:46.898+00	\N	\N	2021-11-08 10:20:34.138+00	2021-11-08 10:20:34.257+00
1467	\N	died	2021-11-08 10:18:34.91+00	\N	\N	2021-11-08 10:18:57.752+00	2021-11-08 10:18:57.967+00
1480	\N	died	2021-11-08 10:18:34.956+00	\N	\N	2021-11-08 10:18:57.962+00	2021-11-08 10:18:58.19+00
3290	\N	died	2021-11-08 10:18:41.77+00	\N	\N	2021-11-08 10:19:37.19+00	2021-11-08 10:19:37.702+00
1486	\N	died	2021-11-08 10:18:34.985+00	\N	\N	2021-11-08 10:18:58.104+00	2021-11-08 10:18:58.533+00
1502	\N	died	2021-11-08 10:18:35.085+00	\N	\N	2021-11-08 10:18:58.39+00	2021-11-08 10:18:58.639+00
1513	\N	died	2021-11-08 10:18:35.125+00	\N	\N	2021-11-08 10:18:58.614+00	2021-11-08 10:18:58.813+00
3308	\N	died	2021-11-08 10:18:41.809+00	\N	\N	2021-11-08 10:19:37.537+00	2021-11-08 10:19:37.937+00
1520	\N	died	2021-11-08 10:18:35.151+00	\N	\N	2021-11-08 10:18:58.772+00	2021-11-08 10:18:59.172+00
3486	\N	died	2021-11-08 10:18:42.296+00	\N	\N	2021-11-08 10:19:42.3+00	2021-11-08 10:19:42.985+00
1536	\N	died	2021-11-08 10:18:35.225+00	\N	\N	2021-11-08 10:18:59.169+00	2021-11-08 10:18:59.464+00
1544	\N	died	2021-11-08 10:18:35.257+00	\N	\N	2021-11-08 10:18:59.301+00	2021-11-08 10:18:59.697+00
3315	\N	died	2021-11-08 10:18:41.829+00	\N	\N	2021-11-08 10:19:37.858+00	2021-11-08 10:19:38.166+00
1560	\N	died	2021-11-08 10:18:35.326+00	\N	\N	2021-11-08 10:18:59.694+00	2021-11-08 10:18:59.757+00
1564	\N	died	2021-11-08 10:18:35.345+00	\N	\N	2021-11-08 10:18:59.753+00	2021-11-08 10:18:59.934+00
1572	\N	died	2021-11-08 10:18:35.366+00	\N	\N	2021-11-08 10:18:59.929+00	2021-11-08 10:19:00.077+00
3328	\N	died	2021-11-08 10:18:41.849+00	\N	\N	2021-11-08 10:19:38.104+00	2021-11-08 10:19:38.482+00
1577	\N	died	2021-11-08 10:18:35.387+00	\N	\N	2021-11-08 10:19:00.073+00	2021-11-08 10:19:00.156+00
1582	\N	died	2021-11-08 10:18:35.4+00	\N	\N	2021-11-08 10:19:00.15+00	2021-11-08 10:19:00.205+00
1585	\N	died	2021-11-08 10:18:35.408+00	\N	\N	2021-11-08 10:19:00.201+00	2021-11-08 10:19:00.238+00
3343	\N	died	2021-11-08 10:18:41.893+00	\N	\N	2021-11-08 10:19:38.402+00	2021-11-08 10:19:38.914+00
1587	\N	died	2021-11-08 10:18:35.408+00	\N	\N	2021-11-08 10:19:00.231+00	2021-11-08 10:19:00.378+00
3507	\N	died	2021-11-08 10:18:42.793+00	\N	\N	2021-11-08 10:19:42.795+00	2021-11-08 10:19:43.151+00
1594	\N	died	2021-11-08 10:18:35.424+00	\N	\N	2021-11-08 10:19:00.373+00	2021-11-08 10:19:00.435+00
1598	\N	died	2021-11-08 10:18:35.431+00	\N	\N	2021-11-08 10:19:00.431+00	2021-11-08 10:19:00.56+00
3358	\N	died	2021-11-08 10:18:41.914+00	\N	\N	2021-11-08 10:19:38.887+00	2021-11-08 10:19:39.176+00
1603	\N	died	2021-11-08 10:18:35.446+00	\N	\N	2021-11-08 10:19:00.555+00	2021-11-08 10:19:00.734+00
3369	\N	died	2021-11-08 10:18:41.955+00	\N	\N	2021-11-08 10:19:39.17+00	2021-11-08 10:19:39.326+00
3375	\N	died	2021-11-08 10:18:41.972+00	\N	\N	2021-11-08 10:19:39.32+00	2021-11-08 10:19:39.358+00
3519	\N	died	2021-11-08 10:18:43.169+00	\N	\N	2021-11-08 10:19:43.095+00	2021-11-08 10:19:43.39+00
3377	\N	died	2021-11-08 10:18:41.972+00	\N	\N	2021-11-08 10:19:39.354+00	2021-11-08 10:19:39.709+00
5433	\N	died	2021-11-08 10:19:46.908+00	\N	\N	2021-11-08 10:20:34.239+00	2021-11-08 10:20:34.345+00
3381	\N	died	2021-11-08 10:18:41.98+00	\N	\N	2021-11-08 10:19:39.586+00	2021-11-08 10:19:39.958+00
3391	\N	died	2021-11-08 10:18:42.003+00	\N	\N	2021-11-08 10:19:39.953+00	2021-11-08 10:19:40.075+00
3528	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.255+00	2021-11-08 10:19:43.491+00
3397	\N	died	2021-11-08 10:18:42.016+00	\N	\N	2021-11-08 10:19:40.036+00	2021-11-08 10:19:40.535+00
5488	\N	died	2021-11-08 10:19:47.7+00	\N	\N	2021-11-08 10:20:35.627+00	2021-11-08 10:20:36.051+00
3410	\N	died	2021-11-08 10:18:42.052+00	\N	\N	2021-11-08 10:19:40.396+00	2021-11-08 10:19:40.982+00
3540	\N	died	2021-11-08 10:18:43.507+00	\N	\N	2021-11-08 10:19:43.487+00	2021-11-08 10:19:43.536+00
3419	\N	died	2021-11-08 10:18:42.067+00	\N	\N	2021-11-08 10:19:40.953+00	2021-11-08 10:19:41.416+00
3444	\N	died	2021-11-08 10:18:42.124+00	\N	\N	2021-11-08 10:19:41.395+00	2021-11-08 10:19:41.842+00
5437	\N	died	2021-11-08 10:19:46.913+00	\N	\N	2021-11-08 10:20:34.338+00	2021-11-08 10:20:34.55+00
3543	\N	died	2021-11-08 10:18:43.55+00	\N	\N	2021-11-08 10:19:43.539+00	2021-11-08 10:19:43.796+00
5529	\N	died	2021-11-08 10:19:48.564+00	\N	\N	2021-11-08 10:20:36.816+00	2021-11-08 10:20:37.526+00
3551	\N	died	2021-11-08 10:18:43.769+00	\N	\N	2021-11-08 10:19:43.774+00	2021-11-08 10:19:43.996+00
3558	\N	died	2021-11-08 10:18:43.983+00	\N	\N	2021-11-08 10:19:43.987+00	2021-11-08 10:19:44.117+00
5443	\N	died	2021-11-08 10:19:46.922+00	\N	\N	2021-11-08 10:20:34.506+00	2021-11-08 10:20:34.785+00
3564	\N	died	2021-11-08 10:18:44.116+00	\N	\N	2021-11-08 10:19:44.12+00	2021-11-08 10:19:44.333+00
3571	\N	died	2021-11-08 10:18:44.321+00	\N	\N	2021-11-08 10:19:44.326+00	2021-11-08 10:19:44.6+00
3581	\N	died	2021-11-08 10:18:44.598+00	\N	\N	2021-11-08 10:19:44.596+00	2021-11-08 10:19:44.64+00
5450	\N	died	2021-11-08 10:19:46.932+00	\N	\N	2021-11-08 10:20:34.62+00	2021-11-08 10:20:35.122+00
3583	\N	died	2021-11-08 10:18:44.625+00	\N	\N	2021-11-08 10:19:44.63+00	2021-11-08 10:19:44.704+00
5601	\N	died	2021-11-08 10:19:49.923+00	\N	\N	2021-11-08 10:20:38.959+00	2021-11-08 10:20:39.246+00
3585	\N	died	2021-11-08 10:18:44.711+00	\N	\N	2021-11-08 10:19:44.701+00	2021-11-08 10:19:44.781+00
3589	\N	died	2021-11-08 10:18:44.898+00	\N	\N	2021-11-08 10:19:44.85+00	2021-11-08 10:19:44.961+00
5469	\N	died	2021-11-08 10:19:47.216+00	\N	\N	2021-11-08 10:20:35.113+00	2021-11-08 10:20:35.403+00
3596	\N	died	2021-11-08 10:18:45.114+00	\N	\N	2021-11-08 10:19:44.956+00	2021-11-08 10:19:45.061+00
5479	\N	died	2021-11-08 10:19:47.398+00	\N	\N	2021-11-08 10:20:35.363+00	2021-11-08 10:20:35.471+00
5550	\N	died	2021-11-08 10:19:49.039+00	\N	\N	2021-11-08 10:20:37.515+00	2021-11-08 10:20:37.856+00
5483	\N	died	2021-11-08 10:19:47.615+00	\N	\N	2021-11-08 10:20:35.456+00	2021-11-08 10:20:35.67+00
5502	\N	died	2021-11-08 10:19:47.964+00	\N	\N	2021-11-08 10:20:35.972+00	2021-11-08 10:20:36.595+00
5576	\N	died	2021-11-08 10:19:49.506+00	\N	\N	2021-11-08 10:20:38.2+00	2021-11-08 10:20:38.626+00
5519	\N	died	2021-11-08 10:19:48.349+00	\N	\N	2021-11-08 10:20:36.409+00	2021-11-08 10:20:36.881+00
5559	\N	died	2021-11-08 10:19:49.173+00	\N	\N	2021-11-08 10:20:37.739+00	2021-11-08 10:20:38.443+00
5592	\N	died	2021-11-08 10:19:49.775+00	\N	\N	2021-11-08 10:20:38.622+00	2021-11-08 10:20:38.976+00
5611	\N	died	2021-11-08 10:19:50.04+00	\N	\N	2021-11-08 10:20:39.208+00	2021-11-08 10:20:39.387+00
5619	\N	died	2021-11-08 10:19:50.192+00	\N	\N	2021-11-08 10:20:39.381+00	2021-11-08 10:20:39.593+00
5626	\N	died	2021-11-08 10:19:50.373+00	\N	\N	2021-11-08 10:20:39.5+00	2021-11-08 10:20:39.918+00
5642	\N	died	2021-11-08 10:19:50.675+00	\N	\N	2021-11-08 10:20:39.914+00	2021-11-08 10:20:40.378+00
5652	\N	died	2021-11-08 10:19:50.916+00	\N	\N	2021-11-08 10:20:40.366+00	2021-11-08 10:20:40.42+00
1217	\N	died	2021-11-08 10:18:33.867+00	\N	\N	2021-11-08 10:18:52.973+00	2021-11-08 10:18:53.127+00
3230	\N	died	2021-11-08 10:18:41.625+00	\N	\N	2021-11-08 10:19:35.878+00	2021-11-08 10:19:35.932+00
1222	\N	died	2021-11-08 10:18:33.878+00	\N	\N	2021-11-08 10:18:53.105+00	2021-11-08 10:18:53.293+00
1229	\N	died	2021-11-08 10:18:33.899+00	\N	\N	2021-11-08 10:18:53.219+00	2021-11-08 10:18:53.943+00
1242	\N	died	2021-11-08 10:18:33.977+00	\N	\N	2021-11-08 10:18:53.686+00	2021-11-08 10:18:54.025+00
3233	\N	died	2021-11-08 10:18:41.625+00	\N	\N	2021-11-08 10:19:35.928+00	2021-11-08 10:19:35.999+00
1255	\N	died	2021-11-08 10:18:34.039+00	\N	\N	2021-11-08 10:18:54.02+00	2021-11-08 10:18:54.128+00
1260	\N	died	2021-11-08 10:18:34.066+00	\N	\N	2021-11-08 10:18:54.106+00	2021-11-08 10:18:54.301+00
1270	\N	died	2021-11-08 10:18:34.113+00	\N	\N	2021-11-08 10:18:54.275+00	2021-11-08 10:18:54.638+00
3237	\N	died	2021-11-08 10:18:41.65+00	\N	\N	2021-11-08 10:19:35.994+00	2021-11-08 10:19:36.082+00
1290	\N	died	2021-11-08 10:18:34.198+00	\N	\N	2021-11-08 10:18:54.633+00	2021-11-08 10:18:54.794+00
1297	\N	died	2021-11-08 10:18:34.227+00	\N	\N	2021-11-08 10:18:54.758+00	2021-11-08 10:18:55.021+00
1309	\N	died	2021-11-08 10:18:34.277+00	\N	\N	2021-11-08 10:18:54.999+00	2021-11-08 10:18:55.408+00
3241	\N	died	2021-11-08 10:18:41.659+00	\N	\N	2021-11-08 10:19:36.062+00	2021-11-08 10:19:36.391+00
1327	\N	died	2021-11-08 10:18:34.343+00	\N	\N	2021-11-08 10:18:55.34+00	2021-11-08 10:18:55.747+00
3460	\N	died	2021-11-08 10:18:42.15+00	\N	\N	2021-11-08 10:19:41.754+00	2021-11-08 10:19:42.015+00
1345	\N	died	2021-11-08 10:18:34.395+00	\N	\N	2021-11-08 10:18:55.688+00	2021-11-08 10:18:55.95+00
1356	\N	died	2021-11-08 10:18:34.439+00	\N	\N	2021-11-08 10:18:55.866+00	2021-11-08 10:18:56.108+00
3254	\N	died	2021-11-08 10:18:41.683+00	\N	\N	2021-11-08 10:19:36.37+00	2021-11-08 10:19:36.442+00
1370	\N	died	2021-11-08 10:18:34.501+00	\N	\N	2021-11-08 10:18:56.103+00	2021-11-08 10:18:56.26+00
1374	\N	died	2021-11-08 10:18:34.515+00	\N	\N	2021-11-08 10:18:56.165+00	2021-11-08 10:18:56.425+00
1387	\N	died	2021-11-08 10:18:34.568+00	\N	\N	2021-11-08 10:18:56.377+00	2021-11-08 10:18:56.624+00
3258	\N	died	2021-11-08 10:18:41.692+00	\N	\N	2021-11-08 10:19:36.437+00	2021-11-08 10:19:36.595+00
1396	\N	died	2021-11-08 10:18:34.597+00	\N	\N	2021-11-08 10:18:56.52+00	2021-11-08 10:18:56.752+00
1409	\N	died	2021-11-08 10:18:34.659+00	\N	\N	2021-11-08 10:18:56.743+00	2021-11-08 10:18:56.948+00
1416	\N	died	2021-11-08 10:18:34.681+00	\N	\N	2021-11-08 10:18:56.855+00	2021-11-08 10:18:57.117+00
3264	\N	died	2021-11-08 10:18:41.706+00	\N	\N	2021-11-08 10:19:36.528+00	2021-11-08 10:19:36.916+00
1431	\N	died	2021-11-08 10:18:34.763+00	\N	\N	2021-11-08 10:18:57.11+00	2021-11-08 10:18:57.291+00
3474	\N	died	2021-11-08 10:18:42.183+00	\N	\N	2021-11-08 10:19:42.012+00	2021-11-08 10:19:42.352+00
1438	\N	died	2021-11-08 10:18:34.797+00	\N	\N	2021-11-08 10:18:57.236+00	2021-11-08 10:18:57.554+00
1455	\N	died	2021-11-08 10:18:34.854+00	\N	\N	2021-11-08 10:18:57.55+00	2021-11-08 10:18:57.705+00
3274	\N	died	2021-11-08 10:18:41.731+00	\N	\N	2021-11-08 10:19:36.878+00	2021-11-08 10:19:37.225+00
1460	\N	died	2021-11-08 10:18:34.874+00	\N	\N	2021-11-08 10:18:57.634+00	2021-11-08 10:18:57.956+00
1478	\N	died	2021-11-08 10:18:34.95+00	\N	\N	2021-11-08 10:18:57.934+00	2021-11-08 10:18:58.205+00
1491	\N	died	2021-11-08 10:18:35.041+00	\N	\N	2021-11-08 10:18:58.202+00	2021-11-08 10:18:58.265+00
3288	\N	died	2021-11-08 10:18:41.762+00	\N	\N	2021-11-08 10:19:37.103+00	2021-11-08 10:19:37.524+00
1494	\N	died	2021-11-08 10:18:35.058+00	\N	\N	2021-11-08 10:18:58.261+00	2021-11-08 10:18:58.332+00
1498	\N	died	2021-11-08 10:18:35.071+00	\N	\N	2021-11-08 10:18:58.328+00	2021-11-08 10:18:58.533+00
1503	\N	died	2021-11-08 10:18:35.092+00	\N	\N	2021-11-08 10:18:58.404+00	2021-11-08 10:18:58.743+00
3304	\N	died	2021-11-08 10:18:41.803+00	\N	\N	2021-11-08 10:19:37.469+00	2021-11-08 10:19:37.937+00
1515	\N	died	2021-11-08 10:18:35.136+00	\N	\N	2021-11-08 10:18:58.696+00	2021-11-08 10:18:58.958+00
3484	\N	died	2021-11-08 10:18:42.243+00	\N	\N	2021-11-08 10:19:42.248+00	2021-11-08 10:19:42.674+00
1524	\N	died	2021-11-08 10:18:35.159+00	\N	\N	2021-11-08 10:18:58.922+00	2021-11-08 10:18:59.156+00
1534	\N	died	2021-11-08 10:18:35.196+00	\N	\N	2021-11-08 10:18:59.075+00	2021-11-08 10:18:59.464+00
3316	\N	died	2021-11-08 10:18:41.829+00	\N	\N	2021-11-08 10:19:37.87+00	2021-11-08 10:19:38.166+00
1548	\N	died	2021-11-08 10:18:35.271+00	\N	\N	2021-11-08 10:18:59.443+00	2021-11-08 10:18:59.934+00
5453	\N	died	2021-11-08 10:19:46.937+00	\N	\N	2021-11-08 10:20:34.673+00	2021-11-08 10:20:35.352+00
1571	\N	died	2021-11-08 10:18:35.366+00	\N	\N	2021-11-08 10:18:59.916+00	2021-11-08 10:19:00.509+00
1599	\N	died	2021-11-08 10:18:35.439+00	\N	\N	2021-11-08 10:19:00.503+00	2021-11-08 10:19:00.734+00
3326	\N	died	2021-11-08 10:18:41.843+00	\N	\N	2021-11-08 10:19:38.02+00	2021-11-08 10:19:38.253+00
1607	\N	died	2021-11-08 10:18:35.467+00	\N	\N	2021-11-08 10:19:00.618+00	2021-11-08 10:19:00.993+00
1623	\N	died	2021-11-08 10:18:35.511+00	\N	\N	2021-11-08 10:19:00.99+00	2021-11-08 10:19:01.204+00
1633	\N	died	2021-11-08 10:18:35.553+00	\N	\N	2021-11-08 10:19:01.198+00	2021-11-08 10:19:01.273+00
3337	\N	died	2021-11-08 10:18:41.878+00	\N	\N	2021-11-08 10:19:38.249+00	2021-11-08 10:19:38.482+00
1637	\N	died	2021-11-08 10:18:35.566+00	\N	\N	2021-11-08 10:19:01.27+00	2021-11-08 10:19:01.301+00
3501	\N	died	2021-11-08 10:18:42.664+00	\N	\N	2021-11-08 10:19:42.668+00	2021-11-08 10:19:42.985+00
1639	\N	died	2021-11-08 10:18:35.573+00	\N	\N	2021-11-08 10:19:01.297+00	2021-11-08 10:19:01.419+00
3346	\N	died	2021-11-08 10:18:41.893+00	\N	\N	2021-11-08 10:19:38.445+00	2021-11-08 10:19:39.162+00
1643	\N	died	2021-11-08 10:18:35.587+00	\N	\N	2021-11-08 10:19:01.414+00	2021-11-08 10:19:01.49+00
5568	\N	died	2021-11-08 10:19:49.319+00	\N	\N	2021-11-08 10:20:37.939+00	2021-11-08 10:20:38.443+00
3365	\N	died	2021-11-08 10:18:41.948+00	\N	\N	2021-11-08 10:19:39.108+00	2021-11-08 10:19:39.341+00
3376	\N	died	2021-11-08 10:18:41.972+00	\N	\N	2021-11-08 10:19:39.336+00	2021-11-08 10:19:39.458+00
3511	\N	died	2021-11-08 10:18:42.918+00	\N	\N	2021-11-08 10:19:42.93+00	2021-11-08 10:19:43.39+00
3380	\N	died	2021-11-08 10:18:41.98+00	\N	\N	2021-11-08 10:19:39.453+00	2021-11-08 10:19:39.928+00
3387	\N	died	2021-11-08 10:18:41.995+00	\N	\N	2021-11-08 10:19:39.838+00	2021-11-08 10:19:40.207+00
3402	\N	died	2021-11-08 10:18:42.032+00	\N	\N	2021-11-08 10:19:40.155+00	2021-11-08 10:19:40.982+00
5473	\N	died	2021-11-08 10:19:47.265+00	\N	\N	2021-11-08 10:20:35.171+00	2021-11-08 10:20:35.67+00
3418	\N	died	2021-11-08 10:18:42.067+00	\N	\N	2021-11-08 10:19:40.938+00	2021-11-08 10:19:41.416+00
3438	\N	died	2021-11-08 10:18:42.115+00	\N	\N	2021-11-08 10:19:41.295+00	2021-11-08 10:19:41.533+00
3449	\N	died	2021-11-08 10:18:42.132+00	\N	\N	2021-11-08 10:19:41.528+00	2021-11-08 10:19:41.618+00
5489	\N	died	2021-11-08 10:19:47.716+00	\N	\N	2021-11-08 10:20:35.647+00	2021-11-08 10:20:36.051+00
3452	\N	died	2021-11-08 10:18:42.141+00	\N	\N	2021-11-08 10:19:41.583+00	2021-11-08 10:19:41.769+00
3529	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.27+00	2021-11-08 10:19:43.741+00
3548	\N	died	2021-11-08 10:18:43.705+00	\N	\N	2021-11-08 10:19:43.712+00	2021-11-08 10:19:44.117+00
3561	\N	died	2021-11-08 10:18:44.046+00	\N	\N	2021-11-08 10:19:44.052+00	2021-11-08 10:19:44.6+00
5504	\N	died	2021-11-08 10:19:47.998+00	\N	\N	2021-11-08 10:20:36.007+00	2021-11-08 10:20:36.631+00
3576	\N	died	2021-11-08 10:18:44.469+00	\N	\N	2021-11-08 10:19:44.474+00	2021-11-08 10:19:44.867+00
5575	\N	died	2021-11-08 10:19:49.489+00	\N	\N	2021-11-08 10:20:38.182+00	2021-11-08 10:20:38.596+00
3591	\N	died	2021-11-08 10:18:44.932+00	\N	\N	2021-11-08 10:19:44.874+00	2021-11-08 10:19:45.076+00
3600	\N	died	2021-11-08 10:18:45.18+00	\N	\N	2021-11-08 10:19:45.072+00	2021-11-08 10:19:45.194+00
5523	\N	died	2021-11-08 10:19:48.397+00	\N	\N	2021-11-08 10:20:36.616+00	2021-11-08 10:20:36.881+00
3606	\N	died	2021-11-08 10:18:45.279+00	\N	\N	2021-11-08 10:19:45.174+00	2021-11-08 10:19:45.378+00
3615	\N	died	2021-11-08 10:18:45.599+00	\N	\N	2021-11-08 10:19:45.375+00	2021-11-08 10:19:45.593+00
3625	\N	died	2021-11-08 10:18:45.673+00	\N	\N	2021-11-08 10:19:45.589+00	2021-11-08 10:19:45.641+00
5527	\N	died	2021-11-08 10:19:48.48+00	\N	\N	2021-11-08 10:20:36.749+00	2021-11-08 10:20:37.324+00
3628	\N	died	2021-11-08 10:18:45.68+00	\N	\N	2021-11-08 10:19:45.638+00	2021-11-08 10:19:45.732+00
5540	\N	died	2021-11-08 10:19:48.841+00	\N	\N	2021-11-08 10:20:37.286+00	2021-11-08 10:20:37.856+00
5606	\N	died	2021-11-08 10:19:49.975+00	\N	\N	2021-11-08 10:20:39.089+00	2021-11-08 10:20:39.593+00
5556	\N	died	2021-11-08 10:19:49.123+00	\N	\N	2021-11-08 10:20:37.697+00	2021-11-08 10:20:37.96+00
5640	\N	died	2021-11-08 10:19:50.656+00	\N	\N	2021-11-08 10:20:39.881+00	2021-11-08 10:20:40.378+00
5590	\N	died	2021-11-08 10:19:49.76+00	\N	\N	2021-11-08 10:20:38.59+00	2021-11-08 10:20:38.795+00
5597	\N	died	2021-11-08 10:19:49.873+00	\N	\N	2021-11-08 10:20:38.789+00	2021-11-08 10:20:39.161+00
5668	\N	died	2021-11-08 10:19:51.184+00	\N	\N	2021-11-08 10:20:40.833+00	2021-11-08 10:20:40.987+00
5625	\N	died	2021-11-08 10:19:50.276+00	\N	\N	2021-11-08 10:20:39.48+00	2021-11-08 10:20:39.885+00
5650	\N	died	2021-11-08 10:19:50.898+00	\N	\N	2021-11-08 10:20:40.299+00	2021-11-08 10:20:40.841+00
5663	\N	died	2021-11-08 10:19:51.117+00	\N	\N	2021-11-08 10:20:40.656+00	2021-11-08 10:20:40.987+00
5676	\N	died	2021-11-08 10:19:51.235+00	\N	\N	2021-11-08 10:20:40.981+00	2021-11-08 10:20:41.06+00
5680	\N	died	2021-11-08 10:19:51.302+00	\N	\N	2021-11-08 10:20:41.056+00	2021-11-08 10:20:41.12+00
5682	\N	died	2021-11-08 10:19:51.316+00	\N	\N	2021-11-08 10:20:41.109+00	2021-11-08 10:20:41.299+00
5687	\N	died	2021-11-08 10:19:51.366+00	\N	\N	2021-11-08 10:20:41.29+00	2021-11-08 10:20:41.381+00
1216	\N	died	2021-11-08 10:18:33.848+00	\N	\N	2021-11-08 10:18:52.955+00	2021-11-08 10:18:53.145+00
1224	\N	died	2021-11-08 10:18:33.883+00	\N	\N	2021-11-08 10:18:53.14+00	2021-11-08 10:18:53.293+00
1650	\N	died	2021-11-08 10:18:35.612+00	\N	\N	2021-11-08 10:19:01.535+00	2021-11-08 10:19:01.979+00
1228	\N	died	2021-11-08 10:18:33.894+00	\N	\N	2021-11-08 10:18:53.196+00	2021-11-08 10:18:53.638+00
1239	\N	died	2021-11-08 10:18:33.966+00	\N	\N	2021-11-08 10:18:53.634+00	2021-11-08 10:18:53.943+00
1249	\N	died	2021-11-08 10:18:34.022+00	\N	\N	2021-11-08 10:18:53.918+00	2021-11-08 10:18:54.301+00
1670	\N	died	2021-11-08 10:18:35.742+00	\N	\N	2021-11-08 10:19:01.975+00	2021-11-08 10:19:02.276+00
1267	\N	died	2021-11-08 10:18:34.096+00	\N	\N	2021-11-08 10:18:54.227+00	2021-11-08 10:18:54.463+00
1280	\N	died	2021-11-08 10:18:34.148+00	\N	\N	2021-11-08 10:18:54.46+00	2021-11-08 10:18:54.616+00
1285	\N	died	2021-11-08 10:18:34.176+00	\N	\N	2021-11-08 10:18:54.54+00	2021-11-08 10:18:54.794+00
1680	\N	died	2021-11-08 10:18:35.795+00	\N	\N	2021-11-08 10:19:02.272+00	2021-11-08 10:19:02.309+00
1296	\N	died	2021-11-08 10:18:34.221+00	\N	\N	2021-11-08 10:18:54.734+00	2021-11-08 10:18:54.939+00
3234	\N	died	2021-11-08 10:18:41.634+00	\N	\N	2021-11-08 10:19:35.949+00	2021-11-08 10:19:36.142+00
1304	\N	died	2021-11-08 10:18:34.244+00	\N	\N	2021-11-08 10:18:54.913+00	2021-11-08 10:18:55.128+00
1316	\N	died	2021-11-08 10:18:34.3+00	\N	\N	2021-11-08 10:18:55.107+00	2021-11-08 10:18:55.53+00
1682	\N	died	2021-11-08 10:18:35.8+00	\N	\N	2021-11-08 10:19:02.305+00	2021-11-08 10:19:02.43+00
1335	\N	died	2021-11-08 10:18:34.364+00	\N	\N	2021-11-08 10:18:55.471+00	2021-11-08 10:18:55.792+00
3433	\N	died	2021-11-08 10:18:42.106+00	\N	\N	2021-11-08 10:19:41.17+00	2021-11-08 10:19:41.287+00
1351	\N	died	2021-11-08 10:18:34.42+00	\N	\N	2021-11-08 10:18:55.788+00	2021-11-08 10:18:55.95+00
1359	\N	died	2021-11-08 10:18:34.445+00	\N	\N	2021-11-08 10:18:55.914+00	2021-11-08 10:18:56.26+00
1686	\N	died	2021-11-08 10:18:35.821+00	\N	\N	2021-11-08 10:19:02.426+00	2021-11-08 10:19:02.492+00
1379	\N	died	2021-11-08 10:18:34.537+00	\N	\N	2021-11-08 10:18:56.244+00	2021-11-08 10:18:56.624+00
1399	\N	died	2021-11-08 10:18:34.62+00	\N	\N	2021-11-08 10:18:56.576+00	2021-11-08 10:18:56.948+00
1413	\N	died	2021-11-08 10:18:34.673+00	\N	\N	2021-11-08 10:18:56.81+00	2021-11-08 10:18:56.997+00
1690	\N	died	2021-11-08 10:18:35.839+00	\N	\N	2021-11-08 10:19:02.488+00	2021-11-08 10:19:02.643+00
1424	\N	died	2021-11-08 10:18:34.72+00	\N	\N	2021-11-08 10:18:56.993+00	2021-11-08 10:18:57.097+00
3243	\N	died	2021-11-08 10:18:41.659+00	\N	\N	2021-11-08 10:19:36.138+00	2021-11-08 10:19:36.359+00
1428	\N	died	2021-11-08 10:18:34.741+00	\N	\N	2021-11-08 10:18:57.055+00	2021-11-08 10:18:57.291+00
1441	\N	died	2021-11-08 10:18:34.804+00	\N	\N	2021-11-08 10:18:57.275+00	2021-11-08 10:18:57.705+00
1696	\N	died	2021-11-08 10:18:35.865+00	\N	\N	2021-11-08 10:19:02.638+00	2021-11-08 10:19:02.759+00
1461	\N	died	2021-11-08 10:18:34.874+00	\N	\N	2021-11-08 10:18:57.646+00	2021-11-08 10:18:57.9+00
1476	\N	died	2021-11-08 10:18:34.933+00	\N	\N	2021-11-08 10:18:57.896+00	2021-11-08 10:18:58.08+00
1481	\N	died	2021-11-08 10:18:34.961+00	\N	\N	2021-11-08 10:18:58.035+00	2021-11-08 10:18:58.265+00
1703	\N	died	2021-11-08 10:18:35.899+00	\N	\N	2021-11-08 10:19:02.756+00	2021-11-08 10:19:02.843+00
1493	\N	died	2021-11-08 10:18:35.046+00	\N	\N	2021-11-08 10:18:58.242+00	2021-11-08 10:18:58.366+00
1501	\N	died	2021-11-08 10:18:35.078+00	\N	\N	2021-11-08 10:18:58.362+00	2021-11-08 10:18:58.589+00
1510	\N	died	2021-11-08 10:18:35.118+00	\N	\N	2021-11-08 10:18:58.564+00	2021-11-08 10:18:58.826+00
1705	\N	died	2021-11-08 10:18:35.906+00	\N	\N	2021-11-08 10:19:02.838+00	2021-11-08 10:19:02.899+00
1523	\N	died	2021-11-08 10:18:35.159+00	\N	\N	2021-11-08 10:18:58.821+00	2021-11-08 10:18:59.023+00
3252	\N	died	2021-11-08 10:18:41.683+00	\N	\N	2021-11-08 10:19:36.34+00	2021-11-08 10:19:36.916+00
1528	\N	died	2021-11-08 10:18:35.181+00	\N	\N	2021-11-08 10:18:58.984+00	2021-11-08 10:18:59.202+00
1538	\N	died	2021-11-08 10:18:35.231+00	\N	\N	2021-11-08 10:18:59.197+00	2021-11-08 10:18:59.464+00
1708	\N	died	2021-11-08 10:18:35.924+00	\N	\N	2021-11-08 10:19:02.893+00	2021-11-08 10:19:02.962+00
1545	\N	died	2021-11-08 10:18:35.257+00	\N	\N	2021-11-08 10:18:59.313+00	2021-11-08 10:18:59.757+00
1563	\N	died	2021-11-08 10:18:35.339+00	\N	\N	2021-11-08 10:18:59.739+00	2021-11-08 10:19:00.077+00
1576	\N	died	2021-11-08 10:18:35.387+00	\N	\N	2021-11-08 10:19:00.002+00	2021-11-08 10:19:00.435+00
1712	\N	died	2021-11-08 10:18:35.949+00	\N	\N	2021-11-08 10:19:02.958+00	2021-11-08 10:19:03.081+00
1597	\N	died	2021-11-08 10:18:35.431+00	\N	\N	2021-11-08 10:19:00.416+00	2021-11-08 10:19:00.734+00
1605	\N	died	2021-11-08 10:18:35.458+00	\N	\N	2021-11-08 10:19:00.581+00	2021-11-08 10:19:00.868+00
1619	\N	died	2021-11-08 10:18:35.497+00	\N	\N	2021-11-08 10:19:00.864+00	2021-11-08 10:19:01.204+00
3272	\N	died	2021-11-08 10:18:41.731+00	\N	\N	2021-11-08 10:19:36.794+00	2021-11-08 10:19:36.994+00
1628	\N	died	2021-11-08 10:18:35.538+00	\N	\N	2021-11-08 10:19:01.069+00	2021-11-08 10:19:01.552+00
3437	\N	died	2021-11-08 10:18:42.115+00	\N	\N	2021-11-08 10:19:41.283+00	2021-11-08 10:19:41.515+00
1716	\N	died	2021-11-08 10:18:35.961+00	\N	\N	2021-11-08 10:19:03.077+00	2021-11-08 10:19:03.173+00
1722	\N	died	2021-11-08 10:18:35.977+00	\N	\N	2021-11-08 10:19:03.168+00	2021-11-08 10:19:03.239+00
3281	\N	died	2021-11-08 10:18:41.749+00	\N	\N	2021-11-08 10:19:36.991+00	2021-11-08 10:19:37.225+00
1726	\N	died	2021-11-08 10:18:35.99+00	\N	\N	2021-11-08 10:19:03.235+00	2021-11-08 10:19:03.355+00
1730	\N	died	2021-11-08 10:18:36.002+00	\N	\N	2021-11-08 10:19:03.352+00	2021-11-08 10:19:03.463+00
1737	\N	died	2021-11-08 10:18:36.025+00	\N	\N	2021-11-08 10:19:03.46+00	2021-11-08 10:19:03.561+00
3291	\N	died	2021-11-08 10:18:41.77+00	\N	\N	2021-11-08 10:19:37.203+00	2021-11-08 10:19:37.702+00
1740	\N	died	2021-11-08 10:18:36.033+00	\N	\N	2021-11-08 10:19:03.557+00	2021-11-08 10:19:03.622+00
1745	\N	died	2021-11-08 10:18:36.045+00	\N	\N	2021-11-08 10:19:03.617+00	2021-11-08 10:19:03.738+00
1749	\N	died	2021-11-08 10:18:36.051+00	\N	\N	2021-11-08 10:19:03.73+00	2021-11-08 10:19:03.827+00
3310	\N	died	2021-11-08 10:18:41.815+00	\N	\N	2021-11-08 10:19:37.572+00	2021-11-08 10:19:38.166+00
1755	\N	died	2021-11-08 10:18:36.064+00	\N	\N	2021-11-08 10:19:03.823+00	2021-11-08 10:19:03.956+00
3447	\N	died	2021-11-08 10:18:42.132+00	\N	\N	2021-11-08 10:19:41.499+00	2021-11-08 10:19:41.769+00
1758	\N	died	2021-11-08 10:18:36.076+00	\N	\N	2021-11-08 10:19:03.951+00	2021-11-08 10:19:04.037+00
1763	\N	died	2021-11-08 10:18:36.09+00	\N	\N	2021-11-08 10:19:04.033+00	2021-11-08 10:19:04.188+00
3325	\N	died	2021-11-08 10:18:41.843+00	\N	\N	2021-11-08 10:19:38.011+00	2021-11-08 10:19:38.482+00
1769	\N	died	2021-11-08 10:18:36.107+00	\N	\N	2021-11-08 10:19:04.185+00	2021-11-08 10:19:04.258+00
3493	\N	died	2021-11-08 10:18:42.443+00	\N	\N	2021-11-08 10:19:42.444+00	2021-11-08 10:19:42.509+00
1774	\N	died	2021-11-08 10:18:36.113+00	\N	\N	2021-11-08 10:19:04.255+00	2021-11-08 10:19:04.286+00
1776	\N	died	2021-11-08 10:18:36.12+00	\N	\N	2021-11-08 10:19:04.281+00	2021-11-08 10:19:04.42+00
3341	\N	died	2021-11-08 10:18:41.885+00	\N	\N	2021-11-08 10:19:38.361+00	2021-11-08 10:19:38.758+00
1781	\N	died	2021-11-08 10:18:36.132+00	\N	\N	2021-11-08 10:19:04.415+00	2021-11-08 10:19:04.477+00
3354	\N	died	2021-11-08 10:18:41.907+00	\N	\N	2021-11-08 10:19:38.728+00	2021-11-08 10:19:39.326+00
3459	\N	died	2021-11-08 10:18:42.15+00	\N	\N	2021-11-08 10:19:41.738+00	2021-11-08 10:19:41.988+00
3371	\N	died	2021-11-08 10:18:41.964+00	\N	\N	2021-11-08 10:19:39.209+00	2021-11-08 10:19:39.709+00
3552	\N	died	2021-11-08 10:18:43.807+00	\N	\N	2021-11-08 10:19:43.811+00	2021-11-08 10:19:44.117+00
3384	\N	died	2021-11-08 10:18:41.988+00	\N	\N	2021-11-08 10:19:39.688+00	2021-11-08 10:19:40.207+00
3400	\N	died	2021-11-08 10:18:42.024+00	\N	\N	2021-11-08 10:19:40.086+00	2021-11-08 10:19:40.891+00
3496	\N	died	2021-11-08 10:18:42.493+00	\N	\N	2021-11-08 10:19:42.501+00	2021-11-08 10:19:42.69+00
3412	\N	died	2021-11-08 10:18:42.06+00	\N	\N	2021-11-08 10:19:40.833+00	2021-11-08 10:19:41.082+00
3423	\N	died	2021-11-08 10:18:42.076+00	\N	\N	2021-11-08 10:19:41.012+00	2021-11-08 10:19:41.132+00
3430	\N	died	2021-11-08 10:18:42.098+00	\N	\N	2021-11-08 10:19:41.128+00	2021-11-08 10:19:41.175+00
3502	\N	died	2021-11-08 10:18:42.684+00	\N	\N	2021-11-08 10:19:42.684+00	2021-11-08 10:19:42.985+00
3472	\N	died	2021-11-08 10:18:42.183+00	\N	\N	2021-11-08 10:19:41.983+00	2021-11-08 10:19:42.352+00
3560	\N	died	2021-11-08 10:18:44.019+00	\N	\N	2021-11-08 10:19:44.027+00	2021-11-08 10:19:44.6+00
3482	\N	died	2021-11-08 10:18:42.21+00	\N	\N	2021-11-08 10:19:42.214+00	2021-11-08 10:19:42.453+00
3584	\N	died	2021-11-08 10:18:44.645+00	\N	\N	2021-11-08 10:19:44.647+00	2021-11-08 10:19:44.781+00
3512	\N	died	2021-11-08 10:18:42.952+00	\N	\N	2021-11-08 10:19:42.958+00	2021-11-08 10:19:43.39+00
3531	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.304+00	2021-11-08 10:19:43.796+00
3592	\N	died	2021-11-08 10:18:44.946+00	\N	\N	2021-11-08 10:19:44.9+00	2021-11-08 10:19:45.593+00
3574	\N	died	2021-11-08 10:18:44.381+00	\N	\N	2021-11-08 10:19:44.386+00	2021-11-08 10:19:44.653+00
3637	\N	died	2021-11-08 10:18:45.907+00	\N	\N	2021-11-08 10:19:45.869+00	2021-11-08 10:19:46.319+00
3587	\N	died	2021-11-08 10:18:44.857+00	\N	\N	2021-11-08 10:19:44.842+00	2021-11-08 10:19:44.961+00
3621	\N	died	2021-11-08 10:18:45.658+00	\N	\N	2021-11-08 10:19:45.523+00	2021-11-08 10:19:45.944+00
5454	\N	died	2021-11-08 10:19:46.94+00	\N	\N	2021-11-08 10:20:34.767+00	2021-11-08 10:20:34.841+00
5475	\N	died	2021-11-08 10:19:47.286+00	\N	\N	2021-11-08 10:20:35.206+00	2021-11-08 10:20:35.797+00
3657	\N	died	2021-11-08 10:18:46.314+00	\N	\N	2021-11-08 10:19:46.313+00	2021-11-08 10:19:46.532+00
3667	\N	died	2021-11-08 10:18:46.544+00	\N	\N	2021-11-08 10:19:46.529+00	2021-11-08 10:19:46.57+00
5457	\N	died	2021-11-08 10:19:46.946+00	\N	\N	2021-11-08 10:20:34.831+00	2021-11-08 10:20:34.925+00
3669	\N	died	2021-11-08 10:18:46.624+00	\N	\N	2021-11-08 10:19:46.565+00	2021-11-08 10:19:46.652+00
5533	\N	died	2021-11-08 10:19:48.632+00	\N	\N	2021-11-08 10:20:37.023+00	2021-11-08 10:20:37.468+00
3671	\N	died	2021-11-08 10:18:46.648+00	\N	\N	2021-11-08 10:19:46.648+00	2021-11-08 10:19:46.712+00
5461	\N	died	2021-11-08 10:19:46.998+00	\N	\N	2021-11-08 10:20:34.896+00	2021-11-08 10:20:35.352+00
5503	\N	died	2021-11-08 10:19:47.981+00	\N	\N	2021-11-08 10:20:35.989+00	2021-11-08 10:20:36.595+00
5493	\N	died	2021-11-08 10:19:47.764+00	\N	\N	2021-11-08 10:20:35.739+00	2021-11-08 10:20:36.051+00
5547	\N	died	2021-11-08 10:19:48.939+00	\N	\N	2021-11-08 10:20:37.447+00	2021-11-08 10:20:37.856+00
1214	\N	died	2021-11-08 10:18:33.844+00	\N	\N	2021-11-08 10:18:52.927+00	2021-11-08 10:18:53.191+00
1638	\N	died	2021-11-08 10:18:35.573+00	\N	\N	2021-11-08 10:19:01.287+00	2021-11-08 10:19:01.419+00
1226	\N	died	2021-11-08 10:18:33.888+00	\N	\N	2021-11-08 10:18:53.17+00	2021-11-08 10:18:53.57+00
1235	\N	died	2021-11-08 10:18:33.946+00	\N	\N	2021-11-08 10:18:53.566+00	2021-11-08 10:18:53.943+00
1245	\N	died	2021-11-08 10:18:33.999+00	\N	\N	2021-11-08 10:18:53.843+00	2021-11-08 10:18:54.16+00
1642	\N	died	2021-11-08 10:18:35.587+00	\N	\N	2021-11-08 10:19:01.344+00	2021-11-08 10:19:01.817+00
1263	\N	died	2021-11-08 10:18:34.072+00	\N	\N	2021-11-08 10:18:54.155+00	2021-11-08 10:18:54.355+00
1273	\N	died	2021-11-08 10:18:34.124+00	\N	\N	2021-11-08 10:18:54.316+00	2021-11-08 10:18:54.512+00
1282	\N	died	2021-11-08 10:18:34.158+00	\N	\N	2021-11-08 10:18:54.491+00	2021-11-08 10:18:54.703+00
1663	\N	died	2021-11-08 10:18:35.698+00	\N	\N	2021-11-08 10:19:01.815+00	2021-11-08 10:19:02.276+00
1293	\N	died	2021-11-08 10:18:34.204+00	\N	\N	2021-11-08 10:18:54.684+00	2021-11-08 10:18:55.128+00
3257	\N	died	2021-11-08 10:18:41.692+00	\N	\N	2021-11-08 10:19:36.419+00	2021-11-08 10:19:36.504+00
1313	\N	died	2021-11-08 10:18:34.289+00	\N	\N	2021-11-08 10:18:55.062+00	2021-11-08 10:18:55.293+00
1323	\N	died	2021-11-08 10:18:34.323+00	\N	\N	2021-11-08 10:18:55.275+00	2021-11-08 10:18:55.53+00
1673	\N	died	2021-11-08 10:18:35.759+00	\N	\N	2021-11-08 10:19:02.158+00	2021-11-08 10:19:02.43+00
1337	\N	died	2021-11-08 10:18:34.37+00	\N	\N	2021-11-08 10:18:55.505+00	2021-11-08 10:18:55.826+00
3414	\N	died	2021-11-08 10:18:42.06+00	\N	\N	2021-11-08 10:19:40.871+00	2021-11-08 10:19:41.082+00
1353	\N	died	2021-11-08 10:18:34.426+00	\N	\N	2021-11-08 10:18:55.822+00	2021-11-08 10:18:55.991+00
1363	\N	died	2021-11-08 10:18:34.465+00	\N	\N	2021-11-08 10:18:55.988+00	2021-11-08 10:18:56.088+00
1685	\N	died	2021-11-08 10:18:35.817+00	\N	\N	2021-11-08 10:19:02.409+00	2021-11-08 10:19:02.759+00
1367	\N	died	2021-11-08 10:18:34.484+00	\N	\N	2021-11-08 10:18:56.051+00	2021-11-08 10:18:56.26+00
1376	\N	died	2021-11-08 10:18:34.522+00	\N	\N	2021-11-08 10:18:56.197+00	2021-11-08 10:18:56.509+00
1393	\N	died	2021-11-08 10:18:34.588+00	\N	\N	2021-11-08 10:18:56.474+00	2021-11-08 10:18:56.676+00
1699	\N	died	2021-11-08 10:18:35.885+00	\N	\N	2021-11-08 10:19:02.69+00	2021-11-08 10:19:03.081+00
1405	\N	died	2021-11-08 10:18:34.634+00	\N	\N	2021-11-08 10:18:56.672+00	2021-11-08 10:18:56.762+00
3262	\N	died	2021-11-08 10:18:41.705+00	\N	\N	2021-11-08 10:19:36.499+00	2021-11-08 10:19:36.595+00
1410	\N	died	2021-11-08 10:18:34.659+00	\N	\N	2021-11-08 10:18:56.758+00	2021-11-08 10:18:56.948+00
1418	\N	died	2021-11-08 10:18:34.687+00	\N	\N	2021-11-08 10:18:56.889+00	2021-11-08 10:18:57.291+00
1715	\N	died	2021-11-08 10:18:35.955+00	\N	\N	2021-11-08 10:19:03.005+00	2021-11-08 10:19:03.302+00
1435	\N	died	2021-11-08 10:18:34.783+00	\N	\N	2021-11-08 10:18:57.185+00	2021-11-08 10:18:57.471+00
3544	\N	died	2021-11-08 10:18:43.601+00	\N	\N	2021-11-08 10:19:43.605+00	2021-11-08 10:19:43.996+00
1447	\N	died	2021-11-08 10:18:34.828+00	\N	\N	2021-11-08 10:18:57.419+00	2021-11-08 10:18:57.57+00
1456	\N	died	2021-11-08 10:18:34.854+00	\N	\N	2021-11-08 10:18:57.566+00	2021-11-08 10:18:57.705+00
1727	\N	died	2021-11-08 10:18:35.99+00	\N	\N	2021-11-08 10:19:03.298+00	2021-11-08 10:19:03.463+00
1462	\N	died	2021-11-08 10:18:34.879+00	\N	\N	2021-11-08 10:18:57.667+00	2021-11-08 10:18:58.08+00
1482	\N	died	2021-11-08 10:18:34.967+00	\N	\N	2021-11-08 10:18:58.052+00	2021-11-08 10:18:58.332+00
1497	\N	died	2021-11-08 10:18:35.064+00	\N	\N	2021-11-08 10:18:58.305+00	2021-11-08 10:18:58.6+00
1732	\N	died	2021-11-08 10:18:36.002+00	\N	\N	2021-11-08 10:19:03.38+00	2021-11-08 10:19:03.622+00
1512	\N	died	2021-11-08 10:18:35.125+00	\N	\N	2021-11-08 10:18:58.596+00	2021-11-08 10:18:58.743+00
3266	\N	died	2021-11-08 10:18:41.712+00	\N	\N	2021-11-08 10:19:36.562+00	2021-11-08 10:19:37.058+00
1516	\N	died	2021-11-08 10:18:35.136+00	\N	\N	2021-11-08 10:18:58.704+00	2021-11-08 10:18:59.038+00
1531	\N	died	2021-11-08 10:18:35.189+00	\N	\N	2021-11-08 10:18:59.034+00	2021-11-08 10:18:59.202+00
1744	\N	died	2021-11-08 10:18:36.038+00	\N	\N	2021-11-08 10:19:03.605+00	2021-11-08 10:19:03.827+00
1537	\N	died	2021-11-08 10:18:35.231+00	\N	\N	2021-11-08 10:18:59.186+00	2021-11-08 10:18:59.464+00
1547	\N	died	2021-11-08 10:18:35.264+00	\N	\N	2021-11-08 10:18:59.425+00	2021-11-08 10:18:59.934+00
1569	\N	died	2021-11-08 10:18:35.36+00	\N	\N	2021-11-08 10:18:59.879+00	2021-11-08 10:19:00.156+00
1751	\N	died	2021-11-08 10:18:36.057+00	\N	\N	2021-11-08 10:19:03.768+00	2021-11-08 10:19:04.051+00
1581	\N	died	2021-11-08 10:18:35.394+00	\N	\N	2021-11-08 10:19:00.131+00	2021-11-08 10:19:00.388+00
1595	\N	died	2021-11-08 10:18:35.431+00	\N	\N	2021-11-08 10:19:00.384+00	2021-11-08 10:19:00.509+00
3284	\N	died	2021-11-08 10:18:41.755+00	\N	\N	2021-11-08 10:19:37.04+00	2021-11-08 10:19:37.425+00
1600	\N	died	2021-11-08 10:18:35.439+00	\N	\N	2021-11-08 10:19:00.505+00	2021-11-08 10:19:00.734+00
3426	\N	died	2021-11-08 10:18:42.083+00	\N	\N	2021-11-08 10:19:41.067+00	2021-11-08 10:19:41.416+00
1609	\N	died	2021-11-08 10:18:35.467+00	\N	\N	2021-11-08 10:19:00.646+00	2021-11-08 10:19:01.204+00
1627	\N	died	2021-11-08 10:18:35.526+00	\N	\N	2021-11-08 10:19:01.047+00	2021-11-08 10:19:01.289+00
3299	\N	died	2021-11-08 10:18:41.796+00	\N	\N	2021-11-08 10:19:37.341+00	2021-11-08 10:19:37.841+00
1764	\N	died	2021-11-08 10:18:36.09+00	\N	\N	2021-11-08 10:19:04.047+00	2021-11-08 10:19:04.258+00
1771	\N	died	2021-11-08 10:18:36.107+00	\N	\N	2021-11-08 10:19:04.215+00	2021-11-08 10:19:04.477+00
1784	\N	died	2021-11-08 10:18:36.145+00	\N	\N	2021-11-08 10:19:04.462+00	2021-11-08 10:19:04.893+00
3314	\N	died	2021-11-08 10:18:41.821+00	\N	\N	2021-11-08 10:19:37.837+00	2021-11-08 10:19:37.965+00
1801	\N	died	2021-11-08 10:18:36.19+00	\N	\N	2021-11-08 10:19:04.889+00	2021-11-08 10:19:05.111+00
1811	\N	died	2021-11-08 10:18:36.216+00	\N	\N	2021-11-08 10:19:05.106+00	2021-11-08 10:19:05.148+00
1813	\N	died	2021-11-08 10:18:36.222+00	\N	\N	2021-11-08 10:19:05.142+00	2021-11-08 10:19:05.179+00
3322	\N	died	2021-11-08 10:18:41.835+00	\N	\N	2021-11-08 10:19:37.961+00	2021-11-08 10:19:38.166+00
1815	\N	died	2021-11-08 10:18:36.222+00	\N	\N	2021-11-08 10:19:05.175+00	2021-11-08 10:19:05.298+00
3440	\N	died	2021-11-08 10:18:42.115+00	\N	\N	2021-11-08 10:19:41.329+00	2021-11-08 10:19:41.718+00
1819	\N	died	2021-11-08 10:18:36.235+00	\N	\N	2021-11-08 10:19:05.293+00	2021-11-08 10:19:05.359+00
1823	\N	died	2021-11-08 10:18:36.245+00	\N	\N	2021-11-08 10:19:05.355+00	2021-11-08 10:19:05.51+00
3329	\N	died	2021-11-08 10:18:41.849+00	\N	\N	2021-11-08 10:19:38.121+00	2021-11-08 10:19:38.482+00
1829	\N	died	2021-11-08 10:18:36.256+00	\N	\N	2021-11-08 10:19:05.507+00	2021-11-08 10:19:05.634+00
3500	\N	died	2021-11-08 10:18:42.64+00	\N	\N	2021-11-08 10:19:42.645+00	2021-11-08 10:19:42.985+00
1837	\N	died	2021-11-08 10:18:36.277+00	\N	\N	2021-11-08 10:19:05.63+00	2021-11-08 10:19:05.67+00
1839	\N	died	2021-11-08 10:18:36.282+00	\N	\N	2021-11-08 10:19:05.666+00	2021-11-08 10:19:05.803+00
3345	\N	died	2021-11-08 10:18:41.893+00	\N	\N	2021-11-08 10:19:38.432+00	2021-11-08 10:19:39.076+00
1844	\N	died	2021-11-08 10:18:36.292+00	\N	\N	2021-11-08 10:19:05.798+00	2021-11-08 10:19:05.863+00
1848	\N	died	2021-11-08 10:18:36.304+00	\N	\N	2021-11-08 10:19:05.86+00	2021-11-08 10:19:06.01+00
3363	\N	died	2021-11-08 10:18:41.941+00	\N	\N	2021-11-08 10:19:39.07+00	2021-11-08 10:19:39.326+00
3455	\N	died	2021-11-08 10:18:42.141+00	\N	\N	2021-11-08 10:19:41.62+00	2021-11-08 10:19:41.805+00
3370	\N	died	2021-11-08 10:18:41.955+00	\N	\N	2021-11-08 10:19:39.186+00	2021-11-08 10:19:39.379+00
3654	\N	died	2021-11-08 10:18:46.265+00	\N	\N	2021-11-08 10:19:46.265+00	2021-11-08 10:19:46.532+00
3378	\N	died	2021-11-08 10:18:41.98+00	\N	\N	2021-11-08 10:19:39.375+00	2021-11-08 10:19:39.709+00
3383	\N	died	2021-11-08 10:18:41.988+00	\N	\N	2021-11-08 10:19:39.671+00	2021-11-08 10:19:40.075+00
3398	\N	died	2021-11-08 10:18:42.024+00	\N	\N	2021-11-08 10:19:40.058+00	2021-11-08 10:19:40.891+00
3510	\N	died	2021-11-08 10:18:42.851+00	\N	\N	2021-11-08 10:19:42.851+00	2021-11-08 10:19:43.243+00
3463	\N	died	2021-11-08 10:18:42.158+00	\N	\N	2021-11-08 10:19:41.8+00	2021-11-08 10:19:41.965+00
3568	\N	died	2021-11-08 10:18:44.269+00	\N	\N	2021-11-08 10:19:44.274+00	2021-11-08 10:19:44.6+00
3471	\N	died	2021-11-08 10:18:42.174+00	\N	\N	2021-11-08 10:19:41.962+00	2021-11-08 10:19:42.117+00
3480	\N	died	2021-11-08 10:18:42.192+00	\N	\N	2021-11-08 10:19:42.112+00	2021-11-08 10:19:42.425+00
3555	\N	died	2021-11-08 10:18:43.906+00	\N	\N	2021-11-08 10:19:43.911+00	2021-11-08 10:19:44.202+00
3489	\N	died	2021-11-08 10:18:42.363+00	\N	\N	2021-11-08 10:19:42.368+00	2021-11-08 10:19:42.471+00
3495	\N	died	2021-11-08 10:18:42.476+00	\N	\N	2021-11-08 10:19:42.48+00	2021-11-08 10:19:42.653+00
3527	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.238+00	2021-11-08 10:19:43.452+00
3535	\N	died	2021-11-08 10:18:43.506+00	\N	\N	2021-11-08 10:19:43.416+00	2021-11-08 10:19:43.741+00
3590	\N	died	2021-11-08 10:18:44.915+00	\N	\N	2021-11-08 10:19:44.857+00	2021-11-08 10:19:45.061+00
3565	\N	died	2021-11-08 10:18:44.187+00	\N	\N	2021-11-08 10:19:44.194+00	2021-11-08 10:19:44.254+00
3616	\N	died	2021-11-08 10:18:45.616+00	\N	\N	2021-11-08 10:19:45.392+00	2021-11-08 10:19:46.062+00
3575	\N	died	2021-11-08 10:18:44.395+00	\N	\N	2021-11-08 10:19:44.4+00	2021-11-08 10:19:44.857+00
3598	\N	died	2021-11-08 10:18:45.146+00	\N	\N	2021-11-08 10:19:45.043+00	2021-11-08 10:19:45.266+00
3608	\N	died	2021-11-08 10:18:45.362+00	\N	\N	2021-11-08 10:19:45.262+00	2021-11-08 10:19:45.311+00
3611	\N	died	2021-11-08 10:18:45.446+00	\N	\N	2021-11-08 10:19:45.307+00	2021-11-08 10:19:45.415+00
3645	\N	died	2021-11-08 10:18:46.148+00	\N	\N	2021-11-08 10:19:46.054+00	2021-11-08 10:19:46.228+00
3652	\N	died	2021-11-08 10:18:46.219+00	\N	\N	2021-11-08 10:19:46.221+00	2021-11-08 10:19:46.27+00
3662	\N	died	2021-11-08 10:18:46.446+00	\N	\N	2021-11-08 10:19:46.445+00	2021-11-08 10:19:46.836+00
3677	\N	died	2021-11-08 10:18:46.79+00	\N	\N	2021-11-08 10:19:46.768+00	2021-11-08 10:19:47.052+00
5472	\N	died	2021-11-08 10:19:47.254+00	\N	\N	2021-11-08 10:20:35.162+00	2021-11-08 10:20:35.67+00
3689	\N	died	2021-11-08 10:18:47.048+00	\N	\N	2021-11-08 10:19:47.048+00	2021-11-08 10:19:47.186+00
5487	\N	died	2021-11-08 10:19:47.682+00	\N	\N	2021-11-08 10:20:35.591+00	2021-11-08 10:20:36.051+00
5498	\N	died	2021-11-08 10:19:47.897+00	\N	\N	2021-11-08 10:20:35.891+00	2021-11-08 10:20:36.103+00
1215	\N	died	2021-11-08 10:18:33.848+00	\N	\N	2021-11-08 10:18:52.942+00	2021-11-08 10:18:53.412+00
1233	\N	died	2021-11-08 10:18:33.924+00	\N	\N	2021-11-08 10:18:53.408+00	2021-11-08 10:18:53.943+00
1641	\N	died	2021-11-08 10:18:35.58+00	\N	\N	2021-11-08 10:19:01.33+00	2021-11-08 10:19:01.776+00
1243	\N	died	2021-11-08 10:18:33.983+00	\N	\N	2021-11-08 10:18:53.721+00	2021-11-08 10:18:54.079+00
1257	\N	died	2021-11-08 10:18:34.056+00	\N	\N	2021-11-08 10:18:54.058+00	2021-11-08 10:18:54.178+00
1264	\N	died	2021-11-08 10:18:34.084+00	\N	\N	2021-11-08 10:18:54.174+00	2021-11-08 10:18:54.355+00
1660	\N	died	2021-11-08 10:18:35.672+00	\N	\N	2021-11-08 10:19:01.766+00	2021-11-08 10:19:01.963+00
1274	\N	died	2021-11-08 10:18:34.124+00	\N	\N	2021-11-08 10:18:54.329+00	2021-11-08 10:18:54.616+00
3294	\N	died	2021-11-08 10:18:41.777+00	\N	\N	2021-11-08 10:19:37.254+00	2021-11-08 10:19:37.295+00
1286	\N	died	2021-11-08 10:18:34.182+00	\N	\N	2021-11-08 10:18:54.559+00	2021-11-08 10:18:55.033+00
1311	\N	died	2021-11-08 10:18:34.283+00	\N	\N	2021-11-08 10:18:55.029+00	2021-11-08 10:18:55.146+00
1668	\N	died	2021-11-08 10:18:35.736+00	\N	\N	2021-11-08 10:19:01.96+00	2021-11-08 10:19:02.276+00
1318	\N	died	2021-11-08 10:18:34.306+00	\N	\N	2021-11-08 10:18:55.142+00	2021-11-08 10:18:55.293+00
3446	\N	died	2021-11-08 10:18:42.124+00	\N	\N	2021-11-08 10:19:41.478+00	2021-11-08 10:19:41.571+00
1322	\N	died	2021-11-08 10:18:34.318+00	\N	\N	2021-11-08 10:18:55.255+00	2021-11-08 10:18:55.53+00
1333	\N	died	2021-11-08 10:18:34.357+00	\N	\N	2021-11-08 10:18:55.437+00	2021-11-08 10:18:55.576+00
1678	\N	died	2021-11-08 10:18:35.79+00	\N	\N	2021-11-08 10:19:02.242+00	2021-11-08 10:19:02.643+00
1341	\N	died	2021-11-08 10:18:34.383+00	\N	\N	2021-11-08 10:18:55.572+00	2021-11-08 10:18:55.747+00
1344	\N	died	2021-11-08 10:18:34.395+00	\N	\N	2021-11-08 10:18:55.676+00	2021-11-08 10:18:55.846+00
1354	\N	died	2021-11-08 10:18:34.432+00	\N	\N	2021-11-08 10:18:55.841+00	2021-11-08 10:18:56.019+00
1693	\N	died	2021-11-08 10:18:35.857+00	\N	\N	2021-11-08 10:19:02.543+00	2021-11-08 10:19:02.78+00
1364	\N	died	2021-11-08 10:18:34.472+00	\N	\N	2021-11-08 10:18:56.001+00	2021-11-08 10:18:56.26+00
3296	\N	died	2021-11-08 10:18:41.784+00	\N	\N	2021-11-08 10:19:37.291+00	2021-11-08 10:19:37.425+00
1373	\N	died	2021-11-08 10:18:34.515+00	\N	\N	2021-11-08 10:18:56.152+00	2021-11-08 10:18:56.328+00
1384	\N	died	2021-11-08 10:18:34.549+00	\N	\N	2021-11-08 10:18:56.324+00	2021-11-08 10:18:56.425+00
1704	\N	died	2021-11-08 10:18:35.906+00	\N	\N	2021-11-08 10:19:02.777+00	2021-11-08 10:19:02.899+00
1388	\N	died	2021-11-08 10:18:34.568+00	\N	\N	2021-11-08 10:18:56.387+00	2021-11-08 10:18:56.624+00
3593	\N	died	2021-11-08 10:18:45.002+00	\N	\N	2021-11-08 10:19:44.909+00	2021-11-08 10:19:45.194+00
1398	\N	died	2021-11-08 10:18:34.611+00	\N	\N	2021-11-08 10:18:56.561+00	2021-11-08 10:18:56.948+00
1419	\N	died	2021-11-08 10:18:34.694+00	\N	\N	2021-11-08 10:18:56.909+00	2021-11-08 10:18:57.291+00
1707	\N	died	2021-11-08 10:18:35.918+00	\N	\N	2021-11-08 10:19:02.881+00	2021-11-08 10:19:03.081+00
1437	\N	died	2021-11-08 10:18:34.791+00	\N	\N	2021-11-08 10:18:57.217+00	2021-11-08 10:18:57.535+00
1451	\N	died	2021-11-08 10:18:34.841+00	\N	\N	2021-11-08 10:18:57.481+00	2021-11-08 10:18:57.803+00
1469	\N	died	2021-11-08 10:18:34.916+00	\N	\N	2021-11-08 10:18:57.783+00	2021-11-08 10:18:58.19+00
1714	\N	died	2021-11-08 10:18:35.955+00	\N	\N	2021-11-08 10:19:02.992+00	2021-11-08 10:19:03.355+00
1489	\N	died	2021-11-08 10:18:35.027+00	\N	\N	2021-11-08 10:18:58.182+00	2021-11-08 10:18:58.227+00
3301	\N	died	2021-11-08 10:18:41.796+00	\N	\N	2021-11-08 10:19:37.421+00	2021-11-08 10:19:37.524+00
1492	\N	died	2021-11-08 10:18:35.041+00	\N	\N	2021-11-08 10:18:58.214+00	2021-11-08 10:18:58.332+00
1496	\N	died	2021-11-08 10:18:35.064+00	\N	\N	2021-11-08 10:18:58.292+00	2021-11-08 10:18:58.589+00
1729	\N	died	2021-11-08 10:18:35.996+00	\N	\N	2021-11-08 10:19:03.331+00	2021-11-08 10:19:03.561+00
1509	\N	died	2021-11-08 10:18:35.117+00	\N	\N	2021-11-08 10:18:58.551+00	2021-11-08 10:18:58.743+00
1517	\N	died	2021-11-08 10:18:35.143+00	\N	\N	2021-11-08 10:18:58.726+00	2021-11-08 10:18:59.156+00
1533	\N	died	2021-11-08 10:18:35.189+00	\N	\N	2021-11-08 10:18:59.063+00	2021-11-08 10:18:59.464+00
1739	\N	died	2021-11-08 10:18:36.032+00	\N	\N	2021-11-08 10:19:03.542+00	2021-11-08 10:19:03.738+00
1546	\N	died	2021-11-08 10:18:35.257+00	\N	\N	2021-11-08 10:18:59.405+00	2021-11-08 10:18:59.77+00
1565	\N	died	2021-11-08 10:18:35.345+00	\N	\N	2021-11-08 10:18:59.764+00	2021-11-08 10:18:59.951+00
1573	\N	died	2021-11-08 10:18:35.366+00	\N	\N	2021-11-08 10:18:59.947+00	2021-11-08 10:19:00.156+00
1748	\N	died	2021-11-08 10:18:36.051+00	\N	\N	2021-11-08 10:19:03.668+00	2021-11-08 10:19:04.037+00
1580	\N	died	2021-11-08 10:18:35.394+00	\N	\N	2021-11-08 10:19:00.114+00	2021-11-08 10:19:00.378+00
3305	\N	died	2021-11-08 10:18:41.803+00	\N	\N	2021-11-08 10:19:37.488+00	2021-11-08 10:19:37.937+00
1593	\N	died	2021-11-08 10:18:35.424+00	\N	\N	2021-11-08 10:19:00.355+00	2021-11-08 10:19:00.734+00
3451	\N	died	2021-11-08 10:18:42.132+00	\N	\N	2021-11-08 10:19:41.564+00	2021-11-08 10:19:41.718+00
1610	\N	died	2021-11-08 10:18:35.475+00	\N	\N	2021-11-08 10:19:00.717+00	2021-11-08 10:19:01.204+00
1629	\N	died	2021-11-08 10:18:35.538+00	\N	\N	2021-11-08 10:19:01.08+00	2021-11-08 10:19:01.419+00
3319	\N	died	2021-11-08 10:18:41.835+00	\N	\N	2021-11-08 10:19:37.914+00	2021-11-08 10:19:38.241+00
1762	\N	died	2021-11-08 10:18:36.084+00	\N	\N	2021-11-08 10:19:04.015+00	2021-11-08 10:19:04.42+00
1779	\N	died	2021-11-08 10:18:36.132+00	\N	\N	2021-11-08 10:19:04.335+00	2021-11-08 10:19:04.835+00
1797	\N	died	2021-11-08 10:18:36.177+00	\N	\N	2021-11-08 10:19:04.831+00	2021-11-08 10:19:05.111+00
3336	\N	died	2021-11-08 10:18:41.87+00	\N	\N	2021-11-08 10:19:38.237+00	2021-11-08 10:19:38.482+00
1807	\N	died	2021-11-08 10:18:36.209+00	\N	\N	2021-11-08 10:19:05.042+00	2021-11-08 10:19:05.378+00
1824	\N	died	2021-11-08 10:18:36.245+00	\N	\N	2021-11-08 10:19:05.373+00	2021-11-08 10:19:05.634+00
1834	\N	died	2021-11-08 10:18:36.272+00	\N	\N	2021-11-08 10:19:05.584+00	2021-11-08 10:19:05.863+00
3344	\N	died	2021-11-08 10:18:41.893+00	\N	\N	2021-11-08 10:19:38.413+00	2021-11-08 10:19:38.925+00
1847	\N	died	2021-11-08 10:18:36.298+00	\N	\N	2021-11-08 10:19:05.839+00	2021-11-08 10:19:06.594+00
3456	\N	died	2021-11-08 10:18:42.141+00	\N	\N	2021-11-08 10:19:41.638+00	2021-11-08 10:19:41.965+00
1870	\N	died	2021-11-08 10:18:36.374+00	\N	\N	2021-11-08 10:19:06.589+00	2021-11-08 10:19:06.809+00
1880	\N	died	2021-11-08 10:18:36.412+00	\N	\N	2021-11-08 10:19:06.805+00	2021-11-08 10:19:06.843+00
3360	\N	died	2021-11-08 10:18:41.922+00	\N	\N	2021-11-08 10:19:38.921+00	2021-11-08 10:19:39.091+00
1882	\N	died	2021-11-08 10:18:36.418+00	\N	\N	2021-11-08 10:19:06.839+00	2021-11-08 10:19:06.876+00
3523	\N	died	2021-11-08 10:18:43.169+00	\N	\N	2021-11-08 10:19:43.163+00	2021-11-08 10:19:43.452+00
1884	\N	died	2021-11-08 10:18:36.424+00	\N	\N	2021-11-08 10:19:06.872+00	2021-11-08 10:19:06.93+00
1887	\N	died	2021-11-08 10:18:36.434+00	\N	\N	2021-11-08 10:19:06.927+00	2021-11-08 10:19:07.046+00
3364	\N	died	2021-11-08 10:18:41.941+00	\N	\N	2021-11-08 10:19:39.086+00	2021-11-08 10:19:39.326+00
1891	\N	died	2021-11-08 10:18:36.447+00	\N	\N	2021-11-08 10:19:07.041+00	2021-11-08 10:19:07.173+00
1896	\N	died	2021-11-08 10:18:36.591+00	\N	\N	2021-11-08 10:19:07.214+00	2021-11-08 10:19:07.357+00
3372	\N	died	2021-11-08 10:18:41.964+00	\N	\N	2021-11-08 10:19:39.27+00	2021-11-08 10:19:39.928+00
1904	\N	died	2021-11-08 10:18:36.655+00	\N	\N	2021-11-08 10:19:07.353+00	2021-11-08 10:19:07.509+00
3470	\N	died	2021-11-08 10:18:42.174+00	\N	\N	2021-11-08 10:19:41.895+00	2021-11-08 10:19:42.142+00
3386	\N	died	2021-11-08 10:18:41.995+00	\N	\N	2021-11-08 10:19:39.774+00	2021-11-08 10:19:39.996+00
3394	\N	died	2021-11-08 10:18:42.016+00	\N	\N	2021-11-08 10:19:39.991+00	2021-11-08 10:19:40.207+00
3403	\N	died	2021-11-08 10:18:42.032+00	\N	\N	2021-11-08 10:19:40.17+00	2021-11-08 10:19:40.982+00
3420	\N	died	2021-11-08 10:18:42.076+00	\N	\N	2021-11-08 10:19:40.966+00	2021-11-08 10:19:41.515+00
3534	\N	died	2021-11-08 10:18:43.506+00	\N	\N	2021-11-08 10:19:43.395+00	2021-11-08 10:19:43.536+00
3481	\N	died	2021-11-08 10:18:42.192+00	\N	\N	2021-11-08 10:19:42.137+00	2021-11-08 10:19:42.425+00
3490	\N	died	2021-11-08 10:18:42.379+00	\N	\N	2021-11-08 10:19:42.383+00	2021-11-08 10:19:42.56+00
3553	\N	died	2021-11-08 10:18:43.825+00	\N	\N	2021-11-08 10:19:43.827+00	2021-11-08 10:19:44.6+00
3499	\N	died	2021-11-08 10:18:42.562+00	\N	\N	2021-11-08 10:19:42.567+00	2021-11-08 10:19:42.985+00
3508	\N	died	2021-11-08 10:18:42.811+00	\N	\N	2021-11-08 10:19:42.817+00	2021-11-08 10:19:43.23+00
3542	\N	died	2021-11-08 10:18:43.55+00	\N	\N	2021-11-08 10:19:43.533+00	2021-11-08 10:19:43.741+00
3605	\N	died	2021-11-08 10:18:45.262+00	\N	\N	2021-11-08 10:19:45.156+00	2021-11-08 10:19:45.344+00
3549	\N	died	2021-11-08 10:18:43.735+00	\N	\N	2021-11-08 10:19:43.735+00	2021-11-08 10:19:43.819+00
3577	\N	died	2021-11-08 10:18:44.494+00	\N	\N	2021-11-08 10:19:44.497+00	2021-11-08 10:19:44.961+00
3641	\N	died	2021-11-08 10:18:46.02+00	\N	\N	2021-11-08 10:19:45.988+00	2021-11-08 10:19:46.252+00
3653	\N	died	2021-11-08 10:18:46.248+00	\N	\N	2021-11-08 10:19:46.246+00	2021-11-08 10:19:46.532+00
3613	\N	died	2021-11-08 10:18:45.513+00	\N	\N	2021-11-08 10:19:45.34+00	2021-11-08 10:19:45.593+00
3623	\N	died	2021-11-08 10:18:45.666+00	\N	\N	2021-11-08 10:19:45.554+00	2021-11-08 10:19:46.008+00
5482	\N	died	2021-11-08 10:19:47.449+00	\N	\N	2021-11-08 10:20:35.438+00	2021-11-08 10:20:35.529+00
3660	\N	died	2021-11-08 10:18:46.413+00	\N	\N	2021-11-08 10:19:46.413+00	2021-11-08 10:19:46.97+00
3681	\N	died	2021-11-08 10:18:46.993+00	\N	\N	2021-11-08 10:19:46.939+00	2021-11-08 10:19:47.201+00
3694	\N	died	2021-11-08 10:18:47.246+00	\N	\N	2021-11-08 10:19:47.197+00	2021-11-08 10:19:47.438+00
3704	\N	died	2021-11-08 10:18:47.413+00	\N	\N	2021-11-08 10:19:47.414+00	2021-11-08 10:19:47.77+00
3722	\N	died	2021-11-08 10:18:47.846+00	\N	\N	2021-11-08 10:19:47.765+00	2021-11-08 10:19:47.985+00
3732	\N	died	2021-11-08 10:18:48.062+00	\N	\N	2021-11-08 10:19:47.981+00	2021-11-08 10:19:48.019+00
5486	\N	died	2021-11-08 10:19:47.665+00	\N	\N	2021-11-08 10:20:35.521+00	2021-11-08 10:20:35.67+00
3734	\N	died	2021-11-08 10:18:48.098+00	\N	\N	2021-11-08 10:19:48.015+00	2021-11-08 10:19:48.1+00
5490	\N	died	2021-11-08 10:19:47.717+00	\N	\N	2021-11-08 10:20:35.664+00	2021-11-08 10:20:35.797+00
5494	\N	died	2021-11-08 10:19:47.781+00	\N	\N	2021-11-08 10:20:35.756+00	2021-11-08 10:20:36.087+00
1212	\N	died	2021-11-08 10:18:33.834+00	\N	\N	2021-11-08 10:18:52.887+00	2021-11-08 10:18:53.587+00
1236	\N	died	2021-11-08 10:18:33.951+00	\N	\N	2021-11-08 10:18:53.583+00	2021-11-08 10:18:53.943+00
1575	\N	died	2021-11-08 10:18:35.373+00	\N	\N	2021-11-08 10:18:59.98+00	2021-11-08 10:19:00.378+00
1246	\N	died	2021-11-08 10:18:34.004+00	\N	\N	2021-11-08 10:18:53.865+00	2021-11-08 10:18:54.128+00
1818	\N	died	2021-11-08 10:18:36.228+00	\N	\N	2021-11-08 10:19:05.272+00	2021-11-08 10:19:05.634+00
1261	\N	died	2021-11-08 10:18:34.072+00	\N	\N	2021-11-08 10:18:54.125+00	2021-11-08 10:18:54.301+00
1268	\N	died	2021-11-08 10:18:34.102+00	\N	\N	2021-11-08 10:18:54.241+00	2021-11-08 10:18:54.524+00
1590	\N	died	2021-11-08 10:18:35.416+00	\N	\N	2021-11-08 10:19:00.321+00	2021-11-08 10:19:00.734+00
1284	\N	died	2021-11-08 10:18:34.17+00	\N	\N	2021-11-08 10:18:54.52+00	2021-11-08 10:18:54.703+00
3333	\N	died	2021-11-08 10:18:41.863+00	\N	\N	2021-11-08 10:19:38.188+00	2021-11-08 10:19:38.316+00
1291	\N	died	2021-11-08 10:18:34.199+00	\N	\N	2021-11-08 10:18:54.646+00	2021-11-08 10:18:54.807+00
1300	\N	died	2021-11-08 10:18:34.232+00	\N	\N	2021-11-08 10:18:54.803+00	2021-11-08 10:18:54.939+00
1604	\N	died	2021-11-08 10:18:35.458+00	\N	\N	2021-11-08 10:19:00.567+00	2021-11-08 10:19:00.834+00
1303	\N	died	2021-11-08 10:18:34.244+00	\N	\N	2021-11-08 10:18:54.901+00	2021-11-08 10:18:55.128+00
1312	\N	died	2021-11-08 10:18:34.289+00	\N	\N	2021-11-08 10:18:55.048+00	2021-11-08 10:18:55.248+00
1321	\N	died	2021-11-08 10:18:34.318+00	\N	\N	2021-11-08 10:18:55.243+00	2021-11-08 10:18:55.408+00
1617	\N	died	2021-11-08 10:18:35.488+00	\N	\N	2021-11-08 10:19:00.829+00	2021-11-08 10:19:01.007+00
1326	\N	died	2021-11-08 10:18:34.328+00	\N	\N	2021-11-08 10:18:55.321+00	2021-11-08 10:18:55.53+00
1833	\N	died	2021-11-08 10:18:36.267+00	\N	\N	2021-11-08 10:19:05.563+00	2021-11-08 10:19:05.81+00
1336	\N	died	2021-11-08 10:18:34.37+00	\N	\N	2021-11-08 10:18:55.493+00	2021-11-08 10:18:55.95+00
1355	\N	died	2021-11-08 10:18:34.432+00	\N	\N	2021-11-08 10:18:55.854+00	2021-11-08 10:18:56.04+00
1624	\N	died	2021-11-08 10:18:35.519+00	\N	\N	2021-11-08 10:19:01.003+00	2021-11-08 10:19:01.273+00
1366	\N	died	2021-11-08 10:18:34.478+00	\N	\N	2021-11-08 10:18:56.032+00	2021-11-08 10:18:56.138+00
1371	\N	died	2021-11-08 10:18:34.501+00	\N	\N	2021-11-08 10:18:56.112+00	2021-11-08 10:18:56.309+00
1382	\N	died	2021-11-08 10:18:34.544+00	\N	\N	2021-11-08 10:18:56.287+00	2021-11-08 10:18:56.367+00
1634	\N	died	2021-11-08 10:18:35.553+00	\N	\N	2021-11-08 10:19:01.213+00	2021-11-08 10:19:01.322+00
1386	\N	died	2021-11-08 10:18:34.561+00	\N	\N	2021-11-08 10:18:56.363+00	2021-11-08 10:18:56.509+00
1392	\N	died	2021-11-08 10:18:34.588+00	\N	\N	2021-11-08 10:18:56.457+00	2021-11-08 10:18:56.643+00
1403	\N	died	2021-11-08 10:18:34.627+00	\N	\N	2021-11-08 10:18:56.639+00	2021-11-08 10:18:56.73+00
1640	\N	died	2021-11-08 10:18:35.58+00	\N	\N	2021-11-08 10:19:01.318+00	2021-11-08 10:19:01.49+00
1406	\N	died	2021-11-08 10:18:34.641+00	\N	\N	2021-11-08 10:18:56.693+00	2021-11-08 10:18:56.948+00
1845	\N	died	2021-11-08 10:18:36.292+00	\N	\N	2021-11-08 10:19:05.805+00	2021-11-08 10:19:06.01+00
1414	\N	died	2021-11-08 10:18:34.673+00	\N	\N	2021-11-08 10:18:56.821+00	2021-11-08 10:18:57.097+00
1427	\N	died	2021-11-08 10:18:34.741+00	\N	\N	2021-11-08 10:18:57.044+00	2021-11-08 10:18:57.291+00
1645	\N	died	2021-11-08 10:18:35.594+00	\N	\N	2021-11-08 10:19:01.452+00	2021-11-08 10:19:01.676+00
1436	\N	died	2021-11-08 10:18:34.783+00	\N	\N	2021-11-08 10:18:57.197+00	2021-11-08 10:18:57.471+00
1449	\N	died	2021-11-08 10:18:34.834+00	\N	\N	2021-11-08 10:18:57.446+00	2021-11-08 10:18:57.608+00
1458	\N	died	2021-11-08 10:18:34.868+00	\N	\N	2021-11-08 10:18:57.604+00	2021-11-08 10:18:57.803+00
1655	\N	died	2021-11-08 10:18:35.626+00	\N	\N	2021-11-08 10:19:01.66+00	2021-11-08 10:19:01.963+00
1466	\N	died	2021-11-08 10:18:34.904+00	\N	\N	2021-11-08 10:18:57.734+00	2021-11-08 10:18:57.889+00
1474	\N	died	2021-11-08 10:18:34.928+00	\N	\N	2021-11-08 10:18:57.862+00	2021-11-08 10:18:58.08+00
1483	\N	died	2021-11-08 10:18:34.967+00	\N	\N	2021-11-08 10:18:58.063+00	2021-11-08 10:18:58.341+00
1669	\N	died	2021-11-08 10:18:35.731+00	\N	\N	2021-11-08 10:19:01.965+00	2021-11-08 10:19:02.276+00
1499	\N	died	2021-11-08 10:18:35.071+00	\N	\N	2021-11-08 10:18:58.338+00	2021-11-08 10:18:58.533+00
1852	\N	died	2021-11-08 10:18:36.321+00	\N	\N	2021-11-08 10:19:05.977+00	2021-11-08 10:19:06.809+00
1505	\N	died	2021-11-08 10:18:35.098+00	\N	\N	2021-11-08 10:18:58.48+00	2021-11-08 10:18:58.813+00
1521	\N	died	2021-11-08 10:18:35.151+00	\N	\N	2021-11-08 10:18:58.788+00	2021-11-08 10:18:59.464+00
1679	\N	died	2021-11-08 10:18:35.795+00	\N	\N	2021-11-08 10:19:02.258+00	2021-11-08 10:19:02.759+00
1542	\N	died	2021-11-08 10:18:35.251+00	\N	\N	2021-11-08 10:18:59.266+00	2021-11-08 10:18:59.623+00
3338	\N	died	2021-11-08 10:18:41.878+00	\N	\N	2021-11-08 10:19:38.311+00	2021-11-08 10:19:38.482+00
1554	\N	died	2021-11-08 10:18:35.303+00	\N	\N	2021-11-08 10:18:59.542+00	2021-11-08 10:18:59.724+00
1562	\N	died	2021-11-08 10:18:35.333+00	\N	\N	2021-11-08 10:18:59.721+00	2021-11-08 10:18:59.851+00
1872	\N	died	2021-11-08 10:18:36.388+00	\N	\N	2021-11-08 10:19:06.628+00	2021-11-08 10:19:06.862+00
1567	\N	died	2021-11-08 10:18:35.353+00	\N	\N	2021-11-08 10:18:59.846+00	2021-11-08 10:19:00.077+00
1697	\N	died	2021-11-08 10:18:35.879+00	\N	\N	2021-11-08 10:19:02.665+00	2021-11-08 10:19:02.962+00
1883	\N	died	2021-11-08 10:18:36.424+00	\N	\N	2021-11-08 10:19:06.859+00	2021-11-08 10:19:06.897+00
1709	\N	died	2021-11-08 10:18:35.929+00	\N	\N	2021-11-08 10:19:02.91+00	2021-11-08 10:19:03.173+00
1720	\N	died	2021-11-08 10:18:35.972+00	\N	\N	2021-11-08 10:19:03.143+00	2021-11-08 10:19:03.53+00
1738	\N	died	2021-11-08 10:18:36.025+00	\N	\N	2021-11-08 10:19:03.523+00	2021-11-08 10:19:03.622+00
1885	\N	died	2021-11-08 10:18:36.43+00	\N	\N	2021-11-08 10:19:06.894+00	2021-11-08 10:19:07.046+00
1743	\N	died	2021-11-08 10:18:36.038+00	\N	\N	2021-11-08 10:19:03.588+00	2021-11-08 10:19:03.827+00
3348	\N	died	2021-11-08 10:18:41.899+00	\N	\N	2021-11-08 10:19:38.478+00	2021-11-08 10:19:38.515+00
1753	\N	died	2021-11-08 10:18:36.057+00	\N	\N	2021-11-08 10:19:03.797+00	2021-11-08 10:19:04.258+00
1770	\N	died	2021-11-08 10:18:36.107+00	\N	\N	2021-11-08 10:19:04.198+00	2021-11-08 10:19:04.42+00
1889	\N	died	2021-11-08 10:18:36.441+00	\N	\N	2021-11-08 10:19:07.01+00	2021-11-08 10:19:07.328+00
1780	\N	died	2021-11-08 10:18:36.132+00	\N	\N	2021-11-08 10:19:04.397+00	2021-11-08 10:19:04.754+00
3428	\N	died	2021-11-08 10:18:42.098+00	\N	\N	2021-11-08 10:19:41.098+00	2021-11-08 10:19:41.175+00
1795	\N	died	2021-11-08 10:18:36.177+00	\N	\N	2021-11-08 10:19:04.751+00	2021-11-08 10:19:05.111+00
1804	\N	died	2021-11-08 10:18:36.195+00	\N	\N	2021-11-08 10:19:04.938+00	2021-11-08 10:19:05.298+00
3350	\N	died	2021-11-08 10:18:41.899+00	\N	\N	2021-11-08 10:19:38.511+00	2021-11-08 10:19:38.6+00
3477	\N	died	2021-11-08 10:18:42.192+00	\N	\N	2021-11-08 10:19:42.065+00	2021-11-08 10:19:42.352+00
1901	\N	died	2021-11-08 10:18:36.641+00	\N	\N	2021-11-08 10:19:07.302+00	2021-11-08 10:19:07.63+00
1914	\N	died	2021-11-08 10:18:36.702+00	\N	\N	2021-11-08 10:19:07.567+00	2021-11-08 10:19:07.895+00
3352	\N	died	2021-11-08 10:18:41.907+00	\N	\N	2021-11-08 10:19:38.596+00	2021-11-08 10:19:38.914+00
1929	\N	died	2021-11-08 10:18:36.779+00	\N	\N	2021-11-08 10:19:07.89+00	2021-11-08 10:19:08.112+00
1939	\N	died	2021-11-08 10:18:36.819+00	\N	\N	2021-11-08 10:19:08.106+00	2021-11-08 10:19:08.147+00
1941	\N	died	2021-11-08 10:18:36.832+00	\N	\N	2021-11-08 10:19:08.143+00	2021-11-08 10:19:08.269+00
3357	\N	died	2021-11-08 10:18:41.914+00	\N	\N	2021-11-08 10:19:38.88+00	2021-11-08 10:19:39.326+00
1943	\N	died	2021-11-08 10:18:36.863+00	\N	\N	2021-11-08 10:19:08.261+00	2021-11-08 10:19:08.347+00
3432	\N	died	2021-11-08 10:18:42.106+00	\N	\N	2021-11-08 10:19:41.157+00	2021-11-08 10:19:41.416+00
1948	\N	died	2021-11-08 10:18:36.921+00	\N	\N	2021-11-08 10:19:08.344+00	2021-11-08 10:19:08.498+00
1954	\N	died	2021-11-08 10:18:36.953+00	\N	\N	2021-11-08 10:19:08.494+00	2021-11-08 10:19:08.578+00
3373	\N	died	2021-11-08 10:18:41.964+00	\N	\N	2021-11-08 10:19:39.287+00	2021-11-08 10:19:39.928+00
1959	\N	died	2021-11-08 10:18:36.98+00	\N	\N	2021-11-08 10:19:08.573+00	2021-11-08 10:19:08.631+00
1962	\N	died	2021-11-08 10:18:36.991+00	\N	\N	2021-11-08 10:19:08.626+00	2021-11-08 10:19:08.664+00
3388	\N	died	2021-11-08 10:18:41.995+00	\N	\N	2021-11-08 10:19:39.854+00	2021-11-08 10:19:40.207+00
3461	\N	died	2021-11-08 10:18:42.15+00	\N	\N	2021-11-08 10:19:41.763+00	2021-11-08 10:19:41.853+00
3404	\N	died	2021-11-08 10:18:42.04+00	\N	\N	2021-11-08 10:19:40.19+00	2021-11-08 10:19:40.999+00
3422	\N	died	2021-11-08 10:18:42.076+00	\N	\N	2021-11-08 10:19:40.995+00	2021-11-08 10:19:41.116+00
3541	\N	died	2021-11-08 10:18:43.507+00	\N	\N	2021-11-08 10:19:43.504+00	2021-11-08 10:19:43.741+00
3441	\N	died	2021-11-08 10:18:42.115+00	\N	\N	2021-11-08 10:19:41.345+00	2021-11-08 10:19:41.718+00
3457	\N	died	2021-11-08 10:18:42.15+00	\N	\N	2021-11-08 10:19:41.711+00	2021-11-08 10:19:41.769+00
3487	\N	died	2021-11-08 10:18:42.322+00	\N	\N	2021-11-08 10:19:42.316+00	2021-11-08 10:19:42.985+00
3467	\N	died	2021-11-08 10:18:42.174+00	\N	\N	2021-11-08 10:19:41.85+00	2021-11-08 10:19:42.073+00
3525	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.205+00	2021-11-08 10:19:43.466+00
3509	\N	died	2021-11-08 10:18:42.832+00	\N	\N	2021-11-08 10:19:42.834+00	2021-11-08 10:19:43.23+00
3603	\N	died	2021-11-08 10:18:45.229+00	\N	\N	2021-11-08 10:19:45.122+00	2021-11-08 10:19:45.593+00
3538	\N	died	2021-11-08 10:18:43.507+00	\N	\N	2021-11-08 10:19:43.462+00	2021-11-08 10:19:43.51+00
3570	\N	died	2021-11-08 10:18:44.306+00	\N	\N	2021-11-08 10:19:44.31+00	2021-11-08 10:19:44.6+00
3547	\N	died	2021-11-08 10:18:43.68+00	\N	\N	2021-11-08 10:19:43.685+00	2021-11-08 10:19:44.117+00
3563	\N	died	2021-11-08 10:18:44.099+00	\N	\N	2021-11-08 10:19:44.105+00	2021-11-08 10:19:44.221+00
3580	\N	died	2021-11-08 10:18:44.56+00	\N	\N	2021-11-08 10:19:44.566+00	2021-11-08 10:19:45.144+00
3566	\N	died	2021-11-08 10:18:44.211+00	\N	\N	2021-11-08 10:19:44.216+00	2021-11-08 10:19:44.317+00
5506	\N	died	2021-11-08 10:19:48.081+00	\N	\N	2021-11-08 10:20:36.065+00	2021-11-08 10:20:36.31+00
3620	\N	died	2021-11-08 10:18:45.655+00	\N	\N	2021-11-08 10:19:45.506+00	2021-11-08 10:19:45.712+00
3629	\N	died	2021-11-08 10:18:45.705+00	\N	\N	2021-11-08 10:19:45.706+00	2021-11-08 10:19:45.799+00
5511	\N	died	2021-11-08 10:19:48.166+00	\N	\N	2021-11-08 10:20:36.223+00	2021-11-08 10:20:36.595+00
5520	\N	died	2021-11-08 10:19:48.365+00	\N	\N	2021-11-08 10:20:36.503+00	2021-11-08 10:20:36.983+00
1272	\N	died	2021-11-08 10:18:34.119+00	\N	\N	2021-11-08 10:18:54.298+00	2021-11-08 10:18:54.355+00
1635	\N	died	2021-11-08 10:18:35.559+00	\N	\N	2021-11-08 10:19:01.233+00	2021-11-08 10:19:01.437+00
1275	\N	died	2021-11-08 10:18:34.13+00	\N	\N	2021-11-08 10:18:54.35+00	2021-11-08 10:18:54.387+00
1277	\N	died	2021-11-08 10:18:34.135+00	\N	\N	2021-11-08 10:18:54.383+00	2021-11-08 10:18:54.512+00
1281	\N	died	2021-11-08 10:18:34.153+00	\N	\N	2021-11-08 10:18:54.474+00	2021-11-08 10:18:54.794+00
1644	\N	died	2021-11-08 10:18:35.587+00	\N	\N	2021-11-08 10:19:01.432+00	2021-11-08 10:19:01.552+00
1295	\N	died	2021-11-08 10:18:34.216+00	\N	\N	2021-11-08 10:18:54.715+00	2021-11-08 10:18:54.883+00
1302	\N	died	2021-11-08 10:18:34.238+00	\N	\N	2021-11-08 10:18:54.879+00	2021-11-08 10:18:55.021+00
1307	\N	died	2021-11-08 10:18:34.266+00	\N	\N	2021-11-08 10:18:54.967+00	2021-11-08 10:18:55.229+00
1649	\N	died	2021-11-08 10:18:35.601+00	\N	\N	2021-11-08 10:19:01.513+00	2021-11-08 10:19:01.698+00
1319	\N	died	2021-11-08 10:18:34.306+00	\N	\N	2021-11-08 10:18:55.154+00	2021-11-08 10:18:55.408+00
1868	\N	died	2021-11-08 10:18:36.368+00	\N	\N	2021-11-08 10:19:06.557+00	2021-11-08 10:19:06.809+00
1328	\N	died	2021-11-08 10:18:34.343+00	\N	\N	2021-11-08 10:18:55.355+00	2021-11-08 10:18:55.747+00
1347	\N	died	2021-11-08 10:18:34.401+00	\N	\N	2021-11-08 10:18:55.721+00	2021-11-08 10:18:55.991+00
1657	\N	died	2021-11-08 10:18:35.633+00	\N	\N	2021-11-08 10:19:01.694+00	2021-11-08 10:19:01.76+00
1362	\N	died	2021-11-08 10:18:34.459+00	\N	\N	2021-11-08 10:18:55.966+00	2021-11-08 10:18:56.088+00
1368	\N	died	2021-11-08 10:18:34.484+00	\N	\N	2021-11-08 10:18:56.063+00	2021-11-08 10:18:56.26+00
1378	\N	died	2021-11-08 10:18:34.529+00	\N	\N	2021-11-08 10:18:56.23+00	2021-11-08 10:18:56.624+00
1659	\N	died	2021-11-08 10:18:35.661+00	\N	\N	2021-11-08 10:19:01.751+00	2021-11-08 10:19:01.938+00
1397	\N	died	2021-11-08 10:18:34.605+00	\N	\N	2021-11-08 10:18:56.542+00	2021-11-08 10:18:56.791+00
1411	\N	died	2021-11-08 10:18:34.666+00	\N	\N	2021-11-08 10:18:56.775+00	2021-11-08 10:18:56.98+00
1422	\N	died	2021-11-08 10:18:34.708+00	\N	\N	2021-11-08 10:18:56.955+00	2021-11-08 10:18:57.029+00
1667	\N	died	2021-11-08 10:18:35.727+00	\N	\N	2021-11-08 10:19:01.934+00	2021-11-08 10:19:02.276+00
1426	\N	died	2021-11-08 10:18:34.728+00	\N	\N	2021-11-08 10:18:57.025+00	2021-11-08 10:18:57.141+00
1878	\N	died	2021-11-08 10:18:36.406+00	\N	\N	2021-11-08 10:19:06.772+00	2021-11-08 10:19:07.226+00
1432	\N	died	2021-11-08 10:18:34.77+00	\N	\N	2021-11-08 10:18:57.138+00	2021-11-08 10:18:57.291+00
1440	\N	died	2021-11-08 10:18:34.797+00	\N	\N	2021-11-08 10:18:57.255+00	2021-11-08 10:18:57.622+00
1677	\N	died	2021-11-08 10:18:35.784+00	\N	\N	2021-11-08 10:19:02.226+00	2021-11-08 10:19:02.514+00
1459	\N	died	2021-11-08 10:18:34.868+00	\N	\N	2021-11-08 10:18:57.615+00	2021-11-08 10:18:57.803+00
3362	\N	died	2021-11-08 10:18:41.941+00	\N	\N	2021-11-08 10:19:38.952+00	2021-11-08 10:19:39.162+00
1468	\N	died	2021-11-08 10:18:34.91+00	\N	\N	2021-11-08 10:18:57.762+00	2021-11-08 10:18:58.19+00
1485	\N	died	2021-11-08 10:18:34.984+00	\N	\N	2021-11-08 10:18:58.093+00	2021-11-08 10:18:58.332+00
1691	\N	died	2021-11-08 10:18:35.844+00	\N	\N	2021-11-08 10:19:02.509+00	2021-11-08 10:19:02.759+00
1495	\N	died	2021-11-08 10:18:35.058+00	\N	\N	2021-11-08 10:18:58.271+00	2021-11-08 10:18:58.533+00
1507	\N	died	2021-11-08 10:18:35.112+00	\N	\N	2021-11-08 10:18:58.519+00	2021-11-08 10:18:58.968+00
1527	\N	died	2021-11-08 10:18:35.174+00	\N	\N	2021-11-08 10:18:58.963+00	2021-11-08 10:18:59.156+00
1700	\N	died	2021-11-08 10:18:35.892+00	\N	\N	2021-11-08 10:19:02.709+00	2021-11-08 10:19:03.093+00
1532	\N	died	2021-11-08 10:18:35.189+00	\N	\N	2021-11-08 10:18:59.048+00	2021-11-08 10:18:59.251+00
1897	\N	died	2021-11-08 10:18:36.599+00	\N	\N	2021-11-08 10:19:07.221+00	2021-11-08 10:19:07.509+00
1541	\N	died	2021-11-08 10:18:35.244+00	\N	\N	2021-11-08 10:18:59.246+00	2021-11-08 10:18:59.475+00
1550	\N	died	2021-11-08 10:18:35.277+00	\N	\N	2021-11-08 10:18:59.472+00	2021-11-08 10:18:59.527+00
1717	\N	died	2021-11-08 10:18:35.961+00	\N	\N	2021-11-08 10:19:03.089+00	2021-11-08 10:19:03.239+00
1553	\N	died	2021-11-08 10:18:35.289+00	\N	\N	2021-11-08 10:18:59.521+00	2021-11-08 10:18:59.685+00
3439	\N	died	2021-11-08 10:18:42.115+00	\N	\N	2021-11-08 10:19:41.312+00	2021-11-08 10:19:41.618+00
1557	\N	died	2021-11-08 10:18:35.311+00	\N	\N	2021-11-08 10:18:59.646+00	2021-11-08 10:18:59.934+00
1568	\N	died	2021-11-08 10:18:35.359+00	\N	\N	2021-11-08 10:18:59.867+00	2021-11-08 10:19:00.156+00
1724	\N	died	2021-11-08 10:18:35.983+00	\N	\N	2021-11-08 10:19:03.201+00	2021-11-08 10:19:03.463+00
1579	\N	died	2021-11-08 10:18:35.394+00	\N	\N	2021-11-08 10:19:00.1+00	2021-11-08 10:19:00.217+00
1586	\N	died	2021-11-08 10:18:35.408+00	\N	\N	2021-11-08 10:19:00.213+00	2021-11-08 10:19:00.378+00
1907	\N	died	2021-11-08 10:18:36.678+00	\N	\N	2021-11-08 10:19:07.401+00	2021-11-08 10:19:07.648+00
1592	\N	died	2021-11-08 10:18:35.424+00	\N	\N	2021-11-08 10:19:00.346+00	2021-11-08 10:19:00.734+00
1608	\N	died	2021-11-08 10:18:35.467+00	\N	\N	2021-11-08 10:19:00.63+00	2021-11-08 10:19:01.02+00
1625	\N	died	2021-11-08 10:18:35.519+00	\N	\N	2021-11-08 10:19:01.016+00	2021-11-08 10:19:01.273+00
1918	\N	died	2021-11-08 10:18:36.741+00	\N	\N	2021-11-08 10:19:07.644+00	2021-11-08 10:19:07.77+00
1734	\N	died	2021-11-08 10:18:36.008+00	\N	\N	2021-11-08 10:19:03.405+00	2021-11-08 10:19:03.827+00
3368	\N	died	2021-11-08 10:18:41.955+00	\N	\N	2021-11-08 10:19:39.158+00	2021-11-08 10:19:39.326+00
1752	\N	died	2021-11-08 10:18:36.057+00	\N	\N	2021-11-08 10:19:03.78+00	2021-11-08 10:19:04.188+00
1766	\N	died	2021-11-08 10:18:36.101+00	\N	\N	2021-11-08 10:19:04.087+00	2021-11-08 10:19:04.305+00
1922	\N	died	2021-11-08 10:18:36.754+00	\N	\N	2021-11-08 10:19:07.766+00	2021-11-08 10:19:07.836+00
1777	\N	died	2021-11-08 10:18:36.127+00	\N	\N	2021-11-08 10:19:04.302+00	2021-11-08 10:19:04.477+00
3485	\N	died	2021-11-08 10:18:42.27+00	\N	\N	2021-11-08 10:19:42.275+00	2021-11-08 10:19:42.985+00
1783	\N	died	2021-11-08 10:18:36.137+00	\N	\N	2021-11-08 10:19:04.44+00	2021-11-08 10:19:04.737+00
1793	\N	died	2021-11-08 10:18:36.164+00	\N	\N	2021-11-08 10:19:04.647+00	2021-11-08 10:19:05.111+00
1926	\N	died	2021-11-08 10:18:36.766+00	\N	\N	2021-11-08 10:19:07.832+00	2021-11-08 10:19:07.911+00
1805	\N	died	2021-11-08 10:18:36.203+00	\N	\N	2021-11-08 10:19:04.959+00	2021-11-08 10:19:05.31+00
1820	\N	died	2021-11-08 10:18:36.235+00	\N	\N	2021-11-08 10:19:05.307+00	2021-11-08 10:19:05.439+00
3374	\N	died	2021-11-08 10:18:41.972+00	\N	\N	2021-11-08 10:19:39.307+00	2021-11-08 10:19:39.709+00
1827	\N	died	2021-11-08 10:18:36.256+00	\N	\N	2021-11-08 10:19:05.435+00	2021-11-08 10:19:05.634+00
1836	\N	died	2021-11-08 10:18:36.277+00	\N	\N	2021-11-08 10:19:05.617+00	2021-11-08 10:19:06.01+00
1851	\N	died	2021-11-08 10:18:36.315+00	\N	\N	2021-11-08 10:19:05.956+00	2021-11-08 10:19:06.564+00
1930	\N	died	2021-11-08 10:18:36.779+00	\N	\N	2021-11-08 10:19:07.907+00	2021-11-08 10:19:08.131+00
3382	\N	died	2021-11-08 10:18:41.987+00	\N	\N	2021-11-08 10:19:39.659+00	2021-11-08 10:19:40.075+00
1940	\N	died	2021-11-08 10:18:36.827+00	\N	\N	2021-11-08 10:19:08.126+00	2021-11-08 10:19:08.269+00
3453	\N	died	2021-11-08 10:18:42.141+00	\N	\N	2021-11-08 10:19:41.596+00	2021-11-08 10:19:41.832+00
1945	\N	died	2021-11-08 10:18:36.905+00	\N	\N	2021-11-08 10:19:08.305+00	2021-11-08 10:19:08.578+00
1958	\N	died	2021-11-08 10:18:36.98+00	\N	\N	2021-11-08 10:19:08.56+00	2021-11-08 10:19:09.023+00
3396	\N	died	2021-11-08 10:18:42.016+00	\N	\N	2021-11-08 10:19:40.021+00	2021-11-08 10:19:40.312+00
1977	\N	died	2021-11-08 10:18:37.064+00	\N	\N	2021-11-08 10:19:08.985+00	2021-11-08 10:19:09.32+00
1994	\N	died	2021-11-08 10:18:37.136+00	\N	\N	2021-11-08 10:19:09.315+00	2021-11-08 10:19:09.543+00
2004	\N	died	2021-11-08 10:18:37.187+00	\N	\N	2021-11-08 10:19:09.539+00	2021-11-08 10:19:09.576+00
3408	\N	died	2021-11-08 10:18:42.052+00	\N	\N	2021-11-08 10:19:40.308+00	2021-11-08 10:19:40.891+00
2006	\N	died	2021-11-08 10:18:37.193+00	\N	\N	2021-11-08 10:19:09.572+00	2021-11-08 10:19:09.69+00
2009	\N	died	2021-11-08 10:18:37.21+00	\N	\N	2021-11-08 10:19:09.686+00	2021-11-08 10:19:10.157+00
3413	\N	died	2021-11-08 10:18:42.06+00	\N	\N	2021-11-08 10:19:40.853+00	2021-11-08 10:19:41.082+00
2013	\N	died	2021-11-08 10:18:37.238+00	\N	\N	2021-11-08 10:19:10.154+00	2021-11-08 10:19:10.255+00
3505	\N	died	2021-11-08 10:18:42.757+00	\N	\N	2021-11-08 10:19:42.762+00	2021-11-08 10:19:43.045+00
3424	\N	died	2021-11-08 10:18:42.083+00	\N	\N	2021-11-08 10:19:41.032+00	2021-11-08 10:19:41.194+00
3557	\N	died	2021-11-08 10:18:43.944+00	\N	\N	2021-11-08 10:19:43.953+00	2021-11-08 10:19:44.354+00
3434	\N	died	2021-11-08 10:18:42.106+00	\N	\N	2021-11-08 10:19:41.186+00	2021-11-08 10:19:41.416+00
3465	\N	died	2021-11-08 10:18:42.158+00	\N	\N	2021-11-08 10:19:41.828+00	2021-11-08 10:19:42.032+00
3530	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.287+00	2021-11-08 10:19:43.765+00
3475	\N	died	2021-11-08 10:18:42.183+00	\N	\N	2021-11-08 10:19:42.028+00	2021-11-08 10:19:42.352+00
3690	\N	died	2021-11-08 10:18:47.065+00	\N	\N	2021-11-08 10:19:47.065+00	2021-11-08 10:19:47.318+00
3516	\N	died	2021-11-08 10:18:43.046+00	\N	\N	2021-11-08 10:19:43.04+00	2021-11-08 10:19:43.151+00
3520	\N	died	2021-11-08 10:18:43.169+00	\N	\N	2021-11-08 10:19:43.113+00	2021-11-08 10:19:43.39+00
3572	\N	died	2021-11-08 10:18:44.342+00	\N	\N	2021-11-08 10:19:44.347+00	2021-11-08 10:19:44.64+00
3550	\N	died	2021-11-08 10:18:43.752+00	\N	\N	2021-11-08 10:19:43.754+00	2021-11-08 10:19:43.996+00
3582	\N	died	2021-11-08 10:18:44.606+00	\N	\N	2021-11-08 10:19:44.608+00	2021-11-08 10:19:44.781+00
3618	\N	died	2021-11-08 10:18:45.638+00	\N	\N	2021-11-08 10:19:45.474+00	2021-11-08 10:19:45.641+00
3586	\N	died	2021-11-08 10:18:44.781+00	\N	\N	2021-11-08 10:19:44.773+00	2021-11-08 10:19:44.857+00
3588	\N	died	2021-11-08 10:18:44.88+00	\N	\N	2021-11-08 10:19:44.843+00	2021-11-08 10:19:44.961+00
3594	\N	died	2021-11-08 10:18:45.023+00	\N	\N	2021-11-08 10:19:44.926+00	2021-11-08 10:19:45.478+00
3651	\N	died	2021-11-08 10:18:46.203+00	\N	\N	2021-11-08 10:19:46.204+00	2021-11-08 10:19:46.532+00
3627	\N	died	2021-11-08 10:18:45.68+00	\N	\N	2021-11-08 10:19:45.622+00	2021-11-08 10:19:45.944+00
3635	\N	died	2021-11-08 10:18:45.805+00	\N	\N	2021-11-08 10:19:45.811+00	2021-11-08 10:19:46.042+00
3644	\N	died	2021-11-08 10:18:46.147+00	\N	\N	2021-11-08 10:19:46.037+00	2021-11-08 10:19:46.228+00
3665	\N	died	2021-11-08 10:18:46.538+00	\N	\N	2021-11-08 10:19:46.498+00	2021-11-08 10:19:46.986+00
3685	\N	died	2021-11-08 10:18:47.012+00	\N	\N	2021-11-08 10:19:46.982+00	2021-11-08 10:19:47.076+00
5508	\N	died	2021-11-08 10:19:48.113+00	\N	\N	2021-11-08 10:20:36.099+00	2021-11-08 10:20:36.31+00
1320	\N	died	2021-11-08 10:18:34.312+00	\N	\N	2021-11-08 10:18:55.225+00	2021-11-08 10:18:55.293+00
1324	\N	died	2021-11-08 10:18:34.323+00	\N	\N	2021-11-08 10:18:55.289+00	2021-11-08 10:18:55.408+00
1329	\N	died	2021-11-08 10:18:34.349+00	\N	\N	2021-11-08 10:18:55.376+00	2021-11-08 10:18:55.562+00
1339	\N	died	2021-11-08 10:18:34.378+00	\N	\N	2021-11-08 10:18:55.537+00	2021-11-08 10:18:55.747+00
1694	\N	died	2021-11-08 10:18:35.857+00	\N	\N	2021-11-08 10:19:02.614+00	2021-11-08 10:19:02.862+00
1346	\N	died	2021-11-08 10:18:34.401+00	\N	\N	2021-11-08 10:18:55.708+00	2021-11-08 10:18:55.95+00
1956	\N	died	2021-11-08 10:18:36.963+00	\N	\N	2021-11-08 10:19:08.527+00	2021-11-08 10:19:08.774+00
1360	\N	died	2021-11-08 10:18:34.452+00	\N	\N	2021-11-08 10:18:55.935+00	2021-11-08 10:18:56.309+00
1381	\N	died	2021-11-08 10:18:34.544+00	\N	\N	2021-11-08 10:18:56.277+00	2021-11-08 10:18:56.425+00
1706	\N	died	2021-11-08 10:18:35.912+00	\N	\N	2021-11-08 10:19:02.859+00	2021-11-08 10:19:02.962+00
1389	\N	died	2021-11-08 10:18:34.582+00	\N	\N	2021-11-08 10:18:56.411+00	2021-11-08 10:18:56.624+00
1400	\N	died	2021-11-08 10:18:34.62+00	\N	\N	2021-11-08 10:18:56.587+00	2021-11-08 10:18:56.948+00
1415	\N	died	2021-11-08 10:18:34.681+00	\N	\N	2021-11-08 10:18:56.842+00	2021-11-08 10:18:57.097+00
1710	\N	died	2021-11-08 10:18:35.936+00	\N	\N	2021-11-08 10:19:02.926+00	2021-11-08 10:19:03.239+00
1429	\N	died	2021-11-08 10:18:34.741+00	\N	\N	2021-11-08 10:18:57.071+00	2021-11-08 10:18:57.3+00
1443	\N	died	2021-11-08 10:18:34.804+00	\N	\N	2021-11-08 10:18:57.297+00	2021-11-08 10:18:57.406+00
1446	\N	died	2021-11-08 10:18:34.817+00	\N	\N	2021-11-08 10:18:57.403+00	2021-11-08 10:18:57.535+00
1725	\N	died	2021-11-08 10:18:35.984+00	\N	\N	2021-11-08 10:19:03.213+00	2021-11-08 10:19:03.463+00
1452	\N	died	2021-11-08 10:18:34.848+00	\N	\N	2021-11-08 10:18:57.492+00	2021-11-08 10:18:57.722+00
1965	\N	died	2021-11-08 10:18:36.996+00	\N	\N	2021-11-08 10:19:08.732+00	2021-11-08 10:19:09.036+00
1465	\N	died	2021-11-08 10:18:34.892+00	\N	\N	2021-11-08 10:18:57.718+00	2021-11-08 10:18:57.82+00
1471	\N	died	2021-11-08 10:18:34.922+00	\N	\N	2021-11-08 10:18:57.816+00	2021-11-08 10:18:57.855+00
1736	\N	died	2021-11-08 10:18:36.015+00	\N	\N	2021-11-08 10:19:03.439+00	2021-11-08 10:19:03.855+00
1473	\N	died	2021-11-08 10:18:34.928+00	\N	\N	2021-11-08 10:18:57.85+00	2021-11-08 10:18:57.956+00
3411	\N	died	2021-11-08 10:18:42.052+00	\N	\N	2021-11-08 10:19:40.53+00	2021-11-08 10:19:40.891+00
1477	\N	died	2021-11-08 10:18:34.944+00	\N	\N	2021-11-08 10:18:57.923+00	2021-11-08 10:18:58.19+00
1488	\N	died	2021-11-08 10:18:35+00	\N	\N	2021-11-08 10:18:58.144+00	2021-11-08 10:18:58.533+00
1756	\N	died	2021-11-08 10:18:36.07+00	\N	\N	2021-11-08 10:19:03.851+00	2021-11-08 10:19:04.037+00
1506	\N	died	2021-11-08 10:18:35.104+00	\N	\N	2021-11-08 10:18:58.499+00	2021-11-08 10:18:58.958+00
1525	\N	died	2021-11-08 10:18:35.165+00	\N	\N	2021-11-08 10:18:58.934+00	2021-11-08 10:18:59.251+00
1540	\N	died	2021-11-08 10:18:35.244+00	\N	\N	2021-11-08 10:18:59.236+00	2021-11-08 10:18:59.515+00
1761	\N	died	2021-11-08 10:18:36.084+00	\N	\N	2021-11-08 10:19:03.998+00	2021-11-08 10:19:04.272+00
1551	\N	died	2021-11-08 10:18:35.283+00	\N	\N	2021-11-08 10:18:59.492+00	2021-11-08 10:18:59.685+00
1980	\N	died	2021-11-08 10:18:37.075+00	\N	\N	2021-11-08 10:19:09.031+00	2021-11-08 10:19:09.089+00
1558	\N	died	2021-11-08 10:18:35.318+00	\N	\N	2021-11-08 10:18:59.667+00	2021-11-08 10:18:59.934+00
1570	\N	died	2021-11-08 10:18:35.36+00	\N	\N	2021-11-08 10:18:59.899+00	2021-11-08 10:19:00.205+00
1775	\N	died	2021-11-08 10:18:36.12+00	\N	\N	2021-11-08 10:19:04.268+00	2021-11-08 10:19:04.42+00
1583	\N	died	2021-11-08 10:18:35.4+00	\N	\N	2021-11-08 10:19:00.163+00	2021-11-08 10:19:00.378+00
1589	\N	died	2021-11-08 10:18:35.416+00	\N	\N	2021-11-08 10:19:00.314+00	2021-11-08 10:19:00.56+00
1602	\N	died	2021-11-08 10:18:35.446+00	\N	\N	2021-11-08 10:19:00.539+00	2021-11-08 10:19:00.783+00
1778	\N	died	2021-11-08 10:18:36.127+00	\N	\N	2021-11-08 10:19:04.313+00	2021-11-08 10:19:04.539+00
1614	\N	died	2021-11-08 10:18:35.481+00	\N	\N	2021-11-08 10:19:00.779+00	2021-11-08 10:19:00.856+00
1618	\N	died	2021-11-08 10:18:35.497+00	\N	\N	2021-11-08 10:19:00.852+00	2021-11-08 10:19:01.039+00
1626	\N	died	2021-11-08 10:18:35.526+00	\N	\N	2021-11-08 10:19:01.035+00	2021-11-08 10:19:01.273+00
1787	\N	died	2021-11-08 10:18:36.151+00	\N	\N	2021-11-08 10:19:04.506+00	2021-11-08 10:19:04.859+00
1636	\N	died	2021-11-08 10:18:35.559+00	\N	\N	2021-11-08 10:19:01.247+00	2021-11-08 10:19:01.49+00
1983	\N	died	2021-11-08 10:18:37.085+00	\N	\N	2021-11-08 10:19:09.085+00	2021-11-08 10:19:09.206+00
1646	\N	died	2021-11-08 10:18:35.594+00	\N	\N	2021-11-08 10:19:01.465+00	2021-11-08 10:19:01.76+00
1661	\N	died	2021-11-08 10:18:35.676+00	\N	\N	2021-11-08 10:19:01.774+00	2021-11-08 10:19:02.021+00
1671	\N	died	2021-11-08 10:18:35.747+00	\N	\N	2021-11-08 10:19:02.017+00	2021-11-08 10:19:02.3+00
1681	\N	died	2021-11-08 10:18:35.8+00	\N	\N	2021-11-08 10:19:02.294+00	2021-11-08 10:19:02.43+00
1987	\N	died	2021-11-08 10:18:37.101+00	\N	\N	2021-11-08 10:19:09.202+00	2021-11-08 10:19:09.543+00
1684	\N	died	2021-11-08 10:18:35.812+00	\N	\N	2021-11-08 10:19:02.394+00	2021-11-08 10:19:02.643+00
1799	\N	died	2021-11-08 10:18:36.184+00	\N	\N	2021-11-08 10:19:04.855+00	2021-11-08 10:19:05.111+00
3415	\N	died	2021-11-08 10:18:42.06+00	\N	\N	2021-11-08 10:19:40.887+00	2021-11-08 10:19:40.982+00
1809	\N	died	2021-11-08 10:18:36.209+00	\N	\N	2021-11-08 10:19:05.073+00	2021-11-08 10:19:05.51+00
1828	\N	died	2021-11-08 10:18:36.256+00	\N	\N	2021-11-08 10:19:05.447+00	2021-11-08 10:19:05.803+00
1997	\N	died	2021-11-08 10:18:37.16+00	\N	\N	2021-11-08 10:19:09.368+00	2021-11-08 10:19:09.706+00
1841	\N	died	2021-11-08 10:18:36.287+00	\N	\N	2021-11-08 10:19:05.751+00	2021-11-08 10:19:06.01+00
1850	\N	died	2021-11-08 10:18:36.315+00	\N	\N	2021-11-08 10:19:05.895+00	2021-11-08 10:19:06.226+00
1864	\N	died	2021-11-08 10:18:36.357+00	\N	\N	2021-11-08 10:19:06.222+00	2021-11-08 10:19:06.809+00
2010	\N	died	2021-11-08 10:18:37.214+00	\N	\N	2021-11-08 10:19:09.703+00	2021-11-08 10:19:10.255+00
1873	\N	died	2021-11-08 10:18:36.395+00	\N	\N	2021-11-08 10:19:06.643+00	2021-11-08 10:19:07.173+00
1898	\N	died	2021-11-08 10:18:36.621+00	\N	\N	2021-11-08 10:19:07.241+00	2021-11-08 10:19:07.63+00
3421	\N	died	2021-11-08 10:18:42.076+00	\N	\N	2021-11-08 10:19:40.978+00	2021-11-08 10:19:41.082+00
1916	\N	died	2021-11-08 10:18:36.728+00	\N	\N	2021-11-08 10:19:07.609+00	2021-11-08 10:19:08.112+00
3483	\N	died	2021-11-08 10:18:42.231+00	\N	\N	2021-11-08 10:19:42.234+00	2021-11-08 10:19:42.538+00
1933	\N	died	2021-11-08 10:18:36.792+00	\N	\N	2021-11-08 10:19:08.014+00	2021-11-08 10:19:08.347+00
1947	\N	died	2021-11-08 10:18:36.916+00	\N	\N	2021-11-08 10:19:08.328+00	2021-11-08 10:19:08.578+00
3427	\N	died	2021-11-08 10:18:42.083+00	\N	\N	2021-11-08 10:19:41.078+00	2021-11-08 10:19:41.116+00
2017	\N	died	2021-11-08 10:18:37.249+00	\N	\N	2021-11-08 10:19:10.219+00	2021-11-08 10:19:10.61+00
3579	\N	died	2021-11-08 10:18:44.539+00	\N	\N	2021-11-08 10:19:44.542+00	2021-11-08 10:19:45.144+00
2036	\N	died	2021-11-08 10:18:37.296+00	\N	\N	2021-11-08 10:19:10.606+00	2021-11-08 10:19:10.814+00
2045	\N	died	2021-11-08 10:18:37.322+00	\N	\N	2021-11-08 10:19:10.808+00	2021-11-08 10:19:10.864+00
3429	\N	died	2021-11-08 10:18:42.098+00	\N	\N	2021-11-08 10:19:41.112+00	2021-11-08 10:19:41.142+00
2048	\N	died	2021-11-08 10:18:37.329+00	\N	\N	2021-11-08 10:19:10.858+00	2021-11-08 10:19:10.894+00
2050	\N	died	2021-11-08 10:18:37.335+00	\N	\N	2021-11-08 10:19:10.89+00	2021-11-08 10:19:11.028+00
2055	\N	died	2021-11-08 10:18:37.358+00	\N	\N	2021-11-08 10:19:11.024+00	2021-11-08 10:19:11.098+00
3431	\N	died	2021-11-08 10:18:42.098+00	\N	\N	2021-11-08 10:19:41.138+00	2021-11-08 10:19:41.257+00
2059	\N	died	2021-11-08 10:18:37.372+00	\N	\N	2021-11-08 10:19:11.092+00	2021-11-08 10:19:11.166+00
3497	\N	died	2021-11-08 10:18:42.53+00	\N	\N	2021-11-08 10:19:42.534+00	2021-11-08 10:19:42.741+00
2063	\N	died	2021-11-08 10:18:37.391+00	\N	\N	2021-11-08 10:19:11.163+00	2021-11-08 10:19:11.271+00
2066	\N	died	2021-11-08 10:18:37.4+00	\N	\N	2021-11-08 10:19:11.267+00	2021-11-08 10:19:11.371+00
3435	\N	died	2021-11-08 10:18:42.106+00	\N	\N	2021-11-08 10:19:41.253+00	2021-11-08 10:19:41.416+00
2072	\N	died	2021-11-08 10:18:37.416+00	\N	\N	2021-11-08 10:19:11.367+00	2021-11-08 10:19:11.457+00
3443	\N	died	2021-11-08 10:18:42.124+00	\N	\N	2021-11-08 10:19:41.378+00	2021-11-08 10:19:41.817+00
3569	\N	died	2021-11-08 10:18:44.291+00	\N	\N	2021-11-08 10:19:44.295+00	2021-11-08 10:19:44.6+00
3464	\N	died	2021-11-08 10:18:42.158+00	\N	\N	2021-11-08 10:19:41.813+00	2021-11-08 10:19:41.999+00
3473	\N	died	2021-11-08 10:18:42.183+00	\N	\N	2021-11-08 10:19:41.995+00	2021-11-08 10:19:42.352+00
3504	\N	died	2021-11-08 10:18:42.719+00	\N	\N	2021-11-08 10:19:42.726+00	2021-11-08 10:19:43.024+00
3546	\N	died	2021-11-08 10:18:43.652+00	\N	\N	2021-11-08 10:19:43.659+00	2021-11-08 10:19:44.117+00
3514	\N	died	2021-11-08 10:18:43.002+00	\N	\N	2021-11-08 10:19:43.001+00	2021-11-08 10:19:43.089+00
3675	\N	died	2021-11-08 10:18:46.723+00	\N	\N	2021-11-08 10:19:46.724+00	2021-11-08 10:19:46.97+00
3518	\N	died	2021-11-08 10:18:43.169+00	\N	\N	2021-11-08 10:19:43.084+00	2021-11-08 10:19:43.23+00
3524	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.199+00	2021-11-08 10:19:43.452+00
3536	\N	died	2021-11-08 10:18:43.507+00	\N	\N	2021-11-08 10:19:43.428+00	2021-11-08 10:19:43.741+00
3559	\N	died	2021-11-08 10:18:44.011+00	\N	\N	2021-11-08 10:19:44.01+00	2021-11-08 10:19:44.301+00
3683	\N	died	2021-11-08 10:18:47.006+00	\N	\N	2021-11-08 10:19:46.95+00	2021-11-08 10:19:47.318+00
3601	\N	died	2021-11-08 10:18:45.184+00	\N	\N	2021-11-08 10:19:45.09+00	2021-11-08 10:19:45.294+00
3643	\N	died	2021-11-08 10:18:46.025+00	\N	\N	2021-11-08 10:19:46.023+00	2021-11-08 10:19:46.228+00
3610	\N	died	2021-11-08 10:18:45.428+00	\N	\N	2021-11-08 10:19:45.291+00	2021-11-08 10:19:45.36+00
3614	\N	died	2021-11-08 10:18:45.579+00	\N	\N	2021-11-08 10:19:45.356+00	2021-11-08 10:19:45.593+00
3650	\N	died	2021-11-08 10:18:46.195+00	\N	\N	2021-11-08 10:19:46.187+00	2021-11-08 10:19:46.532+00
3624	\N	died	2021-11-08 10:18:45.669+00	\N	\N	2021-11-08 10:19:45.573+00	2021-11-08 10:19:46.029+00
5509	\N	died	2021-11-08 10:19:48.132+00	\N	\N	2021-11-08 10:20:36.166+00	2021-11-08 10:20:36.31+00
3661	\N	died	2021-11-08 10:18:46.429+00	\N	\N	2021-11-08 10:19:46.429+00	2021-11-08 10:19:46.729+00
3720	\N	died	2021-11-08 10:18:47.729+00	\N	\N	2021-11-08 10:19:47.729+00	2021-11-08 10:19:47.985+00
3700	\N	died	2021-11-08 10:18:47.353+00	\N	\N	2021-11-08 10:19:47.299+00	2021-11-08 10:19:47.735+00
5514	\N	died	2021-11-08 10:19:48.201+00	\N	\N	2021-11-08 10:20:36.295+00	2021-11-08 10:20:36.396+00
3730	\N	died	2021-11-08 10:18:48.029+00	\N	\N	2021-11-08 10:19:47.948+00	2021-11-08 10:19:48.336+00
1444	\N	died	2021-11-08 10:18:34.81+00	\N	\N	2021-11-08 10:18:57.317+00	2021-11-08 10:18:57.471+00
1448	\N	died	2021-11-08 10:18:34.834+00	\N	\N	2021-11-08 10:18:57.436+00	2021-11-08 10:18:57.705+00
1857	\N	died	2021-11-08 10:18:36.333+00	\N	\N	2021-11-08 10:19:06.062+00	2021-11-08 10:19:06.291+00
1463	\N	died	2021-11-08 10:18:34.879+00	\N	\N	2021-11-08 10:18:57.68+00	2021-11-08 10:18:58.19+00
1487	\N	died	2021-11-08 10:18:34.99+00	\N	\N	2021-11-08 10:18:58.128+00	2021-11-08 10:18:58.533+00
1504	\N	died	2021-11-08 10:18:35.098+00	\N	\N	2021-11-08 10:18:58.469+00	2021-11-08 10:18:58.813+00
1866	\N	died	2021-11-08 10:18:36.363+00	\N	\N	2021-11-08 10:19:06.287+00	2021-11-08 10:19:06.809+00
1519	\N	died	2021-11-08 10:18:35.151+00	\N	\N	2021-11-08 10:18:58.76+00	2021-11-08 10:18:59.023+00
1529	\N	died	2021-11-08 10:18:35.181+00	\N	\N	2021-11-08 10:18:58.996+00	2021-11-08 10:18:59.464+00
1543	\N	died	2021-11-08 10:18:35.251+00	\N	\N	2021-11-08 10:18:59.279+00	2021-11-08 10:18:59.685+00
1876	\N	died	2021-11-08 10:18:36.401+00	\N	\N	2021-11-08 10:19:06.689+00	2021-11-08 10:19:07.064+00
1556	\N	died	2021-11-08 10:18:35.311+00	\N	\N	2021-11-08 10:18:59.629+00	2021-11-08 10:18:59.841+00
3494	\N	died	2021-11-08 10:18:42.467+00	\N	\N	2021-11-08 10:19:42.463+00	2021-11-08 10:19:42.56+00
1566	\N	died	2021-11-08 10:18:35.353+00	\N	\N	2021-11-08 10:18:59.834+00	2021-11-08 10:19:00.077+00
1574	\N	died	2021-11-08 10:18:35.373+00	\N	\N	2021-11-08 10:18:59.968+00	2021-11-08 10:19:00.308+00
1892	\N	died	2021-11-08 10:18:36.453+00	\N	\N	2021-11-08 10:19:07.06+00	2021-11-08 10:19:07.328+00
1588	\N	died	2021-11-08 10:18:35.416+00	\N	\N	2021-11-08 10:19:00.301+00	2021-11-08 10:19:00.401+00
3666	\N	died	2021-11-08 10:18:46.542+00	\N	\N	2021-11-08 10:19:46.514+00	2021-11-08 10:19:47.019+00
1596	\N	died	2021-11-08 10:18:35.431+00	\N	\N	2021-11-08 10:19:00.396+00	2021-11-08 10:19:00.56+00
1601	\N	died	2021-11-08 10:18:35.446+00	\N	\N	2021-11-08 10:19:00.528+00	2021-11-08 10:19:00.752+00
1899	\N	died	2021-11-08 10:18:36.633+00	\N	\N	2021-11-08 10:19:07.279+00	2021-11-08 10:19:07.63+00
1612	\N	died	2021-11-08 10:18:35.475+00	\N	\N	2021-11-08 10:19:00.747+00	2021-11-08 10:19:00.802+00
1615	\N	died	2021-11-08 10:18:35.481+00	\N	\N	2021-11-08 10:19:00.798+00	2021-11-08 10:19:00.886+00
1620	\N	died	2021-11-08 10:18:35.497+00	\N	\N	2021-11-08 10:19:00.882+00	2021-11-08 10:19:01.204+00
1911	\N	died	2021-11-08 10:18:36.697+00	\N	\N	2021-11-08 10:19:07.521+00	2021-11-08 10:19:07.77+00
1630	\N	died	2021-11-08 10:18:35.545+00	\N	\N	2021-11-08 10:19:01.105+00	2021-11-08 10:19:01.501+00
3498	\N	died	2021-11-08 10:18:42.546+00	\N	\N	2021-11-08 10:19:42.551+00	2021-11-08 10:19:42.985+00
1648	\N	died	2021-11-08 10:18:35.601+00	\N	\N	2021-11-08 10:19:01.496+00	2021-11-08 10:19:01.676+00
1653	\N	died	2021-11-08 10:18:35.619+00	\N	\N	2021-11-08 10:19:01.585+00	2021-11-08 10:19:01.842+00
1920	\N	died	2021-11-08 10:18:36.748+00	\N	\N	2021-11-08 10:19:07.677+00	2021-11-08 10:19:08.112+00
1664	\N	died	2021-11-08 10:18:35.71+00	\N	\N	2021-11-08 10:19:01.839+00	2021-11-08 10:19:02.276+00
1674	\N	died	2021-11-08 10:18:35.764+00	\N	\N	2021-11-08 10:19:02.175+00	2021-11-08 10:19:02.446+00
1687	\N	died	2021-11-08 10:18:35.826+00	\N	\N	2021-11-08 10:19:02.443+00	2021-11-08 10:19:02.533+00
1934	\N	died	2021-11-08 10:18:36.806+00	\N	\N	2021-11-08 10:19:08.026+00	2021-11-08 10:19:08.498+00
1692	\N	died	2021-11-08 10:18:35.844+00	\N	\N	2021-11-08 10:19:02.524+00	2021-11-08 10:19:02.759+00
1702	\N	died	2021-11-08 10:18:35.899+00	\N	\N	2021-11-08 10:19:02.742+00	2021-11-08 10:19:03.173+00
1721	\N	died	2021-11-08 10:18:35.972+00	\N	\N	2021-11-08 10:19:03.155+00	2021-11-08 10:19:03.568+00
1949	\N	died	2021-11-08 10:18:36.926+00	\N	\N	2021-11-08 10:19:08.36+00	2021-11-08 10:19:08.631+00
1741	\N	died	2021-11-08 10:18:36.033+00	\N	\N	2021-11-08 10:19:03.564+00	2021-11-08 10:19:03.738+00
3506	\N	died	2021-11-08 10:18:42.775+00	\N	\N	2021-11-08 10:19:42.781+00	2021-11-08 10:19:43.151+00
1746	\N	died	2021-11-08 10:18:36.045+00	\N	\N	2021-11-08 10:19:03.63+00	2021-11-08 10:19:03.956+00
1757	\N	died	2021-11-08 10:18:36.07+00	\N	\N	2021-11-08 10:19:03.863+00	2021-11-08 10:19:04.188+00
1961	\N	died	2021-11-08 10:18:36.985+00	\N	\N	2021-11-08 10:19:08.606+00	2021-11-08 10:19:09.023+00
1768	\N	died	2021-11-08 10:18:36.101+00	\N	\N	2021-11-08 10:19:04.113+00	2021-11-08 10:19:04.551+00
1790	\N	died	2021-11-08 10:18:36.157+00	\N	\N	2021-11-08 10:19:04.547+00	2021-11-08 10:19:04.818+00
1796	\N	died	2021-11-08 10:18:36.177+00	\N	\N	2021-11-08 10:19:04.813+00	2021-11-08 10:19:05.111+00
1975	\N	died	2021-11-08 10:18:37.041+00	\N	\N	2021-11-08 10:19:08.904+00	2021-11-08 10:19:09.257+00
1806	\N	died	2021-11-08 10:18:36.203+00	\N	\N	2021-11-08 10:19:04.972+00	2021-11-08 10:19:05.359+00
1822	\N	died	2021-11-08 10:18:36.245+00	\N	\N	2021-11-08 10:19:05.344+00	2021-11-08 10:19:05.634+00
3521	\N	died	2021-11-08 10:18:43.169+00	\N	\N	2021-11-08 10:19:43.129+00	2021-11-08 10:19:43.39+00
1832	\N	died	2021-11-08 10:18:36.267+00	\N	\N	2021-11-08 10:19:05.552+00	2021-11-08 10:19:05.803+00
3687	\N	died	2021-11-08 10:18:47.023+00	\N	\N	2021-11-08 10:19:47.016+00	2021-11-08 10:19:47.166+00
1843	\N	died	2021-11-08 10:18:36.292+00	\N	\N	2021-11-08 10:19:05.785+00	2021-11-08 10:19:06.079+00
3532	\N	died	2021-11-08 10:18:43.366+00	\N	\N	2021-11-08 10:19:43.312+00	2021-11-08 10:19:43.843+00
1990	\N	died	2021-11-08 10:18:37.117+00	\N	\N	2021-11-08 10:19:09.252+00	2021-11-08 10:19:09.543+00
5518	\N	died	2021-11-08 10:19:48.331+00	\N	\N	2021-11-08 10:20:36.39+00	2021-11-08 10:20:36.595+00
2000	\N	died	2021-11-08 10:18:37.176+00	\N	\N	2021-11-08 10:19:09.476+00	2021-11-08 10:19:10.255+00
2016	\N	died	2021-11-08 10:18:37.243+00	\N	\N	2021-11-08 10:19:10.203+00	2021-11-08 10:19:10.456+00
3554	\N	died	2021-11-08 10:18:43.834+00	\N	\N	2021-11-08 10:19:43.838+00	2021-11-08 10:19:44.117+00
2028	\N	died	2021-11-08 10:18:37.277+00	\N	\N	2021-11-08 10:19:10.432+00	2021-11-08 10:19:10.814+00
2044	\N	died	2021-11-08 10:18:37.322+00	\N	\N	2021-11-08 10:19:10.791+00	2021-11-08 10:19:11.177+00
2064	\N	died	2021-11-08 10:18:37.391+00	\N	\N	2021-11-08 10:19:11.173+00	2021-11-08 10:19:11.371+00
3562	\N	died	2021-11-08 10:18:44.071+00	\N	\N	2021-11-08 10:19:44.076+00	2021-11-08 10:19:44.6+00
2068	\N	died	2021-11-08 10:18:37.408+00	\N	\N	2021-11-08 10:19:11.303+00	2021-11-08 10:19:11.603+00
3692	\N	died	2021-11-08 10:18:47.165+00	\N	\N	2021-11-08 10:19:47.162+00	2021-11-08 10:19:47.318+00
2079	\N	died	2021-11-08 10:18:37.494+00	\N	\N	2021-11-08 10:19:11.573+00	2021-11-08 10:19:11.92+00
2097	\N	died	2021-11-08 10:18:37.585+00	\N	\N	2021-11-08 10:19:11.915+00	2021-11-08 10:19:12.09+00
3578	\N	died	2021-11-08 10:18:44.521+00	\N	\N	2021-11-08 10:19:44.524+00	2021-11-08 10:19:44.961+00
2104	\N	died	2021-11-08 10:18:37.619+00	\N	\N	2021-11-08 10:19:12.087+00	2021-11-08 10:19:12.136+00
5546	\N	died	2021-11-08 10:19:48.924+00	\N	\N	2021-11-08 10:20:37.431+00	2021-11-08 10:20:37.856+00
2107	\N	died	2021-11-08 10:18:37.626+00	\N	\N	2021-11-08 10:19:12.132+00	2021-11-08 10:19:12.293+00
2113	\N	died	2021-11-08 10:18:37.658+00	\N	\N	2021-11-08 10:19:12.289+00	2021-11-08 10:19:12.368+00
3595	\N	died	2021-11-08 10:18:45.041+00	\N	\N	2021-11-08 10:19:44.943+00	2021-11-08 10:19:45.329+00
2117	\N	died	2021-11-08 10:18:37.682+00	\N	\N	2021-11-08 10:19:12.364+00	2021-11-08 10:19:12.54+00
2125	\N	died	2021-11-08 10:18:37.706+00	\N	\N	2021-11-08 10:19:12.537+00	2021-11-08 10:19:12.571+00
3612	\N	died	2021-11-08 10:18:45.497+00	\N	\N	2021-11-08 10:19:45.325+00	2021-11-08 10:19:45.593+00
3699	\N	died	2021-11-08 10:18:47.349+00	\N	\N	2021-11-08 10:19:47.287+00	2021-11-08 10:19:47.708+00
3619	\N	died	2021-11-08 10:18:45.65+00	\N	\N	2021-11-08 10:19:45.492+00	2021-11-08 10:19:45.799+00
3633	\N	died	2021-11-08 10:18:45.773+00	\N	\N	2021-11-08 10:19:45.775+00	2021-11-08 10:19:46.228+00
3646	\N	died	2021-11-08 10:18:46.152+00	\N	\N	2021-11-08 10:19:46.073+00	2021-11-08 10:19:46.307+00
5522	\N	died	2021-11-08 10:19:48.383+00	\N	\N	2021-11-08 10:20:36.574+00	2021-11-08 10:20:36.705+00
3656	\N	died	2021-11-08 10:18:46.297+00	\N	\N	2021-11-08 10:19:46.301+00	2021-11-08 10:19:46.532+00
5558	\N	died	2021-11-08 10:19:49.157+00	\N	\N	2021-11-08 10:20:37.722+00	2021-11-08 10:20:38.167+00
3718	\N	died	2021-11-08 10:18:47.698+00	\N	\N	2021-11-08 10:19:47.701+00	2021-11-08 10:19:47.985+00
3728	\N	died	2021-11-08 10:18:47.946+00	\N	\N	2021-11-08 10:19:47.915+00	2021-11-08 10:19:48.253+00
5525	\N	died	2021-11-08 10:19:48.447+00	\N	\N	2021-11-08 10:20:36.689+00	2021-11-08 10:20:37.059+00
3745	\N	died	2021-11-08 10:18:48.399+00	\N	\N	2021-11-08 10:19:48.249+00	2021-11-08 10:19:48.551+00
3755	\N	died	2021-11-08 10:18:48.639+00	\N	\N	2021-11-08 10:19:48.464+00	2021-11-08 10:19:48.911+00
3773	\N	died	2021-11-08 10:18:49.079+00	\N	\N	2021-11-08 10:19:48.907+00	2021-11-08 10:19:49.128+00
5532	\N	died	2021-11-08 10:19:48.597+00	\N	\N	2021-11-08 10:20:37+00	2021-11-08 10:20:37.349+00
3783	\N	died	2021-11-08 10:18:49.439+00	\N	\N	2021-11-08 10:19:49.124+00	2021-11-08 10:19:49.162+00
3785	\N	died	2021-11-08 10:18:49.504+00	\N	\N	2021-11-08 10:19:49.157+00	2021-11-08 10:19:49.196+00
5542	\N	died	2021-11-08 10:19:48.874+00	\N	\N	2021-11-08 10:20:37.339+00	2021-11-08 10:20:37.468+00
3787	\N	died	2021-11-08 10:18:49.51+00	\N	\N	2021-11-08 10:19:49.188+00	2021-11-08 10:19:49.262+00
5589	\N	died	2021-11-08 10:19:49.758+00	\N	\N	2021-11-08 10:20:38.573+00	2021-11-08 10:20:38.711+00
5574	\N	died	2021-11-08 10:19:49.474+00	\N	\N	2021-11-08 10:20:38.149+00	2021-11-08 10:20:38.469+00
5584	\N	died	2021-11-08 10:19:49.69+00	\N	\N	2021-11-08 10:20:38.458+00	2021-11-08 10:20:38.512+00
5603	\N	died	2021-11-08 10:19:49.942+00	\N	\N	2021-11-08 10:20:39.005+00	2021-11-08 10:20:39.37+00
5586	\N	died	2021-11-08 10:19:49.707+00	\N	\N	2021-11-08 10:20:38.506+00	2021-11-08 10:20:38.582+00
5593	\N	died	2021-11-08 10:19:49.777+00	\N	\N	2021-11-08 10:20:38.692+00	2021-11-08 10:20:39.161+00
5617	\N	died	2021-11-08 10:19:50.173+00	\N	\N	2021-11-08 10:20:39.347+00	2021-11-08 10:20:39.593+00
5628	\N	died	2021-11-08 10:19:50.392+00	\N	\N	2021-11-08 10:20:39.55+00	2021-11-08 10:20:40.378+00
5646	\N	died	2021-11-08 10:19:50.723+00	\N	\N	2021-11-08 10:20:40.091+00	2021-11-08 10:20:40.569+00
5658	\N	died	2021-11-08 10:19:51.065+00	\N	\N	2021-11-08 10:20:40.557+00	2021-11-08 10:20:40.697+00
1552	\N	died	2021-11-08 10:18:35.288+00	\N	\N	2021-11-08 10:18:59.51+00	2021-11-08 10:18:59.623+00
1555	\N	died	2021-11-08 10:18:35.311+00	\N	\N	2021-11-08 10:18:59.619+00	2021-11-08 10:18:59.685+00
1559	\N	died	2021-11-08 10:18:35.318+00	\N	\N	2021-11-08 10:18:59.68+00	2021-11-08 10:18:59.724+00
1561	\N	died	2021-11-08 10:18:35.333+00	\N	\N	2021-11-08 10:18:59.711+00	2021-11-08 10:19:00.091+00
1913	\N	died	2021-11-08 10:18:36.702+00	\N	\N	2021-11-08 10:19:07.552+00	2021-11-08 10:19:07.857+00
1578	\N	died	2021-11-08 10:18:35.387+00	\N	\N	2021-11-08 10:19:00.088+00	2021-11-08 10:19:00.205+00
1584	\N	died	2021-11-08 10:18:35.4+00	\N	\N	2021-11-08 10:19:00.18+00	2021-11-08 10:19:00.378+00
1591	\N	died	2021-11-08 10:18:35.424+00	\N	\N	2021-11-08 10:19:00.336+00	2021-11-08 10:19:00.734+00
1927	\N	died	2021-11-08 10:18:36.771+00	\N	\N	2021-11-08 10:19:07.852+00	2021-11-08 10:19:08.112+00
1606	\N	died	2021-11-08 10:18:35.458+00	\N	\N	2021-11-08 10:19:00.598+00	2021-11-08 10:19:00.955+00
3533	\N	died	2021-11-08 10:18:43.506+00	\N	\N	2021-11-08 10:19:43.386+00	2021-11-08 10:19:43.452+00
1621	\N	died	2021-11-08 10:18:35.504+00	\N	\N	2021-11-08 10:19:00.95+00	2021-11-08 10:19:01.204+00
1631	\N	died	2021-11-08 10:18:35.545+00	\N	\N	2021-11-08 10:19:01.114+00	2021-11-08 10:19:01.676+00
1935	\N	died	2021-11-08 10:18:36.806+00	\N	\N	2021-11-08 10:19:08.04+00	2021-11-08 10:19:08.498+00
1652	\N	died	2021-11-08 10:18:35.612+00	\N	\N	2021-11-08 10:19:01.563+00	2021-11-08 10:19:01.798+00
3659	\N	died	2021-11-08 10:18:46.379+00	\N	\N	2021-11-08 10:19:46.345+00	2021-11-08 10:19:46.585+00
1662	\N	died	2021-11-08 10:18:35.681+00	\N	\N	2021-11-08 10:19:01.793+00	2021-11-08 10:19:02.276+00
1672	\N	died	2021-11-08 10:18:35.747+00	\N	\N	2021-11-08 10:19:02.13+00	2021-11-08 10:19:02.38+00
1951	\N	died	2021-11-08 10:18:36.938+00	\N	\N	2021-11-08 10:19:08.396+00	2021-11-08 10:19:08.774+00
1683	\N	died	2021-11-08 10:18:35.806+00	\N	\N	2021-11-08 10:19:02.376+00	2021-11-08 10:19:02.492+00
1688	\N	died	2021-11-08 10:18:35.833+00	\N	\N	2021-11-08 10:19:02.459+00	2021-11-08 10:19:02.759+00
1698	\N	died	2021-11-08 10:18:35.879+00	\N	\N	2021-11-08 10:19:02.673+00	2021-11-08 10:19:02.976+00
1967	\N	died	2021-11-08 10:18:37.008+00	\N	\N	2021-11-08 10:19:08.771+00	2021-11-08 10:19:09.023+00
1713	\N	died	2021-11-08 10:18:35.949+00	\N	\N	2021-11-08 10:19:02.972+00	2021-11-08 10:19:03.173+00
3537	\N	died	2021-11-08 10:18:43.507+00	\N	\N	2021-11-08 10:19:43.445+00	2021-11-08 10:19:43.491+00
1718	\N	died	2021-11-08 10:18:35.966+00	\N	\N	2021-11-08 10:19:03.115+00	2021-11-08 10:19:03.463+00
1733	\N	died	2021-11-08 10:18:36.008+00	\N	\N	2021-11-08 10:19:03.391+00	2021-11-08 10:19:03.827+00
1972	\N	died	2021-11-08 10:18:37.029+00	\N	\N	2021-11-08 10:19:08.85+00	2021-11-08 10:19:09.102+00
1750	\N	died	2021-11-08 10:18:36.051+00	\N	\N	2021-11-08 10:19:03.747+00	2021-11-08 10:19:03.969+00
3726	\N	died	2021-11-08 10:18:47.913+00	\N	\N	2021-11-08 10:19:47.881+00	2021-11-08 10:19:48.186+00
1759	\N	died	2021-11-08 10:18:36.076+00	\N	\N	2021-11-08 10:19:03.963+00	2021-11-08 10:19:04.069+00
1765	\N	died	2021-11-08 10:18:36.09+00	\N	\N	2021-11-08 10:19:04.065+00	2021-11-08 10:19:04.258+00
1984	\N	died	2021-11-08 10:18:37.085+00	\N	\N	2021-11-08 10:19:09.097+00	2021-11-08 10:19:09.285+00
1773	\N	died	2021-11-08 10:18:36.113+00	\N	\N	2021-11-08 10:19:04.24+00	2021-11-08 10:19:04.539+00
1788	\N	died	2021-11-08 10:18:36.151+00	\N	\N	2021-11-08 10:19:04.513+00	2021-11-08 10:19:05.111+00
1803	\N	died	2021-11-08 10:18:36.195+00	\N	\N	2021-11-08 10:19:04.923+00	2021-11-08 10:19:05.159+00
1991	\N	died	2021-11-08 10:18:37.122+00	\N	\N	2021-11-08 10:19:09.269+00	2021-11-08 10:19:09.543+00
1814	\N	died	2021-11-08 10:18:36.222+00	\N	\N	2021-11-08 10:19:05.155+00	2021-11-08 10:19:05.298+00
3539	\N	died	2021-11-08 10:18:43.507+00	\N	\N	2021-11-08 10:19:43.48+00	2021-11-08 10:19:43.741+00
1817	\N	died	2021-11-08 10:18:36.228+00	\N	\N	2021-11-08 10:19:05.207+00	2021-11-08 10:19:05.402+00
1825	\N	died	2021-11-08 10:18:36.251+00	\N	\N	2021-11-08 10:19:05.394+00	2021-11-08 10:19:05.634+00
2002	\N	died	2021-11-08 10:18:37.181+00	\N	\N	2021-11-08 10:19:09.506+00	2021-11-08 10:19:10.271+00
1835	\N	died	2021-11-08 10:18:36.272+00	\N	\N	2021-11-08 10:19:05.597+00	2021-11-08 10:19:05.877+00
1849	\N	died	2021-11-08 10:18:36.304+00	\N	\N	2021-11-08 10:19:05.872+00	2021-11-08 10:19:06.079+00
1856	\N	died	2021-11-08 10:18:36.327+00	\N	\N	2021-11-08 10:19:06.039+00	2021-11-08 10:19:06.193+00
2020	\N	died	2021-11-08 10:18:37.255+00	\N	\N	2021-11-08 10:19:10.265+00	2021-11-08 10:19:10.456+00
1862	\N	died	2021-11-08 10:18:36.351+00	\N	\N	2021-11-08 10:19:06.189+00	2021-11-08 10:19:06.39+00
1867	\N	died	2021-11-08 10:18:36.368+00	\N	\N	2021-11-08 10:19:06.386+00	2021-11-08 10:19:06.809+00
3545	\N	died	2021-11-08 10:18:43.619+00	\N	\N	2021-11-08 10:19:43.626+00	2021-11-08 10:19:43.996+00
1877	\N	died	2021-11-08 10:18:36.406+00	\N	\N	2021-11-08 10:19:06.759+00	2021-11-08 10:19:07.173+00
3670	\N	died	2021-11-08 10:18:46.638+00	\N	\N	2021-11-08 10:19:46.581+00	2021-11-08 10:19:46.68+00
1895	\N	died	2021-11-08 10:18:36.534+00	\N	\N	2021-11-08 10:19:07.161+00	2021-11-08 10:19:07.328+00
1902	\N	died	2021-11-08 10:18:36.648+00	\N	\N	2021-11-08 10:19:07.321+00	2021-11-08 10:19:07.374+00
3556	\N	died	2021-11-08 10:18:43.93+00	\N	\N	2021-11-08 10:19:43.933+00	2021-11-08 10:19:44.254+00
1905	\N	died	2021-11-08 10:18:36.661+00	\N	\N	2021-11-08 10:19:07.37+00	2021-11-08 10:19:07.63+00
2026	\N	died	2021-11-08 10:18:37.272+00	\N	\N	2021-11-08 10:19:10.398+00	2021-11-08 10:19:10.594+00
2035	\N	died	2021-11-08 10:18:37.296+00	\N	\N	2021-11-08 10:19:10.589+00	2021-11-08 10:19:10.814+00
2043	\N	died	2021-11-08 10:18:37.322+00	\N	\N	2021-11-08 10:19:10.729+00	2021-11-08 10:19:11.166+00
3567	\N	died	2021-11-08 10:18:44.231+00	\N	\N	2021-11-08 10:19:44.235+00	2021-11-08 10:19:44.6+00
2062	\N	died	2021-11-08 10:18:37.384+00	\N	\N	2021-11-08 10:19:11.141+00	2021-11-08 10:19:11.603+00
2080	\N	died	2021-11-08 10:18:37.498+00	\N	\N	2021-11-08 10:19:11.58+00	2021-11-08 10:19:12.09+00
2099	\N	died	2021-11-08 10:18:37.592+00	\N	\N	2021-11-08 10:19:12.007+00	2021-11-08 10:19:12.293+00
3573	\N	died	2021-11-08 10:18:44.36+00	\N	\N	2021-11-08 10:19:44.365+00	2021-11-08 10:19:45.027+00
2112	\N	died	2021-11-08 10:18:37.651+00	\N	\N	2021-11-08 10:19:12.27+00	2021-11-08 10:19:12.54+00
3672	\N	died	2021-11-08 10:18:46.673+00	\N	\N	2021-11-08 10:19:46.673+00	2021-11-08 10:19:46.836+00
2124	\N	died	2021-11-08 10:18:37.7+00	\N	\N	2021-11-08 10:19:12.516+00	2021-11-08 10:19:12.94+00
2143	\N	died	2021-11-08 10:18:37.76+00	\N	\N	2021-11-08 10:19:12.937+00	2021-11-08 10:19:13.099+00
3597	\N	died	2021-11-08 10:18:45.129+00	\N	\N	2021-11-08 10:19:45.023+00	2021-11-08 10:19:45.144+00
2152	\N	died	2021-11-08 10:18:37.805+00	\N	\N	2021-11-08 10:19:13.095+00	2021-11-08 10:19:13.191+00
2154	\N	died	2021-11-08 10:18:37.811+00	\N	\N	2021-11-08 10:19:13.186+00	2021-11-08 10:19:13.224+00
2156	\N	died	2021-11-08 10:18:37.817+00	\N	\N	2021-11-08 10:19:13.22+00	2021-11-08 10:19:13.292+00
3602	\N	died	2021-11-08 10:18:45.212+00	\N	\N	2021-11-08 10:19:45.109+00	2021-11-08 10:19:45.415+00
2160	\N	died	2021-11-08 10:18:37.83+00	\N	\N	2021-11-08 10:19:13.287+00	2021-11-08 10:19:13.478+00
2168	\N	died	2021-11-08 10:18:37.859+00	\N	\N	2021-11-08 10:19:13.473+00	2021-11-08 10:19:13.54+00
3617	\N	died	2021-11-08 10:18:45.633+00	\N	\N	2021-11-08 10:19:45.408+00	2021-11-08 10:19:45.641+00
3676	\N	died	2021-11-08 10:18:46.772+00	\N	\N	2021-11-08 10:19:46.761+00	2021-11-08 10:19:47.004+00
3626	\N	died	2021-11-08 10:18:45.677+00	\N	\N	2021-11-08 10:19:45.606+00	2021-11-08 10:19:45.747+00
3741	\N	died	2021-11-08 10:18:48.28+00	\N	\N	2021-11-08 10:19:48.182+00	2021-11-08 10:19:48.318+00
3631	\N	died	2021-11-08 10:18:45.738+00	\N	\N	2021-11-08 10:19:45.741+00	2021-11-08 10:19:45.944+00
3636	\N	died	2021-11-08 10:18:45.905+00	\N	\N	2021-11-08 10:19:45.829+00	2021-11-08 10:19:46.228+00
3648	\N	died	2021-11-08 10:18:46.161+00	\N	\N	2021-11-08 10:19:46.104+00	2021-11-08 10:19:46.532+00
3746	\N	died	2021-11-08 10:18:48.401+00	\N	\N	2021-11-08 10:19:48.314+00	2021-11-08 10:19:48.551+00
3686	\N	died	2021-11-08 10:18:47.017+00	\N	\N	2021-11-08 10:19:47+00	2021-11-08 10:19:47.166+00
5526	\N	died	2021-11-08 10:19:48.464+00	\N	\N	2021-11-08 10:20:36.718+00	2021-11-08 10:20:37.324+00
3691	\N	died	2021-11-08 10:18:47.086+00	\N	\N	2021-11-08 10:19:47.089+00	2021-11-08 10:19:47.438+00
3703	\N	died	2021-11-08 10:18:47.406+00	\N	\N	2021-11-08 10:19:47.399+00	2021-11-08 10:19:47.676+00
3716	\N	died	2021-11-08 10:18:47.666+00	\N	\N	2021-11-08 10:19:47.666+00	2021-11-08 10:19:47.985+00
3756	\N	died	2021-11-08 10:18:48.655+00	\N	\N	2021-11-08 10:19:48.481+00	2021-11-08 10:19:49.128+00
5536	\N	died	2021-11-08 10:19:48.773+00	\N	\N	2021-11-08 10:20:37.139+00	2021-11-08 10:20:37.468+00
3775	\N	died	2021-11-08 10:18:49.205+00	\N	\N	2021-11-08 10:19:48.94+00	2021-11-08 10:19:49.178+00
5577	\N	died	2021-11-08 10:19:49.54+00	\N	\N	2021-11-08 10:20:38.224+00	2021-11-08 10:20:38.729+00
3786	\N	died	2021-11-08 10:18:49.508+00	\N	\N	2021-11-08 10:19:49.174+00	2021-11-08 10:19:49.262+00
3789	\N	died	2021-11-08 10:18:49.54+00	\N	\N	2021-11-08 10:19:49.224+00	2021-11-08 10:19:49.445+00
5545	\N	died	2021-11-08 10:19:48.923+00	\N	\N	2021-11-08 10:20:37.408+00	2021-11-08 10:20:37.856+00
3797	\N	died	2021-11-08 10:18:49.79+00	\N	\N	2021-11-08 10:19:49.405+00	2021-11-08 10:19:49.79+00
3816	\N	died	2021-11-08 10:18:50.398+00	\N	\N	2021-11-08 10:19:49.778+00	2021-11-08 10:19:49.98+00
5555	\N	died	2021-11-08 10:19:49.11+00	\N	\N	2021-11-08 10:20:37.683+00	2021-11-08 10:20:38+00
3825	\N	died	2021-11-08 10:18:50.697+00	\N	\N	2021-11-08 10:19:49.976+00	2021-11-08 10:19:50.027+00
5570	\N	died	2021-11-08 10:19:49.423+00	\N	\N	2021-11-08 10:20:37.979+00	2021-11-08 10:20:38.443+00
5594	\N	died	2021-11-08 10:19:49.794+00	\N	\N	2021-11-08 10:20:38.723+00	2021-11-08 10:20:39.161+00
5604	\N	died	2021-11-08 10:19:49.957+00	\N	\N	2021-11-08 10:20:39.024+00	2021-11-08 10:20:39.442+00
5621	\N	died	2021-11-08 10:19:50.223+00	\N	\N	2021-11-08 10:20:39.415+00	2021-11-08 10:20:39.792+00
5635	\N	died	2021-11-08 10:19:50.508+00	\N	\N	2021-11-08 10:20:39.782+00	2021-11-08 10:20:39.902+00
5641	\N	died	2021-11-08 10:19:50.673+00	\N	\N	2021-11-08 10:20:39.897+00	2021-11-08 10:20:40.378+00
5651	\N	died	2021-11-08 10:19:50.899+00	\N	\N	2021-11-08 10:20:40.332+00	2021-11-08 10:20:40.987+00
5670	\N	died	2021-11-08 10:19:51.2+00	\N	\N	2021-11-08 10:20:40.864+00	2021-11-08 10:20:41.091+00
5681	\N	died	2021-11-08 10:19:51.315+00	\N	\N	2021-11-08 10:20:41.075+00	2021-11-08 10:20:41.299+00
1611	\N	died	2021-11-08 10:18:35.475+00	\N	\N	2021-11-08 10:19:00.73+00	2021-11-08 10:19:00.771+00
1613	\N	died	2021-11-08 10:18:35.481+00	\N	\N	2021-11-08 10:19:00.767+00	2021-11-08 10:19:00.822+00
2018	\N	died	2021-11-08 10:18:37.249+00	\N	\N	2021-11-08 10:19:10.232+00	2021-11-08 10:19:10.814+00
1616	\N	died	2021-11-08 10:18:35.488+00	\N	\N	2021-11-08 10:19:00.818+00	2021-11-08 10:19:00.969+00
1622	\N	died	2021-11-08 10:18:35.504+00	\N	\N	2021-11-08 10:19:00.964+00	2021-11-08 10:19:01.204+00
1632	\N	died	2021-11-08 10:18:35.553+00	\N	\N	2021-11-08 10:19:01.185+00	2021-11-08 10:19:01.676+00
2040	\N	died	2021-11-08 10:18:37.316+00	\N	\N	2021-11-08 10:19:10.677+00	2021-11-08 10:19:11.028+00
1654	\N	died	2021-11-08 10:18:35.619+00	\N	\N	2021-11-08 10:19:01.646+00	2021-11-08 10:19:01.922+00
3599	\N	died	2021-11-08 10:18:45.163+00	\N	\N	2021-11-08 10:19:45.056+00	2021-11-08 10:19:45.144+00
1666	\N	died	2021-11-08 10:18:35.72+00	\N	\N	2021-11-08 10:19:01.918+00	2021-11-08 10:19:02.276+00
1676	\N	died	2021-11-08 10:18:35.78+00	\N	\N	2021-11-08 10:19:02.208+00	2021-11-08 10:19:02.643+00
2052	\N	died	2021-11-08 10:18:37.35+00	\N	\N	2021-11-08 10:19:10.929+00	2021-11-08 10:19:11.166+00
1695	\N	died	2021-11-08 10:18:35.865+00	\N	\N	2021-11-08 10:19:02.626+00	2021-11-08 10:19:02.962+00
3743	\N	died	2021-11-08 10:18:48.362+00	\N	\N	2021-11-08 10:19:48.216+00	2021-11-08 10:19:48.551+00
1711	\N	died	2021-11-08 10:18:35.936+00	\N	\N	2021-11-08 10:19:02.939+00	2021-11-08 10:19:03.185+00
1723	\N	died	2021-11-08 10:18:35.977+00	\N	\N	2021-11-08 10:19:03.18+00	2021-11-08 10:19:03.324+00
2061	\N	died	2021-11-08 10:18:37.384+00	\N	\N	2021-11-08 10:19:11.124+00	2021-11-08 10:19:11.392+00
1728	\N	died	2021-11-08 10:18:35.996+00	\N	\N	2021-11-08 10:19:03.32+00	2021-11-08 10:19:03.463+00
1735	\N	died	2021-11-08 10:18:36.015+00	\N	\N	2021-11-08 10:19:03.426+00	2021-11-08 10:19:03.827+00
1754	\N	died	2021-11-08 10:18:36.064+00	\N	\N	2021-11-08 10:19:03.809+00	2021-11-08 10:19:04.258+00
2073	\N	died	2021-11-08 10:18:37.423+00	\N	\N	2021-11-08 10:19:11.388+00	2021-11-08 10:19:11.603+00
1772	\N	died	2021-11-08 10:18:36.113+00	\N	\N	2021-11-08 10:19:04.228+00	2021-11-08 10:19:04.497+00
3604	\N	died	2021-11-08 10:18:45.246+00	\N	\N	2021-11-08 10:19:45.14+00	2021-11-08 10:19:45.194+00
1786	\N	died	2021-11-08 10:18:36.151+00	\N	\N	2021-11-08 10:19:04.493+00	2021-11-08 10:19:04.737+00
1792	\N	died	2021-11-08 10:18:36.163+00	\N	\N	2021-11-08 10:19:04.635+00	2021-11-08 10:19:04.911+00
2078	\N	died	2021-11-08 10:18:37.471+00	\N	\N	2021-11-08 10:19:11.533+00	2021-11-08 10:19:11.824+00
1802	\N	died	2021-11-08 10:18:36.19+00	\N	\N	2021-11-08 10:19:04.907+00	2021-11-08 10:19:05.148+00
1812	\N	died	2021-11-08 10:18:36.216+00	\N	\N	2021-11-08 10:19:05.123+00	2021-11-08 10:19:05.198+00
1816	\N	died	2021-11-08 10:18:36.228+00	\N	\N	2021-11-08 10:19:05.193+00	2021-11-08 10:19:05.359+00
2091	\N	died	2021-11-08 10:18:37.565+00	\N	\N	2021-11-08 10:19:11.82+00	2021-11-08 10:19:11.876+00
1821	\N	died	2021-11-08 10:18:36.235+00	\N	\N	2021-11-08 10:19:05.322+00	2021-11-08 10:19:05.634+00
1831	\N	died	2021-11-08 10:18:36.261+00	\N	\N	2021-11-08 10:19:05.531+00	2021-11-08 10:19:06.01+00
1853	\N	died	2021-11-08 10:18:36.321+00	\N	\N	2021-11-08 10:19:05.989+00	2021-11-08 10:19:06.809+00
2094	\N	died	2021-11-08 10:18:37.579+00	\N	\N	2021-11-08 10:19:11.872+00	2021-11-08 10:19:12.09+00
1874	\N	died	2021-11-08 10:18:36.395+00	\N	\N	2021-11-08 10:19:06.655+00	2021-11-08 10:19:06.996+00
3607	\N	died	2021-11-08 10:18:45.283+00	\N	\N	2021-11-08 10:19:45.189+00	2021-11-08 10:19:45.294+00
1888	\N	died	2021-11-08 10:18:36.434+00	\N	\N	2021-11-08 10:19:06.989+00	2021-11-08 10:19:07.173+00
1893	\N	died	2021-11-08 10:18:36.477+00	\N	\N	2021-11-08 10:19:07.095+00	2021-11-08 10:19:07.395+00
2100	\N	died	2021-11-08 10:18:37.598+00	\N	\N	2021-11-08 10:19:12.02+00	2021-11-08 10:19:12.318+00
1906	\N	died	2021-11-08 10:18:36.671+00	\N	\N	2021-11-08 10:19:07.392+00	2021-11-08 10:19:07.63+00
1915	\N	died	2021-11-08 10:18:36.714+00	\N	\N	2021-11-08 10:19:07.585+00	2021-11-08 10:19:08.112+00
1931	\N	died	2021-11-08 10:18:36.786+00	\N	\N	2021-11-08 10:19:07.927+00	2021-11-08 10:19:08.164+00
2114	\N	died	2021-11-08 10:18:37.663+00	\N	\N	2021-11-08 10:19:12.304+00	2021-11-08 10:19:12.54+00
1942	\N	died	2021-11-08 10:18:36.837+00	\N	\N	2021-11-08 10:19:08.159+00	2021-11-08 10:19:08.299+00
1946	\N	died	2021-11-08 10:18:36.91+00	\N	\N	2021-11-08 10:19:08.31+00	2021-11-08 10:19:08.498+00
1952	\N	died	2021-11-08 10:18:36.943+00	\N	\N	2021-11-08 10:19:08.41+00	2021-11-08 10:19:08.809+00
2123	\N	died	2021-11-08 10:18:37.7+00	\N	\N	2021-11-08 10:19:12.505+00	2021-11-08 10:19:13.099+00
1969	\N	died	2021-11-08 10:18:37.017+00	\N	\N	2021-11-08 10:19:08.805+00	2021-11-08 10:19:09.023+00
3609	\N	died	2021-11-08 10:18:45.381+00	\N	\N	2021-11-08 10:19:45.273+00	2021-11-08 10:19:45.593+00
1976	\N	died	2021-11-08 10:18:37.047+00	\N	\N	2021-11-08 10:19:08.969+00	2021-11-08 10:19:09.285+00
1992	\N	died	2021-11-08 10:18:37.122+00	\N	\N	2021-11-08 10:19:09.281+00	2021-11-08 10:19:09.543+00
3750	\N	died	2021-11-08 10:18:48.556+00	\N	\N	2021-11-08 10:19:48.384+00	2021-11-08 10:19:48.602+00
2001	\N	died	2021-11-08 10:18:37.181+00	\N	\N	2021-11-08 10:19:09.493+00	2021-11-08 10:19:10.255+00
2145	\N	died	2021-11-08 10:18:37.767+00	\N	\N	2021-11-08 10:19:12.97+00	2021-11-08 10:19:13.236+00
3622	\N	died	2021-11-08 10:18:45.663+00	\N	\N	2021-11-08 10:19:45.539+00	2021-11-08 10:19:45.977+00
2157	\N	died	2021-11-08 10:18:37.817+00	\N	\N	2021-11-08 10:19:13.232+00	2021-11-08 10:19:13.478+00
2162	\N	died	2021-11-08 10:18:37.835+00	\N	\N	2021-11-08 10:19:13.32+00	2021-11-08 10:19:13.553+00
2173	\N	died	2021-11-08 10:18:37.871+00	\N	\N	2021-11-08 10:19:13.549+00	2021-11-08 10:19:13.689+00
3639	\N	died	2021-11-08 10:18:46.014+00	\N	\N	2021-11-08 10:19:45.954+00	2021-11-08 10:19:46.292+00
2177	\N	died	2021-11-08 10:18:37.895+00	\N	\N	2021-11-08 10:19:13.671+00	2021-11-08 10:19:14.04+00
2196	\N	died	2021-11-08 10:18:37.963+00	\N	\N	2021-11-08 10:19:14.037+00	2021-11-08 10:19:14.138+00
2199	\N	died	2021-11-08 10:18:37.969+00	\N	\N	2021-11-08 10:19:14.134+00	2021-11-08 10:19:14.238+00
3655	\N	died	2021-11-08 10:18:46.282+00	\N	\N	2021-11-08 10:19:46.285+00	2021-11-08 10:19:46.532+00
2205	\N	died	2021-11-08 10:18:37.998+00	\N	\N	2021-11-08 10:19:14.234+00	2021-11-08 10:19:14.37+00
3760	\N	died	2021-11-08 10:18:48.822+00	\N	\N	2021-11-08 10:19:48.598+00	2021-11-08 10:19:48.712+00
2209	\N	died	2021-11-08 10:18:38.01+00	\N	\N	2021-11-08 10:19:14.366+00	2021-11-08 10:19:14.541+00
2218	\N	died	2021-11-08 10:18:38.081+00	\N	\N	2021-11-08 10:19:14.543+00	2021-11-08 10:19:14.689+00
3664	\N	died	2021-11-08 10:18:46.522+00	\N	\N	2021-11-08 10:19:46.483+00	2021-11-08 10:19:46.97+00
2225	\N	died	2021-11-08 10:18:38.136+00	\N	\N	2021-11-08 10:19:14.697+00	2021-11-08 10:19:14.89+00
3806	\N	died	2021-11-08 10:18:50.113+00	\N	\N	2021-11-08 10:19:49.557+00	2021-11-08 10:19:49.697+00
2232	\N	died	2021-11-08 10:18:38.168+00	\N	\N	2021-11-08 10:19:14.885+00	2021-11-08 10:19:15.133+00
2239	\N	died	2021-11-08 10:18:38.209+00	\N	\N	2021-11-08 10:19:15.128+00	2021-11-08 10:19:15.166+00
3682	\N	died	2021-11-08 10:18:47.002+00	\N	\N	2021-11-08 10:19:46.945+00	2021-11-08 10:19:47.318+00
2241	\N	died	2021-11-08 10:18:38.218+00	\N	\N	2021-11-08 10:19:15.162+00	2021-11-08 10:19:15.229+00
2245	\N	died	2021-11-08 10:18:38.23+00	\N	\N	2021-11-08 10:19:15.224+00	2021-11-08 10:19:15.301+00
3696	\N	died	2021-11-08 10:18:47.279+00	\N	\N	2021-11-08 10:19:47.232+00	2021-11-08 10:19:47.483+00
3764	\N	died	2021-11-08 10:18:48.872+00	\N	\N	2021-11-08 10:19:48.708+00	2021-11-08 10:19:48.825+00
3708	\N	died	2021-11-08 10:18:47.496+00	\N	\N	2021-11-08 10:19:47.479+00	2021-11-08 10:19:47.536+00
3711	\N	died	2021-11-08 10:18:47.529+00	\N	\N	2021-11-08 10:19:47.53+00	2021-11-08 10:19:47.689+00
5531	\N	died	2021-11-08 10:19:48.58+00	\N	\N	2021-11-08 10:20:36.959+00	2021-11-08 10:20:37.324+00
3717	\N	died	2021-11-08 10:18:47.683+00	\N	\N	2021-11-08 10:19:47.683+00	2021-11-08 10:19:47.985+00
3727	\N	died	2021-11-08 10:18:47.929+00	\N	\N	2021-11-08 10:19:47.898+00	2021-11-08 10:19:48.221+00
3811	\N	died	2021-11-08 10:18:50.266+00	\N	\N	2021-11-08 10:19:49.692+00	2021-11-08 10:19:49.728+00
3768	\N	died	2021-11-08 10:18:48.993+00	\N	\N	2021-11-08 10:19:48.821+00	2021-11-08 10:19:49.128+00
5567	\N	died	2021-11-08 10:19:49.317+00	\N	\N	2021-11-08 10:20:37.922+00	2021-11-08 10:20:38.443+00
3776	\N	died	2021-11-08 10:18:49.257+00	\N	\N	2021-11-08 10:19:49.008+00	2021-11-08 10:19:49.21+00
3788	\N	died	2021-11-08 10:18:49.522+00	\N	\N	2021-11-08 10:19:49.206+00	2021-11-08 10:19:49.323+00
5538	\N	died	2021-11-08 10:19:48.792+00	\N	\N	2021-11-08 10:20:37.172+00	2021-11-08 10:20:37.655+00
3793	\N	died	2021-11-08 10:18:49.694+00	\N	\N	2021-11-08 10:19:49.288+00	2021-11-08 10:19:49.561+00
5656	\N	died	2021-11-08 10:19:50.981+00	\N	\N	2021-11-08 10:20:40.508+00	2021-11-08 10:20:40.697+00
3813	\N	died	2021-11-08 10:18:50.333+00	\N	\N	2021-11-08 10:19:49.724+00	2021-11-08 10:19:49.98+00
3819	\N	died	2021-11-08 10:18:50.563+00	\N	\N	2021-11-08 10:19:49.876+00	2021-11-08 10:19:50.044+00
5552	\N	died	2021-11-08 10:19:49.073+00	\N	\N	2021-11-08 10:20:37.631+00	2021-11-08 10:20:37.893+00
3829	\N	died	2021-11-08 10:18:50.863+00	\N	\N	2021-11-08 10:19:50.041+00	2021-11-08 10:19:50.162+00
3833	\N	died	2021-11-08 10:18:50.964+00	\N	\N	2021-11-08 10:19:50.159+00	2021-11-08 10:19:50.228+00
3837	\N	died	2021-11-08 10:18:51.097+00	\N	\N	2021-11-08 10:19:50.224+00	2021-11-08 10:19:50.477+00
5563	\N	died	2021-11-08 10:19:49.242+00	\N	\N	2021-11-08 10:20:37.873+00	2021-11-08 10:20:37.96+00
3847	\N	died	2021-11-08 10:18:51.381+00	\N	\N	2021-11-08 10:19:50.473+00	2021-11-08 10:19:50.513+00
5579	\N	died	2021-11-08 10:19:49.573+00	\N	\N	2021-11-08 10:20:38.272+00	2021-11-08 10:20:38.812+00
5627	\N	died	2021-11-08 10:19:50.39+00	\N	\N	2021-11-08 10:20:39.516+00	2021-11-08 10:20:40.017+00
5598	\N	died	2021-11-08 10:19:49.875+00	\N	\N	2021-11-08 10:20:38.806+00	2021-11-08 10:20:39.161+00
5607	\N	died	2021-11-08 10:19:49.989+00	\N	\N	2021-11-08 10:20:39.105+00	2021-11-08 10:20:39.593+00
5644	\N	died	2021-11-08 10:19:50.707+00	\N	\N	2021-11-08 10:20:40+00	2021-11-08 10:20:40.404+00
5675	\N	died	2021-11-08 10:19:51.233+00	\N	\N	2021-11-08 10:20:40.964+00	2021-11-08 10:20:41.585+00
5653	\N	died	2021-11-08 10:19:50.931+00	\N	\N	2021-11-08 10:20:40.398+00	2021-11-08 10:20:40.548+00
5697	\N	died	2021-11-08 10:19:51.467+00	\N	\N	2021-11-08 10:20:41.574+00	2021-11-08 10:20:41.827+00
5706	\N	died	2021-11-08 10:19:51.654+00	\N	\N	2021-11-08 10:20:41.758+00	2021-11-08 10:20:42.678+00
1647	\N	died	2021-11-08 10:18:35.601+00	\N	\N	2021-11-08 10:19:01.486+00	2021-11-08 10:19:01.552+00
1651	\N	died	2021-11-08 10:18:35.612+00	\N	\N	2021-11-08 10:19:01.548+00	2021-11-08 10:19:01.676+00
2012	\N	died	2021-11-08 10:18:37.233+00	\N	\N	2021-11-08 10:19:09.802+00	2021-11-08 10:19:10.493+00
1656	\N	died	2021-11-08 10:18:35.626+00	\N	\N	2021-11-08 10:19:01.672+00	2021-11-08 10:19:01.719+00
2252	\N	died	2021-11-08 10:18:38.263+00	\N	\N	2021-11-08 10:19:15.346+00	2021-11-08 10:19:15.667+00
1658	\N	died	2021-11-08 10:18:35.639+00	\N	\N	2021-11-08 10:19:01.715+00	2021-11-08 10:19:01.905+00
1665	\N	died	2021-11-08 10:18:35.715+00	\N	\N	2021-11-08 10:19:01.9+00	2021-11-08 10:19:02.276+00
2030	\N	died	2021-11-08 10:18:37.284+00	\N	\N	2021-11-08 10:19:10.465+00	2021-11-08 10:19:10.814+00
1675	\N	died	2021-11-08 10:18:35.775+00	\N	\N	2021-11-08 10:19:02.192+00	2021-11-08 10:19:02.492+00
1689	\N	died	2021-11-08 10:18:35.839+00	\N	\N	2021-11-08 10:19:02.476+00	2021-11-08 10:19:02.759+00
1701	\N	died	2021-11-08 10:18:35.892+00	\N	\N	2021-11-08 10:19:02.721+00	2021-11-08 10:19:03.173+00
2039	\N	died	2021-11-08 10:18:37.31+00	\N	\N	2021-11-08 10:19:10.657+00	2021-11-08 10:19:11.098+00
1719	\N	died	2021-11-08 10:18:35.966+00	\N	\N	2021-11-08 10:19:03.123+00	2021-11-08 10:19:03.463+00
1731	\N	died	2021-11-08 10:18:36.002+00	\N	\N	2021-11-08 10:19:03.364+00	2021-11-08 10:19:03.577+00
1742	\N	died	2021-11-08 10:18:36.038+00	\N	\N	2021-11-08 10:19:03.573+00	2021-11-08 10:19:03.738+00
2056	\N	died	2021-11-08 10:18:37.365+00	\N	\N	2021-11-08 10:19:11.047+00	2021-11-08 10:19:11.2+00
1747	\N	died	2021-11-08 10:18:36.045+00	\N	\N	2021-11-08 10:19:03.647+00	2021-11-08 10:19:03.991+00
2269	\N	died	2021-11-08 10:18:38.344+00	\N	\N	2021-11-08 10:19:15.663+00	2021-11-08 10:19:15.884+00
1760	\N	died	2021-11-08 10:18:36.084+00	\N	\N	2021-11-08 10:19:03.988+00	2021-11-08 10:19:04.188+00
1767	\N	died	2021-11-08 10:18:36.101+00	\N	\N	2021-11-08 10:19:04.098+00	2021-11-08 10:19:04.477+00
2065	\N	died	2021-11-08 10:18:37.4+00	\N	\N	2021-11-08 10:19:11.197+00	2021-11-08 10:19:11.371+00
1782	\N	died	2021-11-08 10:18:36.137+00	\N	\N	2021-11-08 10:19:04.427+00	2021-11-08 10:19:04.617+00
3630	\N	died	2021-11-08 10:18:45.724+00	\N	\N	2021-11-08 10:19:45.724+00	2021-11-08 10:19:45.799+00
1791	\N	died	2021-11-08 10:18:36.157+00	\N	\N	2021-11-08 10:19:04.613+00	2021-11-08 10:19:04.848+00
1798	\N	died	2021-11-08 10:18:36.184+00	\N	\N	2021-11-08 10:19:04.843+00	2021-11-08 10:19:05.111+00
2070	\N	died	2021-11-08 10:18:37.408+00	\N	\N	2021-11-08 10:19:11.334+00	2021-11-08 10:19:11.793+00
1808	\N	died	2021-11-08 10:18:36.209+00	\N	\N	2021-11-08 10:19:05.056+00	2021-11-08 10:19:05.439+00
1826	\N	died	2021-11-08 10:18:36.251+00	\N	\N	2021-11-08 10:19:05.414+00	2021-11-08 10:19:05.651+00
1838	\N	died	2021-11-08 10:18:36.277+00	\N	\N	2021-11-08 10:19:05.647+00	2021-11-08 10:19:05.803+00
2084	\N	died	2021-11-08 10:18:37.522+00	\N	\N	2021-11-08 10:19:11.646+00	2021-11-08 10:19:11.887+00
1842	\N	died	2021-11-08 10:18:36.287+00	\N	\N	2021-11-08 10:19:05.764+00	2021-11-08 10:19:06.031+00
2279	\N	died	2021-11-08 10:18:38.396+00	\N	\N	2021-11-08 10:19:15.88+00	2021-11-08 10:19:15.916+00
1855	\N	died	2021-11-08 10:18:36.327+00	\N	\N	2021-11-08 10:19:06.026+00	2021-11-08 10:19:06.131+00
1860	\N	died	2021-11-08 10:18:36.345+00	\N	\N	2021-11-08 10:19:06.109+00	2021-11-08 10:19:06.58+00
2095	\N	died	2021-11-08 10:18:37.579+00	\N	\N	2021-11-08 10:19:11.882+00	2021-11-08 10:19:12.09+00
1869	\N	died	2021-11-08 10:18:36.374+00	\N	\N	2021-11-08 10:19:06.576+00	2021-11-08 10:19:06.809+00
3721	\N	died	2021-11-08 10:18:47.83+00	\N	\N	2021-11-08 10:19:47.75+00	2021-11-08 10:19:47.985+00
1879	\N	died	2021-11-08 10:18:36.412+00	\N	\N	2021-11-08 10:19:06.793+00	2021-11-08 10:19:07.328+00
1900	\N	died	2021-11-08 10:18:36.633+00	\N	\N	2021-11-08 10:19:07.289+00	2021-11-08 10:19:07.63+00
2102	\N	died	2021-11-08 10:18:37.604+00	\N	\N	2021-11-08 10:19:12.054+00	2021-11-08 10:19:12.54+00
1912	\N	died	2021-11-08 10:18:36.697+00	\N	\N	2021-11-08 10:19:07.532+00	2021-11-08 10:19:07.836+00
1925	\N	died	2021-11-08 10:18:36.766+00	\N	\N	2021-11-08 10:19:07.818+00	2021-11-08 10:19:08.112+00
1932	\N	died	2021-11-08 10:18:36.792+00	\N	\N	2021-11-08 10:19:08.005+00	2021-11-08 10:19:08.299+00
2118	\N	died	2021-11-08 10:18:37.682+00	\N	\N	2021-11-08 10:19:12.374+00	2021-11-08 10:19:12.587+00
1944	\N	died	2021-11-08 10:18:36.894+00	\N	\N	2021-11-08 10:19:08.289+00	2021-11-08 10:19:08.498+00
2281	\N	died	2021-11-08 10:18:38.402+00	\N	\N	2021-11-08 10:19:15.911+00	2021-11-08 10:19:15.952+00
1950	\N	died	2021-11-08 10:18:36.932+00	\N	\N	2021-11-08 10:19:08.377+00	2021-11-08 10:19:08.644+00
1963	\N	died	2021-11-08 10:18:36.991+00	\N	\N	2021-11-08 10:19:08.639+00	2021-11-08 10:19:08.774+00
2128	\N	died	2021-11-08 10:18:37.712+00	\N	\N	2021-11-08 10:19:12.582+00	2021-11-08 10:19:12.721+00
1966	\N	died	2021-11-08 10:18:37.002+00	\N	\N	2021-11-08 10:19:08.755+00	2021-11-08 10:19:09.023+00
1974	\N	died	2021-11-08 10:18:37.035+00	\N	\N	2021-11-08 10:19:08.886+00	2021-11-08 10:19:09.226+00
1988	\N	died	2021-11-08 10:18:37.107+00	\N	\N	2021-11-08 10:19:09.222+00	2021-11-08 10:19:09.543+00
2283	\N	died	2021-11-08 10:18:38.407+00	\N	\N	2021-11-08 10:19:15.945+00	2021-11-08 10:19:16.016+00
1998	\N	died	2021-11-08 10:18:37.165+00	\N	\N	2021-11-08 10:19:09.443+00	2021-11-08 10:19:10.157+00
3634	\N	died	2021-11-08 10:18:45.788+00	\N	\N	2021-11-08 10:19:45.789+00	2021-11-08 10:19:45.944+00
2131	\N	died	2021-11-08 10:18:37.721+00	\N	\N	2021-11-08 10:19:12.682+00	2021-11-08 10:19:12.856+00
2141	\N	died	2021-11-08 10:18:37.753+00	\N	\N	2021-11-08 10:19:12.853+00	2021-11-08 10:19:13.099+00
2287	\N	died	2021-11-08 10:18:38.426+00	\N	\N	2021-11-08 10:19:16.012+00	2021-11-08 10:19:16.091+00
2151	\N	died	2021-11-08 10:18:37.79+00	\N	\N	2021-11-08 10:19:13.074+00	2021-11-08 10:19:13.54+00
3772	\N	died	2021-11-08 10:18:49.063+00	\N	\N	2021-11-08 10:19:48.891+00	2021-11-08 10:19:49.128+00
2171	\N	died	2021-11-08 10:18:37.865+00	\N	\N	2021-11-08 10:19:13.515+00	2021-11-08 10:19:13.871+00
2291	\N	died	2021-11-08 10:18:38.469+00	\N	\N	2021-11-08 10:19:16.088+00	2021-11-08 10:19:16.206+00
2186	\N	died	2021-11-08 10:18:37.92+00	\N	\N	2021-11-08 10:19:13.866+00	2021-11-08 10:19:14.022+00
2195	\N	died	2021-11-08 10:18:37.955+00	\N	\N	2021-11-08 10:19:14.017+00	2021-11-08 10:19:14.138+00
2198	\N	died	2021-11-08 10:18:37.969+00	\N	\N	2021-11-08 10:19:14.122+00	2021-11-08 10:19:14.269+00
2207	\N	died	2021-11-08 10:18:38.004+00	\N	\N	2021-11-08 10:19:14.266+00	2021-11-08 10:19:14.541+00
2299	\N	died	2021-11-08 10:18:38.511+00	\N	\N	2021-11-08 10:19:16.212+00	2021-11-08 10:19:16.351+00
2213	\N	died	2021-11-08 10:18:38.022+00	\N	\N	2021-11-08 10:19:14.433+00	2021-11-08 10:19:14.871+00
3638	\N	died	2021-11-08 10:18:46.013+00	\N	\N	2021-11-08 10:19:45.94+00	2021-11-08 10:19:46.008+00
2231	\N	died	2021-11-08 10:18:38.164+00	\N	\N	2021-11-08 10:19:14.867+00	2021-11-08 10:19:15.133+00
2236	\N	died	2021-11-08 10:18:38.186+00	\N	\N	2021-11-08 10:19:15.079+00	2021-11-08 10:19:15.367+00
2307	\N	died	2021-11-08 10:18:38.549+00	\N	\N	2021-11-08 10:19:16.346+00	2021-11-08 10:19:16.469+00
3642	\N	died	2021-11-08 10:18:46.022+00	\N	\N	2021-11-08 10:19:46.004+00	2021-11-08 10:19:46.228+00
2314	\N	died	2021-11-08 10:18:38.579+00	\N	\N	2021-11-08 10:19:16.464+00	2021-11-08 10:19:16.531+00
3731	\N	died	2021-11-08 10:18:48.046+00	\N	\N	2021-11-08 10:19:47.965+00	2021-11-08 10:19:48.37+00
2318	\N	died	2021-11-08 10:18:38.585+00	\N	\N	2021-11-08 10:19:16.526+00	2021-11-08 10:19:16.708+00
2326	\N	died	2021-11-08 10:18:38.613+00	\N	\N	2021-11-08 10:19:16.704+00	2021-11-08 10:19:16.771+00
3649	\N	died	2021-11-08 10:18:46.171+00	\N	\N	2021-11-08 10:19:46.173+00	2021-11-08 10:19:46.532+00
2330	\N	died	2021-11-08 10:18:38.629+00	\N	\N	2021-11-08 10:19:16.767+00	2021-11-08 10:19:16.808+00
3812	\N	died	2021-11-08 10:18:50.33+00	\N	\N	2021-11-08 10:19:49.708+00	2021-11-08 10:19:49.764+00
2332	\N	died	2021-11-08 10:18:38.646+00	\N	\N	2021-11-08 10:19:16.803+00	2021-11-08 10:19:16.883+00
2337	\N	died	2021-11-08 10:18:38.662+00	\N	\N	2021-11-08 10:19:16.879+00	2021-11-08 10:19:16.951+00
3663	\N	died	2021-11-08 10:18:46.474+00	\N	\N	2021-11-08 10:19:46.466+00	2021-11-08 10:19:46.836+00
2341	\N	died	2021-11-08 10:18:38.688+00	\N	\N	2021-11-08 10:19:16.947+00	2021-11-08 10:19:17.021+00
2345	\N	died	2021-11-08 10:18:38.706+00	\N	\N	2021-11-08 10:19:17.017+00	2021-11-08 10:19:17.102+00
3679	\N	died	2021-11-08 10:18:46.798+00	\N	\N	2021-11-08 10:19:46.803+00	2021-11-08 10:19:47.438+00
2350	\N	died	2021-11-08 10:18:38.737+00	\N	\N	2021-11-08 10:19:17.099+00	2021-11-08 10:19:17.314+00
3749	\N	died	2021-11-08 10:18:48.497+00	\N	\N	2021-11-08 10:19:48.366+00	2021-11-08 10:19:48.585+00
3702	\N	died	2021-11-08 10:18:47.358+00	\N	\N	2021-11-08 10:19:47.331+00	2021-11-08 10:19:47.536+00
3710	\N	died	2021-11-08 10:18:47.513+00	\N	\N	2021-11-08 10:19:47.512+00	2021-11-08 10:19:47.754+00
3758	\N	died	2021-11-08 10:18:48.771+00	\N	\N	2021-11-08 10:19:48.566+00	2021-11-08 10:19:48.712+00
3762	\N	died	2021-11-08 10:18:48.838+00	\N	\N	2021-11-08 10:19:48.633+00	2021-11-08 10:19:48.895+00
3815	\N	died	2021-11-08 10:18:50.349+00	\N	\N	2021-11-08 10:19:49.76+00	2021-11-08 10:19:49.98+00
3782	\N	died	2021-11-08 10:18:49.422+00	\N	\N	2021-11-08 10:19:49.112+00	2021-11-08 10:19:49.545+00
3823	\N	died	2021-11-08 10:18:50.63+00	\N	\N	2021-11-08 10:19:49.942+00	2021-11-08 10:19:50.477+00
3802	\N	died	2021-11-08 10:18:50.013+00	\N	\N	2021-11-08 10:19:49.49+00	2021-11-08 10:19:49.712+00
3842	\N	died	2021-11-08 10:18:51.314+00	\N	\N	2021-11-08 10:19:50.393+00	2021-11-08 10:19:50.681+00
5560	\N	died	2021-11-08 10:19:49.206+00	\N	\N	2021-11-08 10:20:37.755+00	2021-11-08 10:20:38.443+00
3856	\N	died	2021-11-08 10:18:51.688+00	\N	\N	2021-11-08 10:19:50.678+00	2021-11-08 10:19:50.938+00
5605	\N	died	2021-11-08 10:19:49.974+00	\N	\N	2021-11-08 10:20:39.059+00	2021-11-08 10:20:39.593+00
3866	\N	died	2021-11-08 10:18:51.989+00	\N	\N	2021-11-08 10:19:50.932+00	2021-11-08 10:19:50.97+00
3868	\N	died	2021-11-08 10:18:52.055+00	\N	\N	2021-11-08 10:19:50.966+00	2021-11-08 10:19:51.002+00
5578	\N	died	2021-11-08 10:19:49.556+00	\N	\N	2021-11-08 10:20:38.249+00	2021-11-08 10:20:38.78+00
3870	\N	died	2021-11-08 10:18:52.088+00	\N	\N	2021-11-08 10:19:50.998+00	2021-11-08 10:19:51.14+00
5596	\N	died	2021-11-08 10:19:49.806+00	\N	\N	2021-11-08 10:20:38.759+00	2021-11-08 10:20:39.161+00
5623	\N	died	2021-11-08 10:19:50.26+00	\N	\N	2021-11-08 10:20:39.447+00	2021-11-08 10:20:39.683+00
5633	\N	died	2021-11-08 10:19:50.489+00	\N	\N	2021-11-08 10:20:39.673+00	2021-11-08 10:20:39.837+00
1785	\N	died	2021-11-08 10:18:36.145+00	\N	\N	2021-11-08 10:19:04.472+00	2021-11-08 10:19:04.539+00
1789	\N	died	2021-11-08 10:18:36.157+00	\N	\N	2021-11-08 10:19:04.536+00	2021-11-08 10:19:04.737+00
1794	\N	died	2021-11-08 10:18:36.164+00	\N	\N	2021-11-08 10:19:04.733+00	2021-11-08 10:19:04.88+00
1800	\N	died	2021-11-08 10:18:36.19+00	\N	\N	2021-11-08 10:19:04.877+00	2021-11-08 10:19:05.111+00
2192	\N	died	2021-11-08 10:18:37.948+00	\N	\N	2021-11-08 10:19:13.968+00	2021-11-08 10:19:14.238+00
1810	\N	died	2021-11-08 10:18:36.215+00	\N	\N	2021-11-08 10:19:05.093+00	2021-11-08 10:19:05.634+00
1830	\N	died	2021-11-08 10:18:36.261+00	\N	\N	2021-11-08 10:19:05.516+00	2021-11-08 10:19:05.734+00
1840	\N	died	2021-11-08 10:18:36.282+00	\N	\N	2021-11-08 10:19:05.73+00	2021-11-08 10:19:05.863+00
2204	\N	died	2021-11-08 10:18:37.998+00	\N	\N	2021-11-08 10:19:14.221+00	2021-11-08 10:19:14.541+00
1846	\N	died	2021-11-08 10:18:36.298+00	\N	\N	2021-11-08 10:19:05.825+00	2021-11-08 10:19:06.131+00
2379	\N	died	2021-11-08 10:18:39.087+00	\N	\N	2021-11-08 10:19:17.714+00	2021-11-08 10:19:17.768+00
1859	\N	died	2021-11-08 10:18:36.338+00	\N	\N	2021-11-08 10:19:06.092+00	2021-11-08 10:19:06.265+00
1865	\N	died	2021-11-08 10:18:36.363+00	\N	\N	2021-11-08 10:19:06.26+00	2021-11-08 10:19:06.809+00
2216	\N	died	2021-11-08 10:18:38.042+00	\N	\N	2021-11-08 10:19:14.49+00	2021-11-08 10:19:15.133+00
1875	\N	died	2021-11-08 10:18:36.4+00	\N	\N	2021-11-08 10:19:06.674+00	2021-11-08 10:19:07.046+00
3632	\N	died	2021-11-08 10:18:45.753+00	\N	\N	2021-11-08 10:19:45.758+00	2021-11-08 10:19:45.977+00
1890	\N	died	2021-11-08 10:18:36.447+00	\N	\N	2021-11-08 10:19:07.026+00	2021-11-08 10:19:07.335+00
1903	\N	died	2021-11-08 10:18:36.648+00	\N	\N	2021-11-08 10:19:07.331+00	2021-11-08 10:19:07.509+00
2237	\N	died	2021-11-08 10:18:38.192+00	\N	\N	2021-11-08 10:19:15.095+00	2021-11-08 10:19:15.38+00
1908	\N	died	2021-11-08 10:18:36.684+00	\N	\N	2021-11-08 10:19:07.418+00	2021-11-08 10:19:07.77+00
1921	\N	died	2021-11-08 10:18:36.754+00	\N	\N	2021-11-08 10:19:07.754+00	2021-11-08 10:19:08.112+00
1938	\N	died	2021-11-08 10:18:36.819+00	\N	\N	2021-11-08 10:19:08.093+00	2021-11-08 10:19:08.578+00
2254	\N	died	2021-11-08 10:18:38.27+00	\N	\N	2021-11-08 10:19:15.375+00	2021-11-08 10:19:15.461+00
1957	\N	died	2021-11-08 10:18:36.975+00	\N	\N	2021-11-08 10:19:08.543+00	2021-11-08 10:19:09.023+00
2382	\N	died	2021-11-08 10:18:39.102+00	\N	\N	2021-11-08 10:19:17.763+00	2021-11-08 10:19:17.829+00
1973	\N	died	2021-11-08 10:18:37.029+00	\N	\N	2021-11-08 10:19:08.864+00	2021-11-08 10:19:09.141+00
1986	\N	died	2021-11-08 10:18:37.096+00	\N	\N	2021-11-08 10:19:09.136+00	2021-11-08 10:19:09.341+00
2260	\N	died	2021-11-08 10:18:38.293+00	\N	\N	2021-11-08 10:19:15.457+00	2021-11-08 10:19:15.551+00
1995	\N	died	2021-11-08 10:18:37.149+00	\N	\N	2021-11-08 10:19:09.337+00	2021-11-08 10:19:09.564+00
3735	\N	died	2021-11-08 10:18:48.147+00	\N	\N	2021-11-08 10:19:48.087+00	2021-11-08 10:19:48.17+00
2005	\N	died	2021-11-08 10:18:37.193+00	\N	\N	2021-11-08 10:19:09.559+00	2021-11-08 10:19:09.69+00
2008	\N	died	2021-11-08 10:18:37.205+00	\N	\N	2021-11-08 10:19:09.613+00	2021-11-08 10:19:10.255+00
2262	\N	died	2021-11-08 10:18:38.306+00	\N	\N	2021-11-08 10:19:15.547+00	2021-11-08 10:19:15.618+00
2015	\N	died	2021-11-08 10:18:37.243+00	\N	\N	2021-11-08 10:19:10.186+00	2021-11-08 10:19:10.39+00
2025	\N	died	2021-11-08 10:18:37.272+00	\N	\N	2021-11-08 10:19:10.386+00	2021-11-08 10:19:10.493+00
2031	\N	died	2021-11-08 10:18:37.29+00	\N	\N	2021-11-08 10:19:10.478+00	2021-11-08 10:19:10.814+00
2266	\N	died	2021-11-08 10:18:38.331+00	\N	\N	2021-11-08 10:19:15.614+00	2021-11-08 10:19:15.884+00
2042	\N	died	2021-11-08 10:18:37.316+00	\N	\N	2021-11-08 10:19:10.708+00	2021-11-08 10:19:11.166+00
2386	\N	died	2021-11-08 10:18:39.113+00	\N	\N	2021-11-08 10:19:17.825+00	2021-11-08 10:19:17.981+00
2060	\N	died	2021-11-08 10:18:37.384+00	\N	\N	2021-11-08 10:19:11.114+00	2021-11-08 10:19:11.371+00
2069	\N	died	2021-11-08 10:18:37.408+00	\N	\N	2021-11-08 10:19:11.317+00	2021-11-08 10:19:11.618+00
2271	\N	died	2021-11-08 10:18:38.349+00	\N	\N	2021-11-08 10:19:15.695+00	2021-11-08 10:19:15.928+00
2082	\N	died	2021-11-08 10:18:37.51+00	\N	\N	2021-11-08 10:19:11.614+00	2021-11-08 10:19:11.793+00
2086	\N	died	2021-11-08 10:18:37.528+00	\N	\N	2021-11-08 10:19:11.678+00	2021-11-08 10:19:12.09+00
2101	\N	died	2021-11-08 10:18:37.598+00	\N	\N	2021-11-08 10:19:12.034+00	2021-11-08 10:19:12.368+00
2282	\N	died	2021-11-08 10:18:38.402+00	\N	\N	2021-11-08 10:19:15.924+00	2021-11-08 10:19:16.016+00
2116	\N	died	2021-11-08 10:18:37.675+00	\N	\N	2021-11-08 10:19:12.345+00	2021-11-08 10:19:12.721+00
2132	\N	died	2021-11-08 10:18:37.728+00	\N	\N	2021-11-08 10:19:12.703+00	2021-11-08 10:19:13.099+00
2392	\N	died	2021-11-08 10:18:39.131+00	\N	\N	2021-11-08 10:19:17.976+00	2021-11-08 10:19:18.037+00
2150	\N	died	2021-11-08 10:18:37.79+00	\N	\N	2021-11-08 10:19:13.061+00	2021-11-08 10:19:13.54+00
3640	\N	died	2021-11-08 10:18:46.018+00	\N	\N	2021-11-08 10:19:45.972+00	2021-11-08 10:19:46.228+00
2169	\N	died	2021-11-08 10:18:37.859+00	\N	\N	2021-11-08 10:19:13.482+00	2021-11-08 10:19:13.639+00
2175	\N	died	2021-11-08 10:18:37.881+00	\N	\N	2021-11-08 10:19:13.634+00	2021-11-08 10:19:13.745+00
2396	\N	died	2021-11-08 10:18:39.148+00	\N	\N	2021-11-08 10:19:18.034+00	2021-11-08 10:19:18.072+00
2180	\N	died	2021-11-08 10:18:37.901+00	\N	\N	2021-11-08 10:19:13.707+00	2021-11-08 10:19:14.022+00
2285	\N	died	2021-11-08 10:18:38.413+00	\N	\N	2021-11-08 10:19:15.978+00	2021-11-08 10:19:16.206+00
2295	\N	died	2021-11-08 10:18:38.488+00	\N	\N	2021-11-08 10:19:16.154+00	2021-11-08 10:19:16.479+00
2315	\N	died	2021-11-08 10:18:38.579+00	\N	\N	2021-11-08 10:19:16.474+00	2021-11-08 10:19:16.708+00
2398	\N	died	2021-11-08 10:18:39.154+00	\N	\N	2021-11-08 10:19:18.068+00	2021-11-08 10:19:18.199+00
2321	\N	died	2021-11-08 10:18:38.597+00	\N	\N	2021-11-08 10:19:16.62+00	2021-11-08 10:19:16.883+00
2334	\N	died	2021-11-08 10:18:38.65+00	\N	\N	2021-11-08 10:19:16.833+00	2021-11-08 10:19:17.021+00
2343	\N	died	2021-11-08 10:18:38.697+00	\N	\N	2021-11-08 10:19:16.98+00	2021-11-08 10:19:17.314+00
3647	\N	died	2021-11-08 10:18:46.154+00	\N	\N	2021-11-08 10:19:46.089+00	2021-11-08 10:19:46.337+00
2351	\N	died	2021-11-08 10:18:38.941+00	\N	\N	2021-11-08 10:19:17.29+00	2021-11-08 10:19:17.354+00
2358	\N	died	2021-11-08 10:18:38.981+00	\N	\N	2021-11-08 10:19:17.346+00	2021-11-08 10:19:17.39+00
2360	\N	died	2021-11-08 10:18:38.99+00	\N	\N	2021-11-08 10:19:17.385+00	2021-11-08 10:19:17.476+00
3658	\N	died	2021-11-08 10:18:46.331+00	\N	\N	2021-11-08 10:19:46.331+00	2021-11-08 10:19:46.57+00
2365	\N	died	2021-11-08 10:18:39.014+00	\N	\N	2021-11-08 10:19:17.472+00	2021-11-08 10:19:17.548+00
3738	\N	died	2021-11-08 10:18:48.18+00	\N	\N	2021-11-08 10:19:48.133+00	2021-11-08 10:19:48.37+00
2369	\N	died	2021-11-08 10:18:39.029+00	\N	\N	2021-11-08 10:19:17.543+00	2021-11-08 10:19:17.718+00
2402	\N	died	2021-11-08 10:18:39.165+00	\N	\N	2021-11-08 10:19:18.194+00	2021-11-08 10:19:18.267+00
2406	\N	died	2021-11-08 10:18:39.178+00	\N	\N	2021-11-08 10:19:18.263+00	2021-11-08 10:19:18.333+00
3668	\N	died	2021-11-08 10:18:46.556+00	\N	\N	2021-11-08 10:19:46.549+00	2021-11-08 10:19:46.695+00
2410	\N	died	2021-11-08 10:18:39.191+00	\N	\N	2021-11-08 10:19:18.329+00	2021-11-08 10:19:18.459+00
3779	\N	died	2021-11-08 10:18:49.289+00	\N	\N	2021-11-08 10:19:49.057+00	2021-11-08 10:19:49.338+00
2415	\N	died	2021-11-08 10:18:39.203+00	\N	\N	2021-11-08 10:19:18.455+00	2021-11-08 10:19:18.538+00
2420	\N	died	2021-11-08 10:18:39.216+00	\N	\N	2021-11-08 10:19:18.534+00	2021-11-08 10:19:18.674+00
3673	\N	died	2021-11-08 10:18:46.697+00	\N	\N	2021-11-08 10:19:46.69+00	2021-11-08 10:19:46.836+00
2425	\N	died	2021-11-08 10:18:39.233+00	\N	\N	2021-11-08 10:19:18.666+00	2021-11-08 10:19:18.754+00
2430	\N	died	2021-11-08 10:18:39.246+00	\N	\N	2021-11-08 10:19:18.75+00	2021-11-08 10:19:18.792+00
2432	\N	died	2021-11-08 10:18:39.253+00	\N	\N	2021-11-08 10:19:18.788+00	2021-11-08 10:19:18.856+00
3678	\N	died	2021-11-08 10:18:46.794+00	\N	\N	2021-11-08 10:19:46.782+00	2021-11-08 10:19:47.318+00
2436	\N	died	2021-11-08 10:18:39.26+00	\N	\N	2021-11-08 10:19:18.851+00	2021-11-08 10:19:18.991+00
3748	\N	died	2021-11-08 10:18:48.43+00	\N	\N	2021-11-08 10:19:48.349+00	2021-11-08 10:19:48.778+00
2444	\N	died	2021-11-08 10:18:39.285+00	\N	\N	2021-11-08 10:19:18.987+00	2021-11-08 10:19:19.105+00
3698	\N	died	2021-11-08 10:18:47.333+00	\N	\N	2021-11-08 10:19:47.265+00	2021-11-08 10:19:47.637+00
3848	\N	died	2021-11-08 10:18:51.396+00	\N	\N	2021-11-08 10:19:50.49+00	2021-11-08 10:19:50.628+00
3714	\N	died	2021-11-08 10:18:47.63+00	\N	\N	2021-11-08 10:19:47.631+00	2021-11-08 10:19:47.985+00
3724	\N	died	2021-11-08 10:18:47.879+00	\N	\N	2021-11-08 10:19:47.848+00	2021-11-08 10:19:48.091+00
3796	\N	died	2021-11-08 10:18:49.789+00	\N	\N	2021-11-08 10:19:49.334+00	2021-11-08 10:19:49.545+00
3765	\N	died	2021-11-08 10:18:48.889+00	\N	\N	2021-11-08 10:19:48.774+00	2021-11-08 10:19:48.863+00
3822	\N	died	2021-11-08 10:18:50.603+00	\N	\N	2021-11-08 10:19:49.924+00	2021-11-08 10:19:50.244+00
3770	\N	died	2021-11-08 10:18:49.023+00	\N	\N	2021-11-08 10:19:48.859+00	2021-11-08 10:19:49.128+00
3851	\N	died	2021-11-08 10:18:51.539+00	\N	\N	2021-11-08 10:19:50.541+00	2021-11-08 10:19:50.938+00
3804	\N	died	2021-11-08 10:18:50.032+00	\N	\N	2021-11-08 10:19:49.523+00	2021-11-08 10:19:49.98+00
3838	\N	died	2021-11-08 10:18:51.106+00	\N	\N	2021-11-08 10:19:50.241+00	2021-11-08 10:19:50.494+00
5553	\N	died	2021-11-08 10:19:49.089+00	\N	\N	2021-11-08 10:20:37.647+00	2021-11-08 10:20:37.856+00
3861	\N	died	2021-11-08 10:18:51.805+00	\N	\N	2021-11-08 10:19:50.849+00	2021-11-08 10:19:51.14+00
3874	\N	died	2021-11-08 10:18:52.272+00	\N	\N	2021-11-08 10:19:51.118+00	2021-11-08 10:19:51.586+00
3896	\N	died	2021-11-08 10:18:53.217+00	\N	\N	2021-11-08 10:19:51.582+00	2021-11-08 10:19:51.844+00
3906	\N	died	2021-11-08 10:18:53.598+00	\N	\N	2021-11-08 10:19:51.84+00	2021-11-08 10:19:51.878+00
3908	\N	died	2021-11-08 10:18:53.631+00	\N	\N	2021-11-08 10:19:51.874+00	2021-11-08 10:19:51.912+00
5562	\N	died	2021-11-08 10:19:49.24+00	\N	\N	2021-11-08 10:20:37.842+00	2021-11-08 10:20:37.893+00
3910	\N	died	2021-11-08 10:18:53.68+00	\N	\N	2021-11-08 10:19:51.908+00	2021-11-08 10:19:52.028+00
5564	\N	died	2021-11-08 10:19:49.257+00	\N	\N	2021-11-08 10:20:37.889+00	2021-11-08 10:20:37.917+00
5566	\N	died	2021-11-08 10:19:49.275+00	\N	\N	2021-11-08 10:20:37.913+00	2021-11-08 10:20:38.02+00
1854	\N	died	2021-11-08 10:18:36.321+00	\N	\N	2021-11-08 10:19:06.005+00	2021-11-08 10:19:06.079+00
1858	\N	died	2021-11-08 10:18:36.333+00	\N	\N	2021-11-08 10:19:06.072+00	2021-11-08 10:19:06.131+00
1861	\N	died	2021-11-08 10:18:36.351+00	\N	\N	2021-11-08 10:19:06.126+00	2021-11-08 10:19:06.215+00
1863	\N	died	2021-11-08 10:18:36.357+00	\N	\N	2021-11-08 10:19:06.212+00	2021-11-08 10:19:06.615+00
2217	\N	died	2021-11-08 10:18:38.073+00	\N	\N	2021-11-08 10:19:14.534+00	2021-11-08 10:19:14.614+00
1871	\N	died	2021-11-08 10:18:36.379+00	\N	\N	2021-11-08 10:19:06.611+00	2021-11-08 10:19:06.843+00
3674	\N	died	2021-11-08 10:18:46.706+00	\N	\N	2021-11-08 10:19:46.706+00	2021-11-08 10:19:46.836+00
1881	\N	died	2021-11-08 10:18:36.418+00	\N	\N	2021-11-08 10:19:06.827+00	2021-11-08 10:19:06.93+00
1886	\N	died	2021-11-08 10:18:36.43+00	\N	\N	2021-11-08 10:19:06.905+00	2021-11-08 10:19:07.173+00
2220	\N	died	2021-11-08 10:18:38.095+00	\N	\N	2021-11-08 10:19:14.61+00	2021-11-08 10:19:14.65+00
1894	\N	died	2021-11-08 10:18:36.508+00	\N	\N	2021-11-08 10:19:07.133+00	2021-11-08 10:19:07.509+00
3794	\N	died	2021-11-08 10:18:49.696+00	\N	\N	2021-11-08 10:19:49.305+00	2021-11-08 10:19:49.697+00
1909	\N	died	2021-11-08 10:18:36.685+00	\N	\N	2021-11-08 10:19:07.43+00	2021-11-08 10:19:07.79+00
1923	\N	died	2021-11-08 10:18:36.761+00	\N	\N	2021-11-08 10:19:07.785+00	2021-11-08 10:19:07.87+00
2222	\N	died	2021-11-08 10:18:38.105+00	\N	\N	2021-11-08 10:19:14.645+00	2021-11-08 10:19:14.841+00
1928	\N	died	2021-11-08 10:18:36.771+00	\N	\N	2021-11-08 10:19:07.864+00	2021-11-08 10:19:08.112+00
1937	\N	died	2021-11-08 10:18:36.813+00	\N	\N	2021-11-08 10:19:08.073+00	2021-11-08 10:19:08.514+00
1955	\N	died	2021-11-08 10:18:36.958+00	\N	\N	2021-11-08 10:19:08.511+00	2021-11-08 10:19:08.631+00
2226	\N	died	2021-11-08 10:18:38.145+00	\N	\N	2021-11-08 10:19:14.714+00	2021-11-08 10:19:15.229+00
1960	\N	died	2021-11-08 10:18:36.985+00	\N	\N	2021-11-08 10:19:08.594+00	2021-11-08 10:19:08.809+00
3680	\N	died	2021-11-08 10:18:46.838+00	\N	\N	2021-11-08 10:19:46.833+00	2021-11-08 10:19:46.97+00
1968	\N	died	2021-11-08 10:18:37.013+00	\N	\N	2021-11-08 10:19:08.784+00	2021-11-08 10:19:09.023+00
1978	\N	died	2021-11-08 10:18:37.069+00	\N	\N	2021-11-08 10:19:09.001+00	2021-11-08 10:19:09.543+00
2244	\N	died	2021-11-08 10:18:38.23+00	\N	\N	2021-11-08 10:19:15.212+00	2021-11-08 10:19:15.461+00
1996	\N	died	2021-11-08 10:18:37.155+00	\N	\N	2021-11-08 10:19:09.354+00	2021-11-08 10:19:09.601+00
3891	\N	died	2021-11-08 10:18:52.939+00	\N	\N	2021-11-08 10:19:51.449+00	2021-11-08 10:19:51.844+00
2007	\N	died	2021-11-08 10:18:37.198+00	\N	\N	2021-11-08 10:19:09.597+00	2021-11-08 10:19:10.157+00
2011	\N	died	2021-11-08 10:18:37.219+00	\N	\N	2021-11-08 10:19:09.719+00	2021-11-08 10:19:10.368+00
2258	\N	died	2021-11-08 10:18:38.281+00	\N	\N	2021-11-08 10:19:15.432+00	2021-11-08 10:19:15.884+00
2023	\N	died	2021-11-08 10:18:37.267+00	\N	\N	2021-11-08 10:19:10.352+00	2021-11-08 10:19:10.814+00
2038	\N	died	2021-11-08 10:18:37.31+00	\N	\N	2021-11-08 10:19:10.639+00	2021-11-08 10:19:10.881+00
2049	\N	died	2021-11-08 10:18:37.335+00	\N	\N	2021-11-08 10:19:10.877+00	2021-11-08 10:19:11.028+00
2272	\N	died	2021-11-08 10:18:38.349+00	\N	\N	2021-11-08 10:19:15.708+00	2021-11-08 10:19:16.016+00
2053	\N	died	2021-11-08 10:18:37.35+00	\N	\N	2021-11-08 10:19:10.94+00	2021-11-08 10:19:11.286+00
3684	\N	died	2021-11-08 10:18:47.009+00	\N	\N	2021-11-08 10:19:46.966+00	2021-11-08 10:19:47.052+00
2067	\N	died	2021-11-08 10:18:37.4+00	\N	\N	2021-11-08 10:19:11.282+00	2021-11-08 10:19:11.457+00
2074	\N	died	2021-11-08 10:18:37.43+00	\N	\N	2021-11-08 10:19:11.408+00	2021-11-08 10:19:11.793+00
2286	\N	died	2021-11-08 10:18:38.42+00	\N	\N	2021-11-08 10:19:15.997+00	2021-11-08 10:19:16.206+00
2088	\N	died	2021-11-08 10:18:37.545+00	\N	\N	2021-11-08 10:19:11.77+00	2021-11-08 10:19:12.103+00
2105	\N	died	2021-11-08 10:18:37.619+00	\N	\N	2021-11-08 10:19:12.099+00	2021-11-08 10:19:12.293+00
2109	\N	died	2021-11-08 10:18:37.638+00	\N	\N	2021-11-08 10:19:12.165+00	2021-11-08 10:19:12.54+00
2297	\N	died	2021-11-08 10:18:38.494+00	\N	\N	2021-11-08 10:19:16.183+00	2021-11-08 10:19:16.539+00
2119	\N	died	2021-11-08 10:18:37.688+00	\N	\N	2021-11-08 10:19:12.395+00	2021-11-08 10:19:12.623+00
2130	\N	died	2021-11-08 10:18:37.721+00	\N	\N	2021-11-08 10:19:12.618+00	2021-11-08 10:19:12.792+00
2135	\N	died	2021-11-08 10:18:37.734+00	\N	\N	2021-11-08 10:19:12.749+00	2021-11-08 10:19:13.099+00
2319	\N	died	2021-11-08 10:18:38.591+00	\N	\N	2021-11-08 10:19:16.535+00	2021-11-08 10:19:16.771+00
2148	\N	died	2021-11-08 10:18:37.778+00	\N	\N	2021-11-08 10:19:13.025+00	2021-11-08 10:19:13.478+00
3688	\N	died	2021-11-08 10:18:47.035+00	\N	\N	2021-11-08 10:19:47.037+00	2021-11-08 10:19:47.318+00
2165	\N	died	2021-11-08 10:18:37.847+00	\N	\N	2021-11-08 10:19:13.417+00	2021-11-08 10:19:13.766+00
2183	\N	died	2021-11-08 10:18:37.913+00	\N	\N	2021-11-08 10:19:13.762+00	2021-11-08 10:19:13.894+00
3808	\N	died	2021-11-08 10:18:50.149+00	\N	\N	2021-11-08 10:19:49.643+00	2021-11-08 10:19:49.98+00
2187	\N	died	2021-11-08 10:18:37.926+00	\N	\N	2021-11-08 10:19:13.887+00	2021-11-08 10:19:14.108+00
2197	\N	died	2021-11-08 10:18:37.963+00	\N	\N	2021-11-08 10:19:14.1+00	2021-11-08 10:19:14.238+00
3695	\N	died	2021-11-08 10:18:47.263+00	\N	\N	2021-11-08 10:19:47.217+00	2021-11-08 10:19:47.458+00
2203	\N	died	2021-11-08 10:18:37.992+00	\N	\N	2021-11-08 10:19:14.204+00	2021-11-08 10:19:14.541+00
2328	\N	died	2021-11-08 10:18:38.623+00	\N	\N	2021-11-08 10:19:16.738+00	2021-11-08 10:19:16.883+00
5557	\N	died	2021-11-08 10:19:49.139+00	\N	\N	2021-11-08 10:20:37.705+00	2021-11-08 10:20:38.04+00
2336	\N	died	2021-11-08 10:18:38.659+00	\N	\N	2021-11-08 10:19:16.862+00	2021-11-08 10:19:17.314+00
2353	\N	died	2021-11-08 10:18:38.952+00	\N	\N	2021-11-08 10:19:17.304+00	2021-11-08 10:19:17.494+00
3706	\N	died	2021-11-08 10:18:47.449+00	\N	\N	2021-11-08 10:19:47.45+00	2021-11-08 10:19:47.501+00
2366	\N	died	2021-11-08 10:18:39.017+00	\N	\N	2021-11-08 10:19:17.486+00	2021-11-08 10:19:17.697+00
2375	\N	died	2021-11-08 10:18:39.062+00	\N	\N	2021-11-08 10:19:17.644+00	2021-11-08 10:19:17.981+00
2391	\N	died	2021-11-08 10:18:39.131+00	\N	\N	2021-11-08 10:19:17.963+00	2021-11-08 10:19:18.459+00
3709	\N	died	2021-11-08 10:18:47.497+00	\N	\N	2021-11-08 10:19:47.496+00	2021-11-08 10:19:47.657+00
2413	\N	died	2021-11-08 10:18:39.197+00	\N	\N	2021-11-08 10:19:18.425+00	2021-11-08 10:19:18.674+00
3820	\N	died	2021-11-08 10:18:50.579+00	\N	\N	2021-11-08 10:19:49.891+00	2021-11-08 10:19:50.477+00
2422	\N	died	2021-11-08 10:18:39.226+00	\N	\N	2021-11-08 10:19:18.618+00	2021-11-08 10:19:18.807+00
2433	\N	died	2021-11-08 10:18:39.253+00	\N	\N	2021-11-08 10:19:18.802+00	2021-11-08 10:19:18.991+00
3715	\N	died	2021-11-08 10:18:47.649+00	\N	\N	2021-11-08 10:19:47.65+00	2021-11-08 10:19:47.985+00
2438	\N	died	2021-11-08 10:18:39.266+00	\N	\N	2021-11-08 10:19:18.884+00	2021-11-08 10:19:19.12+00
2449	\N	died	2021-11-08 10:18:39.293+00	\N	\N	2021-11-08 10:19:19.116+00	2021-11-08 10:19:19.222+00
2453	\N	died	2021-11-08 10:18:39.311+00	\N	\N	2021-11-08 10:19:19.188+00	2021-11-08 10:19:19.672+00
3725	\N	died	2021-11-08 10:18:47.897+00	\N	\N	2021-11-08 10:19:47.868+00	2021-11-08 10:19:48.118+00
2476	\N	died	2021-11-08 10:18:39.365+00	\N	\N	2021-11-08 10:19:19.668+00	2021-11-08 10:19:19.805+00
2481	\N	died	2021-11-08 10:18:39.385+00	\N	\N	2021-11-08 10:19:19.8+00	2021-11-08 10:19:19.882+00
3737	\N	died	2021-11-08 10:18:48.164+00	\N	\N	2021-11-08 10:19:48.114+00	2021-11-08 10:19:48.221+00
2485	\N	died	2021-11-08 10:18:39.397+00	\N	\N	2021-11-08 10:19:19.879+00	2021-11-08 10:19:20.017+00
3840	\N	died	2021-11-08 10:18:51.239+00	\N	\N	2021-11-08 10:19:50.276+00	2021-11-08 10:19:50.628+00
3742	\N	died	2021-11-08 10:18:48.331+00	\N	\N	2021-11-08 10:19:48.202+00	2021-11-08 10:19:48.551+00
3898	\N	died	2021-11-08 10:18:53.372+00	\N	\N	2021-11-08 10:19:51.616+00	2021-11-08 10:19:52.258+00
3753	\N	died	2021-11-08 10:18:48.607+00	\N	\N	2021-11-08 10:19:48.43+00	2021-11-08 10:19:48.849+00
3769	\N	died	2021-11-08 10:18:49.006+00	\N	\N	2021-11-08 10:19:48.844+00	2021-11-08 10:19:49.128+00
3778	\N	died	2021-11-08 10:18:49.272+00	\N	\N	2021-11-08 10:19:49.04+00	2021-11-08 10:19:49.323+00
3925	\N	died	2021-11-08 10:18:54.045+00	\N	\N	2021-11-08 10:19:52.255+00	2021-11-08 10:19:52.336+00
3852	\N	died	2021-11-08 10:18:51.572+00	\N	\N	2021-11-08 10:19:50.607+00	2021-11-08 10:19:50.938+00
3863	\N	died	2021-11-08 10:18:51.841+00	\N	\N	2021-11-08 10:19:50.882+00	2021-11-08 10:19:51.224+00
5572	\N	died	2021-11-08 10:19:49.457+00	\N	\N	2021-11-08 10:20:38.031+00	2021-11-08 10:20:38.443+00
3880	\N	died	2021-11-08 10:18:52.499+00	\N	\N	2021-11-08 10:19:51.22+00	2021-11-08 10:19:51.373+00
3886	\N	died	2021-11-08 10:18:52.723+00	\N	\N	2021-11-08 10:19:51.368+00	2021-11-08 10:19:51.407+00
3888	\N	died	2021-11-08 10:18:52.856+00	\N	\N	2021-11-08 10:19:51.403+00	2021-11-08 10:19:51.454+00
5582	\N	died	2021-11-08 10:19:49.657+00	\N	\N	2021-11-08 10:20:38.4+00	2021-11-08 10:20:38.582+00
5608	\N	died	2021-11-08 10:19:50.007+00	\N	\N	2021-11-08 10:20:39.122+00	2021-11-08 10:20:39.593+00
3930	\N	died	2021-11-08 10:18:54.223+00	\N	\N	2021-11-08 10:19:52.332+00	2021-11-08 10:19:52.362+00
3932	\N	died	2021-11-08 10:18:54.239+00	\N	\N	2021-11-08 10:19:52.357+00	2021-11-08 10:19:52.496+00
5588	\N	died	2021-11-08 10:19:49.74+00	\N	\N	2021-11-08 10:20:38.542+00	2021-11-08 10:20:38.78+00
3937	\N	died	2021-11-08 10:18:54.381+00	\N	\N	2021-11-08 10:19:52.491+00	2021-11-08 10:19:52.579+00
3942	\N	died	2021-11-08 10:18:54.489+00	\N	\N	2021-11-08 10:19:52.575+00	2021-11-08 10:19:52.694+00
5595	\N	died	2021-11-08 10:19:49.796+00	\N	\N	2021-11-08 10:20:38.739+00	2021-11-08 10:20:39.161+00
5664	\N	died	2021-11-08 10:19:51.135+00	\N	\N	2021-11-08 10:20:40.673+00	2021-11-08 10:20:41.06+00
5629	\N	died	2021-11-08 10:19:50.407+00	\N	\N	2021-11-08 10:20:39.573+00	2021-11-08 10:20:40.378+00
5648	\N	died	2021-11-08 10:19:50.865+00	\N	\N	2021-11-08 10:20:40.173+00	2021-11-08 10:20:40.697+00
5689	\N	died	2021-11-08 10:19:51.399+00	\N	\N	2021-11-08 10:20:41.323+00	2021-11-08 10:20:41.827+00
5677	\N	died	2021-11-08 10:19:51.236+00	\N	\N	2021-11-08 10:20:40.997+00	2021-11-08 10:20:41.14+00
5683	\N	died	2021-11-08 10:19:51.331+00	\N	\N	2021-11-08 10:20:41.131+00	2021-11-08 10:20:41.381+00
5702	\N	died	2021-11-08 10:19:51.581+00	\N	\N	2021-11-08 10:20:41.664+00	2021-11-08 10:20:41.889+00
5712	\N	died	2021-11-08 10:19:51.873+00	\N	\N	2021-11-08 10:20:41.875+00	2021-11-08 10:20:41.959+00
1910	\N	died	2021-11-08 10:18:36.691+00	\N	\N	2021-11-08 10:19:07.502+00	2021-11-08 10:19:07.63+00
1917	\N	died	2021-11-08 10:18:36.734+00	\N	\N	2021-11-08 10:19:07.627+00	2021-11-08 10:19:07.662+00
2278	\N	died	2021-11-08 10:18:38.389+00	\N	\N	2021-11-08 10:19:15.861+00	2021-11-08 10:19:16.206+00
1919	\N	died	2021-11-08 10:18:36.741+00	\N	\N	2021-11-08 10:19:07.655+00	2021-11-08 10:19:07.836+00
1924	\N	died	2021-11-08 10:18:36.761+00	\N	\N	2021-11-08 10:19:07.799+00	2021-11-08 10:19:08.112+00
1936	\N	died	2021-11-08 10:18:36.813+00	\N	\N	2021-11-08 10:19:08.061+00	2021-11-08 10:19:08.498+00
2298	\N	died	2021-11-08 10:18:38.506+00	\N	\N	2021-11-08 10:19:16.201+00	2021-11-08 10:19:16.261+00
1953	\N	died	2021-11-08 10:18:36.947+00	\N	\N	2021-11-08 10:19:08.427+00	2021-11-08 10:19:09.023+00
1971	\N	died	2021-11-08 10:18:37.023+00	\N	\N	2021-11-08 10:19:08.831+00	2021-11-08 10:19:09.089+00
1982	\N	died	2021-11-08 10:18:37.08+00	\N	\N	2021-11-08 10:19:09.067+00	2021-11-08 10:19:09.239+00
2302	\N	died	2021-11-08 10:18:38.523+00	\N	\N	2021-11-08 10:19:16.258+00	2021-11-08 10:19:16.297+00
1989	\N	died	2021-11-08 10:18:37.111+00	\N	\N	2021-11-08 10:19:09.235+00	2021-11-08 10:19:09.543+00
2492	\N	died	2021-11-08 10:18:39.413+00	\N	\N	2021-11-08 10:19:20.038+00	2021-11-08 10:19:20.307+00
1999	\N	died	2021-11-08 10:18:37.17+00	\N	\N	2021-11-08 10:19:09.46+00	2021-11-08 10:19:10.169+00
2014	\N	died	2021-11-08 10:18:37.238+00	\N	\N	2021-11-08 10:19:10.165+00	2021-11-08 10:19:10.281+00
2304	\N	died	2021-11-08 10:18:38.529+00	\N	\N	2021-11-08 10:19:16.293+00	2021-11-08 10:19:16.365+00
2021	\N	died	2021-11-08 10:18:37.261+00	\N	\N	2021-11-08 10:19:10.277+00	2021-11-08 10:19:10.456+00
3803	\N	died	2021-11-08 10:18:50.03+00	\N	\N	2021-11-08 10:19:49.507+00	2021-11-08 10:19:49.745+00
2027	\N	died	2021-11-08 10:18:37.277+00	\N	\N	2021-11-08 10:19:10.419+00	2021-11-08 10:19:10.864+00
2046	\N	died	2021-11-08 10:18:37.329+00	\N	\N	2021-11-08 10:19:10.827+00	2021-11-08 10:19:10.918+00
2308	\N	died	2021-11-08 10:18:38.549+00	\N	\N	2021-11-08 10:19:16.358+00	2021-11-08 10:19:16.501+00
2051	\N	died	2021-11-08 10:18:37.344+00	\N	\N	2021-11-08 10:19:10.913+00	2021-11-08 10:19:11.098+00
2057	\N	died	2021-11-08 10:18:37.365+00	\N	\N	2021-11-08 10:19:11.057+00	2021-11-08 10:19:11.371+00
2071	\N	died	2021-11-08 10:18:37.416+00	\N	\N	2021-11-08 10:19:11.356+00	2021-11-08 10:19:11.807+00
2316	\N	died	2021-11-08 10:18:38.585+00	\N	\N	2021-11-08 10:19:16.496+00	2021-11-08 10:19:16.708+00
2090	\N	died	2021-11-08 10:18:37.558+00	\N	\N	2021-11-08 10:19:11.803+00	2021-11-08 10:19:11.876+00
2505	\N	died	2021-11-08 10:18:39.459+00	\N	\N	2021-11-08 10:19:20.301+00	2021-11-08 10:19:20.445+00
2093	\N	died	2021-11-08 10:18:37.572+00	\N	\N	2021-11-08 10:19:11.852+00	2021-11-08 10:19:12.124+00
2106	\N	died	2021-11-08 10:18:37.626+00	\N	\N	2021-11-08 10:19:12.12+00	2021-11-08 10:19:12.293+00
2323	\N	died	2021-11-08 10:18:38.602+00	\N	\N	2021-11-08 10:19:16.654+00	2021-11-08 10:19:17.03+00
2111	\N	died	2021-11-08 10:18:37.645+00	\N	\N	2021-11-08 10:19:12.251+00	2021-11-08 10:19:12.54+00
2122	\N	died	2021-11-08 10:18:37.694+00	\N	\N	2021-11-08 10:19:12.483+00	2021-11-08 10:19:12.837+00
2140	\N	died	2021-11-08 10:18:37.748+00	\N	\N	2021-11-08 10:19:12.833+00	2021-11-08 10:19:13.099+00
2346	\N	died	2021-11-08 10:18:38.709+00	\N	\N	2021-11-08 10:19:17.026+00	2021-11-08 10:19:17.314+00
2147	\N	died	2021-11-08 10:18:37.772+00	\N	\N	2021-11-08 10:19:13.003+00	2021-11-08 10:19:13.27+00
2159	\N	died	2021-11-08 10:18:37.824+00	\N	\N	2021-11-08 10:19:13.266+00	2021-11-08 10:19:13.478+00
2166	\N	died	2021-11-08 10:18:37.853+00	\N	\N	2021-11-08 10:19:13.437+00	2021-11-08 10:19:14.022+00
2352	\N	died	2021-11-08 10:18:38.944+00	\N	\N	2021-11-08 10:19:17.297+00	2021-11-08 10:19:17.476+00
2188	\N	died	2021-11-08 10:18:37.932+00	\N	\N	2021-11-08 10:19:13.906+00	2021-11-08 10:19:14.238+00
2510	\N	died	2021-11-08 10:18:39.488+00	\N	\N	2021-11-08 10:19:20.442+00	2021-11-08 10:19:20.513+00
2200	\N	died	2021-11-08 10:18:37.975+00	\N	\N	2021-11-08 10:19:14.153+00	2021-11-08 10:19:14.541+00
2211	\N	died	2021-11-08 10:18:38.016+00	\N	\N	2021-11-08 10:19:14.4+00	2021-11-08 10:19:14.666+00
2362	\N	died	2021-11-08 10:18:38.999+00	\N	\N	2021-11-08 10:19:17.419+00	2021-11-08 10:19:17.697+00
2223	\N	died	2021-11-08 10:18:38.109+00	\N	\N	2021-11-08 10:19:14.662+00	2021-11-08 10:19:14.841+00
3697	\N	died	2021-11-08 10:18:47.329+00	\N	\N	2021-11-08 10:19:47.255+00	2021-11-08 10:19:47.552+00
2228	\N	died	2021-11-08 10:18:38.154+00	\N	\N	2021-11-08 10:19:14.746+00	2021-11-08 10:19:15.149+00
2240	\N	died	2021-11-08 10:18:38.214+00	\N	\N	2021-11-08 10:19:15.146+00	2021-11-08 10:19:15.229+00
2373	\N	died	2021-11-08 10:18:39.043+00	\N	\N	2021-11-08 10:19:17.611+00	2021-11-08 10:19:17.829+00
2243	\N	died	2021-11-08 10:18:38.224+00	\N	\N	2021-11-08 10:19:15.194+00	2021-11-08 10:19:15.367+00
2251	\N	died	2021-11-08 10:18:38.258+00	\N	\N	2021-11-08 10:19:15.328+00	2021-11-08 10:19:15.566+00
2263	\N	died	2021-11-08 10:18:38.311+00	\N	\N	2021-11-08 10:19:15.562+00	2021-11-08 10:19:15.649+00
2514	\N	died	2021-11-08 10:18:39.502+00	\N	\N	2021-11-08 10:19:20.508+00	2021-11-08 10:19:20.583+00
2268	\N	died	2021-11-08 10:18:38.337+00	\N	\N	2021-11-08 10:19:15.645+00	2021-11-08 10:19:15.884+00
3865	\N	died	2021-11-08 10:18:51.955+00	\N	\N	2021-11-08 10:19:50.917+00	2021-11-08 10:19:51.373+00
2385	\N	died	2021-11-08 10:18:39.113+00	\N	\N	2021-11-08 10:19:17.812+00	2021-11-08 10:19:18.091+00
2399	\N	died	2021-11-08 10:18:39.16+00	\N	\N	2021-11-08 10:19:18.087+00	2021-11-08 10:19:18.267+00
2518	\N	died	2021-11-08 10:18:39.514+00	\N	\N	2021-11-08 10:19:20.578+00	2021-11-08 10:19:20.731+00
2404	\N	died	2021-11-08 10:18:39.171+00	\N	\N	2021-11-08 10:19:18.229+00	2021-11-08 10:19:18.558+00
2421	\N	died	2021-11-08 10:18:39.226+00	\N	\N	2021-11-08 10:19:18.555+00	2021-11-08 10:19:18.754+00
2428	\N	died	2021-11-08 10:18:39.24+00	\N	\N	2021-11-08 10:19:18.716+00	2021-11-08 10:19:19.105+00
2524	\N	died	2021-11-08 10:18:39.531+00	\N	\N	2021-11-08 10:19:20.726+00	2021-11-08 10:19:20.923+00
2445	\N	died	2021-11-08 10:18:39.285+00	\N	\N	2021-11-08 10:19:19.05+00	2021-11-08 10:19:19.153+00
3712	\N	died	2021-11-08 10:18:47.546+00	\N	\N	2021-11-08 10:19:47.547+00	2021-11-08 10:19:47.723+00
2451	\N	died	2021-11-08 10:18:39.304+00	\N	\N	2021-11-08 10:19:19.15+00	2021-11-08 10:19:19.384+00
2457	\N	died	2021-11-08 10:18:39.318+00	\N	\N	2021-11-08 10:19:19.308+00	2021-11-08 10:19:19.523+00
2467	\N	died	2021-11-08 10:18:39.345+00	\N	\N	2021-11-08 10:19:19.517+00	2021-11-08 10:19:19.592+00
3719	\N	died	2021-11-08 10:18:47.72+00	\N	\N	2021-11-08 10:19:47.718+00	2021-11-08 10:19:47.985+00
2471	\N	died	2021-11-08 10:18:39.359+00	\N	\N	2021-11-08 10:19:19.589+00	2021-11-08 10:19:19.656+00
3814	\N	died	2021-11-08 10:18:50.339+00	\N	\N	2021-11-08 10:19:49.741+00	2021-11-08 10:19:49.98+00
2475	\N	died	2021-11-08 10:18:39.365+00	\N	\N	2021-11-08 10:19:19.651+00	2021-11-08 10:19:19.805+00
2479	\N	died	2021-11-08 10:18:39.372+00	\N	\N	2021-11-08 10:19:19.768+00	2021-11-08 10:19:20.091+00
3729	\N	died	2021-11-08 10:18:47.962+00	\N	\N	2021-11-08 10:19:47.931+00	2021-11-08 10:19:48.551+00
2533	\N	died	2021-11-08 10:18:39.573+00	\N	\N	2021-11-08 10:19:20.919+00	2021-11-08 10:19:20.975+00
2536	\N	died	2021-11-08 10:18:39.587+00	\N	\N	2021-11-08 10:19:20.971+00	2021-11-08 10:19:21.007+00
2538	\N	died	2021-11-08 10:18:39.592+00	\N	\N	2021-11-08 10:19:21.003+00	2021-11-08 10:19:21.074+00
3751	\N	died	2021-11-08 10:18:48.588+00	\N	\N	2021-11-08 10:19:48.398+00	2021-11-08 10:19:48.712+00
2542	\N	died	2021-11-08 10:18:39.605+00	\N	\N	2021-11-08 10:19:21.07+00	2021-11-08 10:19:21.182+00
2546	\N	died	2021-11-08 10:18:39.643+00	\N	\N	2021-11-08 10:19:21.178+00	2021-11-08 10:19:21.251+00
2550	\N	died	2021-11-08 10:18:39.655+00	\N	\N	2021-11-08 10:19:21.246+00	2021-11-08 10:19:21.348+00
3763	\N	died	2021-11-08 10:18:48.856+00	\N	\N	2021-11-08 10:19:48.691+00	2021-11-08 10:19:48.929+00
2556	\N	died	2021-11-08 10:18:39.666+00	\N	\N	2021-11-08 10:19:21.343+00	2021-11-08 10:19:21.465+00
2560	\N	died	2021-11-08 10:18:39.681+00	\N	\N	2021-11-08 10:19:21.46+00	2021-11-08 10:19:21.512+00
3774	\N	died	2021-11-08 10:18:49.188+00	\N	\N	2021-11-08 10:19:48.925+00	2021-11-08 10:19:49.162+00
2563	\N	died	2021-11-08 10:18:39.69+00	\N	\N	2021-11-08 10:19:21.508+00	2021-11-08 10:19:21.552+00
3784	\N	died	2021-11-08 10:18:49.471+00	\N	\N	2021-11-08 10:19:49.14+00	2021-11-08 10:19:49.262+00
3850	\N	died	2021-11-08 10:18:51.514+00	\N	\N	2021-11-08 10:19:50.524+00	2021-11-08 10:19:50.661+00
3790	\N	died	2021-11-08 10:18:49.638+00	\N	\N	2021-11-08 10:19:49.242+00	2021-11-08 10:19:49.545+00
3821	\N	died	2021-11-08 10:18:50.599+00	\N	\N	2021-11-08 10:19:49.908+00	2021-11-08 10:19:50.178+00
3884	\N	died	2021-11-08 10:18:52.665+00	\N	\N	2021-11-08 10:19:51.332+00	2021-11-08 10:19:51.844+00
3834	\N	died	2021-11-08 10:18:51.038+00	\N	\N	2021-11-08 10:19:50.174+00	2021-11-08 10:19:50.477+00
3936	\N	died	2021-11-08 10:18:54.348+00	\N	\N	2021-11-08 10:19:52.477+00	2021-11-08 10:19:52.845+00
3839	\N	died	2021-11-08 10:18:51.122+00	\N	\N	2021-11-08 10:19:50.261+00	2021-11-08 10:19:50.528+00
3855	\N	died	2021-11-08 10:18:51.589+00	\N	\N	2021-11-08 10:19:50.657+00	2021-11-08 10:19:50.938+00
3901	\N	died	2021-11-08 10:18:53.544+00	\N	\N	2021-11-08 10:19:51.663+00	2021-11-08 10:19:52.048+00
3915	\N	died	2021-11-08 10:18:53.863+00	\N	\N	2021-11-08 10:19:52.044+00	2021-11-08 10:19:52.245+00
3953	\N	died	2021-11-08 10:18:54.898+00	\N	\N	2021-11-08 10:19:52.807+00	2021-11-08 10:19:53.286+00
3924	\N	died	2021-11-08 10:18:54.043+00	\N	\N	2021-11-08 10:19:52.241+00	2021-11-08 10:19:52.336+00
5571	\N	died	2021-11-08 10:19:49.44+00	\N	\N	2021-11-08 10:20:38.008+00	2021-11-08 10:20:38.443+00
3927	\N	died	2021-11-08 10:18:54.072+00	\N	\N	2021-11-08 10:19:52.282+00	2021-11-08 10:19:52.496+00
3975	\N	died	2021-11-08 10:18:55.589+00	\N	\N	2021-11-08 10:19:53.283+00	2021-11-08 10:19:53.503+00
3985	\N	died	2021-11-08 10:18:55.932+00	\N	\N	2021-11-08 10:19:53.499+00	2021-11-08 10:19:53.54+00
3987	\N	died	2021-11-08 10:18:55.982+00	\N	\N	2021-11-08 10:19:53.532+00	2021-11-08 10:19:53.714+00
5581	\N	died	2021-11-08 10:19:49.656+00	\N	\N	2021-11-08 10:20:38.323+00	2021-11-08 10:20:39.161+00
3989	\N	died	2021-11-08 10:18:55.997+00	\N	\N	2021-11-08 10:19:53.708+00	2021-11-08 10:19:53.777+00
5602	\N	died	2021-11-08 10:19:49.94+00	\N	\N	2021-11-08 10:20:38.99+00	2021-11-08 10:20:39.273+00
5613	\N	died	2021-11-08 10:19:50.123+00	\N	\N	2021-11-08 10:20:39.258+00	2021-11-08 10:20:39.37+00
1964	\N	died	2021-11-08 10:18:36.996+00	\N	\N	2021-11-08 10:19:08.66+00	2021-11-08 10:19:08.823+00
1970	\N	died	2021-11-08 10:18:37.023+00	\N	\N	2021-11-08 10:19:08.819+00	2021-11-08 10:19:09.023+00
3693	\N	died	2021-11-08 10:18:47.179+00	\N	\N	2021-11-08 10:19:47.179+00	2021-11-08 10:19:47.318+00
1979	\N	died	2021-11-08 10:18:37.075+00	\N	\N	2021-11-08 10:19:09.019+00	2021-11-08 10:19:09.054+00
1981	\N	died	2021-11-08 10:18:37.08+00	\N	\N	2021-11-08 10:19:09.05+00	2021-11-08 10:19:09.124+00
2417	\N	died	2021-11-08 10:18:39.209+00	\N	\N	2021-11-08 10:19:18.487+00	2021-11-08 10:19:18.754+00
1985	\N	died	2021-11-08 10:18:37.09+00	\N	\N	2021-11-08 10:19:09.119+00	2021-11-08 10:19:09.306+00
1993	\N	died	2021-11-08 10:18:37.136+00	\N	\N	2021-11-08 10:19:09.303+00	2021-11-08 10:19:09.543+00
2003	\N	died	2021-11-08 10:18:37.187+00	\N	\N	2021-11-08 10:19:09.526+00	2021-11-08 10:19:10.368+00
2429	\N	died	2021-11-08 10:18:39.246+00	\N	\N	2021-11-08 10:19:18.738+00	2021-11-08 10:19:19.105+00
2022	\N	died	2021-11-08 10:18:37.261+00	\N	\N	2021-11-08 10:19:10.34+00	2021-11-08 10:19:10.562+00
2033	\N	died	2021-11-08 10:18:37.29+00	\N	\N	2021-11-08 10:19:10.558+00	2021-11-08 10:19:10.636+00
2037	\N	died	2021-11-08 10:18:37.31+00	\N	\N	2021-11-08 10:19:10.633+00	2021-11-08 10:19:10.864+00
2447	\N	died	2021-11-08 10:18:39.292+00	\N	\N	2021-11-08 10:19:19.087+00	2021-11-08 10:19:19.171+00
2047	\N	died	2021-11-08 10:18:37.329+00	\N	\N	2021-11-08 10:19:10.841+00	2021-11-08 10:19:11.028+00
3701	\N	died	2021-11-08 10:18:47.355+00	\N	\N	2021-11-08 10:19:47.314+00	2021-11-08 10:19:47.438+00
2054	\N	died	2021-11-08 10:18:37.358+00	\N	\N	2021-11-08 10:19:10.963+00	2021-11-08 10:19:11.603+00
2077	\N	died	2021-11-08 10:18:37.471+00	\N	\N	2021-11-08 10:19:11.521+00	2021-11-08 10:19:11.793+00
2452	\N	died	2021-11-08 10:18:39.304+00	\N	\N	2021-11-08 10:19:19.166+00	2021-11-08 10:19:19.384+00
2087	\N	died	2021-11-08 10:18:37.534+00	\N	\N	2021-11-08 10:19:11.697+00	2021-11-08 10:19:12.09+00
2103	\N	died	2021-11-08 10:18:37.613+00	\N	\N	2021-11-08 10:19:12.07+00	2021-11-08 10:19:12.54+00
2120	\N	died	2021-11-08 10:18:37.688+00	\N	\N	2021-11-08 10:19:12.457+00	2021-11-08 10:19:12.792+00
2459	\N	died	2021-11-08 10:18:39.325+00	\N	\N	2021-11-08 10:19:19.347+00	2021-11-08 10:19:19.805+00
2136	\N	died	2021-11-08 10:18:37.735+00	\N	\N	2021-11-08 10:19:12.766+00	2021-11-08 10:19:13.099+00
2149	\N	died	2021-11-08 10:18:37.784+00	\N	\N	2021-11-08 10:19:13.046+00	2021-11-08 10:19:13.478+00
2167	\N	died	2021-11-08 10:18:37.853+00	\N	\N	2021-11-08 10:19:13.449+00	2021-11-08 10:19:14.022+00
2480	\N	died	2021-11-08 10:18:39.385+00	\N	\N	2021-11-08 10:19:19.788+00	2021-11-08 10:19:20.226+00
2190	\N	died	2021-11-08 10:18:37.943+00	\N	\N	2021-11-08 10:19:13.936+00	2021-11-08 10:19:14.238+00
3705	\N	died	2021-11-08 10:18:47.434+00	\N	\N	2021-11-08 10:19:47.434+00	2021-11-08 10:19:47.483+00
2202	\N	died	2021-11-08 10:18:37.986+00	\N	\N	2021-11-08 10:19:14.187+00	2021-11-08 10:19:14.541+00
2212	\N	died	2021-11-08 10:18:38.022+00	\N	\N	2021-11-08 10:19:14.421+00	2021-11-08 10:19:14.841+00
2498	\N	died	2021-11-08 10:18:39.433+00	\N	\N	2021-11-08 10:19:20.185+00	2021-11-08 10:19:20.513+00
2227	\N	died	2021-11-08 10:18:38.15+00	\N	\N	2021-11-08 10:19:14.728+00	2021-11-08 10:19:15.133+00
3841	\N	died	2021-11-08 10:18:51.264+00	\N	\N	2021-11-08 10:19:50.374+00	2021-11-08 10:19:50.643+00
2238	\N	died	2021-11-08 10:18:38.197+00	\N	\N	2021-11-08 10:19:15.113+00	2021-11-08 10:19:15.461+00
2256	\N	died	2021-11-08 10:18:38.275+00	\N	\N	2021-11-08 10:19:15.408+00	2021-11-08 10:19:15.884+00
2513	\N	died	2021-11-08 10:18:39.501+00	\N	\N	2021-11-08 10:19:20.497+00	2021-11-08 10:19:20.74+00
2276	\N	died	2021-11-08 10:18:38.383+00	\N	\N	2021-11-08 10:19:15.831+00	2021-11-08 10:19:16.206+00
2294	\N	died	2021-11-08 10:18:38.482+00	\N	\N	2021-11-08 10:19:16.134+00	2021-11-08 10:19:16.469+00
2309	\N	died	2021-11-08 10:18:38.559+00	\N	\N	2021-11-08 10:19:16.379+00	2021-11-08 10:19:16.708+00
2525	\N	died	2021-11-08 10:18:39.539+00	\N	\N	2021-11-08 10:19:20.735+00	2021-11-08 10:19:20.975+00
2320	\N	died	2021-11-08 10:18:38.591+00	\N	\N	2021-11-08 10:19:16.599+00	2021-11-08 10:19:16.79+00
3707	\N	died	2021-11-08 10:18:47.462+00	\N	\N	2021-11-08 10:19:47.462+00	2021-11-08 10:19:47.623+00
2331	\N	died	2021-11-08 10:18:38.641+00	\N	\N	2021-11-08 10:19:16.785+00	2021-11-08 10:19:16.883+00
2335	\N	died	2021-11-08 10:18:38.655+00	\N	\N	2021-11-08 10:19:16.844+00	2021-11-08 10:19:17.102+00
2535	\N	died	2021-11-08 10:18:39.582+00	\N	\N	2021-11-08 10:19:20.954+00	2021-11-08 10:19:21.182+00
2349	\N	died	2021-11-08 10:18:38.731+00	\N	\N	2021-11-08 10:19:17.08+00	2021-11-08 10:19:17.476+00
2363	\N	died	2021-11-08 10:18:39.005+00	\N	\N	2021-11-08 10:19:17.439+00	2021-11-08 10:19:17.697+00
2371	\N	died	2021-11-08 10:18:39.037+00	\N	\N	2021-11-08 10:19:17.581+00	2021-11-08 10:19:17.779+00
3713	\N	died	2021-11-08 10:18:47.615+00	\N	\N	2021-11-08 10:19:47.616+00	2021-11-08 10:19:47.786+00
2383	\N	died	2021-11-08 10:18:39.102+00	\N	\N	2021-11-08 10:19:17.775+00	2021-11-08 10:19:17.981+00
2390	\N	died	2021-11-08 10:18:39.125+00	\N	\N	2021-11-08 10:19:17.944+00	2021-11-08 10:19:18.397+00
2411	\N	died	2021-11-08 10:18:39.191+00	\N	\N	2021-11-08 10:19:18.393+00	2021-11-08 10:19:18.538+00
3723	\N	died	2021-11-08 10:18:47.864+00	\N	\N	2021-11-08 10:19:47.782+00	2021-11-08 10:19:48.019+00
2545	\N	died	2021-11-08 10:18:39.624+00	\N	\N	2021-11-08 10:19:21.118+00	2021-11-08 10:19:21.417+00
3854	\N	died	2021-11-08 10:18:51.578+00	\N	\N	2021-11-08 10:19:50.638+00	2021-11-08 10:19:50.938+00
2557	\N	died	2021-11-08 10:18:39.672+00	\N	\N	2021-11-08 10:19:21.413+00	2021-11-08 10:19:21.512+00
2562	\N	died	2021-11-08 10:18:39.69+00	\N	\N	2021-11-08 10:19:21.496+00	2021-11-08 10:19:21.674+00
3733	\N	died	2021-11-08 10:18:48.079+00	\N	\N	2021-11-08 10:19:47.999+00	2021-11-08 10:19:48.17+00
2572	\N	died	2021-11-08 10:18:39.722+00	\N	\N	2021-11-08 10:19:21.651+00	2021-11-08 10:19:22.141+00
2595	\N	died	2021-11-08 10:18:39.804+00	\N	\N	2021-11-08 10:19:22.134+00	2021-11-08 10:19:22.206+00
2599	\N	died	2021-11-08 10:18:39.815+00	\N	\N	2021-11-08 10:19:22.203+00	2021-11-08 10:19:22.238+00
3739	\N	died	2021-11-08 10:18:48.197+00	\N	\N	2021-11-08 10:19:48.149+00	2021-11-08 10:19:48.551+00
2601	\N	died	2021-11-08 10:18:39.819+00	\N	\N	2021-11-08 10:19:22.234+00	2021-11-08 10:19:22.339+00
2604	\N	died	2021-11-08 10:18:39.827+00	\N	\N	2021-11-08 10:19:22.335+00	2021-11-08 10:19:22.407+00
2608	\N	died	2021-11-08 10:18:39.842+00	\N	\N	2021-11-08 10:19:22.403+00	2021-11-08 10:19:22.562+00
3752	\N	died	2021-11-08 10:18:48.605+00	\N	\N	2021-11-08 10:19:48.415+00	2021-11-08 10:19:48.825+00
2615	\N	died	2021-11-08 10:18:39.858+00	\N	\N	2021-11-08 10:19:22.559+00	2021-11-08 10:19:22.598+00
3859	\N	died	2021-11-08 10:18:51.789+00	\N	\N	2021-11-08 10:19:50.724+00	2021-11-08 10:19:50.986+00
2617	\N	died	2021-11-08 10:18:39.864+00	\N	\N	2021-11-08 10:19:22.594+00	2021-11-08 10:19:22.647+00
2620	\N	died	2021-11-08 10:18:39.881+00	\N	\N	2021-11-08 10:19:22.643+00	2021-11-08 10:19:22.815+00
3767	\N	died	2021-11-08 10:18:48.991+00	\N	\N	2021-11-08 10:19:48.812+00	2021-11-08 10:19:49.128+00
2627	\N	died	2021-11-08 10:18:39.904+00	\N	\N	2021-11-08 10:19:22.811+00	2021-11-08 10:19:22.885+00
3923	\N	died	2021-11-08 10:18:54.039+00	\N	\N	2021-11-08 10:19:52.224+00	2021-11-08 10:19:52.694+00
2631	\N	died	2021-11-08 10:18:39.916+00	\N	\N	2021-11-08 10:19:22.88+00	2021-11-08 10:19:22.941+00
3781	\N	died	2021-11-08 10:18:49.321+00	\N	\N	2021-11-08 10:19:49.09+00	2021-11-08 10:19:49.463+00
3800	\N	died	2021-11-08 10:18:49.947+00	\N	\N	2021-11-08 10:19:49.46+00	2021-11-08 10:19:49.697+00
3869	\N	died	2021-11-08 10:18:52.072+00	\N	\N	2021-11-08 10:19:50.982+00	2021-11-08 10:19:51.14+00
3807	\N	died	2021-11-08 10:18:50.129+00	\N	\N	2021-11-08 10:19:49.574+00	2021-11-08 10:19:49.79+00
3817	\N	died	2021-11-08 10:18:50.446+00	\N	\N	2021-11-08 10:19:49.796+00	2021-11-08 10:19:50.162+00
3831	\N	died	2021-11-08 10:18:50.896+00	\N	\N	2021-11-08 10:19:50.123+00	2021-11-08 10:19:50.477+00
3945	\N	died	2021-11-08 10:18:54.597+00	\N	\N	2021-11-08 10:19:52.673+00	2021-11-08 10:19:52.964+00
5583	\N	died	2021-11-08 10:19:49.672+00	\N	\N	2021-11-08 10:20:38.434+00	2021-11-08 10:20:38.489+00
3873	\N	died	2021-11-08 10:18:52.222+00	\N	\N	2021-11-08 10:19:51.099+00	2021-11-08 10:19:51.42+00
3889	\N	died	2021-11-08 10:18:52.871+00	\N	\N	2021-11-08 10:19:51.415+00	2021-11-08 10:19:51.537+00
3983	\N	died	2021-11-08 10:18:55.863+00	\N	\N	2021-11-08 10:19:53.465+00	2021-11-08 10:19:54.086+00
3893	\N	died	2021-11-08 10:18:53.072+00	\N	\N	2021-11-08 10:19:51.532+00	2021-11-08 10:19:51.844+00
5599	\N	died	2021-11-08 10:19:49.89+00	\N	\N	2021-11-08 10:20:38.829+00	2021-11-08 10:20:39.246+00
3902	\N	died	2021-11-08 10:18:53.548+00	\N	\N	2021-11-08 10:19:51.683+00	2021-11-08 10:19:52.245+00
3958	\N	died	2021-11-08 10:18:55.014+00	\N	\N	2021-11-08 10:19:52.942+00	2021-11-08 10:19:53.254+00
5585	\N	died	2021-11-08 10:19:49.691+00	\N	\N	2021-11-08 10:20:38.482+00	2021-11-08 10:20:38.527+00
3973	\N	died	2021-11-08 10:18:55.522+00	\N	\N	2021-11-08 10:19:53.25+00	2021-11-08 10:19:53.503+00
4003	\N	died	2021-11-08 10:18:56.215+00	\N	\N	2021-11-08 10:19:54.082+00	2021-11-08 10:19:54.226+00
5636	\N	died	2021-11-08 10:19:50.523+00	\N	\N	2021-11-08 10:20:39.808+00	2021-11-08 10:20:40.017+00
4012	\N	died	2021-11-08 10:18:56.374+00	\N	\N	2021-11-08 10:19:54.223+00	2021-11-08 10:19:54.334+00
4016	\N	died	2021-11-08 10:18:56.49+00	\N	\N	2021-11-08 10:19:54.331+00	2021-11-08 10:19:54.371+00
5587	\N	died	2021-11-08 10:19:49.724+00	\N	\N	2021-11-08 10:20:38.522+00	2021-11-08 10:20:38.61+00
4018	\N	died	2021-11-08 10:18:56.539+00	\N	\N	2021-11-08 10:19:54.367+00	2021-11-08 10:19:54.437+00
4022	\N	died	2021-11-08 10:18:56.574+00	\N	\N	2021-11-08 10:19:54.431+00	2021-11-08 10:19:54.611+00
5591	\N	died	2021-11-08 10:19:49.774+00	\N	\N	2021-11-08 10:20:38.606+00	2021-11-08 10:20:38.875+00
5610	\N	died	2021-11-08 10:19:50.023+00	\N	\N	2021-11-08 10:20:39.181+00	2021-11-08 10:20:39.321+00
5615	\N	died	2021-11-08 10:19:50.157+00	\N	\N	2021-11-08 10:20:39.314+00	2021-11-08 10:20:39.442+00
5620	\N	died	2021-11-08 10:19:50.207+00	\N	\N	2021-11-08 10:20:39.397+00	2021-11-08 10:20:39.651+00
5631	\N	died	2021-11-08 10:19:50.456+00	\N	\N	2021-11-08 10:20:39.608+00	2021-11-08 10:20:39.82+00
2019	\N	died	2021-11-08 10:18:37.255+00	\N	\N	2021-11-08 10:19:10.252+00	2021-11-08 10:19:10.368+00
2397	\N	died	2021-11-08 10:18:39.154+00	\N	\N	2021-11-08 10:19:18.055+00	2021-11-08 10:19:18.199+00
2024	\N	died	2021-11-08 10:18:37.267+00	\N	\N	2021-11-08 10:19:10.364+00	2021-11-08 10:19:10.456+00
2029	\N	died	2021-11-08 10:18:37.284+00	\N	\N	2021-11-08 10:19:10.452+00	2021-11-08 10:19:10.493+00
2032	\N	died	2021-11-08 10:18:37.29+00	\N	\N	2021-11-08 10:19:10.489+00	2021-11-08 10:19:10.581+00
2400	\N	died	2021-11-08 10:18:39.16+00	\N	\N	2021-11-08 10:19:18.159+00	2021-11-08 10:19:18.333+00
2034	\N	died	2021-11-08 10:18:37.296+00	\N	\N	2021-11-08 10:19:10.577+00	2021-11-08 10:19:10.814+00
3736	\N	died	2021-11-08 10:18:48.151+00	\N	\N	2021-11-08 10:19:48.096+00	2021-11-08 10:19:48.17+00
2041	\N	died	2021-11-08 10:18:37.316+00	\N	\N	2021-11-08 10:19:10.691+00	2021-11-08 10:19:11.098+00
2058	\N	died	2021-11-08 10:18:37.372+00	\N	\N	2021-11-08 10:19:11.08+00	2021-11-08 10:19:11.457+00
2408	\N	died	2021-11-08 10:18:39.184+00	\N	\N	2021-11-08 10:19:18.296+00	2021-11-08 10:19:18.538+00
2075	\N	died	2021-11-08 10:18:37.452+00	\N	\N	2021-11-08 10:19:11.446+00	2021-11-08 10:19:11.603+00
2081	\N	died	2021-11-08 10:18:37.503+00	\N	\N	2021-11-08 10:19:11.599+00	2021-11-08 10:19:11.793+00
2085	\N	died	2021-11-08 10:18:37.522+00	\N	\N	2021-11-08 10:19:11.657+00	2021-11-08 10:19:12.09+00
2419	\N	died	2021-11-08 10:18:39.216+00	\N	\N	2021-11-08 10:19:18.521+00	2021-11-08 10:19:18.875+00
2098	\N	died	2021-11-08 10:18:37.592+00	\N	\N	2021-11-08 10:19:11.937+00	2021-11-08 10:19:12.293+00
2110	\N	died	2021-11-08 10:18:37.645+00	\N	\N	2021-11-08 10:19:12.235+00	2021-11-08 10:19:12.54+00
2121	\N	died	2021-11-08 10:18:37.694+00	\N	\N	2021-11-08 10:19:12.468+00	2021-11-08 10:19:12.807+00
2437	\N	died	2021-11-08 10:18:39.266+00	\N	\N	2021-11-08 10:19:18.872+00	2021-11-08 10:19:19.105+00
2138	\N	died	2021-11-08 10:18:37.742+00	\N	\N	2021-11-08 10:19:12.803+00	2021-11-08 10:19:12.953+00
3740	\N	died	2021-11-08 10:18:48.263+00	\N	\N	2021-11-08 10:19:48.166+00	2021-11-08 10:19:48.238+00
2144	\N	died	2021-11-08 10:18:37.76+00	\N	\N	2021-11-08 10:19:12.949+00	2021-11-08 10:19:13.191+00
2153	\N	died	2021-11-08 10:18:37.805+00	\N	\N	2021-11-08 10:19:13.167+00	2021-11-08 10:19:13.305+00
2446	\N	died	2021-11-08 10:18:39.285+00	\N	\N	2021-11-08 10:19:19.068+00	2021-11-08 10:19:19.384+00
2161	\N	died	2021-11-08 10:18:37.83+00	\N	\N	2021-11-08 10:19:13.3+00	2021-11-08 10:19:13.54+00
2170	\N	died	2021-11-08 10:18:37.865+00	\N	\N	2021-11-08 10:19:13.503+00	2021-11-08 10:19:13.745+00
2179	\N	died	2021-11-08 10:18:37.901+00	\N	\N	2021-11-08 10:19:13.695+00	2021-11-08 10:19:14.022+00
2460	\N	died	2021-11-08 10:18:39.325+00	\N	\N	2021-11-08 10:19:19.36+00	2021-11-08 10:19:19.821+00
2189	\N	died	2021-11-08 10:18:37.937+00	\N	\N	2021-11-08 10:19:13.921+00	2021-11-08 10:19:14.238+00
2201	\N	died	2021-11-08 10:18:37.981+00	\N	\N	2021-11-08 10:19:14.173+00	2021-11-08 10:19:14.541+00
2214	\N	died	2021-11-08 10:18:38.028+00	\N	\N	2021-11-08 10:19:14.454+00	2021-11-08 10:19:15.133+00
2482	\N	died	2021-11-08 10:18:39.385+00	\N	\N	2021-11-08 10:19:19.817+00	2021-11-08 10:19:20.017+00
2233	\N	died	2021-11-08 10:18:38.175+00	\N	\N	2021-11-08 10:19:14.962+00	2021-11-08 10:19:15.301+00
3744	\N	died	2021-11-08 10:18:48.396+00	\N	\N	2021-11-08 10:19:48.232+00	2021-11-08 10:19:48.551+00
2246	\N	died	2021-11-08 10:18:38.235+00	\N	\N	2021-11-08 10:19:15.245+00	2021-11-08 10:19:15.461+00
2255	\N	died	2021-11-08 10:18:38.275+00	\N	\N	2021-11-08 10:19:15.393+00	2021-11-08 10:19:15.629+00
2488	\N	died	2021-11-08 10:18:39.402+00	\N	\N	2021-11-08 10:19:19.978+00	2021-11-08 10:19:20.239+00
2267	\N	died	2021-11-08 10:18:38.331+00	\N	\N	2021-11-08 10:19:15.624+00	2021-11-08 10:19:15.884+00
3909	\N	died	2021-11-08 10:18:53.646+00	\N	\N	2021-11-08 10:19:51.891+00	2021-11-08 10:19:52.028+00
2275	\N	died	2021-11-08 10:18:38.368+00	\N	\N	2021-11-08 10:19:15.812+00	2021-11-08 10:19:16.107+00
2292	\N	died	2021-11-08 10:18:38.475+00	\N	\N	2021-11-08 10:19:16.104+00	2021-11-08 10:19:16.261+00
2501	\N	died	2021-11-08 10:18:39.442+00	\N	\N	2021-11-08 10:19:20.235+00	2021-11-08 10:19:20.323+00
2300	\N	died	2021-11-08 10:18:38.517+00	\N	\N	2021-11-08 10:19:16.23+00	2021-11-08 10:19:16.469+00
2311	\N	died	2021-11-08 10:18:38.566+00	\N	\N	2021-11-08 10:19:16.408+00	2021-11-08 10:19:16.708+00
2324	\N	died	2021-11-08 10:18:38.602+00	\N	\N	2021-11-08 10:19:16.666+00	2021-11-08 10:19:16.965+00
2506	\N	died	2021-11-08 10:18:39.463+00	\N	\N	2021-11-08 10:19:20.319+00	2021-11-08 10:19:20.513+00
2342	\N	died	2021-11-08 10:18:38.691+00	\N	\N	2021-11-08 10:19:16.961+00	2021-11-08 10:19:17.102+00
3754	\N	died	2021-11-08 10:18:48.623+00	\N	\N	2021-11-08 10:19:48.448+00	2021-11-08 10:19:48.879+00
2348	\N	died	2021-11-08 10:18:38.724+00	\N	\N	2021-11-08 10:19:17.061+00	2021-11-08 10:19:17.354+00
3981	\N	died	2021-11-08 10:18:55.806+00	\N	\N	2021-11-08 10:19:53.432+00	2021-11-08 10:19:53.955+00
2357	\N	died	2021-11-08 10:18:38.971+00	\N	\N	2021-11-08 10:19:17.334+00	2021-11-08 10:19:17.697+00
2372	\N	died	2021-11-08 10:18:39.04+00	\N	\N	2021-11-08 10:19:17.594+00	2021-11-08 10:19:17.981+00
3771	\N	died	2021-11-08 10:18:49.046+00	\N	\N	2021-11-08 10:19:48.875+00	2021-11-08 10:19:49.128+00
2387	\N	died	2021-11-08 10:18:39.117+00	\N	\N	2021-11-08 10:19:17.844+00	2021-11-08 10:19:18.058+00
2512	\N	died	2021-11-08 10:18:39.497+00	\N	\N	2021-11-08 10:19:20.48+00	2021-11-08 10:19:20.923+00
2530	\N	died	2021-11-08 10:18:39.556+00	\N	\N	2021-11-08 10:19:20.821+00	2021-11-08 10:19:21.251+00
3780	\N	died	2021-11-08 10:18:49.306+00	\N	\N	2021-11-08 10:19:49.073+00	2021-11-08 10:19:49.445+00
2549	\N	died	2021-11-08 10:18:39.649+00	\N	\N	2021-11-08 10:19:21.226+00	2021-11-08 10:19:21.564+00
3912	\N	died	2021-11-08 10:18:53.718+00	\N	\N	2021-11-08 10:19:51.988+00	2021-11-08 10:19:52.245+00
2566	\N	died	2021-11-08 10:18:39.698+00	\N	\N	2021-11-08 10:19:21.559+00	2021-11-08 10:19:21.754+00
2575	\N	died	2021-11-08 10:18:39.73+00	\N	\N	2021-11-08 10:19:21.702+00	2021-11-08 10:19:21.93+00
3798	\N	died	2021-11-08 10:18:49.863+00	\N	\N	2021-11-08 10:19:49.424+00	2021-11-08 10:19:49.812+00
2585	\N	died	2021-11-08 10:18:39.761+00	\N	\N	2021-11-08 10:19:21.926+00	2021-11-08 10:19:22.125+00
2594	\N	died	2021-11-08 10:18:39.803+00	\N	\N	2021-11-08 10:19:22.122+00	2021-11-08 10:19:22.206+00
2597	\N	died	2021-11-08 10:18:39.811+00	\N	\N	2021-11-08 10:19:22.172+00	2021-11-08 10:19:22.339+00
3818	\N	died	2021-11-08 10:18:50.468+00	\N	\N	2021-11-08 10:19:49.807+00	2021-11-08 10:19:50.027+00
2603	\N	died	2021-11-08 10:18:39.827+00	\N	\N	2021-11-08 10:19:22.271+00	2021-11-08 10:19:22.616+00
2618	\N	died	2021-11-08 10:18:39.87+00	\N	\N	2021-11-08 10:19:22.611+00	2021-11-08 10:19:22.815+00
2623	\N	died	2021-11-08 10:18:39.891+00	\N	\N	2021-11-08 10:19:22.692+00	2021-11-08 10:19:22.96+00
3827	\N	died	2021-11-08 10:18:50.812+00	\N	\N	2021-11-08 10:19:50.01+00	2021-11-08 10:19:50.214+00
2636	\N	died	2021-11-08 10:18:39.929+00	\N	\N	2021-11-08 10:19:22.953+00	2021-11-08 10:19:23.169+00
3920	\N	died	2021-11-08 10:18:53.931+00	\N	\N	2021-11-08 10:19:52.123+00	2021-11-08 10:19:52.496+00
2645	\N	died	2021-11-08 10:18:39.965+00	\N	\N	2021-11-08 10:19:23.162+00	2021-11-08 10:19:23.297+00
3836	\N	died	2021-11-08 10:18:51.092+00	\N	\N	2021-11-08 10:19:50.21+00	2021-11-08 10:19:50.477+00
2650	\N	died	2021-11-08 10:18:39.987+00	\N	\N	2021-11-08 10:19:23.293+00	2021-11-08 10:19:23.333+00
3845	\N	died	2021-11-08 10:18:51.353+00	\N	\N	2021-11-08 10:19:50.438+00	2021-11-08 10:19:50.938+00
3860	\N	died	2021-11-08 10:18:51.791+00	\N	\N	2021-11-08 10:19:50.831+00	2021-11-08 10:19:51.14+00
3998	\N	died	2021-11-08 10:18:56.148+00	\N	\N	2021-11-08 10:19:53.951+00	2021-11-08 10:19:54.104+00
3872	\N	died	2021-11-08 10:18:52.206+00	\N	\N	2021-11-08 10:19:51.084+00	2021-11-08 10:19:51.373+00
5618	\N	died	2021-11-08 10:19:50.19+00	\N	\N	2021-11-08 10:20:39.364+00	2021-11-08 10:20:39.442+00
3883	\N	died	2021-11-08 10:18:52.646+00	\N	\N	2021-11-08 10:19:51.317+00	2021-11-08 10:19:51.844+00
3899	\N	died	2021-11-08 10:18:53.406+00	\N	\N	2021-11-08 10:19:51.633+00	2021-11-08 10:19:51.896+00
3935	\N	died	2021-11-08 10:18:54.314+00	\N	\N	2021-11-08 10:19:52.46+00	2021-11-08 10:19:52.744+00
4004	\N	died	2021-11-08 10:18:56.239+00	\N	\N	2021-11-08 10:19:54.099+00	2021-11-08 10:19:54.334+00
3949	\N	died	2021-11-08 10:18:54.713+00	\N	\N	2021-11-08 10:19:52.741+00	2021-11-08 10:19:52.964+00
5672	\N	died	2021-11-08 10:19:51.216+00	\N	\N	2021-11-08 10:20:40.904+00	2021-11-08 10:20:41.535+00
3957	\N	died	2021-11-08 10:18:54.997+00	\N	\N	2021-11-08 10:19:52.924+00	2021-11-08 10:19:53.217+00
3971	\N	died	2021-11-08 10:18:55.458+00	\N	\N	2021-11-08 10:19:53.213+00	2021-11-08 10:19:53.503+00
5616	\N	died	2021-11-08 10:19:50.158+00	\N	\N	2021-11-08 10:20:39.331+00	2021-11-08 10:20:39.593+00
4014	\N	died	2021-11-08 10:18:56.408+00	\N	\N	2021-11-08 10:19:54.298+00	2021-11-08 10:19:54.63+00
5622	\N	died	2021-11-08 10:19:50.24+00	\N	\N	2021-11-08 10:20:39.431+00	2021-11-08 10:20:39.593+00
4031	\N	died	2021-11-08 10:18:56.773+00	\N	\N	2021-11-08 10:19:54.626+00	2021-11-08 10:19:54.888+00
4037	\N	died	2021-11-08 10:18:56.922+00	\N	\N	2021-11-08 10:19:54.766+00	2021-11-08 10:19:55.02+00
4049	\N	died	2021-11-08 10:18:57.106+00	\N	\N	2021-11-08 10:19:55.016+00	2021-11-08 10:19:55.088+00
5630	\N	died	2021-11-08 10:19:50.423+00	\N	\N	2021-11-08 10:20:39.589+00	2021-11-08 10:20:39.651+00
4053	\N	died	2021-11-08 10:18:57.165+00	\N	\N	2021-11-08 10:19:55.084+00	2021-11-08 10:19:55.205+00
5649	\N	died	2021-11-08 10:19:50.882+00	\N	\N	2021-11-08 10:20:40.248+00	2021-11-08 10:20:40.726+00
4057	\N	died	2021-11-08 10:18:57.232+00	\N	\N	2021-11-08 10:19:55.201+00	2021-11-08 10:19:55.288+00
5632	\N	died	2021-11-08 10:19:50.473+00	\N	\N	2021-11-08 10:20:39.641+00	2021-11-08 10:20:39.768+00
4062	\N	died	2021-11-08 10:18:57.4+00	\N	\N	2021-11-08 10:19:55.283+00	2021-11-08 10:19:55.345+00
5695	\N	died	2021-11-08 10:19:51.449+00	\N	\N	2021-11-08 10:20:41.517+00	2021-11-08 10:20:41.827+00
5634	\N	died	2021-11-08 10:19:50.506+00	\N	\N	2021-11-08 10:20:39.75+00	2021-11-08 10:20:39.868+00
5639	\N	died	2021-11-08 10:19:50.624+00	\N	\N	2021-11-08 10:20:39.864+00	2021-11-08 10:20:40.378+00
5666	\N	died	2021-11-08 10:19:51.165+00	\N	\N	2021-11-08 10:20:40.709+00	2021-11-08 10:20:40.987+00
5701	\N	died	2021-11-08 10:19:51.565+00	\N	\N	2021-11-08 10:20:41.656+00	2021-11-08 10:20:42.113+00
5718	\N	died	2021-11-08 10:19:52.04+00	\N	\N	2021-11-08 10:20:42.076+00	2021-11-08 10:20:43.105+00
5746	\N	died	2021-11-08 10:19:52.607+00	\N	\N	2021-11-08 10:20:43.091+00	2021-11-08 10:20:43.267+00
5743	\N	died	2021-11-08 10:19:52.557+00	\N	\N	2021-11-08 10:20:42.989+00	2021-11-08 10:20:43.267+00
2076	\N	died	2021-11-08 10:18:37.465+00	\N	\N	2021-11-08 10:19:11.455+00	2021-11-08 10:19:11.632+00
2083	\N	died	2021-11-08 10:18:37.516+00	\N	\N	2021-11-08 10:19:11.628+00	2021-11-08 10:19:11.793+00
2089	\N	died	2021-11-08 10:18:37.551+00	\N	\N	2021-11-08 10:19:11.787+00	2021-11-08 10:19:11.836+00
2092	\N	died	2021-11-08 10:18:37.565+00	\N	\N	2021-11-08 10:19:11.832+00	2021-11-08 10:19:11.92+00
2483	\N	died	2021-11-08 10:18:39.391+00	\N	\N	2021-11-08 10:19:19.829+00	2021-11-08 10:19:20.091+00
2096	\N	died	2021-11-08 10:18:37.585+00	\N	\N	2021-11-08 10:19:11.903+00	2021-11-08 10:19:12.16+00
2108	\N	died	2021-11-08 10:18:37.638+00	\N	\N	2021-11-08 10:19:12.157+00	2021-11-08 10:19:12.368+00
2115	\N	died	2021-11-08 10:18:37.668+00	\N	\N	2021-11-08 10:19:12.329+00	2021-11-08 10:19:12.571+00
2494	\N	died	2021-11-08 10:18:39.418+00	\N	\N	2021-11-08 10:19:20.072+00	2021-11-08 10:19:20.599+00
2126	\N	died	2021-11-08 10:18:37.706+00	\N	\N	2021-11-08 10:19:12.549+00	2021-11-08 10:19:12.741+00
3747	\N	died	2021-11-08 10:18:48.412+00	\N	\N	2021-11-08 10:19:48.332+00	2021-11-08 10:19:48.551+00
2134	\N	died	2021-11-08 10:18:37.734+00	\N	\N	2021-11-08 10:19:12.737+00	2021-11-08 10:19:12.825+00
2139	\N	died	2021-11-08 10:18:37.748+00	\N	\N	2021-11-08 10:19:12.821+00	2021-11-08 10:19:13.099+00
2519	\N	died	2021-11-08 10:18:39.518+00	\N	\N	2021-11-08 10:19:20.596+00	2021-11-08 10:19:20.923+00
2146	\N	died	2021-11-08 10:18:37.767+00	\N	\N	2021-11-08 10:19:12.982+00	2021-11-08 10:19:13.478+00
3877	\N	died	2021-11-08 10:18:52.322+00	\N	\N	2021-11-08 10:19:51.166+00	2021-11-08 10:19:51.56+00
2163	\N	died	2021-11-08 10:18:37.841+00	\N	\N	2021-11-08 10:19:13.337+00	2021-11-08 10:19:13.689+00
2176	\N	died	2021-11-08 10:18:37.889+00	\N	\N	2021-11-08 10:19:13.653+00	2021-11-08 10:19:13.781+00
2526	\N	died	2021-11-08 10:18:39.544+00	\N	\N	2021-11-08 10:19:20.754+00	2021-11-08 10:19:20.987+00
2184	\N	died	2021-11-08 10:18:37.913+00	\N	\N	2021-11-08 10:19:13.775+00	2021-11-08 10:19:14.022+00
2191	\N	died	2021-11-08 10:18:37.943+00	\N	\N	2021-11-08 10:19:13.95+00	2021-11-08 10:19:14.269+00
2206	\N	died	2021-11-08 10:18:38.004+00	\N	\N	2021-11-08 10:19:14.259+00	2021-11-08 10:19:14.636+00
2537	\N	died	2021-11-08 10:18:39.587+00	\N	\N	2021-11-08 10:19:20.983+00	2021-11-08 10:19:21.074+00
2221	\N	died	2021-11-08 10:18:38.1+00	\N	\N	2021-11-08 10:19:14.633+00	2021-11-08 10:19:14.689+00
3757	\N	died	2021-11-08 10:18:48.731+00	\N	\N	2021-11-08 10:19:48.548+00	2021-11-08 10:19:48.585+00
2224	\N	died	2021-11-08 10:18:38.129+00	\N	\N	2021-11-08 10:19:14.687+00	2021-11-08 10:19:14.841+00
2230	\N	died	2021-11-08 10:18:38.164+00	\N	\N	2021-11-08 10:19:14.837+00	2021-11-08 10:19:15.133+00
2540	\N	died	2021-11-08 10:18:39.601+00	\N	\N	2021-11-08 10:19:21.038+00	2021-11-08 10:19:21.251+00
2234	\N	died	2021-11-08 10:18:38.18+00	\N	\N	2021-11-08 10:19:14.996+00	2021-11-08 10:19:15.301+00
4019	\N	died	2021-11-08 10:18:56.556+00	\N	\N	2021-11-08 10:19:54.384+00	2021-11-08 10:19:54.611+00
2248	\N	died	2021-11-08 10:18:38.241+00	\N	\N	2021-11-08 10:19:15.279+00	2021-11-08 10:19:15.618+00
2265	\N	died	2021-11-08 10:18:38.325+00	\N	\N	2021-11-08 10:19:15.598+00	2021-11-08 10:19:15.884+00
2548	\N	died	2021-11-08 10:18:39.649+00	\N	\N	2021-11-08 10:19:21.212+00	2021-11-08 10:19:21.512+00
2277	\N	died	2021-11-08 10:18:38.383+00	\N	\N	2021-11-08 10:19:15.841+00	2021-11-08 10:19:16.206+00
2296	\N	died	2021-11-08 10:18:38.494+00	\N	\N	2021-11-08 10:19:16.173+00	2021-11-08 10:19:16.518+00
2317	\N	died	2021-11-08 10:18:38.585+00	\N	\N	2021-11-08 10:19:16.509+00	2021-11-08 10:19:16.708+00
2561	\N	died	2021-11-08 10:18:39.685+00	\N	\N	2021-11-08 10:19:21.478+00	2021-11-08 10:19:21.674+00
2325	\N	died	2021-11-08 10:18:38.609+00	\N	\N	2021-11-08 10:19:16.688+00	2021-11-08 10:19:17.021+00
3759	\N	died	2021-11-08 10:18:48.805+00	\N	\N	2021-11-08 10:19:48.581+00	2021-11-08 10:19:48.616+00
2344	\N	died	2021-11-08 10:18:38.7+00	\N	\N	2021-11-08 10:19:16.994+00	2021-11-08 10:19:17.376+00
2359	\N	died	2021-11-08 10:18:38.987+00	\N	\N	2021-11-08 10:19:17.373+00	2021-11-08 10:19:17.476+00
2570	\N	died	2021-11-08 10:18:39.717+00	\N	\N	2021-11-08 10:19:21.619+00	2021-11-08 10:19:22.125+00
2364	\N	died	2021-11-08 10:18:39.008+00	\N	\N	2021-11-08 10:19:17.454+00	2021-11-08 10:19:17.697+00
2376	\N	died	2021-11-08 10:18:39.073+00	\N	\N	2021-11-08 10:19:17.664+00	2021-11-08 10:19:18.037+00
2393	\N	died	2021-11-08 10:18:39.136+00	\N	\N	2021-11-08 10:19:17.987+00	2021-11-08 10:19:18.199+00
2589	\N	died	2021-11-08 10:18:39.778+00	\N	\N	2021-11-08 10:19:21.985+00	2021-11-08 10:19:22.36+00
2401	\N	died	2021-11-08 10:18:39.16+00	\N	\N	2021-11-08 10:19:18.175+00	2021-11-08 10:19:18.459+00
2414	\N	died	2021-11-08 10:18:39.197+00	\N	\N	2021-11-08 10:19:18.442+00	2021-11-08 10:19:18.674+00
3761	\N	died	2021-11-08 10:18:48.823+00	\N	\N	2021-11-08 10:19:48.612+00	2021-11-08 10:19:48.825+00
2424	\N	died	2021-11-08 10:18:39.233+00	\N	\N	2021-11-08 10:19:18.653+00	2021-11-08 10:19:18.991+00
3894	\N	died	2021-11-08 10:18:53.155+00	\N	\N	2021-11-08 10:19:51.554+00	2021-11-08 10:19:51.844+00
2439	\N	died	2021-11-08 10:18:39.272+00	\N	\N	2021-11-08 10:19:18.905+00	2021-11-08 10:19:19.222+00
2454	\N	died	2021-11-08 10:18:39.312+00	\N	\N	2021-11-08 10:19:19.202+00	2021-11-08 10:19:19.757+00
3766	\N	died	2021-11-08 10:18:48.987+00	\N	\N	2021-11-08 10:19:48.793+00	2021-11-08 10:19:49.128+00
2478	\N	died	2021-11-08 10:18:39.372+00	\N	\N	2021-11-08 10:19:19.75+00	2021-11-08 10:19:19.882+00
2605	\N	died	2021-11-08 10:18:39.831+00	\N	\N	2021-11-08 10:19:22.353+00	2021-11-08 10:19:22.562+00
2612	\N	died	2021-11-08 10:18:39.852+00	\N	\N	2021-11-08 10:19:22.47+00	2021-11-08 10:19:22.834+00
2628	\N	died	2021-11-08 10:18:39.909+00	\N	\N	2021-11-08 10:19:22.831+00	2021-11-08 10:19:22.941+00
3777	\N	died	2021-11-08 10:18:49.258+00	\N	\N	2021-11-08 10:19:49.022+00	2021-11-08 10:19:49.323+00
2634	\N	died	2021-11-08 10:18:39.925+00	\N	\N	2021-11-08 10:19:22.922+00	2021-11-08 10:19:23.169+00
2643	\N	died	2021-11-08 10:18:39.955+00	\N	\N	2021-11-08 10:19:23.132+00	2021-11-08 10:19:23.387+00
2655	\N	died	2021-11-08 10:18:40.006+00	\N	\N	2021-11-08 10:19:23.383+00	2021-11-08 10:19:23.53+00
3792	\N	died	2021-11-08 10:18:49.69+00	\N	\N	2021-11-08 10:19:49.275+00	2021-11-08 10:19:49.479+00
2661	\N	died	2021-11-08 10:18:40.017+00	\N	\N	2021-11-08 10:19:23.525+00	2021-11-08 10:19:23.603+00
3904	\N	died	2021-11-08 10:18:53.563+00	\N	\N	2021-11-08 10:19:51.757+00	2021-11-08 10:19:52.245+00
2665	\N	died	2021-11-08 10:18:40.038+00	\N	\N	2021-11-08 10:19:23.598+00	2021-11-08 10:19:23.793+00
2673	\N	died	2021-11-08 10:18:40.076+00	\N	\N	2021-11-08 10:19:23.788+00	2021-11-08 10:19:23.825+00
3801	\N	died	2021-11-08 10:18:49.979+00	\N	\N	2021-11-08 10:19:49.475+00	2021-11-08 10:19:49.697+00
2675	\N	died	2021-11-08 10:18:40.081+00	\N	\N	2021-11-08 10:19:23.82+00	2021-11-08 10:19:23.856+00
2677	\N	died	2021-11-08 10:18:40.085+00	\N	\N	2021-11-08 10:19:23.852+00	2021-11-08 10:19:23.988+00
2682	\N	died	2021-11-08 10:18:40.098+00	\N	\N	2021-11-08 10:19:23.984+00	2021-11-08 10:19:24.091+00
3809	\N	died	2021-11-08 10:18:50.196+00	\N	\N	2021-11-08 10:19:49.658+00	2021-11-08 10:19:49.98+00
2688	\N	died	2021-11-08 10:18:40.114+00	\N	\N	2021-11-08 10:19:24.084+00	2021-11-08 10:19:24.209+00
2692	\N	died	2021-11-08 10:18:40.14+00	\N	\N	2021-11-08 10:19:24.205+00	2021-11-08 10:19:24.338+00
3824	\N	died	2021-11-08 10:18:50.646+00	\N	\N	2021-11-08 10:19:49.957+00	2021-11-08 10:19:50.477+00
3844	\N	died	2021-11-08 10:18:51.351+00	\N	\N	2021-11-08 10:19:50.424+00	2021-11-08 10:19:50.713+00
3954	\N	died	2021-11-08 10:18:54.931+00	\N	\N	2021-11-08 10:19:52.825+00	2021-11-08 10:19:53.503+00
3858	\N	died	2021-11-08 10:18:51.771+00	\N	\N	2021-11-08 10:19:50.71+00	2021-11-08 10:19:50.97+00
4024	\N	died	2021-11-08 10:18:56.656+00	\N	\N	2021-11-08 10:19:54.517+00	2021-11-08 10:19:54.737+00
3867	\N	died	2021-11-08 10:18:52.022+00	\N	\N	2021-11-08 10:19:50.948+00	2021-11-08 10:19:51.071+00
3871	\N	died	2021-11-08 10:18:52.155+00	\N	\N	2021-11-08 10:19:51.066+00	2021-11-08 10:19:51.207+00
3980	\N	died	2021-11-08 10:18:55.774+00	\N	\N	2021-11-08 10:19:53.413+00	2021-11-08 10:19:53.938+00
3919	\N	died	2021-11-08 10:18:53.93+00	\N	\N	2021-11-08 10:19:52.108+00	2021-11-08 10:19:52.35+00
3931	\N	died	2021-11-08 10:18:54.224+00	\N	\N	2021-11-08 10:19:52.346+00	2021-11-08 10:19:52.496+00
3934	\N	died	2021-11-08 10:18:54.273+00	\N	\N	2021-11-08 10:19:52.442+00	2021-11-08 10:19:52.694+00
4035	\N	died	2021-11-08 10:18:56.905+00	\N	\N	2021-11-08 10:19:54.733+00	2021-11-08 10:19:54.904+00
3944	\N	died	2021-11-08 10:18:54.556+00	\N	\N	2021-11-08 10:19:52.609+00	2021-11-08 10:19:52.845+00
4048	\N	died	2021-11-08 10:18:57.089+00	\N	\N	2021-11-08 10:19:55.001+00	2021-11-08 10:19:55.088+00
3996	\N	died	2021-11-08 10:18:56.1+00	\N	\N	2021-11-08 10:19:53.913+00	2021-11-08 10:19:54.226+00
5624	\N	died	2021-11-08 10:19:50.274+00	\N	\N	2021-11-08 10:20:39.465+00	2021-11-08 10:20:39.852+00
4007	\N	died	2021-11-08 10:18:56.274+00	\N	\N	2021-11-08 10:19:54.14+00	2021-11-08 10:19:54.388+00
5744	\N	died	2021-11-08 10:19:52.574+00	\N	\N	2021-11-08 10:20:43.006+00	2021-11-08 10:20:43.267+00
4045	\N	died	2021-11-08 10:18:57.023+00	\N	\N	2021-11-08 10:19:54.9+00	2021-11-08 10:19:55.005+00
4051	\N	died	2021-11-08 10:18:57.132+00	\N	\N	2021-11-08 10:19:55.051+00	2021-11-08 10:19:55.362+00
4067	\N	died	2021-11-08 10:18:57.464+00	\N	\N	2021-11-08 10:19:55.358+00	2021-11-08 10:19:55.651+00
5638	\N	died	2021-11-08 10:19:50.607+00	\N	\N	2021-11-08 10:20:39.847+00	2021-11-08 10:20:40.378+00
4071	\N	died	2021-11-08 10:18:57.584+00	\N	\N	2021-11-08 10:19:55.646+00	2021-11-08 10:19:55.767+00
4076	\N	died	2021-11-08 10:18:57.698+00	\N	\N	2021-11-08 10:19:55.762+00	2021-11-08 10:19:55.813+00
5647	\N	died	2021-11-08 10:19:50.849+00	\N	\N	2021-11-08 10:20:40.142+00	2021-11-08 10:20:40.631+00
4079	\N	died	2021-11-08 10:18:57.731+00	\N	\N	2021-11-08 10:19:55.809+00	2021-11-08 10:19:55.979+00
5660	\N	died	2021-11-08 10:19:51.083+00	\N	\N	2021-11-08 10:20:40.606+00	2021-11-08 10:20:41.06+00
5707	\N	died	2021-11-08 10:19:51.682+00	\N	\N	2021-11-08 10:20:41.79+00	2021-11-08 10:20:42.626+00
5679	\N	died	2021-11-08 10:19:51.3+00	\N	\N	2021-11-08 10:20:41.039+00	2021-11-08 10:20:41.381+00
5690	\N	died	2021-11-08 10:19:51.401+00	\N	\N	2021-11-08 10:20:41.344+00	2021-11-08 10:20:41.827+00
5724	\N	died	2021-11-08 10:19:52.157+00	\N	\N	2021-11-08 10:20:42.423+00	2021-11-08 10:20:43.011+00
5750	\N	died	2021-11-08 10:19:52.707+00	\N	\N	2021-11-08 10:20:43.181+00	2021-11-08 10:20:43.545+00
2127	\N	died	2021-11-08 10:18:37.712+00	\N	\N	2021-11-08 10:19:12.566+00	2021-11-08 10:19:12.604+00
2507	\N	died	2021-11-08 10:18:39.474+00	\N	\N	2021-11-08 10:19:20.347+00	2021-11-08 10:19:20.583+00
2129	\N	died	2021-11-08 10:18:37.712+00	\N	\N	2021-11-08 10:19:12.6+00	2021-11-08 10:19:12.721+00
3791	\N	died	2021-11-08 10:18:49.656+00	\N	\N	2021-11-08 10:19:49.258+00	2021-11-08 10:19:49.323+00
2133	\N	died	2021-11-08 10:18:37.729+00	\N	\N	2021-11-08 10:19:12.716+00	2021-11-08 10:19:12.792+00
2137	\N	died	2021-11-08 10:18:37.742+00	\N	\N	2021-11-08 10:19:12.787+00	2021-11-08 10:19:12.94+00
2516	\N	died	2021-11-08 10:18:39.511+00	\N	\N	2021-11-08 10:19:20.546+00	2021-11-08 10:19:20.923+00
2142	\N	died	2021-11-08 10:18:37.753+00	\N	\N	2021-11-08 10:19:12.917+00	2021-11-08 10:19:13.203+00
2155	\N	died	2021-11-08 10:18:37.811+00	\N	\N	2021-11-08 10:19:13.199+00	2021-11-08 10:19:13.26+00
2158	\N	died	2021-11-08 10:18:37.824+00	\N	\N	2021-11-08 10:19:13.256+00	2021-11-08 10:19:13.478+00
2527	\N	died	2021-11-08 10:18:39.548+00	\N	\N	2021-11-08 10:19:20.772+00	2021-11-08 10:19:21.074+00
2164	\N	died	2021-11-08 10:18:37.846+00	\N	\N	2021-11-08 10:19:13.403+00	2021-11-08 10:19:13.745+00
2181	\N	died	2021-11-08 10:18:37.908+00	\N	\N	2021-11-08 10:19:13.729+00	2021-11-08 10:19:14.022+00
2194	\N	died	2021-11-08 10:18:37.954+00	\N	\N	2021-11-08 10:19:14.004+00	2021-11-08 10:19:14.393+00
2541	\N	died	2021-11-08 10:18:39.601+00	\N	\N	2021-11-08 10:19:21.052+00	2021-11-08 10:19:21.348+00
2210	\N	died	2021-11-08 10:18:38.016+00	\N	\N	2021-11-08 10:19:14.386+00	2021-11-08 10:19:14.614+00
3795	\N	died	2021-11-08 10:18:49.772+00	\N	\N	2021-11-08 10:19:49.319+00	2021-11-08 10:19:49.445+00
2219	\N	died	2021-11-08 10:18:38.091+00	\N	\N	2021-11-08 10:19:14.597+00	2021-11-08 10:19:14.841+00
2229	\N	died	2021-11-08 10:18:38.16+00	\N	\N	2021-11-08 10:19:14.761+00	2021-11-08 10:19:15.178+00
2555	\N	died	2021-11-08 10:18:39.666+00	\N	\N	2021-11-08 10:19:21.334+00	2021-11-08 10:19:21.754+00
2242	\N	died	2021-11-08 10:18:38.218+00	\N	\N	2021-11-08 10:19:15.174+00	2021-11-08 10:19:15.301+00
2247	\N	died	2021-11-08 10:18:38.235+00	\N	\N	2021-11-08 10:19:15.258+00	2021-11-08 10:19:15.533+00
2261	\N	died	2021-11-08 10:18:38.3+00	\N	\N	2021-11-08 10:19:15.529+00	2021-11-08 10:19:15.618+00
2576	\N	died	2021-11-08 10:18:39.733+00	\N	\N	2021-11-08 10:19:21.719+00	2021-11-08 10:19:22.125+00
2264	\N	died	2021-11-08 10:18:38.318+00	\N	\N	2021-11-08 10:19:15.579+00	2021-11-08 10:19:15.884+00
2273	\N	died	2021-11-08 10:18:38.355+00	\N	\N	2021-11-08 10:19:15.779+00	2021-11-08 10:19:16.034+00
2288	\N	died	2021-11-08 10:18:38.433+00	\N	\N	2021-11-08 10:19:16.03+00	2021-11-08 10:19:16.206+00
2587	\N	died	2021-11-08 10:18:39.773+00	\N	\N	2021-11-08 10:19:21.953+00	2021-11-08 10:19:22.206+00
2293	\N	died	2021-11-08 10:18:38.482+00	\N	\N	2021-11-08 10:19:16.123+00	2021-11-08 10:19:16.317+00
3799	\N	died	2021-11-08 10:18:49.88+00	\N	\N	2021-11-08 10:19:49.441+00	2021-11-08 10:19:49.545+00
2305	\N	died	2021-11-08 10:18:38.536+00	\N	\N	2021-11-08 10:19:16.313+00	2021-11-08 10:19:16.469+00
2310	\N	died	2021-11-08 10:18:38.566+00	\N	\N	2021-11-08 10:19:16.397+00	2021-11-08 10:19:16.708+00
2598	\N	died	2021-11-08 10:18:39.811+00	\N	\N	2021-11-08 10:19:22.185+00	2021-11-08 10:19:22.562+00
2322	\N	died	2021-11-08 10:18:38.597+00	\N	\N	2021-11-08 10:19:16.633+00	2021-11-08 10:19:16.951+00
3941	\N	died	2021-11-08 10:18:54.472+00	\N	\N	2021-11-08 10:19:52.558+00	2021-11-08 10:19:52.978+00
2338	\N	died	2021-11-08 10:18:38.672+00	\N	\N	2021-11-08 10:19:16.899+00	2021-11-08 10:19:17.102+00
2347	\N	died	2021-11-08 10:18:38.715+00	\N	\N	2021-11-08 10:19:17.049+00	2021-11-08 10:19:17.41+00
2614	\N	died	2021-11-08 10:18:39.858+00	\N	\N	2021-11-08 10:19:22.496+00	2021-11-08 10:19:22.896+00
2361	\N	died	2021-11-08 10:18:38.996+00	\N	\N	2021-11-08 10:19:17.406+00	2021-11-08 10:19:17.515+00
2367	\N	died	2021-11-08 10:18:39.02+00	\N	\N	2021-11-08 10:19:17.511+00	2021-11-08 10:19:17.697+00
2377	\N	died	2021-11-08 10:18:39.078+00	\N	\N	2021-11-08 10:19:17.677+00	2021-11-08 10:19:18.037+00
2632	\N	died	2021-11-08 10:18:39.916+00	\N	\N	2021-11-08 10:19:22.892+00	2021-11-08 10:19:23.03+00
2395	\N	died	2021-11-08 10:18:39.148+00	\N	\N	2021-11-08 10:19:18.02+00	2021-11-08 10:19:18.333+00
3805	\N	died	2021-11-08 10:18:50.097+00	\N	\N	2021-11-08 10:19:49.541+00	2021-11-08 10:19:49.697+00
2409	\N	died	2021-11-08 10:18:39.184+00	\N	\N	2021-11-08 10:19:18.31+00	2021-11-08 10:19:18.754+00
2426	\N	died	2021-11-08 10:18:39.24+00	\N	\N	2021-11-08 10:19:18.687+00	2021-11-08 10:19:18.991+00
2637	\N	died	2021-11-08 10:18:39.929+00	\N	\N	2021-11-08 10:19:23.025+00	2021-11-08 10:19:23.297+00
2441	\N	died	2021-11-08 10:18:39.272+00	\N	\N	2021-11-08 10:19:18.933+00	2021-11-08 10:19:19.384+00
3999	\N	died	2021-11-08 10:18:56.15+00	\N	\N	2021-11-08 10:19:53.965+00	2021-11-08 10:19:54.226+00
2458	\N	died	2021-11-08 10:18:39.318+00	\N	\N	2021-11-08 10:19:19.326+00	2021-11-08 10:19:19.656+00
2474	\N	died	2021-11-08 10:18:39.365+00	\N	\N	2021-11-08 10:19:19.638+00	2021-11-08 10:19:20.03+00
3810	\N	died	2021-11-08 10:18:50.213+00	\N	\N	2021-11-08 10:19:49.673+00	2021-11-08 10:19:50.027+00
2491	\N	died	2021-11-08 10:18:39.408+00	\N	\N	2021-11-08 10:19:20.025+00	2021-11-08 10:19:20.226+00
2497	\N	died	2021-11-08 10:18:39.429+00	\N	\N	2021-11-08 10:19:20.117+00	2021-11-08 10:19:20.445+00
2647	\N	died	2021-11-08 10:18:39.975+00	\N	\N	2021-11-08 10:19:23.195+00	2021-11-08 10:19:23.553+00
3826	\N	died	2021-11-08 10:18:50.713+00	\N	\N	2021-11-08 10:19:49.994+00	2021-11-08 10:19:50.162+00
2662	\N	died	2021-11-08 10:18:40.025+00	\N	\N	2021-11-08 10:19:23.549+00	2021-11-08 10:19:23.793+00
3960	\N	died	2021-11-08 10:18:55.105+00	\N	\N	2021-11-08 10:19:52.974+00	2021-11-08 10:19:53.043+00
2671	\N	died	2021-11-08 10:18:40.067+00	\N	\N	2021-11-08 10:19:23.752+00	2021-11-08 10:19:24.106+00
2689	\N	died	2021-11-08 10:18:40.114+00	\N	\N	2021-11-08 10:19:24.101+00	2021-11-08 10:19:24.338+00
3832	\N	died	2021-11-08 10:18:50.913+00	\N	\N	2021-11-08 10:19:50.141+00	2021-11-08 10:19:50.477+00
2695	\N	died	2021-11-08 10:18:40.154+00	\N	\N	2021-11-08 10:19:24.255+00	2021-11-08 10:19:24.668+00
2713	\N	died	2021-11-08 10:18:40.2+00	\N	\N	2021-11-08 10:19:24.664+00	2021-11-08 10:19:24.831+00
2723	\N	died	2021-11-08 10:18:40.233+00	\N	\N	2021-11-08 10:19:24.827+00	2021-11-08 10:19:24.93+00
3846	\N	died	2021-11-08 10:18:51.363+00	\N	\N	2021-11-08 10:19:50.456+00	2021-11-08 10:19:50.938+00
2725	\N	died	2021-11-08 10:18:40.239+00	\N	\N	2021-11-08 10:19:24.926+00	2021-11-08 10:19:25.001+00
2729	\N	died	2021-11-08 10:18:40.26+00	\N	\N	2021-11-08 10:19:24.997+00	2021-11-08 10:19:25.118+00
2733	\N	died	2021-11-08 10:18:40.272+00	\N	\N	2021-11-08 10:19:25.114+00	2021-11-08 10:19:25.269+00
3862	\N	died	2021-11-08 10:18:51.822+00	\N	\N	2021-11-08 10:19:50.866+00	2021-11-08 10:19:51.156+00
2740	\N	died	2021-11-08 10:18:40.301+00	\N	\N	2021-11-08 10:19:25.264+00	2021-11-08 10:19:25.36+00
3964	\N	died	2021-11-08 10:18:55.24+00	\N	\N	2021-11-08 10:19:53.038+00	2021-11-08 10:19:53.152+00
2743	\N	died	2021-11-08 10:18:40.317+00	\N	\N	2021-11-08 10:19:25.356+00	2021-11-08 10:19:25.413+00
2747	\N	died	2021-11-08 10:18:40.323+00	\N	\N	2021-11-08 10:19:25.409+00	2021-11-08 10:19:25.452+00
3876	\N	died	2021-11-08 10:18:52.305+00	\N	\N	2021-11-08 10:19:51.152+00	2021-11-08 10:19:51.373+00
2749	\N	died	2021-11-08 10:18:40.333+00	\N	\N	2021-11-08 10:19:25.447+00	2021-11-08 10:19:25.598+00
3881	\N	died	2021-11-08 10:18:52.532+00	\N	\N	2021-11-08 10:19:51.237+00	2021-11-08 10:19:51.439+00
3890	\N	died	2021-11-08 10:18:52.925+00	\N	\N	2021-11-08 10:19:51.435+00	2021-11-08 10:19:51.571+00
3967	\N	died	2021-11-08 10:18:55.338+00	\N	\N	2021-11-08 10:19:53.149+00	2021-11-08 10:19:53.203+00
3895	\N	died	2021-11-08 10:18:53.184+00	\N	\N	2021-11-08 10:19:51.566+00	2021-11-08 10:19:51.844+00
4041	\N	died	2021-11-08 10:18:56.941+00	\N	\N	2021-11-08 10:19:54.832+00	2021-11-08 10:19:55.288+00
3905	\N	died	2021-11-08 10:18:53.58+00	\N	\N	2021-11-08 10:19:51.823+00	2021-11-08 10:19:52.245+00
4008	\N	died	2021-11-08 10:18:56.322+00	\N	\N	2021-11-08 10:19:54.16+00	2021-11-08 10:19:54.421+00
3921	\N	died	2021-11-08 10:18:53.972+00	\N	\N	2021-11-08 10:19:52.142+00	2021-11-08 10:19:52.579+00
3970	\N	died	2021-11-08 10:18:55.456+00	\N	\N	2021-11-08 10:19:53.2+00	2021-11-08 10:19:53.503+00
3977	\N	died	2021-11-08 10:18:55.705+00	\N	\N	2021-11-08 10:19:53.317+00	2021-11-08 10:19:53.652+00
4059	\N	died	2021-11-08 10:18:57.273+00	\N	\N	2021-11-08 10:19:55.234+00	2021-11-08 10:19:55.48+00
3988	\N	died	2021-11-08 10:18:55.985+00	\N	\N	2021-11-08 10:19:53.648+00	2021-11-08 10:19:53.777+00
3991	\N	died	2021-11-08 10:18:56.03+00	\N	\N	2021-11-08 10:19:53.741+00	2021-11-08 10:19:53.969+00
4021	\N	died	2021-11-08 10:18:56.572+00	\N	\N	2021-11-08 10:19:54.417+00	2021-11-08 10:19:54.611+00
4028	\N	died	2021-11-08 10:18:56.724+00	\N	\N	2021-11-08 10:19:54.573+00	2021-11-08 10:19:54.888+00
5643	\N	died	2021-11-08 10:19:50.69+00	\N	\N	2021-11-08 10:20:39.931+00	2021-11-08 10:20:40.697+00
4068	\N	died	2021-11-08 10:18:57.49+00	\N	\N	2021-11-08 10:19:55.425+00	2021-11-08 10:19:55.813+00
5693	\N	died	2021-11-08 10:19:51.433+00	\N	\N	2021-11-08 10:20:41.408+00	2021-11-08 10:20:41.827+00
4078	\N	died	2021-11-08 10:18:57.716+00	\N	\N	2021-11-08 10:19:55.79+00	2021-11-08 10:19:56.03+00
4088	\N	died	2021-11-08 10:18:57.92+00	\N	\N	2021-11-08 10:19:56.026+00	2021-11-08 10:19:56.221+00
5662	\N	died	2021-11-08 10:19:51.115+00	\N	\N	2021-11-08 10:20:40.639+00	2021-11-08 10:20:40.987+00
4096	\N	died	2021-11-08 10:18:58.091+00	\N	\N	2021-11-08 10:19:56.216+00	2021-11-08 10:19:56.343+00
4101	\N	died	2021-11-08 10:18:58.157+00	\N	\N	2021-11-08 10:19:56.34+00	2021-11-08 10:19:56.376+00
5671	\N	died	2021-11-08 10:19:51.202+00	\N	\N	2021-11-08 10:20:40.881+00	2021-11-08 10:20:41.299+00
4103	\N	died	2021-11-08 10:18:58.163+00	\N	\N	2021-11-08 10:19:56.373+00	2021-11-08 10:19:56.43+00
5705	\N	died	2021-11-08 10:19:51.632+00	\N	\N	2021-11-08 10:20:41.691+00	2021-11-08 10:20:42.626+00
5684	\N	died	2021-11-08 10:19:51.351+00	\N	\N	2021-11-08 10:20:41.2+00	2021-11-08 10:20:41.454+00
5748	\N	died	2021-11-08 10:19:52.673+00	\N	\N	2021-11-08 10:20:43.148+00	2021-11-08 10:20:43.511+00
5722	\N	died	2021-11-08 10:19:52.107+00	\N	\N	2021-11-08 10:20:42.156+00	2021-11-08 10:20:42.844+00
5762	\N	died	2021-11-08 10:19:52.941+00	\N	\N	2021-11-08 10:20:43.493+00	2021-11-08 10:20:43.777+00
5735	\N	died	2021-11-08 10:19:52.374+00	\N	\N	2021-11-08 10:20:42.84+00	2021-11-08 10:20:42.994+00
5772	\N	died	2021-11-08 10:19:53.165+00	\N	\N	2021-11-08 10:20:43.74+00	2021-11-08 10:20:44.087+00
2172	\N	died	2021-11-08 10:18:37.871+00	\N	\N	2021-11-08 10:19:13.536+00	2021-11-08 10:19:13.573+00
2571	\N	died	2021-11-08 10:18:39.722+00	\N	\N	2021-11-08 10:19:21.637+00	2021-11-08 10:19:22.125+00
2174	\N	died	2021-11-08 10:18:37.881+00	\N	\N	2021-11-08 10:19:13.569+00	2021-11-08 10:19:13.689+00
2178	\N	died	2021-11-08 10:18:37.895+00	\N	\N	2021-11-08 10:19:13.684+00	2021-11-08 10:19:13.745+00
2182	\N	died	2021-11-08 10:18:37.908+00	\N	\N	2021-11-08 10:19:13.741+00	2021-11-08 10:19:13.803+00
2591	\N	died	2021-11-08 10:18:39.787+00	\N	\N	2021-11-08 10:19:22.022+00	2021-11-08 10:19:22.562+00
2185	\N	died	2021-11-08 10:18:37.92+00	\N	\N	2021-11-08 10:19:13.796+00	2021-11-08 10:19:14.022+00
2193	\N	died	2021-11-08 10:18:37.948+00	\N	\N	2021-11-08 10:19:13.984+00	2021-11-08 10:19:14.357+00
2208	\N	died	2021-11-08 10:18:38.01+00	\N	\N	2021-11-08 10:19:14.354+00	2021-11-08 10:19:14.541+00
2609	\N	died	2021-11-08 10:18:39.847+00	\N	\N	2021-11-08 10:19:22.422+00	2021-11-08 10:19:22.633+00
2215	\N	died	2021-11-08 10:18:38.033+00	\N	\N	2021-11-08 10:19:14.471+00	2021-11-08 10:19:15.133+00
3828	\N	died	2021-11-08 10:18:50.83+00	\N	\N	2021-11-08 10:19:50.024+00	2021-11-08 10:19:50.111+00
2235	\N	died	2021-11-08 10:18:38.18+00	\N	\N	2021-11-08 10:19:15.068+00	2021-11-08 10:19:15.367+00
2250	\N	died	2021-11-08 10:18:38.253+00	\N	\N	2021-11-08 10:19:15.312+00	2021-11-08 10:19:15.461+00
2619	\N	died	2021-11-08 10:18:39.881+00	\N	\N	2021-11-08 10:19:22.629+00	2021-11-08 10:19:22.815+00
2259	\N	died	2021-11-08 10:18:38.293+00	\N	\N	2021-11-08 10:19:15.445+00	2021-11-08 10:19:15.884+00
2274	\N	died	2021-11-08 10:18:38.362+00	\N	\N	2021-11-08 10:19:15.798+00	2021-11-08 10:19:16.091+00
2289	\N	died	2021-11-08 10:18:38.452+00	\N	\N	2021-11-08 10:19:16.061+00	2021-11-08 10:19:16.261+00
2625	\N	died	2021-11-08 10:18:39.9+00	\N	\N	2021-11-08 10:19:22.73+00	2021-11-08 10:19:23.103+00
2301	\N	died	2021-11-08 10:18:38.523+00	\N	\N	2021-11-08 10:19:16.246+00	2021-11-08 10:19:16.469+00
2313	\N	died	2021-11-08 10:18:38.572+00	\N	\N	2021-11-08 10:19:16.444+00	2021-11-08 10:19:16.771+00
2329	\N	died	2021-11-08 10:18:38.629+00	\N	\N	2021-11-08 10:19:16.753+00	2021-11-08 10:19:16.951+00
2640	\N	died	2021-11-08 10:18:39.937+00	\N	\N	2021-11-08 10:19:23.075+00	2021-11-08 10:19:23.793+00
2340	\N	died	2021-11-08 10:18:38.682+00	\N	\N	2021-11-08 10:19:16.927+00	2021-11-08 10:19:17.314+00
3830	\N	died	2021-11-08 10:18:50.88+00	\N	\N	2021-11-08 10:19:50.107+00	2021-11-08 10:19:50.196+00
2356	\N	died	2021-11-08 10:18:38.965+00	\N	\N	2021-11-08 10:19:17.318+00	2021-11-08 10:19:17.697+00
2370	\N	died	2021-11-08 10:18:39.031+00	\N	\N	2021-11-08 10:19:17.561+00	2021-11-08 10:19:17.768+00
2666	\N	died	2021-11-08 10:18:40.046+00	\N	\N	2021-11-08 10:19:23.612+00	2021-11-08 10:19:23.842+00
2381	\N	died	2021-11-08 10:18:39.098+00	\N	\N	2021-11-08 10:19:17.743+00	2021-11-08 10:19:17.981+00
3978	\N	died	2021-11-08 10:18:55.74+00	\N	\N	2021-11-08 10:19:53.384+00	2021-11-08 10:19:53.777+00
2388	\N	died	2021-11-08 10:18:39.121+00	\N	\N	2021-11-08 10:19:17.862+00	2021-11-08 10:19:18.267+00
2403	\N	died	2021-11-08 10:18:39.166+00	\N	\N	2021-11-08 10:19:18.209+00	2021-11-08 10:19:18.416+00
2676	\N	died	2021-11-08 10:18:40.085+00	\N	\N	2021-11-08 10:19:23.838+00	2021-11-08 10:19:23.893+00
2412	\N	died	2021-11-08 10:18:39.197+00	\N	\N	2021-11-08 10:19:18.412+00	2021-11-08 10:19:18.538+00
2418	\N	died	2021-11-08 10:18:39.209+00	\N	\N	2021-11-08 10:19:18.502+00	2021-11-08 10:19:18.771+00
2431	\N	died	2021-11-08 10:18:39.246+00	\N	\N	2021-11-08 10:19:18.766+00	2021-11-08 10:19:18.823+00
2679	\N	died	2021-11-08 10:18:40.093+00	\N	\N	2021-11-08 10:19:23.889+00	2021-11-08 10:19:24.091+00
2434	\N	died	2021-11-08 10:18:39.253+00	\N	\N	2021-11-08 10:19:18.818+00	2021-11-08 10:19:18.991+00
3835	\N	died	2021-11-08 10:18:51.089+00	\N	\N	2021-11-08 10:19:50.193+00	2021-11-08 10:19:50.477+00
2440	\N	died	2021-11-08 10:18:39.272+00	\N	\N	2021-11-08 10:19:18.917+00	2021-11-08 10:19:19.297+00
2456	\N	died	2021-11-08 10:18:39.318+00	\N	\N	2021-11-08 10:19:19.288+00	2021-11-08 10:19:19.442+00
2684	\N	died	2021-11-08 10:18:40.104+00	\N	\N	2021-11-08 10:19:24.019+00	2021-11-08 10:19:24.338+00
2463	\N	died	2021-11-08 10:18:39.338+00	\N	\N	2021-11-08 10:19:19.413+00	2021-11-08 10:19:19.592+00
2470	\N	died	2021-11-08 10:18:39.352+00	\N	\N	2021-11-08 10:19:19.567+00	2021-11-08 10:19:19.896+00
2486	\N	died	2021-11-08 10:18:39.397+00	\N	\N	2021-11-08 10:19:19.892+00	2021-11-08 10:19:20.091+00
2696	\N	died	2021-11-08 10:18:40.154+00	\N	\N	2021-11-08 10:19:24.267+00	2021-11-08 10:19:24.53+00
2493	\N	died	2021-11-08 10:18:39.413+00	\N	\N	2021-11-08 10:19:20.052+00	2021-11-08 10:19:20.583+00
2517	\N	died	2021-11-08 10:18:39.511+00	\N	\N	2021-11-08 10:19:20.559+00	2021-11-08 10:19:20.923+00
2529	\N	died	2021-11-08 10:18:39.551+00	\N	\N	2021-11-08 10:19:20.804+00	2021-11-08 10:19:21.196+00
3843	\N	died	2021-11-08 10:18:51.347+00	\N	\N	2021-11-08 10:19:50.408+00	2021-11-08 10:19:50.938+00
2547	\N	died	2021-11-08 10:18:39.643+00	\N	\N	2021-11-08 10:19:21.192+00	2021-11-08 10:19:21.348+00
2554	\N	died	2021-11-08 10:18:39.66+00	\N	\N	2021-11-08 10:19:21.309+00	2021-11-08 10:19:21.674+00
2707	\N	died	2021-11-08 10:18:40.182+00	\N	\N	2021-11-08 10:19:24.509+00	2021-11-08 10:19:24.831+00
3864	\N	died	2021-11-08 10:18:51.939+00	\N	\N	2021-11-08 10:19:50.9+00	2021-11-08 10:19:51.373+00
2719	\N	died	2021-11-08 10:18:40.228+00	\N	\N	2021-11-08 10:19:24.763+00	2021-11-08 10:19:25.118+00
3992	\N	died	2021-11-08 10:18:56.047+00	\N	\N	2021-11-08 10:19:53.758+00	2021-11-08 10:19:54.226+00
2732	\N	died	2021-11-08 10:18:40.268+00	\N	\N	2021-11-08 10:19:25.047+00	2021-11-08 10:19:25.36+00
2742	\N	died	2021-11-08 10:18:40.31+00	\N	\N	2021-11-08 10:19:25.337+00	2021-11-08 10:19:25.467+00
3882	\N	died	2021-11-08 10:18:52.616+00	\N	\N	2021-11-08 10:19:51.303+00	2021-11-08 10:19:51.471+00
2750	\N	died	2021-11-08 10:18:40.338+00	\N	\N	2021-11-08 10:19:25.464+00	2021-11-08 10:19:25.809+00
4065	\N	died	2021-11-08 10:18:57.431+00	\N	\N	2021-11-08 10:19:55.325+00	2021-11-08 10:19:55.979+00
2758	\N	died	2021-11-08 10:18:40.364+00	\N	\N	2021-11-08 10:19:25.648+00	2021-11-08 10:19:25.912+00
2770	\N	died	2021-11-08 10:18:40.411+00	\N	\N	2021-11-08 10:19:25.907+00	2021-11-08 10:19:26.039+00
3892	\N	died	2021-11-08 10:18:52.988+00	\N	\N	2021-11-08 10:19:51.468+00	2021-11-08 10:19:51.844+00
2775	\N	died	2021-11-08 10:18:40.432+00	\N	\N	2021-11-08 10:19:26.035+00	2021-11-08 10:19:26.155+00
2782	\N	died	2021-11-08 10:18:40.451+00	\N	\N	2021-11-08 10:19:26.151+00	2021-11-08 10:19:26.189+00
2784	\N	died	2021-11-08 10:18:40.462+00	\N	\N	2021-11-08 10:19:26.185+00	2021-11-08 10:19:26.313+00
3900	\N	died	2021-11-08 10:18:53.543+00	\N	\N	2021-11-08 10:19:51.654+00	2021-11-08 10:19:51.928+00
2788	\N	died	2021-11-08 10:18:40.479+00	\N	\N	2021-11-08 10:19:26.308+00	2021-11-08 10:19:26.372+00
4006	\N	died	2021-11-08 10:18:56.272+00	\N	\N	2021-11-08 10:19:54.124+00	2021-11-08 10:19:54.353+00
2792	\N	died	2021-11-08 10:18:40.486+00	\N	\N	2021-11-08 10:19:26.368+00	2021-11-08 10:19:26.508+00
2797	\N	died	2021-11-08 10:18:40.497+00	\N	\N	2021-11-08 10:19:26.504+00	2021-11-08 10:19:26.606+00
3911	\N	died	2021-11-08 10:18:53.716+00	\N	\N	2021-11-08 10:19:51.923+00	2021-11-08 10:19:52.095+00
2803	\N	died	2021-11-08 10:18:40.511+00	\N	\N	2021-11-08 10:19:26.602+00	2021-11-08 10:19:26.639+00
2805	\N	died	2021-11-08 10:18:40.517+00	\N	\N	2021-11-08 10:19:26.634+00	2021-11-08 10:19:26.759+00
3916	\N	died	2021-11-08 10:18:53.88+00	\N	\N	2021-11-08 10:19:52.058+00	2021-11-08 10:19:52.336+00
3928	\N	died	2021-11-08 10:18:54.122+00	\N	\N	2021-11-08 10:19:52.3+00	2021-11-08 10:19:52.579+00
4017	\N	died	2021-11-08 10:18:56.492+00	\N	\N	2021-11-08 10:19:54.348+00	2021-11-08 10:19:54.405+00
3938	\N	died	2021-11-08 10:18:54.439+00	\N	\N	2021-11-08 10:19:52.508+00	2021-11-08 10:19:52.712+00
3947	\N	died	2021-11-08 10:18:54.663+00	\N	\N	2021-11-08 10:19:52.708+00	2021-11-08 10:19:52.845+00
4082	\N	died	2021-11-08 10:18:57.78+00	\N	\N	2021-11-08 10:19:55.933+00	2021-11-08 10:19:56.343+00
3952	\N	died	2021-11-08 10:18:54.814+00	\N	\N	2021-11-08 10:19:52.796+00	2021-11-08 10:19:53.503+00
4020	\N	died	2021-11-08 10:18:56.558+00	\N	\N	2021-11-08 10:19:54.398+00	2021-11-08 10:19:54.611+00
4099	\N	died	2021-11-08 10:18:58.142+00	\N	\N	2021-11-08 10:19:56.265+00	2021-11-08 10:19:56.513+00
4026	\N	died	2021-11-08 10:18:56.691+00	\N	\N	2021-11-08 10:19:54.549+00	2021-11-08 10:19:54.888+00
5637	\N	died	2021-11-08 10:19:50.541+00	\N	\N	2021-11-08 10:20:39.831+00	2021-11-08 10:20:40.378+00
4038	\N	died	2021-11-08 10:18:56.923+00	\N	\N	2021-11-08 10:19:54.782+00	2021-11-08 10:19:55.205+00
4054	\N	died	2021-11-08 10:18:57.181+00	\N	\N	2021-11-08 10:19:55.101+00	2021-11-08 10:19:55.345+00
4111	\N	died	2021-11-08 10:18:58.178+00	\N	\N	2021-11-08 10:19:56.507+00	2021-11-08 10:19:56.663+00
5645	\N	died	2021-11-08 10:19:50.709+00	\N	\N	2021-11-08 10:20:40.036+00	2021-11-08 10:20:40.447+00
4121	\N	died	2021-11-08 10:18:58.289+00	\N	\N	2021-11-08 10:19:56.659+00	2021-11-08 10:19:56.694+00
5688	\N	died	2021-11-08 10:19:51.368+00	\N	\N	2021-11-08 10:20:41.306+00	2021-11-08 10:20:41.564+00
4123	\N	died	2021-11-08 10:18:58.325+00	\N	\N	2021-11-08 10:19:56.69+00	2021-11-08 10:19:56.761+00
4127	\N	died	2021-11-08 10:18:58.387+00	\N	\N	2021-11-08 10:19:56.756+00	2021-11-08 10:19:56.828+00
5655	\N	died	2021-11-08 10:19:50.965+00	\N	\N	2021-11-08 10:20:40.441+00	2021-11-08 10:20:40.631+00
4131	\N	died	2021-11-08 10:18:58.467+00	\N	\N	2021-11-08 10:19:56.823+00	2021-11-08 10:19:56.896+00
5696	\N	died	2021-11-08 10:19:51.465+00	\N	\N	2021-11-08 10:20:41.551+00	2021-11-08 10:20:41.827+00
4135	\N	died	2021-11-08 10:18:58.548+00	\N	\N	2021-11-08 10:19:56.893+00	2021-11-08 10:19:56.993+00
5659	\N	died	2021-11-08 10:19:51.082+00	\N	\N	2021-11-08 10:20:40.582+00	2021-11-08 10:20:40.987+00
5673	\N	died	2021-11-08 10:19:51.217+00	\N	\N	2021-11-08 10:20:40.931+00	2021-11-08 10:20:41.381+00
5703	\N	died	2021-11-08 10:19:51.599+00	\N	\N	2021-11-08 10:20:41.673+00	2021-11-08 10:20:41.973+00
5759	\N	died	2021-11-08 10:19:52.841+00	\N	\N	2021-11-08 10:20:43.443+00	2021-11-08 10:20:43.535+00
5716	\N	died	2021-11-08 10:19:52.007+00	\N	\N	2021-11-08 10:20:41.965+00	2021-11-08 10:20:42.626+00
5723	\N	died	2021-11-08 10:19:52.141+00	\N	\N	2021-11-08 10:20:42.177+00	2021-11-08 10:20:42.994+00
5742	\N	died	2021-11-08 10:19:52.524+00	\N	\N	2021-11-08 10:20:42.973+00	2021-11-08 10:20:43.285+00
5755	\N	died	2021-11-08 10:19:52.793+00	\N	\N	2021-11-08 10:20:43.281+00	2021-11-08 10:20:43.448+00
2249	\N	died	2021-11-08 10:18:38.248+00	\N	\N	2021-11-08 10:19:15.297+00	2021-11-08 10:19:15.367+00
2253	\N	died	2021-11-08 10:18:38.27+00	\N	\N	2021-11-08 10:19:15.362+00	2021-11-08 10:19:15.461+00
2257	\N	died	2021-11-08 10:18:38.281+00	\N	\N	2021-11-08 10:19:15.421+00	2021-11-08 10:19:15.68+00
2270	\N	died	2021-11-08 10:18:38.344+00	\N	\N	2021-11-08 10:19:15.675+00	2021-11-08 10:19:15.916+00
2658	\N	died	2021-11-08 10:18:40.01+00	\N	\N	2021-11-08 10:19:23.426+00	2021-11-08 10:19:23.793+00
2280	\N	died	2021-11-08 10:18:38.396+00	\N	\N	2021-11-08 10:19:15.892+00	2021-11-08 10:19:15.963+00
2284	\N	died	2021-11-08 10:18:38.408+00	\N	\N	2021-11-08 10:19:15.959+00	2021-11-08 10:19:16.091+00
2290	\N	died	2021-11-08 10:18:38.463+00	\N	\N	2021-11-08 10:19:16.073+00	2021-11-08 10:19:16.283+00
2670	\N	died	2021-11-08 10:18:40.067+00	\N	\N	2021-11-08 10:19:23.73+00	2021-11-08 10:19:24.091+00
2303	\N	died	2021-11-08 10:18:38.529+00	\N	\N	2021-11-08 10:19:16.279+00	2021-11-08 10:19:16.329+00
3849	\N	died	2021-11-08 10:18:51.502+00	\N	\N	2021-11-08 10:19:50.508+00	2021-11-08 10:19:50.628+00
2306	\N	died	2021-11-08 10:18:38.536+00	\N	\N	2021-11-08 10:19:16.325+00	2021-11-08 10:19:16.469+00
2312	\N	died	2021-11-08 10:18:38.566+00	\N	\N	2021-11-08 10:19:16.426+00	2021-11-08 10:19:16.771+00
2687	\N	died	2021-11-08 10:18:40.114+00	\N	\N	2021-11-08 10:19:24.073+00	2021-11-08 10:19:24.465+00
2327	\N	died	2021-11-08 10:18:38.618+00	\N	\N	2021-11-08 10:19:16.721+00	2021-11-08 10:19:16.825+00
3994	\N	died	2021-11-08 10:18:56.081+00	\N	\N	2021-11-08 10:19:53.841+00	2021-11-08 10:19:54.072+00
2333	\N	died	2021-11-08 10:18:38.65+00	\N	\N	2021-11-08 10:19:16.821+00	2021-11-08 10:19:16.951+00
2339	\N	died	2021-11-08 10:18:38.679+00	\N	\N	2021-11-08 10:19:16.914+00	2021-11-08 10:19:17.314+00
2703	\N	died	2021-11-08 10:18:40.171+00	\N	\N	2021-11-08 10:19:24.442+00	2021-11-08 10:19:24.55+00
2355	\N	died	2021-11-08 10:18:38.962+00	\N	\N	2021-11-08 10:19:17.314+00	2021-11-08 10:19:17.697+00
2374	\N	died	2021-11-08 10:18:39.052+00	\N	\N	2021-11-08 10:19:17.63+00	2021-11-08 10:19:17.981+00
2389	\N	died	2021-11-08 10:18:39.121+00	\N	\N	2021-11-08 10:19:17.925+00	2021-11-08 10:19:18.333+00
2709	\N	died	2021-11-08 10:18:40.187+00	\N	\N	2021-11-08 10:19:24.545+00	2021-11-08 10:19:24.681+00
2407	\N	died	2021-11-08 10:18:39.178+00	\N	\N	2021-11-08 10:19:18.275+00	2021-11-08 10:19:18.538+00
3853	\N	died	2021-11-08 10:18:51.576+00	\N	\N	2021-11-08 10:19:50.625+00	2021-11-08 10:19:50.713+00
2416	\N	died	2021-11-08 10:18:39.203+00	\N	\N	2021-11-08 10:19:18.466+00	2021-11-08 10:19:18.754+00
2427	\N	died	2021-11-08 10:18:39.24+00	\N	\N	2021-11-08 10:19:18.7+00	2021-11-08 10:19:18.991+00
2714	\N	died	2021-11-08 10:18:40.2+00	\N	\N	2021-11-08 10:19:24.676+00	2021-11-08 10:19:24.899+00
2443	\N	died	2021-11-08 10:18:39.278+00	\N	\N	2021-11-08 10:19:18.968+00	2021-11-08 10:19:19.396+00
2462	\N	died	2021-11-08 10:18:39.331+00	\N	\N	2021-11-08 10:19:19.392+00	2021-11-08 10:19:19.454+00
2466	\N	died	2021-11-08 10:18:39.345+00	\N	\N	2021-11-08 10:19:19.45+00	2021-11-08 10:19:19.592+00
2724	\N	died	2021-11-08 10:18:40.239+00	\N	\N	2021-11-08 10:19:24.895+00	2021-11-08 10:19:25.001+00
2469	\N	died	2021-11-08 10:18:39.352+00	\N	\N	2021-11-08 10:19:19.55+00	2021-11-08 10:19:19.757+00
2477	\N	died	2021-11-08 10:18:39.372+00	\N	\N	2021-11-08 10:19:19.687+00	2021-11-08 10:19:20.017+00
2487	\N	died	2021-11-08 10:18:39.397+00	\N	\N	2021-11-08 10:19:19.959+00	2021-11-08 10:19:20.226+00
2727	\N	died	2021-11-08 10:18:40.25+00	\N	\N	2021-11-08 10:19:24.967+00	2021-11-08 10:19:25.269+00
2499	\N	died	2021-11-08 10:18:39.438+00	\N	\N	2021-11-08 10:19:20.205+00	2021-11-08 10:19:20.532+00
3857	\N	died	2021-11-08 10:18:51.705+00	\N	\N	2021-11-08 10:19:50.691+00	2021-11-08 10:19:51.207+00
2515	\N	died	2021-11-08 10:18:39.506+00	\N	\N	2021-11-08 10:19:20.528+00	2021-11-08 10:19:20.7+00
2522	\N	died	2021-11-08 10:18:39.527+00	\N	\N	2021-11-08 10:19:20.696+00	2021-11-08 10:19:20.923+00
2737	\N	died	2021-11-08 10:18:40.284+00	\N	\N	2021-11-08 10:19:25.214+00	2021-11-08 10:19:25.598+00
2532	\N	died	2021-11-08 10:18:39.567+00	\N	\N	2021-11-08 10:19:20.906+00	2021-11-08 10:19:21.348+00
2553	\N	died	2021-11-08 10:18:39.66+00	\N	\N	2021-11-08 10:19:21.296+00	2021-11-08 10:19:21.674+00
2569	\N	died	2021-11-08 10:18:39.706+00	\N	\N	2021-11-08 10:19:21.601+00	2021-11-08 10:19:21.892+00
2754	\N	died	2021-11-08 10:18:40.353+00	\N	\N	2021-11-08 10:19:25.581+00	2021-11-08 10:19:25.821+00
2583	\N	died	2021-11-08 10:18:39.754+00	\N	\N	2021-11-08 10:19:21.888+00	2021-11-08 10:19:22.125+00
2590	\N	died	2021-11-08 10:18:39.782+00	\N	\N	2021-11-08 10:19:22.003+00	2021-11-08 10:19:22.407+00
3878	\N	died	2021-11-08 10:18:52.39+00	\N	\N	2021-11-08 10:19:51.185+00	2021-11-08 10:19:51.407+00
2607	\N	died	2021-11-08 10:18:39.835+00	\N	\N	2021-11-08 10:19:22.384+00	2021-11-08 10:19:22.815+00
4002	\N	died	2021-11-08 10:18:56.214+00	\N	\N	2021-11-08 10:19:54.068+00	2021-11-08 10:19:54.226+00
2624	\N	died	2021-11-08 10:18:39.896+00	\N	\N	2021-11-08 10:19:22.711+00	2021-11-08 10:19:23.049+00
2638	\N	died	2021-11-08 10:18:39.932+00	\N	\N	2021-11-08 10:19:23.045+00	2021-11-08 10:19:23.297+00
3887	\N	died	2021-11-08 10:18:52.756+00	\N	\N	2021-11-08 10:19:51.379+00	2021-11-08 10:19:51.603+00
2648	\N	died	2021-11-08 10:18:39.977+00	\N	\N	2021-11-08 10:19:23.261+00	2021-11-08 10:19:23.53+00
2765	\N	died	2021-11-08 10:18:40.387+00	\N	\N	2021-11-08 10:19:25.817+00	2021-11-08 10:19:25.89+00
4095	\N	died	2021-11-08 10:18:58.089+00	\N	\N	2021-11-08 10:19:56.201+00	2021-11-08 10:19:56.612+00
2769	\N	died	2021-11-08 10:18:40.403+00	\N	\N	2021-11-08 10:19:25.884+00	2021-11-08 10:19:26.039+00
2773	\N	died	2021-11-08 10:18:40.425+00	\N	\N	2021-11-08 10:19:25.956+00	2021-11-08 10:19:26.256+00
3897	\N	died	2021-11-08 10:18:53.339+00	\N	\N	2021-11-08 10:19:51.599+00	2021-11-08 10:19:51.878+00
2785	\N	died	2021-11-08 10:18:40.462+00	\N	\N	2021-11-08 10:19:26.253+00	2021-11-08 10:19:26.372+00
2790	\N	died	2021-11-08 10:18:40.479+00	\N	\N	2021-11-08 10:19:26.336+00	2021-11-08 10:19:26.606+00
2800	\N	died	2021-11-08 10:18:40.504+00	\N	\N	2021-11-08 10:19:26.553+00	2021-11-08 10:19:27.017+00
3907	\N	died	2021-11-08 10:18:53.613+00	\N	\N	2021-11-08 10:19:51.857+00	2021-11-08 10:19:52.028+00
2818	\N	died	2021-11-08 10:18:40.555+00	\N	\N	2021-11-08 10:19:26.947+00	2021-11-08 10:19:27.24+00
4011	\N	died	2021-11-08 10:18:56.372+00	\N	\N	2021-11-08 10:19:54.208+00	2021-11-08 10:19:54.611+00
2833	\N	died	2021-11-08 10:18:40.588+00	\N	\N	2021-11-08 10:19:27.235+00	2021-11-08 10:19:27.439+00
2842	\N	died	2021-11-08 10:18:40.612+00	\N	\N	2021-11-08 10:19:27.435+00	2021-11-08 10:19:27.473+00
3913	\N	died	2021-11-08 10:18:53.747+00	\N	\N	2021-11-08 10:19:52.007+00	2021-11-08 10:19:52.245+00
2844	\N	died	2021-11-08 10:18:40.62+00	\N	\N	2021-11-08 10:19:27.469+00	2021-11-08 10:19:27.515+00
2847	\N	died	2021-11-08 10:18:40.629+00	\N	\N	2021-11-08 10:19:27.511+00	2021-11-08 10:19:27.633+00
2851	\N	died	2021-11-08 10:18:40.644+00	\N	\N	2021-11-08 10:19:27.631+00	2021-11-08 10:19:27.689+00
3922	\N	died	2021-11-08 10:18:54.006+00	\N	\N	2021-11-08 10:19:52.158+00	2021-11-08 10:19:52.694+00
2855	\N	died	2021-11-08 10:18:40.65+00	\N	\N	2021-11-08 10:19:27.685+00	2021-11-08 10:19:27.789+00
2861	\N	died	2021-11-08 10:18:40.665+00	\N	\N	2021-11-08 10:19:27.785+00	2021-11-08 10:19:27.939+00
3943	\N	died	2021-11-08 10:18:54.506+00	\N	\N	2021-11-08 10:19:52.591+00	2021-11-08 10:19:52.845+00
4029	\N	died	2021-11-08 10:18:56.739+00	\N	\N	2021-11-08 10:19:54.593+00	2021-11-08 10:19:54.888+00
3950	\N	died	2021-11-08 10:18:54.731+00	\N	\N	2021-11-08 10:19:52.758+00	2021-11-08 10:19:53.01+00
3961	\N	died	2021-11-08 10:18:55.139+00	\N	\N	2021-11-08 10:19:52.991+00	2021-11-08 10:19:53.203+00
4115	\N	died	2021-11-08 10:18:58.186+00	\N	\N	2021-11-08 10:19:56.557+00	2021-11-08 10:19:56.896+00
3969	\N	died	2021-11-08 10:18:55.423+00	\N	\N	2021-11-08 10:19:53.183+00	2021-11-08 10:19:53.503+00
5654	\N	died	2021-11-08 10:19:50.948+00	\N	\N	2021-11-08 10:20:40.415+00	2021-11-08 10:20:40.548+00
3979	\N	died	2021-11-08 10:18:55.773+00	\N	\N	2021-11-08 10:19:53.399+00	2021-11-08 10:19:53.938+00
4042	\N	died	2021-11-08 10:18:56.972+00	\N	\N	2021-11-08 10:19:54.85+00	2021-11-08 10:19:55.288+00
4134	\N	died	2021-11-08 10:18:58.516+00	\N	\N	2021-11-08 10:19:56.874+00	2021-11-08 10:19:57.089+00
4061	\N	died	2021-11-08 10:18:57.398+00	\N	\N	2021-11-08 10:19:55.269+00	2021-11-08 10:19:55.779+00
5692	\N	died	2021-11-08 10:19:51.415+00	\N	\N	2021-11-08 10:20:41.389+00	2021-11-08 10:20:41.649+00
4077	\N	died	2021-11-08 10:18:57.714+00	\N	\N	2021-11-08 10:19:55.775+00	2021-11-08 10:19:55.979+00
4083	\N	died	2021-11-08 10:18:57.814+00	\N	\N	2021-11-08 10:19:55.942+00	2021-11-08 10:19:56.221+00
5657	\N	died	2021-11-08 10:19:50.998+00	\N	\N	2021-11-08 10:20:40.54+00	2021-11-08 10:20:40.631+00
4146	\N	died	2021-11-08 10:18:58.981+00	\N	\N	2021-11-08 10:19:57.085+00	2021-11-08 10:19:57.188+00
4152	\N	died	2021-11-08 10:18:59.165+00	\N	\N	2021-11-08 10:19:57.184+00	2021-11-08 10:19:57.296+00
5661	\N	died	2021-11-08 10:19:51.098+00	\N	\N	2021-11-08 10:20:40.625+00	2021-11-08 10:20:40.823+00
4156	\N	died	2021-11-08 10:18:59.215+00	\N	\N	2021-11-08 10:19:57.293+00	2021-11-08 10:19:57.438+00
4160	\N	died	2021-11-08 10:18:59.298+00	\N	\N	2021-11-08 10:19:57.435+00	2021-11-08 10:19:57.606+00
4169	\N	died	2021-11-08 10:18:59.508+00	\N	\N	2021-11-08 10:19:57.6+00	2021-11-08 10:19:57.702+00
5667	\N	died	2021-11-08 10:19:51.182+00	\N	\N	2021-11-08 10:20:40.807+00	2021-11-08 10:20:40.987+00
5714	\N	died	2021-11-08 10:19:51.907+00	\N	\N	2021-11-08 10:20:41.923+00	2021-11-08 10:20:42.626+00
4175	\N	died	2021-11-08 10:18:59.692+00	\N	\N	2021-11-08 10:19:57.698+00	2021-11-08 10:19:57.736+00
5674	\N	died	2021-11-08 10:19:51.219+00	\N	\N	2021-11-08 10:20:40.947+00	2021-11-08 10:20:41.454+00
5700	\N	died	2021-11-08 10:19:51.553+00	\N	\N	2021-11-08 10:20:41.644+00	2021-11-08 10:20:41.86+00
5710	\N	died	2021-11-08 10:19:51.839+00	\N	\N	2021-11-08 10:20:41.839+00	2021-11-08 10:20:41.959+00
5721	\N	died	2021-11-08 10:19:52.09+00	\N	\N	2021-11-08 10:20:42.14+00	2021-11-08 10:20:42.799+00
5732	\N	died	2021-11-08 10:19:52.316+00	\N	\N	2021-11-08 10:20:42.791+00	2021-11-08 10:20:42.851+00
2354	\N	died	2021-11-08 10:18:38.956+00	\N	\N	2021-11-08 10:19:17.304+00	2021-11-08 10:19:17.539+00
2368	\N	died	2021-11-08 10:18:39.026+00	\N	\N	2021-11-08 10:19:17.536+00	2021-11-08 10:19:17.697+00
2378	\N	died	2021-11-08 10:18:39.081+00	\N	\N	2021-11-08 10:19:17.694+00	2021-11-08 10:19:17.731+00
2380	\N	died	2021-11-08 10:18:39.093+00	\N	\N	2021-11-08 10:19:17.727+00	2021-11-08 10:19:17.829+00
2776	\N	died	2021-11-08 10:18:40.438+00	\N	\N	2021-11-08 10:19:26.056+00	2021-11-08 10:19:26.324+00
2384	\N	died	2021-11-08 10:18:39.107+00	\N	\N	2021-11-08 10:19:17.794+00	2021-11-08 10:19:18.037+00
2394	\N	died	2021-11-08 10:18:39.136+00	\N	\N	2021-11-08 10:19:18+00	2021-11-08 10:19:18.267+00
2405	\N	died	2021-11-08 10:18:39.171+00	\N	\N	2021-11-08 10:19:18.243+00	2021-11-08 10:19:18.674+00
2789	\N	died	2021-11-08 10:18:40.479+00	\N	\N	2021-11-08 10:19:26.319+00	2021-11-08 10:19:26.508+00
2423	\N	died	2021-11-08 10:18:39.226+00	\N	\N	2021-11-08 10:19:18.633+00	2021-11-08 10:19:18.844+00
3875	\N	died	2021-11-08 10:18:52.289+00	\N	\N	2021-11-08 10:19:51.136+00	2021-11-08 10:19:51.207+00
2435	\N	died	2021-11-08 10:18:39.26+00	\N	\N	2021-11-08 10:19:18.838+00	2021-11-08 10:19:18.991+00
2442	\N	died	2021-11-08 10:18:39.278+00	\N	\N	2021-11-08 10:19:18.953+00	2021-11-08 10:19:19.442+00
2794	\N	died	2021-11-08 10:18:40.491+00	\N	\N	2021-11-08 10:19:26.407+00	2021-11-08 10:19:26.824+00
2464	\N	died	2021-11-08 10:18:39.338+00	\N	\N	2021-11-08 10:19:19.425+00	2021-11-08 10:19:19.656+00
4023	\N	died	2021-11-08 10:18:56.606+00	\N	\N	2021-11-08 10:19:54.451+00	2021-11-08 10:19:54.647+00
2472	\N	died	2021-11-08 10:18:39.359+00	\N	\N	2021-11-08 10:19:19.6+00	2021-11-08 10:19:19.882+00
2484	\N	died	2021-11-08 10:18:39.392+00	\N	\N	2021-11-08 10:19:19.843+00	2021-11-08 10:19:20.114+00
2812	\N	died	2021-11-08 10:18:40.543+00	\N	\N	2021-11-08 10:19:26.806+00	2021-11-08 10:19:27.029+00
2496	\N	died	2021-11-08 10:18:39.429+00	\N	\N	2021-11-08 10:19:20.111+00	2021-11-08 10:19:20.258+00
2502	\N	died	2021-11-08 10:18:39.446+00	\N	\N	2021-11-08 10:19:20.253+00	2021-11-08 10:19:20.445+00
2508	\N	died	2021-11-08 10:18:39.478+00	\N	\N	2021-11-08 10:19:20.36+00	2021-11-08 10:19:20.683+00
2823	\N	died	2021-11-08 10:18:40.568+00	\N	\N	2021-11-08 10:19:27.026+00	2021-11-08 10:19:27.083+00
2521	\N	died	2021-11-08 10:18:39.522+00	\N	\N	2021-11-08 10:19:20.678+00	2021-11-08 10:19:20.923+00
3879	\N	died	2021-11-08 10:18:52.424+00	\N	\N	2021-11-08 10:19:51.203+00	2021-11-08 10:19:51.373+00
2531	\N	died	2021-11-08 10:18:39.56+00	\N	\N	2021-11-08 10:19:20.887+00	2021-11-08 10:19:21.263+00
2551	\N	died	2021-11-08 10:18:39.655+00	\N	\N	2021-11-08 10:19:21.258+00	2021-11-08 10:19:21.465+00
2826	\N	died	2021-11-08 10:18:40.575+00	\N	\N	2021-11-08 10:19:27.078+00	2021-11-08 10:19:27.198+00
2558	\N	died	2021-11-08 10:18:39.677+00	\N	\N	2021-11-08 10:19:21.43+00	2021-11-08 10:19:21.573+00
2567	\N	died	2021-11-08 10:18:39.702+00	\N	\N	2021-11-08 10:19:21.569+00	2021-11-08 10:19:21.754+00
2577	\N	died	2021-11-08 10:18:39.738+00	\N	\N	2021-11-08 10:19:21.737+00	2021-11-08 10:19:22.125+00
2830	\N	died	2021-11-08 10:18:40.582+00	\N	\N	2021-11-08 10:19:27.194+00	2021-11-08 10:19:27.439+00
2593	\N	died	2021-11-08 10:18:39.799+00	\N	\N	2021-11-08 10:19:22.103+00	2021-11-08 10:19:22.562+00
2613	\N	died	2021-11-08 10:18:39.852+00	\N	\N	2021-11-08 10:19:22.484+00	2021-11-08 10:19:22.885+00
2630	\N	died	2021-11-08 10:18:39.913+00	\N	\N	2021-11-08 10:19:22.861+00	2021-11-08 10:19:23.297+00
2840	\N	died	2021-11-08 10:18:40.612+00	\N	\N	2021-11-08 10:19:27.407+00	2021-11-08 10:19:27.789+00
2646	\N	died	2021-11-08 10:18:39.972+00	\N	\N	2021-11-08 10:19:23.181+00	2021-11-08 10:19:23.347+00
3885	\N	died	2021-11-08 10:18:52.682+00	\N	\N	2021-11-08 10:19:51.354+00	2021-11-08 10:19:51.844+00
2653	\N	died	2021-11-08 10:18:39.996+00	\N	\N	2021-11-08 10:19:23.343+00	2021-11-08 10:19:23.53+00
2657	\N	died	2021-11-08 10:18:40.01+00	\N	\N	2021-11-08 10:19:23.412+00	2021-11-08 10:19:23.793+00
2858	\N	died	2021-11-08 10:18:40.658+00	\N	\N	2021-11-08 10:19:27.734+00	2021-11-08 10:19:27.956+00
2672	\N	died	2021-11-08 10:18:40.071+00	\N	\N	2021-11-08 10:19:23.769+00	2021-11-08 10:19:24.192+00
2691	\N	died	2021-11-08 10:18:40.135+00	\N	\N	2021-11-08 10:19:24.188+00	2021-11-08 10:19:24.338+00
2698	\N	died	2021-11-08 10:18:40.159+00	\N	\N	2021-11-08 10:19:24.302+00	2021-11-08 10:19:24.831+00
2868	\N	died	2021-11-08 10:18:40.679+00	\N	\N	2021-11-08 10:19:27.951+00	2021-11-08 10:19:28.024+00
2717	\N	died	2021-11-08 10:18:40.221+00	\N	\N	2021-11-08 10:19:24.735+00	2021-11-08 10:19:25.014+00
2730	\N	died	2021-11-08 10:18:40.26+00	\N	\N	2021-11-08 10:19:25.01+00	2021-11-08 10:19:25.269+00
2735	\N	died	2021-11-08 10:18:40.276+00	\N	\N	2021-11-08 10:19:25.179+00	2021-11-08 10:19:25.433+00
2871	\N	died	2021-11-08 10:18:40.693+00	\N	\N	2021-11-08 10:19:28.003+00	2021-11-08 10:19:28.207+00
2748	\N	died	2021-11-08 10:18:40.328+00	\N	\N	2021-11-08 10:19:25.428+00	2021-11-08 10:19:25.484+00
3903	\N	died	2021-11-08 10:18:53.549+00	\N	\N	2021-11-08 10:19:51.697+00	2021-11-08 10:19:52.095+00
2751	\N	died	2021-11-08 10:18:40.343+00	\N	\N	2021-11-08 10:19:25.481+00	2021-11-08 10:19:25.809+00
4032	\N	died	2021-11-08 10:18:56.808+00	\N	\N	2021-11-08 10:19:54.642+00	2021-11-08 10:19:54.888+00
2761	\N	died	2021-11-08 10:18:40.37+00	\N	\N	2021-11-08 10:19:25.693+00	2021-11-08 10:19:26.155+00
2880	\N	died	2021-11-08 10:18:40.709+00	\N	\N	2021-11-08 10:19:28.202+00	2021-11-08 10:19:28.398+00
3917	\N	died	2021-11-08 10:18:53.897+00	\N	\N	2021-11-08 10:19:52.074+00	2021-11-08 10:19:52.336+00
2889	\N	died	2021-11-08 10:18:40.732+00	\N	\N	2021-11-08 10:19:28.394+00	2021-11-08 10:19:28.436+00
4130	\N	died	2021-11-08 10:18:58.465+00	\N	\N	2021-11-08 10:19:56.809+00	2021-11-08 10:19:57.188+00
2891	\N	died	2021-11-08 10:18:40.74+00	\N	\N	2021-11-08 10:19:28.43+00	2021-11-08 10:19:28.459+00
2893	\N	died	2021-11-08 10:18:40.74+00	\N	\N	2021-11-08 10:19:28.452+00	2021-11-08 10:19:28.577+00
3929	\N	died	2021-11-08 10:18:54.206+00	\N	\N	2021-11-08 10:19:52.317+00	2021-11-08 10:19:52.579+00
2897	\N	died	2021-11-08 10:18:40.758+00	\N	\N	2021-11-08 10:19:28.572+00	2021-11-08 10:19:28.647+00
2901	\N	died	2021-11-08 10:18:40.773+00	\N	\N	2021-11-08 10:19:28.643+00	2021-11-08 10:19:28.799+00
2907	\N	died	2021-11-08 10:18:40.786+00	\N	\N	2021-11-08 10:19:28.795+00	2021-11-08 10:19:28.914+00
3940	\N	died	2021-11-08 10:18:54.458+00	\N	\N	2021-11-08 10:19:52.538+00	2021-11-08 10:19:52.964+00
2914	\N	died	2021-11-08 10:18:40.801+00	\N	\N	2021-11-08 10:19:28.91+00	2021-11-08 10:19:29.081+00
4039	\N	died	2021-11-08 10:18:56.925+00	\N	\N	2021-11-08 10:19:54.799+00	2021-11-08 10:19:55.205+00
2921	\N	died	2021-11-08 10:18:40.823+00	\N	\N	2021-11-08 10:19:29.077+00	2021-11-08 10:19:29.168+00
2926	\N	died	2021-11-08 10:18:40.837+00	\N	\N	2021-11-08 10:19:29.164+00	2021-11-08 10:19:29.256+00
3956	\N	died	2021-11-08 10:18:54.981+00	\N	\N	2021-11-08 10:19:52.908+00	2021-11-08 10:19:53.043+00
2928	\N	died	2021-11-08 10:18:40.837+00	\N	\N	2021-11-08 10:19:29.251+00	2021-11-08 10:19:29.326+00
5665	\N	died	2021-11-08 10:19:51.148+00	\N	\N	2021-11-08 10:20:40.69+00	2021-11-08 10:20:40.853+00
2932	\N	died	2021-11-08 10:18:40.859+00	\N	\N	2021-11-08 10:19:29.323+00	2021-11-08 10:19:29.391+00
2936	\N	died	2021-11-08 10:18:40.865+00	\N	\N	2021-11-08 10:19:29.387+00	2021-11-08 10:19:29.582+00
3963	\N	died	2021-11-08 10:18:55.239+00	\N	\N	2021-11-08 10:19:53.024+00	2021-11-08 10:19:53.307+00
2945	\N	died	2021-11-08 10:18:40.887+00	\N	\N	2021-11-08 10:19:29.577+00	2021-11-08 10:19:29.64+00
3976	\N	died	2021-11-08 10:18:55.673+00	\N	\N	2021-11-08 10:19:53.3+00	2021-11-08 10:19:53.54+00
4056	\N	died	2021-11-08 10:18:57.215+00	\N	\N	2021-11-08 10:19:55.134+00	2021-11-08 10:19:55.767+00
3986	\N	died	2021-11-08 10:18:55.963+00	\N	\N	2021-11-08 10:19:53.516+00	2021-11-08 10:19:53.727+00
3990	\N	died	2021-11-08 10:18:55.998+00	\N	\N	2021-11-08 10:19:53.723+00	2021-11-08 10:19:53.938+00
4148	\N	died	2021-11-08 10:18:59.073+00	\N	\N	2021-11-08 10:19:57.116+00	2021-11-08 10:19:57.47+00
3995	\N	died	2021-11-08 10:18:56.098+00	\N	\N	2021-11-08 10:19:53.9+00	2021-11-08 10:19:54.226+00
4009	\N	died	2021-11-08 10:18:56.357+00	\N	\N	2021-11-08 10:19:54.175+00	2021-11-08 10:19:54.454+00
4072	\N	died	2021-11-08 10:18:57.6+00	\N	\N	2021-11-08 10:19:55.692+00	2021-11-08 10:19:55.979+00
4161	\N	died	2021-11-08 10:18:59.299+00	\N	\N	2021-11-08 10:19:57.465+00	2021-11-08 10:19:57.702+00
4081	\N	died	2021-11-08 10:18:57.75+00	\N	\N	2021-11-08 10:19:55.917+00	2021-11-08 10:19:56.221+00
4093	\N	died	2021-11-08 10:18:58.05+00	\N	\N	2021-11-08 10:19:56.166+00	2021-11-08 10:19:56.663+00
5669	\N	died	2021-11-08 10:19:51.199+00	\N	\N	2021-11-08 10:20:40.848+00	2021-11-08 10:20:41.06+00
4119	\N	died	2021-11-08 10:18:58.256+00	\N	\N	2021-11-08 10:19:56.625+00	2021-11-08 10:19:56.828+00
5704	\N	died	2021-11-08 10:19:51.615+00	\N	\N	2021-11-08 10:20:41.681+00	2021-11-08 10:20:42.626+00
4171	\N	died	2021-11-08 10:18:59.615+00	\N	\N	2021-11-08 10:19:57.634+00	2021-11-08 10:19:57.914+00
4182	\N	died	2021-11-08 10:18:59.865+00	\N	\N	2021-11-08 10:19:57.91+00	2021-11-08 10:19:58.056+00
5678	\N	died	2021-11-08 10:19:51.299+00	\N	\N	2021-11-08 10:20:41.019+00	2021-11-08 10:20:41.299+00
4189	\N	died	2021-11-08 10:19:00.198+00	\N	\N	2021-11-08 10:19:58.052+00	2021-11-08 10:19:58.18+00
4194	\N	died	2021-11-08 10:19:00.5+00	\N	\N	2021-11-08 10:19:58.176+00	2021-11-08 10:19:58.212+00
4196	\N	died	2021-11-08 10:19:00.525+00	\N	\N	2021-11-08 10:19:58.207+00	2021-11-08 10:19:58.281+00
5686	\N	died	2021-11-08 10:19:51.364+00	\N	\N	2021-11-08 10:20:41.261+00	2021-11-08 10:20:41.827+00
4200	\N	died	2021-11-08 10:19:00.764+00	\N	\N	2021-11-08 10:19:58.277+00	2021-11-08 10:19:58.398+00
5720	\N	died	2021-11-08 10:19:52.074+00	\N	\N	2021-11-08 10:20:42.123+00	2021-11-08 10:20:42.772+00
5760	\N	died	2021-11-08 10:19:52.907+00	\N	\N	2021-11-08 10:20:43.456+00	2021-11-08 10:20:43.777+00
5730	\N	died	2021-11-08 10:19:52.299+00	\N	\N	2021-11-08 10:20:42.739+00	2021-11-08 10:20:42.994+00
5739	\N	died	2021-11-08 10:19:52.474+00	\N	\N	2021-11-08 10:20:42.906+00	2021-11-08 10:20:43.267+00
5749	\N	died	2021-11-08 10:19:52.689+00	\N	\N	2021-11-08 10:20:43.164+00	2021-11-08 10:20:43.461+00
5767	\N	died	2021-11-08 10:19:53.006+00	\N	\N	2021-11-08 10:20:43.589+00	2021-11-08 10:20:43.951+00
5779	\N	died	2021-11-08 10:19:53.298+00	\N	\N	2021-11-08 10:20:43.933+00	2021-11-08 10:20:44.037+00
2448	\N	died	2021-11-08 10:18:39.292+00	\N	\N	2021-11-08 10:19:19.101+00	2021-11-08 10:19:19.143+00
2786	\N	died	2021-11-08 10:18:40.469+00	\N	\N	2021-11-08 10:19:26.275+00	2021-11-08 10:19:26.508+00
2450	\N	died	2021-11-08 10:18:39.304+00	\N	\N	2021-11-08 10:19:19.137+00	2021-11-08 10:19:19.222+00
2455	\N	died	2021-11-08 10:18:39.312+00	\N	\N	2021-11-08 10:19:19.218+00	2021-11-08 10:19:19.384+00
2461	\N	died	2021-11-08 10:18:39.331+00	\N	\N	2021-11-08 10:19:19.38+00	2021-11-08 10:19:19.442+00
2796	\N	died	2021-11-08 10:18:40.491+00	\N	\N	2021-11-08 10:19:26.484+00	2021-11-08 10:19:27.017+00
2465	\N	died	2021-11-08 10:18:39.345+00	\N	\N	2021-11-08 10:19:19.437+00	2021-11-08 10:19:19.541+00
2468	\N	died	2021-11-08 10:18:39.352+00	\N	\N	2021-11-08 10:19:19.537+00	2021-11-08 10:19:19.656+00
2473	\N	died	2021-11-08 10:18:39.359+00	\N	\N	2021-11-08 10:19:19.617+00	2021-11-08 10:19:20.017+00
2820	\N	died	2021-11-08 10:18:40.562+00	\N	\N	2021-11-08 10:19:26.98+00	2021-11-08 10:19:27.439+00
2489	\N	died	2021-11-08 10:18:39.402+00	\N	\N	2021-11-08 10:19:19.993+00	2021-11-08 10:19:20.292+00
3914	\N	died	2021-11-08 10:18:53.84+00	\N	\N	2021-11-08 10:19:52.024+00	2021-11-08 10:19:52.095+00
2503	\N	died	2021-11-08 10:18:39.45+00	\N	\N	2021-11-08 10:19:20.271+00	2021-11-08 10:19:20.513+00
2511	\N	died	2021-11-08 10:18:39.492+00	\N	\N	2021-11-08 10:19:20.461+00	2021-11-08 10:19:20.663+00
2837	\N	died	2021-11-08 10:18:40.601+00	\N	\N	2021-11-08 10:19:27.306+00	2021-11-08 10:19:27.727+00
2520	\N	died	2021-11-08 10:18:39.518+00	\N	\N	2021-11-08 10:19:20.658+00	2021-11-08 10:19:20.923+00
4058	\N	died	2021-11-08 10:18:57.233+00	\N	\N	2021-11-08 10:19:55.215+00	2021-11-08 10:19:55.345+00
2528	\N	died	2021-11-08 10:18:39.548+00	\N	\N	2021-11-08 10:19:20.784+00	2021-11-08 10:19:21.182+00
2543	\N	died	2021-11-08 10:18:39.609+00	\N	\N	2021-11-08 10:19:21.088+00	2021-11-08 10:19:21.348+00
2856	\N	died	2021-11-08 10:18:40.65+00	\N	\N	2021-11-08 10:19:27.703+00	2021-11-08 10:19:27.991+00
2552	\N	died	2021-11-08 10:18:39.655+00	\N	\N	2021-11-08 10:19:21.277+00	2021-11-08 10:19:21.533+00
2564	\N	died	2021-11-08 10:18:39.694+00	\N	\N	2021-11-08 10:19:21.529+00	2021-11-08 10:19:21.674+00
2568	\N	died	2021-11-08 10:18:39.706+00	\N	\N	2021-11-08 10:19:21.588+00	2021-11-08 10:19:21.773+00
2870	\N	died	2021-11-08 10:18:40.693+00	\N	\N	2021-11-08 10:19:27.984+00	2021-11-08 10:19:28.141+00
2579	\N	died	2021-11-08 10:18:39.742+00	\N	\N	2021-11-08 10:19:21.769+00	2021-11-08 10:19:21.874+00
3918	\N	died	2021-11-08 10:18:53.916+00	\N	\N	2021-11-08 10:19:52.091+00	2021-11-08 10:19:52.336+00
2582	\N	died	2021-11-08 10:18:39.749+00	\N	\N	2021-11-08 10:19:21.869+00	2021-11-08 10:19:21.941+00
2586	\N	died	2021-11-08 10:18:39.767+00	\N	\N	2021-11-08 10:19:21.937+00	2021-11-08 10:19:22.156+00
2874	\N	died	2021-11-08 10:18:40.701+00	\N	\N	2021-11-08 10:19:28.101+00	2021-11-08 10:19:28.398+00
2596	\N	died	2021-11-08 10:18:39.807+00	\N	\N	2021-11-08 10:19:22.153+00	2021-11-08 10:19:22.238+00
2600	\N	died	2021-11-08 10:18:39.819+00	\N	\N	2021-11-08 10:19:22.223+00	2021-11-08 10:19:22.562+00
2610	\N	died	2021-11-08 10:18:39.847+00	\N	\N	2021-11-08 10:19:22.435+00	2021-11-08 10:19:22.815+00
2888	\N	died	2021-11-08 10:18:40.732+00	\N	\N	2021-11-08 10:19:28.378+00	2021-11-08 10:19:28.814+00
2622	\N	died	2021-11-08 10:18:39.891+00	\N	\N	2021-11-08 10:19:22.679+00	2021-11-08 10:19:22.907+00
2633	\N	died	2021-11-08 10:18:39.921+00	\N	\N	2021-11-08 10:19:22.902+00	2021-11-08 10:19:23.103+00
2639	\N	died	2021-11-08 10:18:39.937+00	\N	\N	2021-11-08 10:19:23.063+00	2021-11-08 10:19:23.793+00
2908	\N	died	2021-11-08 10:18:40.786+00	\N	\N	2021-11-08 10:19:28.81+00	2021-11-08 10:19:28.93+00
2668	\N	died	2021-11-08 10:18:40.058+00	\N	\N	2021-11-08 10:19:23.644+00	2021-11-08 10:19:24.091+00
3926	\N	died	2021-11-08 10:18:54.056+00	\N	\N	2021-11-08 10:19:52.268+00	2021-11-08 10:19:52.379+00
2683	\N	died	2021-11-08 10:18:40.103+00	\N	\N	2021-11-08 10:19:24.004+00	2021-11-08 10:19:24.223+00
2693	\N	died	2021-11-08 10:18:40.14+00	\N	\N	2021-11-08 10:19:24.219+00	2021-11-08 10:19:24.43+00
2915	\N	died	2021-11-08 10:18:40.801+00	\N	\N	2021-11-08 10:19:28.926+00	2021-11-08 10:19:29.168+00
2702	\N	died	2021-11-08 10:18:40.171+00	\N	\N	2021-11-08 10:19:24.426+00	2021-11-08 10:19:24.53+00
2706	\N	died	2021-11-08 10:18:40.182+00	\N	\N	2021-11-08 10:19:24.5+00	2021-11-08 10:19:24.831+00
2716	\N	died	2021-11-08 10:18:40.206+00	\N	\N	2021-11-08 10:19:24.709+00	2021-11-08 10:19:25.001+00
2924	\N	died	2021-11-08 10:18:40.83+00	\N	\N	2021-11-08 10:19:29.128+00	2021-11-08 10:19:29.391+00
2728	\N	died	2021-11-08 10:18:40.255+00	\N	\N	2021-11-08 10:19:24.981+00	2021-11-08 10:19:25.269+00
2739	\N	died	2021-11-08 10:18:40.288+00	\N	\N	2021-11-08 10:19:25.245+00	2021-11-08 10:19:25.809+00
3933	\N	died	2021-11-08 10:18:54.255+00	\N	\N	2021-11-08 10:19:52.375+00	2021-11-08 10:19:52.579+00
2760	\N	died	2021-11-08 10:18:40.369+00	\N	\N	2021-11-08 10:19:25.68+00	2021-11-08 10:19:26.039+00
4064	\N	died	2021-11-08 10:18:57.416+00	\N	\N	2021-11-08 10:19:55.306+00	2021-11-08 10:19:55.979+00
2774	\N	died	2021-11-08 10:18:40.432+00	\N	\N	2021-11-08 10:19:26.024+00	2021-11-08 10:19:26.176+00
2783	\N	died	2021-11-08 10:18:40.462+00	\N	\N	2021-11-08 10:19:26.172+00	2021-11-08 10:19:26.313+00
3939	\N	died	2021-11-08 10:18:54.456+00	\N	\N	2021-11-08 10:19:52.525+00	2021-11-08 10:19:52.845+00
2935	\N	died	2021-11-08 10:18:40.865+00	\N	\N	2021-11-08 10:19:29.373+00	2021-11-08 10:19:29.64+00
4143	\N	died	2021-11-08 10:18:58.932+00	\N	\N	2021-11-08 10:19:57.027+00	2021-11-08 10:19:57.337+00
2947	\N	died	2021-11-08 10:18:40.895+00	\N	\N	2021-11-08 10:19:29.619+00	2021-11-08 10:19:29.81+00
2955	\N	died	2021-11-08 10:18:40.916+00	\N	\N	2021-11-08 10:19:29.806+00	2021-11-08 10:19:30.055+00
3951	\N	died	2021-11-08 10:18:54.755+00	\N	\N	2021-11-08 10:19:52.775+00	2021-11-08 10:19:53.061+00
2964	\N	died	2021-11-08 10:18:40.939+00	\N	\N	2021-11-08 10:19:30.048+00	2021-11-08 10:19:30.094+00
2967	\N	died	2021-11-08 10:18:40.945+00	\N	\N	2021-11-08 10:19:30.09+00	2021-11-08 10:19:30.186+00
2969	\N	died	2021-11-08 10:18:40.95+00	\N	\N	2021-11-08 10:19:30.182+00	2021-11-08 10:19:30.248+00
3965	\N	died	2021-11-08 10:18:55.272+00	\N	\N	2021-11-08 10:19:53.057+00	2021-11-08 10:19:53.17+00
2973	\N	died	2021-11-08 10:18:40.956+00	\N	\N	2021-11-08 10:19:30.244+00	2021-11-08 10:19:30.314+00
4080	\N	died	2021-11-08 10:18:57.748+00	\N	\N	2021-11-08 10:19:55.876+00	2021-11-08 10:19:56.221+00
2977	\N	died	2021-11-08 10:18:40.967+00	\N	\N	2021-11-08 10:19:30.311+00	2021-11-08 10:19:30.431+00
2980	\N	died	2021-11-08 10:18:40.972+00	\N	\N	2021-11-08 10:19:30.427+00	2021-11-08 10:19:30.635+00
3968	\N	died	2021-11-08 10:18:55.373+00	\N	\N	2021-11-08 10:19:53.166+00	2021-11-08 10:19:53.238+00
2989	\N	died	2021-11-08 10:18:41.005+00	\N	\N	2021-11-08 10:19:30.63+00	2021-11-08 10:19:30.69+00
4201	\N	died	2021-11-08 10:19:00.815+00	\N	\N	2021-11-08 10:19:58.293+00	2021-11-08 10:19:58.663+00
2993	\N	died	2021-11-08 10:18:41.012+00	\N	\N	2021-11-08 10:19:30.686+00	2021-11-08 10:19:30.724+00
2995	\N	died	2021-11-08 10:18:41.019+00	\N	\N	2021-11-08 10:19:30.72+00	2021-11-08 10:19:30.774+00
3972	\N	died	2021-11-08 10:18:55.49+00	\N	\N	2021-11-08 10:19:53.233+00	2021-11-08 10:19:53.503+00
2998	\N	died	2021-11-08 10:18:41.027+00	\N	\N	2021-11-08 10:19:30.77+00	2021-11-08 10:19:30.882+00
3002	\N	died	2021-11-08 10:18:41.038+00	\N	\N	2021-11-08 10:19:30.877+00	2021-11-08 10:19:30.956+00
3982	\N	died	2021-11-08 10:18:55.839+00	\N	\N	2021-11-08 10:19:53.449+00	2021-11-08 10:19:54.002+00
4091	\N	died	2021-11-08 10:18:58.032+00	\N	\N	2021-11-08 10:19:56.135+00	2021-11-08 10:19:56.362+00
4001	\N	died	2021-11-08 10:18:56.183+00	\N	\N	2021-11-08 10:19:53.998+00	2021-11-08 10:19:54.226+00
4010	\N	died	2021-11-08 10:18:56.36+00	\N	\N	2021-11-08 10:19:54.189+00	2021-11-08 10:19:54.611+00
4157	\N	died	2021-11-08 10:18:59.232+00	\N	\N	2021-11-08 10:19:57.332+00	2021-11-08 10:19:57.489+00
4027	\N	died	2021-11-08 10:18:56.722+00	\N	\N	2021-11-08 10:19:54.559+00	2021-11-08 10:19:54.888+00
4040	\N	died	2021-11-08 10:18:56.94+00	\N	\N	2021-11-08 10:19:54.817+00	2021-11-08 10:19:55.22+00
4102	\N	died	2021-11-08 10:18:58.161+00	\N	\N	2021-11-08 10:19:56.358+00	2021-11-08 10:19:56.43+00
4162	\N	died	2021-11-08 10:18:59.423+00	\N	\N	2021-11-08 10:19:57.485+00	2021-11-08 10:19:57.702+00
4105	\N	died	2021-11-08 10:18:58.165+00	\N	\N	2021-11-08 10:19:56.406+00	2021-11-08 10:19:56.612+00
4240	\N	died	2021-11-08 10:19:01.742+00	\N	\N	2021-11-08 10:19:59.245+00	2021-11-08 10:19:59.513+00
4116	\N	died	2021-11-08 10:18:58.198+00	\N	\N	2021-11-08 10:19:56.576+00	2021-11-08 10:19:56.913+00
4136	\N	died	2021-11-08 10:18:58.581+00	\N	\N	2021-11-08 10:19:56.91+00	2021-11-08 10:19:57.069+00
4206	\N	died	2021-11-08 10:19:00.984+00	\N	\N	2021-11-08 10:19:58.424+00	2021-11-08 10:19:58.754+00
4220	\N	died	2021-11-08 10:19:01.284+00	\N	\N	2021-11-08 10:19:58.849+00	2021-11-08 10:19:59.071+00
4172	\N	died	2021-11-08 10:18:59.617+00	\N	\N	2021-11-08 10:19:57.648+00	2021-11-08 10:19:58.056+00
4186	\N	died	2021-11-08 10:19:00+00	\N	\N	2021-11-08 10:19:58+00	2021-11-08 10:19:58.297+00
4217	\N	died	2021-11-08 10:19:01.265+00	\N	\N	2021-11-08 10:19:58.751+00	2021-11-08 10:19:58.89+00
4228	\N	died	2021-11-08 10:19:01.582+00	\N	\N	2021-11-08 10:19:58.984+00	2021-11-08 10:19:59.262+00
5691	\N	died	2021-11-08 10:19:51.402+00	\N	\N	2021-11-08 10:20:41.374+00	2021-11-08 10:20:41.454+00
4252	\N	died	2021-11-08 10:19:01.806+00	\N	\N	2021-11-08 10:19:59.493+00	2021-11-08 10:19:59.971+00
4280	\N	died	2021-11-08 10:19:02.457+00	\N	\N	2021-11-08 10:20:00.068+00	2021-11-08 10:20:00.188+00
4271	\N	died	2021-11-08 10:19:02.224+00	\N	\N	2021-11-08 10:19:59.859+00	2021-11-08 10:20:00.24+00
5747	\N	died	2021-11-08 10:19:52.608+00	\N	\N	2021-11-08 10:20:43.125+00	2021-11-08 10:20:43.448+00
4284	\N	died	2021-11-08 10:19:02.623+00	\N	\N	2021-11-08 10:20:00.185+00	2021-11-08 10:20:00.272+00
4287	\N	died	2021-11-08 10:19:02.662+00	\N	\N	2021-11-08 10:20:00.232+00	2021-11-08 10:20:00.471+00
5694	\N	died	2021-11-08 10:19:51.434+00	\N	\N	2021-11-08 10:20:41.443+00	2021-11-08 10:20:41.611+00
4288	\N	died	2021-11-08 10:19:02.707+00	\N	\N	2021-11-08 10:20:00.254+00	2021-11-08 10:20:00.522+00
5698	\N	died	2021-11-08 10:19:51.532+00	\N	\N	2021-11-08 10:20:41.599+00	2021-11-08 10:20:41.827+00
5708	\N	died	2021-11-08 10:19:51.756+00	\N	\N	2021-11-08 10:20:41.807+00	2021-11-08 10:20:42.772+00
5728	\N	died	2021-11-08 10:19:52.281+00	\N	\N	2021-11-08 10:20:42.706+00	2021-11-08 10:20:42.883+00
5737	\N	died	2021-11-08 10:19:52.458+00	\N	\N	2021-11-08 10:20:42.869+00	2021-11-08 10:20:43.267+00
2490	\N	died	2021-11-08 10:18:39.408+00	\N	\N	2021-11-08 10:19:20.013+00	2021-11-08 10:19:20.091+00
2495	\N	died	2021-11-08 10:18:39.418+00	\N	\N	2021-11-08 10:19:20.085+00	2021-11-08 10:19:20.226+00
2853	\N	died	2021-11-08 10:18:40.644+00	\N	\N	2021-11-08 10:19:27.66+00	2021-11-08 10:19:27.939+00
2500	\N	died	2021-11-08 10:18:39.442+00	\N	\N	2021-11-08 10:19:20.223+00	2021-11-08 10:19:20.292+00
2504	\N	died	2021-11-08 10:18:39.459+00	\N	\N	2021-11-08 10:19:20.288+00	2021-11-08 10:19:20.445+00
2509	\N	died	2021-11-08 10:18:39.487+00	\N	\N	2021-11-08 10:19:20.431+00	2021-11-08 10:19:20.731+00
2864	\N	died	2021-11-08 10:18:40.672+00	\N	\N	2021-11-08 10:19:27.885+00	2021-11-08 10:19:28.398+00
2523	\N	died	2021-11-08 10:18:39.531+00	\N	\N	2021-11-08 10:19:20.713+00	2021-11-08 10:19:20.975+00
5685	\N	died	2021-11-08 10:19:51.353+00	\N	\N	2021-11-08 10:20:41.233+00	2021-11-08 10:20:41.635+00
2534	\N	died	2021-11-08 10:18:39.577+00	\N	\N	2021-11-08 10:19:20.936+00	2021-11-08 10:19:21.026+00
2539	\N	died	2021-11-08 10:18:39.597+00	\N	\N	2021-11-08 10:19:21.022+00	2021-11-08 10:19:21.182+00
2885	\N	died	2021-11-08 10:18:40.726+00	\N	\N	2021-11-08 10:19:28.335+00	2021-11-08 10:19:28.647+00
2544	\N	died	2021-11-08 10:18:39.624+00	\N	\N	2021-11-08 10:19:21.105+00	2021-11-08 10:19:21.465+00
2559	\N	died	2021-11-08 10:18:39.681+00	\N	\N	2021-11-08 10:19:21.446+00	2021-11-08 10:19:21.754+00
2574	\N	died	2021-11-08 10:18:39.73+00	\N	\N	2021-11-08 10:19:21.688+00	2021-11-08 10:19:21.874+00
2900	\N	died	2021-11-08 10:18:40.772+00	\N	\N	2021-11-08 10:19:28.631+00	2021-11-08 10:19:28.914+00
2581	\N	died	2021-11-08 10:18:39.746+00	\N	\N	2021-11-08 10:19:21.802+00	2021-11-08 10:19:22.125+00
2588	\N	died	2021-11-08 10:18:39.778+00	\N	\N	2021-11-08 10:19:21.972+00	2021-11-08 10:19:22.257+00
2602	\N	died	2021-11-08 10:18:39.823+00	\N	\N	2021-11-08 10:19:22.253+00	2021-11-08 10:19:22.407+00
2913	\N	died	2021-11-08 10:18:40.801+00	\N	\N	2021-11-08 10:19:28.897+00	2021-11-08 10:19:29.168+00
2606	\N	died	2021-11-08 10:18:39.835+00	\N	\N	2021-11-08 10:19:22.372+00	2021-11-08 10:19:22.598+00
5699	\N	died	2021-11-08 10:19:51.549+00	\N	\N	2021-11-08 10:20:41.626+00	2021-11-08 10:20:41.827+00
2616	\N	died	2021-11-08 10:18:39.864+00	\N	\N	2021-11-08 10:19:22.583+00	2021-11-08 10:19:22.666+00
2621	\N	died	2021-11-08 10:18:39.886+00	\N	\N	2021-11-08 10:19:22.662+00	2021-11-08 10:19:22.885+00
2925	\N	died	2021-11-08 10:18:40.83+00	\N	\N	2021-11-08 10:19:29.143+00	2021-11-08 10:19:29.406+00
2629	\N	died	2021-11-08 10:18:39.909+00	\N	\N	2021-11-08 10:19:22.843+00	2021-11-08 10:19:23.169+00
2644	\N	died	2021-11-08 10:18:39.963+00	\N	\N	2021-11-08 10:19:23.146+00	2021-11-08 10:19:23.53+00
2660	\N	died	2021-11-08 10:18:40.017+00	\N	\N	2021-11-08 10:19:23.513+00	2021-11-08 10:19:23.793+00
2937	\N	died	2021-11-08 10:18:40.865+00	\N	\N	2021-11-08 10:19:29.401+00	2021-11-08 10:19:29.607+00
2669	\N	died	2021-11-08 10:18:40.062+00	\N	\N	2021-11-08 10:19:23.661+00	2021-11-08 10:19:24.091+00
2685	\N	died	2021-11-08 10:18:40.109+00	\N	\N	2021-11-08 10:19:24.042+00	2021-11-08 10:19:24.338+00
2699	\N	died	2021-11-08 10:18:40.165+00	\N	\N	2021-11-08 10:19:24.322+00	2021-11-08 10:19:24.831+00
2946	\N	died	2021-11-08 10:18:40.894+00	\N	\N	2021-11-08 10:19:29.6+00	2021-11-08 10:19:29.758+00
2720	\N	died	2021-11-08 10:18:40.228+00	\N	\N	2021-11-08 10:19:24.776+00	2021-11-08 10:19:25.269+00
5709	\N	died	2021-11-08 10:19:51.823+00	\N	\N	2021-11-08 10:20:41.823+00	2021-11-08 10:20:41.86+00
2734	\N	died	2021-11-08 10:18:40.273+00	\N	\N	2021-11-08 10:19:25.126+00	2021-11-08 10:19:25.413+00
2746	\N	died	2021-11-08 10:18:40.323+00	\N	\N	2021-11-08 10:19:25.395+00	2021-11-08 10:19:25.809+00
2950	\N	died	2021-11-08 10:18:40.901+00	\N	\N	2021-11-08 10:19:29.718+00	2021-11-08 10:19:30.055+00
2759	\N	died	2021-11-08 10:18:40.364+00	\N	\N	2021-11-08 10:19:25.66+00	2021-11-08 10:19:25.94+00
2772	\N	died	2021-11-08 10:18:40.417+00	\N	\N	2021-11-08 10:19:25.934+00	2021-11-08 10:19:26.155+00
2781	\N	died	2021-11-08 10:18:40.451+00	\N	\N	2021-11-08 10:19:26.134+00	2021-11-08 10:19:26.606+00
2962	\N	died	2021-11-08 10:18:40.933+00	\N	\N	2021-11-08 10:19:30.01+00	2021-11-08 10:19:30.635+00
2801	\N	died	2021-11-08 10:18:40.511+00	\N	\N	2021-11-08 10:19:26.572+00	2021-11-08 10:19:26.772+00
2810	\N	died	2021-11-08 10:18:40.536+00	\N	\N	2021-11-08 10:19:26.768+00	2021-11-08 10:19:27.017+00
2815	\N	died	2021-11-08 10:18:40.549+00	\N	\N	2021-11-08 10:19:26.847+00	2021-11-08 10:19:27.101+00
2983	\N	died	2021-11-08 10:18:40.984+00	\N	\N	2021-11-08 10:19:30.481+00	2021-11-08 10:19:30.711+00
2827	\N	died	2021-11-08 10:18:40.575+00	\N	\N	2021-11-08 10:19:27.094+00	2021-11-08 10:19:27.259+00
5711	\N	died	2021-11-08 10:19:51.856+00	\N	\N	2021-11-08 10:20:41.856+00	2021-11-08 10:20:41.908+00
2834	\N	died	2021-11-08 10:18:40.595+00	\N	\N	2021-11-08 10:19:27.256+00	2021-11-08 10:19:27.46+00
2843	\N	died	2021-11-08 10:18:40.62+00	\N	\N	2021-11-08 10:19:27.456+00	2021-11-08 10:19:27.515+00
2846	\N	died	2021-11-08 10:18:40.629+00	\N	\N	2021-11-08 10:19:27.499+00	2021-11-08 10:19:27.689+00
5713	\N	died	2021-11-08 10:19:51.891+00	\N	\N	2021-11-08 10:20:41.9+00	2021-11-08 10:20:42.113+00
2994	\N	died	2021-11-08 10:18:41.019+00	\N	\N	2021-11-08 10:19:30.707+00	2021-11-08 10:19:30.774+00
2997	\N	died	2021-11-08 10:18:41.027+00	\N	\N	2021-11-08 10:19:30.753+00	2021-11-08 10:19:30.956+00
5717	\N	died	2021-11-08 10:19:52.023+00	\N	\N	2021-11-08 10:20:42.042+00	2021-11-08 10:20:42.772+00
3006	\N	died	2021-11-08 10:18:41.053+00	\N	\N	2021-11-08 10:19:30.944+00	2021-11-08 10:19:31.307+00
3022	\N	died	2021-11-08 10:18:41.104+00	\N	\N	2021-11-08 10:19:31.303+00	2021-11-08 10:19:31.39+00
3027	\N	died	2021-11-08 10:18:41.118+00	\N	\N	2021-11-08 10:19:31.385+00	2021-11-08 10:19:31.464+00
5727	\N	died	2021-11-08 10:19:52.265+00	\N	\N	2021-11-08 10:20:42.693+00	2021-11-08 10:20:42.829+00
3031	\N	died	2021-11-08 10:18:41.132+00	\N	\N	2021-11-08 10:19:31.456+00	2021-11-08 10:19:31.636+00
3037	\N	died	2021-11-08 10:18:41.145+00	\N	\N	2021-11-08 10:19:31.631+00	2021-11-08 10:19:31.798+00
3044	\N	died	2021-11-08 10:18:41.169+00	\N	\N	2021-11-08 10:19:31.793+00	2021-11-08 10:19:31.831+00
5734	\N	died	2021-11-08 10:19:52.357+00	\N	\N	2021-11-08 10:20:42.823+00	2021-11-08 10:20:42.994+00
3046	\N	died	2021-11-08 10:18:41.169+00	\N	\N	2021-11-08 10:19:31.828+00	2021-11-08 10:19:31.866+00
3048	\N	died	2021-11-08 10:18:41.177+00	\N	\N	2021-11-08 10:19:31.862+00	2021-11-08 10:19:32.015+00
3054	\N	died	2021-11-08 10:18:41.192+00	\N	\N	2021-11-08 10:19:32.01+00	2021-11-08 10:19:32.228+00
5740	\N	died	2021-11-08 10:19:52.49+00	\N	\N	2021-11-08 10:20:42.926+00	2021-11-08 10:20:43.448+00
5758	\N	died	2021-11-08 10:19:52.824+00	\N	\N	2021-11-08 10:20:43.426+00	2021-11-08 10:20:43.777+00
5769	\N	died	2021-11-08 10:19:53.056+00	\N	\N	2021-11-08 10:20:43.69+00	2021-11-08 10:20:44.305+00
5791	\N	died	2021-11-08 10:19:53.74+00	\N	\N	2021-11-08 10:20:44.206+00	2021-11-08 10:20:44.61+00
5809	\N	died	2021-11-08 10:19:54.45+00	\N	\N	2021-11-08 10:20:44.606+00	2021-11-08 10:20:44.965+00
5819	\N	died	2021-11-08 10:19:54.766+00	\N	\N	2021-11-08 10:20:44.95+00	2021-11-08 10:20:45.032+00
5821	\N	died	2021-11-08 10:19:54.849+00	\N	\N	2021-11-08 10:20:45.017+00	2021-11-08 10:20:45.187+00
5824	\N	died	2021-11-08 10:19:54.966+00	\N	\N	2021-11-08 10:20:45.175+00	2021-11-08 10:20:45.299+00
5828	\N	died	2021-11-08 10:19:55.083+00	\N	\N	2021-11-08 10:20:45.284+00	2021-11-08 10:20:45.43+00
5831	\N	died	2021-11-08 10:19:55.2+00	\N	\N	2021-11-08 10:20:45.417+00	2021-11-08 10:20:45.549+00
5835	\N	died	2021-11-08 10:19:55.291+00	\N	\N	2021-11-08 10:20:45.534+00	2021-11-08 10:20:45.673+00
2565	\N	died	2021-11-08 10:18:39.698+00	\N	\N	2021-11-08 10:19:21.549+00	2021-11-08 10:19:21.674+00
2920	\N	died	2021-11-08 10:18:40.823+00	\N	\N	2021-11-08 10:19:29.062+00	2021-11-08 10:19:29.582+00
2573	\N	died	2021-11-08 10:18:39.726+00	\N	\N	2021-11-08 10:19:21.67+00	2021-11-08 10:19:21.754+00
4112	\N	died	2021-11-08 10:18:58.178+00	\N	\N	2021-11-08 10:19:56.509+00	2021-11-08 10:19:56.713+00
2578	\N	died	2021-11-08 10:18:39.738+00	\N	\N	2021-11-08 10:19:21.75+00	2021-11-08 10:19:21.792+00
2580	\N	died	2021-11-08 10:18:39.746+00	\N	\N	2021-11-08 10:19:21.787+00	2021-11-08 10:19:21.905+00
2943	\N	died	2021-11-08 10:18:40.879+00	\N	\N	2021-11-08 10:19:29.552+00	2021-11-08 10:19:30.055+00
2584	\N	died	2021-11-08 10:18:39.754+00	\N	\N	2021-11-08 10:19:21.9+00	2021-11-08 10:19:22.125+00
3053	\N	died	2021-11-08 10:18:41.192+00	\N	\N	2021-11-08 10:19:31.952+00	2021-11-08 10:19:32.478+00
2592	\N	died	2021-11-08 10:18:39.787+00	\N	\N	2021-11-08 10:19:22.035+00	2021-11-08 10:19:22.562+00
2611	\N	died	2021-11-08 10:18:39.847+00	\N	\N	2021-11-08 10:19:22.452+00	2021-11-08 10:19:22.815+00
2961	\N	died	2021-11-08 10:18:40.933+00	\N	\N	2021-11-08 10:19:29.998+00	2021-11-08 10:19:30.451+00
2626	\N	died	2021-11-08 10:18:39.9+00	\N	\N	2021-11-08 10:19:22.793+00	2021-11-08 10:19:23.169+00
2642	\N	died	2021-11-08 10:18:39.947+00	\N	\N	2021-11-08 10:19:23.111+00	2021-11-08 10:19:23.333+00
2651	\N	died	2021-11-08 10:18:39.991+00	\N	\N	2021-11-08 10:19:23.311+00	2021-11-08 10:19:23.398+00
2981	\N	died	2021-11-08 10:18:40.976+00	\N	\N	2021-11-08 10:19:30.446+00	2021-11-08 10:19:30.69+00
2656	\N	died	2021-11-08 10:18:40.006+00	\N	\N	2021-11-08 10:19:23.394+00	2021-11-08 10:19:23.603+00
3946	\N	died	2021-11-08 10:18:54.631+00	\N	\N	2021-11-08 10:19:52.69+00	2021-11-08 10:19:52.729+00
2663	\N	died	2021-11-08 10:18:40.028+00	\N	\N	2021-11-08 10:19:23.562+00	2021-11-08 10:19:23.825+00
2674	\N	died	2021-11-08 10:18:40.076+00	\N	\N	2021-11-08 10:19:23.801+00	2021-11-08 10:19:23.988+00
2991	\N	died	2021-11-08 10:18:41.012+00	\N	\N	2021-11-08 10:19:30.656+00	2021-11-08 10:19:30.902+00
2681	\N	died	2021-11-08 10:18:40.098+00	\N	\N	2021-11-08 10:19:23.971+00	2021-11-08 10:19:24.338+00
4234	\N	died	2021-11-08 10:19:01.712+00	\N	\N	2021-11-08 10:19:59.15+00	2021-11-08 10:19:59.513+00
2694	\N	died	2021-11-08 10:18:40.146+00	\N	\N	2021-11-08 10:19:24.236+00	2021-11-08 10:19:24.53+00
2705	\N	died	2021-11-08 10:18:40.176+00	\N	\N	2021-11-08 10:19:24.476+00	2021-11-08 10:19:24.598+00
3003	\N	died	2021-11-08 10:18:41.047+00	\N	\N	2021-11-08 10:19:30.898+00	2021-11-08 10:19:31.127+00
2712	\N	died	2021-11-08 10:18:40.192+00	\N	\N	2021-11-08 10:19:24.592+00	2021-11-08 10:19:24.831+00
2722	\N	died	2021-11-08 10:18:40.233+00	\N	\N	2021-11-08 10:19:24.809+00	2021-11-08 10:19:25.331+00
2741	\N	died	2021-11-08 10:18:40.301+00	\N	\N	2021-11-08 10:19:25.327+00	2021-11-08 10:19:25.413+00
3013	\N	died	2021-11-08 10:18:41.066+00	\N	\N	2021-11-08 10:19:31.103+00	2021-11-08 10:19:31.555+00
2745	\N	died	2021-11-08 10:18:40.323+00	\N	\N	2021-11-08 10:19:25.381+00	2021-11-08 10:19:25.809+00
2756	\N	died	2021-11-08 10:18:40.359+00	\N	\N	2021-11-08 10:19:25.617+00	2021-11-08 10:19:25.89+00
2767	\N	died	2021-11-08 10:18:40.396+00	\N	\N	2021-11-08 10:19:25.851+00	2021-11-08 10:19:26.155+00
3032	\N	died	2021-11-08 10:18:41.132+00	\N	\N	2021-11-08 10:19:31.552+00	2021-11-08 10:19:31.798+00
2777	\N	died	2021-11-08 10:18:40.438+00	\N	\N	2021-11-08 10:19:26.068+00	2021-11-08 10:19:26.372+00
4124	\N	died	2021-11-08 10:18:58.348+00	\N	\N	2021-11-08 10:19:56.709+00	2021-11-08 10:19:56.828+00
2791	\N	died	2021-11-08 10:18:40.486+00	\N	\N	2021-11-08 10:19:26.356+00	2021-11-08 10:19:26.606+00
2802	\N	died	2021-11-08 10:18:40.511+00	\N	\N	2021-11-08 10:19:26.584+00	2021-11-08 10:19:27.017+00
3040	\N	died	2021-11-08 10:18:41.154+00	\N	\N	2021-11-08 10:19:31.681+00	2021-11-08 10:19:32.015+00
2814	\N	died	2021-11-08 10:18:40.543+00	\N	\N	2021-11-08 10:19:26.826+00	2021-11-08 10:19:27.083+00
3948	\N	died	2021-11-08 10:18:54.696+00	\N	\N	2021-11-08 10:19:52.725+00	2021-11-08 10:19:52.845+00
2825	\N	died	2021-11-08 10:18:40.575+00	\N	\N	2021-11-08 10:19:27.063+00	2021-11-08 10:19:27.24+00
2832	\N	died	2021-11-08 10:18:40.588+00	\N	\N	2021-11-08 10:19:27.227+00	2021-11-08 10:19:27.488+00
2845	\N	died	2021-11-08 10:18:40.62+00	\N	\N	2021-11-08 10:19:27.484+00	2021-11-08 10:19:27.633+00
3955	\N	died	2021-11-08 10:18:54.964+00	\N	\N	2021-11-08 10:19:52.842+00	2021-11-08 10:19:52.964+00
2849	\N	died	2021-11-08 10:18:40.636+00	\N	\N	2021-11-08 10:19:27.544+00	2021-11-08 10:19:27.939+00
2862	\N	died	2021-11-08 10:18:40.665+00	\N	\N	2021-11-08 10:19:27.852+00	2021-11-08 10:19:28.093+00
2873	\N	died	2021-11-08 10:18:40.701+00	\N	\N	2021-11-08 10:19:28.089+00	2021-11-08 10:19:28.173+00
3959	\N	died	2021-11-08 10:18:55.081+00	\N	\N	2021-11-08 10:19:52.959+00	2021-11-08 10:19:53.01+00
2878	\N	died	2021-11-08 10:18:40.709+00	\N	\N	2021-11-08 10:19:28.168+00	2021-11-08 10:19:28.398+00
4129	\N	died	2021-11-08 10:18:58.402+00	\N	\N	2021-11-08 10:19:56.791+00	2021-11-08 10:19:57.069+00
2886	\N	died	2021-11-08 10:18:40.726+00	\N	\N	2021-11-08 10:19:28.343+00	2021-11-08 10:19:28.664+00
2902	\N	died	2021-11-08 10:18:40.773+00	\N	\N	2021-11-08 10:19:28.66+00	2021-11-08 10:19:28.852+00
3962	\N	died	2021-11-08 10:18:55.222+00	\N	\N	2021-11-08 10:19:53.007+00	2021-11-08 10:19:53.152+00
2910	\N	died	2021-11-08 10:18:40.795+00	\N	\N	2021-11-08 10:19:28.847+00	2021-11-08 10:19:29.081+00
3966	\N	died	2021-11-08 10:18:55.306+00	\N	\N	2021-11-08 10:19:53.075+00	2021-11-08 10:19:53.272+00
3974	\N	died	2021-11-08 10:18:55.555+00	\N	\N	2021-11-08 10:19:53.266+00	2021-11-08 10:19:53.503+00
4144	\N	died	2021-11-08 10:18:58.95+00	\N	\N	2021-11-08 10:19:57.043+00	2021-11-08 10:19:57.405+00
3984	\N	died	2021-11-08 10:18:55.897+00	\N	\N	2021-11-08 10:19:53.482+00	2021-11-08 10:19:54.119+00
4251	\N	died	2021-11-08 10:19:01.79+00	\N	\N	2021-11-08 10:19:59.476+00	2021-11-08 10:19:59.832+00
4005	\N	died	2021-11-08 10:18:56.241+00	\N	\N	2021-11-08 10:19:54.115+00	2021-11-08 10:19:54.334+00
4015	\N	died	2021-11-08 10:18:56.456+00	\N	\N	2021-11-08 10:19:54.316+00	2021-11-08 10:19:54.662+00
4159	\N	died	2021-11-08 10:18:59.263+00	\N	\N	2021-11-08 10:19:57.401+00	2021-11-08 10:19:57.606+00
4033	\N	died	2021-11-08 10:18:56.839+00	\N	\N	2021-11-08 10:19:54.658+00	2021-11-08 10:19:54.888+00
4043	\N	died	2021-11-08 10:18:56.989+00	\N	\N	2021-11-08 10:19:54.869+00	2021-11-08 10:19:55.345+00
4063	\N	died	2021-11-08 10:18:57.414+00	\N	\N	2021-11-08 10:19:55.292+00	2021-11-08 10:19:55.767+00
4167	\N	died	2021-11-08 10:18:59.489+00	\N	\N	2021-11-08 10:19:57.569+00	2021-11-08 10:19:58.056+00
4073	\N	died	2021-11-08 10:18:57.601+00	\N	\N	2021-11-08 10:19:55.706+00	2021-11-08 10:19:55.996+00
4086	\N	died	2021-11-08 10:18:57.914+00	\N	\N	2021-11-08 10:19:55.992+00	2021-11-08 10:19:56.047+00
4269	\N	died	2021-11-08 10:19:02.19+00	\N	\N	2021-11-08 10:19:59.827+00	2021-11-08 10:20:00.038+00
4089	\N	died	2021-11-08 10:18:57.932+00	\N	\N	2021-11-08 10:19:56.043+00	2021-11-08 10:19:56.343+00
5715	\N	died	2021-11-08 10:19:51.923+00	\N	\N	2021-11-08 10:20:41.949+00	2021-11-08 10:20:42.113+00
4098	\N	died	2021-11-08 10:18:58.14+00	\N	\N	2021-11-08 10:19:56.256+00	2021-11-08 10:19:56.444+00
4107	\N	died	2021-11-08 10:18:58.169+00	\N	\N	2021-11-08 10:19:56.44+00	2021-11-08 10:19:56.513+00
4276	\N	died	2021-11-08 10:19:02.391+00	\N	\N	2021-11-08 10:20:00.003+00	2021-11-08 10:20:00.272+00
4184	\N	died	2021-11-08 10:18:59.965+00	\N	\N	2021-11-08 10:19:57.943+00	2021-11-08 10:19:58.2+00
5753	\N	died	2021-11-08 10:19:52.757+00	\N	\N	2021-11-08 10:20:43.249+00	2021-11-08 10:20:43.777+00
4195	\N	died	2021-11-08 10:19:00.523+00	\N	\N	2021-11-08 10:19:58.195+00	2021-11-08 10:19:58.281+00
4198	\N	died	2021-11-08 10:19:00.615+00	\N	\N	2021-11-08 10:19:58.243+00	2021-11-08 10:19:58.663+00
4289	\N	died	2021-11-08 10:19:02.74+00	\N	\N	2021-11-08 10:20:00.269+00	2021-11-08 10:20:00.471+00
4208	\N	died	2021-11-08 10:19:01.001+00	\N	\N	2021-11-08 10:19:58.459+00	2021-11-08 10:19:58.953+00
4223	\N	died	2021-11-08 10:19:01.341+00	\N	\N	2021-11-08 10:19:58.899+00	2021-11-08 10:19:59.171+00
5719	\N	died	2021-11-08 10:19:52.057+00	\N	\N	2021-11-08 10:20:42.106+00	2021-11-08 10:20:42.626+00
4298	\N	died	2021-11-08 10:19:03.074+00	\N	\N	2021-11-08 10:20:00.468+00	2021-11-08 10:20:00.506+00
4300	\N	died	2021-11-08 10:19:03.14+00	\N	\N	2021-11-08 10:20:00.502+00	2021-11-08 10:20:00.588+00
5725	\N	died	2021-11-08 10:19:52.223+00	\N	\N	2021-11-08 10:20:42.608+00	2021-11-08 10:20:42.772+00
4303	\N	died	2021-11-08 10:19:03.233+00	\N	\N	2021-11-08 10:20:00.552+00	2021-11-08 10:20:00.847+00
5729	\N	died	2021-11-08 10:19:52.298+00	\N	\N	2021-11-08 10:20:42.722+00	2021-11-08 10:20:42.994+00
4304	\N	died	2021-11-08 10:19:03.315+00	\N	\N	2021-11-08 10:20:00.568+00	2021-11-08 10:20:01.08+00
4311	\N	died	2021-11-08 10:19:03.765+00	\N	\N	2021-11-08 10:20:00.843+00	2021-11-08 10:20:01.08+00
5823	\N	died	2021-11-08 10:19:54.899+00	\N	\N	2021-11-08 10:20:45.133+00	2021-11-08 10:20:45.43+00
4321	\N	died	2021-11-08 10:19:04.333+00	\N	\N	2021-11-08 10:20:01.076+00	2021-11-08 10:20:01.13+00
5741	\N	died	2021-11-08 10:19:52.507+00	\N	\N	2021-11-08 10:20:42.957+00	2021-11-08 10:20:43.267+00
4324	\N	died	2021-11-08 10:19:04.533+00	\N	\N	2021-11-08 10:20:01.126+00	2021-11-08 10:20:01.163+00
5804	\N	died	2021-11-08 10:19:54.282+00	\N	\N	2021-11-08 10:20:44.524+00	2021-11-08 10:20:44.628+00
5770	\N	died	2021-11-08 10:19:53.074+00	\N	\N	2021-11-08 10:20:43.706+00	2021-11-08 10:20:44.037+00
5783	\N	died	2021-11-08 10:19:53.431+00	\N	\N	2021-11-08 10:20:44.015+00	2021-11-08 10:20:44.327+00
5797	\N	died	2021-11-08 10:19:53.983+00	\N	\N	2021-11-08 10:20:44.316+00	2021-11-08 10:20:44.493+00
5802	\N	died	2021-11-08 10:19:54.174+00	\N	\N	2021-11-08 10:20:44.489+00	2021-11-08 10:20:44.528+00
5830	\N	died	2021-11-08 10:19:55.133+00	\N	\N	2021-11-08 10:20:45.341+00	2021-11-08 10:20:45.871+00
5810	\N	died	2021-11-08 10:19:54.516+00	\N	\N	2021-11-08 10:20:44.623+00	2021-11-08 10:20:44.998+00
5820	\N	died	2021-11-08 10:19:54.816+00	\N	\N	2021-11-08 10:20:44.984+00	2021-11-08 10:20:45.187+00
5844	\N	died	2021-11-08 10:19:55.759+00	\N	\N	2021-11-08 10:20:45.854+00	2021-11-08 10:20:46.005+00
2635	\N	died	2021-11-08 10:18:39.925+00	\N	\N	2021-11-08 10:19:22.935+00	2021-11-08 10:19:23.103+00
3036	\N	died	2021-11-08 10:18:41.139+00	\N	\N	2021-11-08 10:19:31.611+00	2021-11-08 10:19:32.033+00
2641	\N	died	2021-11-08 10:18:39.944+00	\N	\N	2021-11-08 10:19:23.099+00	2021-11-08 10:19:23.297+00
5726	\N	died	2021-11-08 10:19:52.24+00	\N	\N	2021-11-08 10:20:42.659+00	2021-11-08 10:20:42.772+00
2649	\N	died	2021-11-08 10:18:39.987+00	\N	\N	2021-11-08 10:19:23.282+00	2021-11-08 10:19:23.603+00
3055	\N	died	2021-11-08 10:18:41.192+00	\N	\N	2021-11-08 10:19:32.028+00	2021-11-08 10:19:32.334+00
2664	\N	died	2021-11-08 10:18:40.035+00	\N	\N	2021-11-08 10:19:23.581+00	2021-11-08 10:19:23.988+00
2680	\N	died	2021-11-08 10:18:40.093+00	\N	\N	2021-11-08 10:19:23.959+00	2021-11-08 10:19:24.124+00
2690	\N	died	2021-11-08 10:18:40.12+00	\N	\N	2021-11-08 10:19:24.12+00	2021-11-08 10:19:24.338+00
3993	\N	died	2021-11-08 10:18:56.048+00	\N	\N	2021-11-08 10:19:53.772+00	2021-11-08 10:19:53.938+00
2697	\N	died	2021-11-08 10:18:40.159+00	\N	\N	2021-11-08 10:19:24.286+00	2021-11-08 10:19:24.831+00
2715	\N	died	2021-11-08 10:18:40.206+00	\N	\N	2021-11-08 10:19:24.695+00	2021-11-08 10:19:24.951+00
2726	\N	died	2021-11-08 10:18:40.245+00	\N	\N	2021-11-08 10:19:24.946+00	2021-11-08 10:19:25.118+00
3997	\N	died	2021-11-08 10:18:56.131+00	\N	\N	2021-11-08 10:19:53.934+00	2021-11-08 10:19:54.002+00
2731	\N	died	2021-11-08 10:18:40.264+00	\N	\N	2021-11-08 10:19:25.028+00	2021-11-08 10:19:25.413+00
4267	\N	died	2021-11-08 10:19:02.156+00	\N	\N	2021-11-08 10:19:59.793+00	2021-11-08 10:20:00.188+00
2744	\N	died	2021-11-08 10:18:40.317+00	\N	\N	2021-11-08 10:19:25.368+00	2021-11-08 10:19:25.566+00
2753	\N	died	2021-11-08 10:18:40.348+00	\N	\N	2021-11-08 10:19:25.562+00	2021-11-08 10:19:25.809+00
4000	\N	died	2021-11-08 10:18:56.181+00	\N	\N	2021-11-08 10:19:53.983+00	2021-11-08 10:19:54.334+00
2763	\N	died	2021-11-08 10:18:40.381+00	\N	\N	2021-11-08 10:19:25.784+00	2021-11-08 10:19:26.155+00
2780	\N	died	2021-11-08 10:18:40.451+00	\N	\N	2021-11-08 10:19:26.122+00	2021-11-08 10:19:26.606+00
2799	\N	died	2021-11-08 10:18:40.504+00	\N	\N	2021-11-08 10:19:26.539+00	2021-11-08 10:19:26.759+00
4013	\N	died	2021-11-08 10:18:56.406+00	\N	\N	2021-11-08 10:19:54.283+00	2021-11-08 10:19:54.611+00
2808	\N	died	2021-11-08 10:18:40.525+00	\N	\N	2021-11-08 10:19:26.734+00	2021-11-08 10:19:27.017+00
2821	\N	died	2021-11-08 10:18:40.562+00	\N	\N	2021-11-08 10:19:26.993+00	2021-11-08 10:19:27.439+00
2839	\N	died	2021-11-08 10:18:40.601+00	\N	\N	2021-11-08 10:19:27.334+00	2021-11-08 10:19:27.689+00
4025	\N	died	2021-11-08 10:18:56.689+00	\N	\N	2021-11-08 10:19:54.534+00	2021-11-08 10:19:54.753+00
2854	\N	died	2021-11-08 10:18:40.65+00	\N	\N	2021-11-08 10:19:27.673+00	2021-11-08 10:19:27.939+00
4283	\N	died	2021-11-08 10:19:02.54+00	\N	\N	2021-11-08 10:20:00.118+00	2021-11-08 10:20:00.471+00
2866	\N	died	2021-11-08 10:18:40.679+00	\N	\N	2021-11-08 10:19:27.922+00	2021-11-08 10:19:28.398+00
2883	\N	died	2021-11-08 10:18:40.718+00	\N	\N	2021-11-08 10:19:28.251+00	2021-11-08 10:19:28.577+00
4036	\N	died	2021-11-08 10:18:56.907+00	\N	\N	2021-11-08 10:19:54.749+00	2021-11-08 10:19:54.984+00
2896	\N	died	2021-11-08 10:18:40.749+00	\N	\N	2021-11-08 10:19:28.552+00	2021-11-08 10:19:28.688+00
2903	\N	died	2021-11-08 10:18:40.78+00	\N	\N	2021-11-08 10:19:28.681+00	2021-11-08 10:19:28.914+00
2912	\N	died	2021-11-08 10:18:40.795+00	\N	\N	2021-11-08 10:19:28.876+00	2021-11-08 10:19:29.168+00
4046	\N	died	2021-11-08 10:18:57.04+00	\N	\N	2021-11-08 10:19:54.967+00	2021-11-08 10:19:55.088+00
2923	\N	died	2021-11-08 10:18:40.83+00	\N	\N	2021-11-08 10:19:29.114+00	2021-11-08 10:19:29.341+00
4297	\N	died	2021-11-08 10:19:02.99+00	\N	\N	2021-11-08 10:20:00.455+00	2021-11-08 10:20:00.588+00
2933	\N	died	2021-11-08 10:18:40.859+00	\N	\N	2021-11-08 10:19:29.337+00	2021-11-08 10:19:29.582+00
2938	\N	died	2021-11-08 10:18:40.871+00	\N	\N	2021-11-08 10:19:29.473+00	2021-11-08 10:19:29.758+00
4052	\N	died	2021-11-08 10:18:57.133+00	\N	\N	2021-11-08 10:19:55.064+00	2021-11-08 10:19:55.288+00
2949	\N	died	2021-11-08 10:18:40.901+00	\N	\N	2021-11-08 10:19:29.707+00	2021-11-08 10:19:30.055+00
4301	\N	died	2021-11-08 10:19:03.166+00	\N	\N	2021-11-08 10:20:00.518+00	2021-11-08 10:20:00.588+00
2960	\N	died	2021-11-08 10:18:40.927+00	\N	\N	2021-11-08 10:19:29.935+00	2021-11-08 10:19:30.314+00
2976	\N	died	2021-11-08 10:18:40.967+00	\N	\N	2021-11-08 10:19:30.297+00	2021-11-08 10:19:30.69+00
4060	\N	died	2021-11-08 10:18:57.314+00	\N	\N	2021-11-08 10:19:55.25+00	2021-11-08 10:19:55.767+00
2990	\N	died	2021-11-08 10:18:41.005+00	\N	\N	2021-11-08 10:19:30.643+00	2021-11-08 10:19:30.838+00
2999	\N	died	2021-11-08 10:18:41.032+00	\N	\N	2021-11-08 10:19:30.83+00	2021-11-08 10:19:30.956+00
3004	\N	died	2021-11-08 10:18:41.047+00	\N	\N	2021-11-08 10:19:30.911+00	2021-11-08 10:19:31.39+00
3024	\N	died	2021-11-08 10:18:41.111+00	\N	\N	2021-11-08 10:19:31.336+00	2021-11-08 10:19:31.636+00
4305	\N	died	2021-11-08 10:19:03.349+00	\N	\N	2021-11-08 10:20:00.585+00	2021-11-08 10:20:00.817+00
4075	\N	died	2021-11-08 10:18:57.664+00	\N	\N	2021-11-08 10:19:55.743+00	2021-11-08 10:19:56.221+00
5731	\N	died	2021-11-08 10:19:52.315+00	\N	\N	2021-11-08 10:20:42.758+00	2021-11-08 10:20:42.815+00
4092	\N	died	2021-11-08 10:18:58.048+00	\N	\N	2021-11-08 10:19:56.15+00	2021-11-08 10:19:56.469+00
4109	\N	died	2021-11-08 10:18:58.172+00	\N	\N	2021-11-08 10:19:56.465+00	2021-11-08 10:19:56.612+00
4114	\N	died	2021-11-08 10:18:58.184+00	\N	\N	2021-11-08 10:19:56.543+00	2021-11-08 10:19:56.828+00
4128	\N	died	2021-11-08 10:18:58.401+00	\N	\N	2021-11-08 10:19:56.776+00	2021-11-08 10:19:56.993+00
4294	\N	died	2021-11-08 10:19:02.89+00	\N	\N	2021-11-08 10:20:00.352+00	2021-11-08 10:20:00.865+00
4140	\N	died	2021-11-08 10:18:58.757+00	\N	\N	2021-11-08 10:19:56.975+00	2021-11-08 10:19:57.296+00
4155	\N	died	2021-11-08 10:18:59.184+00	\N	\N	2021-11-08 10:19:57.223+00	2021-11-08 10:19:57.606+00
4309	\N	died	2021-11-08 10:19:03.615+00	\N	\N	2021-11-08 10:20:00.812+00	2021-11-08 10:20:00.898+00
4168	\N	died	2021-11-08 10:18:59.506+00	\N	\N	2021-11-08 10:19:57.585+00	2021-11-08 10:19:58.056+00
4188	\N	died	2021-11-08 10:19:00.148+00	\N	\N	2021-11-08 10:19:58.034+00	2021-11-08 10:19:58.663+00
4312	\N	died	2021-11-08 10:19:03.807+00	\N	\N	2021-11-08 10:20:00.861+00	2021-11-08 10:20:01.13+00
4209	\N	died	2021-11-08 10:19:01.032+00	\N	\N	2021-11-08 10:19:58.477+00	2021-11-08 10:19:58.953+00
5733	\N	died	2021-11-08 10:19:52.331+00	\N	\N	2021-11-08 10:20:42.807+00	2021-11-08 10:20:42.994+00
4225	\N	died	2021-11-08 10:19:01.482+00	\N	\N	2021-11-08 10:19:58.935+00	2021-11-08 10:19:59.278+00
4242	\N	died	2021-11-08 10:19:01.745+00	\N	\N	2021-11-08 10:19:59.274+00	2021-11-08 10:19:59.513+00
4250	\N	died	2021-11-08 10:19:01.77+00	\N	\N	2021-11-08 10:19:59.413+00	2021-11-08 10:19:59.815+00
5738	\N	died	2021-11-08 10:19:52.459+00	\N	\N	2021-11-08 10:20:42.892+00	2021-11-08 10:20:43.267+00
4322	\N	died	2021-11-08 10:19:04.459+00	\N	\N	2021-11-08 10:20:01.095+00	2021-11-08 10:20:01.233+00
5825	\N	died	2021-11-08 10:19:55+00	\N	\N	2021-11-08 10:20:45.199+00	2021-11-08 10:20:45.549+00
4313	\N	died	2021-11-08 10:19:03.848+00	\N	\N	2021-11-08 10:20:00.878+00	2021-11-08 10:20:01.267+00
5751	\N	died	2021-11-08 10:19:52.724+00	\N	\N	2021-11-08 10:20:43.2+00	2021-11-08 10:20:43.777+00
4327	\N	died	2021-11-08 10:19:04.841+00	\N	\N	2021-11-08 10:20:01.227+00	2021-11-08 10:20:01.349+00
4329	\N	died	2021-11-08 10:19:04.957+00	\N	\N	2021-11-08 10:20:01.262+00	2021-11-08 10:20:01.382+00
4336	\N	died	2021-11-08 10:19:05.391+00	\N	\N	2021-11-08 10:20:01.377+00	2021-11-08 10:20:01.499+00
4340	\N	died	2021-11-08 10:19:05.615+00	\N	\N	2021-11-08 10:20:01.494+00	2021-11-08 10:20:01.55+00
5766	\N	died	2021-11-08 10:19:52.99+00	\N	\N	2021-11-08 10:20:43.573+00	2021-11-08 10:20:43.864+00
4343	\N	died	2021-11-08 10:19:05.857+00	\N	\N	2021-11-08 10:20:01.545+00	2021-11-08 10:20:01.631+00
4332	\N	died	2021-11-08 10:19:05.14+00	\N	\N	2021-11-08 10:20:01.31+00	2021-11-08 10:20:01.698+00
5777	\N	died	2021-11-08 10:19:53.265+00	\N	\N	2021-11-08 10:20:43.823+00	2021-11-08 10:20:44.069+00
4348	\N	died	2021-11-08 10:19:06.107+00	\N	\N	2021-11-08 10:20:01.627+00	2021-11-08 10:20:01.812+00
4349	\N	died	2021-11-08 10:19:06.124+00	\N	\N	2021-11-08 10:20:01.694+00	2021-11-08 10:20:01.812+00
5786	\N	died	2021-11-08 10:19:53.481+00	\N	\N	2021-11-08 10:20:44.065+00	2021-11-08 10:20:44.305+00
5794	\N	died	2021-11-08 10:19:53.899+00	\N	\N	2021-11-08 10:20:44.265+00	2021-11-08 10:20:44.965+00
5812	\N	died	2021-11-08 10:19:54.558+00	\N	\N	2021-11-08 10:20:44.725+00	2021-11-08 10:20:45.299+00
5833	\N	died	2021-11-08 10:19:55.249+00	\N	\N	2021-11-08 10:20:45.477+00	2021-11-08 10:20:46.325+00
5851	\N	died	2021-11-08 10:19:55.974+00	\N	\N	2021-11-08 10:20:46.075+00	2021-11-08 10:20:46.618+00
5866	\N	died	2021-11-08 10:19:56.542+00	\N	\N	2021-11-08 10:20:46.601+00	2021-11-08 10:20:47.093+00
5875	\N	died	2021-11-08 10:19:56.808+00	\N	\N	2021-11-08 10:20:47.075+00	2021-11-08 10:20:47.211+00
5878	\N	died	2021-11-08 10:19:56.892+00	\N	\N	2021-11-08 10:20:47.196+00	2021-11-08 10:20:47.335+00
5880	\N	died	2021-11-08 10:19:56.941+00	\N	\N	2021-11-08 10:20:47.32+00	2021-11-08 10:20:47.459+00
5884	\N	died	2021-11-08 10:19:57.026+00	\N	\N	2021-11-08 10:20:47.447+00	2021-11-08 10:20:47.539+00
2652	\N	died	2021-11-08 10:18:39.996+00	\N	\N	2021-11-08 10:19:23.329+00	2021-11-08 10:19:23.367+00
3026	\N	died	2021-11-08 10:18:41.118+00	\N	\N	2021-11-08 10:19:31.373+00	2021-11-08 10:19:31.798+00
2654	\N	died	2021-11-08 10:18:40.001+00	\N	\N	2021-11-08 10:19:23.361+00	2021-11-08 10:19:23.53+00
2659	\N	died	2021-11-08 10:18:40.013+00	\N	\N	2021-11-08 10:19:23.495+00	2021-11-08 10:19:23.793+00
3042	\N	died	2021-11-08 10:18:41.154+00	\N	\N	2021-11-08 10:19:31.71+00	2021-11-08 10:19:32.334+00
2667	\N	died	2021-11-08 10:18:40.052+00	\N	\N	2021-11-08 10:19:23.633+00	2021-11-08 10:19:23.893+00
2678	\N	died	2021-11-08 10:18:40.089+00	\N	\N	2021-11-08 10:19:23.87+00	2021-11-08 10:19:24.091+00
4030	\N	died	2021-11-08 10:18:56.741+00	\N	\N	2021-11-08 10:19:54.607+00	2021-11-08 10:19:54.678+00
2686	\N	died	2021-11-08 10:18:40.109+00	\N	\N	2021-11-08 10:19:24.052+00	2021-11-08 10:19:24.43+00
2701	\N	died	2021-11-08 10:18:40.171+00	\N	\N	2021-11-08 10:19:24.356+00	2021-11-08 10:19:24.584+00
2711	\N	died	2021-11-08 10:18:40.192+00	\N	\N	2021-11-08 10:19:24.58+00	2021-11-08 10:19:24.831+00
4034	\N	died	2021-11-08 10:18:56.873+00	\N	\N	2021-11-08 10:19:54.675+00	2021-11-08 10:19:54.888+00
2721	\N	died	2021-11-08 10:18:40.233+00	\N	\N	2021-11-08 10:19:24.797+00	2021-11-08 10:19:25.269+00
4244	\N	died	2021-11-08 10:19:01.75+00	\N	\N	2021-11-08 10:19:59.31+00	2021-11-08 10:19:59.714+00
2738	\N	died	2021-11-08 10:18:40.284+00	\N	\N	2021-11-08 10:19:25.228+00	2021-11-08 10:19:25.809+00
2757	\N	died	2021-11-08 10:18:40.359+00	\N	\N	2021-11-08 10:19:25.627+00	2021-11-08 10:19:25.89+00
4044	\N	died	2021-11-08 10:18:56.99+00	\N	\N	2021-11-08 10:19:54.884+00	2021-11-08 10:19:54.984+00
2768	\N	died	2021-11-08 10:18:40.403+00	\N	\N	2021-11-08 10:19:25.872+00	2021-11-08 10:19:26.155+00
5736	\N	died	2021-11-08 10:19:52.441+00	\N	\N	2021-11-08 10:20:42.847+00	2021-11-08 10:20:43.028+00
2779	\N	died	2021-11-08 10:18:40.445+00	\N	\N	2021-11-08 10:19:26.102+00	2021-11-08 10:19:26.508+00
2795	\N	died	2021-11-08 10:18:40.491+00	\N	\N	2021-11-08 10:19:26.418+00	2021-11-08 10:19:27.017+00
4047	\N	died	2021-11-08 10:18:57.042+00	\N	\N	2021-11-08 10:19:54.981+00	2021-11-08 10:19:55.036+00
2816	\N	died	2021-11-08 10:18:40.549+00	\N	\N	2021-11-08 10:19:26.859+00	2021-11-08 10:19:27.181+00
2829	\N	died	2021-11-08 10:18:40.582+00	\N	\N	2021-11-08 10:19:27.177+00	2021-11-08 10:19:27.439+00
2838	\N	died	2021-11-08 10:18:40.601+00	\N	\N	2021-11-08 10:19:27.318+00	2021-11-08 10:19:27.648+00
4050	\N	died	2021-11-08 10:18:57.108+00	\N	\N	2021-11-08 10:19:55.032+00	2021-11-08 10:19:55.205+00
2852	\N	died	2021-11-08 10:18:40.644+00	\N	\N	2021-11-08 10:19:27.643+00	2021-11-08 10:19:27.727+00
4261	\N	died	2021-11-08 10:19:01.952+00	\N	\N	2021-11-08 10:19:59.644+00	2021-11-08 10:19:59.971+00
2857	\N	died	2021-11-08 10:18:40.658+00	\N	\N	2021-11-08 10:19:27.724+00	2021-11-08 10:19:27.939+00
2865	\N	died	2021-11-08 10:18:40.672+00	\N	\N	2021-11-08 10:19:27.901+00	2021-11-08 10:19:28.398+00
4055	\N	died	2021-11-08 10:18:57.182+00	\N	\N	2021-11-08 10:19:55.116+00	2021-11-08 10:19:55.651+00
2881	\N	died	2021-11-08 10:18:40.718+00	\N	\N	2021-11-08 10:19:28.223+00	2021-11-08 10:19:28.446+00
2892	\N	died	2021-11-08 10:18:40.74+00	\N	\N	2021-11-08 10:19:28.443+00	2021-11-08 10:19:28.54+00
2895	\N	died	2021-11-08 10:18:40.749+00	\N	\N	2021-11-08 10:19:28.536+00	2021-11-08 10:19:28.647+00
4070	\N	died	2021-11-08 10:18:57.582+00	\N	\N	2021-11-08 10:19:55.509+00	2021-11-08 10:19:55.979+00
2899	\N	died	2021-11-08 10:18:40.758+00	\N	\N	2021-11-08 10:19:28.61+00	2021-11-08 10:19:28.914+00
2911	\N	died	2021-11-08 10:18:40.795+00	\N	\N	2021-11-08 10:19:28.86+00	2021-11-08 10:19:29.168+00
2922	\N	died	2021-11-08 10:18:40.823+00	\N	\N	2021-11-08 10:19:29.093+00	2021-11-08 10:19:29.326+00
4084	\N	died	2021-11-08 10:18:57.848+00	\N	\N	2021-11-08 10:19:55.959+00	2021-11-08 10:19:56.343+00
2931	\N	died	2021-11-08 10:18:40.851+00	\N	\N	2021-11-08 10:19:29.301+00	2021-11-08 10:19:29.582+00
4273	\N	died	2021-11-08 10:19:02.256+00	\N	\N	2021-11-08 10:19:59.951+00	2021-11-08 10:20:00.471+00
2940	\N	died	2021-11-08 10:18:40.871+00	\N	\N	2021-11-08 10:19:29.503+00	2021-11-08 10:19:29.773+00
2953	\N	died	2021-11-08 10:18:40.909+00	\N	\N	2021-11-08 10:19:29.768+00	2021-11-08 10:19:29.825+00
4097	\N	died	2021-11-08 10:18:58.123+00	\N	\N	2021-11-08 10:19:56.234+00	2021-11-08 10:19:56.394+00
2956	\N	died	2021-11-08 10:18:40.916+00	\N	\N	2021-11-08 10:19:29.82+00	2021-11-08 10:19:30.094+00
2966	\N	died	2021-11-08 10:18:40.939+00	\N	\N	2021-11-08 10:19:30.068+00	2021-11-08 10:19:30.388+00
2978	\N	died	2021-11-08 10:18:40.972+00	\N	\N	2021-11-08 10:19:30.381+00	2021-11-08 10:19:30.635+00
4104	\N	died	2021-11-08 10:18:58.164+00	\N	\N	2021-11-08 10:19:56.39+00	2021-11-08 10:19:56.469+00
2984	\N	died	2021-11-08 10:18:40.984+00	\N	\N	2021-11-08 10:19:30.493+00	2021-11-08 10:19:30.743+00
2996	\N	died	2021-11-08 10:18:41.027+00	\N	\N	2021-11-08 10:19:30.739+00	2021-11-08 10:19:30.882+00
3000	\N	died	2021-11-08 10:18:41.032+00	\N	\N	2021-11-08 10:19:30.843+00	2021-11-08 10:19:31.127+00
4108	\N	died	2021-11-08 10:18:58.171+00	\N	\N	2021-11-08 10:19:56.458+00	2021-11-08 10:19:56.663+00
3009	\N	died	2021-11-08 10:18:41.06+00	\N	\N	2021-11-08 10:19:30.985+00	2021-11-08 10:19:31.39+00
4295	\N	died	2021-11-08 10:19:02.907+00	\N	\N	2021-11-08 10:20:00.418+00	2021-11-08 10:20:00.898+00
5745	\N	died	2021-11-08 10:19:52.591+00	\N	\N	2021-11-08 10:20:43.023+00	2021-11-08 10:20:43.267+00
4120	\N	died	2021-11-08 10:18:58.258+00	\N	\N	2021-11-08 10:19:56.641+00	2021-11-08 10:19:56.847+00
4132	\N	died	2021-11-08 10:18:58.497+00	\N	\N	2021-11-08 10:19:56.843+00	2021-11-08 10:19:56.993+00
4314	\N	died	2021-11-08 10:19:03.949+00	\N	\N	2021-11-08 10:20:00.894+00	2021-11-08 10:20:01.13+00
4139	\N	died	2021-11-08 10:18:58.723+00	\N	\N	2021-11-08 10:19:56.959+00	2021-11-08 10:19:57.203+00
4153	\N	died	2021-11-08 10:18:59.166+00	\N	\N	2021-11-08 10:19:57.199+00	2021-11-08 10:19:57.37+00
4326	\N	died	2021-11-08 10:19:04.749+00	\N	\N	2021-11-08 10:20:01.16+00	2021-11-08 10:20:01.248+00
4158	\N	died	2021-11-08 10:18:59.234+00	\N	\N	2021-11-08 10:19:57.367+00	2021-11-08 10:19:57.519+00
4164	\N	died	2021-11-08 10:18:59.441+00	\N	\N	2021-11-08 10:19:57.515+00	2021-11-08 10:19:57.702+00
4174	\N	died	2021-11-08 10:18:59.69+00	\N	\N	2021-11-08 10:19:57.685+00	2021-11-08 10:19:58.18+00
4192	\N	died	2021-11-08 10:19:00.334+00	\N	\N	2021-11-08 10:19:58.149+00	2021-11-08 10:19:58.663+00
4207	\N	died	2021-11-08 10:19:00.999+00	\N	\N	2021-11-08 10:19:58.443+00	2021-11-08 10:19:58.89+00
5752	\N	died	2021-11-08 10:19:52.74+00	\N	\N	2021-11-08 10:20:43.233+00	2021-11-08 10:20:43.777+00
4221	\N	died	2021-11-08 10:19:01.315+00	\N	\N	2021-11-08 10:19:58.864+00	2021-11-08 10:19:59.219+00
5859	\N	died	2021-11-08 10:19:56.2+00	\N	\N	2021-11-08 10:20:46.376+00	2021-11-08 10:20:46.553+00
4238	\N	died	2021-11-08 10:19:01.735+00	\N	\N	2021-11-08 10:19:59.215+00	2021-11-08 10:19:59.348+00
4323	\N	died	2021-11-08 10:19:04.491+00	\N	\N	2021-11-08 10:20:01.11+00	2021-11-08 10:20:01.349+00
4328	\N	died	2021-11-08 10:19:04.874+00	\N	\N	2021-11-08 10:20:01.244+00	2021-11-08 10:20:01.349+00
4334	\N	died	2021-11-08 10:19:05.291+00	\N	\N	2021-11-08 10:20:01.344+00	2021-11-08 10:20:01.499+00
5768	\N	died	2021-11-08 10:19:53.024+00	\N	\N	2021-11-08 10:20:43.667+00	2021-11-08 10:20:44.037+00
4333	\N	died	2021-11-08 10:19:05.191+00	\N	\N	2021-11-08 10:20:01.327+00	2021-11-08 10:20:01.812+00
4338	\N	died	2021-11-08 10:19:05.549+00	\N	\N	2021-11-08 10:20:01.463+00	2021-11-08 10:20:01.812+00
4351	\N	died	2021-11-08 10:19:06.258+00	\N	\N	2021-11-08 10:20:01.727+00	2021-11-08 10:20:02.365+00
5781	\N	died	2021-11-08 10:19:53.383+00	\N	\N	2021-11-08 10:20:43.983+00	2021-11-08 10:20:44.305+00
4352	\N	died	2021-11-08 10:19:06.384+00	\N	\N	2021-11-08 10:20:01.745+00	2021-11-08 10:20:02.578+00
4366	\N	died	2021-11-08 10:19:07.057+00	\N	\N	2021-11-08 10:20:02.361+00	2021-11-08 10:20:02.578+00
5793	\N	died	2021-11-08 10:19:53.84+00	\N	\N	2021-11-08 10:20:44.237+00	2021-11-08 10:20:44.965+00
4376	\N	died	2021-11-08 10:19:07.099+00	\N	\N	2021-11-08 10:20:02.574+00	2021-11-08 10:20:02.662+00
5864	\N	died	2021-11-08 10:19:56.425+00	\N	\N	2021-11-08 10:20:46.535+00	2021-11-08 10:20:47.093+00
4381	\N	died	2021-11-08 10:19:07.112+00	\N	\N	2021-11-08 10:20:02.658+00	2021-11-08 10:20:02.797+00
5814	\N	died	2021-11-08 10:19:54.625+00	\N	\N	2021-11-08 10:20:44.794+00	2021-11-08 10:20:45.43+00
4386	\N	died	2021-11-08 10:19:07.128+00	\N	\N	2021-11-08 10:20:02.793+00	2021-11-08 10:20:02.829+00
5883	\N	died	2021-11-08 10:19:57.008+00	\N	\N	2021-11-08 10:20:47.416+00	2021-11-08 10:20:47.73+00
5829	\N	died	2021-11-08 10:19:55.1+00	\N	\N	2021-11-08 10:20:45.309+00	2021-11-08 10:20:45.673+00
5837	\N	died	2021-11-08 10:19:55.357+00	\N	\N	2021-11-08 10:20:45.583+00	2021-11-08 10:20:46.037+00
5849	\N	died	2021-11-08 10:19:55.942+00	\N	\N	2021-11-08 10:20:46.025+00	2021-11-08 10:20:46.473+00
5869	\N	died	2021-11-08 10:19:56.625+00	\N	\N	2021-11-08 10:20:46.759+00	2021-11-08 10:20:47.459+00
5890	\N	died	2021-11-08 10:19:57.183+00	\N	\N	2021-11-08 10:20:47.676+00	2021-11-08 10:20:48.002+00
5903	\N	died	2021-11-08 10:19:57.667+00	\N	\N	2021-11-08 10:20:47.998+00	2021-11-08 10:20:48.079+00
5907	\N	died	2021-11-08 10:19:57.768+00	\N	\N	2021-11-08 10:20:48.074+00	2021-11-08 10:20:48.169+00
5911	\N	died	2021-11-08 10:19:57.943+00	\N	\N	2021-11-08 10:20:48.16+00	2021-11-08 10:20:48.291+00
2700	\N	died	2021-11-08 10:18:40.165+00	\N	\N	2021-11-08 10:19:24.334+00	2021-11-08 10:19:24.465+00
2704	\N	died	2021-11-08 10:18:40.176+00	\N	\N	2021-11-08 10:19:24.461+00	2021-11-08 10:19:24.53+00
2708	\N	died	2021-11-08 10:18:40.182+00	\N	\N	2021-11-08 10:19:24.527+00	2021-11-08 10:19:24.563+00
3052	\N	died	2021-11-08 10:18:41.184+00	\N	\N	2021-11-08 10:19:31.928+00	2021-11-08 10:19:32.349+00
2710	\N	died	2021-11-08 10:18:40.187+00	\N	\N	2021-11-08 10:19:24.559+00	2021-11-08 10:19:24.831+00
2718	\N	died	2021-11-08 10:18:40.221+00	\N	\N	2021-11-08 10:19:24.752+00	2021-11-08 10:19:25.269+00
2736	\N	died	2021-11-08 10:18:40.28+00	\N	\N	2021-11-08 10:19:25.197+00	2021-11-08 10:19:25.546+00
4066	\N	died	2021-11-08 10:18:57.433+00	\N	\N	2021-11-08 10:19:55.34+00	2021-11-08 10:19:55.48+00
2752	\N	died	2021-11-08 10:18:40.343+00	\N	\N	2021-11-08 10:19:25.542+00	2021-11-08 10:19:25.809+00
4291	\N	died	2021-11-08 10:19:02.856+00	\N	\N	2021-11-08 10:20:00.302+00	2021-11-08 10:20:00.817+00
2762	\N	died	2021-11-08 10:18:40.381+00	\N	\N	2021-11-08 10:19:25.713+00	2021-11-08 10:19:26.155+00
2778	\N	died	2021-11-08 10:18:40.445+00	\N	\N	2021-11-08 10:19:26.09+00	2021-11-08 10:19:26.508+00
4069	\N	died	2021-11-08 10:18:57.547+00	\N	\N	2021-11-08 10:19:55.476+00	2021-11-08 10:19:55.767+00
2793	\N	died	2021-11-08 10:18:40.486+00	\N	\N	2021-11-08 10:19:26.386+00	2021-11-08 10:19:26.625+00
4377	\N	died	2021-11-08 10:19:07.105+00	\N	\N	2021-11-08 10:20:02.594+00	2021-11-08 10:20:02.797+00
2804	\N	died	2021-11-08 10:18:40.517+00	\N	\N	2021-11-08 10:19:26.622+00	2021-11-08 10:19:26.759+00
2807	\N	died	2021-11-08 10:18:40.525+00	\N	\N	2021-11-08 10:19:26.72+00	2021-11-08 10:19:27.017+00
4074	\N	died	2021-11-08 10:18:57.632+00	\N	\N	2021-11-08 10:19:55.725+00	2021-11-08 10:19:56.121+00
2817	\N	died	2021-11-08 10:18:40.549+00	\N	\N	2021-11-08 10:19:26.878+00	2021-11-08 10:19:27.218+00
2831	\N	died	2021-11-08 10:18:40.588+00	\N	\N	2021-11-08 10:19:27.214+00	2021-11-08 10:19:27.439+00
2841	\N	died	2021-11-08 10:18:40.612+00	\N	\N	2021-11-08 10:19:27.419+00	2021-11-08 10:19:27.789+00
4090	\N	died	2021-11-08 10:18:57.949+00	\N	\N	2021-11-08 10:19:56.117+00	2021-11-08 10:19:56.343+00
2860	\N	died	2021-11-08 10:18:40.665+00	\N	\N	2021-11-08 10:19:27.772+00	2021-11-08 10:19:28.16+00
4306	\N	died	2021-11-08 10:19:03.423+00	\N	\N	2021-11-08 10:20:00.755+00	2021-11-08 10:20:01.08+00
2877	\N	died	2021-11-08 10:18:40.709+00	\N	\N	2021-11-08 10:19:28.156+00	2021-11-08 10:19:28.398+00
2884	\N	died	2021-11-08 10:18:40.726+00	\N	\N	2021-11-08 10:19:28.323+00	2021-11-08 10:19:28.647+00
4100	\N	died	2021-11-08 10:18:58.156+00	\N	\N	2021-11-08 10:19:56.275+00	2021-11-08 10:19:56.612+00
2898	\N	died	2021-11-08 10:18:40.758+00	\N	\N	2021-11-08 10:19:28.595+00	2021-11-08 10:19:28.83+00
4373	\N	died	2021-11-08 10:19:07.091+00	\N	\N	2021-11-08 10:20:02.476+00	2021-11-08 10:20:02.797+00
2909	\N	died	2021-11-08 10:18:40.786+00	\N	\N	2021-11-08 10:19:28.826+00	2021-11-08 10:19:29.081+00
2917	\N	died	2021-11-08 10:18:40.816+00	\N	\N	2021-11-08 10:19:29.015+00	2021-11-08 10:19:29.275+00
4113	\N	died	2021-11-08 10:18:58.18+00	\N	\N	2021-11-08 10:19:56.523+00	2021-11-08 10:19:56.761+00
2929	\N	died	2021-11-08 10:18:40.851+00	\N	\N	2021-11-08 10:19:29.272+00	2021-11-08 10:19:29.356+00
2934	\N	died	2021-11-08 10:18:40.859+00	\N	\N	2021-11-08 10:19:29.352+00	2021-11-08 10:19:29.582+00
2942	\N	died	2021-11-08 10:18:40.879+00	\N	\N	2021-11-08 10:19:29.537+00	2021-11-08 10:19:30.055+00
4126	\N	died	2021-11-08 10:18:58.385+00	\N	\N	2021-11-08 10:19:56.743+00	2021-11-08 10:19:56.896+00
2957	\N	died	2021-11-08 10:18:40.916+00	\N	\N	2021-11-08 10:19:29.839+00	2021-11-08 10:19:30.167+00
4315	\N	died	2021-11-08 10:19:03.982+00	\N	\N	2021-11-08 10:20:00.91+00	2021-11-08 10:20:01.163+00
2968	\N	died	2021-11-08 10:18:40.945+00	\N	\N	2021-11-08 10:19:30.16+00	2021-11-08 10:19:30.248+00
2971	\N	died	2021-11-08 10:18:40.95+00	\N	\N	2021-11-08 10:19:30.21+00	2021-11-08 10:19:30.414+00
4133	\N	died	2021-11-08 10:18:58.515+00	\N	\N	2021-11-08 10:19:56.86+00	2021-11-08 10:19:57.013+00
2979	\N	died	2021-11-08 10:18:40.972+00	\N	\N	2021-11-08 10:19:30.41+00	2021-11-08 10:19:30.635+00
2987	\N	died	2021-11-08 10:18:40.991+00	\N	\N	2021-11-08 10:19:30.545+00	2021-11-08 10:19:31.127+00
3010	\N	died	2021-11-08 10:18:41.06+00	\N	\N	2021-11-08 10:19:31.053+00	2021-11-08 10:19:31.176+00
4142	\N	died	2021-11-08 10:18:58.806+00	\N	\N	2021-11-08 10:19:57.009+00	2021-11-08 10:19:57.106+00
3017	\N	died	2021-11-08 10:18:41.089+00	\N	\N	2021-11-08 10:19:31.173+00	2021-11-08 10:19:31.296+00
3021	\N	died	2021-11-08 10:18:41.104+00	\N	\N	2021-11-08 10:19:31.292+00	2021-11-08 10:19:31.39+00
4325	\N	died	2021-11-08 10:19:04.632+00	\N	\N	2021-11-08 10:20:01.143+00	2021-11-08 10:20:01.349+00
3025	\N	died	2021-11-08 10:18:41.111+00	\N	\N	2021-11-08 10:19:31.353+00	2021-11-08 10:19:31.798+00
3039	\N	died	2021-11-08 10:18:41.145+00	\N	\N	2021-11-08 10:19:31.66+00	2021-11-08 10:19:31.851+00
3047	\N	died	2021-11-08 10:18:41.177+00	\N	\N	2021-11-08 10:19:31.848+00	2021-11-08 10:19:32.015+00
4147	\N	died	2021-11-08 10:18:59.031+00	\N	\N	2021-11-08 10:19:57.102+00	2021-11-08 10:19:57.296+00
4154	\N	died	2021-11-08 10:18:59.182+00	\N	\N	2021-11-08 10:19:57.21+00	2021-11-08 10:19:57.606+00
4165	\N	died	2021-11-08 10:18:59.456+00	\N	\N	2021-11-08 10:19:57.535+00	2021-11-08 10:19:57.721+00
4320	\N	died	2021-11-08 10:19:04.299+00	\N	\N	2021-11-08 10:20:01.06+00	2021-11-08 10:20:01.515+00
4176	\N	died	2021-11-08 10:18:59.707+00	\N	\N	2021-11-08 10:19:57.717+00	2021-11-08 10:19:57.856+00
4179	\N	died	2021-11-08 10:18:59.749+00	\N	\N	2021-11-08 10:19:57.768+00	2021-11-08 10:19:58.056+00
4330	\N	died	2021-11-08 10:19:05.04+00	\N	\N	2021-11-08 10:20:01.277+00	2021-11-08 10:20:01.55+00
4187	\N	died	2021-11-08 10:19:00.097+00	\N	\N	2021-11-08 10:19:58.018+00	2021-11-08 10:19:58.381+00
4203	\N	died	2021-11-08 10:19:00.85+00	\N	\N	2021-11-08 10:19:58.375+00	2021-11-08 10:19:58.663+00
4341	\N	died	2021-11-08 10:19:05.748+00	\N	\N	2021-11-08 10:20:01.512+00	2021-11-08 10:20:01.631+00
4213	\N	died	2021-11-08 10:19:01.102+00	\N	\N	2021-11-08 10:19:58.599+00	2021-11-08 10:19:59.171+00
5754	\N	died	2021-11-08 10:19:52.774+00	\N	\N	2021-11-08 10:20:43.264+00	2021-11-08 10:20:43.315+00
4233	\N	died	2021-11-08 10:19:01.709+00	\N	\N	2021-11-08 10:19:59.11+00	2021-11-08 10:19:59.513+00
4249	\N	died	2021-11-08 10:19:01.765+00	\N	\N	2021-11-08 10:19:59.393+00	2021-11-08 10:19:59.732+00
4263	\N	died	2021-11-08 10:19:01.973+00	\N	\N	2021-11-08 10:19:59.727+00	2021-11-08 10:19:59.971+00
4384	\N	died	2021-11-08 10:19:07.118+00	\N	\N	2021-11-08 10:20:02.71+00	2021-11-08 10:20:03.082+00
4272	\N	died	2021-11-08 10:19:02.239+00	\N	\N	2021-11-08 10:19:59.877+00	2021-11-08 10:20:00.471+00
4385	\N	died	2021-11-08 10:19:07.125+00	\N	\N	2021-11-08 10:20:02.774+00	2021-11-08 10:20:03.082+00
5815	\N	died	2021-11-08 10:19:54.642+00	\N	\N	2021-11-08 10:20:44.825+00	2021-11-08 10:20:45.549+00
4342	\N	died	2021-11-08 10:19:05.782+00	\N	\N	2021-11-08 10:20:01.527+00	2021-11-08 10:20:01.812+00
4346	\N	died	2021-11-08 10:19:06.059+00	\N	\N	2021-11-08 10:20:01.596+00	2021-11-08 10:20:01.848+00
4350	\N	died	2021-11-08 10:19:06.209+00	\N	\N	2021-11-08 10:20:01.711+00	2021-11-08 10:20:01.989+00
5756	\N	died	2021-11-08 10:19:52.795+00	\N	\N	2021-11-08 10:20:43.3+00	2021-11-08 10:20:43.477+00
5879	\N	died	2021-11-08 10:19:56.909+00	\N	\N	2021-11-08 10:20:47.285+00	2021-11-08 10:20:47.459+00
4357	\N	died	2021-11-08 10:19:06.641+00	\N	\N	2021-11-08 10:20:01.827+00	2021-11-08 10:20:02.323+00
4361	\N	died	2021-11-08 10:19:06.857+00	\N	\N	2021-11-08 10:20:01.985+00	2021-11-08 10:20:02.385+00
5761	\N	died	2021-11-08 10:19:52.924+00	\N	\N	2021-11-08 10:20:43.473+00	2021-11-08 10:20:43.777+00
4364	\N	died	2021-11-08 10:19:07.007+00	\N	\N	2021-11-08 10:20:02.319+00	2021-11-08 10:20:02.578+00
4367	\N	died	2021-11-08 10:19:07.075+00	\N	\N	2021-11-08 10:20:02.378+00	2021-11-08 10:20:02.599+00
5771	\N	died	2021-11-08 10:19:53.148+00	\N	\N	2021-11-08 10:20:43.723+00	2021-11-08 10:20:44.054+00
4396	\N	died	2021-11-08 10:19:07.15+00	\N	\N	2021-11-08 10:20:03.008+00	2021-11-08 10:20:03.331+00
5832	\N	died	2021-11-08 10:19:55.233+00	\N	\N	2021-11-08 10:20:45.442+00	2021-11-08 10:20:45.834+00
5785	\N	died	2021-11-08 10:19:53.465+00	\N	\N	2021-11-08 10:20:44.048+00	2021-11-08 10:20:44.305+00
4398	\N	died	2021-11-08 10:19:07.155+00	\N	\N	2021-11-08 10:20:03.043+00	2021-11-08 10:20:03.512+00
4412	\N	died	2021-11-08 10:19:07.187+00	\N	\N	2021-11-08 10:20:03.325+00	2021-11-08 10:20:03.512+00
5852	\N	died	2021-11-08 10:19:55.992+00	\N	\N	2021-11-08 10:20:46.162+00	2021-11-08 10:20:47.093+00
4420	\N	died	2021-11-08 10:19:07.204+00	\N	\N	2021-11-08 10:20:03.509+00	2021-11-08 10:20:03.546+00
4422	\N	died	2021-11-08 10:19:07.207+00	\N	\N	2021-11-08 10:20:03.542+00	2021-11-08 10:20:03.58+00
5792	\N	died	2021-11-08 10:19:53.757+00	\N	\N	2021-11-08 10:20:44.214+00	2021-11-08 10:20:44.577+00
4424	\N	died	2021-11-08 10:19:07.212+00	\N	\N	2021-11-08 10:20:03.576+00	2021-11-08 10:20:03.635+00
5807	\N	died	2021-11-08 10:19:54.383+00	\N	\N	2021-11-08 10:20:44.573+00	2021-11-08 10:20:44.965+00
5882	\N	died	2021-11-08 10:19:56.974+00	\N	\N	2021-11-08 10:20:47.391+00	2021-11-08 10:20:47.763+00
5842	\N	died	2021-11-08 10:19:55.725+00	\N	\N	2021-11-08 10:20:45.767+00	2021-11-08 10:20:46.325+00
5868	\N	died	2021-11-08 10:19:56.608+00	\N	\N	2021-11-08 10:20:46.669+00	2021-11-08 10:20:47.302+00
5917	\N	died	2021-11-08 10:19:58.134+00	\N	\N	2021-11-08 10:20:48.333+00	2021-11-08 10:20:48.636+00
5893	\N	died	2021-11-08 10:19:57.331+00	\N	\N	2021-11-08 10:20:47.741+00	2021-11-08 10:20:48.355+00
5929	\N	died	2021-11-08 10:19:58.443+00	\N	\N	2021-11-08 10:20:48.632+00	2021-11-08 10:20:48.774+00
5934	\N	died	2021-11-08 10:19:58.692+00	\N	\N	2021-11-08 10:20:48.76+00	2021-11-08 10:20:48.811+00
5936	\N	died	2021-11-08 10:19:58.784+00	\N	\N	2021-11-08 10:20:48.807+00	2021-11-08 10:20:48.878+00
5940	\N	died	2021-11-08 10:19:58.934+00	\N	\N	2021-11-08 10:20:48.874+00	2021-11-08 10:20:49.052+00
2755	\N	died	2021-11-08 10:18:40.354+00	\N	\N	2021-11-08 10:19:25.594+00	2021-11-08 10:19:25.809+00
4318	\N	died	2021-11-08 10:19:04.225+00	\N	\N	2021-11-08 10:20:01.026+00	2021-11-08 10:20:01.499+00
2764	\N	died	2021-11-08 10:18:40.387+00	\N	\N	2021-11-08 10:19:25.805+00	2021-11-08 10:19:25.847+00
3051	\N	died	2021-11-08 10:18:41.184+00	\N	\N	2021-11-08 10:19:31.911+00	2021-11-08 10:19:32.334+00
2766	\N	died	2021-11-08 10:18:40.396+00	\N	\N	2021-11-08 10:19:25.839+00	2021-11-08 10:19:25.94+00
4085	\N	died	2021-11-08 10:18:57.881+00	\N	\N	2021-11-08 10:19:55.975+00	2021-11-08 10:19:56.014+00
2771	\N	died	2021-11-08 10:18:40.417+00	\N	\N	2021-11-08 10:19:25.927+00	2021-11-08 10:19:26.313+00
2787	\N	died	2021-11-08 10:18:40.469+00	\N	\N	2021-11-08 10:19:26.285+00	2021-11-08 10:19:26.606+00
2798	\N	died	2021-11-08 10:18:40.497+00	\N	\N	2021-11-08 10:19:26.518+00	2021-11-08 10:19:26.663+00
4087	\N	died	2021-11-08 10:18:57.918+00	\N	\N	2021-11-08 10:19:56.011+00	2021-11-08 10:19:56.221+00
2806	\N	died	2021-11-08 10:18:40.525+00	\N	\N	2021-11-08 10:19:26.659+00	2021-11-08 10:19:26.789+00
2811	\N	died	2021-11-08 10:18:40.536+00	\N	\N	2021-11-08 10:19:26.784+00	2021-11-08 10:19:27.017+00
2819	\N	died	2021-11-08 10:18:40.555+00	\N	\N	2021-11-08 10:19:26.961+00	2021-11-08 10:19:27.439+00
4094	\N	died	2021-11-08 10:18:58.073+00	\N	\N	2021-11-08 10:19:56.184+00	2021-11-08 10:19:56.612+00
2835	\N	died	2021-11-08 10:18:40.595+00	\N	\N	2021-11-08 10:19:27.269+00	2021-11-08 10:19:27.633+00
2848	\N	died	2021-11-08 10:18:40.636+00	\N	\N	2021-11-08 10:19:27.534+00	2021-11-08 10:19:27.789+00
2859	\N	died	2021-11-08 10:18:40.658+00	\N	\N	2021-11-08 10:19:27.752+00	2021-11-08 10:19:28.141+00
4117	\N	died	2021-11-08 10:18:58.2+00	\N	\N	2021-11-08 10:19:56.59+00	2021-11-08 10:19:56.993+00
2875	\N	died	2021-11-08 10:18:40.701+00	\N	\N	2021-11-08 10:19:28.119+00	2021-11-08 10:19:28.436+00
4337	\N	died	2021-11-08 10:19:05.432+00	\N	\N	2021-11-08 10:20:01.394+00	2021-11-08 10:20:01.631+00
2890	\N	died	2021-11-08 10:18:40.732+00	\N	\N	2021-11-08 10:19:28.41+00	2021-11-08 10:19:28.54+00
2894	\N	died	2021-11-08 10:18:40.749+00	\N	\N	2021-11-08 10:19:28.473+00	2021-11-08 10:19:28.799+00
4138	\N	died	2021-11-08 10:18:58.632+00	\N	\N	2021-11-08 10:19:56.942+00	2021-11-08 10:19:57.188+00
2905	\N	died	2021-11-08 10:18:40.78+00	\N	\N	2021-11-08 10:19:28.76+00	2021-11-08 10:19:29.081+00
2918	\N	died	2021-11-08 10:18:40.816+00	\N	\N	2021-11-08 10:19:29.026+00	2021-11-08 10:19:29.582+00
2939	\N	died	2021-11-08 10:18:40.871+00	\N	\N	2021-11-08 10:19:29.494+00	2021-11-08 10:19:29.758+00
4151	\N	died	2021-11-08 10:18:59.143+00	\N	\N	2021-11-08 10:19:57.166+00	2021-11-08 10:19:57.702+00
2951	\N	died	2021-11-08 10:18:40.901+00	\N	\N	2021-11-08 10:19:29.736+00	2021-11-08 10:19:30.094+00
2965	\N	died	2021-11-08 10:18:40.939+00	\N	\N	2021-11-08 10:19:30.06+00	2021-11-08 10:19:30.314+00
2974	\N	died	2021-11-08 10:18:40.961+00	\N	\N	2021-11-08 10:19:30.264+00	2021-11-08 10:19:30.465+00
4170	\N	died	2021-11-08 10:18:59.54+00	\N	\N	2021-11-08 10:19:57.617+00	2021-11-08 10:19:57.757+00
2982	\N	died	2021-11-08 10:18:40.976+00	\N	\N	2021-11-08 10:19:30.46+00	2021-11-08 10:19:30.69+00
4356	\N	died	2021-11-08 10:19:06.626+00	\N	\N	2021-11-08 10:20:01.808+00	2021-11-08 10:20:01.848+00
2992	\N	died	2021-11-08 10:18:41.012+00	\N	\N	2021-11-08 10:19:30.669+00	2021-11-08 10:19:31.127+00
3008	\N	died	2021-11-08 10:18:41.06+00	\N	\N	2021-11-08 10:19:30.973+00	2021-11-08 10:19:31.411+00
4414	\N	died	2021-11-08 10:19:07.193+00	\N	\N	2021-11-08 10:20:03.361+00	2021-11-08 10:20:03.645+00
3028	\N	died	2021-11-08 10:18:41.125+00	\N	\N	2021-11-08 10:19:31.407+00	2021-11-08 10:19:31.636+00
3035	\N	died	2021-11-08 10:18:41.139+00	\N	\N	2021-11-08 10:19:31.596+00	2021-11-08 10:19:32.015+00
4178	\N	died	2021-11-08 10:18:59.737+00	\N	\N	2021-11-08 10:19:57.754+00	2021-11-08 10:19:57.931+00
4344	\N	died	2021-11-08 10:19:05.891+00	\N	\N	2021-11-08 10:20:01.561+00	2021-11-08 10:20:01.865+00
4183	\N	died	2021-11-08 10:18:59.914+00	\N	\N	2021-11-08 10:19:57.926+00	2021-11-08 10:19:58.18+00
4191	\N	died	2021-11-08 10:19:00.332+00	\N	\N	2021-11-08 10:19:58.135+00	2021-11-08 10:19:58.415+00
4205	\N	died	2021-11-08 10:19:00.982+00	\N	\N	2021-11-08 10:19:58.41+00	2021-11-08 10:19:58.697+00
4358	\N	died	2021-11-08 10:19:06.757+00	\N	\N	2021-11-08 10:20:01.845+00	2021-11-08 10:20:01.93+00
4215	\N	died	2021-11-08 10:19:01.183+00	\N	\N	2021-11-08 10:19:58.675+00	2021-11-08 10:19:58.79+00
4219	\N	died	2021-11-08 10:19:01.282+00	\N	\N	2021-11-08 10:19:58.785+00	2021-11-08 10:19:58.953+00
4427	\N	died	2021-11-08 10:19:07.218+00	\N	\N	2021-11-08 10:20:03.63+00	2021-11-08 10:20:03.749+00
4224	\N	died	2021-11-08 10:19:01.45+00	\N	\N	2021-11-08 10:19:58.918+00	2021-11-08 10:19:59.187+00
4236	\N	died	2021-11-08 10:19:01.726+00	\N	\N	2021-11-08 10:19:59.184+00	2021-11-08 10:19:59.262+00
4359	\N	died	2021-11-08 10:19:06.79+00	\N	\N	2021-11-08 10:20:01.861+00	2021-11-08 10:20:02.028+00
4239	\N	died	2021-11-08 10:19:01.736+00	\N	\N	2021-11-08 10:19:59.225+00	2021-11-08 10:19:59.513+00
5845	\N	died	2021-11-08 10:19:55.774+00	\N	\N	2021-11-08 10:20:45.883+00	2021-11-08 10:20:46.325+00
4248	\N	died	2021-11-08 10:19:01.762+00	\N	\N	2021-11-08 10:19:59.377+00	2021-11-08 10:19:59.614+00
4259	\N	died	2021-11-08 10:19:01.915+00	\N	\N	2021-11-08 10:19:59.61+00	2021-11-08 10:19:59.815+00
4360	\N	died	2021-11-08 10:19:06.824+00	\N	\N	2021-11-08 10:20:01.927+00	2021-11-08 10:20:02.349+00
4266	\N	died	2021-11-08 10:19:02.154+00	\N	\N	2021-11-08 10:19:59.777+00	2021-11-08 10:20:00.056+00
4279	\N	died	2021-11-08 10:19:02.441+00	\N	\N	2021-11-08 10:20:00.052+00	2021-11-08 10:20:00.188+00
4282	\N	died	2021-11-08 10:19:02.507+00	\N	\N	2021-11-08 10:20:00.103+00	2021-11-08 10:20:00.288+00
4362	\N	died	2021-11-08 10:19:06.891+00	\N	\N	2021-11-08 10:20:02.024+00	2021-11-08 10:20:02.414+00
4290	\N	died	2021-11-08 10:19:02.774+00	\N	\N	2021-11-08 10:20:00.285+00	2021-11-08 10:20:00.49+00
4299	\N	died	2021-11-08 10:19:03.109+00	\N	\N	2021-11-08 10:20:00.485+00	2021-11-08 10:20:00.538+00
4302	\N	died	2021-11-08 10:19:03.199+00	\N	\N	2021-11-08 10:20:00.535+00	2021-11-08 10:20:00.817+00
4307	\N	died	2021-11-08 10:19:03.457+00	\N	\N	2021-11-08 10:20:00.777+00	2021-11-08 10:20:01.08+00
5763	\N	died	2021-11-08 10:19:52.957+00	\N	\N	2021-11-08 10:20:43.528+00	2021-11-08 10:20:43.777+00
4365	\N	died	2021-11-08 10:19:07.024+00	\N	\N	2021-11-08 10:20:02.344+00	2021-11-08 10:20:02.578+00
4369	\N	died	2021-11-08 10:19:07.081+00	\N	\N	2021-11-08 10:20:02.411+00	2021-11-08 10:20:02.662+00
4379	\N	died	2021-11-08 10:19:07.108+00	\N	\N	2021-11-08 10:20:02.624+00	2021-11-08 10:20:02.914+00
4375	\N	died	2021-11-08 10:19:07.097+00	\N	\N	2021-11-08 10:20:02.56+00	2021-11-08 10:20:03.082+00
4390	\N	died	2021-11-08 10:19:07.136+00	\N	\N	2021-11-08 10:20:02.862+00	2021-11-08 10:20:03.095+00
5773	\N	died	2021-11-08 10:19:53.182+00	\N	\N	2021-11-08 10:20:43.756+00	2021-11-08 10:20:44.305+00
4401	\N	died	2021-11-08 10:19:07.16+00	\N	\N	2021-11-08 10:20:03.091+00	2021-11-08 10:20:03.134+00
4403	\N	died	2021-11-08 10:19:07.168+00	\N	\N	2021-11-08 10:20:03.125+00	2021-11-08 10:20:03.246+00
4407	\N	died	2021-11-08 10:19:07.178+00	\N	\N	2021-11-08 10:20:03.242+00	2021-11-08 10:20:03.315+00
5789	\N	died	2021-11-08 10:19:53.531+00	\N	\N	2021-11-08 10:20:44.118+00	2021-11-08 10:20:44.493+00
5850	\N	died	2021-11-08 10:19:55.958+00	\N	\N	2021-11-08 10:20:46.049+00	2021-11-08 10:20:46.519+00
4397	\N	died	2021-11-08 10:19:07.155+00	\N	\N	2021-11-08 10:20:03.027+00	2021-11-08 10:20:03.512+00
4411	\N	died	2021-11-08 10:19:07.187+00	\N	\N	2021-11-08 10:20:03.311+00	2021-11-08 10:20:03.512+00
4428	\N	died	2021-11-08 10:19:07.219+00	\N	\N	2021-11-08 10:20:03.641+00	2021-11-08 10:20:03.987+00
4417	\N	died	2021-11-08 10:19:07.197+00	\N	\N	2021-11-08 10:20:03.408+00	2021-11-08 10:20:03.987+00
4431	\N	died	2021-11-08 10:19:07.232+00	\N	\N	2021-11-08 10:20:03.744+00	2021-11-08 10:20:03.987+00
5800	\N	died	2021-11-08 10:19:54.124+00	\N	\N	2021-11-08 10:20:44.446+00	2021-11-08 10:20:44.595+00
4441	\N	died	2021-11-08 10:19:07.318+00	\N	\N	2021-11-08 10:20:03.984+00	2021-11-08 10:20:04.024+00
5910	\N	died	2021-11-08 10:19:57.926+00	\N	\N	2021-11-08 10:20:48.14+00	2021-11-08 10:20:48.603+00
4433	\N	died	2021-11-08 10:19:07.234+00	\N	\N	2021-11-08 10:20:03.776+00	2021-11-08 10:20:04.037+00
5808	\N	died	2021-11-08 10:19:54.417+00	\N	\N	2021-11-08 10:20:44.591+00	2021-11-08 10:20:44.965+00
4443	\N	died	2021-11-08 10:19:07.366+00	\N	\N	2021-11-08 10:20:04.019+00	2021-11-08 10:20:04.07+00
4434	\N	died	2021-11-08 10:19:07.238+00	\N	\N	2021-11-08 10:20:03.798+00	2021-11-08 10:20:04.07+00
5817	\N	died	2021-11-08 10:19:54.674+00	\N	\N	2021-11-08 10:20:44.882+00	2021-11-08 10:20:45.673+00
4444	\N	died	2021-11-08 10:19:07.367+00	\N	\N	2021-11-08 10:20:04.033+00	2021-11-08 10:20:04.172+00
4446	\N	died	2021-11-08 10:19:07.383+00	\N	\N	2021-11-08 10:20:04.066+00	2021-11-08 10:20:04.172+00
5836	\N	died	2021-11-08 10:19:55.325+00	\N	\N	2021-11-08 10:20:45.557+00	2021-11-08 10:20:45.898+00
5895	\N	died	2021-11-08 10:19:57.434+00	\N	\N	2021-11-08 10:20:47.773+00	2021-11-08 10:20:48.169+00
5862	\N	died	2021-11-08 10:19:56.274+00	\N	\N	2021-11-08 10:20:46.499+00	2021-11-08 10:20:47.093+00
5871	\N	died	2021-11-08 10:19:56.677+00	\N	\N	2021-11-08 10:20:46.825+00	2021-11-08 10:20:47.556+00
5889	\N	died	2021-11-08 10:19:57.134+00	\N	\N	2021-11-08 10:20:47.548+00	2021-11-08 10:20:47.846+00
5927	\N	died	2021-11-08 10:19:58.392+00	\N	\N	2021-11-08 10:20:48.598+00	2021-11-08 10:20:48.774+00
5933	\N	died	2021-11-08 10:19:58.658+00	\N	\N	2021-11-08 10:20:48.692+00	2021-11-08 10:20:49.134+00
5950	\N	died	2021-11-08 10:19:59.343+00	\N	\N	2021-11-08 10:20:49.124+00	2021-11-08 10:20:49.31+00
5956	\N	died	2021-11-08 10:19:59.542+00	\N	\N	2021-11-08 10:20:49.293+00	2021-11-08 10:20:49.395+00
5960	\N	died	2021-11-08 10:19:59.626+00	\N	\N	2021-11-08 10:20:49.39+00	2021-11-08 10:20:49.488+00
2809	\N	died	2021-11-08 10:18:40.536+00	\N	\N	2021-11-08 10:19:26.756+00	2021-11-08 10:19:26.824+00
5757	\N	died	2021-11-08 10:19:52.807+00	\N	\N	2021-11-08 10:20:43.392+00	2021-11-08 10:20:43.561+00
2813	\N	died	2021-11-08 10:18:40.543+00	\N	\N	2021-11-08 10:19:26.819+00	2021-11-08 10:19:27.017+00
2822	\N	died	2021-11-08 10:18:40.568+00	\N	\N	2021-11-08 10:19:27.013+00	2021-11-08 10:19:27.046+00
5765	\N	died	2021-11-08 10:19:52.973+00	\N	\N	2021-11-08 10:20:43.558+00	2021-11-08 10:20:43.793+00
2824	\N	died	2021-11-08 10:18:40.568+00	\N	\N	2021-11-08 10:19:27.043+00	2021-11-08 10:19:27.118+00
2828	\N	died	2021-11-08 10:18:40.582+00	\N	\N	2021-11-08 10:19:27.114+00	2021-11-08 10:19:27.439+00
2836	\N	died	2021-11-08 10:18:40.595+00	\N	\N	2021-11-08 10:19:27.284+00	2021-11-08 10:19:27.633+00
5775	\N	died	2021-11-08 10:19:53.233+00	\N	\N	2021-11-08 10:20:43.789+00	2021-11-08 10:20:43.864+00
2850	\N	died	2021-11-08 10:18:40.637+00	\N	\N	2021-11-08 10:19:27.561+00	2021-11-08 10:19:27.939+00
2863	\N	died	2021-11-08 10:18:40.672+00	\N	\N	2021-11-08 10:19:27.872+00	2021-11-08 10:19:28.191+00
2879	\N	died	2021-11-08 10:18:40.709+00	\N	\N	2021-11-08 10:19:28.186+00	2021-11-08 10:19:28.398+00
5778	\N	died	2021-11-08 10:19:53.282+00	\N	\N	2021-11-08 10:20:43.847+00	2021-11-08 10:20:44.037+00
2887	\N	died	2021-11-08 10:18:40.726+00	\N	\N	2021-11-08 10:19:28.359+00	2021-11-08 10:19:28.799+00
2906	\N	died	2021-11-08 10:18:40.78+00	\N	\N	2021-11-08 10:19:28.776+00	2021-11-08 10:19:29.081+00
2919	\N	died	2021-11-08 10:18:40.816+00	\N	\N	2021-11-08 10:19:29.044+00	2021-11-08 10:19:29.582+00
5782	\N	died	2021-11-08 10:19:53.399+00	\N	\N	2021-11-08 10:20:43.999+00	2021-11-08 10:20:44.305+00
2941	\N	died	2021-11-08 10:18:40.879+00	\N	\N	2021-11-08 10:19:29.523+00	2021-11-08 10:19:30.055+00
2959	\N	died	2021-11-08 10:18:40.927+00	\N	\N	2021-11-08 10:19:29.868+00	2021-11-08 10:19:30.248+00
2972	\N	died	2021-11-08 10:18:40.956+00	\N	\N	2021-11-08 10:19:30.229+00	2021-11-08 10:19:30.635+00
5795	\N	died	2021-11-08 10:19:53.934+00	\N	\N	2021-11-08 10:20:44.281+00	2021-11-08 10:20:44.965+00
2985	\N	died	2021-11-08 10:18:40.991+00	\N	\N	2021-11-08 10:19:30.514+00	2021-11-08 10:19:30.882+00
3001	\N	died	2021-11-08 10:18:41.038+00	\N	\N	2021-11-08 10:19:30.864+00	2021-11-08 10:19:31.127+00
3011	\N	died	2021-11-08 10:18:41.066+00	\N	\N	2021-11-08 10:19:31.073+00	2021-11-08 10:19:31.296+00
5816	\N	died	2021-11-08 10:19:54.657+00	\N	\N	2021-11-08 10:20:44.849+00	2021-11-08 10:20:45.549+00
3020	\N	died	2021-11-08 10:18:41.095+00	\N	\N	2021-11-08 10:19:31.22+00	2021-11-08 10:19:31.464+00
3029	\N	died	2021-11-08 10:18:41.125+00	\N	\N	2021-11-08 10:19:31.419+00	2021-11-08 10:19:31.649+00
3038	\N	died	2021-11-08 10:18:41.145+00	\N	\N	2021-11-08 10:19:31.644+00	2021-11-08 10:19:31.831+00
5834	\N	died	2021-11-08 10:19:55.269+00	\N	\N	2021-11-08 10:20:45.515+00	2021-11-08 10:20:46.325+00
3045	\N	died	2021-11-08 10:18:41.169+00	\N	\N	2021-11-08 10:19:31.81+00	2021-11-08 10:19:32.015+00
3050	\N	died	2021-11-08 10:18:41.184+00	\N	\N	2021-11-08 10:19:31.901+00	2021-11-08 10:19:32.334+00
5854	\N	died	2021-11-08 10:19:56.043+00	\N	\N	2021-11-08 10:20:46.229+00	2021-11-08 10:20:47.093+00
5872	\N	died	2021-11-08 10:19:56.709+00	\N	\N	2021-11-08 10:20:46.865+00	2021-11-08 10:20:47.73+00
5891	\N	died	2021-11-08 10:19:57.209+00	\N	\N	2021-11-08 10:20:47.709+00	2021-11-08 10:20:48.369+00
5919	\N	died	2021-11-08 10:19:58.175+00	\N	\N	2021-11-08 10:20:48.365+00	2021-11-08 10:20:48.636+00
5928	\N	died	2021-11-08 10:19:58.409+00	\N	\N	2021-11-08 10:20:48.615+00	2021-11-08 10:20:48.828+00
5937	\N	died	2021-11-08 10:19:58.859+00	\N	\N	2021-11-08 10:20:48.823+00	2021-11-08 10:20:49.052+00
5943	\N	died	2021-11-08 10:19:59.001+00	\N	\N	2021-11-08 10:20:48.926+00	2021-11-08 10:20:49.31+00
5955	\N	died	2021-11-08 10:19:59.509+00	\N	\N	2021-11-08 10:20:49.223+00	2021-11-08 10:20:49.488+00
5962	\N	died	2021-11-08 10:19:59.709+00	\N	\N	2021-11-08 10:20:49.423+00	2021-11-08 10:20:49.766+00
5974	\N	died	2021-11-08 10:19:59.984+00	\N	\N	2021-11-08 10:20:49.751+00	2021-11-08 10:20:49.912+00
5978	\N	died	2021-11-08 10:20:00.051+00	\N	\N	2021-11-08 10:20:49.893+00	2021-11-08 10:20:50.005+00
5982	\N	died	2021-11-08 10:20:00.117+00	\N	\N	2021-11-08 10:20:49.986+00	2021-11-08 10:20:50.246+00
5991	\N	died	2021-11-08 10:20:00.318+00	\N	\N	2021-11-08 10:20:50.24+00	2021-11-08 10:20:50.28+00
5993	\N	died	2021-11-08 10:20:00.417+00	\N	\N	2021-11-08 10:20:50.274+00	2021-11-08 10:20:50.366+00
5996	\N	died	2021-11-08 10:20:00.452+00	\N	\N	2021-11-08 10:20:50.351+00	2021-11-08 10:20:50.512+00
6000	\N	died	2021-11-08 10:20:00.517+00	\N	\N	2021-11-08 10:20:50.508+00	2021-11-08 10:20:50.625+00
6005	\N	died	2021-11-08 10:20:00.753+00	\N	\N	2021-11-08 10:20:50.616+00	2021-11-08 10:20:50.653+00
6007	\N	died	2021-11-08 10:20:00.776+00	\N	\N	2021-11-08 10:20:50.648+00	2021-11-08 10:20:50.841+00
6012	\N	died	2021-11-08 10:20:00.843+00	\N	\N	2021-11-08 10:20:50.826+00	2021-11-08 10:20:50.921+00
6017	\N	died	2021-11-08 10:20:00.926+00	\N	\N	2021-11-08 10:20:50.916+00	2021-11-08 10:20:51.119+00
6023	\N	died	2021-11-08 10:20:01.075+00	\N	\N	2021-11-08 10:20:51.109+00	2021-11-08 10:20:51.175+00
6025	\N	died	2021-11-08 10:20:01.094+00	\N	\N	2021-11-08 10:20:51.166+00	2021-11-08 10:20:51.249+00
6029	\N	died	2021-11-08 10:20:01.159+00	\N	\N	2021-11-08 10:20:51.241+00	2021-11-08 10:20:51.42+00
6033	\N	died	2021-11-08 10:20:01.262+00	\N	\N	2021-11-08 10:20:51.403+00	2021-11-08 10:20:51.503+00
2867	\N	died	2021-11-08 10:18:40.679+00	\N	\N	2021-11-08 10:19:27.936+00	2021-11-08 10:19:27.977+00
2869	\N	died	2021-11-08 10:18:40.693+00	\N	\N	2021-11-08 10:19:27.973+00	2021-11-08 10:19:28.024+00
3049	\N	died	2021-11-08 10:18:41.177+00	\N	\N	2021-11-08 10:19:31.879+00	2021-11-08 10:19:32.228+00
2872	\N	died	2021-11-08 10:18:40.693+00	\N	\N	2021-11-08 10:19:28.02+00	2021-11-08 10:19:28.141+00
4378	\N	died	2021-11-08 10:19:07.107+00	\N	\N	2021-11-08 10:20:02.607+00	2021-11-08 10:20:02.812+00
2876	\N	died	2021-11-08 10:18:40.701+00	\N	\N	2021-11-08 10:19:28.136+00	2021-11-08 10:19:28.398+00
3056	\N	died	2021-11-08 10:18:41.199+00	\N	\N	2021-11-08 10:19:32.048+00	2021-11-08 10:19:32.382+00
2882	\N	died	2021-11-08 10:18:40.718+00	\N	\N	2021-11-08 10:19:28.235+00	2021-11-08 10:19:28.799+00
2904	\N	died	2021-11-08 10:18:40.78+00	\N	\N	2021-11-08 10:19:28.694+00	2021-11-08 10:19:29.081+00
4106	\N	died	2021-11-08 10:18:58.168+00	\N	\N	2021-11-08 10:19:56.426+00	2021-11-08 10:19:56.489+00
2916	\N	died	2021-11-08 10:18:40.808+00	\N	\N	2021-11-08 10:19:28.998+00	2021-11-08 10:19:29.241+00
5764	\N	died	2021-11-08 10:19:52.959+00	\N	\N	2021-11-08 10:20:43.54+00	2021-11-08 10:20:43.777+00
2927	\N	died	2021-11-08 10:18:40.837+00	\N	\N	2021-11-08 10:19:29.236+00	2021-11-08 10:19:29.326+00
2930	\N	died	2021-11-08 10:18:40.851+00	\N	\N	2021-11-08 10:19:29.286+00	2021-11-08 10:19:29.582+00
4110	\N	died	2021-11-08 10:18:58.175+00	\N	\N	2021-11-08 10:19:56.483+00	2021-11-08 10:19:56.612+00
2944	\N	died	2021-11-08 10:18:40.887+00	\N	\N	2021-11-08 10:19:29.564+00	2021-11-08 10:19:30.055+00
2963	\N	died	2021-11-08 10:18:40.933+00	\N	\N	2021-11-08 10:19:30.027+00	2021-11-08 10:19:30.635+00
2986	\N	died	2021-11-08 10:18:40.991+00	\N	\N	2021-11-08 10:19:30.527+00	2021-11-08 10:19:30.956+00
4118	\N	died	2021-11-08 10:18:58.24+00	\N	\N	2021-11-08 10:19:56.609+00	2021-11-08 10:19:56.682+00
3005	\N	died	2021-11-08 10:18:41.053+00	\N	\N	2021-11-08 10:19:30.931+00	2021-11-08 10:19:31.156+00
3015	\N	died	2021-11-08 10:18:41.073+00	\N	\N	2021-11-08 10:19:31.135+00	2021-11-08 10:19:31.212+00
3019	\N	died	2021-11-08 10:18:41.095+00	\N	\N	2021-11-08 10:19:31.208+00	2021-11-08 10:19:31.39+00
4387	\N	died	2021-11-08 10:19:07.128+00	\N	\N	2021-11-08 10:20:02.807+00	2021-11-08 10:20:02.914+00
3023	\N	died	2021-11-08 10:18:41.111+00	\N	\N	2021-11-08 10:19:31.323+00	2021-11-08 10:19:31.636+00
3034	\N	died	2021-11-08 10:18:41.139+00	\N	\N	2021-11-08 10:19:31.58+00	2021-11-08 10:19:31.883+00
4383	\N	died	2021-11-08 10:19:07.118+00	\N	\N	2021-11-08 10:20:02.694+00	2021-11-08 10:20:03.082+00
4122	\N	died	2021-11-08 10:18:58.323+00	\N	\N	2021-11-08 10:19:56.678+00	2021-11-08 10:19:56.761+00
4125	\N	died	2021-11-08 10:18:58.35+00	\N	\N	2021-11-08 10:19:56.723+00	2021-11-08 10:19:56.993+00
4137	\N	died	2021-11-08 10:18:58.582+00	\N	\N	2021-11-08 10:19:56.923+00	2021-11-08 10:19:57.188+00
5774	\N	died	2021-11-08 10:19:53.199+00	\N	\N	2021-11-08 10:20:43.773+00	2021-11-08 10:20:43.81+00
4149	\N	died	2021-11-08 10:18:59.14+00	\N	\N	2021-11-08 10:19:57.135+00	2021-11-08 10:19:57.504+00
4163	\N	died	2021-11-08 10:18:59.439+00	\N	\N	2021-11-08 10:19:57.501+00	2021-11-08 10:19:57.702+00
4394	\N	died	2021-11-08 10:19:07.148+00	\N	\N	2021-11-08 10:20:02.928+00	2021-11-08 10:20:03.146+00
4173	\N	died	2021-11-08 10:18:59.665+00	\N	\N	2021-11-08 10:19:57.667+00	2021-11-08 10:19:58.18+00
5877	\N	died	2021-11-08 10:19:56.859+00	\N	\N	2021-11-08 10:20:47.163+00	2021-11-08 10:20:47.539+00
4190	\N	died	2021-11-08 10:19:00.298+00	\N	\N	2021-11-08 10:19:58.069+00	2021-11-08 10:19:58.281+00
4391	\N	died	2021-11-08 10:19:07.138+00	\N	\N	2021-11-08 10:20:02.874+00	2021-11-08 10:20:03.246+00
4199	\N	died	2021-11-08 10:19:00.714+00	\N	\N	2021-11-08 10:19:58.263+00	2021-11-08 10:19:58.663+00
4212	\N	died	2021-11-08 10:19:01.098+00	\N	\N	2021-11-08 10:19:58.526+00	2021-11-08 10:19:59.171+00
4404	\N	died	2021-11-08 10:19:07.171+00	\N	\N	2021-11-08 10:20:03.141+00	2021-11-08 10:20:03.315+00
4231	\N	died	2021-11-08 10:19:01.69+00	\N	\N	2021-11-08 10:19:59.077+00	2021-11-08 10:19:59.348+00
4243	\N	died	2021-11-08 10:19:01.747+00	\N	\N	2021-11-08 10:19:59.292+00	2021-11-08 10:19:59.528+00
4254	\N	died	2021-11-08 10:19:01.812+00	\N	\N	2021-11-08 10:19:59.524+00	2021-11-08 10:19:59.599+00
5776	\N	died	2021-11-08 10:19:53.249+00	\N	\N	2021-11-08 10:20:43.806+00	2021-11-08 10:20:44.037+00
4257	\N	died	2021-11-08 10:19:01.829+00	\N	\N	2021-11-08 10:19:59.574+00	2021-11-08 10:19:59.815+00
4406	\N	died	2021-11-08 10:19:07.175+00	\N	\N	2021-11-08 10:20:03.174+00	2021-11-08 10:20:03.512+00
4264	\N	died	2021-11-08 10:19:02.015+00	\N	\N	2021-11-08 10:19:59.745+00	2021-11-08 10:20:00.038+00
4275	\N	died	2021-11-08 10:19:02.373+00	\N	\N	2021-11-08 10:19:59.985+00	2021-11-08 10:20:00.205+00
5942	\N	died	2021-11-08 10:19:58.984+00	\N	\N	2021-11-08 10:20:48.907+00	2021-11-08 10:20:49.412+00
4285	\N	died	2021-11-08 10:19:02.656+00	\N	\N	2021-11-08 10:20:00.202+00	2021-11-08 10:20:00.471+00
4409	\N	died	2021-11-08 10:19:07.181+00	\N	\N	2021-11-08 10:20:03.274+00	2021-11-08 10:20:03.546+00
4292	\N	died	2021-11-08 10:19:02.876+00	\N	\N	2021-11-08 10:20:00.318+00	2021-11-08 10:20:00.817+00
4308	\N	died	2021-11-08 10:19:03.54+00	\N	\N	2021-11-08 10:20:00.794+00	2021-11-08 10:20:01.08+00
4413	\N	died	2021-11-08 10:19:07.189+00	\N	\N	2021-11-08 10:20:03.342+00	2021-11-08 10:20:03.58+00
4319	\N	died	2021-11-08 10:19:04.266+00	\N	\N	2021-11-08 10:20:01.046+00	2021-11-08 10:20:01.499+00
4339	\N	died	2021-11-08 10:19:05.582+00	\N	\N	2021-11-08 10:20:01.477+00	2021-11-08 10:20:01.812+00
5780	\N	died	2021-11-08 10:19:53.315+00	\N	\N	2021-11-08 10:20:43.966+00	2021-11-08 10:20:44.305+00
4353	\N	died	2021-11-08 10:19:06.574+00	\N	\N	2021-11-08 10:20:01.762+00	2021-11-08 10:20:02.397+00
4354	\N	died	2021-11-08 10:19:06.608+00	\N	\N	2021-11-08 10:20:01.777+00	2021-11-08 10:20:02.578+00
4368	\N	died	2021-11-08 10:19:07.077+00	\N	\N	2021-11-08 10:20:02.392+00	2021-11-08 10:20:02.662+00
5790	\N	died	2021-11-08 10:19:53.706+00	\N	\N	2021-11-08 10:20:44.193+00	2021-11-08 10:20:44.493+00
4372	\N	died	2021-11-08 10:19:07.088+00	\N	\N	2021-11-08 10:20:02.461+00	2021-11-08 10:20:02.797+00
4421	\N	died	2021-11-08 10:19:07.207+00	\N	\N	2021-11-08 10:20:03.525+00	2021-11-08 10:20:03.635+00
5885	\N	died	2021-11-08 10:19:57.042+00	\N	\N	2021-11-08 10:20:47.47+00	2021-11-08 10:20:47.846+00
4423	\N	died	2021-11-08 10:19:07.212+00	\N	\N	2021-11-08 10:20:03.561+00	2021-11-08 10:20:03.664+00
5801	\N	died	2021-11-08 10:19:54.159+00	\N	\N	2021-11-08 10:20:44.473+00	2021-11-08 10:20:44.965+00
4416	\N	died	2021-11-08 10:19:07.197+00	\N	\N	2021-11-08 10:20:03.393+00	2021-11-08 10:20:03.763+00
4429	\N	died	2021-11-08 10:19:07.225+00	\N	\N	2021-11-08 10:20:03.66+00	2021-11-08 10:20:03.987+00
4426	\N	died	2021-11-08 10:19:07.215+00	\N	\N	2021-11-08 10:20:03.61+00	2021-11-08 10:20:03.987+00
4432	\N	died	2021-11-08 10:19:07.233+00	\N	\N	2021-11-08 10:20:03.758+00	2021-11-08 10:20:04.024+00
5811	\N	died	2021-11-08 10:19:54.533+00	\N	\N	2021-11-08 10:20:44.693+00	2021-11-08 10:20:45.115+00
4442	\N	died	2021-11-08 10:19:07.35+00	\N	\N	2021-11-08 10:20:04.002+00	2021-11-08 10:20:04.172+00
4435	\N	died	2021-11-08 10:19:07.239+00	\N	\N	2021-11-08 10:20:03.833+00	2021-11-08 10:20:04.193+00
5822	\N	died	2021-11-08 10:19:54.866+00	\N	\N	2021-11-08 10:20:45.1+00	2021-11-08 10:20:45.299+00
4450	\N	died	2021-11-08 10:19:07.416+00	\N	\N	2021-11-08 10:20:04.189+00	2021-11-08 10:20:04.281+00
5897	\N	died	2021-11-08 10:19:57.5+00	\N	\N	2021-11-08 10:20:47.807+00	2021-11-08 10:20:48.306+00
5826	\N	died	2021-11-08 10:19:55.016+00	\N	\N	2021-11-08 10:20:45.229+00	2021-11-08 10:20:45.673+00
5839	\N	died	2021-11-08 10:19:55.475+00	\N	\N	2021-11-08 10:20:45.633+00	2021-11-08 10:20:46.357+00
5961	\N	died	2021-11-08 10:19:59.643+00	\N	\N	2021-11-08 10:20:49.407+00	2021-11-08 10:20:49.698+00
4447	\N	died	2021-11-08 10:19:07.388+00	\N	\N	2021-11-08 10:20:04.086+00	2021-11-08 10:20:04.449+00
4448	\N	died	2021-11-08 10:19:07.389+00	\N	\N	2021-11-08 10:20:04.101+00	2021-11-08 10:20:04.449+00
5858	\N	died	2021-11-08 10:19:56.183+00	\N	\N	2021-11-08 10:20:46.342+00	2021-11-08 10:20:46.519+00
5861	\N	died	2021-11-08 10:19:56.253+00	\N	\N	2021-11-08 10:20:46.482+00	2021-11-08 10:20:46.652+00
5867	\N	died	2021-11-08 10:19:56.575+00	\N	\N	2021-11-08 10:20:46.634+00	2021-11-08 10:20:47.211+00
5968	\N	died	2021-11-08 10:19:59.826+00	\N	\N	2021-11-08 10:20:49.626+00	2021-11-08 10:20:50.246+00
6041	\N	died	2021-11-08 10:20:01.393+00	\N	\N	2021-11-08 10:20:51.557+00	2021-11-08 10:20:52.005+00
5915	\N	died	2021-11-08 10:19:58.051+00	\N	\N	2021-11-08 10:20:48.298+00	2021-11-08 10:20:48.537+00
5922	\N	died	2021-11-08 10:19:58.243+00	\N	\N	2021-11-08 10:20:48.432+00	2021-11-08 10:20:49.052+00
6016	\N	died	2021-11-08 10:20:00.909+00	\N	\N	2021-11-08 10:20:50.898+00	2021-11-08 10:20:51.449+00
5985	\N	died	2021-11-08 10:20:00.217+00	\N	\N	2021-11-08 10:20:50.066+00	2021-11-08 10:20:50.391+00
5997	\N	died	2021-11-08 10:20:00.467+00	\N	\N	2021-11-08 10:20:50.379+00	2021-11-08 10:20:50.625+00
6002	\N	died	2021-11-08 10:20:00.551+00	\N	\N	2021-11-08 10:20:50.542+00	2021-11-08 10:20:50.921+00
6034	\N	died	2021-11-08 10:20:01.276+00	\N	\N	2021-11-08 10:20:51.438+00	2021-11-08 10:20:51.709+00
6056	\N	died	2021-11-08 10:20:01.626+00	\N	\N	2021-11-08 10:20:51.999+00	2021-11-08 10:20:52.248+00
6064	\N	died	2021-11-08 10:20:01.826+00	\N	\N	2021-11-08 10:20:52.234+00	2021-11-08 10:20:52.354+00
6068	\N	died	2021-11-08 10:20:01.926+00	\N	\N	2021-11-08 10:20:52.349+00	2021-11-08 10:20:52.387+00
6070	\N	died	2021-11-08 10:20:02.023+00	\N	\N	2021-11-08 10:20:52.382+00	2021-11-08 10:20:52.534+00
6074	\N	died	2021-11-08 10:20:02.36+00	\N	\N	2021-11-08 10:20:52.517+00	2021-11-08 10:20:52.63+00
2948	\N	died	2021-11-08 10:18:40.895+00	\N	\N	2021-11-08 10:19:29.636+00	2021-11-08 10:19:29.758+00
2952	\N	died	2021-11-08 10:18:40.909+00	\N	\N	2021-11-08 10:19:29.755+00	2021-11-08 10:19:29.791+00
3041	\N	died	2021-11-08 10:18:41.154+00	\N	\N	2021-11-08 10:19:31.695+00	2021-11-08 10:19:32.228+00
2954	\N	died	2021-11-08 10:18:40.909+00	\N	\N	2021-11-08 10:19:29.787+00	2021-11-08 10:19:30.055+00
2958	\N	died	2021-11-08 10:18:40.927+00	\N	\N	2021-11-08 10:19:29.856+00	2021-11-08 10:19:30.198+00
3057	\N	died	2021-11-08 10:18:41.199+00	\N	\N	2021-11-08 10:19:32.086+00	2021-11-08 10:19:32.507+00
2970	\N	died	2021-11-08 10:18:40.95+00	\N	\N	2021-11-08 10:19:30.195+00	2021-11-08 10:19:30.314+00
4141	\N	died	2021-11-08 10:18:58.758+00	\N	\N	2021-11-08 10:19:56.99+00	2021-11-08 10:19:57.069+00
2975	\N	died	2021-11-08 10:18:40.961+00	\N	\N	2021-11-08 10:19:30.276+00	2021-11-08 10:19:30.635+00
2988	\N	died	2021-11-08 10:18:41.005+00	\N	\N	2021-11-08 10:19:30.615+00	2021-11-08 10:19:31.127+00
3012	\N	died	2021-11-08 10:18:41.066+00	\N	\N	2021-11-08 10:19:31.085+00	2021-11-08 10:19:31.464+00
3030	\N	died	2021-11-08 10:18:41.125+00	\N	\N	2021-11-08 10:19:31.437+00	2021-11-08 10:19:31.798+00
5784	\N	died	2021-11-08 10:19:53.449+00	\N	\N	2021-11-08 10:20:44.033+00	2021-11-08 10:20:44.104+00
4145	\N	died	2021-11-08 10:18:58.952+00	\N	\N	2021-11-08 10:19:57.065+00	2021-11-08 10:19:57.188+00
5990	\N	died	2021-11-08 10:20:00.301+00	\N	\N	2021-11-08 10:20:50.223+00	2021-11-08 10:20:50.854+00
4150	\N	died	2021-11-08 10:18:59.141+00	\N	\N	2021-11-08 10:19:57.148+00	2021-11-08 10:19:57.606+00
4166	\N	died	2021-11-08 10:18:59.457+00	\N	\N	2021-11-08 10:19:57.548+00	2021-11-08 10:19:57.856+00
5788	\N	died	2021-11-08 10:19:53.515+00	\N	\N	2021-11-08 10:20:44.1+00	2021-11-08 10:20:44.375+00
4180	\N	died	2021-11-08 10:18:59.751+00	\N	\N	2021-11-08 10:19:57.782+00	2021-11-08 10:19:58.18+00
4193	\N	died	2021-11-08 10:19:00.381+00	\N	\N	2021-11-08 10:19:58.159+00	2021-11-08 10:19:58.663+00
4211	\N	died	2021-11-08 10:19:01.067+00	\N	\N	2021-11-08 10:19:58.507+00	2021-11-08 10:19:59.071+00
5798	\N	died	2021-11-08 10:19:54.067+00	\N	\N	2021-11-08 10:20:44.342+00	2021-11-08 10:20:44.546+00
4229	\N	died	2021-11-08 10:19:01.656+00	\N	\N	2021-11-08 10:19:59.002+00	2021-11-08 10:19:59.348+00
4245	\N	died	2021-11-08 10:19:01.75+00	\N	\N	2021-11-08 10:19:59.324+00	2021-11-08 10:19:59.815+00
4265	\N	died	2021-11-08 10:19:02.151+00	\N	\N	2021-11-08 10:19:59.76+00	2021-11-08 10:20:00.038+00
5805	\N	died	2021-11-08 10:19:54.316+00	\N	\N	2021-11-08 10:20:44.541+00	2021-11-08 10:20:44.965+00
4277	\N	died	2021-11-08 10:19:02.407+00	\N	\N	2021-11-08 10:20:00.019+00	2021-11-08 10:20:00.471+00
6013	\N	died	2021-11-08 10:20:00.86+00	\N	\N	2021-11-08 10:20:50.849+00	2021-11-08 10:20:51.119+00
4293	\N	died	2021-11-08 10:19:02.878+00	\N	\N	2021-11-08 10:20:00.332+00	2021-11-08 10:20:00.831+00
4310	\N	died	2021-11-08 10:19:03.666+00	\N	\N	2021-11-08 10:20:00.827+00	2021-11-08 10:20:01.08+00
5813	\N	died	2021-11-08 10:19:54.592+00	\N	\N	2021-11-08 10:20:44.764+00	2021-11-08 10:20:45.299+00
4317	\N	died	2021-11-08 10:19:04.182+00	\N	\N	2021-11-08 10:20:00.993+00	2021-11-08 10:20:01.382+00
4335	\N	died	2021-11-08 10:19:05.341+00	\N	\N	2021-11-08 10:20:01.36+00	2021-11-08 10:20:01.631+00
4345	\N	died	2021-11-08 10:19:05.975+00	\N	\N	2021-11-08 10:20:01.577+00	2021-11-08 10:20:01.812+00
5827	\N	died	2021-11-08 10:19:55.05+00	\N	\N	2021-11-08 10:20:45.25+00	2021-11-08 10:20:45.834+00
4355	\N	died	2021-11-08 10:19:06.624+00	\N	\N	2021-11-08 10:20:01.793+00	2021-11-08 10:20:02.429+00
4370	\N	died	2021-11-08 10:19:07.083+00	\N	\N	2021-11-08 10:20:02.425+00	2021-11-08 10:20:02.662+00
4388	\N	died	2021-11-08 10:19:07.131+00	\N	\N	2021-11-08 10:20:02.825+00	2021-11-08 10:20:02.914+00
4380	\N	died	2021-11-08 10:19:07.11+00	\N	\N	2021-11-08 10:20:02.644+00	2021-11-08 10:20:02.914+00
4393	\N	died	2021-11-08 10:19:07.145+00	\N	\N	2021-11-08 10:20:02.91+00	2021-11-08 10:20:03.082+00
5841	\N	died	2021-11-08 10:19:55.691+00	\N	\N	2021-11-08 10:20:45.733+00	2021-11-08 10:20:45.971+00
4400	\N	died	2021-11-08 10:19:07.16+00	\N	\N	2021-11-08 10:20:03.077+00	2021-11-08 10:20:03.115+00
6021	\N	died	2021-11-08 10:20:01.045+00	\N	\N	2021-11-08 10:20:50.992+00	2021-11-08 10:20:51.709+00
4402	\N	died	2021-11-08 10:19:07.164+00	\N	\N	2021-11-08 10:20:03.111+00	2021-11-08 10:20:03.246+00
4392	\N	died	2021-11-08 10:19:07.142+00	\N	\N	2021-11-08 10:20:02.891+00	2021-11-08 10:20:03.315+00
5847	\N	died	2021-11-08 10:19:55.875+00	\N	\N	2021-11-08 10:20:45.95+00	2021-11-08 10:20:46.325+00
4405	\N	died	2021-11-08 10:19:07.175+00	\N	\N	2021-11-08 10:20:03.161+00	2021-11-08 10:20:03.512+00
4408	\N	died	2021-11-08 10:19:07.181+00	\N	\N	2021-11-08 10:20:03.261+00	2021-11-08 10:20:03.512+00
4415	\N	died	2021-11-08 10:19:07.194+00	\N	\N	2021-11-08 10:20:03.375+00	2021-11-08 10:20:03.731+00
5855	\N	died	2021-11-08 10:19:56.117+00	\N	\N	2021-11-08 10:20:46.258+00	2021-11-08 10:20:47.093+00
4419	\N	died	2021-11-08 10:19:07.204+00	\N	\N	2021-11-08 10:20:03.491+00	2021-11-08 10:20:03.987+00
4430	\N	died	2021-11-08 10:19:07.227+00	\N	\N	2021-11-08 10:20:03.726+00	2021-11-08 10:20:03.987+00
5874	\N	died	2021-11-08 10:19:56.775+00	\N	\N	2021-11-08 10:20:46.943+00	2021-11-08 10:20:47.763+00
4445	\N	died	2021-11-08 10:19:07.382+00	\N	\N	2021-11-08 10:20:04.052+00	2021-11-08 10:20:04.247+00
6038	\N	died	2021-11-08 10:20:01.343+00	\N	\N	2021-11-08 10:20:51.508+00	2021-11-08 10:20:51.821+00
4438	\N	died	2021-11-08 10:19:07.277+00	\N	\N	2021-11-08 10:20:03.883+00	2021-11-08 10:20:04.281+00
5894	\N	died	2021-11-08 10:19:57.4+00	\N	\N	2021-11-08 10:20:47.756+00	2021-11-08 10:20:47.886+00
4440	\N	died	2021-11-08 10:19:07.316+00	\N	\N	2021-11-08 10:20:03.968+00	2021-11-08 10:20:04.449+00
4455	\N	died	2021-11-08 10:19:07.582+00	\N	\N	2021-11-08 10:20:04.278+00	2021-11-08 10:20:04.449+00
4439	\N	died	2021-11-08 10:19:07.299+00	\N	\N	2021-11-08 10:20:03.95+00	2021-11-08 10:20:04.449+00
4454	\N	died	2021-11-08 10:19:07.549+00	\N	\N	2021-11-08 10:20:04.261+00	2021-11-08 10:20:04.463+00
5900	\N	died	2021-11-08 10:19:57.584+00	\N	\N	2021-11-08 10:20:47.876+00	2021-11-08 10:20:48.018+00
4462	\N	died	2021-11-08 10:19:07.75+00	\N	\N	2021-11-08 10:20:04.444+00	2021-11-08 10:20:04.482+00
5904	\N	died	2021-11-08 10:19:57.684+00	\N	\N	2021-11-08 10:20:48.015+00	2021-11-08 10:20:48.169+00
6050	\N	died	2021-11-08 10:20:01.544+00	\N	\N	2021-11-08 10:20:51.817+00	2021-11-08 10:20:52.023+00
5909	\N	died	2021-11-08 10:19:57.909+00	\N	\N	2021-11-08 10:20:48.125+00	2021-11-08 10:20:48.537+00
5923	\N	died	2021-11-08 10:19:58.259+00	\N	\N	2021-11-08 10:20:48.509+00	2021-11-08 10:20:49.052+00
5944	\N	died	2021-11-08 10:19:59.076+00	\N	\N	2021-11-08 10:20:48.94+00	2021-11-08 10:20:49.395+00
6057	\N	died	2021-11-08 10:20:01.693+00	\N	\N	2021-11-08 10:20:52.017+00	2021-11-08 10:20:52.354+00
5957	\N	died	2021-11-08 10:19:59.56+00	\N	\N	2021-11-08 10:20:49.332+00	2021-11-08 10:20:49.698+00
5966	\N	died	2021-11-08 10:19:59.776+00	\N	\N	2021-11-08 10:20:49.517+00	2021-11-08 10:20:49.912+00
5977	\N	died	2021-11-08 10:20:00.033+00	\N	\N	2021-11-08 10:20:49.825+00	2021-11-08 10:20:50.246+00
6066	\N	died	2021-11-08 10:20:01.844+00	\N	\N	2021-11-08 10:20:52.293+00	2021-11-08 10:20:52.569+00
6075	\N	died	2021-11-08 10:20:02.377+00	\N	\N	2021-11-08 10:20:52.551+00	2021-11-08 10:20:53.077+00
6082	\N	died	2021-11-08 10:20:02.792+00	\N	\N	2021-11-08 10:20:52.963+00	2021-11-08 10:20:53.307+00
6096	\N	died	2021-11-08 10:20:03.744+00	\N	\N	2021-11-08 10:20:53.302+00	2021-11-08 10:20:53.53+00
6105	\N	died	2021-11-08 10:20:04.168+00	\N	\N	2021-11-08 10:20:53.516+00	2021-11-08 10:20:53.581+00
6108	\N	died	2021-11-08 10:20:04.227+00	\N	\N	2021-11-08 10:20:53.576+00	2021-11-08 10:20:53.745+00
6113	\N	died	2021-11-08 10:20:04.401+00	\N	\N	2021-11-08 10:20:53.718+00	2021-11-08 10:20:53.847+00
6117	\N	died	2021-11-08 10:20:04.494+00	\N	\N	2021-11-08 10:20:53.842+00	2021-11-08 10:20:53.909+00
6120	\N	died	2021-11-08 10:20:04.543+00	\N	\N	2021-11-08 10:20:53.893+00	2021-11-08 10:20:54.163+00
6125	\N	died	2021-11-08 10:20:04.644+00	\N	\N	2021-11-08 10:20:54.147+00	2021-11-08 10:20:54.332+00
3007	\N	died	2021-11-08 10:18:41.053+00	\N	\N	2021-11-08 10:19:30.952+00	2021-11-08 10:19:31.127+00
4451	\N	died	2021-11-08 10:19:07.5+00	\N	\N	2021-11-08 10:20:04.21+00	2021-11-08 10:20:04.499+00
3014	\N	died	2021-11-08 10:18:41.073+00	\N	\N	2021-11-08 10:19:31.122+00	2021-11-08 10:19:31.156+00
3043	\N	died	2021-11-08 10:18:41.169+00	\N	\N	2021-11-08 10:19:31.78+00	2021-11-08 10:19:32.334+00
3016	\N	died	2021-11-08 10:18:41.073+00	\N	\N	2021-11-08 10:19:31.152+00	2021-11-08 10:19:31.212+00
3018	\N	died	2021-11-08 10:18:41.089+00	\N	\N	2021-11-08 10:19:31.185+00	2021-11-08 10:19:31.564+00
3033	\N	died	2021-11-08 10:18:41.132+00	\N	\N	2021-11-08 10:19:31.56+00	2021-11-08 10:19:31.798+00
4177	\N	died	2021-11-08 10:18:59.708+00	\N	\N	2021-11-08 10:19:57.733+00	2021-11-08 10:19:57.856+00
4181	\N	died	2021-11-08 10:18:59.831+00	\N	\N	2021-11-08 10:19:57.852+00	2021-11-08 10:19:58.056+00
4185	\N	died	2021-11-08 10:18:59.998+00	\N	\N	2021-11-08 10:19:57.985+00	2021-11-08 10:19:58.23+00
4197	\N	died	2021-11-08 10:19:00.565+00	\N	\N	2021-11-08 10:19:58.226+00	2021-11-08 10:19:58.364+00
4463	\N	died	2021-11-08 10:19:07.751+00	\N	\N	2021-11-08 10:20:04.459+00	2021-11-08 10:20:04.515+00
4202	\N	died	2021-11-08 10:19:00.848+00	\N	\N	2021-11-08 10:19:58.36+00	2021-11-08 10:19:58.663+00
4210	\N	died	2021-11-08 10:19:01.065+00	\N	\N	2021-11-08 10:19:58.494+00	2021-11-08 10:19:58.972+00
4227	\N	died	2021-11-08 10:19:01.532+00	\N	\N	2021-11-08 10:19:58.968+00	2021-11-08 10:19:59.171+00
5787	\N	died	2021-11-08 10:19:53.498+00	\N	\N	2021-11-08 10:20:44.082+00	2021-11-08 10:20:44.305+00
4232	\N	died	2021-11-08 10:19:01.692+00	\N	\N	2021-11-08 10:19:59.093+00	2021-11-08 10:19:59.513+00
5935	\N	died	2021-11-08 10:19:58.75+00	\N	\N	2021-11-08 10:20:48.794+00	2021-11-08 10:20:48.878+00
4247	\N	died	2021-11-08 10:19:01.757+00	\N	\N	2021-11-08 10:19:59.359+00	2021-11-08 10:19:59.565+00
4452	\N	died	2021-11-08 10:19:07.516+00	\N	\N	2021-11-08 10:20:04.227+00	2021-11-08 10:20:04.531+00
4256	\N	died	2021-11-08 10:19:01.827+00	\N	\N	2021-11-08 10:19:59.561+00	2021-11-08 10:19:59.714+00
4260	\N	died	2021-11-08 10:19:01.931+00	\N	\N	2021-11-08 10:19:59.627+00	2021-11-08 10:19:59.971+00
4270	\N	died	2021-11-08 10:19:02.206+00	\N	\N	2021-11-08 10:19:59.843+00	2021-11-08 10:20:00.089+00
4456	\N	died	2021-11-08 10:19:07.605+00	\N	\N	2021-11-08 10:20:04.294+00	2021-11-08 10:20:04.615+00
4281	\N	died	2021-11-08 10:19:02.474+00	\N	\N	2021-11-08 10:20:00.085+00	2021-11-08 10:20:00.222+00
4465	\N	died	2021-11-08 10:19:07.816+00	\N	\N	2021-11-08 10:20:04.495+00	2021-11-08 10:20:04.615+00
4286	\N	died	2021-11-08 10:19:02.66+00	\N	\N	2021-11-08 10:20:00.218+00	2021-11-08 10:20:00.471+00
4457	\N	died	2021-11-08 10:19:07.607+00	\N	\N	2021-11-08 10:20:04.318+00	2021-11-08 10:20:04.615+00
4296	\N	died	2021-11-08 10:19:02.924+00	\N	\N	2021-11-08 10:20:00.435+00	2021-11-08 10:20:01.08+00
4466	\N	died	2021-11-08 10:19:07.849+00	\N	\N	2021-11-08 10:20:04.511+00	2021-11-08 10:20:04.615+00
4316	\N	died	2021-11-08 10:19:04.084+00	\N	\N	2021-11-08 10:20:00.928+00	2021-11-08 10:20:01.349+00
4331	\N	died	2021-11-08 10:19:05.091+00	\N	\N	2021-11-08 10:20:01.294+00	2021-11-08 10:20:01.631+00
5796	\N	died	2021-11-08 10:19:53.95+00	\N	\N	2021-11-08 10:20:44.298+00	2021-11-08 10:20:44.375+00
4347	\N	died	2021-11-08 10:19:06.09+00	\N	\N	2021-11-08 10:20:01.611+00	2021-11-08 10:20:02.205+00
4464	\N	died	2021-11-08 10:19:07.782+00	\N	\N	2021-11-08 10:20:04.478+00	2021-11-08 10:20:04.615+00
4363	\N	died	2021-11-08 10:19:06.924+00	\N	\N	2021-11-08 10:20:02.202+00	2021-11-08 10:20:02.578+00
4371	\N	died	2021-11-08 10:19:07.085+00	\N	\N	2021-11-08 10:20:02.441+00	2021-11-08 10:20:02.797+00
4382	\N	died	2021-11-08 10:19:07.113+00	\N	\N	2021-11-08 10:20:02.674+00	2021-11-08 10:20:02.848+00
4374	\N	died	2021-11-08 10:19:07.093+00	\N	\N	2021-11-08 10:20:02.541+00	2021-11-08 10:20:03.082+00
4389	\N	died	2021-11-08 10:19:07.131+00	\N	\N	2021-11-08 10:20:02.843+00	2021-11-08 10:20:03.082+00
5799	\N	died	2021-11-08 10:19:54.098+00	\N	\N	2021-11-08 10:20:44.366+00	2021-11-08 10:20:44.51+00
4395	\N	died	2021-11-08 10:19:07.148+00	\N	\N	2021-11-08 10:20:02.941+00	2021-11-08 10:20:03.315+00
4399	\N	died	2021-11-08 10:19:07.157+00	\N	\N	2021-11-08 10:20:03.058+00	2021-11-08 10:20:03.512+00
4410	\N	died	2021-11-08 10:19:07.184+00	\N	\N	2021-11-08 10:20:03.292+00	2021-11-08 10:20:03.635+00
4418	\N	died	2021-11-08 10:19:07.204+00	\N	\N	2021-11-08 10:20:03.476+00	2021-11-08 10:20:03.987+00
4425	\N	died	2021-11-08 10:19:07.212+00	\N	\N	2021-11-08 10:20:03.591+00	2021-11-08 10:20:03.987+00
5803	\N	died	2021-11-08 10:19:54.208+00	\N	\N	2021-11-08 10:20:44.506+00	2021-11-08 10:20:44.577+00
4436	\N	died	2021-11-08 10:19:07.24+00	\N	\N	2021-11-08 10:20:03.851+00	2021-11-08 10:20:04.247+00
4449	\N	died	2021-11-08 10:19:07.399+00	\N	\N	2021-11-08 10:20:04.169+00	2021-11-08 10:20:04.247+00
5938	\N	died	2021-11-08 10:19:58.885+00	\N	\N	2021-11-08 10:20:48.84+00	2021-11-08 10:20:49.213+00
4437	\N	died	2021-11-08 10:19:07.275+00	\N	\N	2021-11-08 10:20:03.869+00	2021-11-08 10:20:04.449+00
4453	\N	died	2021-11-08 10:19:07.518+00	\N	\N	2021-11-08 10:20:04.243+00	2021-11-08 10:20:04.449+00
5806	\N	died	2021-11-08 10:19:54.367+00	\N	\N	2021-11-08 10:20:44.558+00	2021-11-08 10:20:44.965+00
4458	\N	died	2021-11-08 10:19:07.624+00	\N	\N	2021-11-08 10:20:04.385+00	2021-11-08 10:20:04.682+00
4467	\N	died	2021-11-08 10:19:07.883+00	\N	\N	2021-11-08 10:20:04.527+00	2021-11-08 10:20:04.682+00
4460	\N	died	2021-11-08 10:19:07.642+00	\N	\N	2021-11-08 10:20:04.416+00	2021-11-08 10:20:04.682+00
4472	\N	died	2021-11-08 10:19:08.058+00	\N	\N	2021-11-08 10:20:04.611+00	2021-11-08 10:20:04.682+00
6042	\N	died	2021-11-08 10:20:01.46+00	\N	\N	2021-11-08 10:20:51.573+00	2021-11-08 10:20:52.248+00
5818	\N	died	2021-11-08 10:19:54.733+00	\N	\N	2021-11-08 10:20:44.908+00	2021-11-08 10:20:45.673+00
5838	\N	died	2021-11-08 10:19:55.425+00	\N	\N	2021-11-08 10:20:45.611+00	2021-11-08 10:20:46.325+00
4459	\N	died	2021-11-08 10:19:07.64+00	\N	\N	2021-11-08 10:20:04.402+00	2021-11-08 10:20:04.699+00
5953	\N	died	2021-11-08 10:19:59.475+00	\N	\N	2021-11-08 10:20:49.191+00	2021-11-08 10:20:49.698+00
4469	\N	died	2021-11-08 10:19:08+00	\N	\N	2021-11-08 10:20:04.56+00	2021-11-08 10:20:04.813+00
4461	\N	died	2021-11-08 10:19:07.674+00	\N	\N	2021-11-08 10:20:04.426+00	2021-11-08 10:20:04.813+00
4470	\N	died	2021-11-08 10:19:08.002+00	\N	\N	2021-11-08 10:20:04.577+00	2021-11-08 10:20:04.813+00
4476	\N	died	2021-11-08 10:19:08.157+00	\N	\N	2021-11-08 10:20:04.677+00	2021-11-08 10:20:04.813+00
5856	\N	died	2021-11-08 10:19:56.134+00	\N	\N	2021-11-08 10:20:46.294+00	2021-11-08 10:20:47.211+00
4477	\N	died	2021-11-08 10:19:08.233+00	\N	\N	2021-11-08 10:20:04.694+00	2021-11-08 10:20:04.845+00
4481	\N	died	2021-11-08 10:19:08.245+00	\N	\N	2021-11-08 10:20:04.809+00	2021-11-08 10:20:04.845+00
6095	\N	died	2021-11-08 10:20:03.659+00	\N	\N	2021-11-08 10:20:53.282+00	2021-11-08 10:20:53.53+00
5876	\N	died	2021-11-08 10:19:56.842+00	\N	\N	2021-11-08 10:20:47.125+00	2021-11-08 10:20:47.376+00
4478	\N	died	2021-11-08 10:19:08.237+00	\N	\N	2021-11-08 10:20:04.71+00	2021-11-08 10:20:04.881+00
4483	\N	died	2021-11-08 10:19:08.251+00	\N	\N	2021-11-08 10:20:04.841+00	2021-11-08 10:20:04.881+00
5881	\N	died	2021-11-08 10:19:56.959+00	\N	\N	2021-11-08 10:20:47.35+00	2021-11-08 10:20:47.539+00
5969	\N	died	2021-11-08 10:19:59.843+00	\N	\N	2021-11-08 10:20:49.65+00	2021-11-08 10:20:50.246+00
4482	\N	died	2021-11-08 10:19:08.248+00	\N	\N	2021-11-08 10:20:04.827+00	2021-11-08 10:20:04.919+00
4485	\N	died	2021-11-08 10:19:08.256+00	\N	\N	2021-11-08 10:20:04.877+00	2021-11-08 10:20:04.919+00
5886	\N	died	2021-11-08 10:19:57.085+00	\N	\N	2021-11-08 10:20:47.493+00	2021-11-08 10:20:47.886+00
5899	\N	died	2021-11-08 10:19:57.568+00	\N	\N	2021-11-08 10:20:47.858+00	2021-11-08 10:20:48.079+00
6058	\N	died	2021-11-08 10:20:01.71+00	\N	\N	2021-11-08 10:20:52.032+00	2021-11-08 10:20:52.371+00
5906	\N	died	2021-11-08 10:19:57.753+00	\N	\N	2021-11-08 10:20:48.057+00	2021-11-08 10:20:48.537+00
5920	\N	died	2021-11-08 10:19:58.195+00	\N	\N	2021-11-08 10:20:48.381+00	2021-11-08 10:20:48.8+00
5987	\N	died	2021-11-08 10:20:00.254+00	\N	\N	2021-11-08 10:20:50.107+00	2021-11-08 10:20:50.625+00
6069	\N	died	2021-11-08 10:20:01.985+00	\N	\N	2021-11-08 10:20:52.366+00	2021-11-08 10:20:52.534+00
6003	\N	died	2021-11-08 10:20:00.568+00	\N	\N	2021-11-08 10:20:50.574+00	2021-11-08 10:20:51.119+00
6018	\N	died	2021-11-08 10:20:00.928+00	\N	\N	2021-11-08 10:20:50.934+00	2021-11-08 10:20:51.249+00
6028	\N	died	2021-11-08 10:20:01.142+00	\N	\N	2021-11-08 10:20:51.224+00	2021-11-08 10:20:51.709+00
6103	\N	died	2021-11-08 10:20:04.052+00	\N	\N	2021-11-08 10:20:53.485+00	2021-11-08 10:20:53.943+00
6072	\N	died	2021-11-08 10:20:02.318+00	\N	\N	2021-11-08 10:20:52.432+00	2021-11-08 10:20:53.077+00
6080	\N	died	2021-11-08 10:20:02.643+00	\N	\N	2021-11-08 10:20:52.659+00	2021-11-08 10:20:53.128+00
6128	\N	died	2021-11-08 10:20:04.694+00	\N	\N	2021-11-08 10:20:54.258+00	2021-11-08 10:20:54.662+00
6091	\N	died	2021-11-08 10:20:03.36+00	\N	\N	2021-11-08 10:20:53.124+00	2021-11-08 10:20:53.29+00
6121	\N	died	2021-11-08 10:20:04.56+00	\N	\N	2021-11-08 10:20:53.926+00	2021-11-08 10:20:54.332+00
6145	\N	died	2021-11-08 10:20:05.443+00	\N	\N	2021-11-08 10:20:54.657+00	2021-11-08 10:20:54.83+00
6155	\N	died	2021-11-08 10:20:05.665+00	\N	\N	2021-11-08 10:20:54.824+00	2021-11-08 10:20:54.863+00
6157	\N	died	2021-11-08 10:20:05.702+00	\N	\N	2021-11-08 10:20:54.859+00	2021-11-08 10:20:54.903+00
6160	\N	died	2021-11-08 10:20:05.769+00	\N	\N	2021-11-08 10:20:54.899+00	2021-11-08 10:20:55.012+00
6164	\N	died	2021-11-08 10:20:05.938+00	\N	\N	2021-11-08 10:20:54.994+00	2021-11-08 10:20:55.16+00
4484	\N	died	2021-11-08 10:19:08.253+00	\N	\N	2021-11-08 10:20:04.858+00	2021-11-08 10:20:04.949+00
5840	\N	died	2021-11-08 10:19:55.508+00	\N	\N	2021-11-08 10:20:45.662+00	2021-11-08 10:20:45.834+00
4489	\N	died	2021-11-08 10:19:08.269+00	\N	\N	2021-11-08 10:20:04.944+00	2021-11-08 10:20:05.104+00
4494	\N	died	2021-11-08 10:19:08.285+00	\N	\N	2021-11-08 10:20:05.028+00	2021-11-08 10:20:05.55+00
4509	\N	died	2021-11-08 10:19:08.491+00	\N	\N	2021-11-08 10:20:05.527+00	2021-11-08 10:20:05.727+00
5843	\N	died	2021-11-08 10:19:55.742+00	\N	\N	2021-11-08 10:20:45.81+00	2021-11-08 10:20:45.931+00
4517	\N	died	2021-11-08 10:19:08.766+00	\N	\N	2021-11-08 10:20:05.72+00	2021-11-08 10:20:05.776+00
6060	\N	died	2021-11-08 10:20:01.744+00	\N	\N	2021-11-08 10:20:52.068+00	2021-11-08 10:20:52.613+00
4520	\N	died	2021-11-08 10:19:08.799+00	\N	\N	2021-11-08 10:20:05.77+00	2021-11-08 10:20:05.956+00
4523	\N	died	2021-11-08 10:19:08.899+00	\N	\N	2021-11-08 10:20:05.941+00	2021-11-08 10:20:06.063+00
5846	\N	died	2021-11-08 10:19:55.808+00	\N	\N	2021-11-08 10:20:45.917+00	2021-11-08 10:20:46.325+00
4527	\N	died	2021-11-08 10:19:08.999+00	\N	\N	2021-11-08 10:20:06.055+00	2021-11-08 10:20:06.239+00
4529	\N	died	2021-11-08 10:19:09.083+00	\N	\N	2021-11-08 10:20:06.227+00	2021-11-08 10:20:06.669+00
4535	\N	died	2021-11-08 10:19:09.233+00	\N	\N	2021-11-08 10:20:06.665+00	2021-11-08 10:20:07.006+00
5853	\N	died	2021-11-08 10:19:56.011+00	\N	\N	2021-11-08 10:20:46.194+00	2021-11-08 10:20:47.093+00
4540	\N	died	2021-11-08 10:19:09.349+00	\N	\N	2021-11-08 10:20:06.99+00	2021-11-08 10:20:07.204+00
4545	\N	died	2021-11-08 10:19:09.474+00	\N	\N	2021-11-08 10:20:07.189+00	2021-11-08 10:20:07.301+00
4548	\N	died	2021-11-08 10:19:09.557+00	\N	\N	2021-11-08 10:20:07.296+00	2021-11-08 10:20:07.836+00
5870	\N	died	2021-11-08 10:19:56.658+00	\N	\N	2021-11-08 10:20:46.797+00	2021-11-08 10:20:47.539+00
4558	\N	died	2021-11-08 10:19:10.217+00	\N	\N	2021-11-08 10:20:07.82+00	2021-11-08 10:20:07.918+00
6077	\N	died	2021-11-08 10:20:02.46+00	\N	\N	2021-11-08 10:20:52.607+00	2021-11-08 10:20:53.077+00
4560	\N	died	2021-11-08 10:19:10.275+00	\N	\N	2021-11-08 10:20:07.902+00	2021-11-08 10:20:08.087+00
4564	\N	died	2021-11-08 10:19:10.45+00	\N	\N	2021-11-08 10:20:08.071+00	2021-11-08 10:20:08.184+00
5887	\N	died	2021-11-08 10:19:57.101+00	\N	\N	2021-11-08 10:20:47.515+00	2021-11-08 10:20:47.99+00
4568	\N	died	2021-11-08 10:19:10.675+00	\N	\N	2021-11-08 10:20:08.179+00	2021-11-08 10:20:08.252+00
4572	\N	died	2021-11-08 10:19:10.909+00	\N	\N	2021-11-08 10:20:08.246+00	2021-11-08 10:20:08.43+00
4577	\N	died	2021-11-08 10:19:10.961+00	\N	\N	2021-11-08 10:20:08.407+00	2021-11-08 10:20:08.537+00
5901	\N	died	2021-11-08 10:19:57.616+00	\N	\N	2021-11-08 10:20:47.95+00	2021-11-08 10:20:48.169+00
4580	\N	died	2021-11-08 10:19:11.076+00	\N	\N	2021-11-08 10:20:08.521+00	2021-11-08 10:20:08.705+00
4586	\N	died	2021-11-08 10:19:11.194+00	\N	\N	2021-11-08 10:20:08.693+00	2021-11-08 10:20:08.84+00
4589	\N	died	2021-11-08 10:19:11.353+00	\N	\N	2021-11-08 10:20:08.828+00	2021-11-08 10:20:08.892+00
5908	\N	died	2021-11-08 10:19:57.851+00	\N	\N	2021-11-08 10:20:48.092+00	2021-11-08 10:20:48.355+00
4592	\N	died	2021-11-08 10:19:11.402+00	\N	\N	2021-11-08 10:20:08.887+00	2021-11-08 10:20:08.959+00
6087	\N	died	2021-11-08 10:20:03.11+00	\N	\N	2021-11-08 10:20:53.057+00	2021-11-08 10:20:53.551+00
4595	\N	died	2021-11-08 10:19:11.418+00	\N	\N	2021-11-08 10:20:08.946+00	2021-11-08 10:20:09.12+00
4601	\N	died	2021-11-08 10:19:11.433+00	\N	\N	2021-11-08 10:20:09.117+00	2021-11-08 10:20:09.162+00
5916	\N	died	2021-11-08 10:19:58.068+00	\N	\N	2021-11-08 10:20:48.315+00	2021-11-08 10:20:48.584+00
4605	\N	died	2021-11-08 10:19:11.444+00	\N	\N	2021-11-08 10:20:09.159+00	2021-11-08 10:20:09.343+00
4610	\N	died	2021-11-08 10:19:11.55+00	\N	\N	2021-11-08 10:20:09.327+00	2021-11-08 10:20:09.382+00
4612	\N	died	2021-11-08 10:19:11.556+00	\N	\N	2021-11-08 10:20:09.375+00	2021-11-08 10:20:09.47+00
5926	\N	died	2021-11-08 10:19:58.359+00	\N	\N	2021-11-08 10:20:48.567+00	2021-11-08 10:20:48.774+00
4616	\N	died	2021-11-08 10:19:11.564+00	\N	\N	2021-11-08 10:20:09.466+00	2021-11-08 10:20:09.541+00
4620	\N	died	2021-11-08 10:19:11.576+00	\N	\N	2021-11-08 10:20:09.536+00	2021-11-08 10:20:09.734+00
4627	\N	died	2021-11-08 10:19:11.692+00	\N	\N	2021-11-08 10:20:09.729+00	2021-11-08 10:20:09.884+00
5932	\N	died	2021-11-08 10:19:58.525+00	\N	\N	2021-11-08 10:20:48.673+00	2021-11-08 10:20:49.069+00
4632	\N	died	2021-11-08 10:19:11.818+00	\N	\N	2021-11-08 10:20:09.869+00	2021-11-08 10:20:09.933+00
6106	\N	died	2021-11-08 10:20:04.185+00	\N	\N	2021-11-08 10:20:53.542+00	2021-11-08 10:20:53.745+00
4634	\N	died	2021-11-08 10:19:11.868+00	\N	\N	2021-11-08 10:20:09.928+00	2021-11-08 10:20:09.967+00
4636	\N	died	2021-11-08 10:19:11.901+00	\N	\N	2021-11-08 10:20:09.962+00	2021-11-08 10:20:10.034+00
5947	\N	died	2021-11-08 10:19:59.201+00	\N	\N	2021-11-08 10:20:49.065+00	2021-11-08 10:20:49.213+00
4640	\N	died	2021-11-08 10:19:12.068+00	\N	\N	2021-11-08 10:20:10.029+00	2021-11-08 10:20:10.172+00
4644	\N	died	2021-11-08 10:19:12.233+00	\N	\N	2021-11-08 10:20:10.165+00	2021-11-08 10:20:10.3+00
4650	\N	died	2021-11-08 10:19:12.342+00	\N	\N	2021-11-08 10:20:10.295+00	2021-11-08 10:20:10.351+00
5952	\N	died	2021-11-08 10:19:59.411+00	\N	\N	2021-11-08 10:20:49.174+00	2021-11-08 10:20:49.698+00
4653	\N	died	2021-11-08 10:19:12.466+00	\N	\N	2021-11-08 10:20:10.346+00	2021-11-08 10:20:10.504+00
4656	\N	died	2021-11-08 10:19:12.559+00	\N	\N	2021-11-08 10:20:10.497+00	2021-11-08 10:20:10.567+00
5967	\N	died	2021-11-08 10:19:59.809+00	\N	\N	2021-11-08 10:20:49.593+00	2021-11-08 10:20:49.935+00
4658	\N	died	2021-11-08 10:19:12.734+00	\N	\N	2021-11-08 10:20:10.562+00	2021-11-08 10:20:10.599+00
6110	\N	died	2021-11-08 10:20:04.277+00	\N	\N	2021-11-08 10:20:53.609+00	2021-11-08 10:20:53.909+00
5979	\N	died	2021-11-08 10:20:00.068+00	\N	\N	2021-11-08 10:20:49.925+00	2021-11-08 10:20:50.246+00
5984	\N	died	2021-11-08 10:20:00.201+00	\N	\N	2021-11-08 10:20:50.034+00	2021-11-08 10:20:50.512+00
5999	\N	died	2021-11-08 10:20:00.501+00	\N	\N	2021-11-08 10:20:50.433+00	2021-11-08 10:20:50.841+00
6119	\N	died	2021-11-08 10:20:04.527+00	\N	\N	2021-11-08 10:20:53.874+00	2021-11-08 10:20:54.4+00
6011	\N	died	2021-11-08 10:20:00.826+00	\N	\N	2021-11-08 10:20:50.792+00	2021-11-08 10:20:51.15+00
6024	\N	died	2021-11-08 10:20:01.092+00	\N	\N	2021-11-08 10:20:51.134+00	2021-11-08 10:20:51.249+00
6027	\N	died	2021-11-08 10:20:01.125+00	\N	\N	2021-11-08 10:20:51.199+00	2021-11-08 10:20:51.47+00
6035	\N	died	2021-11-08 10:20:01.293+00	\N	\N	2021-11-08 10:20:51.46+00	2021-11-08 10:20:51.709+00
6043	\N	died	2021-11-08 10:20:01.462+00	\N	\N	2021-11-08 10:20:51.59+00	2021-11-08 10:20:52.248+00
6132	\N	died	2021-11-08 10:20:04.876+00	\N	\N	2021-11-08 10:20:54.366+00	2021-11-08 10:20:54.614+00
6142	\N	died	2021-11-08 10:20:05.396+00	\N	\N	2021-11-08 10:20:54.607+00	2021-11-08 10:20:54.83+00
6152	\N	died	2021-11-08 10:20:05.629+00	\N	\N	2021-11-08 10:20:54.774+00	2021-11-08 10:20:55.172+00
6169	\N	died	2021-11-08 10:20:06.218+00	\N	\N	2021-11-08 10:20:55.166+00	2021-11-08 10:20:55.469+00
6178	\N	died	2021-11-08 10:20:06.852+00	\N	\N	2021-11-08 10:20:55.418+00	2021-11-08 10:20:55.771+00
6191	\N	died	2021-11-08 10:20:07.563+00	\N	\N	2021-11-08 10:20:55.766+00	2021-11-08 10:20:56.089+00
6198	\N	died	2021-11-08 10:20:07.899+00	\N	\N	2021-11-08 10:20:56.083+00	2021-11-08 10:20:56.12+00
6200	\N	died	2021-11-08 10:20:07.986+00	\N	\N	2021-11-08 10:20:56.116+00	2021-11-08 10:20:56.205+00
6204	\N	died	2021-11-08 10:20:08.13+00	\N	\N	2021-11-08 10:20:56.187+00	2021-11-08 10:20:56.384+00
6209	\N	died	2021-11-08 10:20:08.228+00	\N	\N	2021-11-08 10:20:56.368+00	2021-11-08 10:20:56.523+00
6217	\N	died	2021-11-08 10:20:08.673+00	\N	\N	2021-11-08 10:20:56.509+00	2021-11-08 10:20:56.623+00
4479	\N	died	2021-11-08 10:19:08.239+00	\N	\N	2021-11-08 10:20:04.724+00	2021-11-08 10:20:04.933+00
4488	\N	died	2021-11-08 10:19:08.265+00	\N	\N	2021-11-08 10:20:04.929+00	2021-11-08 10:20:05.104+00
4492	\N	died	2021-11-08 10:19:08.276+00	\N	\N	2021-11-08 10:20:04.991+00	2021-11-08 10:20:05.727+00
5848	\N	died	2021-11-08 10:19:55.932+00	\N	\N	2021-11-08 10:20:45.989+00	2021-11-08 10:20:46.325+00
4514	\N	died	2021-11-08 10:19:08.624+00	\N	\N	2021-11-08 10:20:05.666+00	2021-11-08 10:20:06.669+00
4532	\N	died	2021-11-08 10:19:09.134+00	\N	\N	2021-11-08 10:20:06.399+00	2021-11-08 10:20:07.396+00
4549	\N	died	2021-11-08 10:19:09.595+00	\N	\N	2021-11-08 10:20:07.38+00	2021-11-08 10:20:07.876+00
5857	\N	died	2021-11-08 10:19:56.149+00	\N	\N	2021-11-08 10:20:46.318+00	2021-11-08 10:20:46.473+00
4559	\N	died	2021-11-08 10:19:10.249+00	\N	\N	2021-11-08 10:20:07.861+00	2021-11-08 10:20:08.087+00
6053	\N	died	2021-11-08 10:20:01.593+00	\N	\N	2021-11-08 10:20:51.885+00	2021-11-08 10:20:52.354+00
4562	\N	died	2021-11-08 10:19:10.382+00	\N	\N	2021-11-08 10:20:07.989+00	2021-11-08 10:20:08.252+00
4570	\N	died	2021-11-08 10:19:10.825+00	\N	\N	2021-11-08 10:20:08.211+00	2021-11-08 10:20:08.537+00
5860	\N	died	2021-11-08 10:19:56.233+00	\N	\N	2021-11-08 10:20:46.467+00	2021-11-08 10:20:46.519+00
4579	\N	died	2021-11-08 10:19:11.045+00	\N	\N	2021-11-08 10:20:08.477+00	2021-11-08 10:20:08.84+00
4588	\N	died	2021-11-08 10:19:11.351+00	\N	\N	2021-11-08 10:20:08.8+00	2021-11-08 10:20:09.12+00
4600	\N	died	2021-11-08 10:19:11.432+00	\N	\N	2021-11-08 10:20:09.103+00	2021-11-08 10:20:09.625+00
5863	\N	died	2021-11-08 10:19:56.358+00	\N	\N	2021-11-08 10:20:46.515+00	2021-11-08 10:20:46.584+00
4621	\N	died	2021-11-08 10:19:11.597+00	\N	\N	2021-11-08 10:20:09.61+00	2021-11-08 10:20:09.884+00
4630	\N	died	2021-11-08 10:19:11.784+00	\N	\N	2021-11-08 10:20:09.779+00	2021-11-08 10:20:10.051+00
4641	\N	died	2021-11-08 10:19:12.084+00	\N	\N	2021-11-08 10:20:10.046+00	2021-11-08 10:20:10.3+00
5865	\N	died	2021-11-08 10:19:56.506+00	\N	\N	2021-11-08 10:20:46.567+00	2021-11-08 10:20:47.093+00
4648	\N	died	2021-11-08 10:19:12.301+00	\N	\N	2021-11-08 10:20:10.264+00	2021-11-08 10:20:10.833+00
6067	\N	died	2021-11-08 10:20:01.86+00	\N	\N	2021-11-08 10:20:52.332+00	2021-11-08 10:20:52.65+00
4669	\N	died	2021-11-08 10:19:13.093+00	\N	\N	2021-11-08 10:20:10.829+00	2021-11-08 10:20:10.931+00
4674	\N	died	2021-11-08 10:19:13.318+00	\N	\N	2021-11-08 10:20:10.928+00	2021-11-08 10:20:11.035+00
5873	\N	died	2021-11-08 10:19:56.742+00	\N	\N	2021-11-08 10:20:46.899+00	2021-11-08 10:20:47.846+00
4679	\N	died	2021-11-08 10:19:13.501+00	\N	\N	2021-11-08 10:20:11.021+00	2021-11-08 10:20:11.093+00
4682	\N	died	2021-11-08 10:19:13.65+00	\N	\N	2021-11-08 10:20:11.087+00	2021-11-08 10:20:11.676+00
4689	\N	died	2021-11-08 10:19:13.901+00	\N	\N	2021-11-08 10:20:11.67+00	2021-11-08 10:20:11.729+00
5896	\N	died	2021-11-08 10:19:57.484+00	\N	\N	2021-11-08 10:20:47.79+00	2021-11-08 10:20:48.291+00
4691	\N	died	2021-11-08 10:19:13.918+00	\N	\N	2021-11-08 10:20:11.714+00	2021-11-08 10:20:11.846+00
4698	\N	died	2021-11-08 10:19:14.17+00	\N	\N	2021-11-08 10:20:11.842+00	2021-11-08 10:20:12.068+00
4704	\N	died	2021-11-08 10:19:14.384+00	\N	\N	2021-11-08 10:20:12.058+00	2021-11-08 10:20:12.128+00
5912	\N	died	2021-11-08 10:19:57.984+00	\N	\N	2021-11-08 10:20:48.234+00	2021-11-08 10:20:48.537+00
4706	\N	died	2021-11-08 10:19:14.452+00	\N	\N	2021-11-08 10:20:12.116+00	2021-11-08 10:20:12.225+00
6079	\N	died	2021-11-08 10:20:02.593+00	\N	\N	2021-11-08 10:20:52.642+00	2021-11-08 10:20:53.111+00
4711	\N	died	2021-11-08 10:19:14.508+00	\N	\N	2021-11-08 10:20:12.217+00	2021-11-08 10:20:12.307+00
4715	\N	died	2021-11-08 10:19:14.52+00	\N	\N	2021-11-08 10:20:12.291+00	2021-11-08 10:20:12.449+00
5921	\N	died	2021-11-08 10:19:58.225+00	\N	\N	2021-11-08 10:20:48.401+00	2021-11-08 10:20:48.878+00
4722	\N	died	2021-11-08 10:19:14.537+00	\N	\N	2021-11-08 10:20:12.445+00	2021-11-08 10:20:12.511+00
6194	\N	died	2021-11-08 10:20:07.678+00	\N	\N	2021-11-08 10:20:55.924+00	2021-11-08 10:20:56.384+00
4726	\N	died	2021-11-08 10:19:14.643+00	\N	\N	2021-11-08 10:20:12.503+00	2021-11-08 10:20:12.617+00
4729	\N	died	2021-11-08 10:19:14.68+00	\N	\N	2021-11-08 10:20:12.613+00	2021-11-08 10:20:12.698+00
5939	\N	died	2021-11-08 10:19:58.918+00	\N	\N	2021-11-08 10:20:48.856+00	2021-11-08 10:20:49.115+00
4734	\N	died	2021-11-08 10:19:14.743+00	\N	\N	2021-11-08 10:20:12.694+00	2021-11-08 10:20:13.034+00
4742	\N	died	2021-11-08 10:19:15.126+00	\N	\N	2021-11-08 10:20:13.021+00	2021-11-08 10:20:13.067+00
4744	\N	died	2021-11-08 10:19:15.159+00	\N	\N	2021-11-08 10:20:13.063+00	2021-11-08 10:20:13.131+00
5948	\N	died	2021-11-08 10:19:59.244+00	\N	\N	2021-11-08 10:20:49.085+00	2021-11-08 10:20:49.395+00
4748	\N	died	2021-11-08 10:19:15.293+00	\N	\N	2021-11-08 10:20:13.128+00	2021-11-08 10:20:13.271+00
6089	\N	died	2021-11-08 10:20:03.26+00	\N	\N	2021-11-08 10:20:53.09+00	2021-11-08 10:20:53.163+00
4752	\N	died	2021-11-08 10:19:15.343+00	\N	\N	2021-11-08 10:20:13.265+00	2021-11-08 10:20:13.423+00
4755	\N	died	2021-11-08 10:19:15.443+00	\N	\N	2021-11-08 10:20:13.414+00	2021-11-08 10:20:13.816+00
5959	\N	died	2021-11-08 10:19:59.609+00	\N	\N	2021-11-08 10:20:49.373+00	2021-11-08 10:20:49.721+00
4765	\N	died	2021-11-08 10:19:15.659+00	\N	\N	2021-11-08 10:20:13.811+00	2021-11-08 10:20:13.849+00
4767	\N	died	2021-11-08 10:19:15.693+00	\N	\N	2021-11-08 10:20:13.846+00	2021-11-08 10:20:13.921+00
4770	\N	died	2021-11-08 10:19:15.81+00	\N	\N	2021-11-08 10:20:13.906+00	2021-11-08 10:20:14.068+00
5972	\N	died	2021-11-08 10:19:59.95+00	\N	\N	2021-11-08 10:20:49.708+00	2021-11-08 10:20:49.793+00
4774	\N	died	2021-11-08 10:19:15.876+00	\N	\N	2021-11-08 10:20:14.063+00	2021-11-08 10:20:14.205+00
5975	\N	died	2021-11-08 10:20:00.002+00	\N	\N	2021-11-08 10:20:49.782+00	2021-11-08 10:20:49.949+00
6093	\N	died	2021-11-08 10:20:03.56+00	\N	\N	2021-11-08 10:20:53.157+00	2021-11-08 10:20:53.387+00
5980	\N	died	2021-11-08 10:20:00.085+00	\N	\N	2021-11-08 10:20:49.941+00	2021-11-08 10:20:50.246+00
5988	\N	died	2021-11-08 10:20:00.268+00	\N	\N	2021-11-08 10:20:50.135+00	2021-11-08 10:20:50.64+00
6006	\N	died	2021-11-08 10:20:00.754+00	\N	\N	2021-11-08 10:20:50.633+00	2021-11-08 10:20:50.841+00
6097	\N	died	2021-11-08 10:20:03.797+00	\N	\N	2021-11-08 10:20:53.382+00	2021-11-08 10:20:53.567+00
6009	\N	died	2021-11-08 10:20:00.81+00	\N	\N	2021-11-08 10:20:50.69+00	2021-11-08 10:20:51.119+00
6208	\N	died	2021-11-08 10:20:08.21+00	\N	\N	2021-11-08 10:20:56.326+00	2021-11-08 10:20:56.713+00
6019	\N	died	2021-11-08 10:20:00.992+00	\N	\N	2021-11-08 10:20:50.958+00	2021-11-08 10:20:51.42+00
6032	\N	died	2021-11-08 10:20:01.26+00	\N	\N	2021-11-08 10:20:51.318+00	2021-11-08 10:20:51.73+00
6046	\N	died	2021-11-08 10:20:01.509+00	\N	\N	2021-11-08 10:20:51.724+00	2021-11-08 10:20:51.804+00
6222	\N	died	2021-11-08 10:20:08.942+00	\N	\N	2021-11-08 10:20:56.691+00	2021-11-08 10:20:57.208+00
6049	\N	died	2021-11-08 10:20:01.543+00	\N	\N	2021-11-08 10:20:51.799+00	2021-11-08 10:20:51.966+00
6107	\N	died	2021-11-08 10:20:04.209+00	\N	\N	2021-11-08 10:20:53.56+00	2021-11-08 10:20:53.745+00
6111	\N	died	2021-11-08 10:20:04.293+00	\N	\N	2021-11-08 10:20:53.624+00	2021-11-08 10:20:54.163+00
6241	\N	died	2021-11-08 10:20:09.867+00	\N	\N	2021-11-08 10:20:57.193+00	2021-11-08 10:20:57.363+00
6124	\N	died	2021-11-08 10:20:04.626+00	\N	\N	2021-11-08 10:20:54.109+00	2021-11-08 10:20:54.63+00
6143	\N	died	2021-11-08 10:20:05.414+00	\N	\N	2021-11-08 10:20:54.624+00	2021-11-08 10:20:54.83+00
6153	\N	died	2021-11-08 10:20:05.646+00	\N	\N	2021-11-08 10:20:54.79+00	2021-11-08 10:20:55.298+00
6171	\N	died	2021-11-08 10:20:06.26+00	\N	\N	2021-11-08 10:20:55.199+00	2021-11-08 10:20:55.544+00
6184	\N	died	2021-11-08 10:20:07.186+00	\N	\N	2021-11-08 10:20:55.541+00	2021-11-08 10:20:55.695+00
6190	\N	died	2021-11-08 10:20:07.519+00	\N	\N	2021-11-08 10:20:55.692+00	2021-11-08 10:20:56.089+00
6250	\N	died	2021-11-08 10:20:10.061+00	\N	\N	2021-11-08 10:20:57.358+00	2021-11-08 10:20:57.486+00
6253	\N	died	2021-11-08 10:20:10.188+00	\N	\N	2021-11-08 10:20:57.476+00	2021-11-08 10:20:57.531+00
6255	\N	died	2021-11-08 10:20:10.263+00	\N	\N	2021-11-08 10:20:57.518+00	2021-11-08 10:20:57.598+00
6259	\N	died	2021-11-08 10:20:10.328+00	\N	\N	2021-11-08 10:20:57.591+00	2021-11-08 10:20:57.73+00
6263	\N	died	2021-11-08 10:20:10.495+00	\N	\N	2021-11-08 10:20:57.712+00	2021-11-08 10:20:57.89+00
6269	\N	died	2021-11-08 10:20:10.61+00	\N	\N	2021-11-08 10:20:57.884+00	2021-11-08 10:20:58.17+00
4487	\N	died	2021-11-08 10:19:08.26+00	\N	\N	2021-11-08 10:20:04.914+00	2021-11-08 10:20:04.985+00
4474	\N	died	2021-11-08 10:19:08.124+00	\N	\N	2021-11-08 10:20:04.645+00	2021-11-08 10:20:04.985+00
4491	\N	died	2021-11-08 10:19:08.276+00	\N	\N	2021-11-08 10:20:04.978+00	2021-11-08 10:20:05.104+00
4496	\N	died	2021-11-08 10:19:08.288+00	\N	\N	2021-11-08 10:20:05.093+00	2021-11-08 10:20:05.255+00
5888	\N	died	2021-11-08 10:19:57.116+00	\N	\N	2021-11-08 10:20:47.532+00	2021-11-08 10:20:47.73+00
4499	\N	died	2021-11-08 10:19:08.301+00	\N	\N	2021-11-08 10:20:05.248+00	2021-11-08 10:20:05.432+00
6086	\N	died	2021-11-08 10:20:03.077+00	\N	\N	2021-11-08 10:20:53.04+00	2021-11-08 10:20:53.53+00
4504	\N	died	2021-11-08 10:19:08.357+00	\N	\N	2021-11-08 10:20:05.428+00	2021-11-08 10:20:05.499+00
4508	\N	died	2021-11-08 10:19:08.424+00	\N	\N	2021-11-08 10:20:05.495+00	2021-11-08 10:20:05.727+00
5892	\N	died	2021-11-08 10:19:57.292+00	\N	\N	2021-11-08 10:20:47.724+00	2021-11-08 10:20:47.846+00
4511	\N	died	2021-11-08 10:19:08.524+00	\N	\N	2021-11-08 10:20:05.606+00	2021-11-08 10:20:05.956+00
4522	\N	died	2021-11-08 10:19:08.883+00	\N	\N	2021-11-08 10:20:05.897+00	2021-11-08 10:20:06.669+00
4533	\N	died	2021-11-08 10:19:09.199+00	\N	\N	2021-11-08 10:20:06.481+00	2021-11-08 10:20:07.836+00
5898	\N	died	2021-11-08 10:19:57.534+00	\N	\N	2021-11-08 10:20:47.828+00	2021-11-08 10:20:47.99+00
4551	\N	died	2021-11-08 10:19:09.61+00	\N	\N	2021-11-08 10:20:07.478+00	2021-11-08 10:20:08.087+00
4563	\N	died	2021-11-08 10:19:10.417+00	\N	\N	2021-11-08 10:20:08.031+00	2021-11-08 10:20:08.465+00
4578	\N	died	2021-11-08 10:19:11.043+00	\N	\N	2021-11-08 10:20:08.452+00	2021-11-08 10:20:08.705+00
5902	\N	died	2021-11-08 10:19:57.633+00	\N	\N	2021-11-08 10:20:47.982+00	2021-11-08 10:20:48.079+00
4584	\N	died	2021-11-08 10:19:11.159+00	\N	\N	2021-11-08 10:20:08.642+00	2021-11-08 10:20:09.131+00
6104	\N	died	2021-11-08 10:20:04.085+00	\N	\N	2021-11-08 10:20:53.502+00	2021-11-08 10:20:54.163+00
4602	\N	died	2021-11-08 10:19:11.436+00	\N	\N	2021-11-08 10:20:09.127+00	2021-11-08 10:20:09.343+00
4608	\N	died	2021-11-08 10:19:11.517+00	\N	\N	2021-11-08 10:20:09.194+00	2021-11-08 10:20:09.734+00
5905	\N	died	2021-11-08 10:19:57.717+00	\N	\N	2021-11-08 10:20:48.034+00	2021-11-08 10:20:48.291+00
4625	\N	died	2021-11-08 10:19:11.644+00	\N	\N	2021-11-08 10:20:09.692+00	2021-11-08 10:20:10.3+00
4649	\N	died	2021-11-08 10:19:12.325+00	\N	\N	2021-11-08 10:20:10.279+00	2021-11-08 10:20:10.901+00
4671	\N	died	2021-11-08 10:19:13.218+00	\N	\N	2021-11-08 10:20:10.873+00	2021-11-08 10:20:11.676+00
5913	\N	died	2021-11-08 10:19:58.017+00	\N	\N	2021-11-08 10:20:48.265+00	2021-11-08 10:20:48.555+00
4685	\N	died	2021-11-08 10:19:13.727+00	\N	\N	2021-11-08 10:20:11.206+00	2021-11-08 10:20:11.846+00
4697	\N	died	2021-11-08 10:19:14.168+00	\N	\N	2021-11-08 10:20:11.831+00	2021-11-08 10:20:12.307+00
4714	\N	died	2021-11-08 10:19:14.517+00	\N	\N	2021-11-08 10:20:12.272+00	2021-11-08 10:20:12.631+00
5925	\N	died	2021-11-08 10:19:58.292+00	\N	\N	2021-11-08 10:20:48.548+00	2021-11-08 10:20:48.774+00
4730	\N	died	2021-11-08 10:19:14.685+00	\N	\N	2021-11-08 10:20:12.627+00	2021-11-08 10:20:13.034+00
6123	\N	died	2021-11-08 10:20:04.61+00	\N	\N	2021-11-08 10:20:53.992+00	2021-11-08 10:20:54.523+00
4738	\N	died	2021-11-08 10:19:14.993+00	\N	\N	2021-11-08 10:20:12.904+00	2021-11-08 10:20:13.334+00
4753	\N	died	2021-11-08 10:19:15.36+00	\N	\N	2021-11-08 10:20:13.287+00	2021-11-08 10:20:13.816+00
5931	\N	died	2021-11-08 10:19:58.493+00	\N	\N	2021-11-08 10:20:48.656+00	2021-11-08 10:20:49.052+00
4759	\N	died	2021-11-08 10:19:15.56+00	\N	\N	2021-11-08 10:20:13.536+00	2021-11-08 10:20:14.068+00
6252	\N	died	2021-11-08 10:20:10.163+00	\N	\N	2021-11-08 10:20:57.443+00	2021-11-08 10:20:57.754+00
4773	\N	died	2021-11-08 10:19:15.859+00	\N	\N	2021-11-08 10:20:14.046+00	2021-11-08 10:20:14.4+00
4786	\N	died	2021-11-08 10:19:16.049+00	\N	\N	2021-11-08 10:20:14.394+00	2021-11-08 10:20:14.563+00
5945	\N	died	2021-11-08 10:19:59.109+00	\N	\N	2021-11-08 10:20:49.016+00	2021-11-08 10:20:49.488+00
4791	\N	died	2021-11-08 10:19:16.06+00	\N	\N	2021-11-08 10:20:14.545+00	2021-11-08 10:20:14.683+00
4795	\N	died	2021-11-08 10:19:16.102+00	\N	\N	2021-11-08 10:20:14.666+00	2021-11-08 10:20:14.944+00
4803	\N	died	2021-11-08 10:19:16.198+00	\N	\N	2021-11-08 10:20:14.928+00	2021-11-08 10:20:15.193+00
5963	\N	died	2021-11-08 10:19:59.726+00	\N	\N	2021-11-08 10:20:49.442+00	2021-11-08 10:20:50.005+00
4805	\N	died	2021-11-08 10:19:16.228+00	\N	\N	2021-11-08 10:20:15.178+00	2021-11-08 10:20:15.592+00
6138	\N	died	2021-11-08 10:20:05.058+00	\N	\N	2021-11-08 10:20:54.503+00	2021-11-08 10:20:54.646+00
4807	\N	died	2021-11-08 10:19:16.277+00	\N	\N	2021-11-08 10:20:15.587+00	2021-11-08 10:20:15.683+00
4812	\N	died	2021-11-08 10:19:16.395+00	\N	\N	2021-11-08 10:20:15.676+00	2021-11-08 10:20:15.853+00
5981	\N	died	2021-11-08 10:20:00.102+00	\N	\N	2021-11-08 10:20:49.957+00	2021-11-08 10:20:50.265+00
4816	\N	died	2021-11-08 10:19:16.618+00	\N	\N	2021-11-08 10:20:15.845+00	2021-11-08 10:20:16.088+00
4824	\N	died	2021-11-08 10:19:16.818+00	\N	\N	2021-11-08 10:20:16.071+00	2021-11-08 10:20:16.132+00
4826	\N	died	2021-11-08 10:19:16.877+00	\N	\N	2021-11-08 10:20:16.125+00	2021-11-08 10:20:16.179+00
5992	\N	died	2021-11-08 10:20:00.351+00	\N	\N	2021-11-08 10:20:50.258+00	2021-11-08 10:20:50.366+00
4828	\N	died	2021-11-08 10:19:16.897+00	\N	\N	2021-11-08 10:20:16.174+00	2021-11-08 10:20:16.391+00
4832	\N	died	2021-11-08 10:19:17.014+00	\N	\N	2021-11-08 10:20:16.373+00	2021-11-08 10:20:16.593+00
4836	\N	died	2021-11-08 10:19:17.111+00	\N	\N	2021-11-08 10:20:16.589+00	2021-11-08 10:20:16.817+00
5995	\N	died	2021-11-08 10:20:00.45+00	\N	\N	2021-11-08 10:20:50.324+00	2021-11-08 10:20:50.625+00
4838	\N	died	2021-11-08 10:19:17.3+00	\N	\N	2021-11-08 10:20:16.794+00	2021-11-08 10:20:17.019+00
6144	\N	died	2021-11-08 10:20:05.427+00	\N	\N	2021-11-08 10:20:54.641+00	2021-11-08 10:20:54.83+00
6004	\N	died	2021-11-08 10:20:00.584+00	\N	\N	2021-11-08 10:20:50.599+00	2021-11-08 10:20:51.119+00
6020	\N	died	2021-11-08 10:20:01.025+00	\N	\N	2021-11-08 10:20:50.974+00	2021-11-08 10:20:51.503+00
6036	\N	died	2021-11-08 10:20:01.309+00	\N	\N	2021-11-08 10:20:51.484+00	2021-11-08 10:20:51.804+00
6154	\N	died	2021-11-08 10:20:05.662+00	\N	\N	2021-11-08 10:20:54.807+00	2021-11-08 10:20:55.298+00
6048	\N	died	2021-11-08 10:20:01.526+00	\N	\N	2021-11-08 10:20:51.775+00	2021-11-08 10:20:52.005+00
6264	\N	died	2021-11-08 10:20:10.529+00	\N	\N	2021-11-08 10:20:57.747+00	2021-11-08 10:20:58.17+00
6055	\N	died	2021-11-08 10:20:01.61+00	\N	\N	2021-11-08 10:20:51.979+00	2021-11-08 10:20:52.354+00
6065	\N	died	2021-11-08 10:20:01.842+00	\N	\N	2021-11-08 10:20:52.266+00	2021-11-08 10:20:52.42+00
6173	\N	died	2021-11-08 10:20:06.477+00	\N	\N	2021-11-08 10:20:55.236+00	2021-11-08 10:20:56.089+00
6071	\N	died	2021-11-08 10:20:02.201+00	\N	\N	2021-11-08 10:20:52.401+00	2021-11-08 10:20:52.595+00
6076	\N	died	2021-11-08 10:20:02.41+00	\N	\N	2021-11-08 10:20:52.585+00	2021-11-08 10:20:53.077+00
6274	\N	died	2021-11-08 10:20:10.787+00	\N	\N	2021-11-08 10:20:58.108+00	2021-11-08 10:20:58.679+00
6193	\N	died	2021-11-08 10:20:07.632+00	\N	\N	2021-11-08 10:20:55.893+00	2021-11-08 10:20:56.233+00
6205	\N	died	2021-11-08 10:20:08.155+00	\N	\N	2021-11-08 10:20:56.223+00	2021-11-08 10:20:56.523+00
6213	\N	died	2021-11-08 10:20:08.449+00	\N	\N	2021-11-08 10:20:56.44+00	2021-11-08 10:20:56.815+00
6228	\N	died	2021-11-08 10:20:09.358+00	\N	\N	2021-11-08 10:20:56.808+00	2021-11-08 10:20:57.021+00
6235	\N	died	2021-11-08 10:20:09.678+00	\N	\N	2021-11-08 10:20:57.016+00	2021-11-08 10:20:57.085+00
6238	\N	died	2021-11-08 10:20:09.76+00	\N	\N	2021-11-08 10:20:57.068+00	2021-11-08 10:20:57.234+00
6242	\N	died	2021-11-08 10:20:09.904+00	\N	\N	2021-11-08 10:20:57.225+00	2021-11-08 10:20:57.486+00
6291	\N	died	2021-11-08 10:20:11.177+00	\N	\N	2021-11-08 10:20:58.662+00	2021-11-08 10:20:58.857+00
6298	\N	died	2021-11-08 10:20:11.739+00	\N	\N	2021-11-08 10:20:58.843+00	2021-11-08 10:20:58.933+00
6300	\N	died	2021-11-08 10:20:11.764+00	\N	\N	2021-11-08 10:20:58.918+00	2021-11-08 10:20:59.021+00
6305	\N	died	2021-11-08 10:20:11.861+00	\N	\N	2021-11-08 10:20:59.016+00	2021-11-08 10:20:59.088+00
6309	\N	died	2021-11-08 10:20:12.024+00	\N	\N	2021-11-08 10:20:59.083+00	2021-11-08 10:20:59.202+00
6315	\N	died	2021-11-08 10:20:12.187+00	\N	\N	2021-11-08 10:20:59.185+00	2021-11-08 10:20:59.359+00
6319	\N	died	2021-11-08 10:20:12.322+00	\N	\N	2021-11-08 10:20:59.35+00	2021-11-08 10:20:59.447+00
5914	\N	died	2021-11-08 10:19:58.034+00	\N	\N	2021-11-08 10:20:48.282+00	2021-11-08 10:20:48.355+00
4490	\N	died	2021-11-08 10:19:08.271+00	\N	\N	2021-11-08 10:20:04.96+00	2021-11-08 10:20:05.432+00
4502	\N	died	2021-11-08 10:19:08.324+00	\N	\N	2021-11-08 10:20:05.397+00	2021-11-08 10:20:05.589+00
4510	\N	died	2021-11-08 10:19:08.508+00	\N	\N	2021-11-08 10:20:05.576+00	2021-11-08 10:20:05.776+00
5918	\N	died	2021-11-08 10:19:58.158+00	\N	\N	2021-11-08 10:20:48.35+00	2021-11-08 10:20:48.537+00
4518	\N	died	2021-11-08 10:19:08.768+00	\N	\N	2021-11-08 10:20:05.734+00	2021-11-08 10:20:06.063+00
4526	\N	died	2021-11-08 10:19:08.982+00	\N	\N	2021-11-08 10:20:06.032+00	2021-11-08 10:20:07.033+00
4541	\N	died	2021-11-08 10:19:09.351+00	\N	\N	2021-11-08 10:20:07.018+00	2021-11-08 10:20:07.256+00
5924	\N	died	2021-11-08 10:19:58.276+00	\N	\N	2021-11-08 10:20:48.532+00	2021-11-08 10:20:48.774+00
4546	\N	died	2021-11-08 10:19:09.49+00	\N	\N	2021-11-08 10:20:07.24+00	2021-11-08 10:20:07.836+00
4550	\N	died	2021-11-08 10:19:09.608+00	\N	\N	2021-11-08 10:20:07.422+00	2021-11-08 10:20:07.958+00
4561	\N	died	2021-11-08 10:19:10.349+00	\N	\N	2021-11-08 10:20:07.943+00	2021-11-08 10:20:08.184+00
5930	\N	died	2021-11-08 10:19:58.476+00	\N	\N	2021-11-08 10:20:48.64+00	2021-11-08 10:20:49.052+00
4566	\N	died	2021-11-08 10:19:10.574+00	\N	\N	2021-11-08 10:20:08.131+00	2021-11-08 10:20:08.705+00
6156	\N	died	2021-11-08 10:20:05.686+00	\N	\N	2021-11-08 10:20:54.843+00	2021-11-08 10:20:54.903+00
4581	\N	died	2021-11-08 10:19:11.078+00	\N	\N	2021-11-08 10:20:08.557+00	2021-11-08 10:20:08.892+00
4591	\N	died	2021-11-08 10:19:11.386+00	\N	\N	2021-11-08 10:20:08.869+00	2021-11-08 10:20:09.343+00
5941	\N	died	2021-11-08 10:19:58.968+00	\N	\N	2021-11-08 10:20:48.89+00	2021-11-08 10:20:49.213+00
4606	\N	died	2021-11-08 10:19:11.448+00	\N	\N	2021-11-08 10:20:09.168+00	2021-11-08 10:20:09.504+00
4617	\N	died	2021-11-08 10:19:11.569+00	\N	\N	2021-11-08 10:20:09.486+00	2021-11-08 10:20:09.884+00
4631	\N	died	2021-11-08 10:19:11.8+00	\N	\N	2021-11-08 10:20:09.794+00	2021-11-08 10:20:10.3+00
5951	\N	died	2021-11-08 10:19:59.377+00	\N	\N	2021-11-08 10:20:49.149+00	2021-11-08 10:20:49.698+00
4645	\N	died	2021-11-08 10:19:12.268+00	\N	\N	2021-11-08 10:20:10.19+00	2021-11-08 10:20:10.616+00
4661	\N	died	2021-11-08 10:19:12.85+00	\N	\N	2021-11-08 10:20:10.611+00	2021-11-08 10:20:10.901+00
4670	\N	died	2021-11-08 10:19:13.183+00	\N	\N	2021-11-08 10:20:10.85+00	2021-11-08 10:20:11.035+00
5965	\N	died	2021-11-08 10:19:59.759+00	\N	\N	2021-11-08 10:20:49.499+00	2021-11-08 10:20:50.246+00
4677	\N	died	2021-11-08 10:19:13.435+00	\N	\N	2021-11-08 10:20:10.977+00	2021-11-08 10:20:11.747+00
6159	\N	died	2021-11-08 10:20:05.753+00	\N	\N	2021-11-08 10:20:54.883+00	2021-11-08 10:20:55.16+00
4692	\N	died	2021-11-08 10:19:13.934+00	\N	\N	2021-11-08 10:20:11.74+00	2021-11-08 10:20:12.068+00
4700	\N	died	2021-11-08 10:19:14.202+00	\N	\N	2021-11-08 10:20:11.878+00	2021-11-08 10:20:12.245+00
5983	\N	died	2021-11-08 10:20:00.184+00	\N	\N	2021-11-08 10:20:50.016+00	2021-11-08 10:20:50.308+00
4712	\N	died	2021-11-08 10:19:14.512+00	\N	\N	2021-11-08 10:20:12.238+00	2021-11-08 10:20:12.449+00
6296	\N	died	2021-11-08 10:20:11.669+00	\N	\N	2021-11-08 10:20:58.776+00	2021-11-08 10:20:59.202+00
4719	\N	died	2021-11-08 10:19:14.529+00	\N	\N	2021-11-08 10:20:12.389+00	2021-11-08 10:20:13.034+00
4737	\N	died	2021-11-08 10:19:14.96+00	\N	\N	2021-11-08 10:20:12.815+00	2021-11-08 10:20:13.271+00
5994	\N	died	2021-11-08 10:20:00.434+00	\N	\N	2021-11-08 10:20:50.293+00	2021-11-08 10:20:50.512+00
4751	\N	died	2021-11-08 10:19:15.325+00	\N	\N	2021-11-08 10:20:13.249+00	2021-11-08 10:20:13.816+00
4764	\N	died	2021-11-08 10:19:15.643+00	\N	\N	2021-11-08 10:20:13.788+00	2021-11-08 10:20:14.382+00
4783	\N	died	2021-11-08 10:19:16.028+00	\N	\N	2021-11-08 10:20:14.344+00	2021-11-08 10:20:14.683+00
5998	\N	died	2021-11-08 10:20:00.484+00	\N	\N	2021-11-08 10:20:50.41+00	2021-11-08 10:20:50.684+00
4794	\N	died	2021-11-08 10:19:16.086+00	\N	\N	2021-11-08 10:20:14.632+00	2021-11-08 10:20:15.778+00
6166	\N	died	2021-11-08 10:20:06.03+00	\N	\N	2021-11-08 10:20:55.042+00	2021-11-08 10:20:55.469+00
4813	\N	died	2021-11-08 10:19:16.46+00	\N	\N	2021-11-08 10:20:15.765+00	2021-11-08 10:20:16.088+00
4822	\N	died	2021-11-08 10:19:16.751+00	\N	\N	2021-11-08 10:20:15.972+00	2021-11-08 10:20:16.817+00
6008	\N	died	2021-11-08 10:20:00.794+00	\N	\N	2021-11-08 10:20:50.669+00	2021-11-08 10:20:50.921+00
4841	\N	died	2021-11-08 10:19:17.37+00	\N	\N	2021-11-08 10:20:16.823+00	2021-11-08 10:20:17.306+00
4859	\N	died	2021-11-08 10:19:18.293+00	\N	\N	2021-11-08 10:20:17.299+00	2021-11-08 10:20:17.599+00
4869	\N	died	2021-11-08 10:19:18.869+00	\N	\N	2021-11-08 10:20:17.58+00	2021-11-08 10:20:17.665+00
6015	\N	died	2021-11-08 10:20:00.893+00	\N	\N	2021-11-08 10:20:50.884+00	2021-11-08 10:20:51.42+00
4871	\N	died	2021-11-08 10:19:18.985+00	\N	\N	2021-11-08 10:20:17.657+00	2021-11-08 10:20:17.73+00
4874	\N	died	2021-11-08 10:19:19.185+00	\N	\N	2021-11-08 10:20:17.723+00	2021-11-08 10:20:17.858+00
4878	\N	died	2021-11-08 10:19:19.411+00	\N	\N	2021-11-08 10:20:17.851+00	2021-11-08 10:20:18.207+00
6030	\N	died	2021-11-08 10:20:01.226+00	\N	\N	2021-11-08 10:20:51.262+00	2021-11-08 10:20:51.709+00
4881	\N	died	2021-11-08 10:19:19.586+00	\N	\N	2021-11-08 10:20:18.19+00	2021-11-08 10:20:18.547+00
6177	\N	died	2021-11-08 10:20:06.802+00	\N	\N	2021-11-08 10:20:55.327+00	2021-11-08 10:20:55.695+00
4887	\N	died	2021-11-08 10:19:20.011+00	\N	\N	2021-11-08 10:20:18.541+00	2021-11-08 10:20:18.719+00
6039	\N	died	2021-11-08 10:20:01.359+00	\N	\N	2021-11-08 10:20:51.524+00	2021-11-08 10:20:51.872+00
4891	\N	died	2021-11-08 10:19:20.107+00	\N	\N	2021-11-08 10:20:18.715+00	2021-11-08 10:20:18.946+00
6052	\N	died	2021-11-08 10:20:01.577+00	\N	\N	2021-11-08 10:20:51.866+00	2021-11-08 10:20:52.248+00
6061	\N	died	2021-11-08 10:20:01.76+00	\N	\N	2021-11-08 10:20:52.099+00	2021-11-08 10:20:53.077+00
6187	\N	died	2021-11-08 10:20:07.295+00	\N	\N	2021-11-08 10:20:55.653+00	2021-11-08 10:20:56.106+00
6081	\N	died	2021-11-08 10:20:02.693+00	\N	\N	2021-11-08 10:20:52.911+00	2021-11-08 10:20:53.237+00
6312	\N	died	2021-11-08 10:20:12.114+00	\N	\N	2021-11-08 10:20:59.133+00	2021-11-08 10:20:59.464+00
6094	\N	died	2021-11-08 10:20:03.626+00	\N	\N	2021-11-08 10:20:53.218+00	2021-11-08 10:20:53.53+00
6099	\N	died	2021-11-08 10:20:03.949+00	\N	\N	2021-11-08 10:20:53.417+00	2021-11-08 10:20:53.745+00
6199	\N	died	2021-11-08 10:20:07.941+00	\N	\N	2021-11-08 10:20:56.099+00	2021-11-08 10:20:56.205+00
6112	\N	died	2021-11-08 10:20:04.385+00	\N	\N	2021-11-08 10:20:53.64+00	2021-11-08 10:20:54.357+00
6131	\N	died	2021-11-08 10:20:04.826+00	\N	\N	2021-11-08 10:20:54.35+00	2021-11-08 10:20:54.484+00
6135	\N	died	2021-11-08 10:20:04.943+00	\N	\N	2021-11-08 10:20:54.433+00	2021-11-08 10:20:54.679+00
6325	\N	died	2021-11-08 10:20:12.47+00	\N	\N	2021-11-08 10:20:59.458+00	2021-11-08 10:20:59.672+00
6146	\N	died	2021-11-08 10:20:05.461+00	\N	\N	2021-11-08 10:20:54.674+00	2021-11-08 10:20:54.848+00
6202	\N	died	2021-11-08 10:20:08.069+00	\N	\N	2021-11-08 10:20:56.149+00	2021-11-08 10:20:56.523+00
6215	\N	died	2021-11-08 10:20:08.59+00	\N	\N	2021-11-08 10:20:56.457+00	2021-11-08 10:20:57.021+00
6332	\N	died	2021-11-08 10:20:12.626+00	\N	\N	2021-11-08 10:20:59.607+00	2021-11-08 10:21:00.038+00
6232	\N	died	2021-11-08 10:20:09.607+00	\N	\N	2021-11-08 10:20:56.942+00	2021-11-08 10:20:57.363+00
6247	\N	died	2021-11-08 10:20:10.011+00	\N	\N	2021-11-08 10:20:57.307+00	2021-11-08 10:20:57.89+00
6266	\N	died	2021-11-08 10:20:10.561+00	\N	\N	2021-11-08 10:20:57.783+00	2021-11-08 10:20:58.422+00
6283	\N	died	2021-11-08 10:20:10.96+00	\N	\N	2021-11-08 10:20:58.416+00	2021-11-08 10:20:58.644+00
6290	\N	died	2021-11-08 10:20:11.103+00	\N	\N	2021-11-08 10:20:58.628+00	2021-11-08 10:20:58.857+00
6349	\N	died	2021-11-08 10:20:13.062+00	\N	\N	2021-11-08 10:21:00.033+00	2021-11-08 10:21:00.58+00
6359	\N	died	2021-11-08 10:20:13.369+00	\N	\N	2021-11-08 10:21:00.575+00	2021-11-08 10:21:00.637+00
6361	\N	died	2021-11-08 10:20:13.413+00	\N	\N	2021-11-08 10:21:00.626+00	2021-11-08 10:21:00.67+00
6363	\N	died	2021-11-08 10:20:13.463+00	\N	\N	2021-11-08 10:21:00.666+00	2021-11-08 10:21:00.738+00
6367	\N	died	2021-11-08 10:20:13.717+00	\N	\N	2021-11-08 10:21:00.733+00	2021-11-08 10:21:00.834+00
6371	\N	died	2021-11-08 10:20:13.86+00	\N	\N	2021-11-08 10:21:00.827+00	2021-11-08 10:21:00.951+00
6374	\N	died	2021-11-08 10:20:13.993+00	\N	\N	2021-11-08 10:21:00.943+00	2021-11-08 10:21:01.029+00
4473	\N	died	2021-11-08 10:19:08.09+00	\N	\N	2021-11-08 10:20:04.627+00	2021-11-08 10:20:05.104+00
4493	\N	died	2021-11-08 10:19:08.282+00	\N	\N	2021-11-08 10:20:05.009+00	2021-11-08 10:20:05.727+00
5946	\N	died	2021-11-08 10:19:59.167+00	\N	\N	2021-11-08 10:20:49.041+00	2021-11-08 10:20:49.115+00
4516	\N	died	2021-11-08 10:19:08.753+00	\N	\N	2021-11-08 10:20:05.703+00	2021-11-08 10:20:06.689+00
4536	\N	died	2021-11-08 10:19:09.25+00	\N	\N	2021-11-08 10:20:06.685+00	2021-11-08 10:20:07.204+00
4542	\N	died	2021-11-08 10:19:09.366+00	\N	\N	2021-11-08 10:20:07.061+00	2021-11-08 10:20:07.836+00
5949	\N	died	2021-11-08 10:19:59.31+00	\N	\N	2021-11-08 10:20:49.107+00	2021-11-08 10:20:49.213+00
4552	\N	died	2021-11-08 10:19:09.683+00	\N	\N	2021-11-08 10:20:07.522+00	2021-11-08 10:20:08.184+00
6239	\N	died	2021-11-08 10:20:09.778+00	\N	\N	2021-11-08 10:20:57.1+00	2021-11-08 10:20:57.363+00
4565	\N	died	2021-11-08 10:19:10.475+00	\N	\N	2021-11-08 10:20:08.109+00	2021-11-08 10:20:08.43+00
4576	\N	died	2021-11-08 10:19:10.959+00	\N	\N	2021-11-08 10:20:08.325+00	2021-11-08 10:20:08.904+00
5954	\N	died	2021-11-08 10:19:59.492+00	\N	\N	2021-11-08 10:20:49.207+00	2021-11-08 10:20:49.395+00
4593	\N	died	2021-11-08 10:19:11.403+00	\N	\N	2021-11-08 10:20:08.9+00	2021-11-08 10:20:09.12+00
4599	\N	died	2021-11-08 10:19:11.431+00	\N	\N	2021-11-08 10:20:09.069+00	2021-11-08 10:20:09.47+00
4615	\N	died	2021-11-08 10:19:11.562+00	\N	\N	2021-11-08 10:20:09.45+00	2021-11-08 10:20:09.734+00
5958	\N	died	2021-11-08 10:19:59.593+00	\N	\N	2021-11-08 10:20:49.357+00	2021-11-08 10:20:49.698+00
4626	\N	died	2021-11-08 10:19:11.675+00	\N	\N	2021-11-08 10:20:09.711+00	2021-11-08 10:20:10.316+00
4651	\N	died	2021-11-08 10:19:12.359+00	\N	\N	2021-11-08 10:20:10.311+00	2021-11-08 10:20:10.504+00
4655	\N	died	2021-11-08 10:19:12.534+00	\N	\N	2021-11-08 10:20:10.472+00	2021-11-08 10:20:10.819+00
5970	\N	died	2021-11-08 10:19:59.859+00	\N	\N	2021-11-08 10:20:49.666+00	2021-11-08 10:20:50.246+00
4662	\N	died	2021-11-08 10:19:12.935+00	\N	\N	2021-11-08 10:20:10.627+00	2021-11-08 10:20:10.931+00
6246	\N	died	2021-11-08 10:20:09.995+00	\N	\N	2021-11-08 10:20:57.293+00	2021-11-08 10:20:57.618+00
4673	\N	died	2021-11-08 10:19:13.284+00	\N	\N	2021-11-08 10:20:10.911+00	2021-11-08 10:20:11.093+00
4681	\N	died	2021-11-08 10:19:13.567+00	\N	\N	2021-11-08 10:20:11.07+00	2021-11-08 10:20:11.689+00
5989	\N	died	2021-11-08 10:20:00.284+00	\N	\N	2021-11-08 10:20:50.207+00	2021-11-08 10:20:50.841+00
4690	\N	died	2021-11-08 10:19:13.903+00	\N	\N	2021-11-08 10:20:11.685+00	2021-11-08 10:20:11.846+00
4696	\N	died	2021-11-08 10:19:14.15+00	\N	\N	2021-11-08 10:20:11.811+00	2021-11-08 10:20:12.225+00
4710	\N	died	2021-11-08 10:19:14.506+00	\N	\N	2021-11-08 10:20:12.205+00	2021-11-08 10:20:12.465+00
6010	\N	died	2021-11-08 10:20:00.811+00	\N	\N	2021-11-08 10:20:50.709+00	2021-11-08 10:20:51.119+00
4723	\N	died	2021-11-08 10:19:14.541+00	\N	\N	2021-11-08 10:20:12.46+00	2021-11-08 10:20:12.582+00
4727	\N	died	2021-11-08 10:19:14.659+00	\N	\N	2021-11-08 10:20:12.578+00	2021-11-08 10:20:12.698+00
4733	\N	died	2021-11-08 10:19:14.726+00	\N	\N	2021-11-08 10:20:12.679+00	2021-11-08 10:20:13.082+00
6022	\N	died	2021-11-08 10:20:01.059+00	\N	\N	2021-11-08 10:20:51.076+00	2021-11-08 10:20:51.709+00
4745	\N	died	2021-11-08 10:19:15.21+00	\N	\N	2021-11-08 10:20:13.079+00	2021-11-08 10:20:13.271+00
6260	\N	died	2021-11-08 10:20:10.345+00	\N	\N	2021-11-08 10:20:57.61+00	2021-11-08 10:20:57.89+00
4750	\N	died	2021-11-08 10:19:15.31+00	\N	\N	2021-11-08 10:20:13.221+00	2021-11-08 10:20:13.816+00
4762	\N	died	2021-11-08 10:19:15.61+00	\N	\N	2021-11-08 10:20:13.721+00	2021-11-08 10:20:14.205+00
6040	\N	died	2021-11-08 10:20:01.376+00	\N	\N	2021-11-08 10:20:51.54+00	2021-11-08 10:20:51.966+00
4779	\N	died	2021-11-08 10:19:15.993+00	\N	\N	2021-11-08 10:20:14.17+00	2021-11-08 10:20:14.944+00
4798	\N	died	2021-11-08 10:19:16.151+00	\N	\N	2021-11-08 10:20:14.758+00	2021-11-08 10:20:15.683+00
4811	\N	died	2021-11-08 10:19:16.393+00	\N	\N	2021-11-08 10:20:15.663+00	2021-11-08 10:20:16.088+00
6054	\N	died	2021-11-08 10:20:01.595+00	\N	\N	2021-11-08 10:20:51.957+00	2021-11-08 10:20:52.248+00
4823	\N	died	2021-11-08 10:19:16.801+00	\N	\N	2021-11-08 10:20:15.989+00	2021-11-08 10:20:16.89+00
4843	\N	died	2021-11-08 10:19:17.437+00	\N	\N	2021-11-08 10:20:16.845+00	2021-11-08 10:20:17.345+00
4861	\N	died	2021-11-08 10:19:18.41+00	\N	\N	2021-11-08 10:20:17.339+00	2021-11-08 10:20:17.642+00
6063	\N	died	2021-11-08 10:20:01.792+00	\N	\N	2021-11-08 10:20:52.143+00	2021-11-08 10:20:53.077+00
4870	\N	died	2021-11-08 10:19:18.902+00	\N	\N	2021-11-08 10:20:17.63+00	2021-11-08 10:20:17.73+00
6267	\N	died	2021-11-08 10:20:10.578+00	\N	\N	2021-11-08 10:20:57.809+00	2021-11-08 10:20:58.644+00
4873	\N	died	2021-11-08 10:19:19.135+00	\N	\N	2021-11-08 10:20:17.699+00	2021-11-08 10:20:18.207+00
4880	\N	died	2021-11-08 10:19:19.535+00	\N	\N	2021-11-08 10:20:18.074+00	2021-11-08 10:20:18.719+00
6085	\N	died	2021-11-08 10:20:03.026+00	\N	\N	2021-11-08 10:20:53.024+00	2021-11-08 10:20:53.53+00
4890	\N	died	2021-11-08 10:19:20.102+00	\N	\N	2021-11-08 10:20:18.646+00	2021-11-08 10:20:19.296+00
4904	\N	died	2021-11-08 10:19:20.593+00	\N	\N	2021-11-08 10:20:19.282+00	2021-11-08 10:20:19.584+00
4911	\N	died	2021-11-08 10:19:20.904+00	\N	\N	2021-11-08 10:20:19.572+00	2021-11-08 10:20:19.645+00
6102	\N	died	2021-11-08 10:20:04.018+00	\N	\N	2021-11-08 10:20:53.468+00	2021-11-08 10:20:53.847+00
4913	\N	died	2021-11-08 10:19:20.969+00	\N	\N	2021-11-08 10:20:19.633+00	2021-11-08 10:20:19.887+00
4918	\N	died	2021-11-08 10:19:21.21+00	\N	\N	2021-11-08 10:20:19.882+00	2021-11-08 10:20:20.205+00
6116	\N	died	2021-11-08 10:20:04.476+00	\N	\N	2021-11-08 10:20:53.827+00	2021-11-08 10:20:54.332+00
6287	\N	died	2021-11-08 10:20:11.049+00	\N	\N	2021-11-08 10:20:58.514+00	2021-11-08 10:20:58.899+00
6129	\N	died	2021-11-08 10:20:04.709+00	\N	\N	2021-11-08 10:20:54.292+00	2021-11-08 10:20:54.83+00
6147	\N	died	2021-11-08 10:20:05.478+00	\N	\N	2021-11-08 10:20:54.69+00	2021-11-08 10:20:54.877+00
6158	\N	died	2021-11-08 10:20:05.719+00	\N	\N	2021-11-08 10:20:54.874+00	2021-11-08 10:20:55.012+00
6299	\N	died	2021-11-08 10:20:11.762+00	\N	\N	2021-11-08 10:20:58.885+00	2021-11-08 10:20:59.021+00
6162	\N	died	2021-11-08 10:20:05.889+00	\N	\N	2021-11-08 10:20:54.935+00	2021-11-08 10:20:55.298+00
6174	\N	died	2021-11-08 10:20:06.528+00	\N	\N	2021-11-08 10:20:55.268+00	2021-11-08 10:20:56.089+00
6197	\N	died	2021-11-08 10:20:07.858+00	\N	\N	2021-11-08 10:20:56.051+00	2021-11-08 10:20:56.523+00
6212	\N	died	2021-11-08 10:20:08.322+00	\N	\N	2021-11-08 10:20:56.432+00	2021-11-08 10:20:56.798+00
6226	\N	died	2021-11-08 10:20:09.193+00	\N	\N	2021-11-08 10:20:56.774+00	2021-11-08 10:20:57.107+00
6303	\N	died	2021-11-08 10:20:11.811+00	\N	\N	2021-11-08 10:20:58.983+00	2021-11-08 10:20:59.318+00
6316	\N	died	2021-11-08 10:20:12.204+00	\N	\N	2021-11-08 10:20:59.22+00	2021-11-08 10:20:59.672+00
6333	\N	died	2021-11-08 10:20:12.644+00	\N	\N	2021-11-08 10:20:59.633+00	2021-11-08 10:21:00.58+00
6352	\N	died	2021-11-08 10:20:13.094+00	\N	\N	2021-11-08 10:21:00.313+00	2021-11-08 10:21:00.738+00
6366	\N	died	2021-11-08 10:20:13.675+00	\N	\N	2021-11-08 10:21:00.716+00	2021-11-08 10:21:00.951+00
6373	\N	died	2021-11-08 10:20:13.903+00	\N	\N	2021-11-08 10:21:00.911+00	2021-11-08 10:21:01.063+00
6383	\N	died	2021-11-08 10:20:14.362+00	\N	\N	2021-11-08 10:21:01.059+00	2021-11-08 10:21:01.261+00
6390	\N	died	2021-11-08 10:20:14.756+00	\N	\N	2021-11-08 10:21:01.248+00	2021-11-08 10:21:01.37+00
6394	\N	died	2021-11-08 10:20:14.97+00	\N	\N	2021-11-08 10:21:01.36+00	2021-11-08 10:21:01.474+00
6399	\N	died	2021-11-08 10:20:15.621+00	\N	\N	2021-11-08 10:21:01.46+00	2021-11-08 10:21:01.689+00
4475	\N	died	2021-11-08 10:19:08.14+00	\N	\N	2021-11-08 10:20:04.661+00	2021-11-08 10:20:05.104+00
5964	\N	died	2021-11-08 10:19:59.745+00	\N	\N	2021-11-08 10:20:49.476+00	2021-11-08 10:20:49.698+00
4495	\N	died	2021-11-08 10:19:08.288+00	\N	\N	2021-11-08 10:20:05.062+00	2021-11-08 10:20:05.727+00
4512	\N	died	2021-11-08 10:19:08.54+00	\N	\N	2021-11-08 10:20:05.63+00	2021-11-08 10:20:06.063+00
4524	\N	died	2021-11-08 10:19:08.901+00	\N	\N	2021-11-08 10:20:05.969+00	2021-11-08 10:20:06.82+00
5971	\N	died	2021-11-08 10:19:59.876+00	\N	\N	2021-11-08 10:20:49.691+00	2021-11-08 10:20:49.737+00
4537	\N	died	2021-11-08 10:19:09.266+00	\N	\N	2021-11-08 10:20:06.805+00	2021-11-08 10:20:07.204+00
6218	\N	died	2021-11-08 10:20:08.721+00	\N	\N	2021-11-08 10:20:56.541+00	2021-11-08 10:20:56.713+00
4544	\N	died	2021-11-08 10:19:09.457+00	\N	\N	2021-11-08 10:20:07.143+00	2021-11-08 10:20:07.836+00
4557	\N	died	2021-11-08 10:19:10.183+00	\N	\N	2021-11-08 10:20:07.778+00	2021-11-08 10:20:08.252+00
5973	\N	died	2021-11-08 10:19:59.967+00	\N	\N	2021-11-08 10:20:49.732+00	2021-11-08 10:20:49.912+00
4571	\N	died	2021-11-08 10:19:10.875+00	\N	\N	2021-11-08 10:20:08.229+00	2021-11-08 10:20:08.84+00
6346	\N	died	2021-11-08 10:20:12.983+00	\N	\N	2021-11-08 10:20:59.985+00	2021-11-08 10:21:00.58+00
4587	\N	died	2021-11-08 10:19:11.301+00	\N	\N	2021-11-08 10:20:08.723+00	2021-11-08 10:20:08.959+00
4594	\N	died	2021-11-08 10:19:11.405+00	\N	\N	2021-11-08 10:20:08.917+00	2021-11-08 10:20:09.162+00
5976	\N	died	2021-11-08 10:20:00.018+00	\N	\N	2021-11-08 10:20:49.809+00	2021-11-08 10:20:50.246+00
4603	\N	died	2021-11-08 10:19:11.439+00	\N	\N	2021-11-08 10:20:09.141+00	2021-11-08 10:20:09.541+00
4619	\N	died	2021-11-08 10:19:11.571+00	\N	\N	2021-11-08 10:20:09.519+00	2021-11-08 10:20:09.884+00
4629	\N	died	2021-11-08 10:19:11.768+00	\N	\N	2021-11-08 10:20:09.761+00	2021-11-08 10:20:10.034+00
5986	\N	died	2021-11-08 10:20:00.252+00	\N	\N	2021-11-08 10:20:50.093+00	2021-11-08 10:20:50.625+00
4639	\N	died	2021-11-08 10:19:12.051+00	\N	\N	2021-11-08 10:20:10.012+00	2021-11-08 10:20:10.351+00
6221	\N	died	2021-11-08 10:20:08.886+00	\N	\N	2021-11-08 10:20:56.675+00	2021-11-08 10:20:56.832+00
4652	\N	died	2021-11-08 10:19:12.393+00	\N	\N	2021-11-08 10:20:10.329+00	2021-11-08 10:20:10.582+00
4659	\N	died	2021-11-08 10:19:12.784+00	\N	\N	2021-11-08 10:20:10.579+00	2021-11-08 10:20:10.819+00
6001	\N	died	2021-11-08 10:20:00.534+00	\N	\N	2021-11-08 10:20:50.523+00	2021-11-08 10:20:50.921+00
4664	\N	died	2021-11-08 10:19:13+00	\N	\N	2021-11-08 10:20:10.662+00	2021-11-08 10:20:11.035+00
6395	\N	died	2021-11-08 10:20:15.175+00	\N	\N	2021-11-08 10:21:01.375+00	2021-11-08 10:21:01.745+00
4678	\N	died	2021-11-08 10:19:13.468+00	\N	\N	2021-11-08 10:20:10.994+00	2021-11-08 10:20:11.846+00
4694	\N	died	2021-11-08 10:19:14.034+00	\N	\N	2021-11-08 10:20:11.779+00	2021-11-08 10:20:12.102+00
6014	\N	died	2021-11-08 10:20:00.877+00	\N	\N	2021-11-08 10:20:50.865+00	2021-11-08 10:20:51.19+00
4705	\N	died	2021-11-08 10:19:14.419+00	\N	\N	2021-11-08 10:20:12.091+00	2021-11-08 10:20:12.225+00
4709	\N	died	2021-11-08 10:19:14.502+00	\N	\N	2021-11-08 10:20:12.189+00	2021-11-08 10:20:12.449+00
4721	\N	died	2021-11-08 10:19:14.532+00	\N	\N	2021-11-08 10:20:12.426+00	2021-11-08 10:20:13.034+00
6026	\N	died	2021-11-08 10:20:01.109+00	\N	\N	2021-11-08 10:20:51.182+00	2021-11-08 10:20:51.42+00
4741	\N	died	2021-11-08 10:19:15.11+00	\N	\N	2021-11-08 10:20:12.985+00	2021-11-08 10:20:13.816+00
6229	\N	died	2021-11-08 10:20:09.433+00	\N	\N	2021-11-08 10:20:56.825+00	2021-11-08 10:20:57.085+00
4761	\N	died	2021-11-08 10:19:15.595+00	\N	\N	2021-11-08 10:20:13.678+00	2021-11-08 10:20:14.205+00
4777	\N	died	2021-11-08 10:19:15.942+00	\N	\N	2021-11-08 10:20:14.136+00	2021-11-08 10:20:14.591+00
6031	\N	died	2021-11-08 10:20:01.243+00	\N	\N	2021-11-08 10:20:51.292+00	2021-11-08 10:20:51.709+00
4792	\N	died	2021-11-08 10:19:16.064+00	\N	\N	2021-11-08 10:20:14.584+00	2021-11-08 10:20:14.944+00
4801	\N	died	2021-11-08 10:19:16.192+00	\N	\N	2021-11-08 10:20:14.815+00	2021-11-08 10:20:16.088+00
4819	\N	died	2021-11-08 10:19:16.702+00	\N	\N	2021-11-08 10:20:15.905+00	2021-11-08 10:20:16.593+00
6044	\N	died	2021-11-08 10:20:01.476+00	\N	\N	2021-11-08 10:20:51.659+00	2021-11-08 10:20:52.248+00
4835	\N	died	2021-11-08 10:19:17.096+00	\N	\N	2021-11-08 10:20:16.514+00	2021-11-08 10:20:17.019+00
4848	\N	died	2021-11-08 10:19:17.661+00	\N	\N	2021-11-08 10:20:16.986+00	2021-11-08 10:20:17.172+00
4855	\N	died	2021-11-08 10:19:18.052+00	\N	\N	2021-11-08 10:20:17.163+00	2021-11-08 10:20:17.599+00
6062	\N	died	2021-11-08 10:20:01.776+00	\N	\N	2021-11-08 10:20:52.115+00	2021-11-08 10:20:53.077+00
4863	\N	died	2021-11-08 10:19:18.519+00	\N	\N	2021-11-08 10:20:17.372+00	2021-11-08 10:20:18.547+00
6237	\N	died	2021-11-08 10:20:09.728+00	\N	\N	2021-11-08 10:20:57.049+00	2021-11-08 10:20:57.363+00
4886	\N	died	2021-11-08 10:19:19.877+00	\N	\N	2021-11-08 10:20:18.522+00	2021-11-08 10:20:19.193+00
4902	\N	died	2021-11-08 10:19:20.494+00	\N	\N	2021-11-08 10:20:19.145+00	2021-11-08 10:20:19.906+00
6083	\N	died	2021-11-08 10:20:02.86+00	\N	\N	2021-11-08 10:20:52.983+00	2021-11-08 10:20:53.53+00
4919	\N	died	2021-11-08 10:19:21.244+00	\N	\N	2021-11-08 10:20:19.899+00	2021-11-08 10:20:20.568+00
6351	\N	died	2021-11-08 10:20:13.078+00	\N	\N	2021-11-08 10:21:00.176+00	2021-11-08 10:21:00.655+00
4926	\N	died	2021-11-08 10:19:21.586+00	\N	\N	2021-11-08 10:20:20.347+00	2021-11-08 10:20:20.708+00
4938	\N	died	2021-11-08 10:19:22.269+00	\N	\N	2021-11-08 10:20:20.705+00	2021-11-08 10:20:20.902+00
6098	\N	died	2021-11-08 10:20:03.868+00	\N	\N	2021-11-08 10:20:53.399+00	2021-11-08 10:20:53.597+00
4947	\N	died	2021-11-08 10:19:22.878+00	\N	\N	2021-11-08 10:20:20.898+00	2021-11-08 10:20:20.949+00
4950	\N	died	2021-11-08 10:19:23.097+00	\N	\N	2021-11-08 10:20:20.946+00	2021-11-08 10:20:21.006+00
6109	\N	died	2021-11-08 10:20:04.26+00	\N	\N	2021-11-08 10:20:53.592+00	2021-11-08 10:20:53.847+00
4952	\N	died	2021-11-08 10:19:23.178+00	\N	\N	2021-11-08 10:20:21.002+00	2021-11-08 10:20:21.041+00
6244	\N	died	2021-11-08 10:20:09.961+00	\N	\N	2021-11-08 10:20:57.258+00	2021-11-08 10:20:57.548+00
6115	\N	died	2021-11-08 10:20:04.443+00	\N	\N	2021-11-08 10:20:53.801+00	2021-11-08 10:20:54.332+00
6127	\N	died	2021-11-08 10:20:04.676+00	\N	\N	2021-11-08 10:20:54.22+00	2021-11-08 10:20:54.572+00
6140	\N	died	2021-11-08 10:20:05.246+00	\N	\N	2021-11-08 10:20:54.559+00	2021-11-08 10:20:54.83+00
6256	\N	died	2021-11-08 10:20:10.278+00	\N	\N	2021-11-08 10:20:57.542+00	2021-11-08 10:20:57.73+00
6150	\N	died	2021-11-08 10:20:05.567+00	\N	\N	2021-11-08 10:20:54.741+00	2021-11-08 10:20:55.031+00
6165	\N	died	2021-11-08 10:20:06.007+00	\N	\N	2021-11-08 10:20:55.025+00	2021-11-08 10:20:55.298+00
6172	\N	died	2021-11-08 10:20:06.302+00	\N	\N	2021-11-08 10:20:55.216+00	2021-11-08 10:20:55.695+00
6362	\N	died	2021-11-08 10:20:13.441+00	\N	\N	2021-11-08 10:21:00.65+00	2021-11-08 10:21:00.738+00
6189	\N	died	2021-11-08 10:20:07.42+00	\N	\N	2021-11-08 10:20:55.675+00	2021-11-08 10:20:56.384+00
6207	\N	died	2021-11-08 10:20:08.195+00	\N	\N	2021-11-08 10:20:56.257+00	2021-11-08 10:20:56.548+00
6261	\N	died	2021-11-08 10:20:10.442+00	\N	\N	2021-11-08 10:20:57.625+00	2021-11-08 10:20:58.17+00
6365	\N	died	2021-11-08 10:20:13.628+00	\N	\N	2021-11-08 10:21:00.699+00	2021-11-08 10:21:01.029+00
6272	\N	died	2021-11-08 10:20:10.661+00	\N	\N	2021-11-08 10:20:58.059+00	2021-11-08 10:20:58.463+00
6285	\N	died	2021-11-08 10:20:10.994+00	\N	\N	2021-11-08 10:20:58.452+00	2021-11-08 10:20:58.857+00
6294	\N	died	2021-11-08 10:20:11.613+00	\N	\N	2021-11-08 10:20:58.742+00	2021-11-08 10:20:59.088+00
6412	\N	died	2021-11-08 10:20:15.971+00	\N	\N	2021-11-08 10:21:01.741+00	2021-11-08 10:21:01.85+00
6308	\N	died	2021-11-08 10:20:11.986+00	\N	\N	2021-11-08 10:20:59.066+00	2021-11-08 10:20:59.447+00
6323	\N	died	2021-11-08 10:20:12.46+00	\N	\N	2021-11-08 10:20:59.418+00	2021-11-08 10:20:59.755+00
6336	\N	died	2021-11-08 10:20:12.661+00	\N	\N	2021-11-08 10:20:59.735+00	2021-11-08 10:20:59.831+00
6416	\N	died	2021-11-08 10:20:16.103+00	\N	\N	2021-11-08 10:21:01.842+00	2021-11-08 10:21:02+00
6339	\N	died	2021-11-08 10:20:12.719+00	\N	\N	2021-11-08 10:20:59.818+00	2021-11-08 10:20:59.918+00
6343	\N	died	2021-11-08 10:20:12.903+00	\N	\N	2021-11-08 10:20:59.908+00	2021-11-08 10:20:59.992+00
6377	\N	died	2021-11-08 10:20:14.12+00	\N	\N	2021-11-08 10:21:00.991+00	2021-11-08 10:21:01.395+00
6420	\N	died	2021-11-08 10:20:16.173+00	\N	\N	2021-11-08 10:21:01.992+00	2021-11-08 10:21:02.268+00
6427	\N	died	2021-11-08 10:20:16.28+00	\N	\N	2021-11-08 10:21:02.26+00	2021-11-08 10:21:02.295+00
6429	\N	died	2021-11-08 10:20:16.356+00	\N	\N	2021-11-08 10:21:02.291+00	2021-11-08 10:21:02.356+00
6432	\N	died	2021-11-08 10:20:16.439+00	\N	\N	2021-11-08 10:21:02.35+00	2021-11-08 10:21:02.524+00
6436	\N	died	2021-11-08 10:20:16.494+00	\N	\N	2021-11-08 10:21:02.511+00	2021-11-08 10:21:02.664+00
6442	\N	died	2021-11-08 10:20:16.603+00	\N	\N	2021-11-08 10:21:02.651+00	2021-11-08 10:21:02.779+00
6445	\N	died	2021-11-08 10:20:16.614+00	\N	\N	2021-11-08 10:21:02.761+00	2021-11-08 10:21:02.915+00
6443	\N	died	2021-11-08 10:20:16.605+00	\N	\N	2021-11-08 10:21:02.676+00	2021-11-08 10:21:02.915+00
4486	\N	died	2021-11-08 10:19:08.26+00	\N	\N	2021-11-08 10:20:04.894+00	2021-11-08 10:20:05.126+00
4917	\N	died	2021-11-08 10:19:21.103+00	\N	\N	2021-11-08 10:20:19.854+00	2021-11-08 10:20:20.568+00
4497	\N	died	2021-11-08 10:19:08.294+00	\N	\N	2021-11-08 10:20:05.12+00	2021-11-08 10:20:05.432+00
6037	\N	died	2021-11-08 10:20:01.326+00	\N	\N	2021-11-08 10:20:51.499+00	2021-11-08 10:20:51.709+00
4503	\N	died	2021-11-08 10:19:08.341+00	\N	\N	2021-11-08 10:20:05.415+00	2021-11-08 10:20:05.867+00
4521	\N	died	2021-11-08 10:19:08.816+00	\N	\N	2021-11-08 10:20:05.851+00	2021-11-08 10:20:06.063+00
4928	\N	died	2021-11-08 10:19:21.686+00	\N	\N	2021-11-08 10:20:20.447+00	2021-11-08 10:20:20.902+00
4525	\N	died	2021-11-08 10:19:08.966+00	\N	\N	2021-11-08 10:20:06.009+00	2021-11-08 10:20:07.006+00
4539	\N	died	2021-11-08 10:19:09.334+00	\N	\N	2021-11-08 10:20:06.948+00	2021-11-08 10:20:07.836+00
4553	\N	died	2021-11-08 10:19:09.7+00	\N	\N	2021-11-08 10:20:07.566+00	2021-11-08 10:20:08.43+00
4944	\N	died	2021-11-08 10:19:22.677+00	\N	\N	2021-11-08 10:20:20.841+00	2021-11-08 10:20:21.311+00
4575	\N	died	2021-11-08 10:19:10.927+00	\N	\N	2021-11-08 10:20:08.291+00	2021-11-08 10:20:08.892+00
4590	\N	died	2021-11-08 10:19:11.384+00	\N	\N	2021-11-08 10:20:08.854+00	2021-11-08 10:20:09.12+00
4597	\N	died	2021-11-08 10:19:11.422+00	\N	\N	2021-11-08 10:20:08.983+00	2021-11-08 10:20:09.343+00
4963	\N	died	2021-11-08 10:19:23.887+00	\N	\N	2021-11-08 10:20:21.306+00	2021-11-08 10:20:21.632+00
4609	\N	died	2021-11-08 10:19:11.519+00	\N	\N	2021-11-08 10:20:09.21+00	2021-11-08 10:20:09.884+00
6045	\N	died	2021-11-08 10:20:01.493+00	\N	\N	2021-11-08 10:20:51.693+00	2021-11-08 10:20:51.758+00
4628	\N	died	2021-11-08 10:19:11.694+00	\N	\N	2021-11-08 10:20:09.742+00	2021-11-08 10:20:09.948+00
4635	\N	died	2021-11-08 10:19:11.87+00	\N	\N	2021-11-08 10:20:09.943+00	2021-11-08 10:20:10.034+00
4973	\N	died	2021-11-08 10:19:24.662+00	\N	\N	2021-11-08 10:20:21.628+00	2021-11-08 10:20:21.806+00
4638	\N	died	2021-11-08 10:19:12.018+00	\N	\N	2021-11-08 10:20:09.996+00	2021-11-08 10:20:10.3+00
6234	\N	died	2021-11-08 10:20:09.661+00	\N	\N	2021-11-08 10:20:56.991+00	2021-11-08 10:20:57.486+00
4646	\N	died	2021-11-08 10:19:12.284+00	\N	\N	2021-11-08 10:20:10.223+00	2021-11-08 10:20:10.819+00
4665	\N	died	2021-11-08 10:19:13.017+00	\N	\N	2021-11-08 10:20:10.738+00	2021-11-08 10:20:11.058+00
4975	\N	died	2021-11-08 10:19:24.761+00	\N	\N	2021-11-08 10:20:21.792+00	2021-11-08 10:20:22.123+00
4680	\N	died	2021-11-08 10:19:13.534+00	\N	\N	2021-11-08 10:20:11.05+00	2021-11-08 10:20:11.676+00
4686	\N	died	2021-11-08 10:19:13.76+00	\N	\N	2021-11-08 10:20:11.566+00	2021-11-08 10:20:12.068+00
4699	\N	died	2021-11-08 10:19:14.184+00	\N	\N	2021-11-08 10:20:11.862+00	2021-11-08 10:20:12.157+00
4977	\N	died	2021-11-08 10:19:24.944+00	\N	\N	2021-11-08 10:20:22.114+00	2021-11-08 10:20:22.327+00
4707	\N	died	2021-11-08 10:19:14.468+00	\N	\N	2021-11-08 10:20:12.149+00	2021-11-08 10:20:12.307+00
6047	\N	died	2021-11-08 10:20:01.511+00	\N	\N	2021-11-08 10:20:51.742+00	2021-11-08 10:20:51.855+00
4713	\N	died	2021-11-08 10:19:14.513+00	\N	\N	2021-11-08 10:20:12.253+00	2021-11-08 10:20:12.511+00
4725	\N	died	2021-11-08 10:19:14.627+00	\N	\N	2021-11-08 10:20:12.488+00	2021-11-08 10:20:13.034+00
4981	\N	died	2021-11-08 10:19:25.045+00	\N	\N	2021-11-08 10:20:22.32+00	2021-11-08 10:20:22.419+00
4735	\N	died	2021-11-08 10:19:14.759+00	\N	\N	2021-11-08 10:20:12.722+00	2021-11-08 10:20:13.131+00
4747	\N	died	2021-11-08 10:19:15.276+00	\N	\N	2021-11-08 10:20:13.111+00	2021-11-08 10:20:13.816+00
4760	\N	died	2021-11-08 10:19:15.577+00	\N	\N	2021-11-08 10:20:13.635+00	2021-11-08 10:20:14.101+00
4985	\N	died	2021-11-08 10:19:25.262+00	\N	\N	2021-11-08 10:20:22.415+00	2021-11-08 10:20:22.47+00
4775	\N	died	2021-11-08 10:19:15.877+00	\N	\N	2021-11-08 10:20:14.078+00	2021-11-08 10:20:14.382+00
4784	\N	died	2021-11-08 10:19:16.044+00	\N	\N	2021-11-08 10:20:14.363+00	2021-11-08 10:20:14.944+00
4800	\N	died	2021-11-08 10:19:16.17+00	\N	\N	2021-11-08 10:20:14.786+00	2021-11-08 10:20:16.088+00
4988	\N	died	2021-11-08 10:19:25.445+00	\N	\N	2021-11-08 10:20:22.467+00	2021-11-08 10:20:22.615+00
4817	\N	died	2021-11-08 10:19:16.652+00	\N	\N	2021-11-08 10:20:15.863+00	2021-11-08 10:20:16.156+00
6051	\N	died	2021-11-08 10:20:01.56+00	\N	\N	2021-11-08 10:20:51.84+00	2021-11-08 10:20:52.248+00
4827	\N	died	2021-11-08 10:19:16.893+00	\N	\N	2021-11-08 10:20:16.15+00	2021-11-08 10:20:16.391+00
4830	\N	died	2021-11-08 10:19:16.945+00	\N	\N	2021-11-08 10:20:16.266+00	2021-11-08 10:20:16.817+00
4992	\N	died	2021-11-08 10:19:25.611+00	\N	\N	2021-11-08 10:20:22.607+00	2021-11-08 10:20:22.734+00
4842	\N	died	2021-11-08 10:19:17.404+00	\N	\N	2021-11-08 10:20:16.838+00	2021-11-08 10:20:17.599+00
6181	\N	died	2021-11-08 10:20:07.058+00	\N	\N	2021-11-08 10:20:55.483+00	2021-11-08 10:20:55.555+00
4866	\N	died	2021-11-08 10:19:18.735+00	\N	\N	2021-11-08 10:20:17.438+00	2021-11-08 10:20:17.928+00
4879	\N	died	2021-11-08 10:19:19.435+00	\N	\N	2021-11-08 10:20:17.922+00	2021-11-08 10:20:18.547+00
4885	\N	died	2021-11-08 10:19:19.827+00	\N	\N	2021-11-08 10:20:18.506+00	2021-11-08 10:20:19.584+00
6059	\N	died	2021-11-08 10:20:01.726+00	\N	\N	2021-11-08 10:20:52.049+00	2021-11-08 10:20:52.534+00
4906	\N	died	2021-11-08 10:19:20.711+00	\N	\N	2021-11-08 10:20:19.362+00	2021-11-08 10:20:19.887+00
6320	\N	died	2021-11-08 10:20:12.381+00	\N	\N	2021-11-08 10:20:59.367+00	2021-11-08 10:20:59.541+00
4997	\N	died	2021-11-08 10:19:25.837+00	\N	\N	2021-11-08 10:20:22.722+00	2021-11-08 10:20:22.939+00
5005	\N	died	2021-11-08 10:19:26.022+00	\N	\N	2021-11-08 10:20:22.935+00	2021-11-08 10:20:23.007+00
6073	\N	died	2021-11-08 10:20:02.343+00	\N	\N	2021-11-08 10:20:52.448+00	2021-11-08 10:20:53.077+00
5009	\N	died	2021-11-08 10:19:26.17+00	\N	\N	2021-11-08 10:20:23.003+00	2021-11-08 10:20:23.041+00
5011	\N	died	2021-11-08 10:19:26.303+00	\N	\N	2021-11-08 10:20:23.037+00	2021-11-08 10:20:23.164+00
5013	\N	died	2021-11-08 10:19:26.353+00	\N	\N	2021-11-08 10:20:23.148+00	2021-11-08 10:20:23.362+00
6084	\N	died	2021-11-08 10:20:02.927+00	\N	\N	2021-11-08 10:20:53.007+00	2021-11-08 10:20:53.53+00
5019	\N	died	2021-11-08 10:19:26.653+00	\N	\N	2021-11-08 10:20:23.348+00	2021-11-08 10:20:23.519+00
6185	\N	died	2021-11-08 10:20:07.237+00	\N	\N	2021-11-08 10:20:55.551+00	2021-11-08 10:20:56.089+00
5023	\N	died	2021-11-08 10:19:26.844+00	\N	\N	2021-11-08 10:20:23.514+00	2021-11-08 10:20:23.6+00
5027	\N	died	2021-11-08 10:19:27.061+00	\N	\N	2021-11-08 10:20:23.586+00	2021-11-08 10:20:23.669+00
6100	\N	died	2021-11-08 10:20:03.967+00	\N	\N	2021-11-08 10:20:53.432+00	2021-11-08 10:20:53.847+00
5029	\N	died	2021-11-08 10:19:27.211+00	\N	\N	2021-11-08 10:20:23.657+00	2021-11-08 10:20:23.844+00
5035	\N	died	2021-11-08 10:19:27.529+00	\N	\N	2021-11-08 10:20:23.839+00	2021-11-08 10:20:23.971+00
5041	\N	died	2021-11-08 10:19:27.869+00	\N	\N	2021-11-08 10:20:23.964+00	2021-11-08 10:20:24.067+00
6114	\N	died	2021-11-08 10:20:04.426+00	\N	\N	2021-11-08 10:20:53.758+00	2021-11-08 10:20:54.163+00
5047	\N	died	2021-11-08 10:19:28.32+00	\N	\N	2021-11-08 10:20:24.063+00	2021-11-08 10:20:24.117+00
5050	\N	died	2021-11-08 10:19:28.57+00	\N	\N	2021-11-08 10:20:24.112+00	2021-11-08 10:20:24.151+00
5052	\N	died	2021-11-08 10:19:28.678+00	\N	\N	2021-11-08 10:20:24.146+00	2021-11-08 10:20:24.241+00
6122	\N	died	2021-11-08 10:20:04.593+00	\N	\N	2021-11-08 10:20:53.959+00	2021-11-08 10:20:54.424+00
6192	\N	died	2021-11-08 10:20:07.599+00	\N	\N	2021-11-08 10:20:55.829+00	2021-11-08 10:20:56.137+00
5057	\N	died	2021-11-08 10:19:29.013+00	\N	\N	2021-11-08 10:20:24.235+00	2021-11-08 10:20:24.397+00
6134	\N	died	2021-11-08 10:20:04.928+00	\N	\N	2021-11-08 10:20:54.416+00	2021-11-08 10:20:54.549+00
6251	\N	died	2021-11-08 10:20:10.135+00	\N	\N	2021-11-08 10:20:57.374+00	2021-11-08 10:20:57.73+00
6139	\N	died	2021-11-08 10:20:05.119+00	\N	\N	2021-11-08 10:20:54.537+00	2021-11-08 10:20:54.83+00
6148	\N	died	2021-11-08 10:20:05.494+00	\N	\N	2021-11-08 10:20:54.707+00	2021-11-08 10:20:55.012+00
6161	\N	died	2021-11-08 10:20:05.849+00	\N	\N	2021-11-08 10:20:54.915+00	2021-11-08 10:20:55.298+00
6262	\N	died	2021-11-08 10:20:10.47+00	\N	\N	2021-11-08 10:20:57.642+00	2021-11-08 10:20:58.17+00
6170	\N	died	2021-11-08 10:20:06.224+00	\N	\N	2021-11-08 10:20:55.184+00	2021-11-08 10:20:55.487+00
6201	\N	died	2021-11-08 10:20:08.028+00	\N	\N	2021-11-08 10:20:56.132+00	2021-11-08 10:20:56.248+00
6206	\N	died	2021-11-08 10:20:08.178+00	\N	\N	2021-11-08 10:20:56.242+00	2021-11-08 10:20:56.523+00
6326	\N	died	2021-11-08 10:20:12.485+00	\N	\N	2021-11-08 10:20:59.477+00	2021-11-08 10:20:59.831+00
6216	\N	died	2021-11-08 10:20:08.64+00	\N	\N	2021-11-08 10:20:56.477+00	2021-11-08 10:20:57.021+00
6378	\N	died	2021-11-08 10:20:14.136+00	\N	\N	2021-11-08 10:21:01.008+00	2021-11-08 10:21:01.37+00
6273	\N	died	2021-11-08 10:20:10.735+00	\N	\N	2021-11-08 10:20:58.083+00	2021-11-08 10:20:58.644+00
6345	\N	died	2021-11-08 10:20:12.944+00	\N	\N	2021-11-08 10:20:59.953+00	2021-11-08 10:21:00.58+00
6289	\N	died	2021-11-08 10:20:11.086+00	\N	\N	2021-11-08 10:20:58.557+00	2021-11-08 10:20:59.021+00
6393	\N	died	2021-11-08 10:20:14.892+00	\N	\N	2021-11-08 10:21:01.334+00	2021-11-08 10:21:01.689+00
6304	\N	died	2021-11-08 10:20:11.827+00	\N	\N	2021-11-08 10:20:59.004+00	2021-11-08 10:20:59.374+00
6338	\N	died	2021-11-08 10:20:12.693+00	\N	\N	2021-11-08 10:20:59.792+00	2021-11-08 10:20:59.992+00
6357	\N	died	2021-11-08 10:20:13.261+00	\N	\N	2021-11-08 10:21:00.541+00	2021-11-08 10:21:01.029+00
6423	\N	died	2021-11-08 10:20:16.261+00	\N	\N	2021-11-08 10:21:02.077+00	2021-11-08 10:21:02.664+00
6405	\N	died	2021-11-08 10:20:15.84+00	\N	\N	2021-11-08 10:21:01.641+00	2021-11-08 10:21:02.268+00
6439	\N	died	2021-11-08 10:20:16.514+00	\N	\N	2021-11-08 10:21:02.583+00	2021-11-08 10:21:03.003+00
6453	\N	died	2021-11-08 10:20:16.636+00	\N	\N	2021-11-08 10:21:02.986+00	2021-11-08 10:21:03.163+00
6459	\N	died	2021-11-08 10:20:16.648+00	\N	\N	2021-11-08 10:21:03.148+00	2021-11-08 10:21:03.196+00
6461	\N	died	2021-11-08 10:20:16.652+00	\N	\N	2021-11-08 10:21:03.191+00	2021-11-08 10:21:03.264+00
4471	\N	died	2021-11-08 10:19:08.023+00	\N	\N	2021-11-08 10:20:04.594+00	2021-11-08 10:20:05.255+00
4498	\N	died	2021-11-08 10:19:08.296+00	\N	\N	2021-11-08 10:20:05.183+00	2021-11-08 10:20:05.499+00
4846	\N	died	2021-11-08 10:19:17.578+00	\N	\N	2021-11-08 10:20:16.903+00	2021-11-08 10:20:17.095+00
4507	\N	died	2021-11-08 10:19:08.408+00	\N	\N	2021-11-08 10:20:05.479+00	2021-11-08 10:20:05.776+00
4519	\N	died	2021-11-08 10:19:08.782+00	\N	\N	2021-11-08 10:20:05.754+00	2021-11-08 10:20:06.091+00
4528	\N	died	2021-11-08 10:19:09.016+00	\N	\N	2021-11-08 10:20:06.083+00	2021-11-08 10:20:06.669+00
4851	\N	died	2021-11-08 10:19:17.81+00	\N	\N	2021-11-08 10:20:17.048+00	2021-11-08 10:20:17.599+00
4531	\N	died	2021-11-08 10:19:09.133+00	\N	\N	2021-11-08 10:20:06.305+00	2021-11-08 10:20:07.204+00
4543	\N	died	2021-11-08 10:19:09.44+00	\N	\N	2021-11-08 10:20:07.102+00	2021-11-08 10:20:07.836+00
4555	\N	died	2021-11-08 10:19:09.8+00	\N	\N	2021-11-08 10:20:07.635+00	2021-11-08 10:20:08.43+00
4862	\N	died	2021-11-08 10:19:18.485+00	\N	\N	2021-11-08 10:20:17.358+00	2021-11-08 10:20:17.686+00
4573	\N	died	2021-11-08 10:19:10.911+00	\N	\N	2021-11-08 10:20:08.258+00	2021-11-08 10:20:08.705+00
5078	\N	died	2021-11-08 10:19:30.378+00	\N	\N	2021-11-08 10:20:24.722+00	2021-11-08 10:20:25.034+00
4582	\N	died	2021-11-08 10:19:11.11+00	\N	\N	2021-11-08 10:20:08.592+00	2021-11-08 10:20:09.12+00
4598	\N	died	2021-11-08 10:19:11.426+00	\N	\N	2021-11-08 10:20:09.004+00	2021-11-08 10:20:09.367+00
4872	\N	died	2021-11-08 10:19:19.085+00	\N	\N	2021-11-08 10:20:17.68+00	2021-11-08 10:20:17.858+00
4611	\N	died	2021-11-08 10:19:11.554+00	\N	\N	2021-11-08 10:20:09.36+00	2021-11-08 10:20:09.47+00
6078	\N	died	2021-11-08 10:20:02.559+00	\N	\N	2021-11-08 10:20:52.624+00	2021-11-08 10:20:53.077+00
4614	\N	died	2021-11-08 10:19:11.561+00	\N	\N	2021-11-08 10:20:09.435+00	2021-11-08 10:20:09.734+00
4622	\N	died	2021-11-08 10:19:11.612+00	\N	\N	2021-11-08 10:20:09.646+00	2021-11-08 10:20:09.933+00
4876	\N	died	2021-11-08 10:19:19.344+00	\N	\N	2021-11-08 10:20:17.775+00	2021-11-08 10:20:18.618+00
4633	\N	died	2021-11-08 10:19:11.85+00	\N	\N	2021-11-08 10:20:09.906+00	2021-11-08 10:20:09.985+00
4637	\N	died	2021-11-08 10:19:11.934+00	\N	\N	2021-11-08 10:20:09.979+00	2021-11-08 10:20:10.172+00
4642	\N	died	2021-11-08 10:19:12.118+00	\N	\N	2021-11-08 10:20:10.062+00	2021-11-08 10:20:10.46+00
4888	\N	died	2021-11-08 10:19:20.035+00	\N	\N	2021-11-08 10:20:18.613+00	2021-11-08 10:20:18.946+00
4654	\N	died	2021-11-08 10:19:12.502+00	\N	\N	2021-11-08 10:20:10.445+00	2021-11-08 10:20:10.567+00
5088	\N	died	2021-11-08 10:19:30.971+00	\N	\N	2021-11-08 10:20:25.02+00	2021-11-08 10:20:25.086+00
4657	\N	died	2021-11-08 10:19:12.7+00	\N	\N	2021-11-08 10:20:10.537+00	2021-11-08 10:20:10.819+00
4666	\N	died	2021-11-08 10:19:13.022+00	\N	\N	2021-11-08 10:20:10.763+00	2021-11-08 10:20:11.676+00
4893	\N	died	2021-11-08 10:19:20.202+00	\N	\N	2021-11-08 10:20:18.851+00	2021-11-08 10:20:19.584+00
4683	\N	died	2021-11-08 10:19:13.668+00	\N	\N	2021-11-08 10:20:11.104+00	2021-11-08 10:20:11.768+00
6211	\N	died	2021-11-08 10:20:08.278+00	\N	\N	2021-11-08 10:20:56.416+00	2021-11-08 10:20:56.798+00
4693	\N	died	2021-11-08 10:19:14.002+00	\N	\N	2021-11-08 10:20:11.765+00	2021-11-08 10:20:12.068+00
4702	\N	died	2021-11-08 10:19:14.253+00	\N	\N	2021-11-08 10:20:11.988+00	2021-11-08 10:20:12.449+00
4907	\N	died	2021-11-08 10:19:20.751+00	\N	\N	2021-11-08 10:20:19.413+00	2021-11-08 10:20:20.205+00
4718	\N	died	2021-11-08 10:19:14.526+00	\N	\N	2021-11-08 10:20:12.35+00	2021-11-08 10:20:12.698+00
4732	\N	died	2021-11-08 10:19:14.711+00	\N	\N	2021-11-08 10:20:12.662+00	2021-11-08 10:20:13.054+00
4743	\N	died	2021-11-08 10:19:15.143+00	\N	\N	2021-11-08 10:20:13.048+00	2021-11-08 10:20:13.131+00
4921	\N	died	2021-11-08 10:19:21.411+00	\N	\N	2021-11-08 10:20:19.937+00	2021-11-08 10:20:20.589+00
4746	\N	died	2021-11-08 10:19:15.243+00	\N	\N	2021-11-08 10:20:13.095+00	2021-11-08 10:20:13.396+00
5090	\N	died	2021-11-08 10:19:31.12+00	\N	\N	2021-11-08 10:20:25.08+00	2021-11-08 10:20:25.133+00
4754	\N	died	2021-11-08 10:19:15.418+00	\N	\N	2021-11-08 10:20:13.375+00	2021-11-08 10:20:13.816+00
4763	\N	died	2021-11-08 10:19:15.611+00	\N	\N	2021-11-08 10:20:13.755+00	2021-11-08 10:20:14.228+00
4932	\N	died	2021-11-08 10:19:21.921+00	\N	\N	2021-11-08 10:20:20.584+00	2021-11-08 10:20:20.663+00
4781	\N	died	2021-11-08 10:19:16.01+00	\N	\N	2021-11-08 10:20:14.222+00	2021-11-08 10:20:14.468+00
4787	\N	died	2021-11-08 10:19:16.051+00	\N	\N	2021-11-08 10:20:14.419+00	2021-11-08 10:20:14.944+00
4797	\N	died	2021-11-08 10:19:16.12+00	\N	\N	2021-11-08 10:20:14.729+00	2021-11-08 10:20:15.625+00
4935	\N	died	2021-11-08 10:19:22.119+00	\N	\N	2021-11-08 10:20:20.655+00	2021-11-08 10:20:20.745+00
4809	\N	died	2021-11-08 10:19:16.343+00	\N	\N	2021-11-08 10:20:15.622+00	2021-11-08 10:20:15.853+00
4814	\N	died	2021-11-08 10:19:16.462+00	\N	\N	2021-11-08 10:20:15.785+00	2021-11-08 10:20:16.132+00
5093	\N	died	2021-11-08 10:19:31.29+00	\N	\N	2021-11-08 10:20:25.129+00	2021-11-08 10:20:25.198+00
4825	\N	died	2021-11-08 10:19:16.86+00	\N	\N	2021-11-08 10:20:16.105+00	2021-11-08 10:20:16.391+00
6088	\N	died	2021-11-08 10:20:03.16+00	\N	\N	2021-11-08 10:20:53.073+00	2021-11-08 10:20:53.111+00
4831	\N	died	2021-11-08 10:19:16.977+00	\N	\N	2021-11-08 10:20:16.282+00	2021-11-08 10:20:16.906+00
4939	\N	died	2021-11-08 10:19:22.37+00	\N	\N	2021-11-08 10:20:20.737+00	2021-11-08 10:20:20.949+00
5097	\N	died	2021-11-08 10:19:31.405+00	\N	\N	2021-11-08 10:20:25.194+00	2021-11-08 10:20:25.363+00
4949	\N	died	2021-11-08 10:19:23.061+00	\N	\N	2021-11-08 10:20:20.931+00	2021-11-08 10:20:21.151+00
4959	\N	died	2021-11-08 10:19:23.63+00	\N	\N	2021-11-08 10:20:21.145+00	2021-11-08 10:20:21.36+00
4964	\N	died	2021-11-08 10:19:24.04+00	\N	\N	2021-11-08 10:20:21.325+00	2021-11-08 10:20:22.615+00
5103	\N	died	2021-11-08 10:19:31.845+00	\N	\N	2021-11-08 10:20:25.358+00	2021-11-08 10:20:25.425+00
4991	\N	died	2021-11-08 10:19:25.578+00	\N	\N	2021-11-08 10:20:22.586+00	2021-11-08 10:20:22.939+00
5004	\N	died	2021-11-08 10:19:26.02+00	\N	\N	2021-11-08 10:20:22.92+00	2021-11-08 10:20:23.6+00
5026	\N	died	2021-11-08 10:19:27.011+00	\N	\N	2021-11-08 10:20:23.561+00	2021-11-08 10:20:23.859+00
6090	\N	died	2021-11-08 10:20:03.31+00	\N	\N	2021-11-08 10:20:53.107+00	2021-11-08 10:20:53.163+00
5036	\N	died	2021-11-08 10:19:27.531+00	\N	\N	2021-11-08 10:20:23.851+00	2021-11-08 10:20:24.067+00
6176	\N	died	2021-11-08 10:20:06.684+00	\N	\N	2021-11-08 10:20:55.307+00	2021-11-08 10:20:55.511+00
5043	\N	died	2021-11-08 10:19:27.97+00	\N	\N	2021-11-08 10:20:23.995+00	2021-11-08 10:20:24.17+00
5053	\N	died	2021-11-08 10:19:28.845+00	\N	\N	2021-11-08 10:20:24.165+00	2021-11-08 10:20:24.397+00
6092	\N	died	2021-11-08 10:20:03.476+00	\N	\N	2021-11-08 10:20:53.14+00	2021-11-08 10:20:53.53+00
5060	\N	died	2021-11-08 10:19:29.27+00	\N	\N	2021-11-08 10:20:24.304+00	2021-11-08 10:20:24.725+00
5107	\N	died	2021-11-08 10:19:32.045+00	\N	\N	2021-11-08 10:20:25.421+00	2021-11-08 10:20:25.49+00
5111	\N	died	2021-11-08 10:19:32.538+00	\N	\N	2021-11-08 10:20:25.487+00	2021-11-08 10:20:25.58+00
5113	\N	died	2021-11-08 10:19:32.706+00	\N	\N	2021-11-08 10:20:25.576+00	2021-11-08 10:20:25.687+00
6101	\N	died	2021-11-08 10:20:04.001+00	\N	\N	2021-11-08 10:20:53.449+00	2021-11-08 10:20:53.909+00
5118	\N	died	2021-11-08 10:19:33.217+00	\N	\N	2021-11-08 10:20:25.683+00	2021-11-08 10:20:25.895+00
5125	\N	died	2021-11-08 10:19:33.67+00	\N	\N	2021-11-08 10:20:25.888+00	2021-11-08 10:20:25.941+00
5127	\N	died	2021-11-08 10:19:33.838+00	\N	\N	2021-11-08 10:20:25.929+00	2021-11-08 10:20:25.974+00
6118	\N	died	2021-11-08 10:20:04.51+00	\N	\N	2021-11-08 10:20:53.857+00	2021-11-08 10:20:54.332+00
5129	\N	died	2021-11-08 10:19:33.97+00	\N	\N	2021-11-08 10:20:25.971+00	2021-11-08 10:20:26.083+00
6183	\N	died	2021-11-08 10:20:07.14+00	\N	\N	2021-11-08 10:20:55.507+00	2021-11-08 10:20:55.695+00
5134	\N	died	2021-11-08 10:19:34.313+00	\N	\N	2021-11-08 10:20:26.079+00	2021-11-08 10:20:26.264+00
5138	\N	died	2021-11-08 10:19:34.595+00	\N	\N	2021-11-08 10:20:26.255+00	2021-11-08 10:20:26.455+00
6126	\N	died	2021-11-08 10:20:04.66+00	\N	\N	2021-11-08 10:20:54.188+00	2021-11-08 10:20:54.484+00
5144	\N	died	2021-11-08 10:19:35.062+00	\N	\N	2021-11-08 10:20:26.448+00	2021-11-08 10:20:26.582+00
5151	\N	died	2021-11-08 10:19:35.355+00	\N	\N	2021-11-08 10:20:26.578+00	2021-11-08 10:20:26.634+00
6136	\N	died	2021-11-08 10:20:04.978+00	\N	\N	2021-11-08 10:20:54.46+00	2021-11-08 10:20:54.83+00
6224	\N	died	2021-11-08 10:20:09.127+00	\N	\N	2021-11-08 10:20:56.728+00	2021-11-08 10:20:57.021+00
6149	\N	died	2021-11-08 10:20:05.524+00	\N	\N	2021-11-08 10:20:54.724+00	2021-11-08 10:20:55.012+00
6391	\N	died	2021-11-08 10:20:14.769+00	\N	\N	2021-11-08 10:21:01.279+00	2021-11-08 10:21:01.413+00
6163	\N	died	2021-11-08 10:20:05.895+00	\N	\N	2021-11-08 10:20:54.971+00	2021-11-08 10:20:55.469+00
6249	\N	died	2021-11-08 10:20:10.045+00	\N	\N	2021-11-08 10:20:57.341+00	2021-11-08 10:20:58.17+00
6188	\N	died	2021-11-08 10:20:07.378+00	\N	\N	2021-11-08 10:20:55.667+00	2021-11-08 10:20:56.205+00
6203	\N	died	2021-11-08 10:20:08.107+00	\N	\N	2021-11-08 10:20:56.166+00	2021-11-08 10:20:56.523+00
6233	\N	died	2021-11-08 10:20:09.644+00	\N	\N	2021-11-08 10:20:56.967+00	2021-11-08 10:20:57.363+00
6271	\N	died	2021-11-08 10:20:10.644+00	\N	\N	2021-11-08 10:20:58.004+00	2021-11-08 10:20:58.392+00
6281	\N	died	2021-11-08 10:20:10.927+00	\N	\N	2021-11-08 10:20:58.384+00	2021-11-08 10:20:58.486+00
6286	\N	died	2021-11-08 10:20:11.018+00	\N	\N	2021-11-08 10:20:58.475+00	2021-11-08 10:20:58.857+00
6295	\N	died	2021-11-08 10:20:11.648+00	\N	\N	2021-11-08 10:20:58.758+00	2021-11-08 10:20:59.104+00
6310	\N	died	2021-11-08 10:20:12.056+00	\N	\N	2021-11-08 10:20:59.099+00	2021-11-08 10:20:59.318+00
6317	\N	died	2021-11-08 10:20:12.237+00	\N	\N	2021-11-08 10:20:59.302+00	2021-11-08 10:20:59.447+00
6322	\N	died	2021-11-08 10:20:12.444+00	\N	\N	2021-11-08 10:20:59.4+00	2021-11-08 10:20:59.672+00
6334	\N	died	2021-11-08 10:20:12.646+00	\N	\N	2021-11-08 10:20:59.649+00	2021-11-08 10:21:00.58+00
6355	\N	died	2021-11-08 10:20:13.219+00	\N	\N	2021-11-08 10:21:00.492+00	2021-11-08 10:21:00.849+00
6372	\N	died	2021-11-08 10:20:13.878+00	\N	\N	2021-11-08 10:21:00.842+00	2021-11-08 10:21:01.029+00
6376	\N	died	2021-11-08 10:20:14.062+00	\N	\N	2021-11-08 10:21:00.975+00	2021-11-08 10:21:01.3+00
6397	\N	died	2021-11-08 10:20:15.586+00	\N	\N	2021-11-08 10:21:01.408+00	2021-11-08 10:21:01.689+00
6406	\N	died	2021-11-08 10:20:15.844+00	\N	\N	2021-11-08 10:21:01.66+00	2021-11-08 10:21:02.268+00
6425	\N	died	2021-11-08 10:20:16.265+00	\N	\N	2021-11-08 10:21:02.21+00	2021-11-08 10:21:02.683+00
4468	\N	died	2021-11-08 10:19:07.925+00	\N	\N	2021-11-08 10:20:04.543+00	2021-11-08 10:20:05.331+00
4500	\N	died	2021-11-08 10:19:08.304+00	\N	\N	2021-11-08 10:20:05.314+00	2021-11-08 10:20:05.499+00
4877	\N	died	2021-11-08 10:19:19.377+00	\N	\N	2021-11-08 10:20:17.81+00	2021-11-08 10:20:18.946+00
4505	\N	died	2021-11-08 10:19:08.374+00	\N	\N	2021-11-08 10:20:05.444+00	2021-11-08 10:20:05.727+00
4513	\N	died	2021-11-08 10:19:08.557+00	\N	\N	2021-11-08 10:20:05.647+00	2021-11-08 10:20:06.279+00
4530	\N	died	2021-11-08 10:19:09.116+00	\N	\N	2021-11-08 10:20:06.263+00	2021-11-08 10:20:07.006+00
4892	\N	died	2021-11-08 10:19:20.109+00	\N	\N	2021-11-08 10:20:18.745+00	2021-11-08 10:20:19.193+00
4538	\N	died	2021-11-08 10:19:09.3+00	\N	\N	2021-11-08 10:20:06.855+00	2021-11-08 10:20:07.279+00
4547	\N	died	2021-11-08 10:19:09.524+00	\N	\N	2021-11-08 10:20:07.273+00	2021-11-08 10:20:07.836+00
4556	\N	died	2021-11-08 10:19:10.151+00	\N	\N	2021-11-08 10:20:07.681+00	2021-11-08 10:20:08.201+00
4901	\N	died	2021-11-08 10:19:20.477+00	\N	\N	2021-11-08 10:20:19.13+00	2021-11-08 10:20:19.786+00
4569	\N	died	2021-11-08 10:19:10.726+00	\N	\N	2021-11-08 10:20:08.196+00	2021-11-08 10:20:08.43+00
5122	\N	died	2021-11-08 10:19:33.571+00	\N	\N	2021-11-08 10:20:25.754+00	2021-11-08 10:20:26.277+00
4574	\N	died	2021-11-08 10:19:10.925+00	\N	\N	2021-11-08 10:20:08.279+00	2021-11-08 10:20:08.705+00
4585	\N	died	2021-11-08 10:19:11.193+00	\N	\N	2021-11-08 10:20:08.675+00	2021-11-08 10:20:09.162+00
4915	\N	died	2021-11-08 10:19:21.036+00	\N	\N	2021-11-08 10:20:19.764+00	2021-11-08 10:20:19.928+00
4604	\N	died	2021-11-08 10:19:11.442+00	\N	\N	2021-11-08 10:20:09.15+00	2021-11-08 10:20:09.412+00
4613	\N	died	2021-11-08 10:19:11.558+00	\N	\N	2021-11-08 10:20:09.394+00	2021-11-08 10:20:09.504+00
4618	\N	died	2021-11-08 10:19:11.571+00	\N	\N	2021-11-08 10:20:09.5+00	2021-11-08 10:20:09.734+00
4920	\N	died	2021-11-08 10:19:21.328+00	\N	\N	2021-11-08 10:20:19.924+00	2021-11-08 10:20:20.568+00
4624	\N	died	2021-11-08 10:19:11.642+00	\N	\N	2021-11-08 10:20:09.679+00	2021-11-08 10:20:10.3+00
4647	\N	died	2021-11-08 10:19:12.286+00	\N	\N	2021-11-08 10:20:10.242+00	2021-11-08 10:20:10.819+00
4667	\N	died	2021-11-08 10:19:13.043+00	\N	\N	2021-11-08 10:20:10.788+00	2021-11-08 10:20:11.676+00
4929	\N	died	2021-11-08 10:19:21.735+00	\N	\N	2021-11-08 10:20:20.498+00	2021-11-08 10:20:20.902+00
4687	\N	died	2021-11-08 10:19:13.793+00	\N	\N	2021-11-08 10:20:11.615+00	2021-11-08 10:20:12.068+00
5139	\N	died	2021-11-08 10:19:34.646+00	\N	\N	2021-11-08 10:20:26.272+00	2021-11-08 10:20:26.582+00
4701	\N	died	2021-11-08 10:19:14.218+00	\N	\N	2021-11-08 10:20:11.947+00	2021-11-08 10:20:12.329+00
4716	\N	died	2021-11-08 10:19:14.523+00	\N	\N	2021-11-08 10:20:12.323+00	2021-11-08 10:20:12.511+00
4946	\N	died	2021-11-08 10:19:22.828+00	\N	\N	2021-11-08 10:20:20.878+00	2021-11-08 10:20:21.632+00
4724	\N	died	2021-11-08 10:19:14.595+00	\N	\N	2021-11-08 10:20:12.471+00	2021-11-08 10:20:12.651+00
6130	\N	died	2021-11-08 10:20:04.792+00	\N	\N	2021-11-08 10:20:54.317+00	2021-11-08 10:20:54.4+00
4731	\N	died	2021-11-08 10:19:14.695+00	\N	\N	2021-11-08 10:20:12.646+00	2021-11-08 10:20:13.034+00
4740	\N	died	2021-11-08 10:19:15.092+00	\N	\N	2021-11-08 10:20:12.947+00	2021-11-08 10:20:13.816+00
4967	\N	died	2021-11-08 10:19:24.203+00	\N	\N	2021-11-08 10:20:21.37+00	2021-11-08 10:20:21.86+00
4758	\N	died	2021-11-08 10:19:15.545+00	\N	\N	2021-11-08 10:20:13.486+00	2021-11-08 10:20:14.016+00
4771	\N	died	2021-11-08 10:19:15.826+00	\N	\N	2021-11-08 10:20:13.997+00	2021-11-08 10:20:14.205+00
4778	\N	died	2021-11-08 10:19:15.976+00	\N	\N	2021-11-08 10:20:14.155+00	2021-11-08 10:20:14.944+00
4976	\N	died	2021-11-08 10:19:24.794+00	\N	\N	2021-11-08 10:20:21.847+00	2021-11-08 10:20:22.327+00
4796	\N	died	2021-11-08 10:19:16.119+00	\N	\N	2021-11-08 10:20:14.701+00	2021-11-08 10:20:15.564+00
5148	\N	died	2021-11-08 10:19:35.213+00	\N	\N	2021-11-08 10:20:26.531+00	2021-11-08 10:20:26.925+00
4806	\N	died	2021-11-08 10:19:16.243+00	\N	\N	2021-11-08 10:20:15.546+00	2021-11-08 10:20:15.683+00
4810	\N	died	2021-11-08 10:19:16.376+00	\N	\N	2021-11-08 10:20:15.637+00	2021-11-08 10:20:16.088+00
4979	\N	died	2021-11-08 10:19:24.978+00	\N	\N	2021-11-08 10:20:22.266+00	2021-11-08 10:20:22.47+00
4818	\N	died	2021-11-08 10:19:16.685+00	\N	\N	2021-11-08 10:20:15.88+00	2021-11-08 10:20:16.593+00
6220	\N	died	2021-11-08 10:20:08.853+00	\N	\N	2021-11-08 10:20:56.645+00	2021-11-08 10:20:56.798+00
4833	\N	died	2021-11-08 10:19:17.046+00	\N	\N	2021-11-08 10:20:16.466+00	2021-11-08 10:20:16.817+00
4839	\N	died	2021-11-08 10:19:17.312+00	\N	\N	2021-11-08 10:20:16.801+00	2021-11-08 10:20:17.019+00
4987	\N	died	2021-11-08 10:19:25.379+00	\N	\N	2021-11-08 10:20:22.445+00	2021-11-08 10:20:22.755+00
4847	\N	died	2021-11-08 10:19:17.627+00	\N	\N	2021-11-08 10:20:16.97+00	2021-11-08 10:20:17.138+00
4853	\N	died	2021-11-08 10:19:17.96+00	\N	\N	2021-11-08 10:20:17.124+00	2021-11-08 10:20:17.193+00
5164	\N	died	2021-11-08 10:19:36.273+00	\N	\N	2021-11-08 10:20:26.921+00	2021-11-08 10:20:27.173+00
4856	\N	died	2021-11-08 10:19:18.084+00	\N	\N	2021-11-08 10:20:17.188+00	2021-11-08 10:20:17.599+00
4865	\N	died	2021-11-08 10:19:18.685+00	\N	\N	2021-11-08 10:20:17.42+00	2021-11-08 10:20:17.858+00
4998	\N	died	2021-11-08 10:19:25.869+00	\N	\N	2021-11-08 10:20:22.749+00	2021-11-08 10:20:23.007+00
5174	\N	died	2021-11-08 10:19:37.038+00	\N	\N	2021-11-08 10:20:27.17+00	2021-11-08 10:20:27.223+00
5007	\N	died	2021-11-08 10:19:26.087+00	\N	\N	2021-11-08 10:20:22.971+00	2021-11-08 10:20:23.362+00
6133	\N	died	2021-11-08 10:20:04.893+00	\N	\N	2021-11-08 10:20:54.391+00	2021-11-08 10:20:54.484+00
5018	\N	died	2021-11-08 10:19:26.619+00	\N	\N	2021-11-08 10:20:23.271+00	2021-11-08 10:20:23.971+00
5040	\N	died	2021-11-08 10:19:27.769+00	\N	\N	2021-11-08 10:20:23.944+00	2021-11-08 10:20:24.397+00
5176	\N	died	2021-11-08 10:19:37.187+00	\N	\N	2021-11-08 10:20:27.212+00	2021-11-08 10:20:27.275+00
5058	\N	died	2021-11-08 10:19:29.111+00	\N	\N	2021-11-08 10:20:24.267+00	2021-11-08 10:20:24.545+00
6248	\N	died	2021-11-08 10:20:10.028+00	\N	\N	2021-11-08 10:20:57.324+00	2021-11-08 10:20:57.89+00
5068	\N	died	2021-11-08 10:19:29.704+00	\N	\N	2021-11-08 10:20:24.538+00	2021-11-08 10:20:24.605+00
5071	\N	died	2021-11-08 10:19:29.854+00	\N	\N	2021-11-08 10:20:24.598+00	2021-11-08 10:20:24.679+00
5179	\N	died	2021-11-08 10:19:37.339+00	\N	\N	2021-11-08 10:20:27.271+00	2021-11-08 10:20:27.417+00
5075	\N	died	2021-11-08 10:19:30.18+00	\N	\N	2021-11-08 10:20:24.672+00	2021-11-08 10:20:25.034+00
5081	\N	died	2021-11-08 10:19:30.613+00	\N	\N	2021-11-08 10:20:24.845+00	2021-11-08 10:20:25.149+00
6137	\N	died	2021-11-08 10:20:05.027+00	\N	\N	2021-11-08 10:20:54.474+00	2021-11-08 10:20:54.594+00
5094	\N	died	2021-11-08 10:19:31.321+00	\N	\N	2021-11-08 10:20:25.146+00	2021-11-08 10:20:25.363+00
5101	\N	died	2021-11-08 10:19:31.679+00	\N	\N	2021-11-08 10:20:25.254+00	2021-11-08 10:20:25.895+00
5183	\N	died	2021-11-08 10:19:37.856+00	\N	\N	2021-11-08 10:20:27.413+00	2021-11-08 10:20:27.583+00
5189	\N	died	2021-11-08 10:19:38.347+00	\N	\N	2021-11-08 10:20:27.579+00	2021-11-08 10:20:27.635+00
6141	\N	died	2021-11-08 10:20:05.354+00	\N	\N	2021-11-08 10:20:54.583+00	2021-11-08 10:20:54.83+00
5192	\N	died	2021-11-08 10:19:38.751+00	\N	\N	2021-11-08 10:20:27.631+00	2021-11-08 10:20:27.729+00
6225	\N	died	2021-11-08 10:20:09.168+00	\N	\N	2021-11-08 10:20:56.758+00	2021-11-08 10:20:57.037+00
5197	\N	died	2021-11-08 10:19:39.156+00	\N	\N	2021-11-08 10:20:27.721+00	2021-11-08 10:20:27.839+00
5199	\N	died	2021-11-08 10:19:39.305+00	\N	\N	2021-11-08 10:20:27.824+00	2021-11-08 10:20:27.918+00
6151	\N	died	2021-11-08 10:20:05.605+00	\N	\N	2021-11-08 10:20:54.757+00	2021-11-08 10:20:55.16+00
5203	\N	died	2021-11-08 10:19:39.939+00	\N	\N	2021-11-08 10:20:27.914+00	2021-11-08 10:20:28.12+00
5212	\N	died	2021-11-08 10:19:41.03+00	\N	\N	2021-11-08 10:20:28.106+00	2021-11-08 10:20:28.189+00
5215	\N	died	2021-11-08 10:19:41.281+00	\N	\N	2021-11-08 10:20:28.182+00	2021-11-08 10:20:28.228+00
6167	\N	died	2021-11-08 10:20:06.053+00	\N	\N	2021-11-08 10:20:55.12+00	2021-11-08 10:20:55.469+00
5217	\N	died	2021-11-08 10:19:41.496+00	\N	\N	2021-11-08 10:20:28.222+00	2021-11-08 10:20:28.305+00
5221	\N	died	2021-11-08 10:19:41.847+00	\N	\N	2021-11-08 10:20:28.297+00	2021-11-08 10:20:28.377+00
6179	\N	died	2021-11-08 10:20:06.945+00	\N	\N	2021-11-08 10:20:55.45+00	2021-11-08 10:20:56.089+00
5225	\N	died	2021-11-08 10:19:42.298+00	\N	\N	2021-11-08 10:20:28.372+00	2021-11-08 10:20:28.449+00
6268	\N	died	2021-11-08 10:20:10.594+00	\N	\N	2021-11-08 10:20:57.852+00	2021-11-08 10:20:58.857+00
6195	\N	died	2021-11-08 10:20:07.775+00	\N	\N	2021-11-08 10:20:55.943+00	2021-11-08 10:20:56.523+00
6329	\N	died	2021-11-08 10:20:12.577+00	\N	\N	2021-11-08 10:20:59.549+00	2021-11-08 10:20:59.918+00
6210	\N	died	2021-11-08 10:20:08.245+00	\N	\N	2021-11-08 10:20:56.4+00	2021-11-08 10:20:56.658+00
6236	\N	died	2021-11-08 10:20:09.71+00	\N	\N	2021-11-08 10:20:57.032+00	2021-11-08 10:20:57.124+00
6364	\N	died	2021-11-08 10:20:13.533+00	\N	\N	2021-11-08 10:21:00.683+00	2021-11-08 10:21:00.834+00
6240	\N	died	2021-11-08 10:20:09.793+00	\N	\N	2021-11-08 10:20:57.116+00	2021-11-08 10:20:57.363+00
6293	\N	died	2021-11-08 10:20:11.563+00	\N	\N	2021-11-08 10:20:58.717+00	2021-11-08 10:20:59.038+00
6340	\N	died	2021-11-08 10:20:12.762+00	\N	\N	2021-11-08 10:20:59.842+00	2021-11-08 10:21:00.119+00
6306	\N	died	2021-11-08 10:20:11.877+00	\N	\N	2021-11-08 10:20:59.033+00	2021-11-08 10:20:59.202+00
6313	\N	died	2021-11-08 10:20:12.147+00	\N	\N	2021-11-08 10:20:59.15+00	2021-11-08 10:20:59.672+00
6417	\N	died	2021-11-08 10:20:16.104+00	\N	\N	2021-11-08 10:21:01.859+00	2021-11-08 10:21:02.268+00
6350	\N	died	2021-11-08 10:20:13.077+00	\N	\N	2021-11-08 10:21:00.102+00	2021-11-08 10:21:00.637+00
6385	\N	died	2021-11-08 10:20:14.46+00	\N	\N	2021-11-08 10:21:01.085+00	2021-11-08 10:21:01.395+00
6360	\N	died	2021-11-08 10:20:13.374+00	\N	\N	2021-11-08 10:21:00.594+00	2021-11-08 10:21:00.688+00
6369	\N	died	2021-11-08 10:20:13.811+00	\N	\N	2021-11-08 10:21:00.784+00	2021-11-08 10:21:01.261+00
6396	\N	died	2021-11-08 10:20:15.543+00	\N	\N	2021-11-08 10:21:01.391+00	2021-11-08 10:21:01.689+00
6403	\N	died	2021-11-08 10:20:15.763+00	\N	\N	2021-11-08 10:21:01.608+00	2021-11-08 10:21:01.869+00
6424	\N	died	2021-11-08 10:20:16.263+00	\N	\N	2021-11-08 10:21:02.177+00	2021-11-08 10:21:02.664+00
6441	\N	died	2021-11-08 10:20:16.588+00	\N	\N	2021-11-08 10:21:02.626+00	2021-11-08 10:21:03.163+00
6457	\N	died	2021-11-08 10:20:16.643+00	\N	\N	2021-11-08 10:21:03.108+00	2021-11-08 10:21:03.363+00
4480	\N	died	2021-11-08 10:19:08.243+00	\N	\N	2021-11-08 10:20:04.793+00	2021-11-08 10:20:05.375+00
4501	\N	died	2021-11-08 10:19:08.307+00	\N	\N	2021-11-08 10:20:05.357+00	2021-11-08 10:20:05.499+00
4941	\N	died	2021-11-08 10:19:22.493+00	\N	\N	2021-11-08 10:20:20.774+00	2021-11-08 10:20:21.058+00
4506	\N	died	2021-11-08 10:19:08.391+00	\N	\N	2021-11-08 10:20:05.462+00	2021-11-08 10:20:05.727+00
5168	\N	died	2021-11-08 10:19:36.497+00	\N	\N	2021-11-08 10:20:26.995+00	2021-11-08 10:20:27.417+00
4515	\N	died	2021-11-08 10:19:08.658+00	\N	\N	2021-11-08 10:20:05.687+00	2021-11-08 10:20:06.669+00
4534	\N	died	2021-11-08 10:19:09.216+00	\N	\N	2021-11-08 10:20:06.53+00	2021-11-08 10:20:07.836+00
4955	\N	died	2021-11-08 10:19:23.377+00	\N	\N	2021-11-08 10:20:21.055+00	2021-11-08 10:20:21.288+00
4554	\N	died	2021-11-08 10:19:09.716+00	\N	\N	2021-11-08 10:20:07.602+00	2021-11-08 10:20:08.184+00
4567	\N	died	2021-11-08 10:19:10.628+00	\N	\N	2021-11-08 10:20:08.156+00	2021-11-08 10:20:08.705+00
4583	\N	died	2021-11-08 10:19:11.111+00	\N	\N	2021-11-08 10:20:08.611+00	2021-11-08 10:20:09.12+00
4962	\N	died	2021-11-08 10:19:23.836+00	\N	\N	2021-11-08 10:20:21.285+00	2021-11-08 10:20:21.632+00
4596	\N	died	2021-11-08 10:19:11.42+00	\N	\N	2021-11-08 10:20:08.967+00	2021-11-08 10:20:09.343+00
4607	\N	died	2021-11-08 10:19:11.451+00	\N	\N	2021-11-08 10:20:09.183+00	2021-11-08 10:20:09.734+00
4623	\N	died	2021-11-08 10:19:11.625+00	\N	\N	2021-11-08 10:20:09.662+00	2021-11-08 10:20:10.172+00
4972	\N	died	2021-11-08 10:19:24.578+00	\N	\N	2021-11-08 10:20:21.614+00	2021-11-08 10:20:22.653+00
4643	\N	died	2021-11-08 10:19:12.15+00	\N	\N	2021-11-08 10:20:10.137+00	2021-11-08 10:20:10.819+00
5182	\N	died	2021-11-08 10:19:37.756+00	\N	\N	2021-11-08 10:20:27.393+00	2021-11-08 10:20:27.635+00
4663	\N	died	2021-11-08 10:19:12.967+00	\N	\N	2021-11-08 10:20:10.645+00	2021-11-08 10:20:11.035+00
4676	\N	died	2021-11-08 10:19:13.401+00	\N	\N	2021-11-08 10:20:10.96+00	2021-11-08 10:20:11.676+00
4993	\N	died	2021-11-08 10:19:25.645+00	\N	\N	2021-11-08 10:20:22.636+00	2021-11-08 10:20:22.939+00
4688	\N	died	2021-11-08 10:19:13.884+00	\N	\N	2021-11-08 10:20:11.65+00	2021-11-08 10:20:12.068+00
6168	\N	died	2021-11-08 10:20:06.081+00	\N	\N	2021-11-08 10:20:55.152+00	2021-11-08 10:20:55.298+00
4703	\N	died	2021-11-08 10:19:14.352+00	\N	\N	2021-11-08 10:20:12.027+00	2021-11-08 10:20:12.449+00
4720	\N	died	2021-11-08 10:19:14.532+00	\N	\N	2021-11-08 10:20:12.412+00	2021-11-08 10:20:13.034+00
5000	\N	died	2021-11-08 10:19:25.905+00	\N	\N	2021-11-08 10:20:22.776+00	2021-11-08 10:20:23.191+00
4739	\N	died	2021-11-08 10:19:15.077+00	\N	\N	2021-11-08 10:20:12.923+00	2021-11-08 10:20:13.451+00
4756	\N	died	2021-11-08 10:19:15.526+00	\N	\N	2021-11-08 10:20:13.442+00	2021-11-08 10:20:13.829+00
4766	\N	died	2021-11-08 10:19:15.661+00	\N	\N	2021-11-08 10:20:13.825+00	2021-11-08 10:20:13.921+00
5014	\N	died	2021-11-08 10:19:26.404+00	\N	\N	2021-11-08 10:20:23.183+00	2021-11-08 10:20:23.519+00
4769	\N	died	2021-11-08 10:19:15.793+00	\N	\N	2021-11-08 10:20:13.879+00	2021-11-08 10:20:14.205+00
5191	\N	died	2021-11-08 10:19:38.53+00	\N	\N	2021-11-08 10:20:27.613+00	2021-11-08 10:20:27.865+00
4776	\N	died	2021-11-08 10:19:15.909+00	\N	\N	2021-11-08 10:20:14.121+00	2021-11-08 10:20:14.468+00
4788	\N	died	2021-11-08 10:19:16.052+00	\N	\N	2021-11-08 10:20:14.442+00	2021-11-08 10:20:14.944+00
5021	\N	died	2021-11-08 10:19:26.753+00	\N	\N	2021-11-08 10:20:23.465+00	2021-11-08 10:20:23.971+00
4802	\N	died	2021-11-08 10:19:16.196+00	\N	\N	2021-11-08 10:20:14.895+00	2021-11-08 10:20:16.088+00
6254	\N	died	2021-11-08 10:20:10.22+00	\N	\N	2021-11-08 10:20:57.5+00	2021-11-08 10:20:57.598+00
4821	\N	died	2021-11-08 10:19:16.735+00	\N	\N	2021-11-08 10:20:15.954+00	2021-11-08 10:20:16.817+00
4837	\N	died	2021-11-08 10:19:17.293+00	\N	\N	2021-11-08 10:20:16.786+00	2021-11-08 10:20:16.89+00
5038	\N	died	2021-11-08 10:19:27.67+00	\N	\N	2021-11-08 10:20:23.889+00	2021-11-08 10:20:24.134+00
4845	\N	died	2021-11-08 10:19:17.529+00	\N	\N	2021-11-08 10:20:16.886+00	2021-11-08 10:20:17.019+00
4849	\N	died	2021-11-08 10:19:17.711+00	\N	\N	2021-11-08 10:20:17.012+00	2021-11-08 10:20:17.095+00
4852	\N	died	2021-11-08 10:19:17.86+00	\N	\N	2021-11-08 10:20:17.077+00	2021-11-08 10:20:17.155+00
5051	\N	died	2021-11-08 10:19:28.629+00	\N	\N	2021-11-08 10:20:24.13+00	2021-11-08 10:20:24.213+00
4854	\N	died	2021-11-08 10:19:18.018+00	\N	\N	2021-11-08 10:20:17.15+00	2021-11-08 10:20:17.345+00
5200	\N	died	2021-11-08 10:19:39.373+00	\N	\N	2021-11-08 10:20:27.857+00	2021-11-08 10:20:28.12+00
4860	\N	died	2021-11-08 10:19:18.327+00	\N	\N	2021-11-08 10:20:17.322+00	2021-11-08 10:20:18.547+00
4882	\N	died	2021-11-08 10:19:19.635+00	\N	\N	2021-11-08 10:20:18.284+00	2021-11-08 10:20:18.946+00
5054	\N	died	2021-11-08 10:19:28.895+00	\N	\N	2021-11-08 10:20:24.18+00	2021-11-08 10:20:24.528+00
4894	\N	died	2021-11-08 10:19:20.219+00	\N	\N	2021-11-08 10:20:18.89+00	2021-11-08 10:20:19.584+00
4909	\N	died	2021-11-08 10:19:20.818+00	\N	\N	2021-11-08 10:20:19.499+00	2021-11-08 10:20:20.568+00
4925	\N	died	2021-11-08 10:19:21.544+00	\N	\N	2021-11-08 10:20:20.249+00	2021-11-08 10:20:20.663+00
5205	\N	died	2021-11-08 10:19:40.055+00	\N	\N	2021-11-08 10:20:27.957+00	2021-11-08 10:20:28.212+00
4934	\N	died	2021-11-08 10:19:22.019+00	\N	\N	2021-11-08 10:20:20.623+00	2021-11-08 10:20:20.902+00
6175	\N	died	2021-11-08 10:20:06.661+00	\N	\N	2021-11-08 10:20:55.292+00	2021-11-08 10:20:55.469+00
5066	\N	died	2021-11-08 10:19:29.596+00	\N	\N	2021-11-08 10:20:24.495+00	2021-11-08 10:20:24.621+00
5216	\N	died	2021-11-08 10:19:41.364+00	\N	\N	2021-11-08 10:20:28.205+00	2021-11-08 10:20:28.305+00
5072	\N	died	2021-11-08 10:19:29.995+00	\N	\N	2021-11-08 10:20:24.615+00	2021-11-08 10:20:24.744+00
6384	\N	died	2021-11-08 10:20:14.394+00	\N	\N	2021-11-08 10:21:01.068+00	2021-11-08 10:21:01.37+00
5079	\N	died	2021-11-08 10:19:30.478+00	\N	\N	2021-11-08 10:20:24.741+00	2021-11-08 10:20:25.063+00
5089	\N	died	2021-11-08 10:19:31.07+00	\N	\N	2021-11-08 10:20:25.05+00	2021-11-08 10:20:25.133+00
5219	\N	died	2021-11-08 10:19:41.706+00	\N	\N	2021-11-08 10:20:28.257+00	2021-11-08 10:20:28.449+00
5092	\N	died	2021-11-08 10:19:31.204+00	\N	\N	2021-11-08 10:20:25.112+00	2021-11-08 10:20:25.363+00
5099	\N	died	2021-11-08 10:19:31.578+00	\N	\N	2021-11-08 10:20:25.22+00	2021-11-08 10:20:25.59+00
5114	\N	died	2021-11-08 10:19:32.837+00	\N	\N	2021-11-08 10:20:25.586+00	2021-11-08 10:20:25.895+00
5227	\N	died	2021-11-08 10:19:42.33+00	\N	\N	2021-11-08 10:20:28.413+00	2021-11-08 10:20:28.704+00
5121	\N	died	2021-11-08 10:19:33.438+00	\N	\N	2021-11-08 10:20:25.738+00	2021-11-08 10:20:26.264+00
6180	\N	died	2021-11-08 10:20:06.986+00	\N	\N	2021-11-08 10:20:55.466+00	2021-11-08 10:20:55.494+00
5137	\N	died	2021-11-08 10:19:34.545+00	\N	\N	2021-11-08 10:20:26.231+00	2021-11-08 10:20:26.582+00
5150	\N	died	2021-11-08 10:19:35.305+00	\N	\N	2021-11-08 10:20:26.561+00	2021-11-08 10:20:27.173+00
5239	\N	died	2021-11-08 10:19:42.664+00	\N	\N	2021-11-08 10:20:28.695+00	2021-11-08 10:20:28.952+00
6182	\N	died	2021-11-08 10:20:07.099+00	\N	\N	2021-11-08 10:20:55.49+00	2021-11-08 10:20:55.695+00
5249	\N	died	2021-11-08 10:19:42.997+00	\N	\N	2021-11-08 10:20:28.937+00	2021-11-08 10:20:28.984+00
6257	\N	died	2021-11-08 10:20:10.294+00	\N	\N	2021-11-08 10:20:57.558+00	2021-11-08 10:20:57.89+00
5251	\N	died	2021-11-08 10:19:43.038+00	\N	\N	2021-11-08 10:20:28.98+00	2021-11-08 10:20:29.05+00
5255	\N	died	2021-11-08 10:19:43.189+00	\N	\N	2021-11-08 10:20:29.044+00	2021-11-08 10:20:29.143+00
6186	\N	died	2021-11-08 10:20:07.271+00	\N	\N	2021-11-08 10:20:55.61+00	2021-11-08 10:20:56.089+00
5259	\N	died	2021-11-08 10:19:43.38+00	\N	\N	2021-11-08 10:20:29.135+00	2021-11-08 10:20:29.301+00
5263	\N	died	2021-11-08 10:19:43.528+00	\N	\N	2021-11-08 10:20:29.294+00	2021-11-08 10:20:29.409+00
5268	\N	died	2021-11-08 10:19:43.806+00	\N	\N	2021-11-08 10:20:29.403+00	2021-11-08 10:20:29.46+00
6196	\N	died	2021-11-08 10:20:07.818+00	\N	\N	2021-11-08 10:20:55.977+00	2021-11-08 10:20:56.523+00
5271	\N	died	2021-11-08 10:19:43.907+00	\N	\N	2021-11-08 10:20:29.455+00	2021-11-08 10:20:29.606+00
6279	\N	died	2021-11-08 10:20:10.894+00	\N	\N	2021-11-08 10:20:58.335+00	2021-11-08 10:20:58.644+00
5275	\N	died	2021-11-08 10:19:44.008+00	\N	\N	2021-11-08 10:20:29.602+00	2021-11-08 10:20:29.853+00
5283	\N	died	2021-11-08 10:19:44.192+00	\N	\N	2021-11-08 10:20:29.84+00	2021-11-08 10:20:29.898+00
6214	\N	died	2021-11-08 10:20:08.519+00	\N	\N	2021-11-08 10:20:56.449+00	2021-11-08 10:20:57.021+00
5286	\N	died	2021-11-08 10:19:44.265+00	\N	\N	2021-11-08 10:20:29.894+00	2021-11-08 10:20:30.083+00
6230	\N	died	2021-11-08 10:20:09.485+00	\N	\N	2021-11-08 10:20:56.894+00	2021-11-08 10:20:57.363+00
6288	\N	died	2021-11-08 10:20:11.069+00	\N	\N	2021-11-08 10:20:58.55+00	2021-11-08 10:20:59.021+00
6243	\N	died	2021-11-08 10:20:09.927+00	\N	\N	2021-11-08 10:20:57.241+00	2021-11-08 10:20:57.504+00
6265	\N	died	2021-11-08 10:20:10.535+00	\N	\N	2021-11-08 10:20:57.766+00	2021-11-08 10:20:58.216+00
6311	\N	died	2021-11-08 10:20:12.088+00	\N	\N	2021-11-08 10:20:59.116+00	2021-11-08 10:20:59.447+00
6276	\N	died	2021-11-08 10:20:10.828+00	\N	\N	2021-11-08 10:20:58.201+00	2021-11-08 10:20:58.374+00
6392	\N	died	2021-11-08 10:20:14.814+00	\N	\N	2021-11-08 10:21:01.309+00	2021-11-08 10:21:01.689+00
6330	\N	died	2021-11-08 10:20:12.594+00	\N	\N	2021-11-08 10:20:59.567+00	2021-11-08 10:20:59.943+00
6302	\N	died	2021-11-08 10:20:11.793+00	\N	\N	2021-11-08 10:20:58.966+00	2021-11-08 10:20:59.202+00
6321	\N	died	2021-11-08 10:20:12.411+00	\N	\N	2021-11-08 10:20:59.383+00	2021-11-08 10:20:59.672+00
6358	\N	died	2021-11-08 10:20:13.282+00	\N	\N	2021-11-08 10:21:00.558+00	2021-11-08 10:21:01.036+00
6344	\N	died	2021-11-08 10:20:12.922+00	\N	\N	2021-11-08 10:20:59.933+00	2021-11-08 10:21:00.023+00
6348	\N	died	2021-11-08 10:20:13.047+00	\N	\N	2021-11-08 10:21:00.019+00	2021-11-08 10:21:00.58+00
6440	\N	died	2021-11-08 10:20:16.587+00	\N	\N	2021-11-08 10:21:02.602+00	2021-11-08 10:21:03.163+00
6380	\N	died	2021-11-08 10:20:14.169+00	\N	\N	2021-11-08 10:21:01.033+00	2021-11-08 10:21:01.071+00
6401	\N	died	2021-11-08 10:20:15.661+00	\N	\N	2021-11-08 10:21:01.56+00	2021-11-08 10:21:02.268+00
6421	\N	died	2021-11-08 10:20:16.185+00	\N	\N	2021-11-08 10:21:02.008+00	2021-11-08 10:21:02.387+00
6433	\N	died	2021-11-08 10:20:16.45+00	\N	\N	2021-11-08 10:21:02.369+00	2021-11-08 10:21:02.664+00
6455	\N	died	2021-11-08 10:20:16.64+00	\N	\N	2021-11-08 10:21:03.068+00	2021-11-08 10:21:03.537+00
6471	\N	died	2021-11-08 10:20:16.668+00	\N	\N	2021-11-08 10:21:03.358+00	2021-11-08 10:21:03.537+00
4660	\N	died	2021-11-08 10:19:12.818+00	\N	\N	2021-11-08 10:20:10.595+00	2021-11-08 10:20:10.819+00
5022	\N	died	2021-11-08 10:19:26.803+00	\N	\N	2021-11-08 10:20:23.497+00	2021-11-08 10:20:23.984+00
4668	\N	died	2021-11-08 10:19:13.059+00	\N	\N	2021-11-08 10:20:10.813+00	2021-11-08 10:20:10.901+00
5279	\N	died	2021-11-08 10:19:44.096+00	\N	\N	2021-11-08 10:20:29.688+00	2021-11-08 10:20:30.484+00
4672	\N	died	2021-11-08 10:19:13.251+00	\N	\N	2021-11-08 10:20:10.896+00	2021-11-08 10:20:11.035+00
4675	\N	died	2021-11-08 10:19:13.334+00	\N	\N	2021-11-08 10:20:10.943+00	2021-11-08 10:20:11.676+00
5042	\N	died	2021-11-08 10:19:27.919+00	\N	\N	2021-11-08 10:20:23.979+00	2021-11-08 10:20:24.117+00
4684	\N	died	2021-11-08 10:19:13.693+00	\N	\N	2021-11-08 10:20:11.18+00	2021-11-08 10:20:11.846+00
4695	\N	died	2021-11-08 10:19:14.118+00	\N	\N	2021-11-08 10:20:11.794+00	2021-11-08 10:20:12.225+00
4708	\N	died	2021-11-08 10:19:14.487+00	\N	\N	2021-11-08 10:20:12.172+00	2021-11-08 10:20:12.449+00
5049	\N	died	2021-11-08 10:19:28.471+00	\N	\N	2021-11-08 10:20:24.099+00	2021-11-08 10:20:24.397+00
4717	\N	died	2021-11-08 10:19:14.523+00	\N	\N	2021-11-08 10:20:12.338+00	2021-11-08 10:20:12.617+00
4728	\N	died	2021-11-08 10:19:14.676+00	\N	\N	2021-11-08 10:20:12.595+00	2021-11-08 10:20:13.034+00
4736	\N	died	2021-11-08 10:19:14.835+00	\N	\N	2021-11-08 10:20:12.765+00	2021-11-08 10:20:13.271+00
5059	\N	died	2021-11-08 10:19:29.161+00	\N	\N	2021-11-08 10:20:24.292+00	2021-11-08 10:20:24.679+00
4749	\N	died	2021-11-08 10:19:15.295+00	\N	\N	2021-11-08 10:20:13.142+00	2021-11-08 10:20:13.816+00
5296	\N	died	2021-11-08 10:19:44.523+00	\N	\N	2021-11-08 10:20:30.469+00	2021-11-08 10:20:30.945+00
4757	\N	died	2021-11-08 10:19:15.543+00	\N	\N	2021-11-08 10:20:13.468+00	2021-11-08 10:20:13.864+00
4768	\N	died	2021-11-08 10:19:15.777+00	\N	\N	2021-11-08 10:20:13.861+00	2021-11-08 10:20:14.068+00
5074	\N	died	2021-11-08 10:19:30.088+00	\N	\N	2021-11-08 10:20:24.649+00	2021-11-08 10:20:25.034+00
4772	\N	died	2021-11-08 10:19:15.828+00	\N	\N	2021-11-08 10:20:14.027+00	2021-11-08 10:20:14.382+00
4782	\N	died	2021-11-08 10:19:16.027+00	\N	\N	2021-11-08 10:20:14.323+00	2021-11-08 10:20:14.563+00
4790	\N	died	2021-11-08 10:19:16.057+00	\N	\N	2021-11-08 10:20:14.477+00	2021-11-08 10:20:14.944+00
5086	\N	died	2021-11-08 10:19:30.895+00	\N	\N	2021-11-08 10:20:24.976+00	2021-11-08 10:20:25.375+00
4799	\N	died	2021-11-08 10:19:16.168+00	\N	\N	2021-11-08 10:20:14.77+00	2021-11-08 10:20:15.853+00
4815	\N	died	2021-11-08 10:19:16.493+00	\N	\N	2021-11-08 10:20:15.816+00	2021-11-08 10:20:16.193+00
4829	\N	died	2021-11-08 10:19:16.912+00	\N	\N	2021-11-08 10:20:16.188+00	2021-11-08 10:20:16.593+00
5104	\N	died	2021-11-08 10:19:31.897+00	\N	\N	2021-11-08 10:20:25.371+00	2021-11-08 10:20:25.49+00
4834	\N	died	2021-11-08 10:19:17.078+00	\N	\N	2021-11-08 10:20:16.497+00	2021-11-08 10:20:16.89+00
5304	\N	died	2021-11-08 10:19:44.699+00	\N	\N	2021-11-08 10:20:30.92+00	2021-11-08 10:20:31.017+00
4844	\N	died	2021-11-08 10:19:17.47+00	\N	\N	2021-11-08 10:20:16.865+00	2021-11-08 10:20:17.599+00
4864	\N	died	2021-11-08 10:19:18.552+00	\N	\N	2021-11-08 10:20:17.388+00	2021-11-08 10:20:17.858+00
5109	\N	died	2021-11-08 10:19:32.296+00	\N	\N	2021-11-08 10:20:25.455+00	2021-11-08 10:20:25.895+00
4875	\N	died	2021-11-08 10:19:19.286+00	\N	\N	2021-11-08 10:20:17.739+00	2021-11-08 10:20:18.547+00
4883	\N	died	2021-11-08 10:19:19.685+00	\N	\N	2021-11-08 10:20:18.431+00	2021-11-08 10:20:18.995+00
4896	\N	died	2021-11-08 10:19:20.285+00	\N	\N	2021-11-08 10:20:18.982+00	2021-11-08 10:20:19.193+00
5120	\N	died	2021-11-08 10:19:33.38+00	\N	\N	2021-11-08 10:20:25.721+00	2021-11-08 10:20:26.083+00
4899	\N	died	2021-11-08 10:19:20.341+00	\N	\N	2021-11-08 10:20:19.074+00	2021-11-08 10:20:19.618+00
4912	\N	died	2021-11-08 10:19:20.952+00	\N	\N	2021-11-08 10:20:19.608+00	2021-11-08 10:20:19.837+00
4916	\N	died	2021-11-08 10:19:21.086+00	\N	\N	2021-11-08 10:20:19.819+00	2021-11-08 10:20:20.205+00
5133	\N	died	2021-11-08 10:19:34.263+00	\N	\N	2021-11-08 10:20:26.063+00	2021-11-08 10:20:26.582+00
4922	\N	died	2021-11-08 10:19:21.428+00	\N	\N	2021-11-08 10:20:19.996+00	2021-11-08 10:20:20.681+00
5307	\N	died	2021-11-08 10:19:44.771+00	\N	\N	2021-11-08 10:20:31.006+00	2021-11-08 10:20:31.078+00
4936	\N	died	2021-11-08 10:19:22.169+00	\N	\N	2021-11-08 10:20:20.675+00	2021-11-08 10:20:20.902+00
4943	\N	died	2021-11-08 10:19:22.627+00	\N	\N	2021-11-08 10:20:20.822+00	2021-11-08 10:20:21.269+00
5147	\N	died	2021-11-08 10:19:35.162+00	\N	\N	2021-11-08 10:20:26.513+00	2021-11-08 10:20:26.893+00
4961	\N	died	2021-11-08 10:19:23.786+00	\N	\N	2021-11-08 10:20:21.253+00	2021-11-08 10:20:21.632+00
4970	\N	died	2021-11-08 10:19:24.353+00	\N	\N	2021-11-08 10:20:21.427+00	2021-11-08 10:20:22.419+00
4982	\N	died	2021-11-08 10:19:25.111+00	\N	\N	2021-11-08 10:20:22.343+00	2021-11-08 10:20:22.615+00
5162	\N	died	2021-11-08 10:19:36.047+00	\N	\N	2021-11-08 10:20:26.883+00	2021-11-08 10:20:27.173+00
4990	\N	died	2021-11-08 10:19:25.478+00	\N	\N	2021-11-08 10:20:22.552+00	2021-11-08 10:20:22.939+00
5002	\N	died	2021-11-08 10:19:25.922+00	\N	\N	2021-11-08 10:20:22.88+00	2021-11-08 10:20:23.519+00
5311	\N	died	2021-11-08 10:19:44.845+00	\N	\N	2021-11-08 10:20:31.075+00	2021-11-08 10:20:31.384+00
5172	\N	died	2021-11-08 10:19:36.938+00	\N	\N	2021-11-08 10:20:27.138+00	2021-11-08 10:20:27.599+00
5190	\N	died	2021-11-08 10:19:38.397+00	\N	\N	2021-11-08 10:20:27.596+00	2021-11-08 10:20:27.729+00
5323	\N	died	2021-11-08 10:19:44.899+00	\N	\N	2021-11-08 10:20:31.371+00	2021-11-08 10:20:31.645+00
5195	\N	died	2021-11-08 10:19:38.949+00	\N	\N	2021-11-08 10:20:27.677+00	2021-11-08 10:20:28.12+00
5211	\N	died	2021-11-08 10:19:40.964+00	\N	\N	2021-11-08 10:20:28.081+00	2021-11-08 10:20:28.548+00
5234	\N	died	2021-11-08 10:19:42.522+00	\N	\N	2021-11-08 10:20:28.543+00	2021-11-08 10:20:28.729+00
5333	\N	died	2021-11-08 10:19:45.042+00	\N	\N	2021-11-08 10:20:31.629+00	2021-11-08 10:20:31.695+00
5240	\N	died	2021-11-08 10:19:42.681+00	\N	\N	2021-11-08 10:20:28.723+00	2021-11-08 10:20:28.966+00
5250	\N	died	2021-11-08 10:19:42.998+00	\N	\N	2021-11-08 10:20:28.96+00	2021-11-08 10:20:29.05+00
5253	\N	died	2021-11-08 10:19:43.081+00	\N	\N	2021-11-08 10:20:29.01+00	2021-11-08 10:20:29.301+00
5261	\N	died	2021-11-08 10:19:43.524+00	\N	\N	2021-11-08 10:20:29.239+00	2021-11-08 10:20:29.547+00
5272	\N	died	2021-11-08 10:19:43.931+00	\N	\N	2021-11-08 10:20:29.529+00	2021-11-08 10:20:29.853+00
5335	\N	died	2021-11-08 10:19:45.071+00	\N	\N	2021-11-08 10:20:31.686+00	2021-11-08 10:20:31.809+00
5337	\N	died	2021-11-08 10:19:45.106+00	\N	\N	2021-11-08 10:20:31.787+00	2021-11-08 10:20:31.899+00
5341	\N	died	2021-11-08 10:19:45.155+00	\N	\N	2021-11-08 10:20:31.894+00	2021-11-08 10:20:32.166+00
5345	\N	died	2021-11-08 10:19:45.261+00	\N	\N	2021-11-08 10:20:32.153+00	2021-11-08 10:20:32.323+00
4780	\N	died	2021-11-08 10:19:15.995+00	\N	\N	2021-11-08 10:20:14.186+00	2021-11-08 10:20:14.382+00
4785	\N	died	2021-11-08 10:19:16.045+00	\N	\N	2021-11-08 10:20:14.376+00	2021-11-08 10:20:14.468+00
4789	\N	died	2021-11-08 10:19:16.056+00	\N	\N	2021-11-08 10:20:14.461+00	2021-11-08 10:20:14.683+00
4793	\N	died	2021-11-08 10:19:16.066+00	\N	\N	2021-11-08 10:20:14.601+00	2021-11-08 10:20:15.193+00
5180	\N	died	2021-11-08 10:19:37.505+00	\N	\N	2021-11-08 10:20:27.289+00	2021-11-08 10:20:27.583+00
4804	\N	died	2021-11-08 10:19:16.209+00	\N	\N	2021-11-08 10:20:14.971+00	2021-11-08 10:20:15.625+00
4808	\N	died	2021-11-08 10:19:16.311+00	\N	\N	2021-11-08 10:20:15.604+00	2021-11-08 10:20:16.088+00
4820	\N	died	2021-11-08 10:19:16.719+00	\N	\N	2021-11-08 10:20:15.933+00	2021-11-08 10:20:16.817+00
5187	\N	died	2021-11-08 10:19:38.205+00	\N	\N	2021-11-08 10:20:27.548+00	2021-11-08 10:20:27.933+00
4840	\N	died	2021-11-08 10:19:17.331+00	\N	\N	2021-11-08 10:20:16.817+00	2021-11-08 10:20:17.212+00
4857	\N	died	2021-11-08 10:19:18.227+00	\N	\N	2021-11-08 10:20:17.208+00	2021-11-08 10:20:17.599+00
4867	\N	died	2021-11-08 10:19:18.785+00	\N	\N	2021-11-08 10:20:17.454+00	2021-11-08 10:20:18.547+00
5204	\N	died	2021-11-08 10:19:39.989+00	\N	\N	2021-11-08 10:20:27.929+00	2021-11-08 10:20:28.189+00
4884	\N	died	2021-11-08 10:19:19.785+00	\N	\N	2021-11-08 10:20:18.481+00	2021-11-08 10:20:19.193+00
4900	\N	died	2021-11-08 10:19:20.428+00	\N	\N	2021-11-08 10:20:19.111+00	2021-11-08 10:20:19.584+00
4910	\N	died	2021-11-08 10:19:20.885+00	\N	\N	2021-11-08 10:20:19.533+00	2021-11-08 10:20:20.568+00
5214	\N	died	2021-11-08 10:19:41.154+00	\N	\N	2021-11-08 10:20:28.153+00	2021-11-08 10:20:28.377+00
4927	\N	died	2021-11-08 10:19:21.635+00	\N	\N	2021-11-08 10:20:20.402+00	2021-11-08 10:20:20.902+00
4942	\N	died	2021-11-08 10:19:22.578+00	\N	\N	2021-11-08 10:20:20.787+00	2021-11-08 10:20:21.151+00
4957	\N	died	2021-11-08 10:19:23.547+00	\N	\N	2021-11-08 10:20:21.088+00	2021-11-08 10:20:21.632+00
5222	\N	died	2021-11-08 10:19:41.981+00	\N	\N	2021-11-08 10:20:28.318+00	2021-11-08 10:20:28.535+00
4969	\N	died	2021-11-08 10:19:24.32+00	\N	\N	2021-11-08 10:20:21.406+00	2021-11-08 10:20:22.234+00
4978	\N	died	2021-11-08 10:19:24.962+00	\N	\N	2021-11-08 10:20:22.219+00	2021-11-08 10:20:22.419+00
4983	\N	died	2021-11-08 10:19:25.194+00	\N	\N	2021-11-08 10:20:22.37+00	2021-11-08 10:20:22.734+00
5230	\N	died	2021-11-08 10:19:42.414+00	\N	\N	2021-11-08 10:20:28.477+00	2021-11-08 10:20:28.952+00
4996	\N	died	2021-11-08 10:19:25.802+00	\N	\N	2021-11-08 10:20:22.695+00	2021-11-08 10:20:23.007+00
5008	\N	died	2021-11-08 10:19:26.119+00	\N	\N	2021-11-08 10:20:22.986+00	2021-11-08 10:20:23.519+00
5020	\N	died	2021-11-08 10:19:26.654+00	\N	\N	2021-11-08 10:20:23.385+00	2021-11-08 10:20:23.633+00
5242	\N	died	2021-11-08 10:19:42.757+00	\N	\N	2021-11-08 10:20:28.752+00	2021-11-08 10:20:29.001+00
5028	\N	died	2021-11-08 10:19:27.111+00	\N	\N	2021-11-08 10:20:23.625+00	2021-11-08 10:20:23.844+00
5033	\N	died	2021-11-08 10:19:27.453+00	\N	\N	2021-11-08 10:20:23.806+00	2021-11-08 10:20:24.067+00
5046	\N	died	2021-11-08 10:19:28.221+00	\N	\N	2021-11-08 10:20:24.046+00	2021-11-08 10:20:24.528+00
5252	\N	died	2021-11-08 10:19:43.057+00	\N	\N	2021-11-08 10:20:28.996+00	2021-11-08 10:20:29.143+00
5065	\N	died	2021-11-08 10:19:29.562+00	\N	\N	2021-11-08 10:20:24.415+00	2021-11-08 10:20:24.605+00
5070	\N	died	2021-11-08 10:19:29.804+00	\N	\N	2021-11-08 10:20:24.58+00	2021-11-08 10:20:24.708+00
5077	\N	died	2021-11-08 10:19:30.295+00	\N	\N	2021-11-08 10:20:24.704+00	2021-11-08 10:20:25.034+00
5257	\N	died	2021-11-08 10:19:43.193+00	\N	\N	2021-11-08 10:20:29.077+00	2021-11-08 10:20:29.46+00
5087	\N	died	2021-11-08 10:19:30.929+00	\N	\N	2021-11-08 10:20:24.995+00	2021-11-08 10:20:25.425+00
5106	\N	died	2021-11-08 10:19:31.949+00	\N	\N	2021-11-08 10:20:25.404+00	2021-11-08 10:20:25.509+00
5112	\N	died	2021-11-08 10:19:32.705+00	\N	\N	2021-11-08 10:20:25.505+00	2021-11-08 10:20:25.687+00
5270	\N	died	2021-11-08 10:19:43.824+00	\N	\N	2021-11-08 10:20:29.435+00	2021-11-08 10:20:29.853+00
5116	\N	died	2021-11-08 10:19:32.979+00	\N	\N	2021-11-08 10:20:25.647+00	2021-11-08 10:20:25.992+00
5130	\N	died	2021-11-08 10:19:34.07+00	\N	\N	2021-11-08 10:20:25.986+00	2021-11-08 10:20:26.264+00
5136	\N	died	2021-11-08 10:19:34.429+00	\N	\N	2021-11-08 10:20:26.214+00	2021-11-08 10:20:26.582+00
5277	\N	died	2021-11-08 10:19:44.073+00	\N	\N	2021-11-08 10:20:29.655+00	2021-11-08 10:20:30.155+00
5146	\N	died	2021-11-08 10:19:35.112+00	\N	\N	2021-11-08 10:20:26.49+00	2021-11-08 10:20:26.79+00
5158	\N	died	2021-11-08 10:19:35.876+00	\N	\N	2021-11-08 10:20:26.781+00	2021-11-08 10:20:27.173+00
5167	\N	died	2021-11-08 10:19:36.455+00	\N	\N	2021-11-08 10:20:26.971+00	2021-11-08 10:20:27.292+00
5290	\N	died	2021-11-08 10:19:44.293+00	\N	\N	2021-11-08 10:20:30.138+00	2021-11-08 10:20:30.453+00
5295	\N	died	2021-11-08 10:19:44.384+00	\N	\N	2021-11-08 10:20:30.435+00	2021-11-08 10:20:30.945+00
5303	\N	died	2021-11-08 10:19:44.677+00	\N	\N	2021-11-08 10:20:30.77+00	2021-11-08 10:20:31.645+00
5325	\N	died	2021-11-08 10:19:44.907+00	\N	\N	2021-11-08 10:20:31.42+00	2021-11-08 10:20:31.719+00
5336	\N	died	2021-11-08 10:19:45.089+00	\N	\N	2021-11-08 10:20:31.711+00	2021-11-08 10:20:31.899+00
5339	\N	died	2021-11-08 10:19:45.121+00	\N	\N	2021-11-08 10:20:31.861+00	2021-11-08 10:20:32.323+00
4850	\N	died	2021-11-08 10:19:17.761+00	\N	\N	2021-11-08 10:20:17.027+00	2021-11-08 10:20:17.287+00
4858	\N	died	2021-11-08 10:19:18.26+00	\N	\N	2021-11-08 10:20:17.282+00	2021-11-08 10:20:17.599+00
5258	\N	died	2021-11-08 10:19:43.194+00	\N	\N	2021-11-08 10:20:29.094+00	2021-11-08 10:20:29.606+00
4868	\N	died	2021-11-08 10:19:18.836+00	\N	\N	2021-11-08 10:20:17.536+00	2021-11-08 10:20:18.719+00
5330	\N	died	2021-11-08 10:19:44.942+00	\N	\N	2021-11-08 10:20:31.577+00	2021-11-08 10:20:32.347+00
4889	\N	died	2021-11-08 10:19:20.069+00	\N	\N	2021-11-08 10:20:18.628+00	2021-11-08 10:20:19.055+00
4898	\N	died	2021-11-08 10:19:20.338+00	\N	\N	2021-11-08 10:20:19.048+00	2021-11-08 10:20:19.584+00
5274	\N	died	2021-11-08 10:19:44.006+00	\N	\N	2021-11-08 10:20:29.588+00	2021-11-08 10:20:29.898+00
4905	\N	died	2021-11-08 10:19:20.694+00	\N	\N	2021-11-08 10:20:19.33+00	2021-11-08 10:20:19.786+00
4914	\N	died	2021-11-08 10:19:21.019+00	\N	\N	2021-11-08 10:20:19.677+00	2021-11-08 10:20:20.568+00
4930	\N	died	2021-11-08 10:19:21.785+00	\N	\N	2021-11-08 10:20:20.534+00	2021-11-08 10:20:20.949+00
5285	\N	died	2021-11-08 10:19:44.233+00	\N	\N	2021-11-08 10:20:29.877+00	2021-11-08 10:20:30.386+00
4948	\N	died	2021-11-08 10:19:22.919+00	\N	\N	2021-11-08 10:20:20.913+00	2021-11-08 10:20:21.031+00
4953	\N	died	2021-11-08 10:19:23.279+00	\N	\N	2021-11-08 10:20:21.027+00	2021-11-08 10:20:21.151+00
4958	\N	died	2021-11-08 10:19:23.579+00	\N	\N	2021-11-08 10:20:21.107+00	2021-11-08 10:20:21.632+00
5292	\N	died	2021-11-08 10:19:44.324+00	\N	\N	2021-11-08 10:20:30.235+00	2021-11-08 10:20:30.945+00
4971	\N	died	2021-11-08 10:19:24.495+00	\N	\N	2021-11-08 10:20:21.576+00	2021-11-08 10:20:22.484+00
6219	\N	died	2021-11-08 10:20:08.798+00	\N	\N	2021-11-08 10:20:56.609+00	2021-11-08 10:20:56.713+00
4989	\N	died	2021-11-08 10:19:25.461+00	\N	\N	2021-11-08 10:20:22.479+00	2021-11-08 10:20:22.734+00
4995	\N	died	2021-11-08 10:19:25.711+00	\N	\N	2021-11-08 10:20:22.679+00	2021-11-08 10:20:23.007+00
5301	\N	died	2021-11-08 10:19:44.665+00	\N	\N	2021-11-08 10:20:30.669+00	2021-11-08 10:20:31.3+00
5006	\N	died	2021-11-08 10:19:26.053+00	\N	\N	2021-11-08 10:20:22.953+00	2021-11-08 10:20:23.121+00
5012	\N	died	2021-11-08 10:19:26.305+00	\N	\N	2021-11-08 10:20:23.104+00	2021-11-08 10:20:23.362+00
5017	\N	died	2021-11-08 10:19:26.569+00	\N	\N	2021-11-08 10:20:23.246+00	2021-11-08 10:20:23.729+00
5320	\N	died	2021-11-08 10:19:44.893+00	\N	\N	2021-11-08 10:20:31.294+00	2021-11-08 10:20:31.645+00
5030	\N	died	2021-11-08 10:19:27.253+00	\N	\N	2021-11-08 10:20:23.715+00	2021-11-08 10:20:23.877+00
6414	\N	died	2021-11-08 10:20:15.988+00	\N	\N	2021-11-08 10:21:01.795+00	2021-11-08 10:21:02.268+00
5037	\N	died	2021-11-08 10:19:27.628+00	\N	\N	2021-11-08 10:20:23.872+00	2021-11-08 10:20:24.067+00
5045	\N	died	2021-11-08 10:19:28.153+00	\N	\N	2021-11-08 10:20:24.029+00	2021-11-08 10:20:24.397+00
6223	\N	died	2021-11-08 10:20:09.003+00	\N	\N	2021-11-08 10:20:56.707+00	2021-11-08 10:20:56.798+00
5063	\N	died	2021-11-08 10:19:29.471+00	\N	\N	2021-11-08 10:20:24.354+00	2021-11-08 10:20:25.034+00
5084	\N	died	2021-11-08 10:19:30.736+00	\N	\N	2021-11-08 10:20:24.928+00	2021-11-08 10:20:25.363+00
5100	\N	died	2021-11-08 10:19:31.628+00	\N	\N	2021-11-08 10:20:25.237+00	2021-11-08 10:20:25.895+00
6227	\N	died	2021-11-08 10:20:09.324+00	\N	\N	2021-11-08 10:20:56.791+00	2021-11-08 10:20:57.021+00
5119	\N	died	2021-11-08 10:19:33.271+00	\N	\N	2021-11-08 10:20:25.701+00	2021-11-08 10:20:25.96+00
5128	\N	died	2021-11-08 10:19:33.905+00	\N	\N	2021-11-08 10:20:25.955+00	2021-11-08 10:20:26.083+00
5132	\N	died	2021-11-08 10:19:34.163+00	\N	\N	2021-11-08 10:20:26.048+00	2021-11-08 10:20:26.582+00
6231	\N	died	2021-11-08 10:20:09.535+00	\N	\N	2021-11-08 10:20:56.926+00	2021-11-08 10:20:57.363+00
5145	\N	died	2021-11-08 10:19:35.064+00	\N	\N	2021-11-08 10:20:26.46+00	2021-11-08 10:20:26.699+00
6426	\N	died	2021-11-08 10:20:16.278+00	\N	\N	2021-11-08 10:21:02.235+00	2021-11-08 10:21:02.815+00
5154	\N	died	2021-11-08 10:19:35.579+00	\N	\N	2021-11-08 10:20:26.696+00	2021-11-08 10:20:26.812+00
5159	\N	died	2021-11-08 10:19:35.947+00	\N	\N	2021-11-08 10:20:26.806+00	2021-11-08 10:20:27.173+00
6245	\N	died	2021-11-08 10:20:09.978+00	\N	\N	2021-11-08 10:20:57.274+00	2021-11-08 10:20:57.598+00
5169	\N	died	2021-11-08 10:19:36.547+00	\N	\N	2021-11-08 10:20:27.022+00	2021-11-08 10:20:27.583+00
5184	\N	died	2021-11-08 10:19:37.98+00	\N	\N	2021-11-08 10:20:27.431+00	2021-11-08 10:20:27.729+00
5194	\N	died	2021-11-08 10:19:38.948+00	\N	\N	2021-11-08 10:20:27.664+00	2021-11-08 10:20:28.12+00
6258	\N	died	2021-11-08 10:20:10.31+00	\N	\N	2021-11-08 10:20:57.575+00	2021-11-08 10:20:58.17+00
5209	\N	died	2021-11-08 10:19:40.83+00	\N	\N	2021-11-08 10:20:28.031+00	2021-11-08 10:20:28.468+00
5229	\N	died	2021-11-08 10:19:42.381+00	\N	\N	2021-11-08 10:20:28.461+00	2021-11-08 10:20:28.584+00
5236	\N	died	2021-11-08 10:19:42.548+00	\N	\N	2021-11-08 10:20:28.58+00	2021-11-08 10:20:28.952+00
6270	\N	died	2021-11-08 10:20:10.626+00	\N	\N	2021-11-08 10:20:57.899+00	2021-11-08 10:20:58.263+00
5244	\N	died	2021-11-08 10:19:42.815+00	\N	\N	2021-11-08 10:20:28.785+00	2021-11-08 10:20:29.143+00
6446	\N	died	2021-11-08 10:20:16.616+00	\N	\N	2021-11-08 10:21:02.792+00	2021-11-08 10:21:03.347+00
6278	\N	died	2021-11-08 10:20:10.871+00	\N	\N	2021-11-08 10:20:58.258+00	2021-11-08 10:20:58.422+00
6282	\N	died	2021-11-08 10:20:10.942+00	\N	\N	2021-11-08 10:20:58.4+00	2021-11-08 10:20:58.857+00
6292	\N	died	2021-11-08 10:20:11.204+00	\N	\N	2021-11-08 10:20:58.693+00	2021-11-08 10:20:58.959+00
6301	\N	died	2021-11-08 10:20:11.778+00	\N	\N	2021-11-08 10:20:58.95+00	2021-11-08 10:20:59.088+00
6477	\N	died	2021-11-08 10:20:16.677+00	\N	\N	2021-11-08 10:21:03.533+00	2021-11-08 10:21:03.633+00
6307	\N	died	2021-11-08 10:20:11.944+00	\N	\N	2021-11-08 10:20:59.049+00	2021-11-08 10:20:59.359+00
6467	\N	died	2021-11-08 10:20:16.661+00	\N	\N	2021-11-08 10:21:03.292+00	2021-11-08 10:21:03.633+00
6318	\N	died	2021-11-08 10:20:12.27+00	\N	\N	2021-11-08 10:20:59.333+00	2021-11-08 10:20:59.541+00
6327	\N	died	2021-11-08 10:20:12.487+00	\N	\N	2021-11-08 10:20:59.517+00	2021-11-08 10:20:59.918+00
6342	\N	died	2021-11-08 10:20:12.81+00	\N	\N	2021-11-08 10:20:59.878+00	2021-11-08 10:21:00.58+00
6356	\N	died	2021-11-08 10:20:13.248+00	\N	\N	2021-11-08 10:21:00.517+00	2021-11-08 10:21:01.029+00
6375	\N	died	2021-11-08 10:20:14.045+00	\N	\N	2021-11-08 10:21:00.958+00	2021-11-08 10:21:01.261+00
6387	\N	died	2021-11-08 10:20:14.631+00	\N	\N	2021-11-08 10:21:01.13+00	2021-11-08 10:21:01.689+00
6400	\N	died	2021-11-08 10:20:15.636+00	\N	\N	2021-11-08 10:21:01.483+00	2021-11-08 10:21:01.728+00
6410	\N	died	2021-11-08 10:20:15.932+00	\N	\N	2021-11-08 10:21:01.725+00	2021-11-08 10:21:01.85+00
6481	\N	died	2021-11-08 10:20:16.686+00	\N	\N	2021-11-08 10:21:03.626+00	2021-11-08 10:21:03.836+00
6487	\N	died	2021-11-08 10:20:16.693+00	\N	\N	2021-11-08 10:21:03.826+00	2021-11-08 10:21:03.873+00
6480	\N	died	2021-11-08 10:20:16.681+00	\N	\N	2021-11-08 10:21:03.609+00	2021-11-08 10:21:03.889+00
6489	\N	died	2021-11-08 10:20:16.693+00	\N	\N	2021-11-08 10:21:03.867+00	2021-11-08 10:21:03.939+00
6490	\N	died	2021-11-08 10:20:16.697+00	\N	\N	2021-11-08 10:21:03.884+00	2021-11-08 10:21:04.059+00
6493	\N	died	2021-11-08 10:20:16.7+00	\N	\N	2021-11-08 10:21:03.933+00	2021-11-08 10:21:04.186+00
6495	\N	died	2021-11-08 10:20:16.7+00	\N	\N	2021-11-08 10:21:04.044+00	2021-11-08 10:21:04.186+00
6502	\N	died	2021-11-08 10:20:16.713+00	\N	\N	2021-11-08 10:21:04.177+00	2021-11-08 10:21:04.34+00
6506	\N	died	2021-11-08 10:20:16.718+00	\N	\N	2021-11-08 10:21:04.334+00	2021-11-08 10:21:04.446+00
6509	\N	died	2021-11-08 10:20:16.722+00	\N	\N	2021-11-08 10:21:04.442+00	2021-11-08 10:21:04.494+00
4895	\N	died	2021-11-08 10:19:20.268+00	\N	\N	2021-11-08 10:20:18.935+00	2021-11-08 10:20:19.035+00
4897	\N	died	2021-11-08 10:19:20.335+00	\N	\N	2021-11-08 10:20:19.027+00	2021-11-08 10:20:19.193+00
4903	\N	died	2021-11-08 10:19:20.543+00	\N	\N	2021-11-08 10:20:19.18+00	2021-11-08 10:20:19.584+00
4908	\N	died	2021-11-08 10:19:20.769+00	\N	\N	2021-11-08 10:20:19.447+00	2021-11-08 10:20:20.205+00
5267	\N	died	2021-11-08 10:19:43.804+00	\N	\N	2021-11-08 10:20:29.389+00	2021-11-08 10:20:29.87+00
4923	\N	died	2021-11-08 10:19:21.444+00	\N	\N	2021-11-08 10:20:20.126+00	2021-11-08 10:20:20.902+00
5331	\N	died	2021-11-08 10:19:44.956+00	\N	\N	2021-11-08 10:20:31.594+00	2021-11-08 10:20:32.377+00
4940	\N	died	2021-11-08 10:19:22.419+00	\N	\N	2021-11-08 10:20:20.757+00	2021-11-08 10:20:21.006+00
4951	\N	died	2021-11-08 10:19:23.129+00	\N	\N	2021-11-08 10:20:20.981+00	2021-11-08 10:20:21.151+00
5284	\N	died	2021-11-08 10:19:44.231+00	\N	\N	2021-11-08 10:20:29.861+00	2021-11-08 10:20:30.083+00
4956	\N	died	2021-11-08 10:19:23.511+00	\N	\N	2021-11-08 10:20:21.073+00	2021-11-08 10:20:21.36+00
6275	\N	died	2021-11-08 10:20:10.811+00	\N	\N	2021-11-08 10:20:58.158+00	2021-11-08 10:20:58.244+00
4966	\N	died	2021-11-08 10:19:24.186+00	\N	\N	2021-11-08 10:20:21.356+00	2021-11-08 10:20:21.806+00
4974	\N	died	2021-11-08 10:19:24.732+00	\N	\N	2021-11-08 10:20:21.71+00	2021-11-08 10:20:22.327+00
5288	\N	died	2021-11-08 10:19:44.272+00	\N	\N	2021-11-08 10:20:29.994+00	2021-11-08 10:20:30.945+00
4980	\N	died	2021-11-08 10:19:24.995+00	\N	\N	2021-11-08 10:20:22.293+00	2021-11-08 10:20:22.939+00
4999	\N	died	2021-11-08 10:19:25.903+00	\N	\N	2021-11-08 10:20:22.765+00	2021-11-08 10:20:23.041+00
5010	\N	died	2021-11-08 10:19:26.272+00	\N	\N	2021-11-08 10:20:23.02+00	2021-11-08 10:20:23.362+00
5299	\N	died	2021-11-08 10:19:44.605+00	\N	\N	2021-11-08 10:20:30.582+00	2021-11-08 10:20:31.122+00
5015	\N	died	2021-11-08 10:19:26.502+00	\N	\N	2021-11-08 10:20:23.209+00	2021-11-08 10:20:23.844+00
6476	\N	died	2021-11-08 10:20:16.677+00	\N	\N	2021-11-08 10:21:03.516+00	2021-11-08 10:21:04.186+00
5032	\N	died	2021-11-08 10:19:27.404+00	\N	\N	2021-11-08 10:20:23.786+00	2021-11-08 10:20:24.067+00
5044	\N	died	2021-11-08 10:19:28.087+00	\N	\N	2021-11-08 10:20:24.011+00	2021-11-08 10:20:24.397+00
5312	\N	died	2021-11-08 10:19:44.849+00	\N	\N	2021-11-08 10:20:31.094+00	2021-11-08 10:20:31.333+00
5061	\N	died	2021-11-08 10:19:29.321+00	\N	\N	2021-11-08 10:20:24.321+00	2021-11-08 10:20:25.034+00
5080	\N	died	2021-11-08 10:19:30.511+00	\N	\N	2021-11-08 10:20:24.763+00	2021-11-08 10:20:25.101+00
5091	\N	died	2021-11-08 10:19:31.17+00	\N	\N	2021-11-08 10:20:25.096+00	2021-11-08 10:20:25.198+00
5321	\N	died	2021-11-08 10:19:44.895+00	\N	\N	2021-11-08 10:20:31.315+00	2021-11-08 10:20:31.645+00
5095	\N	died	2021-11-08 10:19:31.371+00	\N	\N	2021-11-08 10:20:25.162+00	2021-11-08 10:20:25.425+00
5105	\N	died	2021-11-08 10:19:31.898+00	\N	\N	2021-11-08 10:20:25.384+00	2021-11-08 10:20:25.687+00
6277	\N	died	2021-11-08 10:20:10.848+00	\N	\N	2021-11-08 10:20:58.234+00	2021-11-08 10:20:58.374+00
5117	\N	died	2021-11-08 10:19:33.03+00	\N	\N	2021-11-08 10:20:25.665+00	2021-11-08 10:20:26.172+00
6496	\N	died	2021-11-08 10:20:16.708+00	\N	\N	2021-11-08 10:21:04.067+00	2021-11-08 10:21:04.34+00
5135	\N	died	2021-11-08 10:19:34.363+00	\N	\N	2021-11-08 10:20:26.157+00	2021-11-08 10:20:26.331+00
5140	\N	died	2021-11-08 10:19:34.746+00	\N	\N	2021-11-08 10:20:26.301+00	2021-11-08 10:20:26.634+00
6280	\N	died	2021-11-08 10:20:10.91+00	\N	\N	2021-11-08 10:20:58.367+00	2021-11-08 10:20:58.463+00
5152	\N	died	2021-11-08 10:19:35.454+00	\N	\N	2021-11-08 10:20:26.608+00	2021-11-08 10:20:26.76+00
5157	\N	died	2021-11-08 10:19:35.77+00	\N	\N	2021-11-08 10:20:26.755+00	2021-11-08 10:20:26.942+00
5165	\N	died	2021-11-08 10:19:36.337+00	\N	\N	2021-11-08 10:20:26.937+00	2021-11-08 10:20:27.19+00
6284	\N	died	2021-11-08 10:20:10.977+00	\N	\N	2021-11-08 10:20:58.433+00	2021-11-08 10:20:58.857+00
5175	\N	died	2021-11-08 10:19:37.087+00	\N	\N	2021-11-08 10:20:27.187+00	2021-11-08 10:20:27.275+00
5178	\N	died	2021-11-08 10:19:37.289+00	\N	\N	2021-11-08 10:20:27.255+00	2021-11-08 10:20:27.583+00
5185	\N	died	2021-11-08 10:19:38.088+00	\N	\N	2021-11-08 10:20:27.459+00	2021-11-08 10:20:27.744+00
6297	\N	died	2021-11-08 10:20:11.711+00	\N	\N	2021-11-08 10:20:58.809+00	2021-11-08 10:20:59.202+00
5198	\N	died	2021-11-08 10:19:39.207+00	\N	\N	2021-11-08 10:20:27.739+00	2021-11-08 10:20:27.877+00
6551	\N	died	2021-11-08 10:20:16.782+00	\N	\N	2021-11-08 10:21:05.567+00	2021-11-08 10:21:06.306+00
5201	\N	died	2021-11-08 10:19:39.656+00	\N	\N	2021-11-08 10:20:27.873+00	2021-11-08 10:20:28.12+00
5208	\N	died	2021-11-08 10:19:40.305+00	\N	\N	2021-11-08 10:20:28.014+00	2021-11-08 10:20:28.449+00
6314	\N	died	2021-11-08 10:20:12.171+00	\N	\N	2021-11-08 10:20:59.166+00	2021-11-08 10:20:59.672+00
5226	\N	died	2021-11-08 10:19:42.314+00	\N	\N	2021-11-08 10:20:28.385+00	2021-11-08 10:20:28.569+00
6498	\N	died	2021-11-08 10:20:16.708+00	\N	\N	2021-11-08 10:21:04.1+00	2021-11-08 10:21:04.446+00
5235	\N	died	2021-11-08 10:19:42.529+00	\N	\N	2021-11-08 10:20:28.564+00	2021-11-08 10:20:28.952+00
5243	\N	died	2021-11-08 10:19:42.778+00	\N	\N	2021-11-08 10:20:28.771+00	2021-11-08 10:20:29.143+00
6331	\N	died	2021-11-08 10:20:12.613+00	\N	\N	2021-11-08 10:20:59.583+00	2021-11-08 10:21:00.009+00
5256	\N	died	2021-11-08 10:19:43.191+00	\N	\N	2021-11-08 10:20:29.061+00	2021-11-08 10:20:29.409+00
6347	\N	died	2021-11-08 10:20:13.018+00	\N	\N	2021-11-08 10:21:00.001+00	2021-11-08 10:21:00.58+00
6504	\N	died	2021-11-08 10:20:16.718+00	\N	\N	2021-11-08 10:21:04.293+00	2021-11-08 10:21:04.462+00
6354	\N	died	2021-11-08 10:20:13.127+00	\N	\N	2021-11-08 10:21:00.469+00	2021-11-08 10:21:00.834+00
6370	\N	died	2021-11-08 10:20:13.843+00	\N	\N	2021-11-08 10:21:00.809+00	2021-11-08 10:21:01.261+00
6388	\N	died	2021-11-08 10:20:14.66+00	\N	\N	2021-11-08 10:21:01.152+00	2021-11-08 10:21:01.689+00
6402	\N	died	2021-11-08 10:20:15.757+00	\N	\N	2021-11-08 10:21:01.592+00	2021-11-08 10:21:01.85+00
6510	\N	died	2021-11-08 10:20:16.722+00	\N	\N	2021-11-08 10:21:04.458+00	2021-11-08 10:21:04.672+00
6415	\N	died	2021-11-08 10:20:16.068+00	\N	\N	2021-11-08 10:21:01.825+00	2021-11-08 10:21:02.28+00
6428	\N	died	2021-11-08 10:20:16.281+00	\N	\N	2021-11-08 10:21:02.275+00	2021-11-08 10:21:02.356+00
6508	\N	died	2021-11-08 10:20:16.722+00	\N	\N	2021-11-08 10:21:04.418+00	2021-11-08 10:21:04.7+00
6431	\N	died	2021-11-08 10:20:16.37+00	\N	\N	2021-11-08 10:21:02.319+00	2021-11-08 10:21:02.664+00
6573	\N	died	2021-11-08 10:20:16.83+00	\N	\N	2021-11-08 10:21:06.3+00	2021-11-08 10:21:06.582+00
6438	\N	died	2021-11-08 10:20:16.512+00	\N	\N	2021-11-08 10:21:02.56+00	2021-11-08 10:21:02.915+00
6451	\N	died	2021-11-08 10:20:16.63+00	\N	\N	2021-11-08 10:21:02.892+00	2021-11-08 10:21:03.347+00
6469	\N	died	2021-11-08 10:20:16.668+00	\N	\N	2021-11-08 10:21:03.325+00	2021-11-08 10:21:03.836+00
6483	\N	died	2021-11-08 10:20:16.686+00	\N	\N	2021-11-08 10:21:03.727+00	2021-11-08 10:21:04.076+00
6516	\N	died	2021-11-08 10:20:16.733+00	\N	\N	2021-11-08 10:21:04.688+00	2021-11-08 10:21:04.806+00
6583	\N	died	2021-11-08 10:20:16.881+00	\N	\N	2021-11-08 10:21:06.569+00	2021-11-08 10:21:06.612+00
6513	\N	died	2021-11-08 10:20:16.728+00	\N	\N	2021-11-08 10:21:04.61+00	2021-11-08 10:21:04.999+00
6521	\N	died	2021-11-08 10:20:16.737+00	\N	\N	2021-11-08 10:21:04.793+00	2021-11-08 10:21:04.999+00
6527	\N	died	2021-11-08 10:20:16.751+00	\N	\N	2021-11-08 10:21:04.992+00	2021-11-08 10:21:05.065+00
6585	\N	died	2021-11-08 10:20:16.886+00	\N	\N	2021-11-08 10:21:06.609+00	2021-11-08 10:21:06.664+00
6531	\N	died	2021-11-08 10:20:16.756+00	\N	\N	2021-11-08 10:21:05.059+00	2021-11-08 10:21:05.203+00
6523	\N	died	2021-11-08 10:20:16.744+00	\N	\N	2021-11-08 10:21:04.902+00	2021-11-08 10:21:05.214+00
6588	\N	died	2021-11-08 10:20:16.9+00	\N	\N	2021-11-08 10:21:06.66+00	2021-11-08 10:21:06.806+00
6535	\N	died	2021-11-08 10:20:16.757+00	\N	\N	2021-11-08 10:21:05.197+00	2021-11-08 10:21:05.339+00
6536	\N	died	2021-11-08 10:20:16.763+00	\N	\N	2021-11-08 10:21:05.208+00	2021-11-08 10:21:05.339+00
6541	\N	died	2021-11-08 10:20:16.769+00	\N	\N	2021-11-08 10:21:05.334+00	2021-11-08 10:21:05.446+00
6592	\N	died	2021-11-08 10:20:16.966+00	\N	\N	2021-11-08 10:21:06.801+00	2021-11-08 10:21:06.933+00
6598	\N	died	2021-11-08 10:20:17.006+00	\N	\N	2021-11-08 10:21:06.926+00	2021-11-08 10:21:07.091+00
6602	\N	died	2021-11-08 10:20:17.024+00	\N	\N	2021-11-08 10:21:07.069+00	2021-11-08 10:21:07.172+00
6606	\N	died	2021-11-08 10:20:17.068+00	\N	\N	2021-11-08 10:21:07.167+00	2021-11-08 10:21:07.215+00
6608	\N	died	2021-11-08 10:20:17.119+00	\N	\N	2021-11-08 10:21:07.208+00	2021-11-08 10:21:07.321+00
6612	\N	died	2021-11-08 10:20:17.162+00	\N	\N	2021-11-08 10:21:07.317+00	2021-11-08 10:21:07.466+00
4924	\N	died	2021-11-08 10:19:21.494+00	\N	\N	2021-11-08 10:20:20.189+00	2021-11-08 10:20:20.568+00
4931	\N	died	2021-11-08 10:19:21.886+00	\N	\N	2021-11-08 10:20:20.559+00	2021-11-08 10:20:20.612+00
5334	\N	died	2021-11-08 10:19:45.056+00	\N	\N	2021-11-08 10:20:31.661+00	2021-11-08 10:20:31.848+00
4933	\N	died	2021-11-08 10:19:21.969+00	\N	\N	2021-11-08 10:20:20.607+00	2021-11-08 10:20:20.691+00
6515	\N	died	2021-11-08 10:20:16.733+00	\N	\N	2021-11-08 10:21:04.66+00	2021-11-08 10:21:04.766+00
4937	\N	died	2021-11-08 10:19:22.22+00	\N	\N	2021-11-08 10:20:20.688+00	2021-11-08 10:20:20.902+00
4945	\N	died	2021-11-08 10:19:22.727+00	\N	\N	2021-11-08 10:20:20.857+00	2021-11-08 10:20:21.36+00
5338	\N	died	2021-11-08 10:19:45.108+00	\N	\N	2021-11-08 10:20:31.829+00	2021-11-08 10:20:32.166+00
4965	\N	died	2021-11-08 10:19:24.07+00	\N	\N	2021-11-08 10:20:21.337+00	2021-11-08 10:20:22.47+00
4986	\N	died	2021-11-08 10:19:25.353+00	\N	\N	2021-11-08 10:20:22.431+00	2021-11-08 10:20:22.671+00
5343	\N	died	2021-11-08 10:19:45.188+00	\N	\N	2021-11-08 10:20:31.944+00	2021-11-08 10:20:32.666+00
4994	\N	died	2021-11-08 10:19:25.678+00	\N	\N	2021-11-08 10:20:22.665+00	2021-11-08 10:20:22.939+00
5003	\N	died	2021-11-08 10:19:25.953+00	\N	\N	2021-11-08 10:20:22.905+00	2021-11-08 10:20:23.6+00
6324	\N	died	2021-11-08 10:20:12.469+00	\N	\N	2021-11-08 10:20:59.441+00	2021-11-08 10:20:59.541+00
5024	\N	died	2021-11-08 10:19:26.945+00	\N	\N	2021-11-08 10:20:23.53+00	2021-11-08 10:20:23.775+00
5031	\N	died	2021-11-08 10:19:27.303+00	\N	\N	2021-11-08 10:20:23.771+00	2021-11-08 10:20:23.971+00
5039	\N	died	2021-11-08 10:19:27.721+00	\N	\N	2021-11-08 10:20:23.911+00	2021-11-08 10:20:24.213+00
6328	\N	died	2021-11-08 10:20:12.502+00	\N	\N	2021-11-08 10:20:59.533+00	2021-11-08 10:20:59.672+00
5055	\N	died	2021-11-08 10:19:28.996+00	\N	\N	2021-11-08 10:20:24.204+00	2021-11-08 10:20:24.397+00
5062	\N	died	2021-11-08 10:19:29.37+00	\N	\N	2021-11-08 10:20:24.338+00	2021-11-08 10:20:25.034+00
5082	\N	died	2021-11-08 10:19:30.653+00	\N	\N	2021-11-08 10:20:24.874+00	2021-11-08 10:20:25.198+00
6335	\N	died	2021-11-08 10:20:12.66+00	\N	\N	2021-11-08 10:20:59.667+00	2021-11-08 10:20:59.782+00
5096	\N	died	2021-11-08 10:19:31.403+00	\N	\N	2021-11-08 10:20:25.18+00	2021-11-08 10:20:25.49+00
5108	\N	died	2021-11-08 10:19:32.253+00	\N	\N	2021-11-08 10:20:25.437+00	2021-11-08 10:20:25.687+00
5115	\N	died	2021-11-08 10:19:32.938+00	\N	\N	2021-11-08 10:20:25.618+00	2021-11-08 10:20:25.941+00
6337	\N	died	2021-11-08 10:20:12.678+00	\N	\N	2021-11-08 10:20:59.77+00	2021-11-08 10:20:59.918+00
5126	\N	died	2021-11-08 10:19:33.722+00	\N	\N	2021-11-08 10:20:25.905+00	2021-11-08 10:20:26.083+00
6499	\N	died	2021-11-08 10:20:16.713+00	\N	\N	2021-11-08 10:21:04.117+00	2021-11-08 10:21:04.887+00
5131	\N	died	2021-11-08 10:19:34.114+00	\N	\N	2021-11-08 10:20:26.017+00	2021-11-08 10:20:26.455+00
5142	\N	died	2021-11-08 10:19:34.846+00	\N	\N	2021-11-08 10:20:26.339+00	2021-11-08 10:20:26.747+00
6341	\N	died	2021-11-08 10:20:12.804+00	\N	\N	2021-11-08 10:20:59.858+00	2021-11-08 10:21:00.58+00
5156	\N	died	2021-11-08 10:19:35.712+00	\N	\N	2021-11-08 10:20:26.737+00	2021-11-08 10:20:26.91+00
6576	\N	died	2021-11-08 10:20:16.839+00	\N	\N	2021-11-08 10:21:06.428+00	2021-11-08 10:21:06.754+00
5163	\N	died	2021-11-08 10:19:36.205+00	\N	\N	2021-11-08 10:20:26.905+00	2021-11-08 10:20:27.173+00
5173	\N	died	2021-11-08 10:19:36.988+00	\N	\N	2021-11-08 10:20:27.155+00	2021-11-08 10:20:27.729+00
6353	\N	died	2021-11-08 10:20:13.11+00	\N	\N	2021-11-08 10:21:00.428+00	2021-11-08 10:21:00.834+00
5193	\N	died	2021-11-08 10:19:38.906+00	\N	\N	2021-11-08 10:20:27.645+00	2021-11-08 10:20:28.12+00
6519	\N	died	2021-11-08 10:20:16.737+00	\N	\N	2021-11-08 10:21:04.755+00	2021-11-08 10:21:04.999+00
5207	\N	died	2021-11-08 10:19:40.188+00	\N	\N	2021-11-08 10:20:27.998+00	2021-11-08 10:20:28.377+00
5224	\N	died	2021-11-08 10:19:42.231+00	\N	\N	2021-11-08 10:20:28.356+00	2021-11-08 10:20:28.599+00
6368	\N	died	2021-11-08 10:20:13.787+00	\N	\N	2021-11-08 10:21:00.752+00	2021-11-08 10:21:01.053+00
5237	\N	died	2021-11-08 10:19:42.565+00	\N	\N	2021-11-08 10:20:28.595+00	2021-11-08 10:20:28.952+00
5246	\N	died	2021-11-08 10:19:42.832+00	\N	\N	2021-11-08 10:20:28.819+00	2021-11-08 10:20:29.301+00
5262	\N	died	2021-11-08 10:19:43.527+00	\N	\N	2021-11-08 10:20:29.263+00	2021-11-08 10:20:29.853+00
6381	\N	died	2021-11-08 10:20:14.221+00	\N	\N	2021-11-08 10:21:01.042+00	2021-11-08 10:21:01.261+00
5280	\N	died	2021-11-08 10:19:44.103+00	\N	\N	2021-11-08 10:20:29.718+00	2021-11-08 10:20:30.945+00
6522	\N	died	2021-11-08 10:20:16.737+00	\N	\N	2021-11-08 10:21:04.869+00	2021-11-08 10:21:05.065+00
5298	\N	died	2021-11-08 10:19:44.593+00	\N	\N	2021-11-08 10:20:30.547+00	2021-11-08 10:20:31.078+00
5309	\N	died	2021-11-08 10:19:44.84+00	\N	\N	2021-11-08 10:20:31.069+00	2021-11-08 10:20:31.122+00
6389	\N	died	2021-11-08 10:20:14.698+00	\N	\N	2021-11-08 10:21:01.175+00	2021-11-08 10:21:01.689+00
5314	\N	died	2021-11-08 10:19:44.852+00	\N	\N	2021-11-08 10:20:31.118+00	2021-11-08 10:20:31.252+00
5317	\N	died	2021-11-08 10:19:44.873+00	\N	\N	2021-11-08 10:20:31.244+00	2021-11-08 10:20:31.405+00
5324	\N	died	2021-11-08 10:19:44.9+00	\N	\N	2021-11-08 10:20:31.394+00	2021-11-08 10:20:31.695+00
6529	\N	died	2021-11-08 10:20:16.751+00	\N	\N	2021-11-08 10:21:05.026+00	2021-11-08 10:21:05.353+00
6404	\N	died	2021-11-08 10:20:15.814+00	\N	\N	2021-11-08 10:21:01.625+00	2021-11-08 10:21:02+00
6419	\N	died	2021-11-08 10:20:16.149+00	\N	\N	2021-11-08 10:21:01.974+00	2021-11-08 10:21:02.306+00
6430	\N	died	2021-11-08 10:20:16.364+00	\N	\N	2021-11-08 10:21:02.3+00	2021-11-08 10:21:02.524+00
6434	\N	died	2021-11-08 10:20:16.464+00	\N	\N	2021-11-08 10:21:02.457+00	2021-11-08 10:21:02.696+00
6542	\N	died	2021-11-08 10:20:16.769+00	\N	\N	2021-11-08 10:21:05.35+00	2021-11-08 10:21:05.58+00
6444	\N	died	2021-11-08 10:20:16.608+00	\N	\N	2021-11-08 10:21:02.691+00	2021-11-08 10:21:02.915+00
6525	\N	died	2021-11-08 10:20:16.745+00	\N	\N	2021-11-08 10:21:04.951+00	2021-11-08 10:21:05.58+00
6450	\N	died	2021-11-08 10:20:16.621+00	\N	\N	2021-11-08 10:21:02.868+00	2021-11-08 10:21:03.264+00
6464	\N	died	2021-11-08 10:20:16.654+00	\N	\N	2021-11-08 10:21:03.242+00	2021-11-08 10:21:03.572+00
6478	\N	died	2021-11-08 10:20:16.681+00	\N	\N	2021-11-08 10:21:03.558+00	2021-11-08 10:21:03.836+00
6589	\N	died	2021-11-08 10:20:16.902+00	\N	\N	2021-11-08 10:21:06.737+00	2021-11-08 10:21:06.933+00
6484	\N	died	2021-11-08 10:20:16.69+00	\N	\N	2021-11-08 10:21:03.762+00	2021-11-08 10:21:04.186+00
6511	\N	died	2021-11-08 10:20:16.728+00	\N	\N	2021-11-08 10:21:04.48+00	2021-11-08 10:21:04.672+00
6547	\N	died	2021-11-08 10:20:16.775+00	\N	\N	2021-11-08 10:21:05.492+00	2021-11-08 10:21:05.973+00
6559	\N	died	2021-11-08 10:20:16.79+00	\N	\N	2021-11-08 10:21:05.967+00	2021-11-08 10:21:06.071+00
6564	\N	died	2021-11-08 10:20:16.804+00	\N	\N	2021-11-08 10:21:06.057+00	2021-11-08 10:21:06.205+00
6550	\N	died	2021-11-08 10:20:16.775+00	\N	\N	2021-11-08 10:21:05.552+00	2021-11-08 10:21:06.27+00
6568	\N	died	2021-11-08 10:20:16.809+00	\N	\N	2021-11-08 10:21:06.2+00	2021-11-08 10:21:06.582+00
6571	\N	died	2021-11-08 10:20:16.82+00	\N	\N	2021-11-08 10:21:06.252+00	2021-11-08 10:21:06.582+00
6581	\N	died	2021-11-08 10:20:16.865+00	\N	\N	2021-11-08 10:21:06.533+00	2021-11-08 10:21:07.015+00
6599	\N	died	2021-11-08 10:20:17.009+00	\N	\N	2021-11-08 10:21:06.999+00	2021-11-08 10:21:07.172+00
6596	\N	died	2021-11-08 10:20:16.985+00	\N	\N	2021-11-08 10:21:06.893+00	2021-11-08 10:21:07.466+00
6604	\N	died	2021-11-08 10:20:17.044+00	\N	\N	2021-11-08 10:21:07.122+00	2021-11-08 10:21:07.632+00
6619	\N	died	2021-11-08 10:20:17.338+00	\N	\N	2021-11-08 10:21:07.493+00	2021-11-08 10:21:07.78+00
6630	\N	died	2021-11-08 10:20:17.627+00	\N	\N	2021-11-08 10:21:07.763+00	2021-11-08 10:21:07.934+00
6634	\N	died	2021-11-08 10:20:17.697+00	\N	\N	2021-11-08 10:21:07.927+00	2021-11-08 10:21:08.045+00
6638	\N	died	2021-11-08 10:20:17.804+00	\N	\N	2021-11-08 10:21:08.035+00	2021-11-08 10:21:08.233+00
4954	\N	died	2021-11-08 10:19:23.327+00	\N	\N	2021-11-08 10:20:21.038+00	2021-11-08 10:20:21.151+00
4960	\N	died	2021-11-08 10:19:23.727+00	\N	\N	2021-11-08 10:20:21.159+00	2021-11-08 10:20:21.632+00
5329	\N	died	2021-11-08 10:19:44.94+00	\N	\N	2021-11-08 10:20:31.56+00	2021-11-08 10:20:32.21+00
4968	\N	died	2021-11-08 10:19:24.252+00	\N	\N	2021-11-08 10:20:21.39+00	2021-11-08 10:20:22.419+00
4984	\N	died	2021-11-08 10:19:25.212+00	\N	\N	2021-11-08 10:20:22.391+00	2021-11-08 10:20:22.939+00
5001	\N	died	2021-11-08 10:19:25.921+00	\N	\N	2021-11-08 10:20:22.853+00	2021-11-08 10:20:23.362+00
6379	\N	died	2021-11-08 10:20:14.154+00	\N	\N	2021-11-08 10:21:01.025+00	2021-11-08 10:21:01.053+00
5016	\N	died	2021-11-08 10:19:26.537+00	\N	\N	2021-11-08 10:20:23.229+00	2021-11-08 10:20:23.6+00
6553	\N	died	2021-11-08 10:20:16.782+00	\N	\N	2021-11-08 10:21:05.592+00	2021-11-08 10:21:06.205+00
5025	\N	died	2021-11-08 10:19:26.977+00	\N	\N	2021-11-08 10:20:23.545+00	2021-11-08 10:20:23.844+00
5034	\N	died	2021-11-08 10:19:27.496+00	\N	\N	2021-11-08 10:20:23.821+00	2021-11-08 10:20:24.117+00
6382	\N	died	2021-11-08 10:20:14.32+00	\N	\N	2021-11-08 10:21:01.049+00	2021-11-08 10:21:01.261+00
5048	\N	died	2021-11-08 10:19:28.428+00	\N	\N	2021-11-08 10:20:24.081+00	2021-11-08 10:20:24.241+00
5056	\N	died	2021-11-08 10:19:29.011+00	\N	\N	2021-11-08 10:20:24.222+00	2021-11-08 10:20:24.696+00
5076	\N	died	2021-11-08 10:19:30.262+00	\N	\N	2021-11-08 10:20:24.691+00	2021-11-08 10:20:25.034+00
6386	\N	died	2021-11-08 10:20:14.583+00	\N	\N	2021-11-08 10:21:01.109+00	2021-11-08 10:21:01.474+00
5085	\N	died	2021-11-08 10:19:30.862+00	\N	\N	2021-11-08 10:20:24.956+00	2021-11-08 10:20:25.363+00
5102	\N	died	2021-11-08 10:19:31.778+00	\N	\N	2021-11-08 10:20:25.323+00	2021-11-08 10:20:25.895+00
5124	\N	died	2021-11-08 10:19:33.62+00	\N	\N	2021-11-08 10:20:25.861+00	2021-11-08 10:20:26.455+00
6398	\N	died	2021-11-08 10:20:15.603+00	\N	\N	2021-11-08 10:21:01.427+00	2021-11-08 10:21:01.711+00
5143	\N	died	2021-11-08 10:19:35.029+00	\N	\N	2021-11-08 10:20:26.419+00	2021-11-08 10:20:26.828+00
5160	\N	died	2021-11-08 10:19:35.98+00	\N	\N	2021-11-08 10:20:26.822+00	2021-11-08 10:20:27.173+00
5170	\N	died	2021-11-08 10:19:36.589+00	\N	\N	2021-11-08 10:20:27.095+00	2021-11-08 10:20:27.583+00
6408	\N	died	2021-11-08 10:20:15.879+00	\N	\N	2021-11-08 10:21:01.7+00	2021-11-08 10:21:01.85+00
5186	\N	died	2021-11-08 10:19:38.155+00	\N	\N	2021-11-08 10:20:27.523+00	2021-11-08 10:20:27.902+00
6565	\N	died	2021-11-08 10:20:16.804+00	\N	\N	2021-11-08 10:21:06.136+00	2021-11-08 10:21:06.336+00
5202	\N	died	2021-11-08 10:19:39.772+00	\N	\N	2021-11-08 10:20:27.893+00	2021-11-08 10:20:28.12+00
5210	\N	died	2021-11-08 10:19:40.905+00	\N	\N	2021-11-08 10:20:28.057+00	2021-11-08 10:20:28.535+00
6413	\N	died	2021-11-08 10:20:15.986+00	\N	\N	2021-11-08 10:21:01.76+00	2021-11-08 10:21:02.268+00
5231	\N	died	2021-11-08 10:19:42.441+00	\N	\N	2021-11-08 10:20:28.493+00	2021-11-08 10:20:28.952+00
5245	\N	died	2021-11-08 10:19:42.83+00	\N	\N	2021-11-08 10:20:28.802+00	2021-11-08 10:20:29.159+00
5260	\N	died	2021-11-08 10:19:43.382+00	\N	\N	2021-11-08 10:20:29.154+00	2021-11-08 10:20:29.409+00
6422	\N	died	2021-11-08 10:20:16.187+00	\N	\N	2021-11-08 10:21:02.025+00	2021-11-08 10:21:02.664+00
5265	\N	died	2021-11-08 10:19:43.709+00	\N	\N	2021-11-08 10:20:29.338+00	2021-11-08 10:20:29.853+00
6567	\N	died	2021-11-08 10:20:16.809+00	\N	\N	2021-11-08 10:21:06.184+00	2021-11-08 10:21:06.582+00
5278	\N	died	2021-11-08 10:19:44.088+00	\N	\N	2021-11-08 10:20:29.671+00	2021-11-08 10:20:30.453+00
5294	\N	died	2021-11-08 10:19:44.345+00	\N	\N	2021-11-08 10:20:30.399+00	2021-11-08 10:20:30.945+00
6437	\N	died	2021-11-08 10:20:16.496+00	\N	\N	2021-11-08 10:21:02.536+00	2021-11-08 10:21:02.915+00
5305	\N	died	2021-11-08 10:19:44.743+00	\N	\N	2021-11-08 10:20:30.946+00	2021-11-08 10:20:31.205+00
5315	\N	died	2021-11-08 10:19:44.855+00	\N	\N	2021-11-08 10:20:31.187+00	2021-11-08 10:20:31.287+00
6574	\N	died	2021-11-08 10:20:16.833+00	\N	\N	2021-11-08 10:21:06.319+00	2021-11-08 10:21:06.598+00
5319	\N	died	2021-11-08 10:19:44.891+00	\N	\N	2021-11-08 10:20:31.28+00	2021-11-08 10:20:31.645+00
6449	\N	died	2021-11-08 10:20:16.62+00	\N	\N	2021-11-08 10:21:02.847+00	2021-11-08 10:21:03.187+00
6460	\N	died	2021-11-08 10:20:16.648+00	\N	\N	2021-11-08 10:21:03.178+00	2021-11-08 10:21:03.264+00
6463	\N	died	2021-11-08 10:20:16.654+00	\N	\N	2021-11-08 10:21:03.225+00	2021-11-08 10:21:03.47+00
6584	\N	died	2021-11-08 10:20:16.883+00	\N	\N	2021-11-08 10:21:06.593+00	2021-11-08 10:21:06.664+00
6472	\N	died	2021-11-08 10:20:16.672+00	\N	\N	2021-11-08 10:21:03.427+00	2021-11-08 10:21:03.836+00
6482	\N	died	2021-11-08 10:20:16.686+00	\N	\N	2021-11-08 10:21:03.651+00	2021-11-08 10:21:03.939+00
6492	\N	died	2021-11-08 10:20:16.697+00	\N	\N	2021-11-08 10:21:03.918+00	2021-11-08 10:21:04.446+00
6507	\N	died	2021-11-08 10:20:16.722+00	\N	\N	2021-11-08 10:21:04.386+00	2021-11-08 10:21:04.589+00
6512	\N	died	2021-11-08 10:20:16.728+00	\N	\N	2021-11-08 10:21:04.572+00	2021-11-08 10:21:04.766+00
6497	\N	died	2021-11-08 10:20:16.708+00	\N	\N	2021-11-08 10:21:04.084+00	2021-11-08 10:21:04.806+00
6620	\N	died	2021-11-08 10:20:17.354+00	\N	\N	2021-11-08 10:21:07.514+00	2021-11-08 10:21:08.25+00
6520	\N	died	2021-11-08 10:20:16.737+00	\N	\N	2021-11-08 10:21:04.776+00	2021-11-08 10:21:05.015+00
6633	\N	died	2021-11-08 10:20:17.679+00	\N	\N	2021-11-08 10:21:07.901+00	2021-11-08 10:21:08.376+00
6517	\N	died	2021-11-08 10:20:16.733+00	\N	\N	2021-11-08 10:21:04.711+00	2021-11-08 10:21:05.065+00
6528	\N	died	2021-11-08 10:20:16.751+00	\N	\N	2021-11-08 10:21:05.009+00	2021-11-08 10:21:05.203+00
6533	\N	died	2021-11-08 10:20:16.757+00	\N	\N	2021-11-08 10:21:05.144+00	2021-11-08 10:21:05.339+00
6642	\N	died	2021-11-08 10:20:18.187+00	\N	\N	2021-11-08 10:21:08.245+00	2021-11-08 10:21:08.406+00
6530	\N	died	2021-11-08 10:20:16.751+00	\N	\N	2021-11-08 10:21:05.042+00	2021-11-08 10:21:05.58+00
6540	\N	died	2021-11-08 10:20:16.763+00	\N	\N	2021-11-08 10:21:05.316+00	2021-11-08 10:21:05.603+00
6650	\N	died	2021-11-08 10:20:18.612+00	\N	\N	2021-11-08 10:21:08.4+00	2021-11-08 10:21:08.549+00
6548	\N	died	2021-11-08 10:20:16.775+00	\N	\N	2021-11-08 10:21:05.513+00	2021-11-08 10:21:06.153+00
6587	\N	died	2021-11-08 10:20:16.898+00	\N	\N	2021-11-08 10:21:06.642+00	2021-11-08 10:21:06.933+00
6580	\N	died	2021-11-08 10:20:16.863+00	\N	\N	2021-11-08 10:21:06.517+00	2021-11-08 10:21:06.933+00
6594	\N	died	2021-11-08 10:20:16.98+00	\N	\N	2021-11-08 10:21:06.851+00	2021-11-08 10:21:07.189+00
6607	\N	died	2021-11-08 10:20:17.073+00	\N	\N	2021-11-08 10:21:07.185+00	2021-11-08 10:21:07.321+00
6597	\N	died	2021-11-08 10:20:17.004+00	\N	\N	2021-11-08 10:21:06.912+00	2021-11-08 10:21:07.483+00
6610	\N	died	2021-11-08 10:20:17.147+00	\N	\N	2021-11-08 10:21:07.284+00	2021-11-08 10:21:07.632+00
6618	\N	died	2021-11-08 10:20:17.321+00	\N	\N	2021-11-08 10:21:07.476+00	2021-11-08 10:21:07.714+00
6625	\N	died	2021-11-08 10:20:17.419+00	\N	\N	2021-11-08 10:21:07.675+00	2021-11-08 10:21:07.934+00
6655	\N	died	2021-11-08 10:20:18.849+00	\N	\N	2021-11-08 10:21:08.536+00	2021-11-08 10:21:08.589+00
6657	\N	died	2021-11-08 10:20:18.926+00	\N	\N	2021-11-08 10:21:08.584+00	2021-11-08 10:21:08.691+00
6661	\N	died	2021-11-08 10:20:19.024+00	\N	\N	2021-11-08 10:21:08.684+00	2021-11-08 10:21:08.874+00
6647	\N	died	2021-11-08 10:20:18.521+00	\N	\N	2021-11-08 10:21:08.344+00	2021-11-08 10:21:09.051+00
6667	\N	died	2021-11-08 10:20:19.127+00	\N	\N	2021-11-08 10:21:08.869+00	2021-11-08 10:21:09.051+00
6673	\N	died	2021-11-08 10:20:19.279+00	\N	\N	2021-11-08 10:21:09.036+00	2021-11-08 10:21:09.087+00
6675	\N	died	2021-11-08 10:20:19.327+00	\N	\N	2021-11-08 10:21:09.084+00	2021-11-08 10:21:09.131+00
5064	\N	died	2021-11-08 10:19:29.52+00	\N	\N	2021-11-08 10:20:24.381+00	2021-11-08 10:20:24.528+00
5067	\N	died	2021-11-08 10:19:29.598+00	\N	\N	2021-11-08 10:20:24.521+00	2021-11-08 10:20:24.561+00
5340	\N	died	2021-11-08 10:19:45.139+00	\N	\N	2021-11-08 10:20:31.879+00	2021-11-08 10:20:32.666+00
5069	\N	died	2021-11-08 10:19:29.753+00	\N	\N	2021-11-08 10:20:24.555+00	2021-11-08 10:20:24.679+00
5073	\N	died	2021-11-08 10:19:30.046+00	\N	\N	2021-11-08 10:20:24.631+00	2021-11-08 10:20:25.034+00
6407	\N	died	2021-11-08 10:20:15.862+00	\N	\N	2021-11-08 10:21:01.683+00	2021-11-08 10:21:01.711+00
5083	\N	died	2021-11-08 10:19:30.704+00	\N	\N	2021-11-08 10:20:24.899+00	2021-11-08 10:20:25.363+00
6611	\N	died	2021-11-08 10:20:17.149+00	\N	\N	2021-11-08 10:21:07.3+00	2021-11-08 10:21:07.632+00
5098	\N	died	2021-11-08 10:19:31.453+00	\N	\N	2021-11-08 10:20:25.204+00	2021-11-08 10:20:25.49+00
5110	\N	died	2021-11-08 10:19:32.471+00	\N	\N	2021-11-08 10:20:25.474+00	2021-11-08 10:20:25.895+00
6409	\N	died	2021-11-08 10:20:15.903+00	\N	\N	2021-11-08 10:21:01.708+00	2021-11-08 10:21:01.745+00
5123	\N	died	2021-11-08 10:19:33.573+00	\N	\N	2021-11-08 10:20:25.77+00	2021-11-08 10:20:26.331+00
5141	\N	died	2021-11-08 10:19:34.796+00	\N	\N	2021-11-08 10:20:26.325+00	2021-11-08 10:20:26.582+00
5149	\N	died	2021-11-08 10:19:35.255+00	\N	\N	2021-11-08 10:20:26.547+00	2021-11-08 10:20:27.173+00
6411	\N	died	2021-11-08 10:20:15.953+00	\N	\N	2021-11-08 10:21:01.733+00	2021-11-08 10:21:02+00
5166	\N	died	2021-11-08 10:19:36.404+00	\N	\N	2021-11-08 10:20:26.954+00	2021-11-08 10:20:27.243+00
5177	\N	died	2021-11-08 10:19:37.238+00	\N	\N	2021-11-08 10:20:27.238+00	2021-11-08 10:20:27.417+00
5181	\N	died	2021-11-08 10:19:37.555+00	\N	\N	2021-11-08 10:20:27.365+00	2021-11-08 10:20:27.729+00
6418	\N	died	2021-11-08 10:20:16.123+00	\N	\N	2021-11-08 10:21:01.935+00	2021-11-08 10:21:02.524+00
5196	\N	died	2021-11-08 10:19:39.106+00	\N	\N	2021-11-08 10:20:27.699+00	2021-11-08 10:20:28.189+00
6614	\N	died	2021-11-08 10:20:17.204+00	\N	\N	2021-11-08 10:21:07.369+00	2021-11-08 10:21:07.714+00
5213	\N	died	2021-11-08 10:19:41.096+00	\N	\N	2021-11-08 10:20:28.13+00	2021-11-08 10:20:28.247+00
5218	\N	died	2021-11-08 10:19:41.58+00	\N	\N	2021-11-08 10:20:28.241+00	2021-11-08 10:20:28.377+00
6435	\N	died	2021-11-08 10:20:16.49+00	\N	\N	2021-11-08 10:21:02.484+00	2021-11-08 10:21:02.815+00
5223	\N	died	2021-11-08 10:19:42.063+00	\N	\N	2021-11-08 10:20:28.34+00	2021-11-08 10:20:28.952+00
5241	\N	died	2021-11-08 10:19:42.754+00	\N	\N	2021-11-08 10:20:28.738+00	2021-11-08 10:20:29.05+00
5254	\N	died	2021-11-08 10:19:43.187+00	\N	\N	2021-11-08 10:20:29.031+00	2021-11-08 10:20:29.409+00
6447	\N	died	2021-11-08 10:20:16.617+00	\N	\N	2021-11-08 10:21:02.808+00	2021-11-08 10:21:03.163+00
5264	\N	died	2021-11-08 10:19:43.683+00	\N	\N	2021-11-08 10:20:29.322+00	2021-11-08 10:20:29.853+00
5276	\N	died	2021-11-08 10:19:44.049+00	\N	\N	2021-11-08 10:20:29.629+00	2021-11-08 10:20:29.929+00
5287	\N	died	2021-11-08 10:19:44.268+00	\N	\N	2021-11-08 10:20:29.913+00	2021-11-08 10:20:30.386+00
6454	\N	died	2021-11-08 10:20:16.636+00	\N	\N	2021-11-08 10:21:03.042+00	2021-11-08 10:21:03.214+00
5291	\N	died	2021-11-08 10:19:44.306+00	\N	\N	2021-11-08 10:20:30.18+00	2021-11-08 10:20:31.017+00
6626	\N	died	2021-11-08 10:20:17.437+00	\N	\N	2021-11-08 10:21:07.692+00	2021-11-08 10:21:08.045+00
5306	\N	died	2021-11-08 10:19:44.749+00	\N	\N	2021-11-08 10:20:30.967+00	2021-11-08 10:20:31.078+00
5310	\N	died	2021-11-08 10:19:44.845+00	\N	\N	2021-11-08 10:20:31.073+00	2021-11-08 10:20:31.252+00
6707	\N	died	2021-11-08 10:20:20.337+00	\N	\N	2021-11-08 10:21:09.952+00	2021-11-08 10:21:10.675+00
5316	\N	died	2021-11-08 10:19:44.871+00	\N	\N	2021-11-08 10:20:31.223+00	2021-11-08 10:20:31.645+00
5326	\N	died	2021-11-08 10:19:44.908+00	\N	\N	2021-11-08 10:20:31.496+00	2021-11-08 10:20:31.899+00
6462	\N	died	2021-11-08 10:20:16.652+00	\N	\N	2021-11-08 10:21:03.208+00	2021-11-08 10:21:03.347+00
6621	\N	died	2021-11-08 10:20:17.357+00	\N	\N	2021-11-08 10:21:07.586+00	2021-11-08 10:21:08.376+00
6468	\N	died	2021-11-08 10:20:16.661+00	\N	\N	2021-11-08 10:21:03.308+00	2021-11-08 10:21:03.836+00
6485	\N	died	2021-11-08 10:20:16.69+00	\N	\N	2021-11-08 10:21:03.775+00	2021-11-08 10:21:04.186+00
6501	\N	died	2021-11-08 10:20:16.713+00	\N	\N	2021-11-08 10:21:04.145+00	2021-11-08 10:21:04.999+00
6539	\N	died	2021-11-08 10:20:16.763+00	\N	\N	2021-11-08 10:21:05.277+00	2021-11-08 10:21:05.58+00
6544	\N	died	2021-11-08 10:20:16.769+00	\N	\N	2021-11-08 10:21:05.43+00	2021-11-08 10:21:05.58+00
6637	\N	died	2021-11-08 10:20:17.772+00	\N	\N	2021-11-08 10:21:08.011+00	2021-11-08 10:21:08.549+00
6526	\N	died	2021-11-08 10:20:16.745+00	\N	\N	2021-11-08 10:21:04.969+00	2021-11-08 10:21:05.603+00
6552	\N	died	2021-11-08 10:20:16.782+00	\N	\N	2021-11-08 10:21:05.576+00	2021-11-08 10:21:05.91+00
6554	\N	died	2021-11-08 10:20:16.782+00	\N	\N	2021-11-08 10:21:05.6+00	2021-11-08 10:21:05.953+00
6653	\N	died	2021-11-08 10:20:18.714+00	\N	\N	2021-11-08 10:21:08.5+00	2021-11-08 10:21:08.778+00
6558	\N	died	2021-11-08 10:20:16.79+00	\N	\N	2021-11-08 10:21:05.935+00	2021-11-08 10:21:06.071+00
6556	\N	died	2021-11-08 10:20:16.79+00	\N	\N	2021-11-08 10:21:05.746+00	2021-11-08 10:21:06.071+00
6739	\N	died	2021-11-08 10:20:20.773+00	\N	\N	2021-11-08 10:21:10.668+00	2021-11-08 10:21:10.95+00
6561	\N	died	2021-11-08 10:20:16.797+00	\N	\N	2021-11-08 10:21:06+00	2021-11-08 10:21:06.24+00
6562	\N	died	2021-11-08 10:20:16.797+00	\N	\N	2021-11-08 10:21:06.02+00	2021-11-08 10:21:06.295+00
6570	\N	died	2021-11-08 10:20:16.82+00	\N	\N	2021-11-08 10:21:06.235+00	2021-11-08 10:21:06.582+00
6572	\N	died	2021-11-08 10:20:16.826+00	\N	\N	2021-11-08 10:21:06.286+00	2021-11-08 10:21:06.582+00
6579	\N	died	2021-11-08 10:20:16.861+00	\N	\N	2021-11-08 10:21:06.5+00	2021-11-08 10:21:06.933+00
6749	\N	died	2021-11-08 10:20:20.895+00	\N	\N	2021-11-08 10:21:10.936+00	2021-11-08 10:21:11.026+00
6582	\N	died	2021-11-08 10:20:16.879+00	\N	\N	2021-11-08 10:21:06.55+00	2021-11-08 10:21:07.091+00
6601	\N	died	2021-11-08 10:20:17.021+00	\N	\N	2021-11-08 10:21:07.051+00	2021-11-08 10:21:07.321+00
6595	\N	died	2021-11-08 10:20:16.984+00	\N	\N	2021-11-08 10:21:06.876+00	2021-11-08 10:21:07.466+00
6751	\N	died	2021-11-08 10:20:20.91+00	\N	\N	2021-11-08 10:21:11.012+00	2021-11-08 10:21:11.062+00
6646	\N	died	2021-11-08 10:20:18.505+00	\N	\N	2021-11-08 10:21:08.313+00	2021-11-08 10:21:09.051+00
6662	\N	died	2021-11-08 10:20:19.047+00	\N	\N	2021-11-08 10:21:08.761+00	2021-11-08 10:21:09.051+00
6668	\N	died	2021-11-08 10:20:19.129+00	\N	\N	2021-11-08 10:21:08.884+00	2021-11-08 10:21:09.116+00
6676	\N	died	2021-11-08 10:20:19.359+00	\N	\N	2021-11-08 10:21:09.102+00	2021-11-08 10:21:09.27+00
6753	\N	died	2021-11-08 10:20:20.927+00	\N	\N	2021-11-08 10:21:11.059+00	2021-11-08 10:21:11.164+00
6670	\N	died	2021-11-08 10:20:19.17+00	\N	\N	2021-11-08 10:21:08.934+00	2021-11-08 10:21:09.432+00
6671	\N	died	2021-11-08 10:20:19.177+00	\N	\N	2021-11-08 10:21:08.953+00	2021-11-08 10:21:09.432+00
6680	\N	died	2021-11-08 10:20:19.485+00	\N	\N	2021-11-08 10:21:09.209+00	2021-11-08 10:21:09.521+00
6690	\N	died	2021-11-08 10:20:19.675+00	\N	\N	2021-11-08 10:21:09.461+00	2021-11-08 10:21:09.715+00
6757	\N	died	2021-11-08 10:20:20.945+00	\N	\N	2021-11-08 10:21:11.152+00	2021-11-08 10:21:11.33+00
6698	\N	died	2021-11-08 10:20:19.921+00	\N	\N	2021-11-08 10:21:09.709+00	2021-11-08 10:21:09.812+00
6683	\N	died	2021-11-08 10:20:19.565+00	\N	\N	2021-11-08 10:21:09.276+00	2021-11-08 10:21:09.841+00
6703	\N	died	2021-11-08 10:20:20.18+00	\N	\N	2021-11-08 10:21:09.795+00	2021-11-08 10:21:09.971+00
6761	\N	died	2021-11-08 10:20:20.995+00	\N	\N	2021-11-08 10:21:11.322+00	2021-11-08 10:21:11.472+00
6768	\N	died	2021-11-08 10:20:21.027+00	\N	\N	2021-11-08 10:21:11.46+00	2021-11-08 10:21:11.589+00
6771	\N	died	2021-11-08 10:20:21.053+00	\N	\N	2021-11-08 10:21:11.584+00	2021-11-08 10:21:11.623+00
6773	\N	died	2021-11-08 10:20:21.069+00	\N	\N	2021-11-08 10:21:11.618+00	2021-11-08 10:21:11.72+00
6778	\N	died	2021-11-08 10:20:21.103+00	\N	\N	2021-11-08 10:21:11.703+00	2021-11-08 10:21:11.869+00
6782	\N	died	2021-11-08 10:20:21.135+00	\N	\N	2021-11-08 10:21:11.862+00	2021-11-08 10:21:11.972+00
6787	\N	died	2021-11-08 10:20:21.159+00	\N	\N	2021-11-08 10:21:11.957+00	2021-11-08 10:21:12.156+00
5153	\N	died	2021-11-08 10:19:35.521+00	\N	\N	2021-11-08 10:20:26.63+00	2021-11-08 10:20:26.716+00
6735	\N	died	2021-11-08 10:20:20.735+00	\N	\N	2021-11-08 10:21:10.55+00	2021-11-08 10:21:10.95+00
5155	\N	died	2021-11-08 10:19:35.646+00	\N	\N	2021-11-08 10:20:26.712+00	2021-11-08 10:20:26.868+00
5332	\N	died	2021-11-08 10:19:45.023+00	\N	\N	2021-11-08 10:20:31.61+00	2021-11-08 10:20:32.422+00
5161	\N	died	2021-11-08 10:19:35.982+00	\N	\N	2021-11-08 10:20:26.86+00	2021-11-08 10:20:27.173+00
5171	\N	died	2021-11-08 10:19:36.78+00	\N	\N	2021-11-08 10:20:27.122+00	2021-11-08 10:20:27.583+00
5188	\N	died	2021-11-08 10:19:38.247+00	\N	\N	2021-11-08 10:20:27.563+00	2021-11-08 10:20:28.12+00
5206	\N	died	2021-11-08 10:19:40.105+00	\N	\N	2021-11-08 10:20:27.98+00	2021-11-08 10:20:28.305+00
6448	\N	died	2021-11-08 10:20:16.619+00	\N	\N	2021-11-08 10:21:02.826+00	2021-11-08 10:21:03.163+00
5220	\N	died	2021-11-08 10:19:41.78+00	\N	\N	2021-11-08 10:20:28.273+00	2021-11-08 10:20:28.535+00
6682	\N	died	2021-11-08 10:20:19.531+00	\N	\N	2021-11-08 10:21:09.259+00	2021-11-08 10:21:09.432+00
5232	\N	died	2021-11-08 10:19:42.46+00	\N	\N	2021-11-08 10:20:28.513+00	2021-11-08 10:20:28.952+00
5247	\N	died	2021-11-08 10:19:42.849+00	\N	\N	2021-11-08 10:20:28.838+00	2021-11-08 10:20:29.409+00
6458	\N	died	2021-11-08 10:20:16.643+00	\N	\N	2021-11-08 10:21:03.125+00	2021-11-08 10:21:03.537+00
5266	\N	died	2021-11-08 10:19:43.733+00	\N	\N	2021-11-08 10:20:29.354+00	2021-11-08 10:20:29.853+00
6678	\N	died	2021-11-08 10:20:19.41+00	\N	\N	2021-11-08 10:21:09.144+00	2021-11-08 10:21:09.432+00
5282	\N	died	2021-11-08 10:19:44.116+00	\N	\N	2021-11-08 10:20:29.752+00	2021-11-08 10:20:30.945+00
6679	\N	died	2021-11-08 10:20:19.444+00	\N	\N	2021-11-08 10:21:09.178+00	2021-11-08 10:21:09.432+00
5302	\N	died	2021-11-08 10:19:44.671+00	\N	\N	2021-11-08 10:20:30.721+00	2021-11-08 10:20:31.356+00
6729	\N	died	2021-11-08 10:20:20.673+00	\N	\N	2021-11-08 10:21:10.451+00	2021-11-08 10:21:10.95+00
5322	\N	died	2021-11-08 10:19:44.897+00	\N	\N	2021-11-08 10:20:31.347+00	2021-11-08 10:20:31.645+00
6474	\N	died	2021-11-08 10:20:16.672+00	\N	\N	2021-11-08 10:21:03.483+00	2021-11-08 10:21:03.836+00
6486	\N	died	2021-11-08 10:20:16.69+00	\N	\N	2021-11-08 10:21:03.794+00	2021-11-08 10:21:04.34+00
6688	\N	died	2021-11-08 10:20:19.631+00	\N	\N	2021-11-08 10:21:09.427+00	2021-11-08 10:21:09.521+00
6503	\N	died	2021-11-08 10:20:16.718+00	\N	\N	2021-11-08 10:21:04.202+00	2021-11-08 10:21:04.766+00
6737	\N	died	2021-11-08 10:20:20.756+00	\N	\N	2021-11-08 10:21:10.567+00	2021-11-08 10:21:10.95+00
6518	\N	died	2021-11-08 10:20:16.733+00	\N	\N	2021-11-08 10:21:04.734+00	2021-11-08 10:21:05.081+00
6532	\N	died	2021-11-08 10:20:16.756+00	\N	\N	2021-11-08 10:21:05.075+00	2021-11-08 10:21:05.23+00
6692	\N	died	2021-11-08 10:20:19.811+00	\N	\N	2021-11-08 10:21:09.5+00	2021-11-08 10:21:09.641+00
6537	\N	died	2021-11-08 10:20:16.763+00	\N	\N	2021-11-08 10:21:05.225+00	2021-11-08 10:21:05.361+00
6543	\N	died	2021-11-08 10:20:16.769+00	\N	\N	2021-11-08 10:21:05.358+00	2021-11-08 10:21:05.58+00
6549	\N	died	2021-11-08 10:20:16.775+00	\N	\N	2021-11-08 10:21:05.525+00	2021-11-08 10:21:06.222+00
6695	\N	died	2021-11-08 10:20:19.879+00	\N	\N	2021-11-08 10:21:09.628+00	2021-11-08 10:21:09.7+00
6569	\N	died	2021-11-08 10:20:16.809+00	\N	\N	2021-11-08 10:21:06.217+00	2021-11-08 10:21:06.582+00
6577	\N	died	2021-11-08 10:20:16.842+00	\N	\N	2021-11-08 10:21:06.467+00	2021-11-08 10:21:06.806+00
6591	\N	died	2021-11-08 10:20:16.964+00	\N	\N	2021-11-08 10:21:06.784+00	2021-11-08 10:21:07.172+00
6697	\N	died	2021-11-08 10:20:19.899+00	\N	\N	2021-11-08 10:21:09.693+00	2021-11-08 10:21:09.812+00
6603	\N	died	2021-11-08 10:20:17.026+00	\N	\N	2021-11-08 10:21:07.101+00	2021-11-08 10:21:07.466+00
6617	\N	died	2021-11-08 10:20:17.297+00	\N	\N	2021-11-08 10:21:07.455+00	2021-11-08 10:21:07.632+00
6613	\N	died	2021-11-08 10:20:17.187+00	\N	\N	2021-11-08 10:21:07.336+00	2021-11-08 10:21:07.714+00
6622	\N	died	2021-11-08 10:20:17.371+00	\N	\N	2021-11-08 10:21:07.623+00	2021-11-08 10:21:07.714+00
6786	\N	died	2021-11-08 10:20:21.157+00	\N	\N	2021-11-08 10:21:11.935+00	2021-11-08 10:21:12.414+00
6627	\N	died	2021-11-08 10:20:17.453+00	\N	\N	2021-11-08 10:21:07.71+00	2021-11-08 10:21:07.807+00
6684	\N	died	2021-11-08 10:20:19.569+00	\N	\N	2021-11-08 10:21:09.351+00	2021-11-08 10:21:09.971+00
6631	\N	died	2021-11-08 10:20:17.654+00	\N	\N	2021-11-08 10:21:07.794+00	2021-11-08 10:21:08.045+00
6624	\N	died	2021-11-08 10:20:17.413+00	\N	\N	2021-11-08 10:21:07.66+00	2021-11-08 10:21:08.117+00
6639	\N	died	2021-11-08 10:20:17.85+00	\N	\N	2021-11-08 10:21:08.103+00	2021-11-08 10:21:08.376+00
6636	\N	died	2021-11-08 10:20:17.738+00	\N	\N	2021-11-08 10:21:07.983+00	2021-11-08 10:21:08.491+00
6741	\N	died	2021-11-08 10:20:20.814+00	\N	\N	2021-11-08 10:21:10.71+00	2021-11-08 10:21:11.254+00
6651	\N	died	2021-11-08 10:20:18.627+00	\N	\N	2021-11-08 10:21:08.467+00	2021-11-08 10:21:08.625+00
6645	\N	died	2021-11-08 10:20:18.478+00	\N	\N	2021-11-08 10:21:08.292+00	2021-11-08 10:21:08.874+00
6658	\N	died	2021-11-08 10:20:18.933+00	\N	\N	2021-11-08 10:21:08.609+00	2021-11-08 10:21:08.874+00
6663	\N	died	2021-11-08 10:20:19.072+00	\N	\N	2021-11-08 10:21:08.799+00	2021-11-08 10:21:09.087+00
6744	\N	died	2021-11-08 10:20:20.84+00	\N	\N	2021-11-08 10:21:10.783+00	2021-11-08 10:21:11.33+00
6664	\N	died	2021-11-08 10:20:19.088+00	\N	\N	2021-11-08 10:21:08.818+00	2021-11-08 10:21:09.159+00
6677	\N	died	2021-11-08 10:20:19.404+00	\N	\N	2021-11-08 10:21:09.127+00	2021-11-08 10:21:09.27+00
6745	\N	died	2021-11-08 10:20:20.853+00	\N	\N	2021-11-08 10:21:10.811+00	2021-11-08 10:21:11.472+00
6674	\N	died	2021-11-08 10:20:19.321+00	\N	\N	2021-11-08 10:21:09.067+00	2021-11-08 10:21:09.197+00
6758	\N	died	2021-11-08 10:20:20.967+00	\N	\N	2021-11-08 10:21:11.236+00	2021-11-08 10:21:11.472+00
6686	\N	died	2021-11-08 10:20:19.602+00	\N	\N	2021-11-08 10:21:09.394+00	2021-11-08 10:21:10.023+00
6701	\N	died	2021-11-08 10:20:19.995+00	\N	\N	2021-11-08 10:21:09.759+00	2021-11-08 10:21:10.182+00
6706	\N	died	2021-11-08 10:20:20.246+00	\N	\N	2021-11-08 10:21:09.936+00	2021-11-08 10:21:10.237+00
6719	\N	died	2021-11-08 10:20:20.58+00	\N	\N	2021-11-08 10:21:10.226+00	2021-11-08 10:21:10.411+00
6791	\N	died	2021-11-08 10:20:21.284+00	\N	\N	2021-11-08 10:21:12.11+00	2021-11-08 10:21:12.732+00
6803	\N	died	2021-11-08 10:20:21.404+00	\N	\N	2021-11-08 10:21:12.402+00	2021-11-08 10:21:12.732+00
6715	\N	died	2021-11-08 10:20:20.525+00	\N	\N	2021-11-08 10:21:10.08+00	2021-11-08 10:21:10.523+00
6727	\N	died	2021-11-08 10:20:20.652+00	\N	\N	2021-11-08 10:21:10.395+00	2021-11-08 10:21:10.523+00
6790	\N	died	2021-11-08 10:20:21.281+00	\N	\N	2021-11-08 10:21:12.034+00	2021-11-08 10:21:12.732+00
6732	\N	died	2021-11-08 10:20:20.703+00	\N	\N	2021-11-08 10:21:10.518+00	2021-11-08 10:21:10.554+00
6796	\N	died	2021-11-08 10:20:21.324+00	\N	\N	2021-11-08 10:21:12.201+00	2021-11-08 10:21:12.732+00
6802	\N	died	2021-11-08 10:20:21.389+00	\N	\N	2021-11-08 10:21:12.37+00	2021-11-08 10:21:12.732+00
6710	\N	died	2021-11-08 10:20:20.399+00	\N	\N	2021-11-08 10:21:10+00	2021-11-08 10:21:10.571+00
6792	\N	died	2021-11-08 10:20:21.3+00	\N	\N	2021-11-08 10:21:12.135+00	2021-11-08 10:21:12.732+00
6762	\N	died	2021-11-08 10:20:20.997+00	\N	\N	2021-11-08 10:21:11.336+00	2021-11-08 10:21:11.607+00
6760	\N	died	2021-11-08 10:20:20.979+00	\N	\N	2021-11-08 10:21:11.294+00	2021-11-08 10:21:11.639+00
6772	\N	died	2021-11-08 10:20:21.054+00	\N	\N	2021-11-08 10:21:11.601+00	2021-11-08 10:21:11.72+00
6774	\N	died	2021-11-08 10:20:21.072+00	\N	\N	2021-11-08 10:21:11.634+00	2021-11-08 10:21:11.869+00
6765	\N	died	2021-11-08 10:20:21.02+00	\N	\N	2021-11-08 10:21:11.386+00	2021-11-08 10:21:11.89+00
6777	\N	died	2021-11-08 10:20:21.088+00	\N	\N	2021-11-08 10:21:11.684+00	2021-11-08 10:21:11.972+00
6811	\N	died	2021-11-08 10:20:21.701+00	\N	\N	2021-11-08 10:21:12.716+00	2021-11-08 10:21:12.791+00
6813	\N	died	2021-11-08 10:20:21.789+00	\N	\N	2021-11-08 10:21:12.781+00	2021-11-08 10:21:12.874+00
6817	\N	died	2021-11-08 10:20:22.216+00	\N	\N	2021-11-08 10:21:12.855+00	2021-11-08 10:21:12.941+00
6808	\N	died	2021-11-08 10:20:21.612+00	\N	\N	2021-11-08 10:21:12.501+00	2021-11-08 10:21:13.13+00
6821	\N	died	2021-11-08 10:20:22.318+00	\N	\N	2021-11-08 10:21:12.934+00	2021-11-08 10:21:13.13+00
5228	\N	died	2021-11-08 10:19:42.365+00	\N	\N	2021-11-08 10:20:28.441+00	2021-11-08 10:20:28.535+00
5327	\N	died	2021-11-08 10:19:44.924+00	\N	\N	2021-11-08 10:20:31.528+00	2021-11-08 10:20:32.166+00
5233	\N	died	2021-11-08 10:19:42.478+00	\N	\N	2021-11-08 10:20:28.53+00	2021-11-08 10:20:28.68+00
5238	\N	died	2021-11-08 10:19:42.641+00	\N	\N	2021-11-08 10:20:28.663+00	2021-11-08 10:20:28.952+00
5342	\N	died	2021-11-08 10:19:45.173+00	\N	\N	2021-11-08 10:20:31.916+00	2021-11-08 10:20:32.364+00
5248	\N	died	2021-11-08 10:19:42.974+00	\N	\N	2021-11-08 10:20:28.855+00	2021-11-08 10:20:29.427+00
5269	\N	died	2021-11-08 10:19:43.822+00	\N	\N	2021-11-08 10:20:29.422+00	2021-11-08 10:20:29.577+00
5273	\N	died	2021-11-08 10:19:43.983+00	\N	\N	2021-11-08 10:20:29.57+00	2021-11-08 10:20:29.853+00
6452	\N	died	2021-11-08 10:20:16.633+00	\N	\N	2021-11-08 10:21:02.909+00	2021-11-08 10:21:03.163+00
5281	\N	died	2021-11-08 10:19:44.114+00	\N	\N	2021-11-08 10:20:29.736+00	2021-11-08 10:20:30.945+00
6704	\N	died	2021-11-08 10:20:20.186+00	\N	\N	2021-11-08 10:21:09.829+00	2021-11-08 10:21:10.023+00
5300	\N	died	2021-11-08 10:19:44.624+00	\N	\N	2021-11-08 10:20:30.624+00	2021-11-08 10:20:31.268+00
5318	\N	died	2021-11-08 10:19:44.889+00	\N	\N	2021-11-08 10:20:31.261+00	2021-11-08 10:20:31.645+00
6456	\N	died	2021-11-08 10:20:16.64+00	\N	\N	2021-11-08 10:21:03.094+00	2021-11-08 10:21:03.347+00
6687	\N	died	2021-11-08 10:20:19.606+00	\N	\N	2021-11-08 10:21:09.409+00	2021-11-08 10:21:10.063+00
6466	\N	died	2021-11-08 10:20:16.657+00	\N	\N	2021-11-08 10:21:03.276+00	2021-11-08 10:21:03.537+00
6708	\N	died	2021-11-08 10:20:20.344+00	\N	\N	2021-11-08 10:21:09.967+00	2021-11-08 10:21:10.063+00
6475	\N	died	2021-11-08 10:20:16.677+00	\N	\N	2021-11-08 10:21:03.504+00	2021-11-08 10:21:03.856+00
6702	\N	died	2021-11-08 10:20:20.123+00	\N	\N	2021-11-08 10:21:09.776+00	2021-11-08 10:21:10.063+00
6488	\N	died	2021-11-08 10:20:16.693+00	\N	\N	2021-11-08 10:21:03.851+00	2021-11-08 10:21:03.939+00
6491	\N	died	2021-11-08 10:20:16.697+00	\N	\N	2021-11-08 10:21:03.9+00	2021-11-08 10:21:04.186+00
6755	\N	died	2021-11-08 10:20:20.93+00	\N	\N	2021-11-08 10:21:11.097+00	2021-11-08 10:21:11.472+00
6500	\N	died	2021-11-08 10:20:16.713+00	\N	\N	2021-11-08 10:21:04.125+00	2021-11-08 10:21:04.999+00
6711	\N	died	2021-11-08 10:20:20.437+00	\N	\N	2021-11-08 10:21:10.019+00	2021-11-08 10:21:10.182+00
6524	\N	died	2021-11-08 10:20:16.745+00	\N	\N	2021-11-08 10:21:04.921+00	2021-11-08 10:21:05.339+00
6538	\N	died	2021-11-08 10:20:16.763+00	\N	\N	2021-11-08 10:21:05.244+00	2021-11-08 10:21:05.471+00
6746	\N	died	2021-11-08 10:20:20.856+00	\N	\N	2021-11-08 10:21:10.827+00	2021-11-08 10:21:11.472+00
6545	\N	died	2021-11-08 10:20:16.769+00	\N	\N	2021-11-08 10:21:05.464+00	2021-11-08 10:21:05.91+00
6714	\N	died	2021-11-08 10:20:20.495+00	\N	\N	2021-11-08 10:21:10.059+00	2021-11-08 10:21:10.216+00
6555	\N	died	2021-11-08 10:20:16.782+00	\N	\N	2021-11-08 10:21:05.669+00	2021-11-08 10:21:06.071+00
6563	\N	died	2021-11-08 10:20:16.797+00	\N	\N	2021-11-08 10:21:06.034+00	2021-11-08 10:21:06.582+00
6575	\N	died	2021-11-08 10:20:16.836+00	\N	\N	2021-11-08 10:21:06.351+00	2021-11-08 10:21:06.63+00
6716	\N	died	2021-11-08 10:20:20.531+00	\N	\N	2021-11-08 10:21:10.165+00	2021-11-08 10:21:10.237+00
6586	\N	died	2021-11-08 10:20:16.896+00	\N	\N	2021-11-08 10:21:06.626+00	2021-11-08 10:21:06.806+00
6590	\N	died	2021-11-08 10:20:16.962+00	\N	\N	2021-11-08 10:21:06.768+00	2021-11-08 10:21:07.091+00
6748	\N	died	2021-11-08 10:20:20.877+00	\N	\N	2021-11-08 10:21:10.86+00	2021-11-08 10:21:11.589+00
6600	\N	died	2021-11-08 10:20:17.011+00	\N	\N	2021-11-08 10:21:07.03+00	2021-11-08 10:21:07.231+00
6718	\N	died	2021-11-08 10:20:20.558+00	\N	\N	2021-11-08 10:21:10.211+00	2021-11-08 10:21:10.245+00
6609	\N	died	2021-11-08 10:20:17.122+00	\N	\N	2021-11-08 10:21:07.226+00	2021-11-08 10:21:07.466+00
6615	\N	died	2021-11-08 10:20:17.207+00	\N	\N	2021-11-08 10:21:07.402+00	2021-11-08 10:21:07.73+00
6628	\N	died	2021-11-08 10:20:17.534+00	\N	\N	2021-11-08 10:21:07.725+00	2021-11-08 10:21:07.934+00
6720	\N	died	2021-11-08 10:20:20.583+00	\N	\N	2021-11-08 10:21:10.233+00	2021-11-08 10:21:10.255+00
6632	\N	died	2021-11-08 10:20:17.656+00	\N	\N	2021-11-08 10:21:07.869+00	2021-11-08 10:21:08.233+00
6616	\N	died	2021-11-08 10:20:17.281+00	\N	\N	2021-11-08 10:21:07.429+00	2021-11-08 10:21:08.376+00
6640	\N	died	2021-11-08 10:20:17.921+00	\N	\N	2021-11-08 10:21:08.18+00	2021-11-08 10:21:08.406+00
6644	\N	died	2021-11-08 10:20:18.427+00	\N	\N	2021-11-08 10:21:08.275+00	2021-11-08 10:21:08.549+00
6649	\N	died	2021-11-08 10:20:18.54+00	\N	\N	2021-11-08 10:21:08.384+00	2021-11-08 10:21:08.691+00
6721	\N	died	2021-11-08 10:20:20.603+00	\N	\N	2021-11-08 10:21:10.242+00	2021-11-08 10:21:10.335+00
6654	\N	died	2021-11-08 10:20:18.842+00	\N	\N	2021-11-08 10:21:08.52+00	2021-11-08 10:21:08.874+00
6722	\N	died	2021-11-08 10:20:20.604+00	\N	\N	2021-11-08 10:21:10.252+00	2021-11-08 10:21:10.335+00
6660	\N	died	2021-11-08 10:20:19.02+00	\N	\N	2021-11-08 10:21:08.652+00	2021-11-08 10:21:09.051+00
6665	\N	died	2021-11-08 10:20:19.091+00	\N	\N	2021-11-08 10:21:08.834+00	2021-11-08 10:21:09.432+00
6672	\N	died	2021-11-08 10:20:19.274+00	\N	\N	2021-11-08 10:21:08.967+00	2021-11-08 10:21:09.521+00
6769	\N	died	2021-11-08 10:20:21.036+00	\N	\N	2021-11-08 10:21:11.536+00	2021-11-08 10:21:11.72+00
6691	\N	died	2021-11-08 10:20:19.761+00	\N	\N	2021-11-08 10:21:09.476+00	2021-11-08 10:21:09.812+00
6763	\N	died	2021-11-08 10:20:20.999+00	\N	\N	2021-11-08 10:21:11.351+00	2021-11-08 10:21:11.72+00
6685	\N	died	2021-11-08 10:20:19.598+00	\N	\N	2021-11-08 10:21:09.38+00	2021-11-08 10:21:09.971+00
6764	\N	died	2021-11-08 10:20:21.001+00	\N	\N	2021-11-08 10:21:11.367+00	2021-11-08 10:21:11.869+00
6726	\N	died	2021-11-08 10:20:20.645+00	\N	\N	2021-11-08 10:21:10.328+00	2021-11-08 10:21:10.523+00
6713	\N	died	2021-11-08 10:20:20.489+00	\N	\N	2021-11-08 10:21:10.042+00	2021-11-08 10:21:10.523+00
6724	\N	died	2021-11-08 10:20:20.62+00	\N	\N	2021-11-08 10:21:10.279+00	2021-11-08 10:21:10.554+00
6805	\N	died	2021-11-08 10:20:21.425+00	\N	\N	2021-11-08 10:21:12.443+00	2021-11-08 10:21:12.894+00
6734	\N	died	2021-11-08 10:20:20.729+00	\N	\N	2021-11-08 10:21:10.543+00	2021-11-08 10:21:10.95+00
6730	\N	died	2021-11-08 10:20:20.686+00	\N	\N	2021-11-08 10:21:10.469+00	2021-11-08 10:21:10.95+00
6731	\N	died	2021-11-08 10:20:20.688+00	\N	\N	2021-11-08 10:21:10.501+00	2021-11-08 10:21:10.95+00
6742	\N	died	2021-11-08 10:20:20.82+00	\N	\N	2021-11-08 10:21:10.735+00	2021-11-08 10:21:11.049+00
6806	\N	died	2021-11-08 10:20:21.568+00	\N	\N	2021-11-08 10:21:12.46+00	2021-11-08 10:21:12.941+00
6752	\N	died	2021-11-08 10:20:20.912+00	\N	\N	2021-11-08 10:21:11.044+00	2021-11-08 10:21:11.164+00
6807	\N	died	2021-11-08 10:20:21.573+00	\N	\N	2021-11-08 10:21:12.476+00	2021-11-08 10:21:13.13+00
6776	\N	died	2021-11-08 10:20:21.086+00	\N	\N	2021-11-08 10:21:11.668+00	2021-11-08 10:21:11.972+00
6775	\N	died	2021-11-08 10:20:21.073+00	\N	\N	2021-11-08 10:21:11.651+00	2021-11-08 10:21:12.156+00
6780	\N	died	2021-11-08 10:20:21.106+00	\N	\N	2021-11-08 10:21:11.803+00	2021-11-08 10:21:12.156+00
6784	\N	died	2021-11-08 10:20:21.143+00	\N	\N	2021-11-08 10:21:11.901+00	2021-11-08 10:21:12.173+00
6781	\N	died	2021-11-08 10:20:21.128+00	\N	\N	2021-11-08 10:21:11.837+00	2021-11-08 10:21:12.241+00
6794	\N	died	2021-11-08 10:20:21.321+00	\N	\N	2021-11-08 10:21:12.167+00	2021-11-08 10:21:12.241+00
6798	\N	died	2021-11-08 10:20:21.354+00	\N	\N	2021-11-08 10:21:12.228+00	2021-11-08 10:21:12.387+00
6818	\N	died	2021-11-08 10:20:22.263+00	\N	\N	2021-11-08 10:21:12.885+00	2021-11-08 10:21:13.13+00
6820	\N	died	2021-11-08 10:20:22.315+00	\N	\N	2021-11-08 10:21:12.918+00	2021-11-08 10:21:13.262+00
6822	\N	died	2021-11-08 10:20:22.341+00	\N	\N	2021-11-08 10:21:13.003+00	2021-11-08 10:21:13.434+00
6832	\N	died	2021-11-08 10:20:22.466+00	\N	\N	2021-11-08 10:21:13.252+00	2021-11-08 10:21:13.434+00
5289	\N	died	2021-11-08 10:19:44.29+00	\N	\N	2021-11-08 10:20:30.078+00	2021-11-08 10:20:30.386+00
5328	\N	died	2021-11-08 10:19:44.925+00	\N	\N	2021-11-08 10:20:31.544+00	2021-11-08 10:20:32.166+00
5293	\N	died	2021-11-08 10:19:44.341+00	\N	\N	2021-11-08 10:20:30.369+00	2021-11-08 10:20:30.516+00
6700	\N	died	2021-11-08 10:20:19.936+00	\N	\N	2021-11-08 10:21:09.742+00	2021-11-08 10:21:10.023+00
5297	\N	died	2021-11-08 10:19:44.541+00	\N	\N	2021-11-08 10:20:30.498+00	2021-11-08 10:20:31.017+00
5344	\N	died	2021-11-08 10:19:45.256+00	\N	\N	2021-11-08 10:20:32.096+00	2021-11-08 10:20:32.666+00
5308	\N	died	2021-11-08 10:19:44.778+00	\N	\N	2021-11-08 10:20:31.017+00	2021-11-08 10:20:31.122+00
6814	\N	died	2021-11-08 10:20:21.845+00	\N	\N	2021-11-08 10:21:12.801+00	2021-11-08 10:21:12.941+00
5313	\N	died	2021-11-08 10:19:44.849+00	\N	\N	2021-11-08 10:20:31.11+00	2021-11-08 10:20:31.645+00
6465	\N	died	2021-11-08 10:20:16.657+00	\N	\N	2021-11-08 10:21:03.259+00	2021-11-08 10:21:03.347+00
6470	\N	died	2021-11-08 10:20:16.668+00	\N	\N	2021-11-08 10:21:03.343+00	2021-11-08 10:21:03.47+00
6705	\N	died	2021-11-08 10:20:20.239+00	\N	\N	2021-11-08 10:21:09.908+00	2021-11-08 10:21:10.216+00
6473	\N	died	2021-11-08 10:20:16.672+00	\N	\N	2021-11-08 10:21:03.46+00	2021-11-08 10:21:03.633+00
6479	\N	died	2021-11-08 10:20:16.681+00	\N	\N	2021-11-08 10:21:03.588+00	2021-11-08 10:21:04.059+00
6494	\N	died	2021-11-08 10:20:16.7+00	\N	\N	2021-11-08 10:21:04.006+00	2021-11-08 10:21:04.34+00
6505	\N	died	2021-11-08 10:20:16.718+00	\N	\N	2021-11-08 10:21:04.317+00	2021-11-08 10:21:04.672+00
6514	\N	died	2021-11-08 10:20:16.728+00	\N	\N	2021-11-08 10:21:04.637+00	2021-11-08 10:21:05.203+00
6717	\N	died	2021-11-08 10:20:20.555+00	\N	\N	2021-11-08 10:21:10.193+00	2021-11-08 10:21:10.271+00
6534	\N	died	2021-11-08 10:20:16.757+00	\N	\N	2021-11-08 10:21:05.179+00	2021-11-08 10:21:05.58+00
6770	\N	died	2021-11-08 10:20:21.037+00	\N	\N	2021-11-08 10:21:11.568+00	2021-11-08 10:21:11.869+00
6546	\N	died	2021-11-08 10:20:16.775+00	\N	\N	2021-11-08 10:21:05.476+00	2021-11-08 10:21:05.91+00
6712	\N	died	2021-11-08 10:20:20.443+00	\N	\N	2021-11-08 10:21:10.034+00	2021-11-08 10:21:10.335+00
6557	\N	died	2021-11-08 10:20:16.79+00	\N	\N	2021-11-08 10:21:05.895+00	2021-11-08 10:21:05.989+00
6560	\N	died	2021-11-08 10:20:16.797+00	\N	\N	2021-11-08 10:21:05.983+00	2021-11-08 10:21:06.205+00
6566	\N	died	2021-11-08 10:20:16.804+00	\N	\N	2021-11-08 10:21:06.17+00	2021-11-08 10:21:06.582+00
6723	\N	died	2021-11-08 10:20:20.606+00	\N	\N	2021-11-08 10:21:10.267+00	2021-11-08 10:21:10.523+00
6578	\N	died	2021-11-08 10:20:16.844+00	\N	\N	2021-11-08 10:21:06.483+00	2021-11-08 10:21:06.933+00
6593	\N	died	2021-11-08 10:20:16.969+00	\N	\N	2021-11-08 10:21:06.819+00	2021-11-08 10:21:07.172+00
6709	\N	died	2021-11-08 10:20:20.393+00	\N	\N	2021-11-08 10:21:09.984+00	2021-11-08 10:21:10.538+00
6605	\N	died	2021-11-08 10:20:17.046+00	\N	\N	2021-11-08 10:21:07.151+00	2021-11-08 10:21:07.651+00
6623	\N	died	2021-11-08 10:20:17.387+00	\N	\N	2021-11-08 10:21:07.643+00	2021-11-08 10:21:07.78+00
6629	\N	died	2021-11-08 10:20:17.576+00	\N	\N	2021-11-08 10:21:07.742+00	2021-11-08 10:21:08.045+00
6635	\N	died	2021-11-08 10:20:17.721+00	\N	\N	2021-11-08 10:21:07.951+00	2021-11-08 10:21:08.376+00
6641	\N	died	2021-11-08 10:20:18.073+00	\N	\N	2021-11-08 10:21:08.215+00	2021-11-08 10:21:08.376+00
6648	\N	died	2021-11-08 10:20:18.538+00	\N	\N	2021-11-08 10:21:08.368+00	2021-11-08 10:21:08.491+00
6652	\N	died	2021-11-08 10:20:18.645+00	\N	\N	2021-11-08 10:21:08.486+00	2021-11-08 10:21:08.574+00
6656	\N	died	2021-11-08 10:20:18.887+00	\N	\N	2021-11-08 10:21:08.568+00	2021-11-08 10:21:08.691+00
6725	\N	died	2021-11-08 10:20:20.622+00	\N	\N	2021-11-08 10:21:10.31+00	2021-11-08 10:21:10.563+00
6643	\N	died	2021-11-08 10:20:18.281+00	\N	\N	2021-11-08 10:21:08.263+00	2021-11-08 10:21:08.874+00
6659	\N	died	2021-11-08 10:20:18.968+00	\N	\N	2021-11-08 10:21:08.634+00	2021-11-08 10:21:09.051+00
6669	\N	died	2021-11-08 10:20:19.144+00	\N	\N	2021-11-08 10:21:08.903+00	2021-11-08 10:21:09.27+00
6666	\N	died	2021-11-08 10:20:19.094+00	\N	\N	2021-11-08 10:21:08.851+00	2021-11-08 10:21:09.448+00
6766	\N	died	2021-11-08 10:20:21.022+00	\N	\N	2021-11-08 10:21:11.403+00	2021-11-08 10:21:11.972+00
6681	\N	died	2021-11-08 10:20:19.496+00	\N	\N	2021-11-08 10:21:09.234+00	2021-11-08 10:21:09.542+00
6783	\N	died	2021-11-08 10:20:21.139+00	\N	\N	2021-11-08 10:21:11.884+00	2021-11-08 10:21:12.156+00
6689	\N	died	2021-11-08 10:20:19.67+00	\N	\N	2021-11-08 10:21:09.442+00	2021-11-08 10:21:09.641+00
6693	\N	died	2021-11-08 10:20:19.816+00	\N	\N	2021-11-08 10:21:09.534+00	2021-11-08 10:21:09.677+00
6767	\N	died	2021-11-08 10:20:21.023+00	\N	\N	2021-11-08 10:21:11.435+00	2021-11-08 10:21:12.156+00
6779	\N	died	2021-11-08 10:20:21.105+00	\N	\N	2021-11-08 10:21:11.734+00	2021-11-08 10:21:12.156+00
6696	\N	died	2021-11-08 10:20:19.881+00	\N	\N	2021-11-08 10:21:09.66+00	2021-11-08 10:21:09.733+00
6694	\N	died	2021-11-08 10:20:19.853+00	\N	\N	2021-11-08 10:21:09.552+00	2021-11-08 10:21:09.812+00
6699	\N	died	2021-11-08 10:20:19.923+00	\N	\N	2021-11-08 10:21:09.726+00	2021-11-08 10:21:09.971+00
6733	\N	died	2021-11-08 10:20:20.704+00	\N	\N	2021-11-08 10:21:10.534+00	2021-11-08 10:21:10.656+00
6799	\N	died	2021-11-08 10:20:21.355+00	\N	\N	2021-11-08 10:21:12.251+00	2021-11-08 10:21:12.732+00
6728	\N	died	2021-11-08 10:20:20.671+00	\N	\N	2021-11-08 10:21:10.428+00	2021-11-08 10:21:10.692+00
6800	\N	died	2021-11-08 10:20:21.369+00	\N	\N	2021-11-08 10:21:12.269+00	2021-11-08 10:21:12.732+00
6736	\N	died	2021-11-08 10:20:20.754+00	\N	\N	2021-11-08 10:21:10.559+00	2021-11-08 10:21:10.95+00
6738	\N	died	2021-11-08 10:20:20.771+00	\N	\N	2021-11-08 10:21:10.636+00	2021-11-08 10:21:10.95+00
6740	\N	died	2021-11-08 10:20:20.787+00	\N	\N	2021-11-08 10:21:10.684+00	2021-11-08 10:21:11.026+00
6801	\N	died	2021-11-08 10:20:21.387+00	\N	\N	2021-11-08 10:21:12.296+00	2021-11-08 10:21:12.768+00
6750	\N	died	2021-11-08 10:20:20.897+00	\N	\N	2021-11-08 10:21:10.979+00	2021-11-08 10:21:11.08+00
6743	\N	died	2021-11-08 10:20:20.838+00	\N	\N	2021-11-08 10:21:10.759+00	2021-11-08 10:21:11.164+00
6754	\N	died	2021-11-08 10:20:20.929+00	\N	\N	2021-11-08 10:21:11.076+00	2021-11-08 10:21:11.33+00
6827	\N	died	2021-11-08 10:20:22.414+00	\N	\N	2021-11-08 10:21:13.117+00	2021-11-08 10:21:13.706+00
6747	\N	died	2021-11-08 10:20:20.874+00	\N	\N	2021-11-08 10:21:10.843+00	2021-11-08 10:21:11.472+00
6756	\N	died	2021-11-08 10:20:20.944+00	\N	\N	2021-11-08 10:21:11.131+00	2021-11-08 10:21:11.472+00
6759	\N	died	2021-11-08 10:20:20.974+00	\N	\N	2021-11-08 10:21:11.268+00	2021-11-08 10:21:11.589+00
6793	\N	died	2021-11-08 10:20:21.305+00	\N	\N	2021-11-08 10:21:12.151+00	2021-11-08 10:21:12.189+00
6809	\N	died	2021-11-08 10:20:21.614+00	\N	\N	2021-11-08 10:21:12.543+00	2021-11-08 10:21:13.13+00
6816	\N	died	2021-11-08 10:20:22.112+00	\N	\N	2021-11-08 10:21:12.834+00	2021-11-08 10:21:13.13+00
6788	\N	died	2021-11-08 10:20:21.237+00	\N	\N	2021-11-08 10:21:11.985+00	2021-11-08 10:21:12.241+00
6815	\N	died	2021-11-08 10:20:22.108+00	\N	\N	2021-11-08 10:21:12.818+00	2021-11-08 10:21:13.13+00
6785	\N	died	2021-11-08 10:20:21.155+00	\N	\N	2021-11-08 10:21:11.917+00	2021-11-08 10:21:12.256+00
6795	\N	died	2021-11-08 10:20:21.323+00	\N	\N	2021-11-08 10:21:12.184+00	2021-11-08 10:21:12.387+00
6789	\N	died	2021-11-08 10:20:21.25+00	\N	\N	2021-11-08 10:21:12.003+00	2021-11-08 10:21:12.387+00
6797	\N	died	2021-11-08 10:20:21.337+00	\N	\N	2021-11-08 10:21:12.21+00	2021-11-08 10:21:12.807+00
6804	\N	died	2021-11-08 10:20:21.405+00	\N	\N	2021-11-08 10:21:12.428+00	2021-11-08 10:21:12.874+00
6812	\N	died	2021-11-08 10:20:21.706+00	\N	\N	2021-11-08 10:21:12.756+00	2021-11-08 10:21:12.874+00
6810	\N	died	2021-11-08 10:20:21.627+00	\N	\N	2021-11-08 10:21:12.654+00	2021-11-08 10:21:13.154+00
6819	\N	died	2021-11-08 10:20:22.291+00	\N	\N	2021-11-08 10:21:12.901+00	2021-11-08 10:21:13.242+00
6828	\N	died	2021-11-08 10:20:22.429+00	\N	\N	2021-11-08 10:21:13.127+00	2021-11-08 10:21:13.242+00
6829	\N	died	2021-11-08 10:20:22.431+00	\N	\N	2021-11-08 10:21:13.144+00	2021-11-08 10:21:13.434+00
6831	\N	died	2021-11-08 10:20:22.464+00	\N	\N	2021-11-08 10:21:13.231+00	2021-11-08 10:21:13.434+00
6823	\N	died	2021-11-08 10:20:22.365+00	\N	\N	2021-11-08 10:21:13.035+00	2021-11-08 10:21:13.434+00
6836	\N	died	2021-11-08 10:20:22.584+00	\N	\N	2021-11-08 10:21:13.401+00	2021-11-08 10:21:13.931+00
6835	\N	died	2021-11-08 10:20:22.581+00	\N	\N	2021-11-08 10:21:13.385+00	2021-11-08 10:21:13.931+00
6847	\N	died	2021-11-08 10:20:22.919+00	\N	\N	2021-11-08 10:21:13.701+00	2021-11-08 10:21:13.931+00
6838	\N	died	2021-11-08 10:20:22.633+00	\N	\N	2021-11-08 10:21:13.458+00	2021-11-08 10:21:13.675+00
6845	\N	died	2021-11-08 10:20:22.85+00	\N	\N	2021-11-08 10:21:13.665+00	2021-11-08 10:21:13.931+00
6853	\N	died	2021-11-08 10:20:23.036+00	\N	\N	2021-11-08 10:21:13.819+00	2021-11-08 10:21:14.272+00
6872	\N	died	2021-11-08 10:20:23.786+00	\N	\N	2021-11-08 10:21:14.267+00	2021-11-08 10:21:14.371+00
6878	\N	died	2021-11-08 10:20:23.909+00	\N	\N	2021-11-08 10:21:14.367+00	2021-11-08 10:21:14.398+00
6880	\N	died	2021-11-08 10:20:23.963+00	\N	\N	2021-11-08 10:21:14.394+00	2021-11-08 10:21:14.512+00
6884	\N	died	2021-11-08 10:20:24.028+00	\N	\N	2021-11-08 10:21:14.495+00	2021-11-08 10:21:14.699+00
6891	\N	died	2021-11-08 10:20:24.129+00	\N	\N	2021-11-08 10:21:14.694+00	2021-11-08 10:21:14.856+00
6897	\N	died	2021-11-08 10:20:24.221+00	\N	\N	2021-11-08 10:21:14.847+00	2021-11-08 10:21:14.956+00
6900	\N	died	2021-11-08 10:20:24.291+00	\N	\N	2021-11-08 10:21:14.951+00	2021-11-08 10:21:15.042+00
6905	\N	died	2021-11-08 10:20:24.378+00	\N	\N	2021-11-08 10:21:15.036+00	2021-11-08 10:21:15.09+00
6908	\N	died	2021-11-08 10:20:24.537+00	\N	\N	2021-11-08 10:21:15.084+00	2021-11-08 10:21:15.34+00
6915	\N	died	2021-11-08 10:20:24.671+00	\N	\N	2021-11-08 10:21:15.336+00	2021-11-08 10:21:15.373+00
6917	\N	died	2021-11-08 10:20:24.69+00	\N	\N	2021-11-08 10:21:15.368+00	2021-11-08 10:21:15.539+00
6922	\N	died	2021-11-08 10:20:24.76+00	\N	\N	2021-11-08 10:21:15.52+00	2021-11-08 10:21:15.904+00
6928	\N	died	2021-11-08 10:20:24.955+00	\N	\N	2021-11-08 10:21:15.887+00	2021-11-08 10:21:16.253+00
6932	\N	died	2021-11-08 10:20:25.048+00	\N	\N	2021-11-08 10:21:16.237+00	2021-11-08 10:21:16.351+00
6936	\N	died	2021-11-08 10:20:25.128+00	\N	\N	2021-11-08 10:21:16.345+00	2021-11-08 10:21:16.383+00
6938	\N	died	2021-11-08 10:20:25.161+00	\N	\N	2021-11-08 10:21:16.376+00	2021-11-08 10:21:16.52+00
6945	\N	died	2021-11-08 10:20:25.357+00	\N	\N	2021-11-08 10:21:16.514+00	2021-11-08 10:21:16.588+00
6951	\N	died	2021-11-08 10:20:25.47+00	\N	\N	2021-11-08 10:21:16.584+00	2021-11-08 10:21:16.645+00
6953	\N	died	2021-11-08 10:20:25.486+00	\N	\N	2021-11-08 10:21:16.637+00	2021-11-08 10:21:16.694+00
6955	\N	died	2021-11-08 10:20:25.586+00	\N	\N	2021-11-08 10:21:16.688+00	2021-11-08 10:21:16.917+00
6961	\N	died	2021-11-08 10:20:25.7+00	\N	\N	2021-11-08 10:21:16.901+00	2021-11-08 10:21:17.19+00
6970	\N	died	2021-11-08 10:20:25.97+00	\N	\N	2021-11-08 10:21:17.174+00	2021-11-08 10:21:17.253+00
6972	\N	died	2021-11-08 10:20:26.014+00	\N	\N	2021-11-08 10:21:17.244+00	2021-11-08 10:21:17.309+00
6975	\N	died	2021-11-08 10:20:26.079+00	\N	\N	2021-11-08 10:21:17.302+00	2021-11-08 10:21:17.399+00
6979	\N	died	2021-11-08 10:20:26.253+00	\N	\N	2021-11-08 10:21:17.383+00	2021-11-08 10:21:17.555+00
6982	\N	died	2021-11-08 10:20:26.321+00	\N	\N	2021-11-08 10:21:17.537+00	2021-11-08 10:21:17.69+00
6986	\N	died	2021-11-08 10:20:26.447+00	\N	\N	2021-11-08 10:21:17.675+00	2021-11-08 10:21:17.903+00
6992	\N	died	2021-11-08 10:20:26.578+00	\N	\N	2021-11-08 10:21:17.887+00	2021-11-08 10:21:18.176+00
7000	\N	died	2021-11-08 10:20:26.805+00	\N	\N	2021-11-08 10:21:18.163+00	2021-11-08 10:21:18.224+00
7002	\N	died	2021-11-08 10:20:26.881+00	\N	\N	2021-11-08 10:21:18.218+00	2021-11-08 10:21:18.337+00
7004	\N	died	2021-11-08 10:20:26.92+00	\N	\N	2021-11-08 10:21:18.318+00	2021-11-08 10:21:18.743+00
7008	\N	died	2021-11-08 10:20:26.992+00	\N	\N	2021-11-08 10:21:18.735+00	2021-11-08 10:21:18.844+00
7014	\N	died	2021-11-08 10:20:27.154+00	\N	\N	2021-11-08 10:21:18.838+00	2021-11-08 10:21:18.892+00
7017	\N	died	2021-11-08 10:20:27.209+00	\N	\N	2021-11-08 10:21:18.885+00	2021-11-08 10:21:19.057+00
7023	\N	died	2021-11-08 10:20:27.362+00	\N	\N	2021-11-08 10:21:19.052+00	2021-11-08 10:21:19.096+00
7025	\N	died	2021-11-08 10:20:27.412+00	\N	\N	2021-11-08 10:21:19.089+00	2021-11-08 10:21:19.192+00
6824	\N	died	2021-11-08 10:20:22.368+00	\N	\N	2021-11-08 10:21:13.051+00	2021-11-08 10:21:13.566+00
6840	\N	died	2021-11-08 10:20:22.678+00	\N	\N	2021-11-08 10:21:13.51+00	2021-11-08 10:21:13.931+00
6851	\N	died	2021-11-08 10:20:23.002+00	\N	\N	2021-11-08 10:21:13.777+00	2021-11-08 10:21:14.058+00
6864	\N	died	2021-11-08 10:20:23.529+00	\N	\N	2021-11-08 10:21:14.051+00	2021-11-08 10:21:14.255+00
6871	\N	died	2021-11-08 10:20:23.77+00	\N	\N	2021-11-08 10:21:14.251+00	2021-11-08 10:21:14.371+00
6875	\N	died	2021-11-08 10:20:23.838+00	\N	\N	2021-11-08 10:21:14.32+00	2021-11-08 10:21:14.699+00
6887	\N	died	2021-11-08 10:20:24.078+00	\N	\N	2021-11-08 10:21:14.56+00	2021-11-08 10:21:14.956+00
6899	\N	died	2021-11-08 10:20:24.264+00	\N	\N	2021-11-08 10:21:14.935+00	2021-11-08 10:21:15.09+00
6907	\N	died	2021-11-08 10:20:24.492+00	\N	\N	2021-11-08 10:21:15.068+00	2021-11-08 10:21:15.389+00
6918	\N	died	2021-11-08 10:20:24.703+00	\N	\N	2021-11-08 10:21:15.385+00	2021-11-08 10:21:15.904+00
6924	\N	died	2021-11-08 10:20:24.872+00	\N	\N	2021-11-08 10:21:15.612+00	2021-11-08 10:21:16.4+00
6939	\N	died	2021-11-08 10:20:25.179+00	\N	\N	2021-11-08 10:21:16.394+00	2021-11-08 10:21:16.588+00
6947	\N	died	2021-11-08 10:20:25.403+00	\N	\N	2021-11-08 10:21:16.544+00	2021-11-08 10:21:16.917+00
6960	\N	died	2021-11-08 10:20:25.682+00	\N	\N	2021-11-08 10:21:16.854+00	2021-11-08 10:21:17.227+00
6971	\N	died	2021-11-08 10:20:25.986+00	\N	\N	2021-11-08 10:21:17.212+00	2021-11-08 10:21:17.277+00
6973	\N	died	2021-11-08 10:20:26.047+00	\N	\N	2021-11-08 10:21:17.268+00	2021-11-08 10:21:17.399+00
6977	\N	died	2021-11-08 10:20:26.212+00	\N	\N	2021-11-08 10:21:17.335+00	2021-11-08 10:21:17.903+00
6991	\N	died	2021-11-08 10:20:26.561+00	\N	\N	2021-11-08 10:21:17.851+00	2021-11-08 10:21:18.647+00
7005	\N	died	2021-11-08 10:20:26.937+00	\N	\N	2021-11-08 10:21:18.633+00	2021-11-08 10:21:18.844+00
7010	\N	died	2021-11-08 10:20:27.092+00	\N	\N	2021-11-08 10:21:18.768+00	2021-11-08 10:21:19.057+00
7022	\N	died	2021-11-08 10:20:27.288+00	\N	\N	2021-11-08 10:21:18.985+00	2021-11-08 10:21:19.355+00
7038	\N	died	2021-11-08 10:20:27.663+00	\N	\N	2021-11-08 10:21:19.318+00	2021-11-08 10:21:19.785+00
7062	\N	died	2021-11-08 10:20:28.255+00	\N	\N	2021-11-08 10:21:19.779+00	2021-11-08 10:21:20.055+00
7072	\N	died	2021-11-08 10:20:28.529+00	\N	\N	2021-11-08 10:21:20.051+00	2021-11-08 10:21:20.097+00
7074	\N	died	2021-11-08 10:20:28.579+00	\N	\N	2021-11-08 10:21:20.082+00	2021-11-08 10:21:20.203+00
7076	\N	died	2021-11-08 10:20:28.737+00	\N	\N	2021-11-08 10:21:20.195+00	2021-11-08 10:21:20.301+00
7081	\N	died	2021-11-08 10:20:28.979+00	\N	\N	2021-11-08 10:21:20.295+00	2021-11-08 10:21:20.376+00
7085	\N	died	2021-11-08 10:20:29.128+00	\N	\N	2021-11-08 10:21:20.37+00	2021-11-08 10:21:20.525+00
7089	\N	died	2021-11-08 10:20:29.317+00	\N	\N	2021-11-08 10:21:20.508+00	2021-11-08 10:21:20.597+00
7095	\N	died	2021-11-08 10:20:29.626+00	\N	\N	2021-11-08 10:21:20.594+00	2021-11-08 10:21:20.632+00
7098	\N	died	2021-11-08 10:20:30.234+00	\N	\N	2021-11-08 10:21:20.628+00	2021-11-08 10:21:20.734+00
7102	\N	died	2021-11-08 10:20:30.621+00	\N	\N	2021-11-08 10:21:20.72+00	2021-11-08 10:21:20.788+00
7104	\N	died	2021-11-08 10:20:30.711+00	\N	\N	2021-11-08 10:21:20.781+00	2021-11-08 10:21:20.93+00
7111	\N	died	2021-11-08 10:20:30.879+00	\N	\N	2021-11-08 10:21:20.921+00	2021-11-08 10:21:21.122+00
7117	\N	died	2021-11-08 10:20:30.924+00	\N	\N	2021-11-08 10:21:21.118+00	2021-11-08 10:21:21.175+00
7119	\N	died	2021-11-08 10:20:30.938+00	\N	\N	2021-11-08 10:21:21.156+00	2021-11-08 10:21:21.252+00
7123	\N	died	2021-11-08 10:20:30.98+00	\N	\N	2021-11-08 10:21:21.246+00	2021-11-08 10:21:21.365+00
7127	\N	died	2021-11-08 10:20:30.99+00	\N	\N	2021-11-08 10:21:21.361+00	2021-11-08 10:21:21.459+00
7131	\N	died	2021-11-08 10:20:31.001+00	\N	\N	2021-11-08 10:21:21.448+00	2021-11-08 10:21:21.708+00
7140	\N	died	2021-11-08 10:20:31.033+00	\N	\N	2021-11-08 10:21:21.702+00	2021-11-08 10:21:21.765+00
6837	\N	died	2021-11-08 10:20:22.606+00	\N	\N	2021-11-08 10:21:13.427+00	2021-11-08 10:21:13.497+00
6830	\N	died	2021-11-08 10:20:22.444+00	\N	\N	2021-11-08 10:21:13.197+00	2021-11-08 10:21:13.497+00
6839	\N	died	2021-11-08 10:20:22.664+00	\N	\N	2021-11-08 10:21:13.485+00	2021-11-08 10:21:13.566+00
6843	\N	died	2021-11-08 10:20:22.745+00	\N	\N	2021-11-08 10:21:13.561+00	2021-11-08 10:21:13.693+00
6846	\N	died	2021-11-08 10:20:22.904+00	\N	\N	2021-11-08 10:21:13.685+00	2021-11-08 10:21:13.931+00
6855	\N	died	2021-11-08 10:20:23.181+00	\N	\N	2021-11-08 10:21:13.901+00	2021-11-08 10:21:14.371+00
6874	\N	died	2021-11-08 10:20:23.82+00	\N	\N	2021-11-08 10:21:14.301+00	2021-11-08 10:21:14.537+00
6885	\N	died	2021-11-08 10:20:24.045+00	\N	\N	2021-11-08 10:21:14.529+00	2021-11-08 10:21:14.856+00
6894	\N	died	2021-11-08 10:20:24.164+00	\N	\N	2021-11-08 10:21:14.743+00	2021-11-08 10:21:15.042+00
6904	\N	died	2021-11-08 10:20:24.353+00	\N	\N	2021-11-08 10:21:15.018+00	2021-11-08 10:21:15.414+00
6920	\N	died	2021-11-08 10:20:24.737+00	\N	\N	2021-11-08 10:21:15.41+00	2021-11-08 10:21:15.904+00
6926	\N	died	2021-11-08 10:20:24.926+00	\N	\N	2021-11-08 10:21:15.836+00	2021-11-08 10:21:16.432+00
6941	\N	died	2021-11-08 10:20:25.22+00	\N	\N	2021-11-08 10:21:16.428+00	2021-11-08 10:21:16.588+00
6950	\N	died	2021-11-08 10:20:25.454+00	\N	\N	2021-11-08 10:21:16.568+00	2021-11-08 10:21:17.19+00
6968	\N	died	2021-11-08 10:20:25.926+00	\N	\N	2021-11-08 10:21:17.136+00	2021-11-08 10:21:17.72+00
6987	\N	died	2021-11-08 10:20:26.487+00	\N	\N	2021-11-08 10:21:17.703+00	2021-11-08 10:21:18.176+00
6997	\N	died	2021-11-08 10:20:26.734+00	\N	\N	2021-11-08 10:21:18.066+00	2021-11-08 10:21:18.858+00
7015	\N	died	2021-11-08 10:20:27.169+00	\N	\N	2021-11-08 10:21:18.852+00	2021-11-08 10:21:19.057+00
7021	\N	died	2021-11-08 10:20:27.287+00	\N	\N	2021-11-08 10:21:18.968+00	2021-11-08 10:21:19.294+00
7036	\N	died	2021-11-08 10:20:27.63+00	\N	\N	2021-11-08 10:21:19.285+00	2021-11-08 10:21:19.496+00
7046	\N	died	2021-11-08 10:20:27.914+00	\N	\N	2021-11-08 10:21:19.461+00	2021-11-08 10:21:19.745+00
7060	\N	died	2021-11-08 10:20:28.221+00	\N	\N	2021-11-08 10:21:19.735+00	2021-11-08 10:21:20.055+00
7070	\N	died	2021-11-08 10:20:28.44+00	\N	\N	2021-11-08 10:21:20.011+00	2021-11-08 10:21:20.525+00
7088	\N	died	2021-11-08 10:20:29.236+00	\N	\N	2021-11-08 10:21:20.486+00	2021-11-08 10:21:20.93+00
7107	\N	died	2021-11-08 10:20:30.767+00	\N	\N	2021-11-08 10:21:20.827+00	2021-11-08 10:21:21.139+00
7118	\N	died	2021-11-08 10:20:30.932+00	\N	\N	2021-11-08 10:21:21.135+00	2021-11-08 10:21:21.252+00
7121	\N	died	2021-11-08 10:20:30.964+00	\N	\N	2021-11-08 10:21:21.202+00	2021-11-08 10:21:21.708+00
7135	\N	died	2021-11-08 10:20:31.014+00	\N	\N	2021-11-08 10:21:21.601+00	2021-11-08 10:21:21.997+00
7152	\N	died	2021-11-08 10:20:31.047+00	\N	\N	2021-11-08 10:21:21.993+00	2021-11-08 10:21:22.266+00
7162	\N	died	2021-11-08 10:20:31.059+00	\N	\N	2021-11-08 10:21:22.261+00	2021-11-08 10:21:22.299+00
7164	\N	died	2021-11-08 10:20:31.061+00	\N	\N	2021-11-08 10:21:22.296+00	2021-11-08 10:21:22.428+00
7167	\N	died	2021-11-08 10:20:31.065+00	\N	\N	2021-11-08 10:21:22.42+00	2021-11-08 10:21:22.495+00
7171	5	died	2021-11-08 10:20:31.068+00	\N	\N	2021-11-08 10:21:22.486+00	2021-11-08 10:21:22.643+00
6833	\N	died	2021-11-08 10:20:22.478+00	\N	\N	2021-11-08 10:21:13.342+00	2021-11-08 10:21:13.566+00
6841	\N	died	2021-11-08 10:20:22.695+00	\N	\N	2021-11-08 10:21:13.526+00	2021-11-08 10:21:13.931+00
6856	\N	died	2021-11-08 10:20:23.208+00	\N	\N	2021-11-08 10:21:13.917+00	2021-11-08 10:21:14.371+00
6876	\N	died	2021-11-08 10:20:23.871+00	\N	\N	2021-11-08 10:21:14.334+00	2021-11-08 10:21:14.699+00
6889	\N	died	2021-11-08 10:20:24.096+00	\N	\N	2021-11-08 10:21:14.668+00	2021-11-08 10:21:15.057+00
6906	\N	died	2021-11-08 10:20:24.412+00	\N	\N	2021-11-08 10:21:15.052+00	2021-11-08 10:21:15.34+00
6912	\N	died	2021-11-08 10:20:24.614+00	\N	\N	2021-11-08 10:21:15.263+00	2021-11-08 10:21:15.904+00
6927	\N	died	2021-11-08 10:20:24.953+00	\N	\N	2021-11-08 10:21:15.854+00	2021-11-08 10:21:16.52+00
6943	\N	died	2021-11-08 10:20:25.253+00	\N	\N	2021-11-08 10:21:16.46+00	2021-11-08 10:21:16.72+00
6956	\N	died	2021-11-08 10:20:25.615+00	\N	\N	2021-11-08 10:21:16.703+00	2021-11-08 10:21:17.19+00
6963	\N	died	2021-11-08 10:20:25.737+00	\N	\N	2021-11-08 10:21:16.946+00	2021-11-08 10:21:17.399+00
6978	\N	died	2021-11-08 10:20:26.23+00	\N	\N	2021-11-08 10:21:17.352+00	2021-11-08 10:21:18.176+00
6995	\N	died	2021-11-08 10:20:26.695+00	\N	\N	2021-11-08 10:21:17.995+00	2021-11-08 10:21:18.844+00
7009	\N	died	2021-11-08 10:20:27.021+00	\N	\N	2021-11-08 10:21:18.752+00	2021-11-08 10:21:19.057+00
7019	\N	died	2021-11-08 10:20:27.254+00	\N	\N	2021-11-08 10:21:18.92+00	2021-11-08 10:21:19.209+00
7032	\N	died	2021-11-08 10:20:27.579+00	\N	\N	2021-11-08 10:21:19.202+00	2021-11-08 10:21:19.355+00
7039	\N	died	2021-11-08 10:20:27.697+00	\N	\N	2021-11-08 10:21:19.338+00	2021-11-08 10:21:20.055+00
7064	\N	died	2021-11-08 10:20:28.295+00	\N	\N	2021-11-08 10:21:19.862+00	2021-11-08 10:21:20.181+00
7075	\N	died	2021-11-08 10:20:28.722+00	\N	\N	2021-11-08 10:21:20.166+00	2021-11-08 10:21:20.301+00
7079	\N	died	2021-11-08 10:20:28.854+00	\N	\N	2021-11-08 10:21:20.252+00	2021-11-08 10:21:20.597+00
7092	\N	died	2021-11-08 10:20:29.421+00	\N	\N	2021-11-08 10:21:20.56+00	2021-11-08 10:21:20.93+00
7109	\N	died	2021-11-08 10:20:30.866+00	\N	\N	2021-11-08 10:21:20.868+00	2021-11-08 10:21:21.382+00
7128	\N	died	2021-11-08 10:20:30.994+00	\N	\N	2021-11-08 10:21:21.378+00	2021-11-08 10:21:21.708+00
7133	\N	died	2021-11-08 10:20:31.008+00	\N	\N	2021-11-08 10:21:21.498+00	2021-11-08 10:21:21.932+00
7148	\N	died	2021-11-08 10:20:31.042+00	\N	\N	2021-11-08 10:21:21.92+00	2021-11-08 10:21:22.266+00
7155	\N	died	2021-11-08 10:20:31.052+00	\N	\N	2021-11-08 10:21:22.079+00	2021-11-08 10:21:22.445+00
7168	5	died	2021-11-08 10:20:31.065+00	\N	\N	2021-11-08 10:21:22.436+00	2021-11-08 10:21:22.546+00
6826	\N	died	2021-11-08 10:20:22.412+00	\N	\N	2021-11-08 10:21:13.101+00	2021-11-08 10:21:13.566+00
6842	\N	died	2021-11-08 10:20:22.72+00	\N	\N	2021-11-08 10:21:13.544+00	2021-11-08 10:21:13.931+00
6854	\N	died	2021-11-08 10:20:23.145+00	\N	\N	2021-11-08 10:21:13.835+00	2021-11-08 10:21:14.255+00
6870	\N	died	2021-11-08 10:20:23.712+00	\N	\N	2021-11-08 10:21:14.237+00	2021-11-08 10:21:14.699+00
6890	\N	died	2021-11-08 10:20:24.111+00	\N	\N	2021-11-08 10:21:14.684+00	2021-11-08 10:21:15.34+00
6911	\N	died	2021-11-08 10:20:24.597+00	\N	\N	2021-11-08 10:21:15.23+00	2021-11-08 10:21:15.904+00
6925	\N	died	2021-11-08 10:20:24.898+00	\N	\N	2021-11-08 10:21:15.749+00	2021-11-08 10:21:16.588+00
6948	\N	died	2021-11-08 10:20:25.42+00	\N	\N	2021-11-08 10:21:16.551+00	2021-11-08 10:21:17.19+00
6964	\N	died	2021-11-08 10:20:25.753+00	\N	\N	2021-11-08 10:21:16.969+00	2021-11-08 10:21:17.399+00
6976	\N	died	2021-11-08 10:20:26.154+00	\N	\N	2021-11-08 10:21:17.318+00	2021-11-08 10:21:17.69+00
6984	\N	died	2021-11-08 10:20:26.41+00	\N	\N	2021-11-08 10:21:17.603+00	2021-11-08 10:21:18.176+00
6994	\N	died	2021-11-08 10:20:26.629+00	\N	\N	2021-11-08 10:21:17.968+00	2021-11-08 10:21:18.241+00
7003	\N	died	2021-11-08 10:20:26.904+00	\N	\N	2021-11-08 10:21:18.235+00	2021-11-08 10:21:18.697+00
7006	\N	died	2021-11-08 10:20:26.953+00	\N	\N	2021-11-08 10:21:18.685+00	2021-11-08 10:21:18.844+00
7012	\N	died	2021-11-08 10:20:27.136+00	\N	\N	2021-11-08 10:21:18.802+00	2021-11-08 10:21:19.192+00
7028	\N	died	2021-11-08 10:20:27.455+00	\N	\N	2021-11-08 10:21:19.126+00	2021-11-08 10:21:19.355+00
7037	\N	died	2021-11-08 10:20:27.644+00	\N	\N	2021-11-08 10:21:19.303+00	2021-11-08 10:21:19.519+00
7048	\N	died	2021-11-08 10:20:27.954+00	\N	\N	2021-11-08 10:21:19.511+00	2021-11-08 10:21:19.577+00
7051	\N	died	2021-11-08 10:20:28.013+00	\N	\N	2021-11-08 10:21:19.569+00	2021-11-08 10:21:19.641+00
7055	\N	died	2021-11-08 10:20:28.102+00	\N	\N	2021-11-08 10:21:19.635+00	2021-11-08 10:21:19.769+00
7061	\N	died	2021-11-08 10:20:28.239+00	\N	\N	2021-11-08 10:21:19.754+00	2021-11-08 10:21:20.055+00
7071	\N	died	2021-11-08 10:20:28.512+00	\N	\N	2021-11-08 10:21:20.035+00	2021-11-08 10:21:20.525+00
7090	\N	died	2021-11-08 10:20:29.321+00	\N	\N	2021-11-08 10:21:20.528+00	2021-11-08 10:21:20.632+00
7097	\N	died	2021-11-08 10:20:29.837+00	\N	\N	2021-11-08 10:21:20.611+00	2021-11-08 10:21:20.798+00
7105	\N	died	2021-11-08 10:20:30.718+00	\N	\N	2021-11-08 10:21:20.794+00	2021-11-08 10:21:21.122+00
7115	\N	died	2021-11-08 10:20:30.903+00	\N	\N	2021-11-08 10:21:21.079+00	2021-11-08 10:21:21.481+00
7132	\N	died	2021-11-08 10:20:31.005+00	\N	\N	2021-11-08 10:21:21.47+00	2021-11-08 10:21:21.765+00
7142	\N	died	2021-11-08 10:20:31.035+00	\N	\N	2021-11-08 10:21:21.745+00	2021-11-08 10:21:21.883+00
7146	\N	died	2021-11-08 10:20:31.04+00	\N	\N	2021-11-08 10:21:21.868+00	2021-11-08 10:21:21.983+00
7151	\N	died	2021-11-08 10:20:31.047+00	\N	\N	2021-11-08 10:21:21.978+00	2021-11-08 10:21:22.266+00
7161	5	died	2021-11-08 10:20:31.059+00	\N	\N	2021-11-08 10:21:22.234+00	2021-11-08 10:21:22.695+00
6825	\N	died	2021-11-08 10:20:22.389+00	\N	\N	2021-11-08 10:21:13.075+00	2021-11-08 10:21:13.646+00
6844	\N	died	2021-11-08 10:20:22.764+00	\N	\N	2021-11-08 10:21:13.632+00	2021-11-08 10:21:13.931+00
6849	\N	died	2021-11-08 10:20:22.97+00	\N	\N	2021-11-08 10:21:13.734+00	2021-11-08 10:21:14.255+00
6866	\N	died	2021-11-08 10:20:23.561+00	\N	\N	2021-11-08 10:21:14.145+00	2021-11-08 10:21:14.371+00
6877	\N	died	2021-11-08 10:20:23.888+00	\N	\N	2021-11-08 10:21:14.351+00	2021-11-08 10:21:14.715+00
6892	\N	died	2021-11-08 10:20:24.146+00	\N	\N	2021-11-08 10:21:14.71+00	2021-11-08 10:21:14.877+00
6898	\N	died	2021-11-08 10:20:24.259+00	\N	\N	2021-11-08 10:21:14.87+00	2021-11-08 10:21:15.042+00
6903	\N	died	2021-11-08 10:20:24.337+00	\N	\N	2021-11-08 10:21:15.002+00	2021-11-08 10:21:15.355+00
6916	\N	died	2021-11-08 10:20:24.688+00	\N	\N	2021-11-08 10:21:15.351+00	2021-11-08 10:21:15.414+00
6919	\N	died	2021-11-08 10:20:24.72+00	\N	\N	2021-11-08 10:21:15.395+00	2021-11-08 10:21:16.253+00
6930	\N	died	2021-11-08 10:20:24.995+00	\N	\N	2021-11-08 10:21:16.07+00	2021-11-08 10:21:16.366+00
6937	\N	died	2021-11-08 10:20:25.145+00	\N	\N	2021-11-08 10:21:16.361+00	2021-11-08 10:21:16.52+00
6942	\N	died	2021-11-08 10:20:25.236+00	\N	\N	2021-11-08 10:21:16.445+00	2021-11-08 10:21:16.827+00
6958	\N	died	2021-11-08 10:20:25.664+00	\N	\N	2021-11-08 10:21:16.82+00	2021-11-08 10:21:17.19+00
6967	\N	died	2021-11-08 10:20:25.904+00	\N	\N	2021-11-08 10:21:17.111+00	2021-11-08 10:21:17.69+00
6985	\N	died	2021-11-08 10:20:26.416+00	\N	\N	2021-11-08 10:21:17.642+00	2021-11-08 10:21:18.176+00
6996	\N	died	2021-11-08 10:20:26.712+00	\N	\N	2021-11-08 10:21:18.033+00	2021-11-08 10:21:18.844+00
7013	\N	died	2021-11-08 10:20:27.138+00	\N	\N	2021-11-08 10:21:18.818+00	2021-11-08 10:21:19.192+00
7030	\N	died	2021-11-08 10:20:27.547+00	\N	\N	2021-11-08 10:21:19.154+00	2021-11-08 10:21:19.496+00
7045	\N	died	2021-11-08 10:20:27.892+00	\N	\N	2021-11-08 10:21:19.443+00	2021-11-08 10:21:19.691+00
7058	\N	died	2021-11-08 10:20:28.18+00	\N	\N	2021-11-08 10:21:19.685+00	2021-11-08 10:21:20.055+00
7068	\N	died	2021-11-08 10:20:28.371+00	\N	\N	2021-11-08 10:21:19.954+00	2021-11-08 10:21:20.376+00
7084	\N	died	2021-11-08 10:20:29.121+00	\N	\N	2021-11-08 10:21:20.352+00	2021-11-08 10:21:20.734+00
7101	\N	died	2021-11-08 10:20:30.579+00	\N	\N	2021-11-08 10:21:20.66+00	2021-11-08 10:21:21.122+00
7113	\N	died	2021-11-08 10:20:30.892+00	\N	\N	2021-11-08 10:21:21.012+00	2021-11-08 10:21:21.317+00
7124	\N	died	2021-11-08 10:20:30.982+00	\N	\N	2021-11-08 10:21:21.31+00	2021-11-08 10:21:21.417+00
7129	\N	died	2021-11-08 10:20:30.997+00	\N	\N	2021-11-08 10:21:21.4+00	2021-11-08 10:21:21.708+00
7136	\N	died	2021-11-08 10:20:31.016+00	\N	\N	2021-11-08 10:21:21.634+00	2021-11-08 10:21:22.266+00
7154	\N	died	2021-11-08 10:20:31.049+00	\N	\N	2021-11-08 10:21:22.01+00	2021-11-08 10:21:22.428+00
7166	\N	died	2021-11-08 10:20:31.063+00	\N	\N	2021-11-08 10:21:22.403+00	2021-11-08 10:21:22.539+00
7173	5	died	2021-11-08 10:20:31.072+00	\N	\N	2021-11-08 10:21:22.531+00	2021-11-08 10:21:22.718+00
6834	\N	died	2021-11-08 10:20:22.55+00	\N	\N	2021-11-08 10:21:13.368+00	2021-11-08 10:21:13.722+00
6848	\N	died	2021-11-08 10:20:22.952+00	\N	\N	2021-11-08 10:21:13.718+00	2021-11-08 10:21:13.964+00
6858	\N	died	2021-11-08 10:20:23.245+00	\N	\N	2021-11-08 10:21:13.943+00	2021-11-08 10:21:14.022+00
6862	\N	died	2021-11-08 10:20:23.496+00	\N	\N	2021-11-08 10:21:14.003+00	2021-11-08 10:21:14.255+00
6867	\N	died	2021-11-08 10:20:23.583+00	\N	\N	2021-11-08 10:21:14.18+00	2021-11-08 10:21:14.388+00
6879	\N	died	2021-11-08 10:20:23.942+00	\N	\N	2021-11-08 10:21:14.385+00	2021-11-08 10:21:14.512+00
6882	\N	died	2021-11-08 10:20:23.994+00	\N	\N	2021-11-08 10:21:14.428+00	2021-11-08 10:21:14.856+00
6893	\N	died	2021-11-08 10:20:24.162+00	\N	\N	2021-11-08 10:21:14.726+00	2021-11-08 10:21:15.042+00
6901	\N	died	2021-11-08 10:20:24.303+00	\N	\N	2021-11-08 10:21:14.968+00	2021-11-08 10:21:15.34+00
6910	\N	died	2021-11-08 10:20:24.579+00	\N	\N	2021-11-08 10:21:15.179+00	2021-11-08 10:21:15.904+00
6923	\N	died	2021-11-08 10:20:24.843+00	\N	\N	2021-11-08 10:21:15.553+00	2021-11-08 10:21:16.351+00
6935	\N	died	2021-11-08 10:20:25.112+00	\N	\N	2021-11-08 10:21:16.327+00	2021-11-08 10:21:16.588+00
6949	\N	died	2021-11-08 10:20:25.436+00	\N	\N	2021-11-08 10:21:16.56+00	2021-11-08 10:21:17.19+00
6966	\N	died	2021-11-08 10:20:25.887+00	\N	\N	2021-11-08 10:21:17.079+00	2021-11-08 10:21:17.591+00
6983	\N	died	2021-11-08 10:20:26.338+00	\N	\N	2021-11-08 10:21:17.575+00	2021-11-08 10:21:17.903+00
6990	\N	died	2021-11-08 10:20:26.546+00	\N	\N	2021-11-08 10:21:17.812+00	2021-11-08 10:21:18.224+00
7001	\N	died	2021-11-08 10:20:26.821+00	\N	\N	2021-11-08 10:21:18.194+00	2021-11-08 10:21:18.743+00
7007	\N	died	2021-11-08 10:20:26.97+00	\N	\N	2021-11-08 10:21:18.71+00	2021-11-08 10:21:18.892+00
7016	\N	died	2021-11-08 10:20:27.186+00	\N	\N	2021-11-08 10:21:18.868+00	2021-11-08 10:21:19.076+00
7024	\N	died	2021-11-08 10:20:27.392+00	\N	\N	2021-11-08 10:21:19.068+00	2021-11-08 10:21:19.192+00
7029	\N	died	2021-11-08 10:20:27.52+00	\N	\N	2021-11-08 10:21:19.136+00	2021-11-08 10:21:19.496+00
7043	\N	died	2021-11-08 10:20:27.856+00	\N	\N	2021-11-08 10:21:19.399+00	2021-11-08 10:21:19.641+00
7054	\N	died	2021-11-08 10:20:28.08+00	\N	\N	2021-11-08 10:21:19.618+00	2021-11-08 10:21:20.055+00
7066	\N	died	2021-11-08 10:20:28.339+00	\N	\N	2021-11-08 10:21:19.918+00	2021-11-08 10:21:20.301+00
7080	\N	died	2021-11-08 10:20:28.934+00	\N	\N	2021-11-08 10:21:20.278+00	2021-11-08 10:21:20.605+00
7096	\N	died	2021-11-08 10:20:29.717+00	\N	\N	2021-11-08 10:21:20.601+00	2021-11-08 10:21:20.734+00
7100	\N	died	2021-11-08 10:20:30.544+00	\N	\N	2021-11-08 10:21:20.643+00	2021-11-08 10:21:20.93+00
7110	\N	died	2021-11-08 10:20:30.872+00	\N	\N	2021-11-08 10:21:20.899+00	2021-11-08 10:21:21.434+00
7130	\N	died	2021-11-08 10:20:30.999+00	\N	\N	2021-11-08 10:21:21.429+00	2021-11-08 10:21:21.708+00
7138	\N	died	2021-11-08 10:20:31.03+00	\N	\N	2021-11-08 10:21:21.669+00	2021-11-08 10:21:22.266+00
7158	\N	died	2021-11-08 10:20:31.054+00	\N	\N	2021-11-08 10:21:22.152+00	2021-11-08 10:21:22.556+00
7174	5	died	2021-11-08 10:20:31.074+00	\N	\N	2021-11-08 10:21:22.546+00	2021-11-08 10:21:22.754+00
6857	\N	died	2021-11-08 10:20:23.228+00	\N	\N	2021-11-08 10:21:13.927+00	2021-11-08 10:21:13.964+00
6859	\N	died	2021-11-08 10:20:23.268+00	\N	\N	2021-11-08 10:21:13.961+00	2021-11-08 10:21:13.987+00
6861	\N	died	2021-11-08 10:20:23.462+00	\N	\N	2021-11-08 10:21:13.984+00	2021-11-08 10:21:14.042+00
6863	\N	died	2021-11-08 10:20:23.513+00	\N	\N	2021-11-08 10:21:14.035+00	2021-11-08 10:21:14.255+00
6869	\N	died	2021-11-08 10:20:23.654+00	\N	\N	2021-11-08 10:21:14.218+00	2021-11-08 10:21:14.699+00
6888	\N	died	2021-11-08 10:20:24.08+00	\N	\N	2021-11-08 10:21:14.654+00	2021-11-08 10:21:15.042+00
6902	\N	died	2021-11-08 10:20:24.32+00	\N	\N	2021-11-08 10:21:14.985+00	2021-11-08 10:21:15.34+00
6914	\N	died	2021-11-08 10:20:24.648+00	\N	\N	2021-11-08 10:21:15.322+00	2021-11-08 10:21:16.253+00
6931	\N	died	2021-11-08 10:20:25.017+00	\N	\N	2021-11-08 10:21:16.204+00	2021-11-08 10:21:16.588+00
6946	\N	died	2021-11-08 10:20:25.37+00	\N	\N	2021-11-08 10:21:16.528+00	2021-11-08 10:21:16.669+00
6954	\N	died	2021-11-08 10:20:25.504+00	\N	\N	2021-11-08 10:21:16.661+00	2021-11-08 10:21:16.84+00
6959	\N	died	2021-11-08 10:20:25.68+00	\N	\N	2021-11-08 10:21:16.835+00	2021-11-08 10:21:17.19+00
6969	\N	died	2021-11-08 10:20:25.954+00	\N	\N	2021-11-08 10:21:17.151+00	2021-11-08 10:21:17.79+00
6989	\N	died	2021-11-08 10:20:26.53+00	\N	\N	2021-11-08 10:21:17.772+00	2021-11-08 10:21:18.176+00
6999	\N	died	2021-11-08 10:20:26.779+00	\N	\N	2021-11-08 10:21:18.132+00	2021-11-08 10:21:19.057+00
7020	\N	died	2021-11-08 10:20:27.27+00	\N	\N	2021-11-08 10:21:18.953+00	2021-11-08 10:21:19.273+00
7034	\N	died	2021-11-08 10:20:27.611+00	\N	\N	2021-11-08 10:21:19.235+00	2021-11-08 10:21:19.496+00
7044	\N	died	2021-11-08 10:20:27.872+00	\N	\N	2021-11-08 10:21:19.428+00	2021-11-08 10:21:19.66+00
7056	\N	died	2021-11-08 10:20:28.129+00	\N	\N	2021-11-08 10:21:19.652+00	2021-11-08 10:21:20.055+00
7065	\N	died	2021-11-08 10:20:28.317+00	\N	\N	2021-11-08 10:21:19.895+00	2021-11-08 10:21:20.301+00
7078	\N	died	2021-11-08 10:20:28.837+00	\N	\N	2021-11-08 10:21:20.236+00	2021-11-08 10:21:20.525+00
7087	\N	died	2021-11-08 10:20:29.23+00	\N	\N	2021-11-08 10:21:20.469+00	2021-11-08 10:21:20.734+00
7099	\N	died	2021-11-08 10:20:30.538+00	\N	\N	2021-11-08 10:21:20.635+00	2021-11-08 10:21:20.93+00
7108	\N	died	2021-11-08 10:20:30.86+00	\N	\N	2021-11-08 10:21:20.845+00	2021-11-08 10:21:21.193+00
7120	\N	died	2021-11-08 10:20:30.944+00	\N	\N	2021-11-08 10:21:21.186+00	2021-11-08 10:21:21.365+00
7125	\N	died	2021-11-08 10:20:30.985+00	\N	\N	2021-11-08 10:21:21.327+00	2021-11-08 10:21:21.708+00
7139	\N	died	2021-11-08 10:20:31.031+00	\N	\N	2021-11-08 10:21:21.685+00	2021-11-08 10:21:22.266+00
7160	5	died	2021-11-08 10:20:31.057+00	\N	\N	2021-11-08 10:21:22.199+00	2021-11-08 10:21:22.674+00
6850	\N	died	2021-11-08 10:20:22.985+00	\N	\N	2021-11-08 10:21:13.752+00	2021-11-08 10:21:13.987+00
6860	\N	died	2021-11-08 10:20:23.345+00	\N	\N	2021-11-08 10:21:13.976+00	2021-11-08 10:21:14.075+00
6865	\N	died	2021-11-08 10:20:23.544+00	\N	\N	2021-11-08 10:21:14.068+00	2021-11-08 10:21:14.371+00
6873	\N	died	2021-11-08 10:20:23.804+00	\N	\N	2021-11-08 10:21:14.285+00	2021-11-08 10:21:14.416+00
6881	\N	died	2021-11-08 10:20:23.978+00	\N	\N	2021-11-08 10:21:14.412+00	2021-11-08 10:21:14.551+00
6886	\N	died	2021-11-08 10:20:24.062+00	\N	\N	2021-11-08 10:21:14.546+00	2021-11-08 10:21:14.856+00
6896	\N	died	2021-11-08 10:20:24.203+00	\N	\N	2021-11-08 10:21:14.808+00	2021-11-08 10:21:15.34+00
6913	\N	died	2021-11-08 10:20:24.63+00	\N	\N	2021-11-08 10:21:15.305+00	2021-11-08 10:21:16.016+00
6929	\N	died	2021-11-08 10:20:24.974+00	\N	\N	2021-11-08 10:21:16+00	2021-11-08 10:21:16.351+00
6934	\N	died	2021-11-08 10:20:25.095+00	\N	\N	2021-11-08 10:21:16.305+00	2021-11-08 10:21:16.52+00
6944	\N	died	2021-11-08 10:20:25.319+00	\N	\N	2021-11-08 10:21:16.484+00	2021-11-08 10:21:17.19+00
6962	\N	died	2021-11-08 10:20:25.72+00	\N	\N	2021-11-08 10:21:16.927+00	2021-11-08 10:21:17.309+00
6974	\N	died	2021-11-08 10:20:26.062+00	\N	\N	2021-11-08 10:21:17.288+00	2021-11-08 10:21:17.555+00
6981	\N	died	2021-11-08 10:20:26.298+00	\N	\N	2021-11-08 10:21:17.503+00	2021-11-08 10:21:18.176+00
6993	\N	died	2021-11-08 10:20:26.605+00	\N	\N	2021-11-08 10:21:17.929+00	2021-11-08 10:21:18.844+00
7011	\N	died	2021-11-08 10:20:27.121+00	\N	\N	2021-11-08 10:21:18.785+00	2021-11-08 10:21:19.106+00
7026	\N	died	2021-11-08 10:20:27.429+00	\N	\N	2021-11-08 10:21:19.101+00	2021-11-08 10:21:19.273+00
7033	\N	died	2021-11-08 10:20:27.595+00	\N	\N	2021-11-08 10:21:19.218+00	2021-11-08 10:21:19.496+00
7042	\N	died	2021-11-08 10:20:27.821+00	\N	\N	2021-11-08 10:21:19.376+00	2021-11-08 10:21:19.593+00
7052	\N	died	2021-11-08 10:20:28.029+00	\N	\N	2021-11-08 10:21:19.586+00	2021-11-08 10:21:19.721+00
7059	\N	died	2021-11-08 10:20:28.204+00	\N	\N	2021-11-08 10:21:19.704+00	2021-11-08 10:21:20.055+00
7069	\N	died	2021-11-08 10:20:28.41+00	\N	\N	2021-11-08 10:21:19.985+00	2021-11-08 10:21:20.457+00
7086	\N	died	2021-11-08 10:20:29.133+00	\N	\N	2021-11-08 10:21:20.439+00	2021-11-08 10:21:20.597+00
7093	\N	died	2021-11-08 10:20:29.454+00	\N	\N	2021-11-08 10:21:20.569+00	2021-11-08 10:21:21.122+00
7112	\N	died	2021-11-08 10:20:30.885+00	\N	\N	2021-11-08 10:21:20.936+00	2021-11-08 10:21:21.252+00
7122	\N	died	2021-11-08 10:20:30.966+00	\N	\N	2021-11-08 10:21:21.23+00	2021-11-08 10:21:21.708+00
7137	\N	died	2021-11-08 10:20:31.028+00	\N	\N	2021-11-08 10:21:21.652+00	2021-11-08 10:21:22.266+00
7156	\N	died	2021-11-08 10:20:31.052+00	\N	\N	2021-11-08 10:21:22.111+00	2021-11-08 10:21:22.495+00
7170	5	died	2021-11-08 10:20:31.066+00	\N	\N	2021-11-08 10:21:22.47+00	2021-11-08 10:21:22.741+00
6852	\N	died	2021-11-08 10:20:23.019+00	\N	\N	2021-11-08 10:21:13.801+00	2021-11-08 10:21:14.255+00
6868	\N	died	2021-11-08 10:20:23.623+00	\N	\N	2021-11-08 10:21:14.202+00	2021-11-08 10:21:14.512+00
6883	\N	died	2021-11-08 10:20:24.011+00	\N	\N	2021-11-08 10:21:14.451+00	2021-11-08 10:21:14.856+00
6895	\N	died	2021-11-08 10:20:24.179+00	\N	\N	2021-11-08 10:21:14.761+00	2021-11-08 10:21:15.34+00
6909	\N	died	2021-11-08 10:20:24.554+00	\N	\N	2021-11-08 10:21:15.101+00	2021-11-08 10:21:15.539+00
6921	\N	died	2021-11-08 10:20:24.738+00	\N	\N	2021-11-08 10:21:15.479+00	2021-11-08 10:21:16.351+00
6933	\N	died	2021-11-08 10:20:25.079+00	\N	\N	2021-11-08 10:21:16.27+00	2021-11-08 10:21:16.432+00
6940	\N	died	2021-11-08 10:20:25.203+00	\N	\N	2021-11-08 10:21:16.41+00	2021-11-08 10:21:16.645+00
6952	\N	died	2021-11-08 10:20:25.471+00	\N	\N	2021-11-08 10:21:16.605+00	2021-11-08 10:21:16.807+00
6957	\N	died	2021-11-08 10:20:25.646+00	\N	\N	2021-11-08 10:21:16.792+00	2021-11-08 10:21:17.19+00
6965	\N	died	2021-11-08 10:20:25.859+00	\N	\N	2021-11-08 10:21:17.045+00	2021-11-08 10:21:17.555+00
6980	\N	died	2021-11-08 10:20:26.271+00	\N	\N	2021-11-08 10:21:17.422+00	2021-11-08 10:21:17.757+00
6988	\N	died	2021-11-08 10:20:26.512+00	\N	\N	2021-11-08 10:21:17.743+00	2021-11-08 10:21:18.176+00
6998	\N	died	2021-11-08 10:20:26.755+00	\N	\N	2021-11-08 10:21:18.096+00	2021-11-08 10:21:19.057+00
7018	\N	died	2021-11-08 10:20:27.237+00	\N	\N	2021-11-08 10:21:18.903+00	2021-11-08 10:21:19.192+00
7027	\N	died	2021-11-08 10:20:27.43+00	\N	\N	2021-11-08 10:21:19.118+00	2021-11-08 10:21:19.496+00
7041	\N	died	2021-11-08 10:20:27.738+00	\N	\N	2021-11-08 10:21:19.36+00	2021-11-08 10:21:19.577+00
7050	\N	died	2021-11-08 10:20:27.997+00	\N	\N	2021-11-08 10:21:19.554+00	2021-11-08 10:21:19.674+00
7057	\N	died	2021-11-08 10:20:28.151+00	\N	\N	2021-11-08 10:21:19.668+00	2021-11-08 10:21:20.055+00
7067	\N	died	2021-11-08 10:20:28.355+00	\N	\N	2021-11-08 10:21:19.935+00	2021-11-08 10:21:20.376+00
7082	\N	died	2021-11-08 10:20:28.996+00	\N	\N	2021-11-08 10:21:20.312+00	2021-11-08 10:21:20.597+00
7091	\N	died	2021-11-08 10:20:29.388+00	\N	\N	2021-11-08 10:21:20.545+00	2021-11-08 10:21:20.768+00
7103	\N	died	2021-11-08 10:20:30.664+00	\N	\N	2021-11-08 10:21:20.755+00	2021-11-08 10:21:20.816+00
7106	\N	died	2021-11-08 10:20:30.762+00	\N	\N	2021-11-08 10:21:20.81+00	2021-11-08 10:21:21.122+00
7116	\N	died	2021-11-08 10:20:30.915+00	\N	\N	2021-11-08 10:21:21.102+00	2021-11-08 10:21:21.708+00
7134	\N	died	2021-11-08 10:20:31.011+00	\N	\N	2021-11-08 10:21:21.519+00	2021-11-08 10:21:21.969+00
7150	\N	died	2021-11-08 10:20:31.045+00	\N	\N	2021-11-08 10:21:21.961+00	2021-11-08 10:21:22.266+00
7159	5	died	2021-11-08 10:20:31.057+00	\N	\N	2021-11-08 10:21:22.169+00	2021-11-08 10:21:22.563+00
7031	\N	died	2021-11-08 10:20:27.562+00	\N	\N	2021-11-08 10:21:19.185+00	2021-11-08 10:21:19.273+00
7035	\N	died	2021-11-08 10:20:27.613+00	\N	\N	2021-11-08 10:21:19.258+00	2021-11-08 10:21:19.355+00
7040	\N	died	2021-11-08 10:20:27.72+00	\N	\N	2021-11-08 10:21:19.351+00	2021-11-08 10:21:19.496+00
7047	\N	died	2021-11-08 10:20:27.928+00	\N	\N	2021-11-08 10:21:19.482+00	2021-11-08 10:21:19.535+00
7049	\N	died	2021-11-08 10:20:27.979+00	\N	\N	2021-11-08 10:21:19.528+00	2021-11-08 10:21:19.641+00
7053	\N	died	2021-11-08 10:20:28.054+00	\N	\N	2021-11-08 10:21:19.602+00	2021-11-08 10:21:19.797+00
7063	\N	died	2021-11-08 10:20:28.272+00	\N	\N	2021-11-08 10:21:19.793+00	2021-11-08 10:21:20.097+00
7073	\N	died	2021-11-08 10:20:28.563+00	\N	\N	2021-11-08 10:21:20.06+00	2021-11-08 10:21:20.221+00
7077	\N	died	2021-11-08 10:20:28.77+00	\N	\N	2021-11-08 10:21:20.211+00	2021-11-08 10:21:20.376+00
7083	\N	died	2021-11-08 10:20:29.03+00	\N	\N	2021-11-08 10:21:20.333+00	2021-11-08 10:21:20.597+00
7094	\N	died	2021-11-08 10:20:29.587+00	\N	\N	2021-11-08 10:21:20.585+00	2021-11-08 10:21:21.122+00
7114	\N	died	2021-11-08 10:20:30.899+00	\N	\N	2021-11-08 10:21:21.049+00	2021-11-08 10:21:21.365+00
7126	\N	died	2021-11-08 10:20:30.988+00	\N	\N	2021-11-08 10:21:21.343+00	2021-11-08 10:21:21.734+00
7141	\N	died	2021-11-08 10:20:31.034+00	\N	\N	2021-11-08 10:21:21.72+00	2021-11-08 10:21:21.8+00
7144	\N	died	2021-11-08 10:20:31.037+00	\N	\N	2021-11-08 10:21:21.777+00	2021-11-08 10:21:21.952+00
7149	\N	died	2021-11-08 10:20:31.043+00	\N	\N	2021-11-08 10:21:21.947+00	2021-11-08 10:21:22.266+00
7157	\N	died	2021-11-08 10:20:31.054+00	\N	\N	2021-11-08 10:21:22.136+00	2021-11-08 10:21:22.513+00
7172	5	died	2021-11-08 10:20:31.068+00	\N	\N	2021-11-08 10:21:22.503+00	2021-11-08 10:21:22.686+00
7143	\N	died	2021-11-08 10:20:31.036+00	\N	\N	2021-11-08 10:21:21.761+00	2021-11-08 10:21:21.8+00
7145	\N	died	2021-11-08 10:20:31.038+00	\N	\N	2021-11-08 10:21:21.796+00	2021-11-08 10:21:21.914+00
7147	\N	died	2021-11-08 10:20:31.041+00	\N	\N	2021-11-08 10:21:21.905+00	2021-11-08 10:21:22.006+00
7153	\N	died	2021-11-08 10:20:31.049+00	\N	\N	2021-11-08 10:21:22.003+00	2021-11-08 10:21:22.281+00
7163	\N	died	2021-11-08 10:20:31.061+00	\N	\N	2021-11-08 10:21:22.277+00	2021-11-08 10:21:22.394+00
7165	\N	died	2021-11-08 10:20:31.063+00	\N	\N	2021-11-08 10:21:22.372+00	2021-11-08 10:21:22.495+00
7169	5	died	2021-11-08 10:20:31.066+00	\N	\N	2021-11-08 10:21:22.453+00	2021-11-08 10:21:22.702+00
\.


--
-- Data for Name: i18n_locales; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.i18n_locales (id, name, code, created_by, updated_by, created_at, updated_at) FROM stdin;
1	English (en)	en	\N	\N	2021-11-04 21:49:48.484+00	2021-11-04 21:49:48.484+00
\.


--
-- Data for Name: scheduled_game_participants; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.scheduled_game_participants (id, nft_id, scheduled_game, published_at, created_by, updated_by, created_at, updated_at, game_participants_result, user_address) FROM stdin;
3	sss	824	2021-11-07 19:55:30.416+00	1	1	2021-11-07 19:55:22.51+00	2021-11-08 11:01:32.539+00	\N	sss
7	9	824	2021-11-08 10:24:51.917+00	1	1	2021-11-08 10:24:49.631+00	2021-11-08 11:01:32.539+00	\N	2342
8	325	824	2021-11-08 10:25:04.397+00	1	1	2021-11-08 10:25:01.975+00	2021-11-08 11:01:32.539+00	\N	235
10	255	824	2021-11-08 10:25:25.07+00	1	1	2021-11-08 10:25:23.806+00	2021-11-08 11:01:32.539+00	\N	35
9	5235	824	2021-11-08 10:25:14.178+00	1	1	2021-11-08 10:25:12.93+00	2021-11-08 11:01:32.539+00	\N	135
6	8	824	2021-11-08 02:09:08.24+00	1	1	2021-11-08 02:09:05.588+00	2021-11-08 11:01:32.539+00	\N	8
4	4	823	2021-11-08 02:05:40.17+00	1	1	2021-11-08 02:05:02.239+00	2021-11-08 10:57:04.953+00	\N	ssss
5	34	823	2021-11-08 02:06:03.562+00	1	1	2021-11-08 02:06:02.025+00	2021-11-08 10:57:04.953+00	7174	matheus
\.


--
-- Data for Name: scheduled_games; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.scheduled_games (id, game_date, published_at, created_by, updated_by, created_at, updated_at) FROM stdin;
812	2021-11-08 08:15:00+00	2021-11-08 08:14:26+00	1	1	2021-11-08 08:14:24.432+00	2021-11-08 08:14:26.013+00
813	2021-11-08 09:47:00+00	2021-11-08 09:46:11.471+00	1	1	2021-11-08 09:46:09.402+00	2021-11-08 09:46:11.482+00
814	2021-11-08 09:50:00+00	2021-11-08 09:49:10.798+00	1	1	2021-11-08 09:49:09.357+00	2021-11-08 09:49:10.809+00
815	2021-11-08 10:18:00+00	2021-11-08 10:17:13.441+00	1	1	2021-11-08 10:17:11.62+00	2021-11-08 10:17:13.452+00
816	2021-11-08 10:26:00+00	2021-11-08 10:25:58.313+00	1	1	2021-11-08 10:25:51.375+00	2021-11-08 10:25:58.33+00
817	2021-11-08 10:28:00+00	2021-11-08 10:26:58.626+00	1	1	2021-11-08 10:26:56.762+00	2021-11-08 10:26:58.638+00
818	2021-11-08 10:35:00+00	2021-11-08 10:34:45.881+00	1	1	2021-11-08 10:34:44.232+00	2021-11-08 10:34:45.91+00
819	2021-11-08 10:41:00+00	2021-11-08 10:40:23.166+00	1	1	2021-11-08 10:40:21.69+00	2021-11-08 10:40:23.177+00
820	2021-11-08 10:45:00+00	2021-11-08 10:44:39.755+00	1	1	2021-11-08 10:44:37.661+00	2021-11-08 10:44:39.766+00
821	2021-11-08 10:47:00+00	2021-11-08 10:46:41.479+00	1	1	2021-11-08 10:46:39.377+00	2021-11-08 10:46:41.49+00
822	2021-11-08 10:50:00+00	2021-11-08 10:49:23.307+00	1	1	2021-11-08 10:49:01.934+00	2021-11-08 10:49:23.318+00
823	2021-11-08 10:58:00+00	2021-11-08 10:57:07.684+00	1	1	2021-11-08 10:55:42.517+00	2021-11-08 10:57:07.695+00
808	2021-11-08 05:06:00+00	2021-11-08 05:04:38.046+00	1	1	2021-11-08 05:04:35.717+00	2021-11-08 05:04:38.057+00
824	2021-11-08 11:02:00+00	2021-11-08 11:01:34.003+00	1	1	2021-11-08 11:01:32.533+00	2021-11-08 11:01:34.015+00
809	2021-11-08 05:09:00+00	2021-11-08 05:08:14.316+00	1	1	2021-11-08 05:08:12.703+00	2021-11-08 05:08:18.146+00
810	2021-11-08 07:53:00+00	2021-11-08 07:52:38.792+00	1	1	2021-11-08 07:52:37.273+00	2021-11-08 07:52:38.806+00
811	2021-11-08 07:55:00+00	2021-11-08 07:54:29.125+00	1	1	2021-11-08 07:54:27.116+00	2021-11-08 07:54:29.137+00
\.


--
-- Data for Name: strapi_administrator; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_administrator (id, firstname, lastname, username, email, password, "resetPasswordToken", "registrationToken", "isActive", blocked, "preferedLanguage") FROM stdin;
1	João Mário 	Lago	\N	joao.mario.lago@gmail.com	$2a$10$ufpqYVQJxMoDIGfJj/qUY.jYk0XSpupZyaEOiLI87lanC4mURjOE2	\N	\N	t	\N	\N
2	General	General	\N	any@any.com	$2a$10$lk.hnVoZQajbZ80Z3JCo7eZCbtBCYpnKxZLSGwlZUlcb0zqh6gg5C	\N	a8214b702cd20922abe8dd1cc8bf379652556155	t	\N	\N
\.


--
-- Data for Name: strapi_permission; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_permission (id, action, subject, properties, conditions, role, created_at, updated_at) FROM stdin;
1	plugins::upload.read	\N	{}	[]	2	2021-11-04 21:49:50.24+00	2021-11-04 21:49:50.25+00
2	plugins::upload.assets.create	\N	{}	[]	2	2021-11-04 21:49:50.24+00	2021-11-04 21:49:50.25+00
3	plugins::upload.assets.update	\N	{}	[]	2	2021-11-04 21:49:50.24+00	2021-11-04 21:49:50.251+00
4	plugins::upload.assets.download	\N	{}	[]	2	2021-11-04 21:49:50.24+00	2021-11-04 21:49:50.251+00
5	plugins::upload.assets.copy-link	\N	{}	[]	2	2021-11-04 21:49:50.24+00	2021-11-04 21:49:50.254+00
6	plugins::upload.assets.create	\N	{}	[]	3	2021-11-04 21:49:50.288+00	2021-11-04 21:49:50.3+00
7	plugins::upload.read	\N	{}	["admin::is-creator"]	3	2021-11-04 21:49:50.288+00	2021-11-04 21:49:50.3+00
8	plugins::upload.assets.update	\N	{}	["admin::is-creator"]	3	2021-11-04 21:49:50.289+00	2021-11-04 21:49:50.3+00
9	plugins::upload.assets.download	\N	{}	[]	3	2021-11-04 21:49:50.289+00	2021-11-04 21:49:50.305+00
10	plugins::upload.assets.copy-link	\N	{}	[]	3	2021-11-04 21:49:50.289+00	2021-11-04 21:49:50.309+00
158	plugins::content-manager.explorer.delete	application::game-participants-results.game-participants-results	{}	[]	1	2021-11-08 10:23:29.754+00	2021-11-08 10:23:29.781+00
11	plugins::content-manager.explorer.create	plugins::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	1	2021-11-04 21:49:50.371+00	2021-11-04 21:49:50.392+00
12	plugins::content-manager.explorer.read	plugins::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	1	2021-11-04 21:49:50.371+00	2021-11-04 21:49:50.392+00
163	plugins::content-manager.explorer.publish	application::scheduled-game-participants.scheduled-game-participants	{}	[]	1	2021-11-08 10:23:29.758+00	2021-11-08 10:23:29.781+00
15	plugins::content-type-builder.read	\N	{}	[]	1	2021-11-04 21:49:50.371+00	2021-11-04 21:49:50.392+00
16	plugins::email.settings.read	\N	{}	[]	1	2021-11-04 21:49:50.372+00	2021-11-04 21:49:50.392+00
17	plugins::upload.read	\N	{}	[]	1	2021-11-04 21:49:50.372+00	2021-11-04 21:49:50.392+00
18	plugins::upload.assets.create	\N	{}	[]	1	2021-11-04 21:49:50.372+00	2021-11-04 21:49:50.393+00
19	plugins::upload.assets.update	\N	{}	[]	1	2021-11-04 21:49:50.372+00	2021-11-04 21:49:50.393+00
13	plugins::content-manager.explorer.update	plugins::users-permissions.user	{"fields": ["username", "email", "provider", "password", "resetPasswordToken", "confirmationToken", "confirmed", "blocked", "role"]}	[]	1	2021-11-04 21:49:50.371+00	2021-11-04 21:49:50.397+00
20	plugins::upload.assets.download	\N	{}	[]	1	2021-11-04 21:49:50.372+00	2021-11-04 21:49:50.397+00
21	plugins::upload.assets.copy-link	\N	{}	[]	1	2021-11-04 21:49:50.43+00	2021-11-04 21:49:50.433+00
22	plugins::upload.settings.read	\N	{}	[]	1	2021-11-04 21:49:50.44+00	2021-11-04 21:49:50.457+00
23	plugins::i18n.locale.create	\N	{}	[]	1	2021-11-04 21:49:50.44+00	2021-11-04 21:49:50.457+00
24	plugins::i18n.locale.read	\N	{}	[]	1	2021-11-04 21:49:50.44+00	2021-11-04 21:49:50.457+00
25	plugins::i18n.locale.update	\N	{}	[]	1	2021-11-04 21:49:50.44+00	2021-11-04 21:49:50.457+00
26	plugins::i18n.locale.delete	\N	{}	[]	1	2021-11-04 21:49:50.44+00	2021-11-04 21:49:50.458+00
27	plugins::content-manager.single-types.configure-view	\N	{}	[]	1	2021-11-04 21:49:50.441+00	2021-11-04 21:49:50.458+00
28	plugins::content-manager.collection-types.configure-view	\N	{}	[]	1	2021-11-04 21:49:50.441+00	2021-11-04 21:49:50.458+00
29	plugins::content-manager.components.configure-layout	\N	{}	[]	1	2021-11-04 21:49:50.441+00	2021-11-04 21:49:50.458+00
30	plugins::users-permissions.roles.create	\N	{}	[]	1	2021-11-04 21:49:50.445+00	2021-11-04 21:49:50.463+00
31	plugins::users-permissions.roles.read	\N	{}	[]	1	2021-11-04 21:49:50.458+00	2021-11-04 21:49:50.481+00
32	plugins::users-permissions.roles.update	\N	{}	[]	1	2021-11-04 21:49:50.495+00	2021-11-04 21:49:50.509+00
33	plugins::users-permissions.roles.delete	\N	{}	[]	1	2021-11-04 21:49:50.505+00	2021-11-04 21:49:50.537+00
34	plugins::users-permissions.providers.update	\N	{}	[]	1	2021-11-04 21:49:50.509+00	2021-11-04 21:49:50.546+00
35	plugins::users-permissions.email-templates.read	\N	{}	[]	1	2021-11-04 21:49:50.509+00	2021-11-04 21:49:50.546+00
36	plugins::users-permissions.email-templates.update	\N	{}	[]	1	2021-11-04 21:49:50.51+00	2021-11-04 21:49:50.546+00
37	plugins::users-permissions.advanced-settings.read	\N	{}	[]	1	2021-11-04 21:49:50.51+00	2021-11-04 21:49:50.546+00
41	plugins::users-permissions.advanced-settings.update	\N	{}	[]	1	2021-11-04 21:49:50.51+00	2021-11-04 21:49:50.547+00
38	admin::marketplace.read	\N	{}	[]	1	2021-11-04 21:49:50.511+00	2021-11-04 21:49:50.547+00
39	admin::marketplace.plugins.install	\N	{}	[]	1	2021-11-04 21:49:50.511+00	2021-11-04 21:49:50.547+00
40	plugins::users-permissions.providers.read	\N	{}	[]	1	2021-11-04 21:49:50.512+00	2021-11-04 21:49:50.547+00
42	admin::marketplace.plugins.uninstall	\N	{}	[]	1	2021-11-04 21:49:50.575+00	2021-11-04 21:49:50.58+00
43	admin::webhooks.create	\N	{}	[]	1	2021-11-04 21:49:50.578+00	2021-11-04 21:49:50.583+00
44	admin::webhooks.read	\N	{}	[]	1	2021-11-04 21:49:50.591+00	2021-11-04 21:49:50.609+00
45	admin::webhooks.update	\N	{}	[]	1	2021-11-04 21:49:50.591+00	2021-11-04 21:49:50.609+00
46	admin::webhooks.delete	\N	{}	[]	1	2021-11-04 21:49:50.591+00	2021-11-04 21:49:50.609+00
47	admin::users.create	\N	{}	[]	1	2021-11-04 21:49:50.591+00	2021-11-04 21:49:50.609+00
48	admin::users.read	\N	{}	[]	1	2021-11-04 21:49:50.591+00	2021-11-04 21:49:50.609+00
49	admin::users.update	\N	{}	[]	1	2021-11-04 21:49:50.592+00	2021-11-04 21:49:50.609+00
50	admin::users.delete	\N	{}	[]	1	2021-11-04 21:49:50.592+00	2021-11-04 21:49:50.609+00
51	admin::roles.create	\N	{}	[]	1	2021-11-04 21:49:50.592+00	2021-11-04 21:49:50.614+00
52	admin::roles.read	\N	{}	[]	1	2021-11-04 21:49:50.601+00	2021-11-04 21:49:50.618+00
53	admin::roles.update	\N	{}	[]	1	2021-11-04 21:49:50.618+00	2021-11-04 21:49:50.641+00
54	admin::roles.delete	\N	{}	[]	1	2021-11-04 21:49:50.646+00	2021-11-04 21:49:50.648+00
62	plugins::content-manager.explorer.create	application::scheduled-games.scheduled-games	{"fields": ["game_date", "scheduled_game_participants"]}	[]	1	2021-11-04 21:55:59.357+00	2021-11-04 21:55:59.38+00
64	plugins::content-manager.explorer.read	application::scheduled-games.scheduled-games	{"fields": ["game_date", "scheduled_game_participants"]}	[]	1	2021-11-04 21:55:59.358+00	2021-11-04 21:55:59.38+00
159	plugins::content-manager.explorer.delete	application::scheduled-game-participants.scheduled-game-participants	{}	[]	1	2021-11-08 10:23:29.755+00	2021-11-08 10:23:29.781+00
164	plugins::content-manager.explorer.publish	application::scheduled-games.scheduled-games	{}	[]	1	2021-11-08 10:23:29.759+00	2021-11-08 10:23:29.786+00
122	plugins::content-manager.explorer.update	application::scheduled-game-participants.scheduled-game-participants	{"fields": ["scheduled_game", "game_participants_result", "nft_id", "user_address"]}	[]	1	2021-11-07 19:35:28.955+00	2021-11-07 19:35:28.991+00
160	plugins::content-manager.explorer.delete	application::scheduled-games.scheduled-games	{}	[]	1	2021-11-08 10:23:29.756+00	2021-11-08 10:23:29.781+00
123	plugins::content-manager.explorer.read	application::scheduled-game-participants.scheduled-game-participants	{"fields": ["scheduled_game", "game_participants_result", "nft_id", "user_address"]}	[]	1	2021-11-07 19:35:28.955+00	2021-11-07 19:35:28.992+00
66	plugins::content-manager.explorer.update	application::scheduled-games.scheduled-games	{"fields": ["game_date", "scheduled_game_participants"]}	[]	1	2021-11-04 21:55:59.358+00	2021-11-04 21:55:59.38+00
161	plugins::content-manager.explorer.delete	plugins::users-permissions.user	{}	[]	1	2021-11-08 10:23:29.757+00	2021-11-08 10:23:29.781+00
124	plugins::content-manager.explorer.create	application::scheduled-game-participants.scheduled-game-participants	{"fields": ["scheduled_game", "game_participants_result", "nft_id", "user_address"]}	[]	1	2021-11-07 19:35:28.956+00	2021-11-07 19:35:28.992+00
162	plugins::content-manager.explorer.publish	application::game-participants-results.game-participants-results	{}	[]	1	2021-11-08 10:23:29.757+00	2021-11-08 10:23:29.781+00
73	plugins::content-manager.explorer.create	application::game-participants-results.game-participants-results	{"fields": ["scheduled_game_participant", "result"]}	[]	1	2021-11-04 21:57:13.973+00	2021-11-04 21:57:13.993+00
74	plugins::content-manager.explorer.read	application::game-participants-results.game-participants-results	{"fields": ["scheduled_game_participant", "result"]}	[]	1	2021-11-04 21:57:13.973+00	2021-11-04 21:57:13.993+00
76	plugins::content-manager.explorer.update	application::game-participants-results.game-participants-results	{"fields": ["scheduled_game_participant", "result"]}	[]	1	2021-11-04 21:57:13.973+00	2021-11-04 21:57:13.993+00
\.


--
-- Data for Name: strapi_role; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_role (id, name, code, description, created_at, updated_at) FROM stdin;
1	Super Admin	strapi-super-admin	Super Admins can access and manage all features and settings.	2021-11-04 21:49:50.135+00	2021-11-04 21:49:50.135+00
2	Editor	strapi-editor	Editors can manage and publish contents including those of other users.	2021-11-04 21:49:50.18+00	2021-11-04 21:49:50.18+00
3	Author	strapi-author	Authors can manage the content they have created.	2021-11-04 21:49:50.221+00	2021-11-04 21:49:50.221+00
\.


--
-- Data for Name: strapi_users_roles; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_users_roles (id, user_id, role_id) FROM stdin;
1	1	1
2	2	1
\.


--
-- Data for Name: strapi_webhooks; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.strapi_webhooks (id, name, url, headers, events, enabled) FROM stdin;
1	Game scheduling	http://host.docker.internal:3000/scheduled-games	{}	["entry.publish"]	t
\.


--
-- Data for Name: upload_file; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_file (id, name, "alternativeText", caption, width, height, formats, hash, ext, mime, size, url, "previewUrl", provider, provider_metadata, created_by, updated_by, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: upload_file_morph; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public.upload_file_morph (id, upload_file_id, related_id, related_type, field, "order") FROM stdin;
\.


--
-- Data for Name: users-permissions_permission; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public."users-permissions_permission" (id, type, controller, action, enabled, policy, role, created_by, updated_by) FROM stdin;
1	content-manager	collection-types	bulkdelete	f		1	\N	\N
2	content-manager	collection-types	bulkdelete	f		2	\N	\N
3	content-manager	collection-types	create	f		1	\N	\N
4	content-manager	collection-types	create	f		2	\N	\N
5	content-manager	collection-types	delete	f		1	\N	\N
6	content-manager	collection-types	delete	f		2	\N	\N
7	content-manager	collection-types	find	f		1	\N	\N
8	content-manager	collection-types	find	f		2	\N	\N
10	content-manager	collection-types	findone	f		2	\N	\N
9	content-manager	collection-types	findone	f		1	\N	\N
11	content-manager	collection-types	previewmanyrelations	f		1	\N	\N
12	content-manager	collection-types	previewmanyrelations	f		2	\N	\N
14	content-manager	collection-types	unpublish	f		1	\N	\N
15	content-manager	collection-types	unpublish	f		2	\N	\N
16	content-manager	collection-types	update	f		1	\N	\N
17	content-manager	collection-types	update	f		2	\N	\N
18	content-manager	components	findcomponentconfiguration	f		1	\N	\N
19	content-manager	components	findcomponentconfiguration	f		2	\N	\N
20	content-manager	collection-types	publish	f		2	\N	\N
13	content-manager	collection-types	publish	f		1	\N	\N
21	content-manager	components	findcomponents	f		1	\N	\N
22	content-manager	components	findcomponents	f		2	\N	\N
23	content-manager	components	updatecomponentconfiguration	f		1	\N	\N
25	content-manager	content-types	findcontenttypeconfiguration	f		2	\N	\N
27	content-manager	content-types	findcontenttypes	f		1	\N	\N
24	content-manager	components	updatecomponentconfiguration	f		2	\N	\N
26	content-manager	content-types	findcontenttypeconfiguration	f		1	\N	\N
28	content-manager	content-types	findcontenttypes	f		2	\N	\N
29	content-manager	content-types	findcontenttypessettings	f		1	\N	\N
30	content-manager	content-types	findcontenttypessettings	f		2	\N	\N
31	content-manager	content-types	updatecontenttypeconfiguration	f		1	\N	\N
32	content-manager	content-types	updatecontenttypeconfiguration	f		2	\N	\N
33	content-manager	relations	find	f		1	\N	\N
34	content-manager	relations	find	f		2	\N	\N
36	content-manager	single-types	delete	f		1	\N	\N
37	content-manager	single-types	delete	f		2	\N	\N
38	content-manager	single-types	find	f		1	\N	\N
39	content-manager	single-types	find	f		2	\N	\N
40	content-manager	single-types	publish	f		1	\N	\N
41	content-manager	single-types	createorupdate	f		2	\N	\N
35	content-manager	single-types	createorupdate	f		1	\N	\N
42	content-manager	single-types	publish	f		2	\N	\N
43	content-manager	single-types	unpublish	f		1	\N	\N
44	content-manager	single-types	unpublish	f		2	\N	\N
45	content-manager	uid	checkuidavailability	f		1	\N	\N
46	content-manager	uid	checkuidavailability	f		2	\N	\N
48	content-manager	uid	generateuid	f		2	\N	\N
49	content-type-builder	builder	getreservednames	f		1	\N	\N
50	content-type-builder	builder	getreservednames	f		2	\N	\N
51	content-type-builder	componentcategories	deletecategory	f		1	\N	\N
52	content-type-builder	componentcategories	deletecategory	f		2	\N	\N
47	content-manager	uid	generateuid	f		1	\N	\N
53	content-type-builder	componentcategories	editcategory	f		1	\N	\N
54	content-type-builder	componentcategories	editcategory	f		2	\N	\N
55	content-type-builder	components	createcomponent	f		1	\N	\N
56	content-type-builder	components	createcomponent	f		2	\N	\N
57	content-type-builder	components	deletecomponent	f		1	\N	\N
58	content-type-builder	components	deletecomponent	f		2	\N	\N
59	content-type-builder	components	getcomponent	f		1	\N	\N
60	content-type-builder	components	getcomponent	f		2	\N	\N
61	content-type-builder	components	getcomponents	f		1	\N	\N
62	content-type-builder	components	getcomponents	f		2	\N	\N
63	content-type-builder	components	updatecomponent	f		1	\N	\N
64	content-type-builder	components	updatecomponent	f		2	\N	\N
65	content-type-builder	connections	getconnections	f		1	\N	\N
183	application	scheduled-games	update	f		1	\N	\N
185	application	scheduled-game-participants	count	f		1	\N	\N
195	application	scheduled-game-participants	update	f		1	\N	\N
73	content-type-builder	contenttypes	getcontenttypes	f		1	\N	\N
78	email	email	getsettings	f		2	\N	\N
87	i18n	locales	createlocale	f		1	\N	\N
97	upload	upload	destroy	f		1	\N	\N
106	upload	upload	search	f		2	\N	\N
118	users-permissions	auth	forgotpassword	t		2	\N	\N
128	users-permissions	user	create	f		2	\N	\N
138	users-permissions	user	me	t		2	\N	\N
149	users-permissions	userspermissions	getpermissions	f		1	\N	\N
158	users-permissions	userspermissions	getroles	f		2	\N	\N
169	users-permissions	userspermissions	updateproviders	f		2	\N	\N
173	application	scheduled-games	create	t		2	\N	\N
207	application	game-participants-results	update	f		1	\N	\N
197	application	game-participants-results	count	t		2	\N	\N
75	content-type-builder	contenttypes	updatecontenttype	f		1	\N	\N
85	i18n	iso-locales	listisolocales	f		1	\N	\N
90	i18n	locales	deletelocale	f		2	\N	\N
99	upload	upload	find	f		1	\N	\N
109	upload	upload	upload	f		1	\N	\N
119	users-permissions	auth	register	f		1	\N	\N
129	users-permissions	user	destroy	f		1	\N	\N
139	users-permissions	user	update	f		1	\N	\N
148	users-permissions	userspermissions	getemailtemplate	f		2	\N	\N
159	users-permissions	userspermissions	getroutes	f		1	\N	\N
171	users-permissions	userspermissions	searchusers	f		2	\N	\N
198	application	game-participants-results	count	f		1	\N	\N
186	application	scheduled-game-participants	count	t		2	\N	\N
174	application	scheduled-games	delete	t		2	\N	\N
196	application	scheduled-game-participants	update	t		2	\N	\N
66	content-type-builder	connections	getconnections	f		2	\N	\N
76	content-type-builder	contenttypes	updatecontenttype	f		2	\N	\N
86	i18n	iso-locales	listisolocales	f		2	\N	\N
96	upload	upload	count	f		2	\N	\N
107	upload	upload	updatesettings	f		1	\N	\N
113	users-permissions	auth	connect	t		1	\N	\N
123	users-permissions	auth	sendemailconfirmation	f		1	\N	\N
134	users-permissions	user	find	f		2	\N	\N
144	users-permissions	userspermissions	deleterole	f		2	\N	\N
154	users-permissions	userspermissions	getproviders	f		2	\N	\N
170	users-permissions	userspermissions	updaterole	f		1	\N	\N
187	application	scheduled-game-participants	create	f		1	\N	\N
199	application	game-participants-results	create	f		1	\N	\N
175	application	scheduled-games	find	t		2	\N	\N
68	content-type-builder	contenttypes	createcontenttype	f		2	\N	\N
77	email	email	getsettings	f		1	\N	\N
88	i18n	locales	createlocale	f		2	\N	\N
98	upload	upload	destroy	f		2	\N	\N
108	upload	upload	updatesettings	f		2	\N	\N
117	users-permissions	auth	forgotpassword	f		1	\N	\N
127	users-permissions	user	create	f		1	\N	\N
137	users-permissions	user	me	t		1	\N	\N
147	users-permissions	userspermissions	getemailtemplate	f		1	\N	\N
157	users-permissions	userspermissions	getroles	f		1	\N	\N
164	users-permissions	userspermissions	updateadvancedsettings	f		1	\N	\N
176	application	scheduled-games	findone	f		1	\N	\N
200	application	game-participants-results	create	t		2	\N	\N
188	application	scheduled-game-participants	create	t		2	\N	\N
184	application	scheduled-games	update	t		2	\N	\N
67	content-type-builder	contenttypes	createcontenttype	f		1	\N	\N
80	email	email	send	f		2	\N	\N
91	i18n	locales	listlocales	f		1	\N	\N
101	upload	upload	findone	f		1	\N	\N
111	users-permissions	auth	callback	f		1	\N	\N
121	users-permissions	auth	resetpassword	f		1	\N	\N
131	users-permissions	user	destroyall	f		1	\N	\N
140	users-permissions	user	update	f		2	\N	\N
150	users-permissions	userspermissions	getpermissions	f		2	\N	\N
160	users-permissions	userspermissions	getroutes	f		2	\N	\N
168	users-permissions	userspermissions	updateproviders	f		1	\N	\N
177	application	scheduled-games	find	f		1	\N	\N
189	application	scheduled-game-participants	delete	f		1	\N	\N
201	application	game-participants-results	delete	f		1	\N	\N
69	content-type-builder	contenttypes	deletecontenttype	f		1	\N	\N
81	email	email	test	f		1	\N	\N
89	i18n	locales	deletelocale	f		1	\N	\N
100	upload	upload	find	f		2	\N	\N
110	upload	upload	upload	f		2	\N	\N
120	users-permissions	auth	register	t		2	\N	\N
130	users-permissions	user	destroy	f		2	\N	\N
141	users-permissions	userspermissions	createrole	f		1	\N	\N
151	users-permissions	userspermissions	getpolicies	f		1	\N	\N
161	users-permissions	userspermissions	index	f		1	\N	\N
167	users-permissions	userspermissions	updateemailtemplate	f		2	\N	\N
178	application	scheduled-games	create	f		1	\N	\N
208	application	game-participants-results	update	t		2	\N	\N
202	application	game-participants-results	delete	t		2	\N	\N
190	application	scheduled-game-participants	delete	t		2	\N	\N
70	content-type-builder	contenttypes	deletecontenttype	f		2	\N	\N
82	email	email	test	f		2	\N	\N
93	i18n	locales	updatelocale	f		1	\N	\N
105	upload	upload	getsettings	f		2	\N	\N
115	users-permissions	auth	emailconfirmation	f		1	\N	\N
126	users-permissions	user	count	f		2	\N	\N
133	users-permissions	user	find	f		1	\N	\N
143	users-permissions	userspermissions	deleterole	f		1	\N	\N
152	users-permissions	userspermissions	getpolicies	f		2	\N	\N
162	users-permissions	userspermissions	index	f		2	\N	\N
172	users-permissions	userspermissions	updaterole	f		2	\N	\N
191	application	scheduled-game-participants	findone	f		1	\N	\N
203	application	game-participants-results	find	f		1	\N	\N
179	application	scheduled-games	count	t		2	\N	\N
72	content-type-builder	contenttypes	getcontenttype	f		2	\N	\N
79	email	email	send	f		1	\N	\N
95	upload	upload	count	f		1	\N	\N
104	upload	upload	search	f		1	\N	\N
116	users-permissions	auth	emailconfirmation	t		2	\N	\N
124	users-permissions	auth	sendemailconfirmation	f		2	\N	\N
136	users-permissions	user	findone	f		2	\N	\N
146	users-permissions	userspermissions	getadvancedsettings	f		2	\N	\N
155	users-permissions	userspermissions	getrole	f		1	\N	\N
166	users-permissions	userspermissions	updateemailtemplate	f		1	\N	\N
180	application	scheduled-games	count	f		1	\N	\N
192	application	scheduled-game-participants	find	f		1	\N	\N
204	application	game-participants-results	find	t		2	\N	\N
71	content-type-builder	contenttypes	getcontenttype	f		1	\N	\N
83	i18n	content-types	getnonlocalizedattributes	f		1	\N	\N
94	i18n	locales	updatelocale	f		2	\N	\N
103	upload	upload	getsettings	f		1	\N	\N
114	users-permissions	auth	connect	t		2	\N	\N
125	users-permissions	user	count	f		1	\N	\N
135	users-permissions	user	findone	f		1	\N	\N
145	users-permissions	userspermissions	getadvancedsettings	f		1	\N	\N
156	users-permissions	userspermissions	getrole	f		2	\N	\N
165	users-permissions	userspermissions	updateadvancedsettings	f		2	\N	\N
181	application	scheduled-games	delete	f		1	\N	\N
205	application	game-participants-results	findone	f		1	\N	\N
193	application	scheduled-game-participants	find	t		2	\N	\N
74	content-type-builder	contenttypes	getcontenttypes	f		2	\N	\N
84	i18n	content-types	getnonlocalizedattributes	f		2	\N	\N
92	i18n	locales	listlocales	f		2	\N	\N
102	upload	upload	findone	f		2	\N	\N
112	users-permissions	auth	callback	t		2	\N	\N
122	users-permissions	auth	resetpassword	t		2	\N	\N
132	users-permissions	user	destroyall	f		2	\N	\N
142	users-permissions	userspermissions	createrole	f		2	\N	\N
153	users-permissions	userspermissions	getproviders	f		1	\N	\N
163	users-permissions	userspermissions	searchusers	f		1	\N	\N
206	application	game-participants-results	findone	t		2	\N	\N
194	application	scheduled-game-participants	findone	t		2	\N	\N
182	application	scheduled-games	findone	t		2	\N	\N
\.


--
-- Data for Name: users-permissions_role; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public."users-permissions_role" (id, name, description, type, created_by, updated_by) FROM stdin;
1	Authenticated	Default role given to authenticated user.	authenticated	\N	\N
2	Public	Default role given to unauthenticated user.	public	\N	\N
\.


--
-- Data for Name: users-permissions_user; Type: TABLE DATA; Schema: public; Owner: strapi
--

COPY public."users-permissions_user" (id, username, email, provider, password, "resetPasswordToken", "confirmationToken", confirmed, blocked, role, created_by, updated_by, created_at, updated_at) FROM stdin;
\.


--
-- Name: core_store_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.core_store_id_seq', 30, true);


--
-- Name: game_participants_results_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.game_participants_results_id_seq', 7174, true);


--
-- Name: i18n_locales_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.i18n_locales_id_seq', 1, true);


--
-- Name: scheduled_game_participants_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.scheduled_game_participants_id_seq', 10, true);


--
-- Name: scheduled_games_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.scheduled_games_id_seq', 824, true);


--
-- Name: strapi_administrator_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_administrator_id_seq', 2, true);


--
-- Name: strapi_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_permission_id_seq', 164, true);


--
-- Name: strapi_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_role_id_seq', 3, true);


--
-- Name: strapi_users_roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_users_roles_id_seq', 3, true);


--
-- Name: strapi_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.strapi_webhooks_id_seq', 1, true);


--
-- Name: upload_file_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_file_id_seq', 1, false);


--
-- Name: upload_file_morph_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public.upload_file_morph_id_seq', 1, false);


--
-- Name: users-permissions_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public."users-permissions_permission_id_seq"', 208, true);


--
-- Name: users-permissions_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public."users-permissions_role_id_seq"', 2, true);


--
-- Name: users-permissions_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: strapi
--

SELECT pg_catalog.setval('public."users-permissions_user_id_seq"', 1, false);


--
-- Name: core_store core_store_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.core_store
    ADD CONSTRAINT core_store_pkey PRIMARY KEY (id);


--
-- Name: game_participants_results game_participants_results_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.game_participants_results
    ADD CONSTRAINT game_participants_results_pkey PRIMARY KEY (id);


--
-- Name: i18n_locales i18n_locales_code_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locales
    ADD CONSTRAINT i18n_locales_code_unique UNIQUE (code);


--
-- Name: i18n_locales i18n_locales_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.i18n_locales
    ADD CONSTRAINT i18n_locales_pkey PRIMARY KEY (id);


--
-- Name: scheduled_game_participants scheduled_game_participants_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.scheduled_game_participants
    ADD CONSTRAINT scheduled_game_participants_pkey PRIMARY KEY (id);


--
-- Name: scheduled_games scheduled_games_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.scheduled_games
    ADD CONSTRAINT scheduled_games_pkey PRIMARY KEY (id);


--
-- Name: strapi_administrator strapi_administrator_email_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_administrator
    ADD CONSTRAINT strapi_administrator_email_unique UNIQUE (email);


--
-- Name: strapi_administrator strapi_administrator_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_administrator
    ADD CONSTRAINT strapi_administrator_pkey PRIMARY KEY (id);


--
-- Name: strapi_permission strapi_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_permission
    ADD CONSTRAINT strapi_permission_pkey PRIMARY KEY (id);


--
-- Name: strapi_role strapi_role_code_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_role
    ADD CONSTRAINT strapi_role_code_unique UNIQUE (code);


--
-- Name: strapi_role strapi_role_name_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_role
    ADD CONSTRAINT strapi_role_name_unique UNIQUE (name);


--
-- Name: strapi_role strapi_role_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_role
    ADD CONSTRAINT strapi_role_pkey PRIMARY KEY (id);


--
-- Name: strapi_users_roles strapi_users_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_users_roles
    ADD CONSTRAINT strapi_users_roles_pkey PRIMARY KEY (id);


--
-- Name: strapi_webhooks strapi_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.strapi_webhooks
    ADD CONSTRAINT strapi_webhooks_pkey PRIMARY KEY (id);


--
-- Name: upload_file_morph upload_file_morph_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_file_morph
    ADD CONSTRAINT upload_file_morph_pkey PRIMARY KEY (id);


--
-- Name: upload_file upload_file_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public.upload_file
    ADD CONSTRAINT upload_file_pkey PRIMARY KEY (id);


--
-- Name: users-permissions_permission users-permissions_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_permission"
    ADD CONSTRAINT "users-permissions_permission_pkey" PRIMARY KEY (id);


--
-- Name: users-permissions_role users-permissions_role_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_role"
    ADD CONSTRAINT "users-permissions_role_pkey" PRIMARY KEY (id);


--
-- Name: users-permissions_role users-permissions_role_type_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_role"
    ADD CONSTRAINT "users-permissions_role_type_unique" UNIQUE (type);


--
-- Name: users-permissions_user users-permissions_user_pkey; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_user"
    ADD CONSTRAINT "users-permissions_user_pkey" PRIMARY KEY (id);


--
-- Name: users-permissions_user users-permissions_user_username_unique; Type: CONSTRAINT; Schema: public; Owner: strapi
--

ALTER TABLE ONLY public."users-permissions_user"
    ADD CONSTRAINT "users-permissions_user_username_unique" UNIQUE (username);


--
-- PostgreSQL database dump complete
--

