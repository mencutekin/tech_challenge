--
-- PostgreSQL database dump
--

-- Dumped from database version 13.7
-- Dumped by pg_dump version 13.7

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

--
-- Name: pex; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pex;


ALTER SCHEMA pex OWNER TO postgres;

--
-- Name: audit_for_albums(); Type: FUNCTION; Schema: pex; Owner: postgres
--

CREATE FUNCTION pex.audit_for_albums() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

BEGIN
INSERT INTO audit_albums (title,old_artist_id,artist_id,username,entry_date) VALUES (NEW.title,OLD.artist_id,NEW.artist_id,current_user,current_date);
RETURN NEW;

END;

$$;


ALTER FUNCTION pex.audit_for_albums() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: albums; Type: TABLE; Schema: pex; Owner: postgres
--

CREATE TABLE pex.albums (
    id integer NOT NULL,
    title text,
    artist_id integer NOT NULL
);


ALTER TABLE pex.albums OWNER TO postgres;

--
-- Name: albums_id_seq; Type: SEQUENCE; Schema: pex; Owner: postgres
--

CREATE SEQUENCE pex.albums_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pex.albums_id_seq OWNER TO postgres;

--
-- Name: albums_id_seq; Type: SEQUENCE OWNED BY; Schema: pex; Owner: postgres
--

ALTER SEQUENCE pex.albums_id_seq OWNED BY pex.albums.id;


--
-- Name: artists; Type: TABLE; Schema: pex; Owner: postgres
--

CREATE TABLE pex.artists (
    id integer NOT NULL,
    org_id integer,
    first_name character varying(50) NOT NULL,
    last_name character varying(50) NOT NULL
);


ALTER TABLE pex.artists OWNER TO postgres;

--
-- Name: artists_id_seq; Type: SEQUENCE; Schema: pex; Owner: postgres
--

CREATE SEQUENCE pex.artists_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pex.artists_id_seq OWNER TO postgres;

--
-- Name: artists_id_seq; Type: SEQUENCE OWNED BY; Schema: pex; Owner: postgres
--

ALTER SEQUENCE pex.artists_id_seq OWNED BY pex.artists.id;


--
-- Name: audit_albums; Type: TABLE; Schema: pex; Owner: postgres
--

CREATE TABLE pex.audit_albums (
    curr_artist_id integer,
    username character varying(50),
    entry_date timestamp without time zone,
    title text,
    old_artist_id integer
);


ALTER TABLE pex.audit_albums OWNER TO postgres;

--
-- Name: genres; Type: TABLE; Schema: pex; Owner: postgres
--

CREATE TABLE pex.genres (
    id integer NOT NULL,
    name text
);


ALTER TABLE pex.genres OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE; Schema: pex; Owner: postgres
--

CREATE SEQUENCE pex.genre_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pex.genre_id_seq OWNER TO postgres;

--
-- Name: genre_id_seq; Type: SEQUENCE OWNED BY; Schema: pex; Owner: postgres
--

ALTER SEQUENCE pex.genre_id_seq OWNED BY pex.genres.id;


--
-- Name: organization; Type: TABLE; Schema: pex; Owner: postgres
--

CREATE TABLE pex.organization (
    id integer NOT NULL,
    name text
);


ALTER TABLE pex.organization OWNER TO postgres;

--
-- Name: organization_id_seq; Type: SEQUENCE; Schema: pex; Owner: postgres
--

CREATE SEQUENCE pex.organization_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pex.organization_id_seq OWNER TO postgres;

--
-- Name: organization_id_seq; Type: SEQUENCE OWNED BY; Schema: pex; Owner: postgres
--

ALTER SEQUENCE pex.organization_id_seq OWNED BY pex.organization.id;


--
-- Name: tracks; Type: TABLE; Schema: pex; Owner: postgres
--

CREATE TABLE pex.tracks (
    id integer NOT NULL,
    album_id integer NOT NULL,
    genre_id integer NOT NULL,
    title text NOT NULL,
    len integer
);


ALTER TABLE pex.tracks OWNER TO postgres;

--
-- Name: tracks_id_seq; Type: SEQUENCE; Schema: pex; Owner: postgres
--

CREATE SEQUENCE pex.tracks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pex.tracks_id_seq OWNER TO postgres;

--
-- Name: tracks_id_seq; Type: SEQUENCE OWNED BY; Schema: pex; Owner: postgres
--

ALTER SEQUENCE pex.tracks_id_seq OWNED BY pex.tracks.id;


--
-- Name: users; Type: TABLE; Schema: pex; Owner: postgres
--

CREATE TABLE pex.users (
    id integer NOT NULL,
    username character varying(50),
    with_admin_priv boolean DEFAULT false NOT NULL,
    with_write_priv boolean DEFAULT false NOT NULL,
    with_read_priv boolean DEFAULT false NOT NULL
);


ALTER TABLE pex.users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: pex; Owner: postgres
--

CREATE SEQUENCE pex.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE pex.users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: pex; Owner: postgres
--

ALTER SEQUENCE pex.users_id_seq OWNED BY pex.users.id;


--
-- Name: albums id; Type: DEFAULT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.albums ALTER COLUMN id SET DEFAULT nextval('pex.albums_id_seq'::regclass);


--
-- Name: artists id; Type: DEFAULT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.artists ALTER COLUMN id SET DEFAULT nextval('pex.artists_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.genres ALTER COLUMN id SET DEFAULT nextval('pex.genre_id_seq'::regclass);


--
-- Name: organization id; Type: DEFAULT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.organization ALTER COLUMN id SET DEFAULT nextval('pex.organization_id_seq'::regclass);


--
-- Name: tracks id; Type: DEFAULT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.tracks ALTER COLUMN id SET DEFAULT nextval('pex.tracks_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.users ALTER COLUMN id SET DEFAULT nextval('pex.users_id_seq'::regclass);


--
-- Data for Name: albums; Type: TABLE DATA; Schema: pex; Owner: postgres
--

COPY pex.albums (id, title, artist_id) FROM stdin;
3	Cholote	1
1	The First Album	1
\.


--
-- Data for Name: artists; Type: TABLE DATA; Schema: pex; Owner: postgres
--

COPY pex.artists (id, org_id, first_name, last_name) FROM stdin;
1	1	Lara	Rexny
3	2	Kenny	Cess
\.


--
-- Data for Name: audit_albums; Type: TABLE DATA; Schema: pex; Owner: postgres
--

COPY pex.audit_albums (curr_artist_id, username, entry_date, title, old_artist_id) FROM stdin;
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: pex; Owner: postgres
--

COPY pex.genres (id, name) FROM stdin;
1	pop
2	rock
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: pex; Owner: postgres
--

COPY pex.organization (id, name) FROM stdin;
1	music pro
2	haxton
\.


--
-- Data for Name: tracks; Type: TABLE DATA; Schema: pex; Owner: postgres
--

COPY pex.tracks (id, album_id, genre_id, title, len) FROM stdin;
2	1	1	fist track	74328
5	3	2	the sec	83274
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: pex; Owner: postgres
--

COPY pex.users (id, username, with_admin_priv, with_write_priv, with_read_priv) FROM stdin;
1	read_user	f	f	t
2	write_user	f	t	f
3	admin_user	t	f	f
\.


--
-- Name: albums_id_seq; Type: SEQUENCE SET; Schema: pex; Owner: postgres
--

SELECT pg_catalog.setval('pex.albums_id_seq', 3, true);


--
-- Name: artists_id_seq; Type: SEQUENCE SET; Schema: pex; Owner: postgres
--

SELECT pg_catalog.setval('pex.artists_id_seq', 3, true);


--
-- Name: genre_id_seq; Type: SEQUENCE SET; Schema: pex; Owner: postgres
--

SELECT pg_catalog.setval('pex.genre_id_seq', 2, true);


--
-- Name: organization_id_seq; Type: SEQUENCE SET; Schema: pex; Owner: postgres
--

SELECT pg_catalog.setval('pex.organization_id_seq', 2, true);


--
-- Name: tracks_id_seq; Type: SEQUENCE SET; Schema: pex; Owner: postgres
--

SELECT pg_catalog.setval('pex.tracks_id_seq', 5, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: pex; Owner: postgres
--

SELECT pg_catalog.setval('pex.users_id_seq', 3, true);


--
-- Name: albums albums_pkey; Type: CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.albums
    ADD CONSTRAINT albums_pkey PRIMARY KEY (id);


--
-- Name: artists artists_pkey; Type: CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.artists
    ADD CONSTRAINT artists_pkey PRIMARY KEY (id);


--
-- Name: genres genre_pkey; Type: CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.genres
    ADD CONSTRAINT genre_pkey PRIMARY KEY (id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: tracks tracks_pkey; Type: CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.tracks
    ADD CONSTRAINT tracks_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: albums_title_idx; Type: INDEX; Schema: pex; Owner: postgres
--

CREATE UNIQUE INDEX albums_title_idx ON pex.albums USING btree (title);


--
-- Name: artists_first_name_last_name_idx; Type: INDEX; Schema: pex; Owner: postgres
--

CREATE UNIQUE INDEX artists_first_name_last_name_idx ON pex.artists USING btree (first_name, last_name);


--
-- Name: genre_name_idx; Type: INDEX; Schema: pex; Owner: postgres
--

CREATE UNIQUE INDEX genre_name_idx ON pex.genres USING btree (name);


--
-- Name: users_username_idx; Type: INDEX; Schema: pex; Owner: postgres
--

CREATE UNIQUE INDEX users_username_idx ON pex.users USING btree (username);


--
-- Name: albums trg_albums; Type: TRIGGER; Schema: pex; Owner: postgres
--

CREATE TRIGGER trg_albums BEFORE UPDATE OF artist_id ON pex.albums FOR EACH ROW EXECUTE FUNCTION pex.audit_for_albums();


--
-- Name: albums fk_albums_artists_id; Type: FK CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.albums
    ADD CONSTRAINT fk_albums_artists_id FOREIGN KEY (artist_id) REFERENCES pex.artists(id);


--
-- Name: artists fk_artist_org_id; Type: FK CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.artists
    ADD CONSTRAINT fk_artist_org_id FOREIGN KEY (org_id) REFERENCES pex.organization(id);


--
-- Name: tracks fk_tracks_album_id; Type: FK CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.tracks
    ADD CONSTRAINT fk_tracks_album_id FOREIGN KEY (album_id) REFERENCES pex.albums(id);


--
-- Name: tracks fk_tracks_genre_id; Type: FK CONSTRAINT; Schema: pex; Owner: postgres
--

ALTER TABLE ONLY pex.tracks
    ADD CONSTRAINT fk_tracks_genre_id FOREIGN KEY (genre_id) REFERENCES pex.genres(id);


--
-- Name: SCHEMA pex; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA pex TO read_user;
GRANT USAGE ON SCHEMA pex TO write_user;
GRANT USAGE ON SCHEMA pex TO admin_user;


--
-- Name: TABLE albums; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT ON TABLE pex.albums TO read_user;
GRANT INSERT,DELETE,UPDATE ON TABLE pex.albums TO write_user;
GRANT ALL ON TABLE pex.albums TO admin_user;


--
-- Name: SEQUENCE albums_id_seq; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE pex.albums_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE pex.albums_id_seq TO write_user;
GRANT SELECT,USAGE ON SEQUENCE pex.albums_id_seq TO admin_user;


--
-- Name: TABLE artists; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT ON TABLE pex.artists TO read_user;
GRANT INSERT,DELETE,UPDATE ON TABLE pex.artists TO write_user;
GRANT ALL ON TABLE pex.artists TO admin_user;


--
-- Name: SEQUENCE artists_id_seq; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE pex.artists_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE pex.artists_id_seq TO write_user;
GRANT SELECT,USAGE ON SEQUENCE pex.artists_id_seq TO admin_user;


--
-- Name: TABLE audit_albums; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT ON TABLE pex.audit_albums TO read_user;
GRANT INSERT,DELETE,UPDATE ON TABLE pex.audit_albums TO write_user;
GRANT ALL ON TABLE pex.audit_albums TO admin_user;


--
-- Name: TABLE genres; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT ON TABLE pex.genres TO read_user;
GRANT INSERT,DELETE,UPDATE ON TABLE pex.genres TO write_user;
GRANT ALL ON TABLE pex.genres TO admin_user;


--
-- Name: SEQUENCE genre_id_seq; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE pex.genre_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE pex.genre_id_seq TO write_user;
GRANT SELECT,USAGE ON SEQUENCE pex.genre_id_seq TO admin_user;


--
-- Name: TABLE organization; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT ON TABLE pex.organization TO read_user;
GRANT INSERT,DELETE,UPDATE ON TABLE pex.organization TO write_user;
GRANT ALL ON TABLE pex.organization TO admin_user;


--
-- Name: SEQUENCE organization_id_seq; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE pex.organization_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE pex.organization_id_seq TO write_user;
GRANT SELECT,USAGE ON SEQUENCE pex.organization_id_seq TO admin_user;


--
-- Name: TABLE tracks; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT ON TABLE pex.tracks TO read_user;
GRANT INSERT,DELETE,UPDATE ON TABLE pex.tracks TO write_user;
GRANT ALL ON TABLE pex.tracks TO admin_user;


--
-- Name: SEQUENCE tracks_id_seq; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE pex.tracks_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE pex.tracks_id_seq TO write_user;
GRANT SELECT,USAGE ON SEQUENCE pex.tracks_id_seq TO admin_user;


--
-- Name: TABLE users; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT ON TABLE pex.users TO read_user;
GRANT INSERT,DELETE,UPDATE ON TABLE pex.users TO write_user;
GRANT ALL ON TABLE pex.users TO admin_user;


--
-- Name: SEQUENCE users_id_seq; Type: ACL; Schema: pex; Owner: postgres
--

GRANT SELECT,USAGE ON SEQUENCE pex.users_id_seq TO read_user;
GRANT SELECT,USAGE ON SEQUENCE pex.users_id_seq TO write_user;
GRANT SELECT,USAGE ON SEQUENCE pex.users_id_seq TO admin_user;


--
-- PostgreSQL database dump complete
--

