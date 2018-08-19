SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: articles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.articles (
    id bigint NOT NULL,
    user_id bigint,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: articles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.articles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: articles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.articles_id_seq OWNED BY public.articles.id;


--
-- Name: documents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.documents (
    id bigint NOT NULL,
    file character varying,
    name character varying,
    documentable_id integer,
    documentable_type character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: documents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.documents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: documents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.documents_id_seq OWNED BY public.documents.id;


--
-- Name: journals; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.journals (
    id bigint NOT NULL,
    title character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: journals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.journals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: journals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.journals_id_seq OWNED BY public.journals.id;


--
-- Name: submission_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.submission_events (
    id bigint NOT NULL,
    submission_id bigint,
    event_type character varying,
    event_subtype character varying,
    date date,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: submissions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.submissions (
    id bigint NOT NULL,
    article_id bigint,
    journal_id bigint,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: latest_article_events_by_users; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.latest_article_events_by_users AS
 SELECT DISTINCT ON (articles.id) articles.id AS article_id,
    articles.user_id,
    submission_events.date AS latest_date
   FROM ((public.articles
     JOIN public.submissions ON ((articles.id = submissions.article_id)))
     JOIN public.submission_events ON ((submissions.id = submission_events.submission_id)))
  ORDER BY articles.id, submission_events.date DESC;


--
-- Name: latest_journal_events_by_users; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.latest_journal_events_by_users AS
 SELECT DISTINCT ON (journals.id) journals.id AS journal_id,
    articles.user_id,
    submission_events.date AS latest_date
   FROM (((public.journals
     JOIN public.submissions ON ((journals.id = submissions.journal_id)))
     JOIN public.articles ON ((articles.id = submissions.article_id)))
     JOIN public.submission_events ON ((submissions.id = submission_events.submission_id)))
  ORDER BY journals.id, submission_events.date DESC;


--
-- Name: latest_submission_events_by_submissions; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW public.latest_submission_events_by_submissions AS
 SELECT DISTINCT ON (submissions.id) submissions.article_id,
    submissions.id AS submission_id,
    submissions.journal_id,
    submission_events.date AS latest_date,
    submission_events.event_subtype
   FROM (public.submissions
     JOIN public.submission_events ON ((submissions.id = submission_events.submission_id)))
  ORDER BY submissions.id, submission_events.date DESC;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: submission_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submission_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submission_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submission_events_id_seq OWNED BY public.submission_events.id;


--
-- Name: submissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.submissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: submissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.submissions_id_seq OWNED BY public.submissions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying,
    email character varying,
    password_digest character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    reset_token character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles ALTER COLUMN id SET DEFAULT nextval('public.articles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.documents ALTER COLUMN id SET DEFAULT nextval('public.documents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.journals ALTER COLUMN id SET DEFAULT nextval('public.journals_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submission_events ALTER COLUMN id SET DEFAULT nextval('public.submission_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions ALTER COLUMN id SET DEFAULT nextval('public.submissions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: articles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: documents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.documents
    ADD CONSTRAINT documents_pkey PRIMARY KEY (id);


--
-- Name: journals_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.journals
    ADD CONSTRAINT journals_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: submission_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.submission_events
    ADD CONSTRAINT submission_events_pkey PRIMARY KEY (id);


--
-- Name: submissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT submissions_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_articles_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_articles_on_user_id ON public.articles USING btree (user_id);


--
-- Name: index_submission_events_on_submission_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_submission_events_on_submission_id ON public.submission_events USING btree (submission_id);


--
-- Name: index_submissions_on_article_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_submissions_on_article_id ON public.submissions USING btree (article_id);


--
-- Name: index_submissions_on_journal_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_submissions_on_journal_id ON public.submissions USING btree (journal_id);


--
-- Name: fk_rails_1da1d79383; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT fk_rails_1da1d79383 FOREIGN KEY (journal_id) REFERENCES public.journals(id);


--
-- Name: fk_rails_3d31dad1cc; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT fk_rails_3d31dad1cc FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: fk_rails_a05ac76e56; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.submissions
    ADD CONSTRAINT fk_rails_a05ac76e56 FOREIGN KEY (article_id) REFERENCES public.articles(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO "schema_migrations" (version) VALUES
('20171201012107'),
('20171202135053'),
('20171202141242'),
('20171202232216'),
('20171209232847'),
('20171225204520'),
('20171230132414'),
('20171231215144'),
('20180506200904'),
('20180715193921');


