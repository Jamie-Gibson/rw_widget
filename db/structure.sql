--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: layers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE layers (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    provider integer DEFAULT 0,
    name character varying NOT NULL,
    color character varying,
    settings jsonb DEFAULT '"{}"'::jsonb,
    z_index integer DEFAULT 0,
    status integer DEFAULT 0,
    published boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: widgets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE widgets (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    name character varying NOT NULL,
    slug character varying,
    description text,
    source character varying,
    source_url character varying,
    authors character varying,
    query_url character varying,
    chart jsonb DEFAULT '"{}"'::jsonb,
    status integer DEFAULT 0,
    published boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: widgets_layers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE widgets_layers (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    widget_id uuid,
    layer_id uuid,
    main boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: layers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY layers
    ADD CONSTRAINT layers_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: widgets_layers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY widgets_layers
    ADD CONSTRAINT widgets_layers_pkey PRIMARY KEY (id);


--
-- Name: widgets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY widgets
    ADD CONSTRAINT widgets_pkey PRIMARY KEY (id);


--
-- Name: index_layers_on_provider; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_layers_on_provider ON layers USING btree (provider);


--
-- Name: index_layers_on_published; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_layers_on_published ON layers USING btree (published);


--
-- Name: index_layers_on_settings; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_layers_on_settings ON layers USING gin (settings);


--
-- Name: index_layers_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_layers_on_status ON layers USING btree (status);


--
-- Name: index_widgets_layers_on_layer_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_widgets_layers_on_layer_id ON widgets_layers USING btree (layer_id);


--
-- Name: index_widgets_layers_on_widget_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_widgets_layers_on_widget_id ON widgets_layers USING btree (widget_id);


--
-- Name: index_widgets_on_chart; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_widgets_on_chart ON widgets USING gin (chart);


--
-- Name: index_widgets_on_published; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_widgets_on_published ON widgets USING btree (published);


--
-- Name: index_widgets_on_status; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_widgets_on_status ON widgets USING btree (status);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160519085855'), ('20160519085906'), ('20160519141006'), ('20160519142335');


