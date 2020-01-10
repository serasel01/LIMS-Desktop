--
-- PostgreSQL database dump
--

-- Dumped from database version 11.5
-- Dumped by pg_dump version 11.5

-- Started on 2020-01-10 19:11:49

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

DROP DATABASE db_inventory;
--
-- TOC entry 2832 (class 1262 OID 16393)
-- Name: db_inventory; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE db_inventory WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'English_United States.1252' LC_CTYPE = 'English_United States.1252';


ALTER DATABASE db_inventory OWNER TO postgres;

\connect db_inventory

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
-- TOC entry 200 (class 1255 OID 16409)
-- Name: scan_update(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.scan_update() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
 
DECLARE
data json;
notification json;
 
BEGIN
 
-- Convert the old or new row to JSON, based on the kind of action.
-- Action = DELETE? -&gt; OLD row
-- Action = INSERT or UPDATE? -&gt; NEW row
IF (TG_OP = 'DELETE') THEN
data = row_to_json(OLD);
ELSE
data = row_to_json(NEW);
END IF;
 
-- Contruct the notification as a JSON string.
notification = json_build_object(
'table',TG_TABLE_NAME,
'action', TG_OP,
'data', data);
 
-- Execute pg_notify(channel, notification)
PERFORM pg_notify('q_event',notification::text);
 
-- Result is ignored since this is an AFTER trigger
RETURN NULL;
END;
 
$$;


ALTER FUNCTION public.scan_update() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 199 (class 1259 OID 24615)
-- Name: tbl_admin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_admin (
    id integer,
    password character varying(36)
);


ALTER TABLE public.tbl_admin OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16399)
-- Name: tbl_barcode; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_barcode (
    barcode character varying(25) NOT NULL,
    book_id integer NOT NULL,
    is_scanned character varying(10),
    "timestamp" timestamp without time zone
);


ALTER TABLE public.tbl_barcode OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16394)
-- Name: tbl_inventory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_inventory (
    title character varying(200) NOT NULL,
    section character varying(30) NOT NULL,
    id integer NOT NULL,
    total_no character varying(10),
    no_scanned character varying(10),
    call_no character varying(50),
    "timestamp" timestamp without time zone
);


ALTER TABLE public.tbl_inventory OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 24603)
-- Name: tbl_users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tbl_users (
    id integer NOT NULL,
    password character varying(40),
    online_status character varying(1),
    permission character varying(1),
    name character varying(100)
);


ALTER TABLE public.tbl_users OWNER TO postgres;

--
-- TOC entry 2826 (class 0 OID 24615)
-- Dependencies: 199
-- Data for Name: tbl_admin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_admin (id, password) VALUES (150483, '364248f3b2dfc70830871d0626514e4a');


--
-- TOC entry 2824 (class 0 OID 16399)
-- Dependencies: 197
-- Data for Name: tbl_barcode; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  000722187', 10, '1', '2020-01-09 15:49:55.618147');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  000909218', 9, '1', '2020-01-09 15:54:37.268283');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  00096552E', 6, '1', '2020-01-09 16:05:07.146946');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4ASRC000046229', 2, '0', '2020-01-08 03:52:44.398729');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  000701252', 373968, '0', '2020-01-08 12:59:15.273817');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4ASRC000041606', 3, '0', '2020-01-08 15:23:26.600363');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4ASRC000052406', 5, '0', '2020-01-08 15:23:41.093346');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  001022642', 4, '1', '2020-01-09 15:40:26.264091');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  000671315', 7, '1', '2020-01-09 15:40:49.561355');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  000566307', 8, '1', '2020-01-09 15:41:01.814848');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  00103017%', 11, '1', '2020-01-09 15:48:27.869163');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  000617001', 12, '1', '2020-01-09 15:48:42.661255');
INSERT INTO public.tbl_barcode (barcode, book_id, is_scanned, "timestamp") VALUES ('4CO  00097603C', 1, '1', '2020-01-09 15:48:53.179518');


--
-- TOC entry 2823 (class 0 OID 16394)
-- Dependencies: 196
-- Data for Name: tbl_inventory; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('The Presidency \by Christine Taylor-Butler', 'American Corner', 2, '1', '0', 'AS JK 517 .T39 2008', '2020-01-08 03:52:42.90569');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Basic Television and Video Systems \Sixth Edition \by Grob and Herndon', 'Circulation', 373968, '1', '0', 'CO-MC TK 6630 G76 1999', '2020-01-08 12:59:15.196888');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Hatchet \by Gary Paulsen', 'American Corner', 3, '1', '0', 'AS-F PZ 7.P38 H38 1987', '2020-01-08 15:23:26.540641');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Getting Started with Engineering \Think Like an Engineer! \by Camille McCue, PhD', 'American Corner', 5, '1', '0', 'AS-R TA 145 .M34 2016', '2020-01-08 15:23:41.08584');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Merriam-Webster Chinese-English Dictionary', 'Reference', 4, '1', '1', 'CO-R PL 1455 .M47 2010', '2020-01-09 15:40:26.185968');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('the BIBLE: Questions People Ask Vol. 2 \by Ariel Alvarez Valdes', 'Reference', 7, '1', '1', 'CO-R BS 1231 V34 2005v.2', '2020-01-09 15:40:49.513741');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('DOs & DONTs in Thailand', 'Reference', 8, '1', '1', 'CO-R DS 563.5 Y43 1999', '2020-01-09 15:41:01.809613');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('The First Phone Call from Heaven \a Novel \by Mitch Albom', 'Circulation', 11, '1', '1', 'CO-F PS 3601.L335 F57 2014', '2020-01-09 15:48:27.852921');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Flight Path \How to Get the Job That Launches Your Career After College \by Neil C. Kalt, PhD and William B. Helmreich, PhD', 'Circulation', 12, '1', '1', 'CO HF 5382.75.U6 K34 1989', '2020-01-09 15:48:42.648378');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Learning Python with Raspberry Pi \by Alex Bradbury and Ben Everard', 'Circulation', 1, '1', '1', 'CO QA 76.73.P98 B73 2014', '2020-01-09 15:48:53.166359');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Manual for Call Center Agents \by Teresita A. Aureus and Cecilia A. Suarez', 'Filipiniana', 10, '1', '1', 'CO-FI-R HE 8788 A97 2005', '2020-01-09 15:49:55.606293');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Pareng Barack \Filipinos in Obamas America \by Benjamin Pimentel', 'Filipiniana', 9, '1', '1', 'CO-FI E 901.1 P56 2008', '2020-01-09 15:54:37.228599');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('modules in administrative office by margarita r. saidali', 'Circulation', 253129, '1', '1', 'CO-FI HF 5547 S25 2012c2', '2020-01-09 16:04:32.485679');
INSERT INTO public.tbl_inventory (title, section, id, total_no, no_scanned, call_no, "timestamp") VALUES ('Modules in Administrative Office Management \by Margarita R. Saidali, DEM, DBA', 'Filipiniana', 6, '1', '1', 'CO-FI HF 5547 S25 2012', '2020-01-09 16:05:07.130579');


--
-- TOC entry 2825 (class 0 OID 24603)
-- Dependencies: 198
-- Data for Name: tbl_users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.tbl_users (id, password, online_status, permission, name) VALUES (150123, 'c44a471bd78cc6c2fea32b9fe028d30a', '1', '0', 'Name');
INSERT INTO public.tbl_users (id, password, online_status, permission, name) VALUES (130189, 'd8578edf8458ce06fbc5bb76a58c5ca4', '1', '0', 'Jojo');
INSERT INTO public.tbl_users (id, password, online_status, permission, name) VALUES (199999, '7f64bef9976362d093fe605585580e2e', '1', '1', 'Riri');


--
-- TOC entry 2697 (class 2606 OID 16403)
-- Name: tbl_barcode tbl_barcode_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_barcode
    ADD CONSTRAINT tbl_barcode_pkey PRIMARY KEY (barcode);


--
-- TOC entry 2699 (class 2606 OID 24607)
-- Name: tbl_users tbl_users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tbl_users
    ADD CONSTRAINT tbl_users_pkey PRIMARY KEY (id);


--
-- TOC entry 2700 (class 2620 OID 16410)
-- Name: tbl_inventory scan_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scan_update AFTER UPDATE ON public.tbl_inventory FOR EACH ROW EXECUTE PROCEDURE public.scan_update();


--
-- TOC entry 2701 (class 2620 OID 24608)
-- Name: tbl_users scan_update; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER scan_update AFTER UPDATE ON public.tbl_users FOR EACH ROW EXECUTE PROCEDURE public.scan_update();


-- Completed on 2020-01-10 19:11:51

--
-- PostgreSQL database dump complete
--

