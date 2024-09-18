--
-- PostgreSQL database dump
--

-- Dumped from database version 14.8 (Ubuntu 14.8-0ubuntu0.22.04.1)
-- Dumped by pg_dump version 14.8

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
-- Name: update_total_price(); Type: FUNCTION; Schema: public; Owner: vlad
--

CREATE FUNCTION public.update_total_price() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  NEW.tax_price := (SELECT price_order FROM orders WHERE orders.id_order = NEW.id_order) * 0.08;
  RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_total_price() OWNER TO vlad;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: clients; Type: TABLE; Schema: public; Owner: vlad
--

CREATE TABLE public.clients (
    id_client integer NOT NULL,
    last_name character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    phone_number character varying(100) NOT NULL
);


ALTER TABLE public.clients OWNER TO vlad;

--
-- Name: clients_id_client_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

ALTER TABLE public.clients ALTER COLUMN id_client ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.clients_id_client_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: company; Type: TABLE; Schema: public; Owner: vlad
--

CREATE TABLE public.company (
    id_company integer NOT NULL,
    name_company character varying(100) NOT NULL,
    address_company character varying(100) NOT NULL,
    phone_number bigint NOT NULL
);


ALTER TABLE public.company OWNER TO vlad;

--
-- Name: company_id_company_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

ALTER TABLE public.company ALTER COLUMN id_company ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.company_id_company_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: projects; Type: TABLE; Schema: public; Owner: vlad
--

CREATE TABLE public.projects (
    id_project integer NOT NULL,
    name_project character varying(200) NOT NULL,
    date_project date NOT NULL,
    status_project character varying(100) NOT NULL,
    client_project integer NOT NULL,
    id_techno integer NOT NULL
);


ALTER TABLE public.projects OWNER TO vlad;

--
-- Name: projects_id_project_seq; Type: SEQUENCE; Schema: public; Owner: vlad
--

ALTER TABLE public.projects ALTER COLUMN id_project ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.projects_id_project_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: sys_integrator; Type: TABLE; Schema: public; Owner: vlad
--

CREATE TABLE public.sys_integrator (
    id_integrator integer NOT NULL,
    last_name character varying(100) NOT NULL,
    first_name character varying(100) NOT NULL,
    job_title character varying(100) NOT NULL,
    phone_number bigint NOT NULL,
    salary integer NOT NULL,
    id_project integer NOT NULL,
    id_company integer NOT NULL
);


ALTER TABLE public.sys_integrator OWNER TO vlad;

--
-- Name: technologies; Type: TABLE; Schema: public; Owner: vlad
--

CREATE TABLE public.technologies (
    id_techno integer NOT NULL,
    name_techno character varying(100) NOT NULL,
    info_techno character varying(200) NOT NULL,
    degree_complexity integer NOT NULL
);


ALTER TABLE public.technologies OWNER TO vlad;

--
-- Data for Name: clients; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY public.clients (id_client, last_name, first_name, phone_number) FROM stdin;
1	Ivanov	Ivan	89771234567
2	Pavlov	Andrey	89770987654
4	Samsonova	Irina	89778889977
5	Kravzov	Sergey	89775234598
6	Nosova	Masha	89772987224
7	Rimova	Ksenia	89773344334
8	Sokolov	Maxim	89779779977
9	Androsov	Misha	89779675454
10	Ermolaeva	Olga	89773456789
3	Smirnov	Oleg	89771245464
\.


--
-- Data for Name: company; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY public.company (id_company, name_company, address_company, phone_number) FROM stdin;
1	IBS_Platformix	Moscow,st._Skladochnaya,3	84959678050
2	INLINE_Technologies	Moscow,Volokolamsky_pr-d,10с1	88002007430
3	Rubytech	Moscow,st._Godovikova,9	84957889999
4	Softline	Moscow,Derbenevskaya_embankment,7	84952320023
5	STEP_LOGIC	Moscow,p._Moskovsky,Kyiv_highway,22	84957753120
6	TEGRUS	Krasnogorsk,Boulevard_Builders,4	84952800230
7	Abak-2000	Moscow,st._Aviamotornaya,8	88003012000
8	ICL	Kazan,st._Siberian_tract,34	88438279582
9	X-Com	Moscow,Kronstadtsky_boulevard,_3A	84998771308
10	Т1	Moscow,st._Yunosti,13	84957907979
\.


--
-- Data for Name: projects; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY public.projects (id_project, name_project, date_project, status_project, client_project, id_techno) FROM stdin;
1	CRM_system_integration	2023-05-17	Processing	8	1
2	CRM_Development	2023-02-10	Job	5	3
3	Installation_and configuration_of_video_surveillance_system	2023-05-08	Completed	6	4
5	Development_of_project_management_system	2023-01-28	Completed	7	8
6	Integration_of_CorpSys_with_suppliers_and_partners	2023-02-20	Job	5	3
7	Implementation_of_an_electronic_document_management_system	2023-05-26	Job	4	8
8	Implementation_of_cloud_computing	2023-04-09	Completed	3	7
9	Creation_of_a_single_platform_for_managing_information_about_employees_in_the_organization	2023-05-03	Processing	10	6
10	ERP_integration	2023-07-14	Completed	8	1
11	API_integration	2023-02-16	Job	2	1
12	Creation_of_a_system_for_automatic_monitoring_and_management_of_the_network_infrastructure_of_an_enterprise	2023-01-25	Processing	7	6
13	Implementation_of_a_contact_center_management_system_for_processing_client_requests	2023-03-14	Processing	1	5
14	Development_and_integration_of_a_data_analytics_system_to_obtain_valuable_business_insights	2023-07-28	Job	9	3
15	HRM_integration	2023-06-11	Completed	3	1
16	Deploying_and_configuring_a_performance_monitoring_system_for_applications_and_infrastructure	2023-01-22	Processing	10	2
17	E-commerce_integration	2023-01-14	Completed	6	1
18	MES_with_ERP_integration	2023-08-05	Processing	1	1
20	Development_and_integration_of_information_security_management_system.	2023-05-04	Job	9	5
19	Development_and_implementation_of_a_payment_processing_system_and_financial_analytics	2023-01-10	Processing	3	2
4	Application_integration_for_business_process_automation	2023-01-04	Processing	10	3
\.


--
-- Data for Name: sys_integrator; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY public.sys_integrator (id_integrator, last_name, first_name, job_title, phone_number, salary, id_project, id_company) FROM stdin;
1	Petrov	Vladislav	Chief_Integrator	88967052700	400000	1	1
2	Aksenova	Valeria	Integrator_2nd_category	88952036621	150000	2	2
3	Vinokurov	Artemy	Integrator_1st_category	88961553240	200000	3	3
4	Vorobieva	Svetlana	Integrator_3rd_category	88921431138	100000	4	4
5	Dorokhov	Alexey	Integrator_2nd_category	88924558037	150000	5	5
6	Dubinina	Sofia	Integrator_1st_category	88922923229	200000	6	6
7	Evseev	Daniel	Integrator_3rd_category	88996147326	100000	7	7
8	Zakharov	Nikolai	Lead_integrator	88955742687	300000	8	8
9	Ivanov	Timofey	Lead_integrator	88958481063	300000	9	9
10	Kondratova	Arina	Integrator_3rd_category	88995992039	100000	10	10
11	Orlova	Anna	Integrator_1st_category	88938233933	200000	11	1
12	Ignatov	Misha	Integrator_1st_category	88931968212	200000	12	2
13	Makarov	Artyom	Integrator_2nd_category	88905944080	150000	13	3
14	Maksimov	Mark	Chief_Integrator	88964371452	400000	14	4
15	Maslova	Sofia	Integrator_3rd_category	88961463618	100000	15	5
16	Mikhailov	Nikita	Integrator_3rd_category	88962990130	100000	16	6
17	Oleinikova	Victoria	Technician	88969382217	50000	17	7
18	Panova	Yaroslava	Integrator_2nd_category	88905952375	150000	18	8
19	Sokolova	Veronika	Integrator_3rd_category	88920848514	100000	19	9
20	Ulyanov	Sergey	Technician	88961896710	50000	20	10
21	Abramov	Egor	Technician	84950000000	30000	14	8
22	Abramov	Alexey	Chief_Integrator	84950000001	150000	17	4
23	Abramov	Matvey	Chief_Integrator	84950000002	150000	16	4
24	Avdeev	Roman	Integrator_2nd_category	84950000003	60000	9	9
25	Avdeev	Nikita	Integrator_1st_category	84950000004	70000	3	9
26	Avdeev	Egor	Integrator_2nd_category	84950000005	60000	2	5
27	Agafonov	Miroslav	Integrator_3rd_category	84950000006	50000	8	8
28	Ageev	Mikhail	Technician	84950000007	30000	9	8
29	Ageev	Mikhail	Integrator_3rd_category	84950000008	50000	10	9
30	Ageev	Maxim	Lead_integrator	84950000009	300000	19	5
31	Ageev	Miron	Integrator_3rd_category	84950000010	50000	6	6
32	Akimov	Mark	Integrator_3rd_category	84950000011	50000	6	9
33	Akimov	Ivan	Technician	84950000012	30000	8	9
34	Aksenov	Andrey	Lead_integrator	84950000013	300000	16	10
35	Aleksandrov	Egor	Integrator_2nd_category	84950000014	60000	14	3
36	Alexandrov	Miron	Integrator_2nd_category	84950000015	60000	15	2
37	Aleksandrov	Maxim	Chief_Integrator	84950000016	150000	4	3
38	Aleksandrov	Ivan	Integrator_3rd_category	84950000017	50000	8	5
39	Aleksandrov	Vladimir	Technician	84950000018	30000	18	9
40	Alekseev	Maxim	Integrator_2nd_category	84950000019	60000	6	2
41	Alekseev	Denis	Integrator_2nd_category	84950000020	60000	8	10
42	Alekseev	Dmitry	Lead_integrator	84950000021	300000	1	8
43	Alekseev	Roman	Integrator_2nd_category	84950000022	60000	19	10
44	Alekseev	Georgy	Technician	84950000023	30000	4	1
45	Alekseev	Daniil	Integrator_3rd_category	84950000024	50000	8	2
46	Alekseev	Alexander	Lead_integrator	84950000025	300000	10	10
47	Alekseev	Maxim	Integrator_1st_category	84950000026	70000	19	7
48	Alekseev	Artyom	Lead_integrator	84950000027	300000	2	2
49	Alekseev	Fedor	Chief_Integrator	84950000028	150000	18	2
50	Alekseev	Semyon	Technician	84950000029	30000	13	3
51	Alekseev	Sergey	Integrator_3rd_category	84950000030	50000	5	4
52	Alekseev	Artyom	Integrator_3rd_category	84950000031	50000	3	3
53	Alekseev	Alexander	Chief_Integrator	84950000032	150000	9	7
54	Alekhin	Kirill	Integrator_2nd_category	84950000033	60000	19	9
55	Ananiev	Stepan	Chief_Integrator	84950000034	150000	10	10
56	Ananiev	Boris	Integrator_1st_category	84950000035	70000	18	1
57	Ananiev	Leon	Integrator_2nd_category	84950000036	60000	10	7
58	Ananiev	Matvey	Lead_integrator	84950000037	300000	3	4
59	Andreev	Miroslav	Integrator_3rd_category	84950000038	50000	9	5
60	Andreev	Maxim	Integrator_2nd_category	84950000039	60000	8	1
61	Andreev	Luka	Technician	84950000040	30000	11	3
62	Andreev	Maxim	Integrator_1st_category	84950000041	70000	7	3
63	Andreev	Dmitry	Integrator_1st_category	84950000042	70000	13	7
64	Andreev	Gleb	Integrator_1st_category	84950000043	70000	1	3
65	Andreev	Nikita	Integrator_2nd_category	84950000044	60000	10	10
66	Andreev	Dmitry	Integrator_3rd_category	84950000045	50000	16	7
67	Andrianov	Stepan	Technician	84950000046	30000	16	3
68	Anikin	Mikhail	Chief_Integrator	84950000047	150000	1	3
69	Anikin	Matvey	Lead_integrator	84950000048	300000	6	1
70	Anikin	Roman	Integrator_2nd_category	84950000049	60000	19	2
71	Anisimov	Nikolay	Integrator_1st_category	84950000050	70000	14	4
72	Anisimov	Mikhail	Integrator_2nd_category	84950000051	60000	2	4
73	Anisimov	Alexander	Technician	84950000052	30000	20	2
74	Antipov	Maxim	Integrator_3rd_category	84950000053	50000	8	6
75	Antonov	Maxim	Lead_integrator	84950000054	300000	18	5
76	Antonov	Artyom	Integrator_3rd_category	84950000055	50000	8	3
77	Antonov	Daniil	Technician	84950000056	30000	6	9
78	Antonov	Lev	Integrator_3rd_category	84950000057	50000	8	5
79	Artemov	Daniil	Lead_integrator	84950000058	300000	19	8
80	Artemov	Mikhail	Integrator_1st_category	84950000059	70000	1	5
81	Astafiev	Daniil	Chief_Integrator	84950000060	150000	10	3
82	Astafiev	Vsevolod	Integrator_3rd_category	84950000061	50000	15	4
83	Astakhov	Konstantin	Integrator_3rd_category	84950000062	50000	2	10
84	Afanasiev	Artemy	Lead_integrator	84950000063	300000	2	7
85	Afanasiev	Artyom	Integrator_3rd_category	84950000064	50000	16	7
86	Afanasiev	Vladislav	Chief_Integrator	84950000065	150000	10	2
87	Bazhenov	Ivan	Chief_Integrator	84950000066	150000	6	6
88	Bazhenov	Dmitry	Technician	84950000067	30000	9	5
89	Bazhenov	Anton	Integrator_1st_category	84950000068	70000	10	5
90	Bazhenov	Zakhar	Integrator_2nd_category	84950000069	60000	4	9
91	Balashov	Serafim	Technician	84950000070	30000	15	5
92	Baranov	Matvey	Integrator_2nd_category	84950000071	60000	5	6
93	Baranov	Semyon	Lead_integrator	84950000072	300000	3	10
94	Baranov	Alexander	Integrator_2nd_category	84950000073	60000	4	6
95	Basov	Daniel	Technician	84950000074	30000	5	3
96	Bezrukov	Nikita	Integrator_2nd_category	84950000075	60000	9	8
97	Belov	Ivan	Technician	84950000076	30000	9	2
98	Belov	Timur	Integrator_3rd_category	84950000077	50000	4	1
99	Belov	Vladislav	Integrator_1st_category	84950000078	70000	20	1
100	Belov	Vadim	Technician	84950000079	30000	8	9
101	Belousov	Bogdan	Technician	84950000080	30000	9	4
102	Belousov	Artyom	Integrator_1st_category	84950000081	70000	3	2
103	Belyaev	Timofey	Lead_integrator	84950000082	300000	15	10
104	Belyaev	Nikita	Integrator_2nd_category	84950000083	60000	20	5
105	Belyakov	Pavel	Chief_Integrator	84950000084	150000	7	5
106	Berezin	Artyom	Lead_integrator	84950000085	300000	10	3
107	Berezin	Matvey	Integrator_2nd_category	84950000086	60000	18	8
108	Biryukov	Alexander	Chief_Integrator	84950000087	150000	16	8
109	Biryukov	Alexander	Lead_integrator	84950000088	300000	17	8
110	Blokhin	Dmitry	Integrator_2nd_category	84950000089	60000	15	3
111	Bobrov	Rodion	Lead_integrator	84950000090	300000	11	3
112	Bogdanov	Maxim	Technician	84950000091	30000	10	5
113	Bogdanov	Maxim	Integrator_2nd_category	84950000092	60000	10	7
114	Bogdanov	Ilya	Lead_integrator	84950000093	300000	4	6
115	Bogdanov	Timofey	Integrator_1st_category	84950000094	70000	4	9
116	Bogdanov	Roman	Lead_integrator	84950000095	300000	2	5
117	Bogomolov	Yuri	Integrator_1st_category	84950000096	70000	5	9
118	Bogomolov	Alexander	Lead_integrator	84950000097	300000	20	8
119	Bondarev	Alexander	Chief_Integrator	84950000098	150000	17	7
120	Borisov	Ivan	Integrator_3rd_category	84950000099	50000	16	6
121	Borisov	Ilya	Technician	84950000100	30000	6	2
122	Borisov	Mark	Integrator_1st_category	84950000101	70000	7	7
123	Borisov	Matvey	Technician	84950000102	30000	4	9
124	Borisov	Daniil	Integrator_2nd_category	84950000103	60000	14	2
125	Borisov	Grigory	Integrator_3rd_category	84950000104	50000	3	5
126	Borisov	Nikita	Technician	84950000105	30000	20	4
127	Borodin	Timur	Lead_integrator	84950000106	300000	13	2
128	Bocharov	Oleg	Chief_Integrator	84950000107	150000	18	8
129	Bocharov	Ivan	Lead_integrator	84950000108	300000	5	6
130	Bulatov	Viktor	Integrator_2nd_category	84950000109	60000	11	1
131	Bulatov	Konstantin	Technician	84950000110	30000	1	1
132	Bulgakov	Matvey	Integrator_1st_category	84950000111	70000	16	9
133	Burov	Kirill	Technician	84950000112	30000	3	8
134	Bychkov	Alexey	Integrator_2nd_category	84950000113	60000	1	9
135	Vavilov	Alexey	Lead_integrator	84950000114	300000	15	3
136	Vasiliev	Grigory	Integrator_2nd_category	84950000115	60000	4	1
137	Vasiliev	Stanislav	Lead_integrator	84950000116	300000	17	7
138	Vasiliev	Konstantin	Integrator_3rd_category	84950000117	50000	19	4
139	Vasiliev	Luka	Integrator_2nd_category	84950000118	60000	10	1
140	Vasiliev	Vsevolod	Technician	84950000119	30000	12	4
141	Vasiliev	Denis	Integrator_3rd_category	84950000120	50000	16	9
142	Vasiliev	Vadim	Chief_Integrator	84950000121	150000	9	3
143	Vasiliev	Artyom	Technician	84950000122	30000	12	4
144	Vasiliev	Stepan	Integrator_1st_category	84950000123	70000	11	8
145	Vasiliev	Mikhail	Technician	84950000124	30000	2	3
146	Vinogradov	Timofey	Lead_integrator	84950000125	300000	18	1
147	Vinogradov	Maxim	Integrator_2nd_category	84950000126	60000	19	10
148	Vinogradov	Artyom	Technician	84950000127	30000	4	4
149	Vinogradov	Matvey	Technician	84950000128	30000	18	4
150	Vinogradov	Matvey	Lead_integrator	84950000129	300000	4	9
151	Vinogradov	Roman	Integrator_2nd_category	84950000130	60000	16	3
152	Vinogradov	Ivan	Integrator_1st_category	84950000131	70000	17	2
153	Vinogradov	Miroslav	Integrator_2nd_category	84950000132	60000	15	9
154	Vinogradov	Daniel	Integrator_1st_category	84950000133	70000	3	2
155	Vladimirov	Yaroslav	Technician	84950000134	30000	1	5
156	Vladimirov	Georgy	Lead_integrator	84950000135	300000	15	4
157	Vladimirov	Kirill	Integrator_1st_category	84950000136	70000	5	6
158	Vladimirov	Vladimir	Lead_integrator	84950000137	300000	11	1
159	Volkov	Stepan	Technician	84950000138	30000	1	3
160	Volkov	Artyom	Integrator_3rd_category	84950000139	50000	1	4
161	Volkov	Mikhail	Lead_integrator	84950000140	300000	4	2
162	Volkov	Maxim	Integrator_2nd_category	84950000141	60000	9	5
163	Volkov	Vladislav	Chief_Integrator	84950000142	150000	15	7
164	Volkov	Matvey	Chief_Integrator	84950000143	150000	16	3
165	Vorobyov	Yaroslav	Integrator_1st_category	84950000144	70000	4	9
166	Vorobyov	Mark	Integrator_3rd_category	84950000145	50000	16	7
167	Vorobyov	Maxim	Integrator_2nd_category	84950000146	60000	7	10
168	Vorobyov	Artur	Lead_integrator	84950000147	300000	10	7
169	Vorobyov	Artyom	Lead_integrator	84950000148	300000	12	2
170	Vorobyov	Dmitry	Technician	84950000149	30000	9	1
171	Vorobyov	Adam	Integrator_2nd_category	84950000150	60000	9	2
172	Vorobyov	Nikita	Lead_integrator	84950000151	300000	1	4
173	Voronin	Ruslan	Technician	84950000152	30000	5	10
174	Voronin	Artyom	Lead_integrator	84950000153	300000	7	4
175	Voronin	Alexander	Integrator_3rd_category	84950000154	50000	6	6
176	Voronov	Sergey	Integrator_2nd_category	84950000155	60000	20	10
177	Vysotsky	Lev	Integrator_1st_category	84950000156	70000	4	2
178	Vysotsky	Miroslav	Integrator_2nd_category	84950000157	60000	8	4
179	Gavrilov	Makar	Integrator_1st_category	84950000158	70000	4	6
180	Gavrilov	Stepan	Integrator_1st_category	84950000159	70000	15	3
181	Gavrilov	Timur	Chief_Integrator	84950000160	150000	9	6
182	Gavrilov	Yuri	Lead_integrator	84950000161	300000	3	2
183	Galkin	Dmitry	Integrator_2nd_category	84950000162	60000	10	3
184	Gerasimov	Ilya	Integrator_3rd_category	84950000163	50000	4	4
185	Gerasimov	Alexey	Integrator_2nd_category	84950000164	60000	3	3
186	Gerasimov	Yaroslav	Lead_integrator	84950000165	300000	1	1
187	Gerasimov	Grigory	Integrator_1st_category	84950000166	70000	17	1
188	Gerasimov	Matvey	Integrator_1st_category	84950000167	70000	13	7
189	Golovanov	Maxim	Technician	84950000168	30000	10	2
190	Golovin	Arseniy	Lead_integrator	84950000169	300000	2	3
191	Golubev	Mark	Technician	84950000170	30000	12	7
192	Golubev	Ivan	Lead_integrator	84950000171	300000	3	9
193	Golubev	German	Technician	84950000172	30000	8	4
194	Goncharov	Roman	Chief_Integrator	84950000173	150000	19	7
195	Goncharov	Daniel	Chief_Integrator	84950000174	150000	19	4
196	Goncharov	Artyom	Technician	84950000175	30000	11	1
197	Goncharov	Roman	Integrator_1st_category	84950000176	70000	16	9
198	Goncharov	Mark	Integrator_3rd_category	84950000177	50000	7	2
199	Goncharov	Alexey	Chief_Integrator	84950000178	150000	9	4
200	Gorbachev	Konstantin	Integrator_1st_category	84950000179	70000	9	3
201	Gorbachev	Dmitry	Integrator_2nd_category	84950000180	60000	2	1
202	Gorbachev	Nikita	Technician	84950000181	30000	3	9
203	Gorbachev	Kirill	Integrator_3rd_category	84950000182	50000	13	9
204	Gorelov	Georgy	Chief_Integrator	84950000183	150000	16	8
205	Gorshkov	Kirill	Technician	84950000184	30000	3	7
206	Gorshkov	Elisey	Integrator_1st_category	84950000185	70000	5	5
207	Goryachev	Mark	Chief_Integrator	84950000186	150000	3	9
208	Grachev	Timofey	Lead_integrator	84950000187	300000	8	10
209	Grekov	Matvey	Lead_integrator	84950000188	300000	4	1
210	Grigoriev	Artyom	Chief_Integrator	84950000189	150000	10	8
211	Grigoriev	Tikhon	Integrator_3rd_category	84950000190	50000	16	1
212	Grigoriev	Ilya	Lead_integrator	84950000191	300000	3	3
213	Grigoriev	Lev	Lead_integrator	84950000192	300000	3	6
214	Grigoriev	Kirill	Integrator_3rd_category	84950000193	50000	1	3
215	Grigoriev	Andrey	Integrator_3rd_category	84950000194	50000	8	3
216	Grigoriev	Bogdan	Lead_integrator	84950000195	300000	20	5
217	Grigoriev	Oleg	Lead_integrator	84950000196	300000	13	1
218	Grishin	Kirill	Integrator_1st_category	84950000197	70000	3	7
219	Gromov	Ilya	Integrator_2nd_category	84950000198	60000	8	7
220	Gromov	Artyom	Integrator_2nd_category	84950000199	60000	14	5
221	Gromov	Nikolay	Chief_Integrator	84950000200	150000	4	4
222	Gulyaev	Vadim	Integrator_3rd_category	84950000201	50000	13	3
223	Gulyaev	Timofey	Chief_Integrator	84950000202	150000	9	10
224	Gusev	Timofey	Lead_integrator	84950000203	300000	2	7
225	Gusev	Artyom	Lead_integrator	84950000204	300000	9	6
226	Gusev	Mikhail	Lead_integrator	84950000205	300000	20	3
227	Gushchin	Petr	Lead_integrator	84950000206	300000	9	2
228	Davydov	Alexander	Integrator_3rd_category	84950000207	50000	19	2
229	Davydov	Gleb	Lead_integrator	84950000208	300000	7	9
230	Davydov	Mark	Integrator_3rd_category	84950000209	50000	7	9
231	Davydov	Maxim	Integrator_2nd_category	84950000210	60000	5	9
232	Davydov	Dmitry	Integrator_2nd_category	84950000211	60000	8	7
233	Davydov	Stepan	Integrator_2nd_category	84950000212	60000	13	8
234	Davydov	Kirill	Integrator_3rd_category	84950000213	50000	6	7
235	Danilov	Gleb	Integrator_3rd_category	84950000214	50000	14	8
236	Danilov	Timofey	Integrator_3rd_category	84950000215	50000	12	1
237	Danilov	Makar	Integrator_3rd_category	84950000216	50000	5	7
238	Danilov	Gleb	Integrator_2nd_category	84950000217	60000	4	1
239	Danilov	Matvey	Chief_Integrator	84950000218	150000	15	3
240	Danilov	Daniel	Integrator_2nd_category	84950000219	60000	15	1
241	Danilov	Fedor	Technician	84950000220	30000	20	7
242	Danilov	Ruslan	Chief_Integrator	84950000221	150000	13	1
243	Degtyarev	Robert	Chief_Integrator	84950000222	150000	14	9
244	Degtyarev	Fedor	Chief_Integrator	84950000223	150000	2	8
245	Degtyarev	Yaroslav	Lead_integrator	84950000224	300000	19	1
246	Degtyarev	Dmitry	Integrator_1st_category	84950000225	70000	13	7
247	Dementiev	Alexander	Chief_Integrator	84950000226	150000	2	7
248	Dementiev	Gleb	Lead_integrator	84950000227	300000	4	10
249	Demidov	Dmitry	Chief_Integrator	84950000228	150000	9	7
250	Demidov	Peter	Integrator_3rd_category	84950000229	50000	20	10
251	Demin	Kirill	Integrator_3rd_category	84950000230	50000	9	8
252	Denisov	Oleg	Technician	84950000231	30000	18	3
253	Denisov	Timofey	Technician	84950000232	30000	7	1
254	Dmitriev	Miroslav	Integrator_3rd_category	84950000233	50000	6	9
255	Dmitriev	Mark	Integrator_3rd_category	84950000234	50000	8	1
256	Dmitriev	Nikita	Lead_integrator	84950000235	300000	20	7
257	Dmitriev	Roman	Integrator_1st_category	84950000236	70000	17	5
258	Dorofeev	Maxim	Integrator_3rd_category	84950000237	50000	2	10
259	Dorokhov	Sergey	Integrator_1st_category	84950000238	70000	16	6
260	Dyakonov	Dmitry	Integrator_2nd_category	84950000239	60000	2	3
261	Dyakonov	Vladimir	Integrator_3rd_category	84950000240	50000	19	9
262	Dyakonov	Maxim	Technician	84950000241	30000	18	10
263	Evdokimov	Peter	Integrator_1st_category	84950000242	70000	15	4
264	Evdokimov	Artyom	Integrator_2nd_category	84950000243	60000	17	7
265	Evdokimov	Sergey	Integrator_2nd_category	84950000244	60000	1	8
266	Evseev	Alexey	Chief_Integrator	84950000245	150000	8	2
267	Egorov	Alexander	Integrator_3rd_category	84950000246	50000	8	3
268	Egorov	Dmitry	Technician	84950000247	30000	15	2
269	Egorov	Roman	Technician	84950000248	30000	10	10
270	Egorov	Savva	Integrator_3rd_category	84950000249	50000	1	10
271	Egorov	Grigory	Lead_integrator	84950000250	300000	14	10
272	Egorov	Konstantin	Integrator_2nd_category	84950000251	60000	8	6
273	Egorov	Mikhail	Integrator_1st_category	84950000252	70000	16	9
274	Elizarov	Nikolay	Integrator_3rd_category	84950000253	50000	3	3
275	Eliseev	Nikolay	Integrator_2nd_category	84950000254	60000	3	10
276	Eliseev	Leonid	Integrator_2nd_category	84950000255	60000	8	3
277	Eliseev	Ilya	Integrator_2nd_category	84950000256	60000	13	7
278	Emelyanov	Matvey	Lead_integrator	84950000257	300000	12	4
279	Emelyanov	Miron	Technician	84950000258	30000	5	5
280	Emelyanov	Kirill	Integrator_2nd_category	84950000259	60000	2	1
281	Eremeev	Anton	Integrator_1st_category	84950000260	70000	2	10
282	Eremin	Maxim	Lead_integrator	84950000261	300000	12	10
283	Ermakov	Yaroslav	Technician	84950000262	30000	6	4
284	Ermakov	Timur	Lead_integrator	84950000263	300000	10	10
285	Ermakov	Anton	Integrator_3rd_category	84950000264	50000	20	9
286	Ermakov	Andrey	Integrator_2nd_category	84950000265	60000	11	3
287	Ermakov	Roman	Integrator_3rd_category	84950000266	50000	4	1
288	Erofeev	Makar	Technician	84950000267	30000	14	10
289	Ershov	Georgy	Chief_Integrator	84950000268	150000	2	10
290	Efimov	Daniil	Lead_integrator	84950000269	300000	13	10
291	Efimov	Grigory	Lead_integrator	84950000270	300000	17	8
292	Efimov	Grigory	Chief_Integrator	84950000271	150000	2	2
293	Efremov	Igor	Lead_integrator	84950000272	300000	4	3
294	Efremov	Artyom	Integrator_3rd_category	84950000273	50000	3	7
295	Zhdanov	Dmitry	Integrator_2nd_category	84950000274	60000	8	9
296	Zhilin	Gleb	Integrator_1st_category	84950000275	70000	18	7
297	Zhukov	Kirill	Integrator_1st_category	84950000276	70000	10	1
298	Zhukov	Mikhail	Integrator_2nd_category	84950000277	60000	3	6
299	Zhukov	Timofey	Technician	84950000278	30000	13	8
300	Zhukov	Gleb	Chief_Integrator	84950000279	150000	11	4
301	Zhukov	Artyom	Integrator_1st_category	84950000280	70000	19	6
302	Zhukov	Savva	Integrator_3rd_category	84950000281	50000	16	8
303	Zhukov	Yaroslav	Integrator_2nd_category	84950000282	60000	18	5
304	Zhuravlev	Artyom	Integrator_1st_category	84950000283	70000	5	10
305	Zhuravlev	Nikolai	Integrator_2nd_category	84950000284	60000	20	1
306	Zavyalov	Savely	Integrator_3rd_category	84950000285	50000	12	5
307	Zaitsev	Adam	Integrator_2nd_category	84950000286	60000	16	2
308	Zaitsev	Sergey	Integrator_2nd_category	84950000287	60000	14	1
309	Zaitsev	Sergey	Integrator_3rd_category	84950000288	50000	2	4
310	Zaitsev	Egor	Technician	84950000289	30000	18	7
311	Zaitsev	Dmitry	Integrator_1st_category	84950000290	70000	5	9
312	Zakharov	Artyom	Integrator_2nd_category	84950000291	60000	11	9
313	Zakharov	Maxim	Chief_Integrator	84950000292	150000	2	1
314	Zakharov	Boris	Chief_Integrator	84950000293	150000	7	8
315	Zakharov	Konstantin	Integrator_1st_category	84950000294	70000	6	10
316	Zakharov	Yaroslav	Integrator_1st_category	84950000295	70000	4	3
317	Zakharov	Timur	Technician	84950000296	30000	2	5
318	Zverev	Ivan	Integrator_2nd_category	84950000297	60000	2	6
319	Zelenin	Fedor	Integrator_1st_category	84950000298	70000	17	2
320	Zelenin	Lev	Lead_integrator	84950000299	300000	5	4
321	Zinoviev	Fedor	Chief_Integrator	84950000300	150000	3	5
322	Zolotov	Sergey	Technician	84950000301	30000	1	5
323	Zorin	Yaroslav	Technician	84950000302	30000	11	8
324	Zotov	Arseny	Integrator_1st_category	84950000303	70000	16	2
325	Zotov	Egor	Integrator_2nd_category	84950000304	60000	15	7
326	Zuev	Maxim	Chief_Integrator	84950000305	150000	17	4
327	Zuev	Andrey	Lead_integrator	84950000306	300000	11	1
328	Zuev	Denis	Chief_Integrator	84950000307	150000	3	5
329	Ivanov	Platon	Chief_Integrator	84950000308	150000	7	4
330	Ivanov	Dmitry	Chief_Integrator	84950000309	150000	7	6
331	Ivanov	Daniel	Integrator_3rd_category	84950000310	50000	18	7
332	Ivanov	Artyom	Integrator_3rd_category	84950000311	50000	7	10
333	Ivanov	Vladimir	Integrator_2nd_category	84950000312	60000	19	6
334	Ivanov	Philip	Integrator_3rd_category	84950000313	50000	6	5
335	Ivanov	Daniel	Chief_Integrator	84950000314	150000	6	6
336	Ivanov	Andrey	Chief_Integrator	84950000315	150000	4	3
337	Ivanov	Daniel	Technician	84950000316	30000	9	10
338	Ivanov	Ilya	Integrator_1st_category	84950000317	70000	1	4
339	Ivanov	Mikhail	Integrator_2nd_category	84950000318	60000	3	4
340	Ivanov	Nikolay	Lead_integrator	84950000319	300000	11	2
341	Ivanov	Mikhail	Lead_integrator	84950000320	300000	19	4
342	Ivanov	Artyom	Integrator_2nd_category	84950000321	60000	6	10
343	Ivanov	Mikhail	Technician	84950000322	30000	2	5
344	Ivanov	Rodion	Integrator_2nd_category	84950000323	60000	5	5
345	Ivanov	Egor	Integrator_3rd_category	84950000324	50000	11	6
346	Ivanov	Grigory	Lead_integrator	84950000325	300000	17	3
347	Ivanov	Dmitry	Integrator_2nd_category	84950000326	60000	13	8
348	Ignatiev	Pavel	Integrator_3rd_category	84950000327	50000	19	1
349	Ignatiev	Luka	Integrator_2nd_category	84950000328	60000	10	10
350	Ignatiev	Maxim	Integrator_2nd_category	84950000329	60000	8	2
351	Izmailov	Daniel	Integrator_2nd_category	84950000330	60000	11	9
352	Ilyin	Sergey	Technician	84950000331	30000	15	10
353	Ilyin	Oleg	Lead_integrator	84950000332	300000	18	3
354	Ilyin	Daniel	Integrator_3rd_category	84950000333	50000	19	5
355	Ilyin	Dmitry	Chief_Integrator	84950000334	150000	6	10
356	Ilyin	Andrey	Integrator_2nd_category	84950000335	60000	6	4
357	Ilyin	Denis	Technician	84950000336	30000	9	1
358	Ilyin	Yaroslav	Integrator_2nd_category	84950000337	60000	15	4
359	Ilyin	Sergey	Technician	84950000338	30000	14	2
360	Ilyin	Ivan	Technician	84950000339	30000	13	9
361	Ilyin	Yuri	Integrator_1st_category	84950000340	70000	9	3
362	Isaev	Alexander	Lead_integrator	84950000341	300000	13	6
363	Isaev	Mikhail	Integrator_1st_category	84950000342	70000	8	3
364	Isaev	Rodion	Integrator_2nd_category	84950000343	60000	8	3
365	Isaev	Luka	Chief_Integrator	84950000344	150000	2	3
366	Kazakov	Nikita	Lead_integrator	84950000345	300000	11	5
367	Kazakov	Georgy	Chief_Integrator	84950000346	150000	7	4
368	Kazakov	Ilya	Chief_Integrator	84950000347	150000	13	3
369	Kazakov	Ilya	Technician	84950000348	30000	20	10
370	Kazantsev	Ivan	Integrator_1st_category	84950000349	70000	4	2
371	Kalachev	Nikolay	Integrator_1st_category	84950000350	70000	11	2
372	Kalashnikov	Sergey	Integrator_2nd_category	84950000351	60000	4	4
373	Kalashnikov	Philip	Integrator_3rd_category	84950000352	50000	9	9
374	Kalinin	Ivan	Chief_Integrator	84950000353	150000	6	10
375	Kalinin	Gleb	Lead_integrator	84950000354	300000	12	10
376	Kalinin	Miroslav	Integrator_3rd_category	84950000355	50000	8	6
377	Kalinin	Yaroslav	Integrator_2nd_category	84950000356	60000	5	4
378	Kalugin	Timofey	Lead_integrator	84950000357	300000	11	6
379	Karasev	Mikhail	Chief_Integrator	84950000358	150000	7	10
380	Karasev	Artyom	Technician	84950000359	30000	2	4
381	Karpov	Andrey	Technician	84950000360	30000	10	3
382	Karpov	Alexey	Chief_Integrator	84950000361	150000	6	8
383	Kasatkin	Artyom	Technician	84950000362	30000	11	5
384	Kasatkin	Robert	Technician	84950000363	30000	19	6
385	Kasatkin	Maxim	Integrator_3rd_category	84950000364	50000	12	8
386	Kasyanov	Ilya	Lead_integrator	84950000365	300000	7	9
387	Kasyanov	Vladimir	Integrator_1st_category	84950000366	70000	4	1
388	Kirillov	Yuri	Technician	84950000367	30000	16	7
389	Kirillov	Roman	Chief_Integrator	84950000368	150000	17	7
390	Kiselev	Andrey	Integrator_2nd_category	84950000369	60000	5	10
391	Kiselev	Mikhail	Integrator_1st_category	84950000370	70000	12	10
392	Klimov	Leonid	Chief_Integrator	84950000371	150000	14	5
393	Klimov	Zakhar	Lead_integrator	84950000372	300000	4	10
394	Klyuev	Timofey	Integrator_1st_category	84950000373	70000	8	8
395	Klyuev	Adam	Technician	84950000374	30000	10	5
396	Knyazev	Adam	Integrator_2nd_category	84950000375	60000	12	9
397	Kovalev	Konstantin	Technician	84950000376	30000	4	5
398	Kovalev	Egor	Integrator_2nd_category	84950000377	60000	18	2
399	Kovalev	Petr	Technician	84950000378	30000	6	4
400	Kozhevnikov	Alexander	Chief_Integrator	84950000379	150000	4	10
401	Kozhevnikov	Nikolay	Integrator_1st_category	84950000380	70000	1	3
402	Kozlov	Egor	Technician	84950000381	30000	6	9
403	Kozlov	Leonid	Integrator_1st_category	84950000382	70000	19	7
404	Kozlov	Artemy	Chief_Integrator	84950000383	150000	20	1
405	Kozlov	Makar	Integrator_2nd_category	84950000384	60000	12	6
406	Kozlov	Stepan	Technician	84950000385	30000	18	7
407	Kozlov	Alexander	Lead_integrator	84950000386	300000	20	2
408	Kozlov	Peter	Integrator_2nd_category	84950000387	60000	1	7
409	Kozlovsky	Dmitry	Technician	84950000388	30000	15	9
410	Kozyrev	Vladimir	Integrator_2nd_category	84950000389	60000	4	2
411	Kozyrev	Peter	Integrator_2nd_category	84950000390	60000	13	4
412	Kolesnikov	Artyom	Integrator_1st_category	84950000391	70000	3	3
413	Kolesnikov	Alexander	Lead_integrator	84950000392	300000	6	1
414	Kolosov	Egor	Chief_Integrator	84950000393	150000	11	5
415	Kolosov	Rodion	Lead_integrator	84950000394	300000	4	8
416	Komarov	Ilya	Integrator_1st_category	84950000395	70000	16	1
417	Komarov	Daniel	Integrator_3rd_category	84950000396	50000	6	6
418	Komarov	Vladislav	Lead_integrator	84950000397	300000	16	2
419	Komarov	Timofey	Chief_Integrator	84950000398	150000	5	5
420	Komarov	Viktor	Chief_Integrator	84950000399	150000	7	9
421	Komarov	Daniel	Integrator_2nd_category	84950000400	60000	11	10
422	Komissarov	Andrey	Chief_Integrator	84950000401	150000	1	2
423	Komissarov	Andrey	Chief_Integrator	84950000402	150000	12	10
424	Kondratiev	Ivan	Lead_integrator	84950000403	300000	13	10
425	Kondratiev	Ruslan	Integrator_3rd_category	84950000404	50000	16	2
426	Kondratiev	Nikolay	Chief_Integrator	84950000405	150000	6	7
427	Konovalov	Pavel	Integrator_1st_category	84950000406	70000	17	8
428	Konovalov	Boris	Lead_integrator	84950000407	300000	14	3
429	Konovalov	Arseniy	Integrator_2nd_category	84950000408	60000	1	1
430	Kononov	Andrey	Integrator_3rd_category	84950000409	50000	5	7
431	Kononov	Ivan	Integrator_1st_category	84950000410	70000	11	4
432	Konstantinov	Vladimir	Integrator_3rd_category	84950000411	50000	19	9
433	Konstantinov	Anton	Integrator_2nd_category	84950000412	60000	9	8
434	Konstantinov	Yaroslav	Integrator_1st_category	84950000413	70000	9	4
435	Kopylov	Egor	Technician	84950000414	30000	19	4
436	Korneev	Sergey	Integrator_3rd_category	84950000415	50000	17	10
437	Korneev	Mark	Integrator_2nd_category	84950000416	60000	17	10
438	Kornilov	Leonid	Chief_Integrator	84950000417	150000	18	4
439	Kornilov	Timur	Integrator_1st_category	84950000418	70000	3	3
440	Korovin	Artyom	Integrator_3rd_category	84950000419	50000	9	7
441	Korolev	Yakov	Integrator_3rd_category	84950000420	50000	10	6
442	Korolev	Mark	Technician	84950000421	30000	12	7
443	Korolev	Daniel	Integrator_3rd_category	84950000422	50000	14	5
444	Korotkov	Mikhail	Integrator_2nd_category	84950000423	60000	14	9
445	Korchagin	Daniel	Integrator_1st_category	84950000424	70000	16	2
446	Kosarev	Mikhail	Integrator_2nd_category	84950000425	60000	12	2
447	Kostin	George	Chief_Integrator	84950000426	150000	15	2
448	Kostin	Maxim	Integrator_2nd_category	84950000427	60000	12	9
449	Kotov	Dmitry	Lead_integrator	84950000428	300000	7	6
450	Kotov	Ruslan	Integrator_2nd_category	84950000429	60000	1	6
451	Kotov	Daniel	Chief_Integrator	84950000430	150000	3	4
452	Krasnov	Andrey	Integrator_3rd_category	84950000431	50000	13	10
453	Krylov	Vadim	Chief_Integrator	84950000432	150000	6	5
454	Krylov	Mark	Integrator_2nd_category	84950000433	60000	18	5
455	Krylov	Mikhail	Chief_Integrator	84950000434	150000	12	2
456	Krylov	Dmitry	Integrator_2nd_category	84950000435	60000	12	8
457	Krylov	Maxim	Lead_integrator	84950000436	300000	9	5
458	Kryukov	Daniil	Integrator_1st_category	84950000437	70000	3	9
459	Kryukov	Alexey	Lead_integrator	84950000438	300000	10	5
460	Kryukov	Svyatoslav	Integrator_3rd_category	84950000439	50000	4	3
461	Kudryavtsev	Roman	Lead_integrator	84950000440	300000	20	2
462	Kudryavtsev	Artyom	Integrator_1st_category	84950000441	70000	12	1
463	Kudryavtsev	Boris	Technician	84950000442	30000	11	10
464	Kudryavtsev	Kirill	Lead_integrator	84950000443	300000	7	9
465	Kuzin	Nikolai	Chief_Integrator	84950000444	150000	1	7
466	Kuzin	Timur	Integrator_2nd_category	84950000445	60000	3	2
467	Kuzin	Stepan	Lead_integrator	84950000446	300000	7	2
468	Kuznetsov	Andrey	Integrator_2nd_category	84950000447	60000	16	5
469	Kuznetsov	Nikita	Lead_integrator	84950000448	300000	14	8
470	Kuznetsov	Matvey	Integrator_1st_category	84950000449	70000	8	4
471	Kuznetsov	Pavel	Technician	84950000450	30000	16	4
472	Kuznetsov	Savely	Lead_integrator	84950000451	300000	13	1
473	Kuznetsov	Artemy	Integrator_1st_category	84950000452	70000	6	10
474	Kuznetsov	Alexey	Chief_Integrator	84950000453	150000	11	6
475	Kuznetsov	Artur	Lead_integrator	84950000454	300000	11	6
476	Kuznetsov	Platon	Integrator_1st_category	84950000455	70000	19	3
477	Kuznetsov	Roman	Technician	84950000456	30000	2	1
478	Kuznetsov	Mikhail	Chief_Integrator	84950000457	150000	16	5
479	Kuznetsov	Mikhail	Integrator_1st_category	84950000458	70000	1	5
480	Kuznetsov	Gleb	Integrator_2nd_category	84950000459	60000	9	8
481	Kuznetsov	Timur	Integrator_2nd_category	84950000460	60000	8	4
482	Kuznetsov	Savva	Technician	84950000461	30000	18	2
483	Kuznetsov	Mark	Integrator_3rd_category	84950000462	50000	11	8
484	Kuznetsov	Demid	Integrator_2nd_category	84950000463	60000	12	2
485	Kuznetsov	Yaroslav	Integrator_2nd_category	84950000464	60000	8	7
486	Kuznetsov	Alexander	Integrator_3rd_category	84950000465	50000	1	9
487	Kuznetsov	Kirill	Integrator_1st_category	84950000466	70000	6	4
488	Kuznetsov	Vladimir	Technician	84950000467	30000	7	3
489	Kuzmin	Pavel	Technician	84950000468	30000	16	3
490	Kuzmin	Ivan	Chief_Integrator	84950000469	150000	14	4
491	Kuzmin	Artyom	Lead_integrator	84950000470	300000	13	3
492	Kuzmin	Nikolay	Technician	84950000471	30000	4	2
493	Kuzmin	Alexey	Integrator_1st_category	84950000472	70000	4	7
494	Kukushkin	Alexey	Chief_Integrator	84950000473	150000	12	5
495	Kulagin	Yan	Technician	84950000474	30000	17	6
496	Kulakov	Alexey	Integrator_1st_category	84950000475	70000	14	5
497	Kuleshov	Pavel	Lead_integrator	84950000476	300000	10	7
498	Kulikov	Grigory	Chief_Integrator	84950000477	150000	15	3
499	Kulikov	Kirill	Integrator_1st_category	84950000478	70000	10	5
500	Kulikov	Georgy	Chief_Integrator	84950000479	150000	13	5
501	Kulikov	Alexander	Chief_Integrator	84950000480	150000	7	9
502	Kulikov	Mikhail	Technician	84950000481	30000	10	3
503	Kulikov	Vladislav	Integrator_1st_category	84950000482	70000	15	1
504	Kulikov	Kirill	Integrator_3rd_category	84950000483	50000	8	2
505	Kulikov	Robert	Integrator_3rd_category	84950000484	50000	4	5
506	Kupriyanov	Sergey	Technician	84950000485	30000	4	4
507	Lavrov	Daniel	Integrator_3rd_category	84950000486	50000	7	1
508	Lavrov	Alexander	Technician	84950000487	30000	11	3
509	Lavrov	Matvey	Integrator_3rd_category	84950000488	50000	9	6
510	Lazarev	Maxim	Integrator_1st_category	84950000489	70000	20	9
511	Lazarev	Alexander	Integrator_1st_category	84950000490	70000	7	6
512	Lapin	Grigory	Lead_integrator	84950000491	300000	15	4
513	Laptev	Alexander	Chief_Integrator	84950000492	150000	6	1
514	Larin	Timofey	Chief_Integrator	84950000493	150000	7	5
515	Lebedev	Vladimir	Integrator_3rd_category	84950000494	50000	9	1
516	Lebedev	Ruslan	Integrator_2nd_category	84950000495	60000	20	6
517	Lebedev	Alexander	Chief_Integrator	84950000496	150000	9	9
518	Lebedev	Alexander	Lead_integrator	84950000497	300000	1	8
519	Lebedev	Ivan	Integrator_1st_category	84950000498	70000	1	7
520	Lebedev	Alexander	Chief_Integrator	84950000499	150000	13	7
521	Lebedev	Mark	Technician	84950000500	30000	14	9
522	Lebedev	Dmitry	Integrator_1st_category	84950000501	70000	10	2
523	Levin	Yaroslav	Chief_Integrator	84950000502	150000	1	10
524	Levin	Roman	Integrator_2nd_category	84950000503	60000	5	8
525	Levin	Egor	Integrator_1st_category	84950000504	70000	20	5
526	Levin	Mark	Chief_Integrator	84950000505	150000	13	10
527	Levin	Elisey	Integrator_3rd_category	84950000506	50000	20	6
528	Levin	Kirill	Integrator_2nd_category	84950000507	60000	6	5
529	Leonov	Matvey	Lead_integrator	84950000508	300000	8	6
530	Leontiev	Alexander	Lead_integrator	84950000509	300000	3	8
531	Litvinov	Denis	Integrator_3rd_category	84950000510	50000	11	1
532	Lobanov	Maxim	Integrator_3rd_category	84950000511	50000	14	5
533	Lobanov	Stepan	Chief_Integrator	84950000512	150000	10	3
534	Lobanov	Mark	Technician	84950000513	30000	11	1
535	Lobanov	Vladimir	Chief_Integrator	84950000514	150000	11	5
536	Loginov	Lev	Chief_Integrator	84950000515	150000	8	1
537	Loginov	Maxim	Chief_Integrator	84950000516	150000	19	10
538	Loginov	Daniil	Integrator_1st_category	84950000517	70000	2	4
539	Lukin	Maxim	Technician	84950000518	30000	7	8
540	Lukin	Mikhail	Integrator_1st_category	84950000519	70000	18	8
541	Lukyanov	Yan	Chief_Integrator	84950000520	150000	11	1
542	Lukyanov	Denis	Integrator_1st_category	84950000521	70000	13	10
543	Lvov	Maxim	Lead_integrator	84950000522	300000	20	9
544	Lvov	Timofey	Technician	84950000523	30000	9	7
545	Lyubimov	Fedor	Integrator_2nd_category	84950000524	60000	3	10
546	Makarov	Mark	Integrator_1st_category	84950000525	70000	17	6
547	Makarov	Zakhar	Integrator_2nd_category	84950000526	60000	11	8
548	Makarov	Miron	Integrator_1st_category	84950000527	70000	7	5
549	Makarov	Vladislav	Integrator_1st_category	84950000528	70000	3	6
550	Makarov	Fedor	Lead_integrator	84950000529	300000	11	8
551	Makarov	Bogdan	Integrator_1st_category	84950000530	70000	7	6
552	Makarov	Roman	Technician	84950000531	30000	4	7
553	Makarov	Seraphim	Integrator_1st_category	84950000532	70000	16	1
554	Maksimov	Mark	Integrator_3rd_category	84950000533	50000	4	6
555	Maksimov	Andrey	Technician	84950000534	30000	12	6
556	Maksimov	Ilya	Chief_Integrator	84950000535	150000	2	4
557	Malyshev	Luka	Technician	84950000536	30000	8	7
558	Malyshev	Ivan	Chief_Integrator	84950000537	150000	13	5
559	Malyshev	Matvey	Integrator_1st_category	84950000538	70000	5	4
560	Malyshev	Matvey	Integrator_1st_category	84950000539	70000	17	8
561	Maltsev	Rodion	Technician	84950000540	30000	6	10
562	Maltsev	Georgy	Integrator_3rd_category	84950000541	50000	1	4
563	Maltsev	Artyom	Technician	84950000542	30000	20	5
564	Markin	Arseniy	Technician	84950000543	30000	14	10
565	Markov	Stepan	Integrator_1st_category	84950000544	70000	18	3
566	Markov	Mikhail	Technician	84950000545	30000	17	8
567	Markov	Demid	Integrator_1st_category	84950000546	70000	18	2
568	Martynov	Mark	Technician	84950000547	30000	17	3
569	Martynov	Matvey	Integrator_2nd_category	84950000548	60000	16	10
570	Martynov	Dmitry	Chief_Integrator	84950000549	150000	9	9
571	Martynov	German	Chief_Integrator	84950000550	150000	7	9
572	Martynov	Arseniy	Technician	84950000551	30000	9	8
573	Maslennikov	Ivan	Integrator_1st_category	84950000552	70000	12	4
574	Maslov	Alexey	Integrator_2nd_category	84950000553	60000	3	10
575	Maslov	Vladimir	Integrator_3rd_category	84950000554	50000	2	2
576	Maslov	Ilya	Integrator_1st_category	84950000555	70000	14	5
577	Medvedev	Mikhail	Chief_Integrator	84950000556	150000	8	1
578	Medvedev	Maxim	Technician	84950000557	30000	17	1
579	Medvedev	Mikhail	Lead_integrator	84950000558	300000	17	9
580	Medvedev	Zakhar	Integrator_2nd_category	84950000559	60000	13	4
581	Melnikov	Maxim	Integrator_3rd_category	84950000560	50000	9	2
582	Melnikov	Vsevolod	Integrator_2nd_category	84950000561	60000	2	9
583	Melnikov	German	Integrator_2nd_category	84950000562	60000	8	3
584	Melnikov	Ilya	Lead_integrator	84950000563	300000	7	7
585	Merkulov	Yaroslav	Chief_Integrator	84950000564	150000	2	7
586	Merkulov	Sergey	Integrator_2nd_category	84950000565	60000	1	9
587	Merkulov	Maxim	Lead_integrator	84950000566	300000	5	1
588	Meshkov	Roman	Technician	84950000567	30000	15	9
589	Meshkov	Ilya	Integrator_1st_category	84950000568	70000	9	3
590	Meshcheryakov	Alexey	Integrator_1st_category	84950000569	70000	12	10
591	Meshcheryakov	Mikhail	Lead_integrator	84950000570	300000	3	9
592	Meshcheryakov	Miron	Integrator_3rd_category	84950000571	50000	7	5
593	Mironov	Mikhail	Integrator_1st_category	84950000572	70000	2	5
594	Mironov	Leonid	Chief_Integrator	84950000573	150000	3	10
595	Mironov	Ivan	Chief_Integrator	84950000574	150000	16	2
596	Mironov	Daniil	Integrator_1st_category	84950000575	70000	5	7
597	Mironov	Daniil	Integrator_3rd_category	84950000576	50000	9	9
598	Mironov	Maxim	Chief_Integrator	84950000577	150000	2	4
599	Mironov	Ivan	Integrator_1st_category	84950000578	70000	16	8
600	Mitrofanov	Demid	Chief_Integrator	84950000579	150000	17	3
601	Mitrofanov	Mark	Integrator_1st_category	84950000580	70000	9	2
602	Mikhailov	Georgy	Lead_integrator	84950000581	300000	2	1
603	Mikhailov	Maxim	Lead_integrator	84950000582	300000	13	5
604	Mikhailov	Konstantin	Chief_Integrator	84950000583	150000	9	7
605	Mikhailov	Fedor	Integrator_1st_category	84950000584	70000	4	3
606	Mikhailov	Alexander	Integrator_2nd_category	84950000585	60000	13	4
607	Mikhailov	Daniil	Chief_Integrator	84950000586	150000	20	6
608	Mikhailov	Alexander	Integrator_2nd_category	84950000587	60000	2	3
609	Mikheev	Mikhail	Chief_Integrator	84950000588	150000	5	10
610	Mikheev	Kirill	Integrator_3rd_category	84950000589	50000	10	9
611	Mikheev	Platon	Technician	84950000590	30000	5	5
612	Moiseev	Maxim	Integrator_1st_category	84950000591	70000	5	9
613	Moiseev	Artyom	Technician	84950000592	30000	11	5
614	Morgunov	Ivan	Integrator_2nd_category	84950000593	60000	20	8
615	Morozov	Artyom	Chief_Integrator	84950000594	150000	15	10
616	Morozov	Pavel	Chief_Integrator	84950000595	150000	4	1
617	Morozov	Mark	Integrator_2nd_category	84950000596	60000	18	6
618	Morozov	Artemy	Technician	84950000597	30000	8	2
619	Morozov	Alexander	Integrator_3rd_category	84950000598	50000	5	2
620	Morozov	Ivan	Integrator_2nd_category	84950000599	60000	9	6
621	Moskvin	Alexey	Technician	84950000600	30000	19	10
622	Muraviev	Daniel	Integrator_2nd_category	84950000601	60000	2	5
623	Mukhin	Yuri	Integrator_1st_category	84950000602	70000	13	1
624	Mukhin	Pavel	Integrator_3rd_category	84950000603	50000	6	7
625	Mukhin	Dmitry	Chief_Integrator	84950000604	150000	12	10
626	Nazarov	Daniel	Technician	84950000605	30000	20	6
627	Nazarov	Matvey	Technician	84950000606	30000	4	7
628	Nazarov	Denis	Integrator_3rd_category	84950000607	50000	15	6
629	Nazarov	Dmitry	Integrator_2nd_category	84950000608	60000	10	5
630	Nazarov	Tikhon	Technician	84950000609	30000	10	6
631	Naumov	Timur	Technician	84950000610	30000	13	6
632	Naumov	Artemy	Chief_Integrator	84950000611	150000	10	8
633	Naumov	Konstantin	Integrator_3rd_category	84950000612	50000	11	4
634	Nekrasov	Timur	Integrator_2nd_category	84950000613	60000	11	6
635	Nekrasov	Timofey	Lead_integrator	84950000614	300000	17	6
636	Nesterov	Alexander	Integrator_2nd_category	84950000615	60000	19	7
637	Nechaev	Daniil	Technician	84950000616	30000	4	1
638	Nechaev	Artur	Technician	84950000617	30000	13	9
639	Nikitin	Sergey	Lead_integrator	84950000618	300000	10	9
640	Nikitin	Andrey	Technician	84950000619	30000	9	9
641	Nikitin	Vasily	Integrator_2nd_category	84950000620	60000	8	7
642	Nikitin	Maxim	Lead_integrator	84950000621	300000	5	2
643	Nikitin	Dmitry	Integrator_3rd_category	84950000622	50000	4	6
644	Nikitin	Miron	Technician	84950000623	30000	5	6
645	Nikiforov	Ivan	Integrator_1st_category	84950000624	70000	7	4
646	Nikiforov	Savva	Integrator_2nd_category	84950000625	60000	20	1
647	Nikiforov	Zakhar	Chief_Integrator	84950000626	150000	6	9
648	Nikonov	Vadim	Integrator_1st_category	84950000627	70000	3	1
649	Nikonov	Zakhar	Chief_Integrator	84950000628	150000	18	2
650	Novikov	Alexander	Integrator_1st_category	84950000629	70000	2	6
651	Novikov	Alexander	Lead_integrator	84950000630	300000	18	2
652	Novikov	Artemy	Integrator_3rd_category	84950000631	50000	14	8
653	Novikov	Yuri	Chief_Integrator	84950000632	150000	5	7
654	Novikov	Sergey	Chief_Integrator	84950000633	150000	2	7
655	Noskov	Mark	Integrator_3rd_category	84950000634	50000	6	5
656	Nosov	Stepan	Chief_Integrator	84950000635	150000	7	10
657	Nosov	Nikolay	Integrator_2nd_category	84950000636	60000	18	3
658	Ovsyannikov	Evgeny	Integrator_1st_category	84950000637	70000	10	8
659	Ovsyannikov	Artyom	Integrator_3rd_category	84950000638	50000	2	7
660	Ovsyannikov	Gleb	Technician	84950000639	30000	16	4
661	Ovchinnikov	Lev	Technician	84950000640	30000	8	5
662	Ovchinnikov	Alexander	Integrator_1st_category	84950000641	70000	13	4
663	Ozerov	Ivan	Integrator_3rd_category	84950000642	50000	18	5
664	Orekhov	Alexander	Integrator_2nd_category	84950000643	60000	9	9
665	Orekhov	Mikhail	Technician	84950000644	30000	19	9
666	Orekhov	Plato	Lead_integrator	84950000645	300000	19	3
667	Orlov	Maxim	Integrator_2nd_category	84950000646	60000	18	9
668	Orlov	Matvey	Lead_integrator	84950000647	300000	17	4
669	Orlov	Makar	Chief_Integrator	84950000648	150000	15	8
670	Orlov	Mark	Integrator_3rd_category	84950000649	50000	16	6
671	Orlov	Ruslan	Technician	84950000650	30000	5	9
672	Orlov	Alexey	Integrator_1st_category	84950000651	70000	7	6
673	Orlov	Ivan	Technician	84950000652	30000	13	1
674	Orlov	Alexander	Chief_Integrator	84950000653	150000	8	2
675	Osipov	Mikhail	Integrator_2nd_category	84950000654	60000	6	1
676	Osipov	Daniil	Integrator_2nd_category	84950000655	60000	7	5
677	Osipov	Nikita	Integrator_1st_category	84950000656	70000	15	9
678	Osipov	Mark	Integrator_2nd_category	84950000657	60000	6	4
679	Ostrovsky	Pavel	Integrator_2nd_category	84950000658	60000	11	8
680	Ostrovsky	Fedor	Integrator_1st_category	84950000659	70000	15	5
681	Pavlov	Demid	Lead_integrator	84950000660	300000	19	7
682	Pavlov	Platon	Technician	84950000661	30000	12	7
683	Pavlov	Demid	Lead_integrator	84950000662	300000	11	10
684	Pavlov	Platon	Integrator_2nd_category	84950000663	60000	20	7
685	Pavlov	Demid	Chief_Integrator	84950000664	150000	5	3
686	Pavlovsky	Elisha	Integrator_2nd_category	84950000665	60000	3	1
687	Panin	Matvey	Integrator_3rd_category	84950000666	50000	3	7
688	Panin	Stepan	Lead_integrator	84950000667	300000	10	5
689	Panin	Nikita	Integrator_3rd_category	84950000668	50000	15	6
690	Panin	Adam	Integrator_3rd_category	84950000669	50000	5	3
691	Panov	Timofey	Technician	84950000670	30000	19	8
692	Panov	Mikhail	Chief_Integrator	84950000671	150000	15	6
693	Panfilov	Artyom	Technician	84950000672	30000	3	9
694	Panfilov	Egor	Lead_integrator	84950000673	300000	2	1
695	Panfilov	Ruslan	Integrator_1st_category	84950000674	70000	15	7
696	Panfilov	Vadim	Lead_integrator	84950000675	300000	5	9
697	Panfilov	Timur	Technician	84950000676	30000	10	6
698	Panfilov	Artyom	Lead_integrator	84950000677	300000	2	5
699	Pastukhov	Grigory	Technician	84950000678	30000	19	9
700	Pakhomov	Maxim	Technician	84950000679	30000	7	1
701	Pakhomov	Fedor	Integrator_2nd_category	84950000680	60000	13	3
702	Petrov	Artyom	Integrator_1st_category	84950000681	70000	7	1
703	Petrov	Timofey	Lead_integrator	84950000682	300000	18	3
704	Petrov	Dmitry	Lead_integrator	84950000683	300000	13	6
705	Petrov	Artyom	Chief_Integrator	84950000684	150000	14	3
706	Petrov	Ivan	Chief_Integrator	84950000685	150000	17	10
707	Petrov	Miroslav	Integrator_2nd_category	84950000686	60000	9	4
708	Petrov	Ilya	Integrator_2nd_category	84950000687	60000	15	2
709	Petrov	Oleg	Integrator_1st_category	84950000688	70000	15	6
710	Petrov	Semyon	Chief_Integrator	84950000689	150000	8	5
711	Petrov	Mikhail	Integrator_3rd_category	84950000690	50000	8	10
712	Petrov	Artyom	Integrator_1st_category	84950000691	70000	20	9
713	Petrov	Maxim	Chief_Integrator	84950000692	150000	20	5
714	Petrov	Gleb	Chief_Integrator	84950000693	150000	15	3
715	Petrov	Georgy	Lead_integrator	84950000694	300000	17	5
716	Petrov	Mikhail	Integrator_3rd_category	84950000695	50000	9	8
717	Petrov	Matvey	Integrator_2nd_category	84950000696	60000	9	4
718	Petrovsky	Ivan	Technician	84950000697	30000	8	9
719	Petrovsky	Ivan	Integrator_2nd_category	84950000698	60000	7	2
720	Petukhov	Alexey	Lead_integrator	84950000699	300000	18	9
721	Petukhov	Alexey	Technician	84950000700	30000	18	6
722	Plotnikov	Yaroslav	Integrator_2nd_category	84950000701	60000	3	4
723	Pokrovsky	Georgy	Chief_Integrator	84950000702	150000	19	8
724	Pokrovsky	Ruslan	Technician	84950000703	30000	19	3
725	Polikarpov	Egor	Integrator_3rd_category	84950000704	50000	5	4
726	Polikarpov	Alexey	Lead_integrator	84950000705	300000	18	3
727	Polyakov	Dmitry	Lead_integrator	84950000706	300000	5	2
728	Polyakov	Semyon	Integrator_1st_category	84950000707	70000	2	9
729	Polyakov	Alexander	Technician	84950000708	30000	14	3
730	Polyakov	Timofey	Integrator_3rd_category	84950000709	50000	14	7
731	Polyakov	Artyom	Integrator_3rd_category	84950000710	50000	15	9
732	Polyakov	Fedor	Technician	84950000711	30000	14	9
733	Polyakov	Vladimir	Integrator_1st_category	84950000712	70000	9	6
734	Polyakov	Luka	Lead_integrator	84950000713	300000	13	10
735	Polyakov	Mikhail	Integrator_3rd_category	84950000714	50000	11	8
736	Ponomarev	Nikolay	Integrator_1st_category	84950000715	70000	9	2
737	Ponomarev	Ivan	Lead_integrator	84950000716	300000	6	10
738	Popov	Alexander	Integrator_3rd_category	84950000717	50000	3	10
739	Popov	Mikhail	Integrator_2nd_category	84950000718	60000	18	5
740	Popov	Ivan	Lead_integrator	84950000719	300000	7	3
741	Popov	Artur	Integrator_2nd_category	84950000720	60000	16	9
742	Popov	Dmitry	Lead_integrator	84950000721	300000	16	9
743	Popov	Miron	Technician	84950000722	30000	17	8
744	Popov	Yaroslav	Integrator_1st_category	84950000723	70000	2	8
745	Popov	Philip	Technician	84950000724	30000	20	9
746	Popov	Mark	Lead_integrator	84950000725	300000	14	1
747	Popov	Boris	Integrator_1st_category	84950000726	70000	11	6
748	Popov	Mark	Integrator_2nd_category	84950000727	60000	16	7
749	Popov	Ruslan	Integrator_3rd_category	84950000728	50000	17	7
750	Popov	Sergey	Technician	84950000729	30000	2	7
751	Popov	Matvey	Integrator_1st_category	84950000730	70000	10	5
752	Popov	Kirill	Integrator_3rd_category	84950000731	50000	5	2
753	Popov	Alexander	Technician	84950000732	30000	14	10
754	Popov	Makar	Lead_integrator	84950000733	300000	3	10
755	Potapov	Ivan	Integrator_1st_category	84950000734	70000	19	4
756	Potapov	Leonid	Lead_integrator	84950000735	300000	8	9
757	Prokhorov	Artyom	Technician	84950000736	30000	1	8
758	Prokhorov	German	Technician	84950000737	30000	1	3
759	Prokhorov	Ivan	Technician	84950000738	30000	6	2
760	Rakov	Leo	Integrator_1st_category	84950000739	70000	11	7
761	Rodin	Georgy	Integrator_1st_category	84950000740	70000	2	6
762	Rodin	Mikhail	Chief_Integrator	84950000741	150000	14	9
763	Rodin	Artyom	Integrator_1st_category	84950000742	70000	8	3
764	Rozanov	Dmitry	Integrator_3rd_category	84950000743	50000	14	8
765	Rozanov	Timur	Integrator_3rd_category	84950000744	50000	8	2
766	Romanov	Alexey	Chief_Integrator	84950000745	150000	19	6
767	Romanov	Lev	Integrator_1st_category	84950000746	70000	11	2
768	Romanov	Mikhail	Integrator_3rd_category	84950000747	50000	10	5
769	Romanov	Dmitry	Integrator_3rd_category	84950000748	50000	16	5
770	Romanov	Mikhail	Lead_integrator	84950000749	300000	8	3
771	Romanov	Nikita	Integrator_2nd_category	84950000750	60000	2	8
772	Rubtsov	Ilya	Lead_integrator	84950000751	300000	14	4
773	Rudnev	Daniel	Chief_Integrator	84950000752	150000	9	4
774	Rudnev	Roman	Integrator_2nd_category	84950000753	60000	20	5
775	Rumyantsev	Platon	Integrator_3rd_category	84950000754	50000	7	1
776	Rumyantsev	Kirill	Integrator_2nd_category	84950000755	60000	12	10
777	Rybakov	Alexey	Integrator_3rd_category	84950000756	50000	1	5
778	Ryzhov	Mikhail	Chief_Integrator	84950000757	150000	4	5
779	Ryabinin	Matvey	Integrator_2nd_category	84950000758	60000	15	8
780	Ryabov	Miron	Integrator_3rd_category	84950000759	50000	7	1
781	Ryabov	Mikhail	Integrator_2nd_category	84950000760	60000	16	10
782	Ryabov	Yaroslav	Technician	84950000761	30000	9	9
783	Saveliev	Ivan	Integrator_3rd_category	84950000762	50000	2	8
784	Saveliev	Timofey	Integrator_2nd_category	84950000763	60000	1	6
785	Saveliev	Alexander	Integrator_2nd_category	84950000764	60000	2	9
786	Saveliev	Maxim	Lead_integrator	84950000765	300000	11	6
787	Saveliev	Lev	Integrator_3rd_category	84950000766	50000	15	2
788	Saveliev	Dmitry	Integrator_1st_category	84950000767	70000	17	8
789	Saveliev	Maxim	Integrator_3rd_category	84950000768	50000	11	4
790	Savin	Yuri	Integrator_3rd_category	84950000769	50000	15	9
791	Savin	Kirill	Integrator_3rd_category	84950000770	50000	13	2
792	Savin	George	Chief_Integrator	84950000771	150000	10	7
793	Savitsky	Ivan	Integrator_2nd_category	84950000772	60000	13	2
794	Sazonov	Ilya	Lead_integrator	84950000773	300000	2	4
795	Sazonov	Platon	Chief_Integrator	84950000774	150000	16	5
796	Safonov	Mark	Technician	84950000775	30000	3	8
797	Sakharov	Makar	Technician	84950000776	30000	12	10
798	Sedov	Daniel	Integrator_1st_category	84950000777	70000	17	5
799	Seleznev	Mark	Integrator_2nd_category	84950000778	60000	5	5
800	Selivanov	Lev	Integrator_2nd_category	84950000779	60000	11	1
801	Selivanov	Mikhail	Lead_integrator	84950000780	300000	6	6
802	Semenov	Anton	Chief_Integrator	84950000781	150000	17	8
803	Semenov	Andrey	Lead_integrator	84950000782	300000	16	8
804	Semenov	Daniil	Integrator_3rd_category	84950000783	50000	8	2
805	Semenov	Alexander	Lead_integrator	84950000784	300000	13	5
806	Semenov	Ruslan	Integrator_1st_category	84950000785	70000	2	5
807	Semenov	Mark	Technician	84950000786	30000	2	8
808	Semenov	Matvey	Integrator_2nd_category	84950000787	60000	17	5
809	Semenov	Ivan	Integrator_1st_category	84950000788	70000	8	1
810	Semenov	Adam	Technician	84950000789	30000	12	7
811	Semenov	Timur	Technician	84950000790	30000	6	1
812	Semenov	Dmitry	Lead_integrator	84950000791	300000	18	7
813	Semin	Stepan	Integrator_1st_category	84950000792	70000	7	6
814	Sergeev	Matvey	Integrator_3rd_category	84950000793	50000	15	4
815	Sergeev	Roman	Technician	84950000794	30000	16	1
816	Sergeev	Gleb	Integrator_1st_category	84950000795	70000	11	6
817	Sergeev	Ruslan	Integrator_3rd_category	84950000796	50000	15	9
818	Sergeev	Roman	Technician	84950000797	30000	13	4
819	Sergeev	Stepan	Integrator_2nd_category	84950000798	60000	15	9
820	Sergeev	Dmitry	Integrator_1st_category	84950000799	70000	15	3
821	Sergeev	Dmitry	Integrator_2nd_category	84950000800	60000	19	10
822	Sergeev	Roman	Integrator_3rd_category	84950000801	50000	5	9
823	Serov	Mark	Chief_Integrator	84950000802	150000	4	2
824	Sidorov	Adam	Integrator_2nd_category	84950000803	60000	14	10
825	Sidorov	Alexey	Technician	84950000804	30000	11	2
826	Sidorov	Oleg	Technician	84950000805	30000	9	1
827	Sidorov	Artemy	Integrator_2nd_category	84950000806	60000	13	2
828	Simonov	Grigory	Technician	84950000807	30000	7	7
829	Simonov	Dmitry	Integrator_1st_category	84950000808	70000	6	1
830	Sinitsyn	Nikolay	Technician	84950000809	30000	18	4
831	Sitnikov	Alexander	Integrator_1st_category	84950000810	70000	6	10
832	Sitnikov	Ivan	Lead_integrator	84950000811	300000	16	8
833	Sitnikov	Yuri	Integrator_1st_category	84950000812	70000	6	9
834	Skvortsov	Ivan	Chief_Integrator	84950000813	150000	7	5
835	Smirnov	Mikhail	Integrator_3rd_category	84950000814	50000	7	4
836	Smirnov	Vladislav	Integrator_1st_category	84950000815	70000	1	1
837	Smirnov	Ivan	Technician	84950000816	30000	6	1
838	Smirnov	Ivan	Integrator_3rd_category	84950000817	50000	11	9
839	Smirnov	Arseniy	Lead_integrator	84950000818	300000	8	7
840	Smirnov	Vladimir	Integrator_1st_category	84950000819	70000	5	4
841	Smirnov	Daniil	Lead_integrator	84950000820	300000	16	8
842	Smirnov	Maxim	Integrator_3rd_category	84950000821	50000	2	7
843	Smirnov	Stepan	Technician	84950000822	30000	8	4
844	Smirnov	Andrey	Integrator_3rd_category	84950000823	50000	1	8
845	Smirnov	Yaroslav	Chief_Integrator	84950000824	150000	12	10
846	Smirnov	Ruslan	Integrator_3rd_category	84950000825	50000	18	10
847	Smirnov	Grigory	Lead_integrator	84950000826	300000	6	5
848	Smirnov	Zakhar	Integrator_3rd_category	84950000827	50000	11	2
849	Smirnov	Egor	Lead_integrator	84950000828	300000	16	2
850	Smirnov	Denis	Integrator_1st_category	84950000829	70000	17	4
851	Smirnov	Ivan	Integrator_1st_category	84950000830	70000	14	2
852	Smirnov	Georgy	Chief_Integrator	84950000831	150000	7	3
853	Smirnov	Nikita	Technician	84950000832	30000	17	6
854	Smirnov	Alexey	Integrator_2nd_category	84950000833	60000	10	3
855	Sobolev	Alexander	Integrator_1st_category	84950000834	70000	2	5
856	Sobolev	Yuri	Lead_integrator	84950000835	300000	4	5
857	Sobolev	Miroslav	Integrator_3rd_category	84950000836	50000	16	8
858	Sokolov	Lev	Technician	84950000837	30000	3	7
859	Sokolov	Demid	Lead_integrator	84950000838	300000	5	3
860	Sokolov	Timofey	Integrator_3rd_category	84950000839	50000	6	10
861	Sokolov	Mark	Integrator_2nd_category	84950000840	60000	14	3
862	Sokolov	Timofey	Chief_Integrator	84950000841	150000	20	8
863	Sokolov	Pavel	Chief_Integrator	84950000842	150000	8	6
864	Sokolov	Andrey	Technician	84950000843	30000	15	5
865	Sokolov	Alexander	Integrator_1st_category	84950000844	70000	13	6
866	Solovyov	Daniel	Integrator_2nd_category	84950000845	60000	8	10
867	Solovyov	Gleb	Integrator_3rd_category	84950000846	50000	20	9
868	Solovyov	Georgy	Technician	84950000847	30000	12	4
869	Solovyov	Gleb	Integrator_2nd_category	84950000848	60000	15	8
870	Solovyov	Alexander	Integrator_3rd_category	84950000849	50000	19	7
871	Somov	Maxim	Integrator_3rd_category	84950000850	50000	16	4
872	Sorokin	Kirill	Integrator_1st_category	84950000851	70000	1	1
873	Sorokin	Sergey	Chief_Integrator	84950000852	150000	5	4
874	Sorokin	Ivan	Chief_Integrator	84950000853	150000	9	6
875	Sorokin	Dmitry	Lead_integrator	84950000854	300000	10	6
876	Sorokin	Artyom	Integrator_3rd_category	84950000855	50000	18	1
877	Sotnikov	Egor	Integrator_3rd_category	84950000856	50000	7	1
878	Sofronov	Alexander	Integrator_3rd_category	84950000857	50000	2	5
879	Spiridonov	Boris	Integrator_1st_category	84950000858	70000	5	1
880	Starostin	Mikhail	Integrator_3rd_category	84950000859	50000	4	8
881	Starostin	Semyon	Chief_Integrator	84950000860	150000	14	10
882	Starostin	Vladimir	Lead_integrator	84950000861	300000	14	10
883	Stepanov	Daniil	Chief_Integrator	84950000862	150000	4	9
884	Stepanov	Timofey	Chief_Integrator	84950000863	150000	4	3
885	Stepanov	Artyom	Technician	84950000864	30000	5	2
886	Stepanov	Fedor	Integrator_1st_category	84950000865	70000	1	2
887	Stolyarov	Pavel	Technician	84950000866	30000	6	7
888	Stolyarov	Ilya	Chief_Integrator	84950000867	150000	3	7
889	Suvorov	Georgy	Lead_integrator	84950000868	300000	19	3
890	Suvorov	Ivan	Technician	84950000869	30000	18	5
891	Suslov	Evgeny	Lead_integrator	84950000870	300000	9	8
892	Sukharev	Denis	Integrator_2nd_category	84950000871	60000	14	9
893	Sychev	Vadim	Integrator_3rd_category	84950000872	50000	14	5
894	Tarasov	Fedor	Chief_Integrator	84950000873	150000	8	7
895	Tarasov	Artyom	Integrator_3rd_category	84950000874	50000	1	8
896	Tarasov	Artyom	Integrator_3rd_category	84950000875	50000	13	10
897	Tarasov	Alexander	Technician	84950000876	30000	10	6
898	Tarasov	Sergey	Integrator_3rd_category	84950000877	50000	7	2
899	Tarasov	Fedor	Integrator_1st_category	84950000878	70000	18	10
900	Terentiev	Oleg	Technician	84950000879	30000	10	1
901	Terentiev	Alexander	Technician	84950000880	30000	14	5
902	Timofeev	Igor	Lead_integrator	84950000881	300000	14	8
903	Titov	Evgeny	Chief_Integrator	84950000882	150000	12	8
904	Titov	Alexander	Lead_integrator	84950000883	300000	6	6
905	Titov	Konstantin	Lead_integrator	84950000884	300000	3	2
906	Titov	Andrey	Integrator_2nd_category	84950000885	60000	3	2
907	Tikhomirov	Alexander	Integrator_2nd_category	84950000886	60000	20	1
908	Tikhomirov	Denis	Integrator_3rd_category	84950000887	50000	16	9
909	Tikhomirov	Dmitry	Integrator_3rd_category	84950000888	50000	17	3
910	Tikhonov	Fedor	Technician	84950000889	30000	11	8
911	Tikhonov	Matvey	Lead_integrator	84950000890	300000	1	5
912	Tkachev	Fedor	Technician	84950000891	30000	17	10
913	Tokarev	Artyom	Integrator_3rd_category	84950000892	50000	7	9
914	Tretyakov	Daniel	Integrator_3rd_category	84950000893	50000	16	2
915	Trifonov	Vladimir	Technician	84950000894	30000	17	4
916	Trinity	Roman	Chief_Integrator	84950000895	150000	4	8
917	Trofimov	Alexander	Chief_Integrator	84950000896	150000	7	3
918	Trofimov	Ivan	Integrator_3rd_category	84950000897	50000	20	8
919	Troshin	Lev	Integrator_1st_category	84950000898	70000	1	4
920	Tumanov	Yaroslav	Integrator_3rd_category	84950000899	50000	16	10
921	Tumanov	Dmitry	Technician	84950000900	30000	19	6
922	Uvarov	Ivan	Chief_Integrator	84950000901	150000	8	6
923	Uvarov	Alexander	Chief_Integrator	84950000902	150000	16	4
924	Ulyanov	Alexander	Lead_integrator	84950000903	300000	18	5
925	Ulyanov	Maxim	Integrator_1st_category	84950000904	70000	4	10
926	Ulyanov	Konstantin	Chief_Integrator	84950000905	150000	13	4
927	Uspensky	Fedor	Integrator_2nd_category	84950000906	60000	7	4
928	Uspensky	Alexander	Integrator_2nd_category	84950000907	60000	15	10
929	Ustinov	Tikhon	Technician	84950000908	30000	7	10
930	Ustinov	Kirill	Integrator_1st_category	84950000909	70000	14	4
931	Ustinov	Zakhar	Lead_integrator	84950000910	300000	16	4
932	Utkin	Mark	Lead_integrator	84950000911	300000	10	1
933	Ushakov	Maxim	Integrator_2nd_category	84950000912	60000	10	9
934	Ushakov	Fedor	Integrator_3rd_category	84950000913	50000	18	2
935	Fadeev	Anton	Lead_integrator	84950000914	300000	14	4
936	Fedorov	Semyon	Integrator_3rd_category	84950000915	50000	4	10
937	Fedorov	Artur	Integrator_3rd_category	84950000916	50000	11	2
938	Fedorov	Alexander	Integrator_3rd_category	84950000917	50000	3	8
939	Fedorov	Timofey	Integrator_2nd_category	84950000918	60000	1	9
940	Fedorov	Daniil	Integrator_1st_category	84950000919	70000	18	3
941	Fedorov	Denis	Lead_integrator	84950000920	300000	9	6
942	Fedotov	Lev	Integrator_3rd_category	84950000921	50000	4	8
943	Fedotov	Nikita	Integrator_1st_category	84950000922	70000	3	6
944	Fedotov	Alexander	Integrator_3rd_category	84950000923	50000	9	5
945	Fedotov	Daniel	Integrator_2nd_category	84950000924	60000	2	2
946	Filatov	Yaroslav	Integrator_2nd_category	84950000925	60000	9	9
947	Filatov	Matvey	Chief_Integrator	84950000926	150000	8	6
948	Filimonov	Mikhail	Lead_integrator	84950000927	300000	9	2
949	Filimonov	Mark	Integrator_2nd_category	84950000928	60000	19	3
950	Filimonov	Maxim	Lead_integrator	84950000929	300000	7	1
951	Filippov	Dmitry	Technician	84950000930	30000	5	6
952	Filippov	Vyacheslav	Integrator_1st_category	84950000931	70000	17	9
953	Filippov	Miroslav	Chief_Integrator	84950000932	150000	20	10
954	Filippov	Alexey	Chief_Integrator	84950000933	150000	7	5
955	Filippov	Alexander	Lead_integrator	84950000934	300000	6	2
956	Firsov	Konstantin	Technician	84950000935	30000	6	5
957	Firsov	Artyom	Integrator_3rd_category	84950000936	50000	8	4
958	Firsov	Leonid	Integrator_1st_category	84950000937	70000	18	2
959	Fokin	Nikita	Lead_integrator	84950000938	300000	9	6
960	Fokin	Pavel	Lead_integrator	84950000939	300000	6	2
961	Fomin	Mikhail	Integrator_1st_category	84950000940	70000	16	9
962	Fomin	Igor	Integrator_1st_category	84950000941	70000	10	2
963	Fomin	Makar	Chief_Integrator	84950000942	150000	12	7
964	Frolov	Alexander	Integrator_1st_category	84950000943	70000	10	2
965	Frolov	Artemy	Chief_Integrator	84950000944	150000	15	8
966	Frolov	Mikhail	Integrator_3rd_category	84950000945	50000	4	4
967	Kharitonov	Evgeny	Technician	84950000946	30000	16	10
968	Khomyakov	Sergey	Integrator_2nd_category	84950000947	60000	16	1
969	Khomyakov	Georgy	Integrator_1st_category	84950000948	70000	17	5
970	Khomyakov	Sergey	Integrator_2nd_category	84950000949	60000	12	4
971	Khudyakov	Nikolai	Technician	84950000950	30000	16	1
972	Tsarev	Maxim	Integrator_3rd_category	84950000951	50000	20	6
973	Tsarev	Dmitry	Chief_Integrator	84950000952	150000	18	2
974	Tsvetkov	Robert	Integrator_1st_category	84950000953	70000	15	6
975	Tsvetkov	Alexander	Chief_Integrator	84950000954	150000	10	2
976	Chebotarev	Alexander	Integrator_3rd_category	84950000955	50000	4	7
977	Cherepanov	Konstantin	Integrator_1st_category	84950000956	70000	7	3
978	Cherkasov	Lev	Chief_Integrator	84950000957	150000	7	2
979	Chernov	Ivan	Technician	84950000958	30000	10	8
980	Chernov	Kirill	Integrator_1st_category	84950000959	70000	19	5
981	Chernov	Gleb	Chief_Integrator	84950000960	150000	3	10
982	Chernov	Mikhail	Integrator_3rd_category	84950000961	50000	4	3
983	Chernov	Timofey	Chief_Integrator	84950000962	150000	6	7
984	Chernov	Maxim	Integrator_3rd_category	84950000963	50000	18	3
985	Black	George	Integrator_2nd_category	84950000964	60000	20	4
986	Chernykh	Vladimir	Technician	84950000965	30000	17	5
987	Chernyshev	Fedor	Integrator_1st_category	84950000966	70000	16	4
988	Chernyshev	Timofey	Integrator_2nd_category	84950000967	60000	5	10
989	Chernyshev	Leonid	Technician	84950000968	30000	10	9
990	Chernyaev	Ruslan	Integrator_1st_category	84950000969	70000	9	6
991	Chesnokov	Philip	Chief_Integrator	84950000970	150000	17	2
992	Chizhov	Anton	Lead_integrator	84950000971	300000	20	1
993	Chistyakov	Roman	Integrator_1st_category	84950000972	70000	3	9
994	Shaposhnikov	Victor	Integrator_2nd_category	84950000973	60000	13	5
995	Shaposhnikov	Lev	Technician	84950000974	30000	10	9
996	Shaposhnikov	Vladimir	Integrator_3rd_category	84950000975	50000	1	9
997	Shevelev	Georgy	Technician	84950000976	30000	13	1
998	Shevtsov	Maxim	Integrator_2nd_category	84950000977	60000	10	5
999	Shevtsov	Daniel	Integrator_2nd_category	84950000978	60000	7	6
1000	Shevtsov	Georgy	Integrator_3rd_category	84950000979	50000	6	10
1001	Shestakov	Dmitry	Technician	84950000980	30000	10	9
1002	Shestakov	Ilya	Integrator_2nd_category	84950000981	60000	3	2
1003	Shestakov	Andrey	Integrator_1st_category	84950000982	70000	12	3
1004	Shirokov	Artyom	Integrator_3rd_category	84950000983	50000	7	8
1005	Shmelev	Artyom	Chief_Integrator	84950000984	150000	6	5
1006	Shubin	Demid	Technician	84950000985	30000	19	8
1007	Shcherbakov	Alexey	Integrator_3rd_category	84950000986	50000	4	3
1008	Yudin	Timofey	Technician	84950000987	30000	7	9
1009	Yudin	Gleb	Chief_Integrator	84950000988	150000	20	2
1010	Yudin	Andrey	Integrator_2nd_category	84950000989	60000	18	2
1011	Yakovlev	Vyacheslav	Integrator_1st_category	84950000990	70000	7	9
1012	Yakovlev	Ivan	Chief_Integrator	84950000991	150000	9	2
1013	Yakovlev	Daniel	Technician	84950000992	30000	15	9
1014	Yakovlev	Alexander	Technician	84950000993	30000	15	10
1015	Yakovlev	Roman	Technician	84950000994	30000	6	1
1016	Yakovlev	Timofey	Integrator_2nd_category	84950000995	60000	12	8
1017	Yakovlev	Petr	Technician	84950000996	30000	8	7
1018	Yakovlev	Oleg	Integrator_3rd_category	84950000997	50000	20	7
1019	Yakovlev	Alexey	Integrator_3rd_category	84950000998	50000	18	10
1020	Yakovlev	Art	Lead_integrator	84950000999	300000	10	2
\.


--
-- Data for Name: technologies; Type: TABLE DATA; Schema: public; Owner: vlad
--

COPY public.technologies (id_techno, name_techno, info_techno, degree_complexity) FROM stdin;
1	API_integration	Used_to_communicate_between_systems_via_API	2
2	Enterprise_Service_Bus	Used_for_communication_between_different_systems	3
3	Enterprise_Application_Integration	Used_to_integrate_applications_and_systems_at_the_enterprise_level	5
4	Data_Management_Systems	Data_storage_and_management	1
5	Version_Control_Systems	Help_the_system_integrator_to_effectively_manage_and_control_changes_in_source_code,_scripts_and_configuration_files	5
6	Service_Oriented_Architecture	Used_to_split_an_application_into_separate_services,_managing_them_through_protocols	4
7	Cloud_storage	Used_to_store,_process_and_integrate_data	1
8	Integration_platforms	Provide_a_set_of_tools_and_functions_for_integrating_various_systems	2
\.


--
-- Name: clients_id_client_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('public.clients_id_client_seq', 11, true);


--
-- Name: company_id_company_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('public.company_id_company_seq', 12, true);


--
-- Name: projects_id_project_seq; Type: SEQUENCE SET; Schema: public; Owner: vlad
--

SELECT pg_catalog.setval('public.projects_id_project_seq', 22, true);


--
-- Name: clients clients_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.clients
    ADD CONSTRAINT clients_pkey PRIMARY KEY (id_client);


--
-- Name: company company_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.company
    ADD CONSTRAINT company_pkey PRIMARY KEY (id_company);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id_project);


--
-- Name: sys_integrator sys_integrator_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.sys_integrator
    ADD CONSTRAINT sys_integrator_pkey PRIMARY KEY (id_integrator);


--
-- Name: technologies techologies_pkey; Type: CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.technologies
    ADD CONSTRAINT techologies_pkey PRIMARY KEY (id_techno);


--
-- Name: projects fk_client_project_projects; Type: FK CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_client_project_projects FOREIGN KEY (client_project) REFERENCES public.clients(id_client);


--
-- Name: sys_integrator fk_id_company_sys; Type: FK CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.sys_integrator
    ADD CONSTRAINT fk_id_company_sys FOREIGN KEY (id_company) REFERENCES public.company(id_company) NOT VALID;


--
-- Name: sys_integrator fk_id_project_sys; Type: FK CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.sys_integrator
    ADD CONSTRAINT fk_id_project_sys FOREIGN KEY (id_project) REFERENCES public.projects(id_project) NOT VALID;


--
-- Name: projects fk_id_techno_projects; Type: FK CONSTRAINT; Schema: public; Owner: vlad
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT fk_id_techno_projects FOREIGN KEY (id_techno) REFERENCES public.technologies(id_techno);


--
-- PostgreSQL database dump complete
--

