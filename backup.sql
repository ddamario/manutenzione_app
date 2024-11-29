--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO postgres;

--
-- Name: interventi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.interventi (
    id integer NOT NULL,
    macchina character varying(100) NOT NULL,
    "priorità" character varying(50),
    stato character varying(50) DEFAULT 'In attesa'::character varying,
    manutentore_id integer,
    tipo_intervento character varying(50),
    descrizione text,
    data_richiesta timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    nome_manutentore character varying(255),
    data_creazione timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.interventi OWNER TO postgres;

--
-- Name: interventi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.interventi_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.interventi_id_seq OWNER TO postgres;

--
-- Name: interventi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.interventi_id_seq OWNED BY public.interventi.id;


--
-- Name: manutentori; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.manutentori (
    id integer NOT NULL,
    nome character varying(100) NOT NULL,
    email character varying(100)
);


ALTER TABLE public.manutentori OWNER TO postgres;

--
-- Name: manutentori_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.manutentori_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.manutentori_id_seq OWNER TO postgres;

--
-- Name: manutentori_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.manutentori_id_seq OWNED BY public.manutentori.id;


--
-- Name: rapporti_intervento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rapporti_intervento (
    id integer NOT NULL,
    intervento_id integer,
    manutentore_id integer,
    descrizione text NOT NULL,
    data_compilazione timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    tempo_intervento interval,
    nome_manutentore character varying(100),
    materiali_utilizzati text,
    macchina character varying(100),
    note text,
    costo_ricambi numeric(10,2),
    causa_del_problema text,
    problema_segnalato text,
    azienda character varying(255),
    ripristino_condizioni_di_pulizia text,
    codice_interno text,
    risoluzione_problema text
);


ALTER TABLE public.rapporti_intervento OWNER TO postgres;

--
-- Name: rapporti_intervento_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.rapporti_intervento_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rapporti_intervento_id_seq OWNER TO postgres;

--
-- Name: rapporti_intervento_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.rapporti_intervento_id_seq OWNED BY public.rapporti_intervento.id;


--
-- Name: interventi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventi ALTER COLUMN id SET DEFAULT nextval('public.interventi_id_seq'::regclass);


--
-- Name: manutentori id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manutentori ALTER COLUMN id SET DEFAULT nextval('public.manutentori_id_seq'::regclass);


--
-- Name: rapporti_intervento id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rapporti_intervento ALTER COLUMN id SET DEFAULT nextval('public.rapporti_intervento_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.alembic_version (version_num) FROM stdin;
\.


--
-- Data for Name: interventi; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.interventi (id, macchina, "priorità", stato, manutentore_id, tipo_intervento, descrizione, data_richiesta, nome_manutentore, data_creazione) FROM stdin;
10	Astucciatrice 2	Alta	In corso	3	Elettrico	Non parte	2024-11-15 09:27:47.43836	\N	2024-11-26 14:28:25.899583
11	Astucciatrice 2	Alta	In corso	3	Elettrico	La macchina non parte	2024-11-15 09:40:41.491971	Luca Nardicchia	2024-11-26 14:28:25.899583
12	Bassina Grande	Alta	Completato	\N	Meccanico	Non spruzza	2024-11-15 09:59:49.647509	Giovanni Palantrani	2024-11-26 14:28:25.899583
13	Contapezzi	Alta	Completato	\N	Elettrico	Non conta	2024-11-15 10:05:18.131266	Dylan D'Amario	2024-11-26 14:28:25.899583
14	Inflaconatrice	Alta	Completato	\N	Meccanico	Guasto cinghia	2024-11-18 16:44:06.133598	Giovanni Palantrani	2024-11-26 14:28:25.899583
15	Astucciatrice	Alta	Completato	\N	Meccanico	none	2024-11-18 16:49:41.688495	Dylan D'Amario	2024-11-26 14:28:25.899583
16	Astucciatrice	Alta	Completato	\N	Meccanico	none	2024-11-18 17:03:54.644358	Luca Nardicchia	2024-11-26 14:28:25.899583
17	Astucciatrice	Alta	Completato	\N	Meccanico	none	2024-11-18 17:14:13.609426	Giovanni Palantrani	2024-11-26 14:28:25.899583
18	Bassina Grande	Alta	Completato	\N	Meccanico	none	2024-11-18 17:21:53.869168	Giovanni Palantrani	2024-11-26 14:28:25.899583
19	lllllllllllllll	Media	Completato	\N	Elettrico	none	2024-11-18 17:24:47.930273	Dylan D'Amario	2024-11-26 14:28:25.899583
21	Bassina Grande	Alta	Completato	\N	Elettrico	none	2024-11-20 11:51:07.650936	Dylan D'Amario	2024-11-26 14:28:25.899583
20	Astucciatrice	Media	Completato	\N	Meccanico	none	2024-11-18 17:41:10.298263	Giovanni Palantrani	2024-11-26 14:28:25.899583
22	Kilian	Alta	Completato	\N	Elettrico	guasto inverter	2024-11-20 11:54:46.358361	Dylan D'Amario	2024-11-26 14:28:25.899583
23	Linea Caramelle	Alta	Completato	\N	Elettrico	Problema pesata	2024-11-20 12:02:05.165134	Dylan D'Amario	2024-11-26 14:28:25.899583
24	Astucciatrice	Bassa	Completato	\N	Meccanico	sostituzione cinghia	2024-11-20 12:04:59.081756	Luca Nardicchia	2024-11-26 14:28:25.899583
25	@@@@@@@@@@@@@	Alta	Completato	\N	Meccanico	@@@@@@@@@@@@@@	2024-11-20 12:12:31.234304	Giovanni Palantrani	2024-11-26 14:28:25.899583
27	lllllllllllllll	Bassa	Completato	\N	Meccanico	3333333333333333333	2024-11-20 12:32:56.482246		2024-11-26 14:28:25.899583
26	Astucciatrice 2	Media	Completato	\N	Meccanico	2222222222	2024-11-20 12:13:40.033454		2024-11-26 14:28:25.899583
28	Bustine Singola	Alta	Completato	\N	Elettrico	Guasta resistenza piastra 2A	2024-11-21 09:15:59.966355	Dylan D’Amario	2024-11-26 14:28:25.899583
29	Cccccc	Alta	Completato	\N	Elettrico	Sassasa	2024-11-21 10:20:21.847367	Dylan 	2024-11-26 14:28:25.899583
1	Bustine Singola	Media	Completato	2	Elettrico	Guasto sonda piastra	2024-11-13 15:19:06.034072	\N	2024-11-26 14:28:25.899583
2	Bustina Gemellare	Alta	Completato	1	Meccanico	Guasto Camma fase saldatura	2024-11-13 15:27:14.691046	\N	2024-11-26 14:28:25.899583
7	Bassina Grande	Media	Completato	1	Meccanico	SOS	2024-11-14 11:34:13.00229	\N	2024-11-26 14:28:25.899583
6	Astucciatrice	Alta	Completato	1	Elettrico	sos	2024-11-14 09:40:38.300954	\N	2024-11-26 14:28:25.899583
4	Comprimitrice	Bassa	Completato	1	Meccanico	Sostituire cartuccia filtro olio, sostituire olio motore	2024-11-14 09:24:15.689358	\N	2024-11-26 14:28:25.899583
30	Bustina singola	Alta	Completato	\N	Meccanico	Guasto sonda	2024-11-22 15:06:00.489493	Gianni Palantrani	2024-11-26 14:28:25.899583
5	Astucciatrice	Media	Completato	1	Elettrico	Guasto motore principale	2024-11-14 09:28:46.785479	\N	2024-11-26 14:28:25.899583
8	Comprimitrice Kilian	Alta	Completato	1	Elettrico	Guasto Inverter	2024-11-14 12:04:05.922611	\N	2024-11-26 14:28:25.899583
3	Partena 3	Alta	Completato	2	Elettrico	Guasto sonda piastra saldante	2024-11-14 08:58:29.16981	\N	2024-11-26 14:28:25.899583
9	Comprimitrice Kilian	Alta	Completato	1	Meccanico	Problema lubrificazione 	2024-11-15 08:54:41.935963	\N	2024-11-26 14:28:25.899583
31	Aaaaaa	Alta	Completato	\N	Meccanico	Aaaaaaa	2024-11-25 12:15:08.885428	Dylan	2024-11-26 14:28:25.899583
33	Astucciatrice	Alta	Completato	\N	Meccanico	llllllllll	2024-11-25 15:36:14.205423	Dylan D'Amario	2024-11-26 14:28:25.899583
32	Astucciatrice	Alta	Completato	\N	Meccanico	aaaa	2024-11-25 15:14:33.999241	Giovanni Palantrani	2024-11-26 14:28:25.899583
34	Astucciatrice	Alta	Completato	\N	Meccanico	aaaaaaaa	2024-11-26 11:33:14.852359	aaaaaaaaaaaaaa	2024-11-26 14:28:25.899583
35	Bassina Grande	Alta	Completato	\N	Meccanico	guasto	2024-11-26 14:18:55.450553	Dylan D'Amario	2024-11-26 14:28:25.899583
36	Comprimitrice	Alta	Completato	\N	Meccanico	cinghia	2024-11-26 14:30:55.866255	Giovanni Palantrani	2024-11-26 14:30:55.866255
37	Bassina Grande	Alta	Completato	\N	Meccanico	Non aspira	2024-11-27 09:28:22.594211	Dylan D’Amario	2024-11-27 09:28:22.594211
38	Astucciatrice 2	Alta	Completato	\N	Elettrico	La macchina non parte	2024-11-27 10:10:02.469579	Luca Nardicchia	2024-11-27 10:10:02.469579
39	Bassina Grande	Alta	Completato	\N	Elettrico	aaaasssssss	2024-11-27 11:18:56.205256	Luca Nardicchia	2024-11-27 11:18:56.205256
40	Astucciatrice	Alta	Completato	\N	Meccanico	aa	2024-11-27 11:26:03.803465	Dylan D'Amario	2024-11-27 11:26:03.803465
41	Astucciatrice 2	Alta	Completato	\N	Meccanico	a	2024-11-27 11:28:57.829657	Giovanni Palantrani	2024-11-27 11:28:57.829657
42	Bassina Grande	Alta	Completato	\N	Meccanico	a	2024-11-27 11:29:54.607012	Dylan D'Amario	2024-11-27 11:29:54.607012
43	Astucciatrice	Media	Completato	\N	Elettrico	l	2024-11-27 11:39:11.664649	Luca Nardicchia	2024-11-27 11:39:11.664649
44	Comprimitrice Kilian	Alta	Completato	\N	Meccanico	sd	2024-11-27 11:50:09.259608	Giovanni Palantrani	2024-11-27 11:50:09.259608
45	Astucciatrice	Alta	Completato	\N	Meccanico	as	2024-11-27 11:53:44.696783	Luca Nardicchia	2024-11-27 11:53:44.696783
46	Astucciatrice	Alta	Completato	\N	Meccanico	as	2024-11-27 11:55:11.276506	Giovanni Palantrani	2024-11-27 11:55:11.276506
47	Astucciatrice	Alta	Completato	\N	Meccanico	ll	2024-11-27 11:56:44.492585	Giovanni Palantrani	2024-11-27 11:56:44.492585
48	Astucciatrice	Alta	Completato	\N	Meccanico	aa	2024-11-27 12:05:20.72982	Giovanni Palantrani	2024-11-27 12:05:20.72982
49	Bassina Grande	Media	Completato	\N	Meccanico	ll	2024-11-27 12:14:35.702058		2024-11-27 12:14:35.702058
50	Astucciatrice	Alta	Completato	\N	Meccanico	aa	2024-11-27 13:55:39.390855	Giovanni Palantrani	2024-11-27 13:55:39.390855
51	Astucciatrice	Alta	Completato	\N	Elettrico	aa	2024-11-27 14:02:38.851664	Dylan D'Amario	2024-11-27 14:02:38.851664
52	Bassina Grande	Media	Completato	\N	Meccanico	aaaaaa	2024-11-27 14:07:56.85199	Giovanni Palantrani	2024-11-27 14:07:56.85199
53	Astucciatrice	Media	Completato	\N	Meccanico	aaaaaa	2024-11-27 14:12:57.800754	aaaaaaa	2024-11-27 14:12:57.800754
54	Astucciatrice	Alta	Completato	\N	Meccanico	aaaa	2024-11-28 09:03:07.787801	Dylan D'Amario	2024-11-28 09:03:07.787801
55	Comprimitrice Kilian	Alta	Completato	\N	Elettrico	aaaaaaa	2024-11-28 09:11:27.30679	Luca Nardicchia	2024-11-28 09:11:27.30679
56	Bassina Grande	Alta	Completato	\N	Elettrico	mmmmmmmmmm	2024-11-28 09:14:27.463012	Luca Nardicchia	2024-11-28 09:14:27.463012
57	Bassina Grande	Alta	Completato	\N	Meccanico	mmmmmmm	2024-11-28 09:15:20.815989	Luca Nardicchia	2024-11-28 09:15:20.815989
58	Astucciatrice	Alta	Completato	\N	Meccanico	aaaaaaaa	2024-11-28 09:17:26.62963	Luca Nardicchia	2024-11-28 09:17:26.62963
59	Astucciatrice	Alta	Completato	\N	Meccanico	aaaaaaa	2024-11-28 09:18:54.803315	Luca Nardicchia	2024-11-28 09:18:54.803315
60	Bassina Grande	Alta	Completato	\N	Meccanico	aaaaa	2024-11-28 09:24:36.541948	Dylan D'Amario	2024-11-28 09:24:36.541948
61	Astucciatrice	Alta	Completato	\N	Meccanico	aaaaa	2024-11-28 09:27:02.981882	Dylan D'Amario	2024-11-28 09:27:02.981882
62	Astucciatrice	Alta	Completato	\N	Elettrico	aaaaaaaa	2024-11-28 09:28:54.008008	Dylan D'Amario	2024-11-28 09:28:54.008008
63	Astucciatrice	Alta	Completato	\N	Meccanico	asaddd	2024-11-28 09:31:10.949929	Dylan D'Amario	2024-11-28 09:31:10.949929
64	Astucciatrice	Alta	Completato	\N	Meccanico	ddddddddd	2024-11-28 09:36:21.309237	Dylan D'Amario	2024-11-28 09:36:21.309237
76	Astucciatrice	Alta	Completato	\N	Meccanico	Aaaaaa	2024-11-28 15:46:27.232979	Gianni Palantrani	2024-11-28 15:46:27.232979
65	Astucciatrice	Alta	Completato	\N	Meccanico	sssss	2024-11-28 09:59:30.544697	Dylan D'Amario	2024-11-28 09:59:30.544697
66	Astucciatrice	Alta	Completato	\N	Meccanico	ssssss	2024-11-28 10:19:51.696155	Luca Nardicchia	2024-11-28 10:19:51.696155
77	Astucciatrice	Alta	Completato	\N	Elettrico	uuuuuuu	2024-11-28 15:51:51.198758	Dylan D'Amario	2024-11-28 15:51:51.198758
67	Astucciatrice 2	Alta	Completato	\N	Meccanico	eeeee	2024-11-28 10:25:21.202359	Dylan D'Amario	2024-11-28 10:25:21.202359
68	Astucciatrice	Alta	Completato	\N	Meccanico	aaaa	2024-11-28 14:18:23.44758	Dylan D'Amario	2024-11-28 14:18:23.44758
69	Aaaaaa	Alta	Completato	\N	Meccanico	Sassaa	2024-11-28 14:19:29.482924	Dylan	2024-11-28 14:19:29.482924
70	Astucciatrice	Alta	Completato	\N	Meccanico	aaaaa	2024-11-28 14:38:24.020404	Giovanni Palantrani	2024-11-28 14:38:24.020404
75	Astucciatrice	Alta	Completato	\N	Meccanico	aaa	2024-11-28 15:45:54.44552	Dylan D'Amario	2024-11-28 15:45:54.44552
71	Blisteratrice	Alta	Completato	\N	Meccanico	Aaaaaa	2024-11-28 14:40:09.892384	Luca Nardicchia	2024-11-28 14:40:09.892384
72	Imbustatrice	Alta	Completato	\N	Elettrico	Guasto sonda	2024-11-28 15:07:22.869169	Luca Nardicchia	2024-11-28 15:07:22.869169
74	Nardicchia	Media	Completato	\N	Elettrico	Nardicchia	2024-11-28 15:10:49.91731	Luca Nardicchia	2024-11-28 15:10:49.91731
73	Bassina Grande	Media	Completato	\N	Elettrico	Nardicchia	2024-11-28 15:08:37.694758	Giovanni Palantrani	2024-11-28 15:08:37.694758
78	Opercolatrice	Alta	Completato	\N	Meccanico	Smontare piatto trasporto capsule	2024-11-28 16:06:41.930164	Giovanni Palantrani	2024-11-28 16:06:41.930164
79	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO.\r\n	2024-11-29 09:09:11.427506	Gianni Palantrani	2024-11-29 09:09:11.427506
80	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	Smontaggio ruota di trasporto capsule	2024-11-29 09:45:11.027006	Gianni Palantrani	2024-11-29 09:45:11.027006
81	Opercolatrice	Alta	Completato	\N	Meccanico	GUASTO	2024-11-29 09:55:53.745265	Gianni Palantrani	2024-11-29 09:55:53.745265
82	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	GUASTO 	2024-11-29 10:03:48.709305	Gianni Palantrani, Luca Nardicchia	2024-11-29 10:03:48.709305
83	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	GUASTO	2024-11-29 10:44:27.845348	Gianni Palantrani, Luca Nardicchia	2024-11-29 10:44:27.845348
84	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	Guasto	2024-11-29 10:55:06.945128	Gianni Palantrani, Luca Nardicchia	2024-11-29 10:55:06.945128
85	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	Guasto	2024-11-29 11:00:40.791656	Gianni Palantrani, Luca Nardicchia	2024-11-29 11:00:40.791656
86	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	GUASTO	2024-11-29 11:04:10.637589	Gianni Palantrani, Luca Nardicchia	2024-11-29 11:04:10.637589
87	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	Guasto 	2024-11-29 11:11:30.251678	Gianni Palantrani, Luca Nardicchia	2024-11-29 11:11:30.251678
88	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	Guasto	2024-11-29 11:23:12.993625	Gianni Palantrani, Luca Nardicchia	2024-11-29 11:23:12.993625
89	Opercolatrice Tipo "0"	Alta	Completato	\N	Meccanico	aaaaaaa	2024-11-29 11:29:21.206147	Gianni Palantrani, Luca Nardicchia	2024-11-29 11:29:21.206147
\.


--
-- Data for Name: manutentori; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.manutentori (id, nome, email) FROM stdin;
1	Dylan DAmario	d.damario@pnkfarmaceutici.com
2	Giovanni Palantrani	g.palantrani@pnkfarmaceutici.com
3	Luca Nardicchia	l.nardicchia@pnkfarmaceutici.com
\.


--
-- Data for Name: rapporti_intervento; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rapporti_intervento (id, intervento_id, manutentore_id, descrizione, data_compilazione, tempo_intervento, nome_manutentore, materiali_utilizzati, macchina, note, costo_ricambi, causa_del_problema, problema_segnalato, azienda, ripristino_condizioni_di_pulizia, codice_interno, risoluzione_problema) FROM stdin;
1	3	1	Sostituzione sonda piastra saldante	2024-11-14 08:59:58.197565	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
2	2	2	Sostituzione 	2024-11-14 09:20:58.834886	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
3	1	1	ciao	2024-11-14 09:21:32.242251	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
4	2	1	ciao	2024-11-14 09:21:36.672918	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
5	4	3	Sostituito filtro olio e olio motore	2024-11-14 09:25:01.696206	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
6	5	1	Sostituzione motore di trasmissione principale	2024-11-14 09:29:30.547571	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N
7	7	1	Guasto macchina	2024-11-14 15:19:58.046021	02:20:00	\N	Motore	Bustine	no.	\N	\N	\N	\N	\N	\N	\N
8	6	3	guasto sonda	2024-11-14 15:20:46.49922	02:30:00	\N	sonda pt100	bustina singola	no.	\N	\N	\N	\N	\N	\N	\N
9	4	\N	sostituzione cinghia di trasmissione	2024-11-14 15:29:28.959372	01:25:00	Dylan D'Amario	Cinghia	Comprimitrice	no	\N	\N	\N	\N	\N	\N	\N
10	3	\N	Sostituzione cinghia	2024-11-14 15:45:39.105832	02:40:00	Dylan D'Amario	Sonda pt100	Partena 3	no	\N	\N	\N	\N	\N	\N	\N
11	12	\N	Sostituzione tubi 	2024-11-15 10:00:51.43594	00:00:02	Giovanni Palantrani	Tubo Rilsan diametro 8	Bassina Grande		\N	\N	\N	\N	\N	\N	\N
12	13	\N	ciao	2024-11-15 11:37:55.32751	00:00:01	Dylan D'Amario	ciao	Contapezzi	no	\N	\N	\N	\N	\N	\N	\N
13	14	\N	Sostituzione cinghia	2024-11-18 16:46:58.463564	02:20:00	Giovanni Palantrani	-1 Cinghia	Inflaconatrice		\N	\N	\N	\N	\N	\N	\N
14	15	\N	none	2024-11-18 16:50:00.424086	02:20:00	Dylan D'Amario	none	Astucciatrice	none	\N	\N	\N	\N	\N	\N	\N
15	16	\N	none	2024-11-18 17:12:07.557546	02:20:00	Luca Nardicchia	none	Astucciatrice	none	\N	\N	\N	\N	\N	\N	\N
16	17	\N	none	2024-11-18 17:16:01.389484	02:20:00	Luca Nardicchia	none	Astucciatrice	none	\N	\N	\N	\N	\N	\N	\N
17	18	\N	none	2024-11-18 17:22:58.129557	02:20:00	Giovanni Palantrani	none	Bassina Grande	none	\N	\N	\N	\N	\N	\N	\N
18	19	\N	none	2024-11-18 17:40:57.469349	02:20:00	Dylan D'Amario	none	lllllllllllllll	none	\N	\N	\N	\N	\N	\N	\N
19	21	\N	none	2024-11-20 11:51:24.372947	02:20:00	Dylan D'Amario	none	Bassina Grande	none	\N	\N	\N	\N	\N	\N	\N
20	20	\N	non lo so	2024-11-20 11:53:15.076305	02:20:00	Dylan D'Amario	none	Astucciatrice	none	\N	\N	\N	\N	\N	\N	\N
21	22	\N	none	2024-11-20 11:55:06.16042	02:15:00	Dylan D'Amario	none	Kilian	none	\N	\N	\N	\N	\N	\N	\N
22	23	\N	Sostituzione cella di carico	2024-11-20 12:02:36.81009	00:00:04	Dylan D'Amario	-2 celle di carico	Linea Caramelle	none	\N	\N	\N	\N	\N	\N	\N
23	24	\N	sostituzione cinghia	2024-11-20 12:05:25.641096	04:00:00	Luca Nardicchia	none	Astucciatrice	none	\N	\N	\N	\N	\N	\N	\N
24	25	\N	@@@@@@@@@@@@	2024-11-20 12:13:00.282817	04:20:00	Giovanni Palantrani	@@@@@@@@@@ò	@@@@@@@@@@@@@	@@@@@@@@@@@@	\N	\N	\N	\N	\N	\N	\N
25	27	\N	0000000000000000000	2024-11-20 12:33:46.838226	02:20:00	000000000000000000	000000000000000000000000000	lllllllllllllll		\N	\N	\N	\N	\N	\N	\N
26	26	\N	sostituzione cinghia	2024-11-20 15:50:38.079736	04:00:00	Luca Nardicchia	-1 cinghia 	Astucciatrice 2	niente da aggiungere.	\N	\N	\N	\N	\N	\N	\N
27	28	\N	Sostituita resistenza piastra riscaldo 2A	2024-11-21 09:17:34.734833	01:00:00	Dylan D’Amario	-1 Resistenza 110V 250W	Bustine Singola	Niente da aggiungere 	\N	\N	\N	\N	\N	\N	\N
28	29	\N	Llllllll	2024-11-21 10:21:26.702238	00:00:02	Dylan 	Lllllll	Cccccc		\N	\N	\N	\N	\N	\N	\N
29	30	\N	Sostituzione cuscinetto	2024-11-22 15:06:47.205999	03:40:00	Gianni Palantrani 	-1 cuscinetto	Bustina singola	No	\N	\N	\N	\N	\N	\N	\N
30	31	\N	aaaaaaaaaaaaaa	2024-11-25 15:06:05.781507	00:00:01	Dylan D'Amario	aaaaaaaaaaaaaa	Aaaaaa		25.00	aaaaaaaaaaaaaaaa	aaaaaaa	PNK FARMACEUTICI	si	\N	\N
31	33	\N	aaaaaaaaaaaaadddddddddddddddddd	2024-11-26 14:22:38.283631	01:25:00	Dylan D'Amario	aaaaaaaaaaaaaaaaaaaddddddddddddddd	Astucciatrice		389.00	aaaaaaaaaaaaaaaaaaaaddddddddddddddddd	aaaaaaaaaaadddddddddddddd	PNK FARMACEUTICI	si	\N	\N
32	32	\N	lllllllllllllllllffffffffff	2024-11-26 14:39:24.689621	02:20:00	Dylan D'Amario	aaaaaaaaaaaaaaaaaaaaaaagggggggggggg	Astucciatrice	no	65.00	llllllllllllllllfffffffffffffff	lllllllllllffffffffffff	PNK FARMACEUTICI	si	\N	\N
33	34	\N	aaaaaaaaaaaaaaaaaaaaa	2024-11-26 14:55:33.630628	02:20:00	Dylan D'Amario	aaaaaaaaaaaaaaaaaaaa	Astucciatrice		35.00	aaaaaaaaaaaaaaaaaaa	aaaaaaaaaaaa	PNK FARMACEUTICI	si	\N	\N
34	35	\N	Sostituzione sonda	2024-11-26 15:01:59.965103	03:45:00	Dylan D'Amario	-1 sonda	Bassina Grande		15.00	Sonda guasta	Guasto sonda temperatura	Pnk farmaceutici	Si	\N	\N
35	36	\N	aaaaaaaaaaaa	2024-11-27 09:58:32.85476	00:00:01	Giovanni Palantrani	aaaaaaaaaa	Comprimitrice	no	35.00	aaaaaaaaaaaaaa	aaaaaaaaaaa	PNK FARMACEUTICI	si	\N	\N
36	37	\N	pulizia tubo di aspirazione	2024-11-27 10:08:40.958421	02:15:00	Dylan D'Amario	nulla	Bassina Grande		0.00	tubo aspirazione otturato	non aspira	PNK FARMACEUTICI	si	\N	\N
37	38	\N	a	2024-11-27 11:05:21.13372	00:00:01	Dylan D'Amario	a	Astucciatrice 2	none	35.00	a	a	PNK FARMACEUTICI	si	\N	\N
38	39	\N	a	2024-11-27 11:19:21.438658	01:00:00	Luca Nardicchia	a	Bassina Grande	none	25.00	a	a	PNK FARMACEUTICI	si	\N	\N
39	40	\N	a	2024-11-27 11:26:54.488159	01:00:00	Dylan D'Amario	a	Astucciatrice	none	25.00	a	a	PNK FARMACEUTICI	si	\N	\N
40	41	\N	a	2024-11-27 11:29:21.63726	01:00:00	Giovanni Palantrani	a	Astucciatrice 2	none	25.00	a	a	PNK FARMACEUTICI	si	\N	\N
41	42	\N	b	2024-11-27 11:30:20.073914	02:20:00	Dylan D'Amario	c	Bassina Grande	none	35.00	b	b	PNK FARMACEUTICI	si	\N	\N
42	43	\N	l	2024-11-27 11:39:48.05703	02:35:00	Luca Nardicchia	l	Astucciatrice	none	25.00	l	l	PNK FARMACEUTICI	si	\N	\N
43	44	\N	as	2024-11-27 11:50:40.66448	02:34:00	Dylan D'Amario	as	Comprimitrice Kilian	none	36.00	as	as	PNK FARMACEUTICI	si	\N	\N
44	45	\N	as	2024-11-27 11:54:02.104714	01:00:00	Luca Nardicchia	sa	Astucciatrice	none	35.00	as	as	PNK FARMACEUTICI	si	\N	\N
45	46	\N	as	2024-11-27 11:55:30.562648	01:00:00	Giovanni Palantrani	as	Astucciatrice	none	25.00	as	as	PNK FARMACEUTICI	si	\N	\N
46	47	\N	ll	2024-11-27 11:57:11.212331	02:15:00	Dylan D'Amario	ll	Astucciatrice	no	35.00	ll	ll		si	\N	\N
47	48	\N	aa	2024-11-27 12:05:44.585776	01:00:00	Dylan D'Amario	aaa	Astucciatrice	no	30.50	aa	aa	PNK FARMACEUTICI	si	\N	\N
48	49	\N	ll	2024-11-27 12:15:08.3167	01:00:00	Dylan D'Amario	mm	Bassina Grande	none	36.20	ll	ll	PNK FARMACEUTICI	si	\N	\N
49	50	\N	AAAAA	2024-11-27 13:56:10.611931	01:00:00	Giovanni Palantrani	AAAAAAA	Astucciatrice	NO	28.00	AAA	AAA	PNK FARMACEUTICI	SI	\N	\N
50	51	\N	aaaa	2024-11-27 14:03:02.139524	01:00:00	Dylan D'Amario	ads	Astucciatrice	no	26.02	aaaaa	aa	PNK FARMACEUTICI	si	\N	\N
51	52	\N	as	2024-11-27 14:08:40.476604	06:20:00	Dylan D'Amario	asd	Bassina Grande	no	1900.00	as	as	PNK FARMACEUTICI	si	\N	\N
52	53	\N	aaaaaaaa	2024-11-27 14:13:21.709372	04:00:00	aaaaaaa	aaaaaaaa	Astucciatrice	no	36.23	aaaaaaa	aaaaaaa	aaaaaa	si	\N	\N
53	54	\N	aaaaaaa	2024-11-28 09:03:36.097491	01:00:00	Dylan D'Amario	aaaaa	Astucciatrice	no	36.20	aaaaaa	aaaa	PNK FARMACEUTICI	si	\N	\N
54	55	\N	aaaaaaaaaaa	2024-11-28 09:11:56.203578	02:30:00	Luca Nardicchia	aaaaaaa	Comprimitrice Kilian	no	36.20	aaaaaaaa	aaaaaaaaa	PNK FARMACEUTICI	si	\N	\N
55	56	\N	mmmmmmmmmmmm	2024-11-28 09:14:56.266963	02:35:00	Luca Nardicchia	nnnnnnnnnnn	Bassina Grande	no	38.36	mmmmmmmmmmmm	mmmmmmm	PNK FARMACEUTICI	si	\N	\N
56	57	\N	mmmmmmm	2024-11-28 09:15:53.417241	02:00:00	Luca Nardicchia	mmmmm	Bassina Grande	no	36.20	mmmmmmmmmmmmmm	mmmmmmmmm	PNK FARMACEUTICI	si	\N	\N
57	58	\N	aaaaaaaaaaaaaaaa	2024-11-28 09:17:49.726637	01:00:00	Dylan D'Amario	aaaaaaaaaaa	Astucciatrice	no	36.20	aaaaaaaaaaaaa	aaaaaaaaa	PNK FARMACEUTICI	si	\N	\N
58	59	\N	aaaaaaaaaaa	2024-11-28 09:19:12.876569	01:00:00	Dylan D'Amario	aaaaaaaaaaa	Astucciatrice	no	36.20	aaaaaaaaaa	aaaaaaaa	PNK FARMACEUTICI	si	\N	\N
59	60	\N	aaaaaaaaaaaaaa	2024-11-28 09:25:00.598357	01:00:00	Dylan D'Amario	aaaaaaaaaaaa	Bassina Grande	no	36.20	aaaaaaaaaaaaaa	aaaaaaaaa	PNK FARMACEUTICI	si	\N	\N
60	61	\N	aaaaaaaaaaa	2024-11-28 09:27:25.560486	01:00:00	Dylan D'Amario	aaaaaaaaaaa	Astucciatrice	no	36.00	aaaaaaaaaaa	aaaaaa	PNK FARMACEUTICI	si	\N	\N
61	62	\N	aaaaaaaaa	2024-11-28 09:29:20.06797	01:00:00	Dylan D'Amario	aaaaaaaaaa	Astucciatrice	no	35.00	aaaaaaaaaaa	aaaaaaa	PNK FARMACEUTICI	si	\N	\N
62	63	\N	ssssssssssss	2024-11-28 09:31:37.487333	01:00:00	Dylan D'Amario	ssssssssssss	Astucciatrice	no	36.00	ssssssssss	sssssssss	PNK FARMACEUTICI	si	\N	\N
63	64	\N	ssssssssssssss	2024-11-28 09:36:49.328128	01:00:00	Dylan D'Amario	ssssssssssss	Astucciatrice	no	36.20	sssssssssss	ssssssss	PNK FARMACEUTICI	si	\N	\N
64	76	\N	Sostituzione 	2024-11-28 15:47:14.559641	03:00:00	Gianni Palantrani 	Nulla	Astucciatrice	No	0.00	Guasto	Guasto	Pnk farmaceutici	Si 	\N	\N
65	65	\N	p	2024-11-28 16:02:03.208586	02:00:00	Dylan D'Amario	m	Astucciatrice	no	25.00	p	p	PNK FARMACEUTICI	si	\N	\N
66	66	\N	n	2024-11-28 16:02:19.620254	02:15:00	Dylan D'Amario	n	Astucciatrice	no	36.00	n	n	PNK FARMACEUTICI	si	\N	\N
67	77	\N	h	2024-11-28 16:02:37.83295	01:00:00	Dylan D'Amario	h	Astucciatrice	h	36.00	h	h	PNK FARMACEUTICI	h	\N	\N
68	67	\N	c	2024-11-28 16:02:56.126663	01:00:00	Dylan D'Amario	c	Astucciatrice 2	c	36.00	c	c		c	\N	\N
69	68	\N	c	2024-11-28 16:03:12.095016	02:15:00	Dylan D'Amario	c	Astucciatrice	c	36.00	c	c	PNK FARMACEUTICI	c	\N	\N
70	69	\N	c	2024-11-28 16:03:31.034436	04:00:00	c	c	Aaaaaa	c	36.00	c	c	PNK FARMACEUTICI	c	\N	\N
71	70	\N	c	2024-11-28 16:03:52.213684	04:20:00	Giovanni Palantrani	c	Astucciatrice	c	36.00	c	c		v	\N	\N
72	75	\N	c	2024-11-28 16:04:07.454079	01:00:00	Dylan D'Amario	c	Astucciatrice	c	35.00	c	c	PNK FARMACEUTICI	c	\N	\N
73	71	\N	c	2024-11-28 16:04:20.677978	01:00:00	c	c	Blisteratrice	c	36.00	c	c	PNK FARMACEUTICI	c	\N	\N
74	72	\N	c	2024-11-28 16:04:34.182929	01:00:00	Dylan D'Amario	c	Imbustatrice	c	35.00	c	c	PNK FARMACEUTICI	c	\N	\N
75	74	\N	c	2024-11-28 16:04:49.996219	01:00:00	Giovanni Palantrani	c	Nardicchia	c	35.00	c	c	PNK FARMACEUTICI	c	\N	\N
76	73	\N	c	2024-11-28 16:05:04.649275	01:00:00	c	c	Bassina Grande	c	36.00	c	c	PNK FARMACEUTICI	c	\N	\N
77	78	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-28 16:08:41.809589	07:00:00	Gianni Palantrani	- 5 METRI DI TUBO SPIRALATO D50 \r\n	Opercolatrice	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
78	79	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE	2024-11-29 09:35:54.265116	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50 \r\n	Opercolatrice Tipo "0"	NULLA DA SEGNALARE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA.	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
79	80	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 09:46:44.118648	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50 \r\n	Opercolatrice Tipo "0"	NULL	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
80	81	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 09:57:14.126594	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50	Opercolatrice	NO	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
81	82	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 10:04:47.794365	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50	Opercolatrice Tipo "0"	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
82	83	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 10:45:16.370681	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50	Opercolatrice Tipo "0"	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
83	84	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 10:56:00.898354	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50	Opercolatrice Tipo "0"	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
84	85	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 11:01:32.639641	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50 \r\n	Opercolatrice Tipo "0"	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
85	86	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 11:05:08.497979	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50	Opercolatrice Tipo "0"	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	\N	\N
86	87	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 11:12:29.522921	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50 \r\n	Opercolatrice Tipo "0"	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	OP2	SI
87	88	\N	SMONTAGGIO INTERO BLOCCO DELLA RUOTA DI TRASPORTO DELLE STAZIONI DELLE CAPSULE. PULIZIA\r\nE LUBRIFICAZIONE DEI PERNI E DELLE CAMME CHE DANNO IL MOVIMENTO ALLE STAZIONI DELLE \r\nCAPSULE E RIMONTAGGIO. SMONTAGGIO COMPLETO CARICATORE CAPSULE PER PULIZIA.\r\nSOSTITUZIONE TUBI DI ASPIRAZIONE CAPSULE DIFETTOSE\r\n	2024-11-29 11:24:18.056369	07:00:00	Gianni Palantrani, Luca Nardicchia	5 METRI DI TUBO SPIRALATO D50	Opercolatrice Tipo "0"	NONE	80.00	USURA	NELLA MANUTENZIONE ORDINARIA DEL 18 NOVEMBRE SI E’ NOTATO CHE IL MOVIMENTO DELLE STAZIONI \r\nDI TRASPORTO CAPSULE NON E’ PERFETTAMENTE FLUIDO. SI E’ DECISO CON L’UFFICIO TECNICO DI\r\nPIANIFICARE UN INTERVENTO PER SMONTARE L’INTERO PIATTO DI TRASPORTO DELLE STAZIONI DELLE \r\nCAPSULE E PROVVEDERE ALLA PULIZIA. \r\n	PNK FARMACEUTICI VIA TEVERE 16	SI	OP2	SI
88	89	\N	aaaaaaaaaaaaaa	2024-11-29 11:29:56.555206	07:00:00	Gianni Palantrani, Luca Nardicchia	- 50 mmmm\r\n- 60 mmm 	Opercolatrice Tipo "0"	no	80.00	aaaaaaaaa	aaaaaaa	PNK FARMACEUTICI	si	OP2	si
\.


--
-- Name: interventi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.interventi_id_seq', 89, true);


--
-- Name: manutentori_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.manutentori_id_seq', 1, false);


--
-- Name: rapporti_intervento_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.rapporti_intervento_id_seq', 88, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: interventi interventi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventi
    ADD CONSTRAINT interventi_pkey PRIMARY KEY (id);


--
-- Name: manutentori manutentori_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.manutentori
    ADD CONSTRAINT manutentori_pkey PRIMARY KEY (id);


--
-- Name: rapporti_intervento rapporti_intervento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rapporti_intervento
    ADD CONSTRAINT rapporti_intervento_pkey PRIMARY KEY (id);


--
-- Name: interventi interventi_manutentore_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.interventi
    ADD CONSTRAINT interventi_manutentore_id_fkey FOREIGN KEY (manutentore_id) REFERENCES public.manutentori(id);


--
-- Name: rapporti_intervento rapporti_intervento_intervento_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rapporti_intervento
    ADD CONSTRAINT rapporti_intervento_intervento_id_fkey FOREIGN KEY (intervento_id) REFERENCES public.interventi(id);


--
-- Name: rapporti_intervento rapporti_intervento_manutentore_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rapporti_intervento
    ADD CONSTRAINT rapporti_intervento_manutentore_id_fkey FOREIGN KEY (manutentore_id) REFERENCES public.manutentori(id);


--
-- PostgreSQL database dump complete
--

