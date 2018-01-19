--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: manual_updates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE manual_updates (
    id bigint NOT NULL,
    date timestamp without time zone,
    file_name character varying(255),
    md5 character varying(255),
    size bigint NOT NULL,
    url character varying(255),
    product_id bigint,
    version_from_id bigint,
    version_to_id bigint
);


ALTER TABLE manual_updates OWNER TO postgres;

--
-- Name: manual_updates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE manual_updates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE manual_updates_id_seq OWNER TO postgres;

--
-- Name: manual_updates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE manual_updates_id_seq OWNED BY manual_updates.id;


--
-- Name: patches; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE patches (
    id bigint NOT NULL,
    barrier boolean DEFAULT false,
    date timestamp without time zone,
    enabled boolean DEFAULT true,
    info text,
    md5 character varying(255),
    notification_text text,
    size bigint NOT NULL,
    url character varying(255),
    product_id bigint,
    version_id bigint,
    version_from_id bigint
);


ALTER TABLE patches OWNER TO postgres;

--
-- Name: patches_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE patches_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE patches_id_seq OWNER TO postgres;

--
-- Name: patches_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE patches_id_seq OWNED BY patches.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE products (
    id bigint NOT NULL,
    description character varying(255),
    display_name character varying(255),
    name character varying(255),
    update_strategy character varying(255),
    project_id bigint,
    publishable boolean DEFAULT false,
    manual_updatable boolean DEFAULT false NOT NULL,
    current_update_instruction text,
    archive_update_instruction text,
    target_products text,
    parent_id bigint,
    emailing_date timestamp without time zone
);


ALTER TABLE products OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE products_id_seq OWNER TO postgres;

--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE projects (
    id bigint NOT NULL,
    description character varying(255),
    display_name character varying(255),
    name character varying(255)
);


ALTER TABLE projects OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE projects_id_seq OWNER TO postgres;

--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users (
    id bigint NOT NULL,
    admin boolean DEFAULT false,
    email character varying(255),
    image character varying(255),
    name character varying(255),
    token character varying(255)
);


ALTER TABLE users OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE users_id_seq OWNER TO postgres;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: users_projects; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE users_projects (
    users_id bigint NOT NULL,
    projects_id bigint NOT NULL
);


ALTER TABLE users_projects OWNER TO postgres;

--
-- Name: versions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE versions (
    id bigint NOT NULL,
    full_version character varying(255) NOT NULL,
    product_id bigint,
    comparable character varying(255)
);


ALTER TABLE versions OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE versions_id_seq OWNER TO postgres;

--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: manual_updates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manual_updates ALTER COLUMN id SET DEFAULT nextval('manual_updates_id_seq'::regclass);


--
-- Name: patches id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patches ALTER COLUMN id SET DEFAULT nextval('patches_id_seq'::regclass);


--
-- Name: products id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Data for Name: manual_updates; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY manual_updates (id, date, file_name, md5, size, url, product_id, version_from_id, version_to_id) FROM stdin;
36	2017-12-25 12:41:08.868	start_9.0.0_9.7.1.update	919c1ae949b45996aea8c9502a70a1a3	106013173	https://126008.selcdn.ru/updates_beta/start/start_update/start_9.0.0_9.7.1.update	1	39	97
\.


--
-- Name: manual_updates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('manual_updates_id_seq', 36, true);


--
-- Data for Name: patches; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY patches (id, barrier, date, enabled, info, md5, notification_text, size, url, product_id, version_id, version_from_id) FROM stdin;
45	f	2017-04-14 17:11:20.624503	t		78fc84e099a22bfa31c0a8eda6b41ad7		298686	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.4	3	2	\N
48	f	2017-04-14 17:11:30.878309	t		b69a149a3a05f09bff572e060ab3b7a3		308362	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.5	3	5	\N
49	f	2017-04-19 10:08:56.988807	t		247f45808ce6285724ef4bab58798833		308872	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.6	3	6	\N
50	f	2017-04-28 17:40:42.055773	t		70f311f26410785ca3d17cfc0081507c		6683669	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.7	3	7	\N
51	f	2017-05-10 17:33:11.867119	t		dfd0ee3cd25249bd88a1ed831edf3555		6700182	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.8	3	8	\N
52	f	2017-05-11 16:44:02.164614	t		9d0d6e91fd81ab59cd92897c8fb354b9		6700730	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.9	3	9	\N
58	f	2017-05-11 17:33:44.699932	t		64e7be2b054f52659c1f3466a6a1566d		6701957	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.10	3	10	\N
59	f	2017-05-11 17:41:42.727639	t		be94b709434b981f347f09b8b34e0e82		6701963	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.0	3	11	\N
60	f	2017-05-12 11:00:14.257578	t		6f8414423f8efa30cbe2fba829e0a2fc		6701217	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.1	3	12	\N
61	f	2017-05-16 12:19:47.762048	t		e70b9be9c53d9eb003520ed64983ddf9		4962425	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.2	3	13	\N
62	f	2017-05-16 16:27:30.574554	t		e1dd34f0ab4787ea54736a519c28e7f2		4962889	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.3	3	14	\N
64	f	2017-05-18 10:56:32.454416	t		f83703cd11390170facff5c904daad68		4962272	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.4	3	15	\N
65	f	2017-05-23 12:23:24.742662	t		e6204f56a4e5bb81f10931f3d64ae477		4985131	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.5	3	16	\N
20	f	2017-04-06 14:20:44.259413	t		152d81bc71758d92036a1b3ab01be171		284714	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.2	3	17	\N
36	f	2017-04-07 11:23:10.908199	t		7663f6b0653c7d6b6191dad9d0d92bec		297420	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/0/1.0.3	3	18	\N
110	f	2017-07-14 17:57:33.201309	t		aef4433764c8ae6364fa67ce8e5dcbdb		584145	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.7	3	19	\N
72	f	2017-05-29 11:30:58.111887	t		65b994b24087552040044c9c7b83ead6		4992040	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.6	3	20	\N
74	f	2017-05-31 11:23:44.814454	t		d4e51fa07ddc1ae6c205355e0bda46d8		4993014	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.7	3	21	\N
75	t	2017-06-05 10:53:23.376613	t		ccf86d3b1eaedbf36cba470a4c48c25c		4994448	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.8	3	22	\N
85	f	2017-06-08 13:25:03.168076	t		300645e35c7ee0ef66a14c177d1faf45		382521	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.9	3	23	\N
87	f	2017-06-08 13:25:54.812844	t		5a01689251af1cbf82e0c1c1cbd45fd5		382521	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.11	3	24	\N
104	f	2017-06-22 13:25:34.595873	t		c1a051a3f861d304037d60f43541bb75		401291	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.3	3	25	\N
91	f	2017-06-08 13:26:38.970071	t		12c4159e9af1d0ce134a68f852b9af3a		382516	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.13	3	26	\N
93	f	2017-06-08 13:26:52.645287	t		05aa069d13d79dfc04772b7282d2c09e		382520	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.14	3	27	\N
94	t	2017-06-08 13:27:14.514639	t		079516fbac456ebfb8fb54bf744d7130		382516	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.15	3	28	\N
86	f	2017-06-08 13:47:21.291336	t		4afc63f651a46716919eb9cb58e9645e		382521	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.10	3	29	\N
88	f	2017-06-08 13:47:40.796474	t		eea30c59b30decb655da21b3735de5e7		382521	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.12	3	30	\N
98	t	2017-06-08 16:16:24.326186	t		6569028f0cae065beade31f330137c56		5000015	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/1/1.1.20	3	31	\N
99	t	2017-06-13 18:05:17.14995	t		aa61e1aadf24f09beaece0f9daccff2a		394107	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.0	3	32	\N
101	t	2017-06-19 18:22:23.158071	t		577546cd90f344fb984c22fd35e93767		406075	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.1	3	33	\N
102	f	2017-06-20 19:00:13.536637	t		2e6c7f0dc330aa0cd56fe792cc614500		400767	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.2	3	34	\N
106	f	2017-06-22 13:25:45.946514	t		e56d0b0136a83fb238d19fa9d98f707c		401956	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.4	3	35	\N
107	f	2017-06-22 16:43:34.453102	t		d580cc9d1aa9beb0017356ae0fb454ff		403343	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.5	3	36	\N
109	t	2017-07-10 13:15:51.687881	t		04a04c581606cc8c1b059add221465d4		587079	https://126008.selcdn.ru/updates/fisgo/dreamkasf/1/2/1.2.6	3	38	\N
108	f	2017-06-26 16:52:17.987534	t		9830c595b100f74e8071ef64e942389e		32985395	https://126008.selcdn.ru/updates_beta/start/utm_arm/2/0/2.0.5	6	37	\N
2	f	2017-07-28 12:22:02.743	t	Исправленные ошибки\n- При запуске с неподключенным ККТ возникала ошибка «Невозможно продолжить работу» (актуально для Viki Micro и Viki Classic)	0a6f81e53cb4443c41f2510f7411287b		8253652	https://126008.selcdn.ru/updates_beta/start/start_update/9/0/9.0.0_9.0.1	1	41	39
4	f	2017-07-31 17:05:52.424	f	\N	24a269db56445c1c3117babc81860c7a	\N	1938812	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/2/1.2.8	3	43	\N
6	f	2017-08-14 17:33:38.115	t	\N	8bf99eeba28d101b83bb4494ac369568	\N	625769	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/2/1.2.10	3	45	\N
5	f	2017-08-09 15:08:02.288	t	Новое в версии\n- Касса позволяет продавать неалкогольные товары, которых нет на кассе: отсканируйте штрихкод и на диалоге «Товар не найден» нажмите «Найти в Кабинете» (касса должна быть подключена к «Кабинету Дримкас»)\n- В меню Возврат теперь можно оформить возврат по чеку: отсканируйте штрихкод чека или введите его реквизиты в дополнительном меню  ⋮ — Возврат по чеку. При возврате используется тот же тип оплаты, что и в возвращаемом чеке. На текущий момент можно вернуть только весь чек целиком.\n- При возврате по чеку, оплаченному банковским терминалом, при технической возможности выполняется банковская операция «Отмена», что позволяет мгновенно вернуть деньги покупателю\n\nИсправленные ошибки\n- При поиске товаров по названию/части штрихкода в результатах поиска могли отображаться не все подходящие товары\n- Касса позволяла дважды открыть меню Инвентаризация (Управление остатками ЕГАИС), что приводило к ошибке «Невозможно продолжить работу»	4b4d20fd69d65cccd6d4a107517717e1		6445670	https://126008.selcdn.ru/updates_beta/start/start_update/9/1/9.0.1_9.1.0	1	44	41
21	f	2017-09-20 15:42:00.334	t	Исправленные ошибки\n- При обработке goods.txt касса могла удалить ранее загруженные скидки	be9d5eb72776d69f58063c59831d9efb	\N	45	https://126008.selcdn.ru/updates_beta/start/demo_start_update__arm/9/3/9.3.1_9.3.2	2	53	54
7	f	2017-08-14 18:49:39.411	t	\N	17713edcc7a3af6aadc19137e84f0d4d	\N	471505	https://126008.selcdn.ru/updates_beta/start/start_update/9/1/9.1.0_9.1.1	1	46	44
8	f	2017-08-22 19:43:22.868	t	\N	a50576f5f890a2b725d68604df3493fb	\N	16183772	https://126008.selcdn.ru/updates_beta/start/start_update/9/2/9.1.1_9.2.0-alpha.446	1	47	46
9	f	2017-08-23 11:51:55.017	t	\N	0b6551798803afec5db96fff1e7952de	\N	1344673	https://126008.selcdn.ru/updates_beta/start/start_update/9/2/9.2.0-alpha.446_9.2.0-alpha.449	1	48	47
126	f	2017-12-18 18:22:36.191	f		2a026132605c4b68953fee4a9873a10d		983284	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.12	3	94	\N
11	f	2017-09-12 17:05:47.864	t	\N	539a0e0354197e359cbab7749ef1f157	\N	825793	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/2/1.2.14	3	50	\N
18	f	2017-09-12 17:42:49.245	t	\N	908966069b3798bfc01f0f3e77ff3a55	\N	825779	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/2/1.2.12	3	51	\N
19	f	2017-09-12 17:44:06.406	t	\N	908966069b3798bfc01f0f3e77ff3a55	\N	825779	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/2/1.2.15	3	52	\N
22	f	2017-09-20 15:52:37.745	t	Новое в версии\r\n- тест\r\n- 20 сентября	7be37373165a9d099092a955c97acd2f	Важное обновление	1644	https://126008.selcdn.ru/updates_beta/start/demo_start_update__arm/9/3/9.3.2_9.3.3	2	55	53
23	f	2017-09-25 17:40:48.688	t	\N	3fab4ac50a60aec2d8c716ca1386b79b	\N	819054	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.3	3	56	\N
24	f	2017-09-26 12:59:23.547	t		88412264b9af69c3bd7bf19e6311c1d4		819087	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.4	3	57	\N
28	f	2017-10-06 18:40:36.3	t		68d2534a73dee498b78798192ef13417		2350201	https://126008.selcdn.ru/updates_beta/start/start_update/9/3/9.2.0-alpha.451_9.3.5	1	59	49
125	f	2017-12-14 14:28:20.55	t	Новое в версии\r\n- В акт списания реализации добавлена возможность переноса количества на товар от другого производителя для исключения пересортицы\r\n- Добавлена возможность подключения весов к кассам Viki Micro и Дримкас Старт (меню Настройка — Прикассовые весы)\r\n\r\nИсправленные ошибки\r\n- Поле "Справка 2" не заполнялось при ручном добавлении позиции в акте перемещения в торговый зал\r\n- Поле "Место расчетов" теперь обязательно для заполнения при регистрации/перерегистрации с заменой ФН\r\n- В некоторых случаях картинки, привязанные к товарам в «Кабинете Дримкас», могли не загружаться на кассу\r\n- Исправлена ошибка "Весы не найдены"при подключении весов Масса К на кассах Viki Mini, Viki Tower и Viki Classic	f9972f0472dc9f4e0c10387e0ed29624		25859252	https://126008.selcdn.ru/updates_beta/start/start_update/9/6/9.5.1_9.6.0	1	93	87
10	f	2017-08-23 14:43:30.264	t	Новое в версии\r\n- Товары, принятые по накладным ЕГАИС, отправляются в «Кабинет Дримкас», что позволяет назначить им цену или внести другие изменения перед продажей на кассе\r\n- В «Кабинете Дримкас» отображается состояние загрузки товаров на кассу\r\n- Значительно ускорена загрузка товаров из «Кабинета Дримкас»\r\n- УТМ на кассах Viki Mini, Tower и Classic теперь работает не только с Jacarta, но и с ключом криптозащиты «Рутокен»\r\n- Ускорена загрузка и установка УТМ на кассах Viki Mini, Tower и Classic\r\n- При передаче чека в ЕГАИС передается номер фискального документа и заводской номер ФН\r\n- Касса Viki Micro определяет некоторые нарушения конфигурации ПО, внесенные пользователем (удаление предустановленного ПО, применение несовместимых образов восстановления), и предлагает способы решения\r\n\r\nИсправленные ошибки\r\n- В текстовые поля нельзя было ввести текст, начинающийся с запятой	9f83cb8b8f2746448556cb1003aa740c		9482283	https://126008.selcdn.ru/updates_beta/start/start_update/9/2/9.2.0-alpha.449_9.2.0-alpha.451	1	49	48
31	f	2017-10-09 19:38:22.416	t		2082c0e593134313734f25b259fef3d2		61491	https://126008.selcdn.ru/updates_beta/start/start_update/9/3/9.3.5_9.3.6	1	60	59
32	f	2017-10-11 12:20:46.627	f		d8a588c435196bf1dfdcc0062dc19fc7		4397473	https://126008.selcdn.ru/updates_beta/start/demo/1/0/1.0.0	4	62	\N
33	f	2017-10-11 12:25:02.841	f		73362235d5f63006c6801ab57719bca7		10	https://126008.selcdn.ru/updates_beta/start/demo3/1/0/1.0.1	7	63	\N
40	f	2017-10-16 17:17:28.391	t		4b1a43a7a9ca83f0392e340d806f5ecc		887103	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.5	3	76	\N
34	f	2017-10-11 12:36:09.226	f		7affe99832aefc27c256bbac792f8fcb		197	https://126008.selcdn.ru/updates_beta/start/demo3/2/0/2.0.5	7	71	\N
113	f	2017-11-01 17:49:41.494	t		e0c54ed25b4a614a1e8090ebf391366d		900953	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.8	3	81	\N
41	f	2017-10-20 12:49:03.221	t	Новое в версии\r\n- Тест	28e588e6052defb070244da06fb36654		2160770	https://126008.selcdn.ru/updates_beta/start/start_update/9/3/9.3.6_9.3.7	1	77	60
42	t	2017-10-23 11:09:20.148	t	Обновление	0eb9ce8a6280221829b516bcbcbe804e	Важное обновление	8752944	https://126008.selcdn.ru/updates_beta/start/demo/1/0/1.0.1	4	78	\N
114	f	2017-11-02 14:14:12.071	t		8a6b37cc5617e2e8beac0930d5696dcb		31535967	https://126008.selcdn.ru/updates_beta/start/utm_arm/2/1/2.1.6	6	82	\N
123	f	2017-12-07 11:38:03.426	t		f17d0421883158963dd7506f3eddbe06		268464	https://126008.selcdn.ru/updates_beta/ComProxy/ComProxyAgent/1/3/1.3.4	9	91	\N
44	f	2017-10-31 15:36:07.156	t	Новое в версии\r\n- Исправлены ошибки в работе ККТ 111\r\n- Устранено переполнение счётчиков\r\n- Восстановление битой базы чеков\r\n\r\nИсправленные ошибки\r\n- 123	1976e34209d5388287c5787ac0f1d58a		900639	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.7	3	80	\N
116	f	2017-11-20 13:16:21.97	f		5e659963920b7773e9e1643090668c30		20758574	https://126008.selcdn.ru/updates_beta/start/start_update/9/4/9.3.7_9.4.0	1	84	77
115	f	2017-11-14 16:09:47.095	t	new verison 670.0.1	a64204da67fd6c05886b64d7a4f7d7cd		265225	https://126008.selcdn.ru/updates_beta/connect/fm16/670/0/670.0.1	10	83	\N
118	f	2017-11-20 13:17:11.989	t		e0b05cc9eec9be2e20a0b100b192b018		25827183	https://126008.selcdn.ru/updates_beta/start/start_update/9/5/9.4.1_9.5.0	1	86	85
120	f	2017-11-24 15:50:27.935	f		ffd05a2e8f5ce5bdee94d1d0eb2a7500		989356	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.9	3	88	\N
37	f	2017-10-13 16:44:19.991	t		d02f32bb4e37cd9c933363a40e0b67a6		265152	https://126008.selcdn.ru/updates_beta/connect/fm16/670/0/670.0.0	10	73	\N
119	f	2017-11-20 16:42:54.9	t		78b95bc93da996592873cda89a11bcb9		6600562	https://126008.selcdn.ru/updates_beta/start/start_update/9/5/9.5.0_9.5.1	1	87	86
38	f	2017-10-13 16:44:59.97	t		6e24d77a219554231c555cc0fd664a25		752634	https://126008.selcdn.ru/updates_beta/connect/pirit2f/570/0/570.0.0	11	74	\N
117	f	2017-11-20 13:16:51.107	t		bd47a27245b315e6415f1bc947023733		32433612	https://126008.selcdn.ru/updates_beta/start/start_update/9/4/9.4.0_9.4.1	1	85	84
124	f	2017-12-11 11:11:44.924	t		773897dabe39e01ad26bb32a91125852		59899904	https://126008.selcdn.ru/updates_beta/start/dreamkas_updater/1/0/1.0.1	12	92	\N
121	f	2017-11-30 12:01:07.827	t		6e24d77a219554231c555cc0fd664a25		752634	https://126008.selcdn.ru/updates_beta/connect/pirit2f/570/0/570.0.2	11	89	\N
39	f	2017-10-13 19:34:25.758	f		ed1798b0c27ab36f264a6bf7a4c7052e		56913920	https://126008.selcdn.ru/updates_beta/start/dreamkas_updater/1/0/1.0.0	12	75	\N
35	f	2017-10-11 12:36:56.681	t	test patch	33a4a77475b598df0e95d494cab81316	test patch agent	268463	https://126008.selcdn.ru/updates_beta/ComProxy/ComProxyAgent/1/3/1.3.3	9	72	\N
122	f	2017-12-05 14:18:16.614	f		4e0eb1ac0a84f46bb830cd1990540fdd		982079	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.11	3	90	\N
43	f	2017-10-26 12:22:12.782	t	Новое в версии\r\n- 321\r\n- 2456	1411d449844d50f523a2d48f8fb1a546		900457	https://126008.selcdn.ru/updates_beta/fisgo/dreamkasf/1/3/1.3.6	3	79	\N
128	f	2017-12-21 16:02:35.61	f	Новое в версии\r\n- В акт списания реализации добавлена возможность переноса количества на товар от другого производителя для исключения пересортицы\r\n- Добавлена возможность подключения весов к кассам Viki Micro и Дримкас Старт (меню Настройка — Прикассовые весы). Поддерживаются весы Масса К (протокол 2), Штрих Слим, CAS ER/AD.\r\n- Добавлено отображение справки 2 в позициях ТТН ЕГАИС\r\n- Добавлено отображение идентификатора и алкокода в позициях актов ЕГАИС\r\n- Поддержка работы с артикулами из «Кабинета Дримкас»\r\n- Возможность отключить экран блокировки (Настройка — Пользователи)\r\n- Отправка лога в поддержку «Дримкас» прямо с кассы через интернет — без флешек и каталога обмена  (Настройка — Об устройстве)\r\n- Время загрузки кассовой программы уменьшено на 20-30 секунд\r\n- Возможность зарегистрировать кассы Вики на несколько систем налогообложения\r\n- Возможность выбрать систему налогообложения по умолчанию\r\n- Возможность установить УТМ 2.1.6\r\n	0d317ac2d107d89d48d080baa41ffede		57292926	https://126008.selcdn.ru/updates_beta/start/start_update/9/7/9.3.7_9.7.0	1	96	77
129	f	2017-12-22 10:51:06.796	t		bcde661036c5f8334bb9b5bfc2e84ec3		4164574	https://126008.selcdn.ru/updates_beta/start/start_update/9/7/9.7.0_9.7.1	1	97	96
130	t	2017-12-25 15:04:49.036	t	Новое в версии\r\n- Тест\r\n- 123\r\n- 24234234234\r\n- апыафывафыва\r\nИсправленные ошибки\r\n- Иго-го\r\n- Га-га-га\r\n- Трололо	1ba097f6eef1e623983929c452f5ed17		10143	https://126008.selcdn.ru/updates_beta/start/dreamkas_start/9/3/9.3.7	14	98	\N
131	f	2017-12-25 16:26:53.212	t	Новое в версии\r\n- 123\r\n- 1234\r\n-12345687	1ba097f6eef1e623983929c452f5ed17		10143	https://126008.selcdn.ru/updates_beta/start/dreamkas_start/9/3/9.3.8	14	99	\N
\.


--
-- Name: patches_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('patches_id_seq', 131, true);


--
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY products (id, description, display_name, name, update_strategy, project_id, publishable, manual_updatable, current_update_instruction, archive_update_instruction, target_products, parent_id, emailing_date) FROM stdin;
6	\N	utm_arm	utm_arm	LAST_BARRIER	1	f	f	\N	\N	\N	\N	\N
2			demo_start_update__arm	DELTA	1	f	f	\N	\N	\N	\N	\N
4			demo	LAST_BARRIER	1	f	f	\N	\N	\N	\N	\N
7			demo3	LAST_BARRIER	1	f	f	\N	\N	\N	\N	\N
9	ComProxyAgent	ComProxyAgent	ComProxyAgent	LAST_BARRIER	3	f	f	\N	\N	\N	\N	\N
10		FM16	fm16	LAST_BARRIER	4	f	f	\N	\N	\N	\N	\N
11		Пирит 2Ф	pirit2f	LAST_BARRIER	4	f	f	\N	\N	\N	\N	\N
13			start_tobacco_update__arm	DELTA	1	f	f	\N	\N	\N	\N	\N
12			dreamkas_updater	LAST_BARRIER	1	f	f	\N	\N	\N	\N	\N
3	\N	FisGo	dreamkasf	LAST_BARRIER	2	t	f	<ol>\r\n\t<li>Перейдите в раздел <b>«Меню» → 4.Система → 5.Версия</b>.</li>\r\n\t<li>Если на кассе установлена не последняя версия, на экране вы увидите сообщение «Доступна версия X.X.XX. Обновить?» (где X это номер версии).</li>\r\n\t<li>Нажмите «Ввод» — начнется загрузка новой версии, после чего ККТ может быть несколько раз перезагружена.</li>\r\n\t<li>После обновления перейдите в <b>«Меню» → 4.Система → 5.Версия</b> и убедитесь, что больше нет доступных обновлений и у вас последняя версия ПО.</li>\r\n</ol>	\N	Дримкас Ф	\N	\N
1	Обновление касс Start	Start	start_update	DELTA	1	t	t	<ol>\r\n\t<li>Проверьте, что используется версия Start ${versionFrom} или выше (меню ☰ — Настройка — Об устройстве);</li>\r\n\t<li>Для <b>Viki Mini, Viki Tower, Viki Classic (кроме Viki Micro)</b> положите файл обновления ${fileName} в корень флешки (NTFS/FAT) и вставьте ее в USB-порт кассы, либо положите его в каталог обмена кассы (\\\\IP кассы\\exchange\\);\r\n\t    <p>Для <b>Viki Micro</b> положите файл в каталог обмена кассы (\\\\IP кассы\\exchange\\) или скопируйте с флешки в каталог C:\\exchange;</p>\r\n\t</li>\r\n\t<li>Перезагрузите кассу (☰ — Завершение работы — Обновить и перезагрузить), чтобы начать обновление;</li>\r\n\t<li>После завершения обновления на экране будет написано «Start ${versionTo}: Первый запуск после обновления». В меню ☰ — Настройка — Об устройстве будет указана версия Start ${versionTo}</li>\r\n</ol>	<h4>Для Viki Mini, Viki Tower, Viki Classic (кроме Viki Micro)</h4>\r\n<ol>\r\n    <li>Проверьте, что используется версия Start 8.1 или выше (меню ☰ — Настройка — Об устройстве);</li>\r\n    <li>Скачайте файл <a href="http://126008.selcdn.ru/setstart/10.3/START_8.1-9.0.update">START_8.1-9.0.update</a>;</li>\r\n    <li>Положите файл обновления START_8.1-9.0.update в корень флешки (NTFS/FAT) и вставьте ее в USB-порт кассы, либо положите его в каталог обмена кассы (\\\\IP кассы\\exchange\\);\r\n    </li>\r\n    <li>Перезагрузите кассу, чтобы начать обновление (☰ — Завершение работы — Обновить и перезагрузить);</li>\r\n    <li>После завершения обновления на экране будет написано «Start 9.0.0: Первый запуск после обновления». В меню ☰ — Настройка — Об устройстве будет указана версия Start 9.0.0.</li>\r\n<p></p>\r\n    <p>Если используется версия ниже Start 8.1, сначала используйте файл обновления <a href="http://126008.selcdn.ru/setstart/10.3/START_4.0-8.1.update">START_4.0-8.1.update</a></p>\r\n</ol>\r\n<h4>Для Viki Micro</h4>\r\n<ol>\r\n    <li>Проверьте, что используется версия Start 8.64 или выше (меню ☰ — Настройка — Об устройстве);</li>\r\n    <li>Скачайте файл <a href="https://126008.selcdn.ru/setstart/START-MICRO_8.64-9.0.update">START-MICRO_8.64-9.0.update</a>;</li>\r\n    <li>Положите файл обновления START-MICRO_8.64-9.0.update в каталог обмена кассы (\\\\IP кассы\\exchange\\ или C:\\exchange);</li>\r\n    <li>Перезагрузите кассу, чтобы начать обновление (☰ — Завершение работы — Обновить и перезагрузить);</li>\r\n    <li>После завершения обновления на экране будет написано «Start 9.0.0: Первый запуск после обновления». В меню ☰ — Настройка — Об устройстве будет указана версия Start 9.0.0.\r\n    </li>\r\n<p></p>\r\n    <p>Если используется версия ниже Start 8.64, сначала используйте файлы обновления:\r\n        <ul>\r\n            <li>Для версии с 8.26 до 8.64: <a href="https://126008.selcdn.ru/setstart/START-MICRO_8.26-8.64.update">START-MICRO_8.26-8.64.update</a></li>\r\n            <li>Для версии с 7.21 до 8.26: <a href="https://126008.selcdn.ru/setstart/START-MICRO_7.21-8.26.update">START-MICRO_7.21-8.26.update</a></li>\r\n        </ul>\r\n    </p>\r\n</ol>	Viki Mini, Viki Tower, Viki Classic и Viki Micro	\N	2017-12-22 14:08:57.821
14	Обновление касс Дримкас Старт	dreamkas_start	dreamkas_start	LAST_BARRIER	1	t	t	\N	\N	\N	\N	\N
\.


--
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('products_id_seq', 14, true);


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY projects (id, description, display_name, name) FROM stdin;
1	\N	start	start
2	\N	fisgo	fisgo
3	Агент службы ComProxy	ComProxy	ComProxy
4	\N	connect	connect
\.


--
-- Name: projects_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('projects_id_seq', 3, true);


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users (id, admin, email, image, name, token) FROM stdin;
3	f	v.bochechko@dreamkas.ru	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg	Валентина Бочечко	19d04cd0-136b-4bff-95f5-78d18c5312ed
4	f	d.kashitsin@dreamkas.ru	https://lh6.googleusercontent.com/-oQhBTSU0Oz0/AAAAAAAAAAI/AAAAAAAAAAs/yPKbq95xXbA/photo.jpg	Денис Кашицын	d67f279d-8e4d-4e90-b38b-a36dcf5763f9
1	t	p.tykvin@dreamkas.ru	https://lh6.googleusercontent.com/-BZUDEs37Gec/AAAAAAAAAAI/AAAAAAAAADA/H8Al_SGHqQE/photo.jpg	Павел Тыквин	e4af378e-749e-4e6c-94c7-a9f701a4c602
5	t	raverkov@dreamkas.ru	https://lh5.googleusercontent.com/-ARlDC7tAvMs/AAAAAAAAAAI/AAAAAAAAACk/Nk3uJ7qpQsI/photo.jpg	Роман Аверков	87867a3e-a95c-42e6-98fa-b9dad992f0cb
8	t	yanovsky@dreamkas.ru	https://lh4.googleusercontent.com/-AQZ9ueKG220/AAAAAAAAAAI/AAAAAAAAABg/V7IWZCjtutU/photo.jpg	Александр Яновский	287648c8-6c20-4133-87ca-9a8074817be4
7	t	s.chepinoga@dreamkas.ru	https://lh6.googleusercontent.com/-xdi2uAiE-H0/AAAAAAAAAAI/AAAAAAAAAAs/Ao7TKeTqY0o/photo.jpg	Сергей Чепинога	3f11b39b-1cb2-4c46-b9e6-1440e7ebcde1
9	f	s.malchenko@dreamkas.ru	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg	Сергей Мальченко	cd47a22d-3378-41df-a1e3-211e75bdaad7
10	f	e.ravnjushkin@dreamkas.ru	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg	Елисей Равнюшкин	53a8940a-30bc-4e9d-b375-04d5530bb947
11	f	d.eroshenkov@dreamkas.ru	https://lh4.googleusercontent.com/-qvKhDkccRs4/AAAAAAAAAAI/AAAAAAAAAAs/_v9Y5WnzQDo/photo.jpg	Дмитрий Ерошенков	1ba60aac-4bbe-4b43-920b-3efe4a43a2f7
12	f	iksss.88@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg	Сергей Кузнецов	f060ac71-8bd0-46fc-992a-bb79785e8d43
13	f	pashaeye@gmail.com	https://lh3.googleusercontent.com/-XdUIqdMkCWA/AAAAAAAAAAI/AAAAAAAAAAA/4252rscbv5M/photo.jpg	Kolesnikov Pavel	91afbbdf-5b22-4fcb-96e3-02677a8cea1f
14	f	l.mikhareva@dreamkas.ru	https://lh5.googleusercontent.com/-fZw2kYRNa_A/AAAAAAAAAAI/AAAAAAAAAGs/ruG5JJz0lJw/photo.jpg	Лилия Михарева	d507774a-b9f8-4739-9dde-3e6c393a1edf
2	t	s.kuznetsov@dreamkas.ru	https://lh4.googleusercontent.com/-IWSGzC6KGso/AAAAAAAAAAI/AAAAAAAAAF0/oLTJkgNxyCE/photo.jpg	Сергей Кузнецов	154578df-c94d-4ec8-9af9-68688395f82e
6	f	o.pelkov@crystals.ru	https://lh4.googleusercontent.com/-JeIJ3QB6w7k/AAAAAAAAAAI/AAAAAAAAAPs/y9r4OcgNBqI/photo.jpg	Олег Пельков	bce5b0c9-f475-4b31-8786-dccdb7d9507c
15	f	d.misurkin@crystals.ru	https://lh3.googleusercontent.com/-C9iZWtNxYfQ/AAAAAAAAAAI/AAAAAAAAAAs/z7t9aeGD6ok/photo.jpg	Денис Мисуркин	bde85e26-7acd-4bc4-afc7-fa46853105a8
\.


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('users_id_seq', 15, true);


--
-- Data for Name: users_projects; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY users_projects (users_id, projects_id) FROM stdin;
1	1
2	1
3	2
4	2
1	2
5	1
2	3
6	3
5	3
5	4
6	4
8	1
2	4
9	4
10	4
11	4
5	2
13	2
15	3
7	1
7	2
\.


--
-- Data for Name: versions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY versions (id, full_version, product_id, comparable) FROM stdin;
2	1.0.4	3	1.0.4
5	1.0.5	3	1.0.5
6	1.0.6	3	1.0.6
7	1.0.7	3	1.0.7
8	1.0.8	3	1.0.8
9	1.0.9	3	1.0.9
10	1.0.10	3	1.0.10
11	1.1.0	3	1.1.0
12	1.1.1	3	1.1.1
13	1.1.2	3	1.1.2
14	1.1.3	3	1.1.3
15	1.1.4	3	1.1.4
16	1.1.5	3	1.1.5
17	1.0.2	3	1.0.2
18	1.0.3	3	1.0.3
19	1.2.7	3	1.2.7
20	1.1.6	3	1.1.6
21	1.1.7	3	1.1.7
22	1.1.8	3	1.1.8
23	1.1.9	3	1.1.9
24	1.1.11	3	1.1.11
25	1.2.3	3	1.2.3
26	1.1.13	3	1.1.13
27	1.1.14	3	1.1.14
28	1.1.15	3	1.1.15
29	1.1.10	3	1.1.10
30	1.1.12	3	1.1.12
31	1.1.20	3	1.1.20
32	1.2.0	3	1.2.0
33	1.2.1	3	1.2.1
34	1.2.2	3	1.2.2
35	1.2.4	3	1.2.4
36	1.2.5	3	1.2.5
37	2.0.5	6	2.0.5
38	1.2.6	3	1.2.6
39	9.0.0	1	9.0.0
41	9.0.1	1	9.0.1
43	1.2.8	3	1.2.8
44	9.1.0	1	9.1.0
45	1.2.10	3	1.2.10
46	9.1.1	1	9.1.1
47	9.2.0-alpha.446	1	9.2.0-alpha.446
48	9.2.0-alpha.449	1	9.2.0-alpha.449
49	9.2.0-alpha.451	1	9.2.0-alpha.451
50	1.2.14	3	1.2.14
51	1.2.12	3	1.2.12
52	1.2.15	3	1.2.15
53	9.3.2	2	9.3.2
54	9.3.1	2	9.3.1
55	9.3.3	2	9.3.3
56	1.3.3	3	1.3.3
57	1.3.4	3	1.3.4
59	9.3.5	1	9.3.5
60	9.3.6	1	9.3.6
62	1.0.0	4	1.0.0
63	1.0.1	7	1.0.1
71	2.0.5	7	2.0.5
72	1.3.3	9	1.3.3
73	670.0.0	10	670.0.0
74	570.0.0	11	570.0.0
75	1.0.0	12	1.0.0
76	1.3.5	3	1.3.5
77	9.3.7	1	9.3.7
78	1.0.1	4	1.0.1
79	1.3.6	3	1.3.6
80	1.3.7	3	1.3.7
81	1.3.8	3	1.3.8
82	2.1.6	6	2.1.6
83	670.0.1	10	670.0.1
84	9.4.0	1	9.4.0
85	9.4.1	1	9.4.1
86	9.5.0	1	9.5.0
87	9.5.1	1	9.5.1
88	1.3.9	3	1.3.9
89	570.0.2	11	570.0.2
90	1.3.11	3	1.3.11
91	1.3.4	9	1.3.4
92	1.0.1	12	1.0.1
93	9.6.0	1	9.6.0
94	1.3.12	3	1.3.12
96	9.7.0	1	9.7.0
97	9.7.1	1	9.7.1
98	9.3.7	14	9.3.7
99	9.3.8	14	9.3.8
\.


--
-- Name: versions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('versions_id_seq', 99, true);


--
-- Name: manual_updates manual_updates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manual_updates
    ADD CONSTRAINT manual_updates_pkey PRIMARY KEY (id);


--
-- Name: patches patches_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patches
    ADD CONSTRAINT patches_pkey PRIMARY KEY (id);


--
-- Name: patches patches_product_id_version_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patches
    ADD CONSTRAINT patches_product_id_version_id_key UNIQUE (product_id, version_id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: patches uk1gc4apnb6sfu17idrhlgrj6o5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patches
    ADD CONSTRAINT uk1gc4apnb6sfu17idrhlgrj6o5 UNIQUE (product_id, version_id, version_from_id);


--
-- Name: projects uk_1e447b96pedrvtxw44ot4qxem; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT uk_1e447b96pedrvtxw44ot4qxem UNIQUE (name);


--
-- Name: users uk_6dotkott2kjsp8vw4d0m25fb7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT uk_6dotkott2kjsp8vw4d0m25fb7 UNIQUE (email);


--
-- Name: products uk_o61fmio5yukmmiqgnxf8pnavn; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT uk_o61fmio5yukmmiqgnxf8pnavn UNIQUE (name);


--
-- Name: manual_updates uka0fq42ggwb4xwvsdqyn130rfg; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manual_updates
    ADD CONSTRAINT uka0fq42ggwb4xwvsdqyn130rfg UNIQUE (product_id, version_to_id, version_from_id);


--
-- Name: versions ukmkc5ug989xychxf75jcvkn61s; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT ukmkc5ug989xychxf75jcvkn61s UNIQUE (full_version, product_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: users_projects fk1wq47u13qkt3icnwbuhw4sei3; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_projects
    ADD CONSTRAINT fk1wq47u13qkt3icnwbuhw4sei3 FOREIGN KEY (projects_id) REFERENCES projects(id);


--
-- Name: manual_updates fk2nqi38anietqdxj052y1gyxqu; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manual_updates
    ADD CONSTRAINT fk2nqi38anietqdxj052y1gyxqu FOREIGN KEY (version_to_id) REFERENCES versions(id);


--
-- Name: patches fk58fcu76rqm8hi6uv3r0ig35fe; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patches
    ADD CONSTRAINT fk58fcu76rqm8hi6uv3r0ig35fe FOREIGN KEY (version_id) REFERENCES versions(id);


--
-- Name: manual_updates fkafy0vodty4c2bmrf31ubyxuu0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manual_updates
    ADD CONSTRAINT fkafy0vodty4c2bmrf31ubyxuu0 FOREIGN KEY (version_from_id) REFERENCES versions(id);


--
-- Name: products fkdjd5tux3sl0urf5yyat0fnqo7; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fkdjd5tux3sl0urf5yyat0fnqo7 FOREIGN KEY (project_id) REFERENCES projects(id);


--
-- Name: users_projects fkhcr3t491sjt9yk1kmckf6vjo2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY users_projects
    ADD CONSTRAINT fkhcr3t491sjt9yk1kmckf6vjo2 FOREIGN KEY (users_id) REFERENCES users(id);


--
-- Name: patches fkl960l1nfkssaj6rmh027ms6tg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patches
    ADD CONSTRAINT fkl960l1nfkssaj6rmh027ms6tg FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: patches fkombdpjrwg9d7kghmkrjr1t9l6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY patches
    ADD CONSTRAINT fkombdpjrwg9d7kghmkrjr1t9l6 FOREIGN KEY (version_from_id) REFERENCES versions(id);


--
-- Name: versions fkq181hapbqgu9v2orn3a180upl; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT fkq181hapbqgu9v2orn3a180upl FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: manual_updates fkq5mkd2xyaamdca3y5dfsytein; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY manual_updates
    ADD CONSTRAINT fkq5mkd2xyaamdca3y5dfsytein FOREIGN KEY (product_id) REFERENCES products(id);


--
-- Name: products fktg6wn5mwlsrvgrm09gds7leox; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fktg6wn5mwlsrvgrm09gds7leox FOREIGN KEY (parent_id) REFERENCES products(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

